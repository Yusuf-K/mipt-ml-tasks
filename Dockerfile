FROM python:3.7

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
COPY . ${HOME}
USER root
RUN chown -R ${NB_UID} ${HOME}
USER ${NB_USER}

RUN python3 -m venv venv && . venv/bin/activate
ADD requirements.txt requirements.txt
RUN pip install -r requirements.txt --user

CMD ["jupyter", "notebook", "--ip", "0.0.0.0"]
