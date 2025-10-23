#!/bin/bash

set -ouex pipefail

### Install packages

# Core build dependencies for building from source
dnf5 install -y \
	git \
	meson \
	ninja-build \
	pkg-config \
	gcc \
	g++ \
	zig
