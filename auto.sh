#!/bin/bash

declare -a used
used+="auto.sh"

while :
do
    for file in $(ls | awk '{ print $NF }')
    do
        if printf '%s\0' "${used[@]}" | grep -Fxqz "$file"; then
            true
        else
            echo
            echo "------------------------------------------------"
            echo
            echo "files unzipped: ${used[@]}"
            echo 
            echo "unzipping $file"
            echo 
            file_output=$(zip -sf $file)
            password=$(echo $file_output | awk 'BEGIN { FS = " " } { print $3 }' | awk 'BEGIN { FS = "." } { print $1 }')
            echo
            echo "Using password: $password"
            echo
            unzip -P $password $file
            used+=($file)        
        fi
    done
done
