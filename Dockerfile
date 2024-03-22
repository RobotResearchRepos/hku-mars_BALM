FROM osrf/ros:noetic-desktop-full

ARG DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-c"]
 
# Binary package dependencies

RUN apt-get update \
 && apt-get install -y libceres-dev \
 && rm -rf /var/lib/apt/lists/*

# Code repository

RUN  mkdir -p /catkin_ws/src/BALM

COPY . /catkin_ws/src/BALM

RUN . /opt/ros/$ROS_DISTRO/setup.bash \
 && apt-get update \
 && rosdep install -r -y \
     --from-paths /catkin_ws/src \
     --ignore-src \
 && rm -rf /var/lib/apt/lists/*

RUN . /opt/ros/$ROS_DISTRO/setup.bash \
 && cd /catkin_ws \
 && catkin_make -j1
 
