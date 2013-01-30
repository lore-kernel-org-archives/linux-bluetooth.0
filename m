Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v2 0/4] sco: SCO socket option for mode
Date: Wed, 30 Jan 2013 17:03:16 +0100
Message-Id: <1359561800-12870-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This is the patch version 2 of the socket option for enabling transparent SCO
sockets. I kept the mode name.
The initial mode corresponding to current behavior is SCO_MODE_CVSD.
SCO_MODE_TRANSPARENT is the mode for setting up transparent data sockets.
Because it is still foggy, SCO_MODE_ENHANCED is no longer declared in this
series, it is sent as an additional RFC.

Let me know what you think.
Best regards,

Frédéric Dalleau (4):
  Bluetooth: Add option for SCO socket mode
  Bluetooth: Use mode to create SCO connection
  Bluetooth: Parameters for outgoing SCO connections
  Bluetooth: Fallback transparent SCO from T2 to T1

 include/net/bluetooth/hci_core.h |    5 ++-
 include/net/bluetooth/sco.h      |    7 +++++
 net/bluetooth/hci_conn.c         |   38 ++++++++++++++++------
 net/bluetooth/hci_event.c        |   22 ++++++++++---
 net/bluetooth/sco.c              |   64 ++++++++++++++++++++++++++++++++++++--
 5 files changed, 118 insertions(+), 18 deletions(-)

-- 
1.7.9.5

