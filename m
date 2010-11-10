Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCHv2 0/7]  Support for out of band association model
Date: Wed, 10 Nov 2010 14:31:10 +0100
Message-ID: <1289395877-12384-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

New version with some bugfixes/improvements and small changes in DBus API.
New feature is support for approval for incoming OOB pairing request.

Comments are welcome.

This email was sent on behalf of ST-Ericsson SA.

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
 doc/oob-api.txt         |   75 ++++++++++
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
 18 files changed, 997 insertions(+), 38 deletions(-)
 create mode 100644 doc/oob-api.txt
 create mode 100644 plugins/dbusoob.c
 create mode 100644 src/oob.c
 create mode 100644 src/oob.h
 create mode 100755 test/simple-oobprovider

