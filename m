Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH 0/5] sco: SCO socket option for mode
Date: Thu, 17 Jan 2013 13:39:44 +0100
Message-Id: <1358426389-25903-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This is the patch version of the socket option for enabling transparent SCO
sockets.  RFC didn't generate feedback, so if we consider that people only
complains when something is wrong, this patch is fine ;)
In between, the patch series has been simplified, the most visible change is
that RFC was declaring HCI_CONN_SCO_T1_SETTINGS and removing it
later, plus some __cpu_to_le16 conversion were added.

The initial mode corresponding to current behavior is SCO_MODE_CVSD.
SCO_MODE_TRANSPARENT is the mode for setting up transparent sockets.
SCO_MODE_ENHANCED is targeted at CSA2. It is only declared and not
implemented.

Let me know what you think.
Best regards,

Frédéric


Frédéric Dalleau (5):
  Bluetooth: Add option for SCO socket mode
  Bluetooth: Add setsockopt for SCO socket mode
  Bluetooth: Use mode when accepting SCO connection
  Bluetooth: Parameters for outgoing SCO connections
  Bluetooth: Fallback transparent SCO from T2 to T1

 include/net/bluetooth/hci_core.h |    5 +++-
 include/net/bluetooth/sco.h      |   20 ++++++++++++++
 net/bluetooth/hci_conn.c         |   36 +++++++++++++++++++++-----
 net/bluetooth/hci_event.c        |   22 +++++++++++++---
 net/bluetooth/sco.c              |   53 +++++++++++++++++++++++++++++++++++---
 5 files changed, 121 insertions(+), 15 deletions(-)

-- 
1.7.9.5

