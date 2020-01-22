FROM centos:7

# Set the locale(en_US.UTF-8)
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV GIT_VERSION 2.21.1

RUN yum install -y unzip \
                   which \
                   make \
                   wget \
                   curl-devel \
                   expat-devel \
                   gettext-devel \
                   openssl-devel \
                   zlib-devel \
                   gcc \
                   perl-ExtUtils-MakeMaker && \
    cd /usr/src && \
    wget https://www.kernel.org/pub/software/scm/git/git-${GIT_VERSION}.tar.gz && \
    tar xzf git-${GIT_VERSION}.tar.gz && \
    cd git-${GIT_VERSION} && \
    make prefix=/usr/local/git all && \
    make prefix=/usr/local/git install && \
    cd /usr/src && \
    rm -rf git-${GIT_VERSION}.tar.gz && \
    rm -rf git-${GIT_VERSION}

FROM centos:7
WORKDIR /root/
COPY --from=0 /usr/local/git/bin/git /usr/local/bin/git
