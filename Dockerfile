FROM ubuntu:18.04
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV ROS_DISTRO dashing
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -q -y \
        curl \
        gnupg2 \
        lsb-release \
    && rm -rf /var/lib/apt/lists/*
RUN curl http://repo.ros2.org/repos.key | apt-key add - && \
    echo "deb [arch=amd64,arm64] http://packages.ros.org/ros2/ubuntu bionic main" > \
        /etc/apt/sources.list.d/ros2-latest.list && \
    apt-get update && \
    apt-get install -y ros-$ROS_DISTRO-ros-base \
    && rm -rf /var/lib/apt/lists/*
RUN apt-get update && \
    apt-get install -y python3-vcstool \
                       python3-colcon-common-extensions \
                       wget \
                       git \
    && rm -rf /var/lib/apt/lists/*
COPY ./ros_entrypoint.sh /
ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
