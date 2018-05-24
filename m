Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Gix, Brian" <brian.gix@intel.com>
To: "a.rai@samsung.com" <a.rai@samsung.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Anupam Roy <anupam.r@samsung.com>,
        SACHIN DEV SHARMA <sachin.dev@samsung.com>
Subject: Re: [PATCH BlueZ v4 00/14] Bluetooth Mesh Daemon
Date: Thu, 24 May 2018 06:45:31 +0000
Message-ID: <4F023D34-B3F6-44D4-AF5A-90BC4EF514FD@intel.com>
References: <20180430210319.25137-1-brian.gix@intel.com>
        <CGME20180430210346epcas2p26aece6a2f299d3b9e151a7531781a0a8@epcms5p6>,<20180524050753epcms5p6d7414d626ed0039e9592098ef7238a5c@epcms5p6>
In-Reply-To: <20180524050753epcms5p6d7414d626ed0039e9592098ef7238a5c@epcms5p6>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Atul,


> On May 23, 2018, at 10:08 PM, Atul Kumar Rai <a.rai@samsung.com> wrote:
> 
> Hi Brian,
>  
>>  Version 4 of this patch set uses the new ECC function ecc_make_public_key()
>>  when a non-ephemeral Public/Private key-pair is required for Provisioning
>>   
>>  Otherwise:
>>  This is our starting point for creating a stand-alone Mesh Daemon.
>>   
>>  The Mesh Daemon (meshd) is intended to eventually co-exist beside the
>>  Bluetooth Daemon (bluetoothd), and either daemon may exist without the
>>  other. The Mesh Daemon will need full control/ownership of a
>>  BT Controller that supports at least Core Spec revision 4.0 or
>>  greater.  It works strictly over the Advertising bearer, but we
>>  have plans to extend it to support Mesh Proxy Server over GATT, at
>>  which point it will require support from bluetoothd.
>>   
>>  The current meshd, and it's companion Non-Background Command-line
>>  version btmesh, exists fully within user-space, but requires an
>>  HCI_USER socket to the kernel controler, and currently requires root
>>  privledges.
>>   
>>  This first revision is intended to operate as a standard
>>  (non-provisioner) node.  It includes the Configuration Server model,
>>  and if it cannot find it's Mesh Configuration, will look for it's
>>  Composition data, and start up as unprovisioned, and accept an
>>  incoming PB-ADV provisioning session.
>>   
>>  Two of us (Inga and Brian) have been working on this, and will be
>>  the initial supporters and maintainers, and we gladly invite other
>>  interested parties to participate.
>>   
>>  Brian Gix (7):
>>    meshd: Shared private meshd interfaces
>>    meshd: Mesh crypto support
>>    meshd: Infrastructure for Mesh daemon
>>    meshd: Initial Mesh Friendship support
>>    meshd: Provisioning logic for mesh
>>    meshd: Upper and Lower mesh transport
>>    meshd: Add Accessors to Transport layer data
>>   
>>  Inga Stotland (7):
>>    meshd: Header files for mesh access layer and utilities
>>    meshd: Source files for mesh access layer and utilities
>>    meshd: Source code for handling access layer mux/demux
>>    meshd: Mesh config server model
>>    meshd: Read and write mesh configuration in JSON format
>>    meshd: Sample device composition in JSON fromat
>>    Makefile for meshd and configure.ac
>>   
>>   Makefile.am                   |    1 +
>>   Makefile.meshd                |   44 +
>>   configure.ac                  |    2 +-
>>   meshd/common/agent.c          |  229 +++
>>   meshd/common/agent.h          |   42 +
>>   meshd/common/mesh-defs.h      |   84 +
>>   meshd/common/util.c           |   71 +
>>   meshd/common/util.h           |   25 +
>>   meshd/config/composition.json |   44 +
>>   meshd/mesh-json/mesh-db.c     | 1360 +++++++++++++
>>   meshd/mesh-json/mesh-db.h     |  144 ++
>>   meshd/src/appkey.c            |  538 ++++++
>>   meshd/src/appkey.h            |   43 +
>>   meshd/src/btmesh.c            |  176 ++
>>   meshd/src/cfgmod-server.c     | 1194 ++++++++++++
>>   meshd/src/cfgmod.h            |   98 +
>>   meshd/src/crypto.c            | 1607 ++++++++++++++++
>>   meshd/src/crypto.h            |  164 ++
>>   meshd/src/display.c           |   67 +
>>   meshd/src/display.h           |   29 +
>>   meshd/src/friend.c            | 1116 +++++++++++
>>   meshd/src/friend.h            |   57 +
>>   meshd/src/hci.c               |  699 +++++++
>>   meshd/src/hci.h               |   56 +
>>   meshd/src/main.c              |  174 ++
>>   meshd/src/mesh-io-api.h       |   58 +
>>   meshd/src/mesh-io-generic.c   |  660 +++++++
>>   meshd/src/mesh-io-generic.h   |   20 +
>>   meshd/src/mesh-io.c           |  187 ++
>>   meshd/src/mesh-io.h           |   99 +
>>   meshd/src/mesh.c              |  184 ++
>>   meshd/src/mesh.h              |   32 +
>>   meshd/src/model.c             | 1274 +++++++++++++
>>   meshd/src/model.h             |  146 ++
>>   meshd/src/net.c               | 4188 +++++++++++++++++++++++++++++++++++++++++
>>   meshd/src/net.h               |  392 ++++
>>   meshd/src/node.c              |  851 +++++++++
>>   meshd/src/node.h              |   80 +
>>   meshd/src/prov.c              |  722 +++++++
>>   meshd/src/prov.h              |  162 ++
>>   meshd/src/provision.c         | 1159 ++++++++++++
>>   meshd/src/provision.h         |   30 +
>>   meshd/src/storage.c           |  673 +++++++
>>   meshd/src/storage.h           |   51 +
>>   44 files changed, 19031 insertions(+), 1 deletion(-)
>>   create mode 100644 Makefile.meshd
>>   create mode 100644 meshd/common/agent.c
>>   create mode 100644 meshd/common/agent.h
>>   create mode 100644 meshd/common/mesh-defs.h
>>   create mode 100644 meshd/common/util.c
>>   create mode 100644 meshd/common/util.h
>>   create mode 100644 meshd/config/composition.json
>>   create mode 100644 meshd/mesh-json/mesh-db.c
>>   create mode 100644 meshd/mesh-json/mesh-db.h
>>   create mode 100644 meshd/src/appkey.c
>>   create mode 100644 meshd/src/appkey.h
>>   create mode 100644 meshd/src/btmesh.c
>>   create mode 100644 meshd/src/cfgmod-server.c
>>   create mode 100644 meshd/src/cfgmod.h
>>   create mode 100644 meshd/src/crypto.c
>>   create mode 100644 meshd/src/crypto.h
>>   create mode 100644 meshd/src/display.c
>>   create mode 100644 meshd/src/display.h
>>   create mode 100644 meshd/src/friend.c
>>   create mode 100644 meshd/src/friend.h
>>   create mode 100644 meshd/src/hci.c
>>   create mode 100644 meshd/src/hci.h
>>   create mode 100644 meshd/src/main.c
>>   create mode 100644 meshd/src/mesh-io-api.h
>>   create mode 100644 meshd/src/mesh-io-generic.c
>>   create mode 100644 meshd/src/mesh-io-generic.h
>>   create mode 100644 meshd/src/mesh-io.c
>>   create mode 100644 meshd/src/mesh-io.h
>>   create mode 100644 meshd/src/mesh.c
>>   create mode 100644 meshd/src/mesh.h
>>   create mode 100644 meshd/src/model.c
>>   create mode 100644 meshd/src/model.h
>>   create mode 100644 meshd/src/net.c
>>   create mode 100644 meshd/src/net.h
>>   create mode 100644 meshd/src/node.c
>>   create mode 100644 meshd/src/node.h
>>   create mode 100644 meshd/src/prov.c
>>   create mode 100644 meshd/src/prov.h
>>   create mode 100644 meshd/src/provision.c
>>   create mode 100644 meshd/src/provision.h
>>   create mode 100644 meshd/src/storage.c
>>   create mode 100644 meshd/src/storage.h
>>   
>>  -- 
>>  2.14.3
>  
> Is there any existing tool to provision over advertising bearer?

The Provisioner role will be one of the first additions we make, but prior to that, the Bluetooth SIG’s PTS tool is available, and can be used for provisioning purposes. Also the local node configuration is in a JSON format that may be edited by hand.