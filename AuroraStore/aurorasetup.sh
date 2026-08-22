#!/bin/bash

set -e

echo "vendor/aurora/aurorasetup.sh called"

download_apk() {
    local source_apk=$1
    local component_name=$2
    local destination_apk

    destination_apk="$component_name"/"$component_name".apk
    if [ -f "$destination_apk" ]; then
        echo "$destination_apk exists: not downloading"
    else
        echo "downloading $source_apk to $destination_apk"
        curl -fL \
            -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36" \
            --output "$destination_apk" "$source_apk"
    fi
}

get-aurora-components() {
    local aurora_store_url="https://auroraoss.com/downloads/AuroraStore/Latest/latest.apk"
    # AuroraServices nao publica releases formais no GitLab (sem assets na API);
    # este eh o unico link disponivel, fixo na v1.1.1 (ultimo lancamento, 2021)
    local aurora_services_url="https://gitlab.com/-/project/8363046/uploads/c22e95975571e9db143567690777a56e/AuroraServices_v1.1.1.apk"

    name="AuroraStore"
    mkdir -p "$name"
    download_apk "$aurora_store_url" "$name"

    name="AuroraServices"
    mkdir -p "$name"
    download_apk "$aurora_services_url" "$name"
}

cd vendor/aurora
get-aurora-components
cd ../..

set +e
