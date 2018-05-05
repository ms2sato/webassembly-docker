FROM ms2sato/llvm

ARG WABT_BRANCH=master
ARG BINARYEN_BRANCH=master

RUN  apt-get update -y  && \
     apt-get install -y  git \
                        cmake \
                        make \
                        gcc \
                        g++ \
                        ninja-build \
                        g++-multilib \
                        python && \
    ls -lah /usr/bin/ld && \
    rm /usr/bin/ld && \
    ln -s /usr/bin/ld.gold /usr/bin/ld && \
    ls -lah /usr/bin/ld && \
    mkdir -p /build && cd /build && \
    cd /build && \
    git clone --depth=1 --branch $BINARYEN_BRANCH --single-branch https://github.com/WebAssembly/binaryen && \
    cd /build/binaryen && \
    cmake . && \
    make && \
    make install && \
    cd /build && \
    git clone --recursive --depth=1 --branch $WABT_BRANCH --single-branch https://github.com/WebAssembly/wabt.git && \ 
    mkdir -p /build/wabt/build && cd /build/wabt/build && \
    cmake -G Ninja -DBUILD_TESTS=OFF .. && \
    ninja && \
    ninja install && \
apt-get remove -y   git \
                    cmake \
                    make \
                    ninja-build \
                    python  && \
apt-get autoremove -y && \
                    rm -rf /var/lib/apt/ && \
                    rm -rf /build

WORKDIR /src

CMD ["bash"]
