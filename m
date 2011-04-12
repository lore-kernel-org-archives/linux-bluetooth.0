Return-Path: <cyrus@holtmann.org>
From: Anderson Briglia <anderson.briglia@openbossa.org>
To: linux-bluetooth@vger.kernel.org,
	ville.tervo@nokia.com,
	johan.hedberg@gmail.com,
	marcel@holtmann.org
Cc: Anderson Briglia <anderson.briglia@openbossa.org>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH] Bluetooth: MTU configuration for LE links
Date: Mon, 11 Apr 2011 20:12:38 -0400
Message-Id: <1302567158-18617-2-git-send-email-anderson.briglia@openbossa.org>
In-Reply-To: <anderson.briglia@openbossa.org>
References: <anderson.briglia@openbossa.org>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch implements MTU configuration for LE links. The previous
implementation was setting the MTU as a fixed value.

Signed-off-by: Anderson Briglia <anderson.briglia@openbossa.org>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/l2cap_core.c |    6 +++++-
 net/bluetooth/l2cap_sock.c |   18 ++++++++++++++++--
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index be6c5aa..4a8b388 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -177,7 +177,11 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 	if (sk->sk_type == SOCK_SEQPACKET || sk->sk_type == SOCK_STREAM) {
 		if (conn->hcon->type == LE_LINK) {
 			/* LE connection */
-			l2cap_pi(sk)->omtu = L2CAP_LE_DEFAULT_MTU;
+			if (l2cap_pi(sk)->imtu < L2CAP_LE_DEFAULT_MTU)
+				l2cap_pi(sk)->imtu = L2CAP_LE_DEFAULT_MTU;
+			if (l2cap_pi(sk)->omtu < L2CAP_LE_DEFAULT_MTU)
+				l2cap_pi(sk)->omtu = L2CAP_LE_DEFAULT_MTU;
+
 			l2cap_pi(sk)->scid = L2CAP_CID_LE_DATA;
 			l2cap_pi(sk)->dcid = L2CAP_CID_LE_DATA;
 		} else {
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 0059dda..b5796fd 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -530,16 +530,18 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __us
 {
 	struct sock *sk = sock->sk;
 	struct l2cap_options opts;
-	int len, err = 0;
+	int len, le_sock, err = 0;
 	u32 opt;
 
 	BT_DBG("sk %p", sk);
 
 	lock_sock(sk);
 
+	le_sock = l2cap_pi(sk)->scid == L2CAP_CID_LE_DATA;
+
 	switch (optname) {
 	case L2CAP_OPTIONS:
-		if (sk->sk_state == BT_CONNECTED) {
+		if (sk->sk_state == BT_CONNECTED && !le_sock) {
 			err = -EINVAL;
 			break;
 		}
@@ -558,6 +560,18 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __us
 			break;
 		}
 
+		if ((opts.imtu || opts.omtu) && le_sock &&
+				(sk->sk_state == BT_CONNECTED)) {
+			if (opts.imtu >= L2CAP_LE_DEFAULT_MTU)
+				l2cap_pi(sk)->imtu = opts.imtu;
+			if (opts.omtu >= L2CAP_LE_DEFAULT_MTU)
+				l2cap_pi(sk)->omtu = opts.omtu;
+			if (opts.imtu < L2CAP_LE_DEFAULT_MTU ||
+					opts.omtu < L2CAP_LE_DEFAULT_MTU)
+				err = -EINVAL;
+			break;
+		}
+
 		if (opts.txwin_size > L2CAP_DEFAULT_TX_WINDOW) {
 			err = -EINVAL;
 			break;
-- 
1.7.1
