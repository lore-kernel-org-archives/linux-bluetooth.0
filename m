Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix ATT socket backwards compatibility with user space
Date: Thu, 17 Oct 2013 22:16:26 +0300
Message-Id: <1382037386-17396-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Old user space versions bind the Attribute Protocol socket to
BDADDR_BREDR when they should be using BDADDR_LE_PUBLIC or
BDADDR_LE_RANDOM. The kernel recently introduced stricter checks on the
socket parameters but we need to punch this hole to them to ensure that
old user space versions keep working.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_sock.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 34e5a58..a43aead 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -159,8 +159,23 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr,
 	if (!bdaddr_type_is_valid(la.l2_bdaddr_type))
 		return -EINVAL;
 
-	if (chan->src_type == BDADDR_BREDR && la.l2_bdaddr_type != BDADDR_BREDR)
-		return -EINVAL;
+	if (chan->src_type == BDADDR_BREDR &&
+	    la.l2_bdaddr_type != BDADDR_BREDR) {
+		if (!bdaddr_type_is_le(la.l2_bdaddr_type))
+			return -EINVAL;
+
+		/* Old user space versions will try to bind the ATT
+		 * socket using BDADDR_BREDR, so we have to allow this
+		 * to pass and fix chan->src_type to the correct value.
+		 */
+		if (la.l2_cid != __constant_cpu_to_le16(L2CAP_CID_ATT))
+			return -EINVAL;
+
+		if (chan->scid != L2CAP_CID_ATT)
+			return -EINVAL;
+
+		chan->src_type = BDADDR_LE_PUBLIC;
+	}
 
 	if (chan->src_type != BDADDR_BREDR && la.l2_bdaddr_type == BDADDR_BREDR)
 		return -EINVAL;
-- 
1.8.3.1

