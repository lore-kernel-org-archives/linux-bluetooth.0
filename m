Return-Path: <cyrus@holtmann.org>
Date: Fri, 20 Feb 2009 15:23:46 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Allow BT_SECURITY for L2CAP raw sockets
Message-ID: <20090220132346.GA5255@jh-x301>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Marcel,

Here's the patch to permit BT_SECURITY for L2CAP raw sockets. It allows
our BtIO code to be simpler since there's no need to do special L2CAP_LM
tricks when doing paring using L2CAP raw sockets. It seemed to work fine
in my tests (both SSP and legacy pairing) so if it's ok with you I'll
also push the corresponding patch for bluetoothd (which without this
patch would cause EINVAL when trying pairing on a newer kernel).

Johan

--4Ckj6UjgE2iN1+kY
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="0001-Bluetooth-Permit-BT_SECURITY-also-for-L2CAP-raw-soc.patch"

>From a6f7321f607712eafde755726d07ccf1a1fcdfab Mon Sep 17 00:00:00 2001
From: Johan Hedberg <johan.hedberg@nokia.com>
Date: Fri, 20 Feb 2009 14:56:00 +0200
Subject: [PATCH] Bluetooth: Permit BT_SECURITY also for L2CAP raw sockets

Userspace pairing code can be simplified if it doesn't have to fall back
to using L2CAP_LM in the case of L2CAP raw sockets. This patch allows
the BT_SECURITY socket option to be used for all types of L2CAP sockets.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 net/bluetooth/l2cap.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 7c6768c..b935cf0 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1308,11 +1308,6 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 
 	switch (optname) {
 	case BT_SECURITY:
-		if (sk->sk_type != SOCK_SEQPACKET) {
-			err = -EINVAL;
-			break;
-		}
-
 		sec.level = BT_SECURITY_LOW;
 
 		len = min_t(unsigned int, sizeof(sec), optlen);
-- 
1.5.6.3


--4Ckj6UjgE2iN1+kY--
