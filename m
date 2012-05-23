Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 01/19] Bluetooth: Add unlink to L2CAP channel ops
Date: Wed, 23 May 2012 18:37:07 +0300
Message-Id: <1337787445-23235-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1337787445-23235-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1337351150-20526-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1337787445-23235-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This helps to separate socket and socketless code. Now socket related
operations moved to l2cap_sock in unlink callback for channels with sk.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/l2cap_core.c    |   19 ++-----------------
 net/bluetooth/l2cap_sock.c    |   25 +++++++++++++++++++++++++
 3 files changed, 28 insertions(+), 17 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 0142257..a017249 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -529,6 +529,7 @@ struct l2cap_ops {
 	void			(*state_change) (void *data, int state);
 	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
 					       unsigned long len, int nb);
+	void			(*unlink) (struct l2cap_chan *chan, int err);
 };
 
 struct l2cap_conn {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index e31b005..c81b828 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -493,9 +493,7 @@ static void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 
 static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 {
-	struct sock *sk = chan->sk;
 	struct l2cap_conn *conn = chan->conn;
-	struct sock *parent = bt_sk(sk)->parent;
 
 	__clear_chan_timer(chan);
 
@@ -511,21 +509,8 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 		hci_conn_put(conn->hcon);
 	}
 
-	lock_sock(sk);
-
-	__l2cap_state_change(chan, BT_CLOSED);
-	sock_set_flag(sk, SOCK_ZAPPED);
-
-	if (err)
-		__l2cap_chan_set_err(chan, err);
-
-	if (parent) {
-		bt_accept_unlink(sk);
-		parent->sk_data_ready(parent, 0);
-	} else
-		sk->sk_state_change(sk);
-
-	release_sock(sk);
+	if (chan->ops->unlink)
+		chan->ops->unlink(chan, err);
 
 	if (test_bit(CONF_NOT_COMPLETE, &chan->conf_state))
 		return;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 4d36605..6749d11 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -954,6 +954,30 @@ static struct sk_buff *l2cap_sock_alloc_skb_cb(struct l2cap_chan *chan,
 	return skb;
 }
 
+static void l2cap_sock_unlink_cb(struct l2cap_chan *chan, int err)
+{
+	struct sock *sk = chan->sk;
+	struct sock *parent = bt_sk(sk)->parent;
+
+	lock_sock(sk);
+
+	chan->state = BT_CLOSED;
+	sk->sk_state = BT_CLOSED;
+	sock_set_flag(sk, SOCK_ZAPPED);
+
+	if (err)
+		sk->sk_err = err;
+
+	parent = bt_sk(sk)->parent;
+	if (parent) {
+		bt_accept_unlink(sk);
+		parent->sk_data_ready(parent, 0);
+	} else
+		sk->sk_state_change(sk);
+
+	release_sock(sk);
+}
+
 static struct l2cap_ops l2cap_chan_ops = {
 	.name		= "L2CAP Socket Interface",
 	.new_connection	= l2cap_sock_new_connection_cb,
@@ -961,6 +985,7 @@ static struct l2cap_ops l2cap_chan_ops = {
 	.close		= l2cap_sock_close_cb,
 	.state_change	= l2cap_sock_state_change_cb,
 	.alloc_skb	= l2cap_sock_alloc_skb_cb,
+	.unlink		= l2cap_sock_unlink_cb,
 };
 
 static void l2cap_sock_destruct(struct sock *sk)
-- 
1.7.9.5

