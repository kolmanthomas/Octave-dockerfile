# Building the dockerfile

```
docker build -t octave:classdef
docker run -it octave:classdef
```

List all containers

```
docker container ls --all
```

Upload the container to GHCR

```
export CR_PAT=YOUR_TOKEN
echo $CR_PAT | docker login --username kolmanthomas --password-stdin
docker tag octave:classdef ghcr.io/kolmanthomas/octave:classdef
docker push ghcr.io/kolmanthomas/octave:classdef
```

To pull the image
```
docker pull ghcr.io/kolmanthomas/octave:classdef
```

To copy Chebfun into the container
```
docker cp ~/chebfun <CONTAINER-ID>:/
```
