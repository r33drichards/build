#!/bin/bash

# Generate a random string for the old origin's name using uuidgen
OLD_ORIGIN_NAME=foo

# Rename origin to the generated random string
git remote rename origin $OLD_ORIGIN_NAME

# Set new origin using the SSH URL
git remote add origin git@github.com:r33drichards/build.git

# Push to the new origin
git push origin --all
git push origin --tags
