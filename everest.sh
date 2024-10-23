#!/bin/bash

# Remove the local manifests directory if it exists (cleanup before repo initialization)
rm -rf .repo/local_manifests/

# Initialize ROM manifest
repo init -u https://github.com/ProjectEverest/manifest -b 14 --git-lfs

# Sync the rpo with force to ensure a clean sync
/opt/crave/resync.sh

# cloning device tree
git clone https://github.com/everestos-mojito/device_xiaomi_mojito.git --depth 1 -b mojito-universe device/xiaomi/mojito
git clone https://github.com/matrix-mojito/android_device_xiaomi_sm6150-common.git --depth 1 -b mojito-universe device/xiaomi/sm6150-common

# cloning kernel tree
git clone https://github.com/bliss-mojito/kernel_xiaomi_mojito.git --depth 1 -b inline-rom kernel/xiaomi/mojito

# cloning vendor tree
git clone https://gitlab.com/bliss-mojito/android_vendor_xiaomi_mojito.git --depth 1 -b 14 vendor/xiaomi/mojito
git clone https://gitlab.com/bliss-mojito/android_vendor_xiaomi_sm6150-common.git --depth 1 -b 14 vendor/xiaomi/sm6150-common

# cloning hardware tree
git clone https://github.com/bliss-mojito/android_hardware_xiaomi.git --depth 1 -b mojito hardware/xiaomi

# Set up the build environment
. build/envsetup.sh

# Choose the target device
lunch lineage_mojito-user

# Build the ROM (use mka bacon for a full build)
mka everest -j$(nproc --all)
