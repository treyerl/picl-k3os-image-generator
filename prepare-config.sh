#!/usr/bin/python3

import sys
import glob
import ruamel.yaml
import os
from ruamel.yaml.scalarstring import PreservedScalarString as pss

for config in glob.iglob(r'config/*.yaml'):
  with open(config) as f:
      content = ruamel.yaml.load(f, ruamel.yaml.RoundTripLoader)
  for manifest in glob.glob(r'manifests/*.yaml'):
    
    with open(manifest, 'r') as m:
      # desc["content"] += m.read()
      desc = {
        "path": "/var/lib/rancher/k3s/server/manifests/" + manifest,
        "content": pss(m.read())
      }
    content['write_files'].append(desc)
  print(config)
  if not os.path.exists('.config'):
    os.mkdir('.config')
  with open('.' + config, 'w+') as c:
      ruamel.yaml.dump(content, c, Dumper=ruamel.yaml.RoundTripDumper)