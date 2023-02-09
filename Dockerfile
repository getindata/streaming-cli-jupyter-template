FROM gcr.io/getindata-images-public/pyflink-base:0.0.2

USER root

RUN pip install pipenv

USER flink

COPY --chown=flink:flink ./Pipfile ./Pipfile.lock /flink/opt/

RUN set -ex && \
    cd /flink/opt && \
    pipenv requirements > requirements.txt && \
    python -m pip install -r requirements.txt

COPY ./src /app/src
COPY .streaming_config.yml ./jars/* /app/lib/
