buildDir = build
CC = clang++
CFLAGS += -Os -Isrc/lib/libNeoAppleArchive -Isrc/lib/build/lzfse/include -I/usr/include/FLTK

LZFSE_DIR = src/lib/libNeoAppleArchive/compression/lzfse
BUILD_LZFSE_DIR = ../../../build/lzfse

NEOAPPLEARCHIVE_DIR = src/lib

output: $(buildDir)
	@ # Build libNeoAppleArchive submodule
	@echo "building libNeoAppleArchive..."
	$(MAKE) -C $(NEOAPPLEARCHIVE_DIR)
	@mv src/lib/build/usr/lib/libNeoAppleArchive.a build/usr/lib/libNeoAppleArchive.a

	@ # Build neoaa CLI tool
	@echo "building neoaa-gui..."
	@$(CC) src/gui/*.c -Lbuild/usr/lib -Lsrc/lib/build/lzfse/lib -Lsrc/lib/build/libzbitmap/lib -o build/neoaa-gui -lNeoAppleArchive -llzfse -lzbitmap -lz $(CFLAGS) -lfltk -lfltk_images -lfltk_forms

$(buildDir):
	@echo "Creating Build Directory"
	mkdir -p build/usr/lib
	mkdir -p build/usr/bin
	mkdir -p build/obj