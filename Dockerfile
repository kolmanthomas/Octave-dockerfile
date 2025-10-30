FROM ubuntu:latest

RUN apt-get update && apt-get install -y git mercurial gcc g++ autoconf automake bison dvipng epstool fig2dev flex gfortran gnuplot-x11 gperf gzip icoutils libarpack2-dev libopenblas-dev libcurl4-gnutls-dev libfftw3-dev libfltk1.3-dev libfontconfig1-dev libfreetype-dev libgl1-mesa-dev libgl2ps-dev libglpk-dev libgraphicsmagick++1-dev libhdf5-dev liblapack-dev libosmesa6-dev libpcre2-dev libqhull-dev libqscintilla2-qt5-dev libqrupdate-dev libreadline-dev librsvg2-bin libsndfile1-dev libsuitesparse-dev libsundials-dev libtool libxft-dev make openjdk-11-jdk perl portaudio19-dev pstoedit qtbase5-dev qttools5-dev qttools5-dev-tools rapidjson-dev rsync tar texinfo texlive-latex-extra zlib1g-dev

RUN hg clone https://hg.octave.org/octave

COPY bug54028_patch_v1 /octave/
COPY inferiorclasses_patch2.diff /octave/
COPY stack-trace-diffs.txt /octave/

WORKDIR /octave
RUN ./bootstrap && mkdir .build

RUN patch -p1 < bug54028_patch_v1 && \
    patch -p1 < inferiorclasses_patch2.diff && \
    patch -p1 < stack-trace-diffs.txt

WORKDIR /octave/.build
RUN .././configure \
    --prefix=/usr/local CFLAGS="-O3" CXXFLAGS="-std=gnu++17 -O3" FFLAGS="-O3" 

RUN make -j$(nproc) && \
    make install 

