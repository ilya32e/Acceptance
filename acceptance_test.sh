#!/bin/bash

# Set the HOME environment variable
export HOME=/var/lib/jenkins

# Use command substitution to capture the result of curl
result=$(curl -s localhost:8765/sum?a=20\&b=80)

# Convert the result to an integer for numeric comparison
result_int=$((result))

# Check if the result is equal to 100
if [ "$result_int" -eq 100 ]; then
    echo "Condition is true"
else
    echo "Condition is false"
fi
