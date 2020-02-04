#!/bin/bash

if [ -z ${IOT_DEVICE_CONNSTR} ]; then 
    echo "Cannot run IoT Edge container: IOT_DEVICE_CONNSTR is not set"
    echo "Eg:"
    echo "export IOT_DEVICE_CONNSTR='HostName=iothub0730.azure-devices.net;DeviceId=myEdgeDevice;SharedAccessKey=zfD73oX3agHTlT0rOvjPnYTkxRPw/k3U0exEGBDWQ5A='"
    exit
fi

if [ -z ${NetworkId} ]; then 
    echo "NetworkId environment variable not set, using default of 'azure-iot-edge'"
    echo "If you wish to use a custom docker network for this deployment use:"
    echo "export NetworkId=other-network-id"
    NetworkId=azure-iot-edge
fi

echo "Using Docker network id of: $NetworkId"

docker run \
    -i \
    -t \
    --rm \
    -v //var//run//docker.sock://var//run//docker.sock \
    -p 15580:15580 \
    -p 15581:15581 \
    --network bridge \
    --name iotedgec \
    -e IOT_DEVICE_CONNSTR="$IOT_DEVICE_CONNSTR" \
    -e NetworkId="$NetworkId" \
    iot-edge-c
