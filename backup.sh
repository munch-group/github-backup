#!/usr/bin/env -S pixi exec --spec gh -- bash -e

if ! gh auth status >/dev/null 2>&1; then
    echo "You need to login: gh auth login"
    exit 1
fi
gh repo list $1 --limit 4000 | while read -r repo _; do
	if ! [ -d $repo ] ; then
		gh repo clone "$repo" "$repo" 
	else
		git -C "$repo" pull
	fi
done

