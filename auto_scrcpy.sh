#!/bin/bash

# Get the list of connected devices from adb
devices=$(adb devices | grep -w "device" | awk '{print $1}')

# Count the number of connected devices
num_devices=$(echo "$devices" | wc -l)

# Check if any devices are connected
if [ $num_devices -eq 0 ]; then
    echo "No devices found. Please connect at least one device."
    exit 1
fi

echo "Found $num_devices device(s)."

# Use xargs to run scrcpy for each device in parallel, outputting to the terminal
echo "$devices" | xargs -n 1 -P $num_devices -I {} bash -c "echo 'Connecting to device with serial: {}'; scrcpy --always-on-top -s {} --window-height=1000"

echo "All devices connected!"
