Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH obexd v1 00/16] client: Remove D-Bus agent
Date: Fri, 25 May 2012 12:11:17 +0200
Message-Id: <1337940693-3417-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

In this second proposal patch 3 has been modified to use time-based control of D-Bus progress reporting, as proposed by Luiz. The PropertyChanged signal will be emitted once per second.

>From original cover letter:

This patchset includes a second set of D-Bus changes as part of a bigger API rewrite in obex-client. The original API proposal started around 6 months ago ([1]) and it has later been discussed and modified several times.

This second series focuses on the replacement of the D-Bus agent: the authorization part is entirely removed and the reporting part is now addressed using D-Bus signals. The resulting API is more BlueZ-style and easier to use.

A third and last patchset is left out for later discussion (not proposed yet in the ML). These should extend the D-Bus API such that the transfer-initiating methods will return relevant information (D-Bus path + properties, to be discussed) about the created transfer object.

This results in a transitional API problem regarding FileTransfer interface: once the agent is removed, and before the transfer path is reported, there is no proper way to get transfer notifications. This problem can be seen in patch v0 16/16, but hopefully it's acceptable during the API transition. The fix is not included here to keep a reasonable patchset size.

Mikel Astiz (16):
  client: Add D-Bus helper library
  client-doc: Add progress property to transfer
  client: Add progress property to transfer
  client-doc: Add transfer event-reporting signals
  client: Add transfer event-reporting signals
  client-doc: Remove D-Bus agent
  client: Use transfer owner instead of agent
  client: Remove D-Bus agent
  client: Remove unused functions in transfer API
  client: Remove internal transfer progress report
  client: Remove obsolete authentication code
  client: Make D-Bus exposure of transfers optional
  client-doc: Add signal to report new transfers
  client: Expose D-Bus data in internal transfer API
  client: Add signal to report new transfers
  client-test: Remove agent from ftp-client

 Makefile.am        |    2 +-
 client/agent.c     |  252 --------------------------------
 client/agent.h     |   43 ------
 client/dbus.c      |  256 ++++++++++++++++++++++++++++++++
 client/dbus.h      |   66 +++++++++
 client/ftp.c       |   48 ++-----
 client/map.c       |    6 +-
 client/opp.c       |    4 +-
 client/pbap.c      |    8 +-
 client/session.c   |  408 ++++++++++------------------------------------------
 client/session.h   |    6 +-
 client/sync.c      |    4 +-
 client/transfer.c  |  209 +++++++++++++++------------
 client/transfer.h  |   13 +-
 doc/client-api.txt |   53 ++------
 test/ftp-client    |   49 ++-----
 16 files changed, 565 insertions(+), 862 deletions(-)
 delete mode 100644 client/agent.c
 delete mode 100644 client/agent.h
 create mode 100644 client/dbus.c
 create mode 100644 client/dbus.h

-- 
1.7.7.6

