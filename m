Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC obexd v3 00/20] Major API changes in obex-client
Date: Tue, 13 Dec 2011 17:44:03 +0100
Message-ID: <1323794663-2711-1-git-send-email-mikel.astiz@bmw-carit.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch series proposes an implementation of the previously discussed D-Bus API changes in obex-client.

This second version includes the corrections proposed by Luiz, mainly:

1. Async flag in get_capabilities (was also included previously but in a wrong patch).
2. CreateSession: type (target) and source address left inside the dictionary.
3. In session.h, transfer returned as return-value and errors as parameter.
4. opp_pull_business_card directly stores the result in a file.
5. obc_session_get now takes void* instead of guint8*.
6. The transfer size request for GET operations (RFC v2 20/21) has been dropped, to be discussed later.

Other minor fixes have also been included:

1. Better error reporting (still to be improved).
2. OPP test scripts merged into opp-client.
3. Synchronization.PutPhonebook changes so it takes a filename, instead of phonebook content.

Mikel Astiz (20):
  client-doc: minor formatting changes
  client-doc: wrap OPP into specific session type
  client: wrap OPP into specific session type
  client-doc: replace SendFiles with SendFile
  client: replace SendFiles with SendFile
  client-doc: move GetCapabilities to session API
  client: move GetCapabilities to session API
  client-doc: replace parameter dict with conventional ones
  client: replace parameter dict with conventional ones
  client-doc: remove agent in favour of transfer signals
  client: remove agent in favour of transfer signals
  client-doc: ObjectPush sessions return transfers
  client: ObjectPush sessions return transfers
  client-doc: FileTransfer sessions return transfers
  client: FileTransfer sessions return transfers
  client-doc: Synchronization sessions return transfers
  client: Synchronization sessions return transfers
  client-doc: PhonebookAccess sessions return transfers
  client: PhonebookAccess sessions return transfers
  client: update copyright statement

 Makefile.am                  |    3 +-
 client/agent.c               |  252 --------
 client/agent.h               |   43 --
 client/dbus.c                |  255 ++++++++
 client/dbus.h                |   66 ++
 client/ftp.c                 |  203 ++++--
 client/manager.c             |  386 +-----------
 client/opp.c                 |  169 +++++-
 client/pbap.c                |  216 ++++---
 client/session.c             | 1432 ++++++++++++++++++++----------------------
 client/session.h             |   82 ++--
 client/sync.c                |   89 ++--
 client/transfer.c            |  895 +++++++++++++++------------
 client/transfer.h            |   74 ++-
 client/transferqueue.c       |  238 +++++++
 client/transferqueue.h       |   47 ++
 doc/client-api.txt           |  274 +++++----
 test/exchange-business-cards |    9 +-
 test/ftp-client              |  191 +++---
 test/get-capabilities        |   15 +-
 test/list-folders            |    2 +-
 test/opp-client              |  100 +++
 test/pbap-client             |  193 +++++--
 test/pull-business-card      |   34 -
 test/send-files              |   82 ---
 25 files changed, 2931 insertions(+), 2419 deletions(-)
 delete mode 100644 client/agent.c
 delete mode 100644 client/agent.h
 create mode 100644 client/dbus.c
 create mode 100644 client/dbus.h
 create mode 100644 client/transferqueue.c
 create mode 100644 client/transferqueue.h
 create mode 100755 test/opp-client
 delete mode 100755 test/pull-business-card
 delete mode 100755 test/send-files

-- 
1.7.6.4

