Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Subject: [PATCH -v3 02/10] Bluetooth: Move clean up code and set of SOCK_ZAPPED to l2cap_sock.c
Date: Sun, 27 May 2012 22:27:52 -0300
Message-Id: <1338168480-9646-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1338168480-9646-1-git-send-email-gustavo@padovan.org>
References: <1338168480-9646-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This remove a bit more of socket code from l2cap core, this calls set the
SOCK_ZAPPED and do some clean up depending on the socket state.

Reported-by: Mat Martineau <mathewm@codeaurora.org>
Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/l2cap_core.c    |   55 ++++++-------------------------------
 net/bluetooth/l2cap_sock.c    |   61 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+), 46 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index aa2dbc6..76b0e7e 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -530,6 +530,7 @@ struct l2cap_ops {
 	struct l2cap_chan	*(*new_connection) (struct l2cap_chan *chan);
 	int			(*recv) (struct l2cap_chan * chan,
 					 struct sk_buff *skb);
+	void			(*teardown) (struct l2cap_chan *chan, int err);
 	void			(*close) (struct l2cap_chan *chan);
 	void			(*state_change) (struct l2cap_chan *chan,
 						 int state);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7edc814..1f4c720 100644
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
+	if (chan->ops->teardown)
+		chan->ops->teardown(chan, err);
 
 	if (test_bit(CONF_NOT_COMPLETE, &chan->conf_state))
 		return;
@@ -554,25 +539,6 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 	return;
 }
 
-static void l2cap_chan_cleanup_listen(struct sock *parent)
-{
-	struct sock *sk;
-
-	BT_DBG("parent %p", parent);
-
-	/* Close not yet accepted channels */
-	while ((sk = bt_accept_dequeue(parent, NULL))) {
-		struct l2cap_chan *chan = l2cap_pi(sk)->chan;
-
-		l2cap_chan_lock(chan);
-		__clear_chan_timer(chan);
-		l2cap_chan_close(chan, ECONNRESET);
-		l2cap_chan_unlock(chan);
-
-		chan->ops->close(chan);
-	}
-}
-
 void l2cap_chan_close(struct l2cap_chan *chan, int reason)
 {
 	struct l2cap_conn *conn = chan->conn;
@@ -583,12 +549,8 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
 
 	switch (chan->state) {
 	case BT_LISTEN:
-		lock_sock(sk);
-		l2cap_chan_cleanup_listen(sk);
-
-		__l2cap_state_change(chan, BT_CLOSED);
-		sock_set_flag(sk, SOCK_ZAPPED);
-		release_sock(sk);
+		if (chan->ops->teardown)
+			chan->ops->teardown(chan, 0);
 		break;
 
 	case BT_CONNECTED:
@@ -630,9 +592,8 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
 		break;
 
 	default:
-		lock_sock(sk);
-		sock_set_flag(sk, SOCK_ZAPPED);
-		release_sock(sk);
+		if (chan->ops->teardown)
+			chan->ops->teardown(chan, 0);
 		break;
 	}
 }
@@ -3419,7 +3380,9 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 
 	/* Check if we already have channel with that dcid */
 	if (__l2cap_get_chan_by_dcid(conn, scid)) {
-		sock_set_flag(sk, SOCK_ZAPPED);
+		if (chan->ops->teardown)
+			chan->ops->teardown(chan, 0);
+
 		chan->ops->close(chan);
 		goto response;
 	}
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index db787f6..3f59463 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -872,6 +872,25 @@ static int l2cap_sock_release(struct socket *sock)
 	return err;
 }
 
+static void l2cap_sock_cleanup_listen(struct sock *parent)
+{
+	struct sock *sk;
+
+	BT_DBG("parent %p", parent);
+
+	/* Close not yet accepted channels */
+	while ((sk = bt_accept_dequeue(parent, NULL))) {
+		struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+
+		l2cap_chan_lock(chan);
+		__clear_chan_timer(chan);
+		l2cap_chan_close(chan, ECONNRESET);
+		l2cap_chan_unlock(chan);
+
+		l2cap_sock_kill(sk);
+	}
+}
+
 static struct l2cap_chan *l2cap_sock_new_connection_cb(struct l2cap_chan *chan)
 {
 	struct sock *sk, *parent = chan->data;
@@ -931,6 +950,47 @@ static void l2cap_sock_close_cb(struct l2cap_chan *chan)
 	l2cap_sock_kill(sk);
 }
 
+static void l2cap_sock_teardown_cb(struct l2cap_chan *chan, int err)
+{
+	struct sock *sk = chan->data;
+	struct sock *parent;
+
+	lock_sock(sk);
+
+	parent = bt_sk(sk)->parent;
+
+	sock_set_flag(sk, SOCK_ZAPPED);
+
+	switch (chan->state) {
+	case BT_OPEN:
+	case BT_BOUND:
+	case BT_CLOSED:
+		break;
+	case BT_LISTEN:
+		l2cap_sock_cleanup_listen(sk);
+		sk->sk_state = BT_CLOSED;
+		chan->state = BT_CLOSED;
+
+		break;
+	default:
+		sk->sk_state = BT_CLOSED;
+		chan->state = BT_CLOSED;
+
+		sk->sk_err = err;
+
+		if (parent) {
+			bt_accept_unlink(sk);
+			parent->sk_data_ready(parent, 0);
+		} else {
+			sk->sk_state_change(sk);
+		}
+
+		break;
+	}
+
+	release_sock(sk);
+}
+
 static void l2cap_sock_state_change_cb(struct l2cap_chan *chan, int state)
 {
 	struct sock *sk = chan->data;
@@ -959,6 +1019,7 @@ static struct l2cap_ops l2cap_chan_ops = {
 	.new_connection	= l2cap_sock_new_connection_cb,
 	.recv		= l2cap_sock_recv_cb,
 	.close		= l2cap_sock_close_cb,
+	.teardown	= l2cap_sock_teardown_cb,
 	.state_change	= l2cap_sock_state_change_cb,
 	.alloc_skb	= l2cap_sock_alloc_skb_cb,
 };
-- 
1.7.10.2

