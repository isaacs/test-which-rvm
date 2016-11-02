#!/usr/bin/env bash

set -e
set -x

which which
which rvm

# set -x on all rvm scripts and bins
for script in ~/.rvm/{scripts,bin}/*; do
  if [ -f $script ]; then
    h=$(head -n 1 $script)
    if [ "$h" == "#!/usr/bin/env bash" ]; then
      cp $script ${script}-bashx-backup
      ( echo "#!$BASH -x"; cat ${script}-bashx-backup ) > $script
    fi
  fi
done

rvm install ruby-2.3.0

for script in ~/.rvm/{scripts,bin}/*-bashx-backup; do
  if [ -f $script ]; then
    mv $script ${script/-bashx-backup/}
  fi
done
