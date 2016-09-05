#!/bin/bash

if [[ $# -gt 1 ]]; then
    echo "Invalid Args"
fi

#set -o xtrace

# Keep track of the root directory
TOP_DIR=$(cd $(dirname "$0") && pwd)
SCRIPTS_DIR=${TOP_DIR}/scripts
CONFIG_DIR=${TOP_DIR}/configs

PASSWORD=rajalokan

function common {
    source ${SCRIPTS_DIR}/common

    update_and_upgrade
    install_cloud_keyring
    install_mysql
    install_rabbitmq
    install_clients
}

function keystone {
    echo "Setting up MySQL + RabbitMQ + Keystone"

    # Setup common services
    common

    source ${SCRIPTS_DIR}/keystone
    setup_keystone
}

function guts {
    echo "Setting up MySQL + RabbitMQ + Keystone + Guts"
    # keystone

    source ${SCRIPTS_DIR}/guts
    setup_guts ${PASSWORD}
}

function horizon {
    echo "Settings up MySQL + RabbitMQ + Keystone + Horizon"

    source ${SCRIPTS_DIR}/horizon
    setup_horizon ${PASSWORD}
}

function guts-dashboard {
    echo "Settings up MySQL + RabbitMQ + Keystone + Horizon + Guts + Guts-dashboard"

    guts
    horizon

    source ${SCRIPTS_DIR}/guts-dashboard
    setup_guts_dashboard ${PASSWORD}
}

case ${1} in
"keystone")
    keystone
    ;;
"horizon")
    horizon
    ;;
"guts")
    guts
    ;;
"guts-dashboard")
    guts-dashboard
    ;;
*)
    echo "Nothing"
    ;;
esac

exit 0
