Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v5 0/6] Support for out of band association model
Date: Fri, 4 Mar 2011 16:08:29 +0100
Message-ID: <1299251315-2041-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Significant change since last version is that oob data is now fed to kernel (or
hciops) and is used while pairing if needed. No need for requesting
providers/agent while pairing. Advantage is less roundtrips and much simpler
implementation.

Whats in the patchset:
- for new kernels implementation in mgmtops
  (with kernel patches from "[PATCH v2 0/4] Support for OOB in mgmt interface")
- for compatibility with older kernels implementation in hciops (mimic mgmt)
- D-Bus plugin only exposes OOB functionality. In future we could also have
  CreateOOB[Paired]Device (or similar) which would act as
  AddRemoteOobData+CreateDevice.


As usual, comments are welcome.


BR,
Szymon Janc
on behalf of ST-Ericsson


Szymon Janc (6):
  Add initial support for Out of Band (OOB) association model
  Add support for Out of Band (OOB) association model in mgmtops
  Add support for Out of Band (OOB) association model in hciops
  Add D-Bus OOB plugin
  Update mgmt-api.txt with OOB commands
  Add oob-api.txt with documentation about OOB D-Bus methods

 Makefile.am       |    8 ++-
 acinclude.m4      |    6 ++
 doc/mgmt-api.txt  |   30 +++++++
 doc/oob-api.txt   |   38 +++++++++
 lib/mgmt.h        |   18 ++++
 plugins/dbusoob.c |  241 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 plugins/hciops.c  |  143 ++++++++++++++++++++++++++++++-
 plugins/mgmtops.c |  127 ++++++++++++++++++++++++++++
 src/adapter.c     |   18 ++++
 src/adapter.h     |   12 +++
 src/oob.c         |   43 ++++++++++
 src/oob.h         |   30 +++++++
 12 files changed, 708 insertions(+), 6 deletions(-)
 create mode 100644 doc/oob-api.txt
 create mode 100644 plugins/dbusoob.c
 create mode 100644 src/oob.c
 create mode 100644 src/oob.h

