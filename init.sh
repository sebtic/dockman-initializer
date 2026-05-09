#!/bin/bash

set -e

export BASE_DIR="$PWD"

git config --global init.defaultBranch main

if [ ! -d .git ]; then
    git init .
fi

cat <<EOF > .gitignore
# do not version override directories since it contains secrets and specific configuration
override

# generated files
generated

# data
data
EOF

git add .gitignore

cat <<'EOF' > dockman
#!/bin/bash

set -e

export BASE_DIR="$(dirname "$(readlink -f "$0")")"

source $BASE_DIR/bin/dockman.sh
EOF
chmod +x dockman

git add dockman

if [ ! -d bin ]; then 
    git submodule add git@github.com:sebtic/dockman-bin.git bin
fi

if [ ! -d global ]; then
    git submodule add git@github.com:sebtic/dockman-global.git global
fi

mkdir -p stacks override

touch stacks/.keep

git add stacks/.keep



