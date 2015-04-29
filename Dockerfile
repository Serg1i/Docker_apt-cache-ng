# Container with apt cacher:
# original version here: https://docs.docker.com/examples/apt-cacher-ng/
# To Build: docker build -t apt-cacher .
# To Run: docker run -d -p 3142:3142 --name apt-cacher-run apt-cacher

# How to configure clients:
# Add an apt Proxy setting echo 'Acquire::http { Proxy "http://dockerhost:3142"; };' >> /etc/apt/conf.d/01proxy - in this case apt will only work if proxy is available.
# Set an environment variable: http_proxy=http://dockerhost:3142/ - bad way as it'll drop all filetypes that aren't specified in apt_cacher options
# Change your sources.list entries to start with http://dockerhost:3142/  - Not tested

FROM        ubuntu
MAINTAINER  Serg1i

VOLUME      ["/var/cache/apt-cacher-ng"]
RUN     apt-get update && apt-get install -y apt-cacher-ng

EXPOSE      3142
CMD     chmod 777 /var/cache/apt-cacher-ng && /etc/init.d/apt-cacher-ng start && tail -f /var/log/apt-cacher-ng/*
