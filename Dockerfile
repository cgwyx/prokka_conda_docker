#################################################################
# Dockerfile
#
# Version:          1.0
# Software:         panX
# Software Version: 1.0
# Description:      Microbial pan-genome analysis and exploration toolkit
# Code:                  https://github.com/neherlab/pan-genome-analysis
# Base Image:       debian:stretch
# Build Cmd:        sudo docker build -t debian_panx:panx_docker_v1.0 .
# Pull Cmd:           docker pull panx:panx_docker_v1.0
# Run Cmd:          sudo docker run -it --rm -v /home:/home -p 8000:8000 --name=panx debian_panx:panx_docker_v1.0
# File Author / Maintainer: cheng gong <512543469@qq.com>
#################################################################

# Set the base image to debian
FROM continuumio/miniconda

MAINTAINER cheng gong <512543469@qq.com>

##########pan-genome-analysis############
ADD ./panx-docker-add-new-pages-repo.sh / \
         ./panx-docker-link-to-server.py  /

RUN conda update --all -y &&\
         conda config --add channels r &&\
         conda config --add channels bioconda &&\
         conda config --add channels conda-forge &&\
         #conda config --add channels defaults &&\
         #conda config --set show_channel_urls yes
         git clone https://github.com/neherlab/pan-genome-analysis.git &&\
         cd pan-genome-analysis &&\
         git submodule update --init &&\
         conda install  -y python=2.7.13 biopython=1.66 numpy=1.10.4 scipy=0.16.1 pandas=0.16.2 ete2=2.3.10  diamond=0.8.36  fasttree=2.1.9 mafft=7.305 mcl=14.137 raxml=8.2.9

##########pan-genome-visualization############
RUN conda install nodejs=4.4.1 &&\
         git clone https://github.com/neherlab/pan-genome-visualization.git &&\
         cd pan-genome-visualization && \
         git submodule update --init && \
         npm install

#Expose port 8000 (webserver)
EXPOSE :8000

WORKDIR /pan-genome-analysis

CMD ["/bin/bash"]


