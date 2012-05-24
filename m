Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 02/12] Bluetooth: Move clean up code and set of SOCK_ZAPPED to l2cap_sock.c
Date: Thu, 24 May 2012 19:59:42 -0300
Message-Id: <1337900389-30915-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1337900389-30915-1-git-send-email-gustavo@padovan.org>
References: <1337900389-30915-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

This remove a bit more of socket code from l2cap core, this calls set the
SOCK_ZAPPED and do some clean up depending on the socket state.

Reported-by: Mat Martineau <mathewm@codeaurora.org>
Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/l2cap_core.c    |   55 ++++++-----------------------------
 net/bluetooth/l2cap_sock.c    |   63 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 46 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 0142257..be3ce5a 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -526,6 +526,7 @@ struct l2cap_ops {
 	struct l2cap_chan	*(*new_connection) (void *data);
 	int			(*recv) (void *data, struct sk_buff *skb);
 	void			(*close) (void *data);
+	void			(*teardown) (void *data, int err);
 	void			(*state_change) (void *data, int state);
 	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
 					       unsigned long len, int nb);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b9c39f6..9f5fc4f 100644
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
+		chan->ops->teardown(chan->data, err);
 
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
-		chan->ops->close(chan->data);
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
+			chan->ops->teardown(chan->data, 0);
 		break;
 
 	case BT_CONNECTED:
@@ -630,9 +592,8 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
 		break;
 
 	default:
-		lock_sock(sk);
-		sock_set_flag(sk, SOCK_ZAPPED);
-		release_sock(sk);
+		if (chan->ops->teardown)
+			chan->ops->teardown(chan->data, 0);
 		break;
 	}
 }
@@ -3416,7 +3377,9 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 
 	/* Check if we already have channel with that dcid */
 	if (__l2cap_get_chan_by_dcid(conn, scid)) {
-		sock_set_flag(sk, SOCK_ZAPPED);
+		if (chan->ops->teardown)
+			chan->ops->teardown(chan->data, 0);
+
 		chan->ops->close(chan->data);
 		goto response;
 	}
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 4d36605..c5a1b57 100644
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
 static struct l2cap_chan *l2cap_sock_new_connection_cb(void *data)
 {
 	struct sock *sk, *parent = data;
@@ -931,6 +950,49 @@ static void l2cap_sock_close_cb(void *data)
 	l2cap_sock_kill(sk);
 }
 
+static void l2cap_sock_teardown_cb(void *data, int err)
+{
+	struct sock *sk = data;
+	struct sock *parent;
+	struct l2cap_chan *chan;
+
+	lock_sock(sk);
+
+	parent = bt_sk(sk)->parent;
+	chan = l2cap_pi(sk)->chan;
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
 static void l2cap_sock_state_change_cb(void *data, int state)
 {
 	struct sock *sk = data;
@@ -959,6 +1021,7 @@ static struct l2cap_ops l2cap_chan_ops = {
 	.new_connection	= l2cap_sock_new_connection_cb,
 	.recv		= l2cap_sock_recv_cb,
 	.close		= l2cap_sock_close_cb,
+	.teardown	= l2cap_sock_teardown_cb,
 	.state_change	= l2cap_sock_state_change_cb,
 	.alloc_skb	= l2cap_sock_alloc_skb_cb,
 };
-- 
1.7.10.1

