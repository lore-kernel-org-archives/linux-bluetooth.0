Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Reject invalid bdaddr types for sockets
Date: Mon, 14 Oct 2013 21:17:52 +0300
Message-Id: <1381774673-14150-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We need to verify that the bdaddr type passed to connect() and bind() is
within the set of valid values. If it is not we need to cleanly fail
with EINVAL.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_sock.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index f1b462f..982915d 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -69,6 +69,9 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 	if (la.l2_cid && la.l2_psm)
 		return -EINVAL;
 
+	if (!bdaddr_type_is_valid(la.l2_bdaddr_type))
+		return -EINVAL;
+
 	lock_sock(sk);
 
 	if (sk->sk_state != BT_OPEN) {
@@ -144,6 +147,9 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr,
 	if (la.l2_cid && la.l2_psm)
 		return -EINVAL;
 
+	if (!bdaddr_type_is_valid(la.l2_bdaddr_type))
+		return -EINVAL;
+
 	err = l2cap_chan_connect(chan, la.l2_psm, __le16_to_cpu(la.l2_cid),
 				 &la.l2_bdaddr, la.l2_bdaddr_type);
 	if (err)
-- 
1.8.3.1

