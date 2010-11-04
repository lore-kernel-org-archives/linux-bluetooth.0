Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 0/4] Support for out of band association model
Date: Thu, 4 Nov 2010 11:10:57 +0100
Message-ID: <1288865461-3760-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This set of patches add support for out of band association model.
Suggestions from previous discussion ([RFC] D-Bus API for out of
band association model) are taken into account.

Also exemplary plugin which exports OOB functionality over DBus
(proposed API) is included.

Comments are welcome.


Szymon Janc (4):
  Add support for Out of Band (OOB) association model.
  Add DBus OOB plugin.
  Add DBus OOB API documentation.
  Add simple-oobprovider for testing.

 Makefile.am             |   11 ++-
 acinclude.m4            |    6 +
 doc/oob-api.txt         |   62 ++++++++
 lib/hci.h               |    3 +
 plugins/dbusoob.c       |  356 +++++++++++++++++++++++++++++++++++++++++++++++
 plugins/hciops.c        |   70 ++++++++--
 src/adapter.c           |    5 +
 src/adapter.h           |    3 +
 src/device.c            |   80 +++++++++++-
 src/device.h            |   12 ++
 src/event.c             |   73 +++++++---
 src/event.h             |    3 +-
 src/oob.c               |   61 ++++++++
 src/oob.h               |   47 ++++++
 test/simple-oobprovider |   54 +++++++
 15 files changed, 811 insertions(+), 35 deletions(-)
 create mode 100644 doc/oob-api.txt
 create mode 100644 plugins/dbusoob.c
 create mode 100644 src/oob.c
 create mode 100644 src/oob.h
 create mode 100755 test/simple-oobprovider

