#!/usr/bin/env bash

# The Set Builtin
# https://www.gnu.org/software/bash/manual/html_node/The-Set-Builtin.html
[ "$DEBUG" == 'true' ] && set -x

cat << EOF

Serve the website locally, escpecially useful for review or test.

Using \`--incremental\` to do a partial build in order to reduce regeneration time.

Unpublished posts have \`published: false\` tag.
Using \`--unpublished\` parameter to published them locally.

The filename of posts have publishing date.
Using \`--future\` parameter to publish every post, regardless of date.

EOF

docker run \
  --interactive \
  --rm \
  --tty \
  --user $(id -u):$(id -g) \
  --volume `pwd`:/website:rw \
  --workdir /website \
  --publish 4000:4000 \
  praqma/jekyll:latest \
  bash -c " \
    jekyll --version && \
    ruby --version && \
    jekyll serve --watch --host=0.0.0.0 --incremental --unpublished --future
    "
