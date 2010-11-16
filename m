Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCHv3 0/7] Support for out of band association model
Date: Tue, 16 Nov 2010 16:44:00 +0100
Message-ID: <1289922247-20712-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes since v2:
 - DBus provider Deactive() changed to Release() to be consistent with
   Agent API
 - DBus UpdateLocalOobData() changed to ReadLocalOobData() and explanation
   note in documentation added
 - renamed all update local oob data functions to read equivalents to keep
   names consistent (with hci command) in call chain

Szymon Janc (7):
  Add support for Out of Band (OOB) association model.
  Add DBus OOB plugin.
  Add DBus OOB API documentation.
  Add simple-oobprovider for testing.
  Add approval request for incoming pairing requests with OOB mechanism
  Update DBus OOB API with RequestApproval method.
  simple-agent - add RequestApproval method for OOB pairing

 Makefile.am             |   10 +-
 acinclude.m4            |    6 +
 doc/oob-api.txt         |   78 +++++++++++
 lib/hci.h               |    3 +
 plugins/dbusoob.c       |  353 +++++++++++++++++++++++++++++++++++++++++++++++
 plugins/hciops.c        |   96 +++++++++++--
 src/adapter.c           |   14 ++-
 src/adapter.h           |    6 +
 src/agent.c             |   59 ++++++++-
 src/agent.h             |    3 +
 src/device.c            |   98 +++++++++++++
 src/device.h            |   13 ++
 src/event.c             |  116 +++++++++++++---
 src/event.h             |    4 +-
 src/oob.c               |   61 ++++++++
 src/oob.h               |   47 +++++++
 test/simple-agent       |   10 ++
 test/simple-oobprovider |   61 ++++++++
 18 files changed, 1000 insertions(+), 38 deletions(-)
 create mode 100644 doc/oob-api.txt
 create mode 100644 plugins/dbusoob.c
 create mode 100644 src/oob.c
 create mode 100644 src/oob.h
 create mode 100755 test/simple-oobprovider

