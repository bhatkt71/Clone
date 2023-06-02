#!/bin/bash

# Function to clone a website recursively
clone_website() {
    # Check if the URL starts with http or https
    if [[ $1 == http* ]]; then
        # Extract the domain name from the URL
        domain=$(echo "$1" | awk -F/ '{print $3}')
        
        # Create a directory for the domain
        mkdir -p "$domain"
        
        # Download the website recursively using wget
        wget -r -np -k -P "$domain" "$1"

        # Replace the file paths in the cloned HTML files
        find "$domain" -type f -name "*.html" -exec sed -i 's|href="/|href="./|g' {} +
        find "$domain" -type f -name "*.html" -exec sed -i 's|src="/|src="./|g' {} +
        find "$domain" -type f -name "*.html" -exec sed -i 's|url(/|url(./|g' {} +
    else
        echo "Invalid URL. Please provide a URL starting with http or https."
    fi
}

# Read the website URL from user input
echo -n "Enter the website URL: "
read url

# Call the clone_website function with the URL
clone_website "$url"
