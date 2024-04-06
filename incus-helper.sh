#!/usr/bin/env bash

set -u
set -e

arg_check() {
    if [ -z "$1" ]; then
        echo "Error: Container name parameter is required."
        return 1
    fi
}

check_jq_installed() {
    if ! command -v jq &>/dev/null; then
        echo "Error: 'jq' command not found. Please install 'jq' before using this function."
        return 1
    fi
}

get_incus_container() {
    if ! arg_check; then
        return 1
    fi

    check_jq_installed || return 1
    incus ls --format=json | jq --raw-output --arg container "$1" 'map(select(.name == $container)) | .[].name'
}

delete_incus_container() {
    if ! arg_check; then
        return 1
    fi

    get_incus_container "$1" | xargs --no-run-if-empty -I {} incus delete --force {}
}
