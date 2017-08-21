Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 0/5] MeshCtl - Mesh GATT Client Provisioner
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170814190119.8684-1-brian.gix@intel.com>
Date: Mon, 21 Aug 2017 12:42:34 +0200
Cc: linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Message-Id: <33A7367D-A41A-457E-9187-C30E2B027CAB@holtmann.org>
References: <20170814190119.8684-1-brian.gix@intel.com>
To: Brian Gix <brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

> With the recent adoption of the Bluetooth Mesh Profile, we offer this
> GATT Client provisioner tool (meshctl).
> 
> Brian Gix / Inga Stotland` (5):
>  mesh: Add BT SIG reserved numbers for Mesh
>  mesh: define APIs for Bluetooth Mesh
>  mesh: Baseline Mesh runtime configuration files
>  mesh: Baseline Mesh implementation
>  mesh: Add mesh to main bluez build
> 
> Makefile.tools       |   24 +
> bootstrap-configure  |    1 +
> configure.ac         |   18 +
> lib/uuid.h           |   10 +
> mesh/README          |   26 +
> mesh/agent.c         |  276 ++++++
> mesh/agent.h         |   58 ++
> mesh/config-client.c |  667 +++++++++++++++
> mesh/config-model.h  |  119 +++
> mesh/config-server.c |  165 ++++
> mesh/crypto.c        | 1168 ++++++++++++++++++++++++++
> mesh/crypto.h        |  133 +++
> mesh/gatt.c          |  609 ++++++++++++++
> mesh/gatt.h          |   47 ++
> mesh/keys.h          |   43 +
> mesh/local_node.json |   61 ++
> mesh/main.c          | 2269 ++++++++++++++++++++++++++++++++++++++++++++++++++
> mesh/mesh-net.h      |  174 ++++
> mesh/net.c           | 2184 ++++++++++++++++++++++++++++++++++++++++++++++++
> mesh/net.h           |   72 ++
> mesh/node.c          |  879 +++++++++++++++++++
> mesh/node.h          |  146 ++++
> mesh/onoff-model.c   |  306 +++++++
> mesh/onoff-model.h   |   50 ++
> mesh/prov-db.c       | 1599 +++++++++++++++++++++++++++++++++++
> mesh/prov-db.h       |   52 ++
> mesh/prov.c          |  664 +++++++++++++++
> mesh/prov.h          |   43 +
> mesh/prov_db.json    |   37 +
> mesh/util.c          |  369 ++++++++
> mesh/util.h          |   71 ++
> 31 files changed, 12340 insertions(+)
> create mode 100644 mesh/README
> create mode 100644 mesh/agent.c
> create mode 100644 mesh/agent.h
> create mode 100644 mesh/config-client.c
> create mode 100644 mesh/config-model.h
> create mode 100644 mesh/config-server.c
> create mode 100644 mesh/crypto.c
> create mode 100644 mesh/crypto.h
> create mode 100644 mesh/gatt.c
> create mode 100644 mesh/gatt.h
> create mode 100644 mesh/keys.h
> create mode 100644 mesh/local_node.json
> create mode 100644 mesh/main.c
> create mode 100644 mesh/mesh-net.h
> create mode 100644 mesh/net.c
> create mode 100644 mesh/net.h
> create mode 100644 mesh/node.c
> create mode 100644 mesh/node.h
> create mode 100644 mesh/onoff-model.c
> create mode 100644 mesh/onoff-model.h
> create mode 100644 mesh/prov-db.c
> create mode 100644 mesh/prov-db.h
> create mode 100644 mesh/prov.c
> create mode 100644 mesh/prov.h
> create mode 100644 mesh/prov_db.json
> create mode 100644 mesh/util.c
> create mode 100644 mesh/util.h

all 5 patches have been applied.

Regards

Marcel

