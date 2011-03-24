Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v6 0/6] Support for out of band association model
Date: Thu, 24 Mar 2011 14:47:33 +0100
Message-ID: <1300974459-24076-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

No vital changes since v5. Only rebase to cleanly apply on latest master and
updated mgmt commands codes to match mgmt OOB v5 patches.

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

