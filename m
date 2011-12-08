Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC obexd v2 00/21] Major API changes in obex-client
Date: Thu, 8 Dec 2011 16:27:34 +0100
Message-ID: <1323358075-27857-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch series proposes an implementation of the previously discussed D-Bus API changes in obex-client.

As a consequence of these changes some internal interfaces have also been simplified or modified (patch 11/21). The new approach tries to be easier to use and safer.

The resulting code seems functional but has had limited testing only, so it will probably introduce several new bugs. However, most of the test scripts have been updated so the result (first impression) can be evaluated without much effort.

Some of the patches have been squashed in order to have a shorter series. Particularly the changes in the test scripts have been merged into the implementation patches.

In addition, there is one more change discussed in the IRC but not included in this series: the D-Bus API should return transfer properties along with the transfer path for each method initiating a transfer. This has been left out, to be discussed later.

I hope you like the general approach.

Mikel Astiz (21):
  client-doc: minor formatting changes
  client-doc: wrap OPP into specific session type
  client: wrap OPP into specific session type
  client-doc: replace SendFiles with SendFile
  client: replace SendFiles with SendFile
  client-doc: GetCapabilities moved to session API
  client: GetCapabilities moved to session API
  client-doc: replace parameter dict with conventional ones
  client: replace parameter dict with conventional ones
  client-doc: remove agent in favour of transfer signals
  client: remove agent in favour of transfer signals
  client-doc: ObjectPush sessions return transports
  client: ObjectPush sessions return transports
  client-doc: FileTransfer sessions return transports
  client: FileTransfer sessions return transports
  client-doc: Synchronization sessions return transports
  client: Synchronization sessions return transports
  client-doc: PhonebookAccess sessions return transports
  client: PhonebookAccess sessions return transports
  client: report size in GET operations
  client: update copyright statement

 Makefile.am                  |    3 +-
 client/agent.c               |  252 --------
 client/agent.h               |   43 --
 client/dbus.c                |  255 ++++++++
 client/dbus.h                |   66 ++
 client/ftp.c                 |  188 ++++--
 client/manager.c             |  401 ++-----------
 client/opp.c                 |  157 +++++-
 client/pbap.c                |  196 +++---
 client/session.c             | 1390 +++++++++++++++++++-----------------------
 client/session.h             |   75 ++--
 client/sync.c                |   74 ++-
 client/transfer.c            |  839 ++++++++++++++------------
 client/transfer.h            |   68 ++-
 client/transferqueue.c       |  230 +++++++
 client/transferqueue.h       |   47 ++
 doc/client-api.txt           |  274 +++++----
 gobex/gobex-defs.h           |    1 +
 gobex/gobex-transfer.c       |   28 +-
 gobex/gobex.h                |    1 +
 test/exchange-business-cards |    9 +-
 test/ftp-client              |  191 +++---
 test/get-capabilities        |   15 +-
 test/list-folders            |    2 +-
 test/pbap-client             |  192 +++++--
 test/pull-business-card      |    8 +-
 test/send-files              |   88 +---
 27 files changed, 2706 insertions(+), 2387 deletions(-)
 delete mode 100644 client/agent.c
 delete mode 100644 client/agent.h
 create mode 100644 client/dbus.c
 create mode 100644 client/dbus.h
 create mode 100644 client/transferqueue.c
 create mode 100644 client/transferqueue.h

-- 
1.7.6.4

