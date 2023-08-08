#!/bin/bash

# Create setup for a new page
# input: directory path
# output:
#   - create directory (and parents) if it (they) doesn't exist
#   - create styles directory
#   - create empty styles.css file
#   - copy normalize.css to styles directory
#   - create index.html file as copy of boilerplate.html with {{TITLE}} replaced with directory name
#   - create README.md file with basic markdown boilerplate

# Get directory path from args
DIR=$1

# Create directory if it doesn't exist
if [ ! -d "$DIR" ]; then
    # recursively create directory
    dir_path="."
    for dir in $(echo $DIR | tr "/" "\n")
    do
        dir_path="$dir_path/$dir"
        if [ ! -d "$dir_path" ]; then
            mkdir "$dir_path"
        fi
    done
fi

# Create styles directory
if [ ! -d "$DIR/styles" ]; then
    mkdir "$DIR/styles"
fi

# Create styles.css file
if [ ! -f "$DIR/styles/style.css" ]; then
    touch "$DIR/styles/style.css"
fi

# Copy normalize.css to styles directory
if [ ! -f "$DIR/styles/normalize.css" ]; then
    cp normalize.css "$DIR/styles/normalize.css"
fi

document_name=$(echo $DIR | tr "/" "\n" | tail -n 1)

# Create index.html file
if [ ! -f "$DIR/index.html" ]; then
    cp boilerplate.html "$DIR/index.html"
    # Replace {{TITLE}} with directory name
    sed -i '' -e "s/{{TITLE}}/$document_name/g" "$DIR/index.html"
fi

# Create README.md file
if [ ! -f "$DIR/README.md" ]; then
    touch "$DIR/README.md"
    echo "# $document_name" >> "$DIR/README.md"
    # Add created date
    echo "Created: $(date)" >> "$DIR/README.md"
fi
