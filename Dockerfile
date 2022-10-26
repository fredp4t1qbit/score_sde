FROM nvidia/cuda:11.8.0-devel-ubuntu20.04

ARG DEBIAN_FRONTEND=noninteractive
RUN apt update && apt -y upgrade && apt install software-properties-common -y && \
	add-apt-repository ppa:deadsnakes/ppa -y && apt update && apt install python3.8 -y && \
	apt install -y python-is-python3 && apt install -y python3-pip
COPY . .
RUN pip install -r requirements.txt
RUN mkdir tmp
# CMD ["python]