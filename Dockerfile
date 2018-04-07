FROM ubuntu:18.04
RUN apt-get update \
  && apt-get install -y wget libz-dev software-properties-common git build-essential cmake\
  && cd /usr/src \
  && git clone http://llvm.org/git/llvm.git \
  && git clone http://llvm.org/git/clang.git llvm/tools/clang \
  && git clone http://llvm.org/git/compiler-rt llvm/projects/compiler-rt \
  && mkdir llvm_build && cd llvm_build/ \
  && cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX=/usr/local -DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD=WebAssembly "/usr/src/llvm" \
  && make -j 8 && make install \
  && git clone https://github.com/WebAssembly/binaryen.git && cd binaryen && cmake . && make && make install
