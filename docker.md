# Mr Yang's `score_sde`, dockerized

## Prereqs

### Install GPU drivers

1. Ensure packages are up to date & install

	`sudo apt update && sudo apt -y upgrade && sudo apt-get -y install ubuntu-drivers-common && sudo ubuntu-drivers autoinstall && sudo apt install nvidia-driver-515`

	Depending on the card, you'll want to install the most up-to-date driver

		- `t4`: 515

		- `v100`: 520

	To check:

		- `ubuntu-drivers devices`

		- `nvidia-smi`

2. Reboot and wait for instance to come back up (~ minute)

	`sudo reboot`

3. Verify installation

	`nvidia-smi`


### Set up Docker environment

1. Install docker

	- ubuntu 22.04:
	`curl https://get.docker.com | sh \
	&& sudo systemctl --now enable docker`

	- ubuntu 20.04: follow guide below
	`https://docs.docker.com/engine/install/ubuntu/`

2. Install the Nvidia Container Toolkit and restart docker

	`distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
   && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
   && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list && sudo apt-get update && sudo apt-get install -y nvidia-docker2`

  	`sudo systemctl restart docker && sudo chmod 666 /var/run/docker.sock`


## Run container

0. Log in to quay to get access to `quay.io/1qbit/diffusion-models`.

1. Run and exec into container
```
docker run --gpus all --ipc=host -it quay.io/1qbit/diffusion-models:score_sde_docker
```

2. Verify GPU availabiility
```
python3 -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"
```

3. Run `cifar10_ddpm.py`
```
XLA_FLAGS=--xla_gpu_cuda_data_dir=/usr/local/cuda python main.py --mode train --config configs/ve/cifar10_ddpm.py --workdir tmp
```


## Build

TODO