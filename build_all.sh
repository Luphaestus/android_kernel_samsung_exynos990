#!/bin/bash

BUILD_FLAGS="$@"

rm -rf build/out/all/

for device in $(find . -iname "*vulcan_*" | sed -E 's/.*vulcan_([^_]*)(_defconfig|defconfig).*/\1/'); do
    echo "Building for device: $device"
    ./build.sh -m "$device" $BUILD_FLAGS
    
    if [ $? -ne 0 ]; then
        echo "Error: Build failed for $device"
        exit 1
    fi
done

echo "All builds completed successfully"
echo "Sym linking"
mkdir -p build/out/all/zip && \
find build/out -iname "*zip" -type f -exec ln -sf $(realpath --relative-to=build/out/all/zip {}) build/out/all/zip/ \;

