Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH 0/2] sco: BT_DEFER_SETUP for SCO sockets
Date: Mon, 19 Nov 2012 17:35:55 +0100
Message-Id: <1353342958-25303-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This is a better view about what can be done to implement DEFER_SETUP on SCO
sockets. hci layer get some changes since previous behavior was to accept all
SCO connections.
The ugly hci_proto_defer has been removed and replaced by an additional flag
parameter to hci_proto_connect_ind.
Regarding testing, I'm still stuck by a txt timeout issue however, if the
delay between accept and recv is set to 0, then the connection is working fine.
And I even managed to get the sco connection established correctly once. So I
believed this emulator problem.
Now I'm trying without emulator.

Let me know what you think.

Best regards,
Frédéric


Frédéric Dalleau (2):
  Bluetooth: Add BT_DEFER_SETUP option to sco socket
  Bluetooth: Implement deferred sco socket setup

 include/net/bluetooth/hci_core.h |    9 +++--
 net/bluetooth/hci_event.c        |   53 +++++++++++++++++++++++++++---
 net/bluetooth/sco.c              |   67 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 119 insertions(+), 10 deletions(-)

-- 
1.7.9.5

