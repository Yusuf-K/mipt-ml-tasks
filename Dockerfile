FROM python:3.7-slim

RUN pip install --no-cache --upgrade pip && \
    pip install --no-cache notebook

ARG NB_USER
ARG NB_UID

ENV USER ${NB_USER}
ENV HOME /home/${NB_USER}

RUN adduser --disabled-password \
    --gecos "Default user" \
    --uid ${NB_UID} \
    ${NB_USER}

WORKDIR ${HOME}
ADD task1 task1

RUN python3 -m venv venv && . venv/bin/activate
ADD requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

