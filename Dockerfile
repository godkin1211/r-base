FROM alpine:edge

MAINTAINER chiachun.chiu <chiachun.chiu@gmail.com>

RUN apk update && \
    apk add --no-cache bash curl curl-dev file\
	                   libxml2-dev gcc g++ git coreutils \
					   ncurses linux-headers musl-dev && \
    apk add --no-cache R R-dev R-doc R-mathlib && \
	R -q -e "install.packages('Rcpp', repos = 'https://cloud.r-project.org/')" && \
	wget https://cran.r-project.org/src/contrib/fs_1.2.6.tar.gz && \
	tar zxvf fs_1.2.6.tar.gz && \
	sed -i '5i #include <sys/stat.h>' fs/src/RcppExports.cpp && \
	R CMD INSTALL fs && \
	R -q -e 'install.packages("devtools", repos = "https://cloud.r-project.org/")' && \
	rm -rf fs *.tar.gz /tmp/*

CMD ["R", "--vanilla"]
