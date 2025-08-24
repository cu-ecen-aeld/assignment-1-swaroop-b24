#Author : Swaroop B

#Description: 
#writer.sh is provided to parse the arguments to write a string to the testfile.txt in /tmp/aesd/assignment1


#!/bin/bash

# Check if exactly 2 arguments are provided
if [ $# -ne 2 ]; then
    echo "Error: Two arguments required."
    echo "Usage: $0 <writefile> <writestr>"
    exit 1
fi

writefile=$1
writestr=$2

# Ensure the directory exists
mkdir -p "$(dirname "$writefile")"

# Try writing string to file
echo "$writestr" > "$writefile"

# Check success
if [ $? -ne 0 ]; then
    echo "Error: Could not create or write to file '$writefile'."
    exit 1
fi

exit 0
