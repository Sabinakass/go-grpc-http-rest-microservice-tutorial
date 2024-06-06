#!/bin/bash

# Check if protoc is installed
if ! command -v protoc &> /dev/null; then
  echo "protoc could not be found. Please install protoc."
  exit 1
fi

# Ensure the protoc-gen-go plugin is installed
if ! command -v protoc-gen-go &> /dev/null; then
  echo "protoc-gen-go could not be found. Please install the protoc-gen-go plugin."
  exit 1
fi

# Ensure the protoc-gen-go-grpc plugin is installed
if ! command -v protoc-gen-go-grpc &> /dev/null; then
  echo "protoc-gen-go-grpc could not be found. Please install the protoc-gen-go-grpc plugin."
  exit 1
fi

# Define the proto directory and output directory
PROTO_DIR=api/proto/v1
OUT_DIR=pkg/model/v1

# Create the output directory if it does not exist
mkdir -p $OUT_DIR

# Generate the Go code from the proto files
for proto_file in $PROTO_DIR/*.proto; do
  protoc --go_out=$OUT_DIR --go_opt=paths=source_relative \
         --go-grpc_out=$OUT_DIR --go-grpc_opt=paths=source_relative $proto_file
done

echo "Generation complete. Check the $OUT_DIR directory for generated files."
