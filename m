Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [RFC 0/4] sco: Another SCO socket option :)
Date: Wed, 28 Nov 2012 19:28:32 +0100
Message-Id: <1354127316-17431-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This patch implements codec socket option on SCO sockets.
Currently it proposes T2 codec settins (see HFP 1.6 p.102)


How to test:
$ scotest -W 1 -C 1

on another machine with same patches run:
$ scotest -n $ADDR -C 1

Check result with btmon.

This took more time than I expected for I met the following issues :
* bluetooth-next branch crashed in apparmor after login.
* At some point, unplugging my usb dongle would also crash the kernel. It is
possible this one was a mix between different versions of kernel modules.
* if the connection request is not accepted, the initiator gets in timeout, and
there is a crash. I think this one will need be fixed.

Next step is to implement fallback between T2 and T1. I'm thinking about using
another bit in hconn->flags to store current settings selection.

Let me know what you think.
Best regards,
Frédéric


Frédéric Dalleau (4):
  Bluetooth: Add option for SCO socket codec
  Bluetooth: Add option for SCO socket socket
  Bluetooth: Use codec to create SCO connection
  Bluetooth: Set link parameters for outgoing connections

 include/net/bluetooth/hci_core.h |    6 +++--
 include/net/bluetooth/sco.h      |    2 ++
 net/bluetooth/hci_conn.c         |   24 ++++++++++++++----
 net/bluetooth/hci_event.c        |   23 ++++++++++++++---
 net/bluetooth/l2cap_core.c       |    4 +--
 net/bluetooth/mgmt.c             |    4 +--
 net/bluetooth/sco.c              |   51 ++++++++++++++++++++++++++++++++++++--
 7 files changed, 97 insertions(+), 17 deletions(-)

-- 
1.7.9.5

