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
        curl -fL --output "$destination_apk" "$source_apk"
    fi
}

get-aurora-components() {
    # AuroraStore via F-Droid (versao 4.8.4 / codigo 76)
    # atualizar o numero da versao manualmente quando sair release nova
    local aurora_store_url="https://f-droid.org/repo/com.aurora.store_76.apk"

    name="AuroraStore"
    mkdir -p "$name"
    download_apk "$aurora_store_url" "$name"
}

cd vendor/aurora
get-aurora-components
cd ../..

set +e
