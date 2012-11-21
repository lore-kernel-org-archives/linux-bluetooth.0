Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v2 0/2] sco: BT_DEFER_SETUP for SCO sockets
Date: Wed, 21 Nov 2012 10:51:10 +0100
Message-Id: <1353491473-3789-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This patch implements BT_DEFER_SETUP option on SCO sockets. hci layer get some
changes since previous behavior was to accept all SCO connections.

How to test :
compile bluez (3fd3d5f or newer) with --enable-test and run:
$ btiotest -s -d -a 5
on another machine run:
$ btiotest -s <bdaddr>
Check result with btmon.

Best regards,
Frédéric


Frédéric Dalleau (2):
  Bluetooth: Add BT_DEFER_SETUP option to sco socket
  Bluetooth: Implement deferred sco socket setup

 include/net/bluetooth/hci_core.h |    9 +++--
 net/bluetooth/hci_event.c        |   52 ++++++++++++++++++++++++++---
 net/bluetooth/sco.c              |   67 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 118 insertions(+), 10 deletions(-)

-- 
1.7.9.5

