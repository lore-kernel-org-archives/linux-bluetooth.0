Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Brian Gix <brian.gix@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, johan.hedberg@gmail.com,
        inga.stotland@intel.com, Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ v5 00/14] Bluetooth Mesh Daemon
Date: Fri,  6 Jul 2018 10:12:52 -0700
Message-Id: <20180706171306.13501-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Version 5 of this patch-set conforms to the new layout under a single
flat mesh directory, after the reclassification of meshctl as a tool.

Otherwise:
This is our starting point for creating a stand-alone Mesh Daemon.

The Mesh Daemon (meshd) is intended to eventually co-exist beside the
Bluetooth Daemon (bluetoothd), and either daemon may exist without the
other. The Mesh Daemon will need full control/ownership of a
BT Controller that supports at least Core Spec revision 4.0 or
greater.  It works strictly over the Advertising bearer, but we
have plans to extend it to support Mesh Proxy Server over GATT, at
which point it will require support from bluetoothd.

The current meshd, and it's companion Non-Background Command-line
version btmesh, exists fully within user-space, but requires an
HCI_USER socket to the kernel controler, and currently requires root
privledges.

This initial revision is intended to operate as a standard
(non-provisioner) node.  It includes the Configuration Server model,
and if it cannot find it's Mesh Configuration, will look for it's
Composition data, and start up as unprovisioned, and accept an
incoming PB-ADV provisioning session.

Two of us (Inga and Brian) have been working on this, and will be
the initial supporters and maintainers, and we gladly invite other
interested parties to participate.

Brian Gix (7):
  mesh: Shared private meshd interfaces
  mesh: Mesh crypto support
  mesh: Infrastructure for Mesh daemon
  mesh: Initial Mesh Friendship support
  mesh: Provisioning logic for mesh
  mesh: Upper and Lower mesh transport
  mesh: Add Accessors to Transport layer data

Inga Stotland (7):
  mesh: Header files for mesh access layer and utilities
  mesh: Source files for mesh access layer and utilities
  mesh: Source code for handling access layer mux/demux
  mesh: Mesh config server model
  mesh: Read and write mesh configuration in JSON format
  mesh: Sample device composition in JSON format
  Makefile for meshd

 Makefile.am                  |    1 +
 Makefile.mesh                |   44 +
 mesh/agent.c                 |  229 +++
 mesh/agent.h                 |   42 +
 mesh/appkey.c                |  536 ++++++
 mesh/appkey.h                |   43 +
 mesh/btmesh.c                |  176 ++
 mesh/cfgmod-server.c         | 1194 ++++++++++++
 mesh/cfgmod.h                |   98 +
 mesh/config/composition.json |   44 +
 mesh/crypto.c                | 1607 ++++++++++++++++
 mesh/crypto.h                |  163 ++
 mesh/display.c               |   67 +
 mesh/display.h               |   28 +
 mesh/friend.c                | 1116 +++++++++++
 mesh/friend.h                |   57 +
 mesh/hci.c                   |  699 +++++++
 mesh/hci.h                   |   56 +
 mesh/main.c                  |  174 ++
 mesh/mesh-db.c               | 1360 ++++++++++++++
 mesh/mesh-db.h               |  144 ++
 mesh/mesh-defs.h             |   84 +
 mesh/mesh-io-api.h           |   58 +
 mesh/mesh-io-generic.c       |  660 +++++++
 mesh/mesh-io-generic.h       |   20 +
 mesh/mesh-io.c               |  187 ++
 mesh/mesh-io.h               |   99 +
 mesh/mesh.c                  |  184 ++
 mesh/mesh.h                  |   32 +
 mesh/model.c                 | 1274 +++++++++++++
 mesh/model.h                 |  146 ++
 mesh/net.c                   | 4188 ++++++++++++++++++++++++++++++++++++++++++
 mesh/net.h                   |  392 ++++
 mesh/node.c                  |  851 +++++++++
 mesh/node.h                  |   80 +
 mesh/prov.c                  |  722 ++++++++
 mesh/prov.h                  |  162 ++
 mesh/provision.c             | 1159 ++++++++++++
 mesh/provision.h             |   30 +
 mesh/storage.c               |  672 +++++++
 mesh/storage.h               |   51 +
 mesh/util.c                  |   71 +
 mesh/util.h                  |   24 +
 43 files changed, 19024 insertions(+)
 create mode 100644 Makefile.mesh
 create mode 100644 mesh/agent.c
 create mode 100644 mesh/agent.h
 create mode 100644 mesh/appkey.c
 create mode 100644 mesh/appkey.h
 create mode 100644 mesh/btmesh.c
 create mode 100644 mesh/cfgmod-server.c
 create mode 100644 mesh/cfgmod.h
 create mode 100644 mesh/config/composition.json
 create mode 100644 mesh/crypto.c
 create mode 100644 mesh/crypto.h
 create mode 100644 mesh/display.c
 create mode 100644 mesh/display.h
 create mode 100644 mesh/friend.c
 create mode 100644 mesh/friend.h
 create mode 100644 mesh/hci.c
 create mode 100644 mesh/hci.h
 create mode 100644 mesh/main.c
 create mode 100644 mesh/mesh-db.c
 create mode 100644 mesh/mesh-db.h
 create mode 100644 mesh/mesh-defs.h
 create mode 100644 mesh/mesh-io-api.h
 create mode 100644 mesh/mesh-io-generic.c
 create mode 100644 mesh/mesh-io-generic.h
 create mode 100644 mesh/mesh-io.c
 create mode 100644 mesh/mesh-io.h
 create mode 100644 mesh/mesh.c
 create mode 100644 mesh/mesh.h
 create mode 100644 mesh/model.c
 create mode 100644 mesh/model.h
 create mode 100644 mesh/net.c
 create mode 100644 mesh/net.h
 create mode 100644 mesh/node.c
 create mode 100644 mesh/node.h
 create mode 100644 mesh/prov.c
 create mode 100644 mesh/prov.h
 create mode 100644 mesh/provision.c
 create mode 100644 mesh/provision.h
 create mode 100644 mesh/storage.c
 create mode 100644 mesh/storage.h
 create mode 100644 mesh/util.c
 create mode 100644 mesh/util.h

-- 
2.14.4

