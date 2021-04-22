#!/bin/bash
# Launches Rust Dedicated Server
# Usage:
#   ./rust_ds.sh

set -e

# generate a random password from /dev/urandom
function rand_password() {
  tr -dc -- '-.~,<>[]{}@%()_+=0-9a-zA-Z' < /dev/urandom | head -c16;echo
}

RUST_SERVER_DIR=/home/rustds/server

if [ ! -f rcon_pass ]; then
  touch /tmp/rcon_pass
  chmod 600 /tmp/rcon_pass
  rand_password > /tmp/rcon_pass
fi

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${RUST_SERVER_DIR}/RustDedicated_Data/Plugins/x86_64

cd "${RUST_SERVER_DIR}"

"${RUST_SERVER_DIR}"/RustDedicated \
    -batchmode \
    +server.secure 0 +server.encryption 0 +server.eac 0 \
    +rcon.web 1 +rcon.port 28016 \
    +rcon.password "$(< /tmp/rcon_pass)" 2>&1

#    -logfile "${SCRIPT_DIR}"/output_log.txt \
