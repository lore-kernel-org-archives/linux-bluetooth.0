Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtman.org, "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [PATCH 2/2] Bluetooth: Add Fixed Channels support to connect()
Date: Mon, 12 Jul 2010 18:19:05 -0300
Message-Id: <1278969545-26864-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1278969545-26864-1-git-send-email-gustavo@padovan.org>
References: <1278969545-26864-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo F. Padovan <padovan@profusion.mobi>

All the Fixed Channel shall be set up with SOCK_DGRAM passing the channel
id too. If you don't inform the channel id, L2CAP will use the
Connectionless channel (0x0002), which was already the default channel for
SOCK_DGRAM.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/l2cap.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 39f047b..132197e 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -229,9 +229,14 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct sock *sk, struct so
 		/* Alloc CID for connection-oriented socket */
 		l2cap_pi(sk)->scid = l2cap_alloc_cid(l);
 	} else if (sk->sk_type == SOCK_DGRAM) {
-		/* Connectionless socket */
-		l2cap_pi(sk)->scid = L2CAP_CID_CONN_LESS;
-		l2cap_pi(sk)->dcid = L2CAP_CID_CONN_LESS;
+		if (l2cap_pi(sk)->scid) {
+			/* Fixed channels */
+			l2cap_pi(sk)->dcid = l2cap_pi(sk)->scid;
+		} else {
+			/* Connectionless socket */
+			l2cap_pi(sk)->scid = L2CAP_CID_CONN_LESS;
+			l2cap_pi(sk)->dcid = L2CAP_CID_CONN_LESS;
+		}
 		l2cap_pi(sk)->omtu = L2CAP_DEFAULT_MTU;
 	} else {
 		/* Raw socket can send/recv signalling messages only */
@@ -1164,7 +1169,7 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int al
 	len = min_t(unsigned int, sizeof(la), alen);
 	memcpy(&la, addr, len);
 
-	if (la.l2_cid)
+	if (la.l2_psm && la.l2_cid)
 		return -EINVAL;
 
 	lock_sock(sk);
@@ -1213,6 +1218,7 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int al
 	/* Set destination address and psm */
 	bacpy(&bt_sk(sk)->dst, &la.l2_bdaddr);
 	l2cap_pi(sk)->psm = la.l2_psm;
+	l2cap_pi(sk)->scid = la.l2_cid;
 
 	err = l2cap_do_connect(sk);
 	if (err)
-- 
1.7.1

