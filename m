Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [RFC] sco: BT_DEFER_SETUP for SCO sockets
Date: Tue, 13 Nov 2012 19:20:24 +0100
Message-Id: <1352830825-13987-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This is a first draft about what can be done to implement DEFER_SETUP on SCO
sockets.  I couldn't test it today I just pulled bluetooth-next and build
failed, so I plan to go further tomorrow.

hci layer get some changes since previous behavior was to accept all SCO
connections.

Some questions are open :
Should we be able to defer non eSCO capable devices? This would remove a few
lines of code.
hci_proto_defered is ugly: What about a flag similar to LM_ACCEPT called
LM_DEFER that would indicate that accepting is defered.

Let me know what you think.

Best regards,
Frédéric


Frédéric Dalleau (1):
  Bluetooth: Add BT_DEFER_SETUP option to sco socket

 include/net/bluetooth/hci_core.h |   15 +++++++
 net/bluetooth/hci_event.c        |   47 +++++++++++++++++++-
 net/bluetooth/sco.c              |   88 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 145 insertions(+), 5 deletions(-)

-- 
1.7.9.5

