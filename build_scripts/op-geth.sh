#!/bin/bash

# Check for the presence of the --only-setup flag.
# This is used in CI to only setup the client directory for other build methods (e.g. docker).
ONLY_SETUP=0
for arg in "$@"
do
    if [ "$arg" == "--only-setup" ]; then
        ONLY_SETUP=1
        break
    fi
done

client_path=$(pwd)/op-geth
src_tracer_path=$(pwd)/tracers/bundler_collector.go.template
dest_tracer_path=${client_path}/eth/tracers/native/bundler_collector.go

echo "Copy tracers to relevant client directory..."
cp $src_tracer_path $dest_tracer_path

if [ $ONLY_SETUP -eq 0 ]; then
    echo "No binary builds for op-geth implemented..."
    echo "Clean up client directory..."
    cd $client_path
    git reset --hard
    git clean -df
else
    echo 'To build, run: "docker build ./op-geth"'
    echo 'To reset client directory, run: "./build_scripts/op-geth.sh"'
fi
