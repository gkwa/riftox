`incus rm --force test_container` fails when this container doesn't exist.

I work around that by first checking whether it exists:
```bash
incus ls --format=json | jq 'map(select(.name == "ubc")) | .[] | .name' 
```

and then
```bash
get_incus_container test_container | xargs --no-run-if-empty -I {} incus delete --force {}
```

but that quicky gets annoying, so this helper script wrapts that.



## Install helpers

```bash
source <(curl -Ls https://raw.githubusercontent.com/taylormonacelli/riftox/master/incus-helper.sh)

get_incus_container test
delete_incus_container test


```