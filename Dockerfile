FROM ubuntu:latest

MAINTAINER Chiachun Chiu "chiachun.chiu@gmail.com"

ENV TZ=Asia/Shanghai

# This version of r-base will be downloaded from USTC
RUN useradd -m docker \
    && addgroup docker staff \
    && sed -i 's/^deb/# deb/' /etc/apt/sources.list \
    && echo 'deb http://mirrors.ustc.edu.cn/ubuntu/ bionic main restricted universe multiverse' >> /etc/apt/sources.list\
    && echo 'deb http://mirrors.ustc.edu.cn/ubuntu/ bionic-backports main restricted universe multiverse' >>/etc/apt/sources.list \
	&& apt update \
	&& ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
	&& echo $TZ > /etc/timezone \
	&& apt install -y --no-install-recommends \
	    apt-utils \
	    ed \
		less \
		vim-tiny \
		wget \
		ca-certificates \
		libcurl4-openssl-dev \
		libxml2-dev \
		r-base \
		r-base-dev \
		r-cran-stringr \
		r-cran-rcurl \
		r-cran-xml \
	&& echo 'options(repos = c(CRAN = "https://mirrors.ustc.edu.cn/CRAN/"))' >> /etc/R/Rprofile.site \
	&& rm -rf /var/lib/apt/lists/*

CMD ["R --vanilla"]
