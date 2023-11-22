#!/bin/bash

# Function to display the banner
display_banner() {
    echo "----------------------------------"
    echo " IP Address and Range Grepper"
    echo "----------------------------------"
}

# Function to display the menu and get user choice
get_user_choice() {
    echo "Select the type of IP data to extract:"
    echo "  1) IP Addresses"
    echo "  2) IP Ranges with CIDR"
    read -p "Enter choice (1 or 2): " choice
}

# Function for loading bar
loading_bar() {
    echo -n "Processing: "
    for i in {1..5}; do
        echo -n "."
        sleep 1
    done
    echo " Done!"
}

# Check if file name is provided
if [ $# -eq 0 ]; then
    echo "No file specified."
    echo "Usage: $0 [file_path]"
    exit 1
fi

input_file=$1 # Get the input file from command line argument

# Validate if the file exists
if [ ! -f "$input_file" ]; then
    echo "File not found! Please check the file path."
    exit 1
fi

display_banner

# Get user choice
get_user_choice

# Output file name
output_file="output.txt" # Output file name

# Regex patterns for IP Address and IP Range
ip_regex='([0-9]{1,3}\.){3}[0-9]{1,3}'
ip_range_regex='([0-9]{1,3}\.){3}[0-9]{1,3}/[0-9]{1,2}'

# Extraction based on choice
case $choice in
    1) 
        grep -oE $ip_regex $input_file > $output_file
        ;;
    2) 
        grep -oE $ip_range_regex $input_file > $output_file
        ;;
    *)
        echo "Invalid choice. Exiting."
        exit 1
        ;;
esac

# Display loading bar
loading_bar

echo "Extraction complete. Check $output_file for results."
