Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 0/5] MAP client: Add Message Notification Service (MNS) server
Date: Tue,  9 Apr 2013 13:51:32 +0200
Message-Id: <1365508297-13032-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

As follow-up on our discussions, I've split the patch set
"MAP client: notification support" into smaller chunks that can be reviewed
separately.

This first patch set adds the Message Notification Service (MNS) server to the
MAP client and automatically establishes/terminates the MNS connection together
with the MAS connections.

The MNS implementation will parse event reports received from the MSE and
print debug messages for now. The dispatching of event reports to the correct
MAS client instance will follow in a different patch set.

Christian Fetzer (5):
  profile: Add MNS server record
  obexd: Add Message Notification Service (MNS) server
  build: Add support for building MNS server
  obexd: Enable MNS server
  obexd: Automatically setup notification connection for MAP client

 Makefile.obexd            |   3 +
 obexd/client/map-event.h  |  42 ++++++
 obexd/client/map.c        |  34 +++++
 obexd/client/mns.c        | 363 ++++++++++++++++++++++++++++++++++++++++++++++
 obexd/plugins/bluetooth.c |   2 +
 obexd/src/obexd.h         |   1 +
 src/profile.c             |  55 +++++++
 7 files changed, 500 insertions(+)
 create mode 100644 obexd/client/map-event.h
 create mode 100644 obexd/client/mns.c

-- 
1.8.2.1

