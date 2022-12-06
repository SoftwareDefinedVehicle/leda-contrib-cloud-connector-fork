#!/bin/sh

#
# Copyright (c) 2022 Contributors to the Eclipse Foundation
#
# See the NOTICE file(s) distributed with this work for additional
# information regarding copyright ownership.
#
# This program and the accompanying materials are made available under the
# terms of the Apache License 2.0 which is available at
# https://www.apache.org/licenses/LICENSE-2.0
#
# SPDX-License-Identifier: Apache-2.0
#

# Check if cloudconnector is already started
[ -n "`pidof cloudconnector`" ] && { echo "Cloud Connector already started, exiting!"; exit 1; }

# Configuration file in json format with flags values, configure with parameter -configFile.
[ -n "${CLOUD_CONNECTOR_CONFIG+x}" ] && ARGUMENTS="$ARGUMENTS -configFile=$CLOUD_CONNECTOR_CONFIG"

# Connection string for the Azure IoT Hub connectivity, configure with parameter -connectionString.
[ -n "${CONNECTION_STRING+x}" ] && ARGUMENTS="$ARGUMENTS -connectionString=$CONNECTION_STRING"

# ID Scope for the Azure DPS authentication, configure with parameter -idScope.
[ -n "${ID_SCOPE+x}" ] && ARGUMENTS="$ARGUMENTS -idScope=$ID_SCOPE"

# The file for the message mappings configuration, configure with parameter -messageMapperConfig (default "message-mapper-config.json").
[ -n "${MESSAGE_MAPPER_CONFIG+x}" ] && ARGUMENTS="$ARGUMENTS -messageMapperConfig=$MESSAGE_MAPPER_CONFIG"

# List of passthrough device topics, configure with parameter -passthroughDeviceTopics.
[ -n "${PASSTHROUGH_DEVICE_TOPICS+x}" ] && ARGUMENTS="$ARGUMENTS -passthroughDeviceTopics=$PASSTHROUGH_DEVICE_TOPICS"

# List of passthrough command names, configure with parameter -passthroughCommandNames.
[ -n "${PASSTHROUGH_COMMAND_NAMES+x}" ] && ARGUMENTS="$ARGUMENTS -passthroughCommandNames=$PASSTHROUGH_COMMAND_NAMES"

# User-specified tenant id, configure with parameter -tenantId (default "defaultTenant").
[ -n "${TENANT_ID+x}" ] && ARGUMENTS="$ARGUMENTS -tenantId=$TENANT_ID"

# Address of the local MQTT broker, configure with parameter -localAddress (default "tcp://localhost:1883").
[ -n "${LOCAL_ADDRESS+x}" ] && ARGUMENTS="$ARGUMENTS -localAddress=$LOCAL_ADDRESS"

# Username for authentication to the local client, configure with parameter -localUsername.
[ -n "${LOCAL_USERNAME+x}" ] && ARGUMENTS="$ARGUMENTS -localUsername=$LOCAL_USERNAME"

# Password for authentication to the local client, configure with parameter -localPassword.
[ -n "${LOCAL_PASSWORD+x}" ] && ARGUMENTS="$ARGUMENTS -localPassword=$LOCAL_PASSWORD"

# Path to Hub certificate, configure with parameter -caCert (default "iothub.crt").
[ -n "${CA_CERT_PATH+x}" ] && ARGUMENTS="$ARGUMENTS -caCert=$CA_CERT_PATH"

# Log file location, configure with parameter -logFile (default "logs/log.txt")
[ -n "${LOG_FILE+x}" ] && ARGUMENTS="$ARGUMENTS -logFile=$LOG_FILE"

# Log level, configure with parameter -logLevel.
# Possible values: ERROR, WARN, INFO, DEBUG, TRACE (default "INFO").
[ -n "${LOG_LEVEL+x}" ] && ARGUMENTS="$ARGUMENTS -logLevel=$LOG_LEVEL"

# Log file size in MB before it gets rotated, configure with parameter -logFileSize (default 2).
[ -n "${LOG_FILE_SIZE+x}" ] && ARGUMENTS="$ARGUMENTS -logFileSize=$LOG_FILE_SIZE"

# Log file max rotations count, configure with parameter -logFileCount (default 5).
[ -n "${LOG_FILE_COUNT+x}" ] && ARGUMENTS="$ARGUMENTS -logFileCount=$LOG_FILE_COUNT"

# Log file rotations max age in days, configure with parameter -logFileMaxAge (default 28).
[ -n "${LOG_FILE_MAX_AGE+x}" ] && ARGUMENTS="$ARGUMENTS -logFileMaxAge=$LOG_FILE_MAX_AGE"

echo $PWD/cloudconnector $ARGUMENTS
nohup $PWD/cloudconnector $ARGUMENTS >/dev/null 2>&1 &
