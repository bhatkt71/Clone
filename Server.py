import http.server
import socketserver

class CustomHandler(http.server.SimpleHTTPRequestHandler):
    extensions_map = {
        '': 'text/html',
        '.html': 'text/html',
        '.css': 'text/css',
        '.js': 'application/javascript',
        '.json': 'application/json',
        '.png': 'image/png',
        '.jpg': 'image/jpeg',
        '.gif': 'image/gif',
    }

    def guess_type(self, path):
        base, ext = http.server.os.path.splitext(path)
        if ext in self.extensions_map:
            return self.extensions_map[ext]
        return http.server.SimpleHTTPRequestHandler.guess_type(self, path)

# Set up the server
handler = CustomHandler
port = 8080
address = "127.0.0.1"
httpd = socketserver.TCPServer((address, port), handler)

# Start the server
print(f"Server running at http://{address}:{port}/")
httpd.serve_forever()
