#!/bin/bash

# THIS IS A BAD IDEA DO NOT DO THIS
# I EXCLUSIVELY USED THIS FOR THESE SMALL LEARNING EXAMPLES
# THIS WILL KILL TAMARIN ON CHANGES WITHOUT YOUR CONSENT

# Path to the binary
TAMARIN_BINARY="tamarin-prover interactive . --quit-on-warning"

start_tamarin() {
    echo "Starting tamarin..."
    $TAMARIN_BINARY &
    TAMARIN_PID=$!
    echo "Tamarin started with PID: $TAMARIN_PID"
}

kill_tamarin() {
    if [ -n "$TAMARIN_PID" ]; then
        echo "Killing tamarin with PID: $TAMARIN_PID"
        kill $TAMARIN_PID
    fi
}

start_tamarin

inotifywait -m -e modify --format '%w%f' . | while read file; do
    echo "Detected change in $file. Restarting tamarin..."
    kill_tamarin
    start_tamarin
done
