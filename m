Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [RFC v2 0/5] sco: SCO socket option for mode
Date: Tue, 11 Dec 2012 17:53:47 +0100
Message-Id: <1355244832-2729-1-git-send-email-frederic.dalleau@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

This is v2 of the patch for codec option on SCO sockets. Some people asked
for more generic behavior, so I renamed the 'codec' field as 'mode' in order to
provide some way to extend the socket option. So it is still an RFC. Feel
free to comment the API in patch 1.

Since previous version, the patch is now able to use T2 codec settings and
switch to T1 if T2 fails (see HFP 1.6 p.102). The fallback is implemented by
using the connection attempt counter to determine what settings to use. I did
so because the fallback mechanism is more generic in this case, and this can be
reused for S3, S2, S1! However, one bit is still needed in the hci flags, and
it is likely that one bit will be needed for each supported 'modes'.

The fallback mechanism is only available on outgoing connections. For incoming
connections, the only to be sure to accept T2 is to call AcceptSyncConnReq with
2EV3 packet type only. But if an incoming connection was done with T1 (EV3)
then we cannot accept it at all: it is not possible to retry an AcceptSyncConn
Req. We can't guess in advance whether some third party wants to connect T2 or
T1. So currently, all supported packets type are accepted.

I also took Andrei comment into account exporting hci_connect_sco. This really
simplifies.

Let me know what you think.
Best regards,

Frédéric


Frédéric Dalleau (5):
  Bluetooth: Add option for SCO socket mode
  Bluetooth: Add setsockopt for SCO socket mode
  Bluetooth: Use codec to create SCO connection
  Bluetooth: Set parameters for outgoing connections
  Bluetooth: Fallback transparent SCO from T2 to T1

 include/net/bluetooth/hci_core.h |    5 +++-
 include/net/bluetooth/sco.h      |   19 ++++++++++++++
 net/bluetooth/hci_conn.c         |   30 +++++++++++++++++----
 net/bluetooth/hci_event.c        |   22 +++++++++++++---
 net/bluetooth/sco.c              |   53 +++++++++++++++++++++++++++++++++++---
 5 files changed, 116 insertions(+), 13 deletions(-)

-- 
1.7.9.5

