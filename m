Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v7 0/6] Support for out of band association mode
Date: Sat, 26 Mar 2011 12:27:05 +0100
Message-ID: <1301138831-12082-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes since v6:
- fixed issues pointed out by Johan

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
 plugins/dbusoob.c |  234 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 plugins/hciops.c  |  142 +++++++++++++++++++++++++++++++-
 plugins/mgmtops.c |  129 +++++++++++++++++++++++++++++
 src/adapter.c     |   18 ++++
 src/adapter.h     |   12 +++
 src/oob.c         |   41 +++++++++
 src/oob.h         |   32 +++++++
 12 files changed, 702 insertions(+), 6 deletions(-)
 create mode 100644 doc/oob-api.txt
 create mode 100644 plugins/dbusoob.c
 create mode 100644 src/oob.c
 create mode 100644 src/oob.h

