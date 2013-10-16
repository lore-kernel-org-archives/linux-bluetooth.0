Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Reintroduce socket restrictions for LE sockets
Date: Wed, 16 Oct 2013 13:37:43 +0300
Message-Id: <1381919863-27504-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Right now we do not allow user space to use connection oriented channels
on LE, and the only CID that can be used is the Attribute Protocol one.
These restrictions went away together with the recent refactoring of the
L2CAP code, but this patch puts them back to their appropriate places.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_sock.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 68f486a..bda52d7 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -72,6 +72,16 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 	if (!bdaddr_type_is_valid(la.l2_bdaddr_type))
 		return -EINVAL;
 
+	if (la.l2_bdaddr_type == BDADDR_LE_PUBLIC ||
+	    la.l2_bdaddr_type == BDADDR_LE_RANDOM) {
+		/* Connection oriented channels are not supported on LE */
+		if (la.l2_psm)
+			return -EINVAL;
+		/* We only allow ATT user space socket */
+		if (la.l2_cid != L2CAP_CID_ATT)
+			return -EINVAL;
+	}
+
 	lock_sock(sk);
 
 	if (sk->sk_state != BT_OPEN) {
@@ -156,6 +166,16 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr,
 	if (chan->src_type != BDADDR_BREDR && la.l2_bdaddr_type == BDADDR_BREDR)
 		return -EINVAL;
 
+	if (la.l2_bdaddr_type == BDADDR_LE_PUBLIC ||
+	    la.l2_bdaddr_type == BDADDR_LE_RANDOM) {
+		/* Connection oriented channels are not supported on LE */
+		if (la.l2_psm)
+			return -EINVAL;
+		/* We only allow ATT user space socket */
+		if (la.l2_cid != L2CAP_CID_ATT)
+			return -EINVAL;
+	}
+
 	err = l2cap_chan_connect(chan, la.l2_psm, __le16_to_cpu(la.l2_cid),
 				 &la.l2_bdaddr, la.l2_bdaddr_type);
 	if (err)
-- 
1.8.3.1

