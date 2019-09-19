FROM continuumio/miniconda3

RUN export QIIME2_RELEASE=2019.7

ENV PATH /opt/conda/envs/qiime2-${QIIME2_RELEASE}/bin:$PATH
ENV LC_ALL C.UTF-8
ENV LANG C.UTF-8
ENV MPLBACKEND agg
ENV HOME /home/qiime2
ENV XDG_CONFIG_HOME /home/qiime2

RUN mkdir /home/qiime2
WORKDIR /home/qiime2

RUN conda update -q -y conda
RUN conda install -q -y wget
RUN wget https://data.qiime2.org/distro/core/qiime2-${QIIME2_RELEASE}-py36-linux-conda.yml
RUN conda env create -n qiime2-${QIIME2_RELEASE} --file qiime2-${QIIME2_RELEASE}-py36-linux-conda.yml
RUN rm qiime2-${QIIME2_RELEASE}-py36-linux-conda.yml
RUN /bin/bash -c "source activate qiime2-${QIIME2_RELEASE}"
RUN qiime dev refresh-cache
RUN echo "source activate qiime2-${QIIME2_RELEASE}" >> $HOME/.bashrc
RUN echo "source tab-qiime" >> $HOME/.bashrc
#update the permissions so any container user can access all the qiime2 functions
RUN chmod -R 777 /home/qiime2
# TODO: update this to point at the new homedir defined above. Keeping this
# for now because this will require an update to the user docs.
VOLUME ["/data"]
WORKDIR /data
