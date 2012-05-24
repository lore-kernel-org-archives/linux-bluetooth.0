Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 01/18] Bluetooth: Add ready to L2CAP channel ops
Date: Thu, 24 May 2012 14:38:11 +0300
Message-Id: <1337859508-32274-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1337859508-32274-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1337351150-20526-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1337859508-32274-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Addings ops->ready() helps to separate socket and socketless
L2CAP channels.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/l2cap_core.c    |   23 +++++------------------
 net/bluetooth/l2cap_sock.c    |   22 ++++++++++++++++++++++
 3 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index a017249..83a67e8 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -530,6 +530,7 @@ struct l2cap_ops {
 	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
 					       unsigned long len, int nb);
 	void			(*unlink) (struct l2cap_chan *chan, int err);
+	void			(*ready) (struct l2cap_chan *chan);
 };
 
 struct l2cap_conn {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 8ca6e8f..16ec122 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -407,7 +407,7 @@ struct l2cap_chan *l2cap_chan_create(void)
 
 	atomic_set(&chan->refcnt, 1);
 
-	/* This flag is cleared in l2cap_chan_ready() */
+	/* This flag is cleared in l2cap chan ops->ready() */
 	set_bit(CONF_NOT_COMPLETE, &chan->conf_state);
 
 	BT_DBG("chan %p", chan);
@@ -955,26 +955,14 @@ static void l2cap_send_conn_req(struct l2cap_chan *chan)
 
 static void l2cap_chan_ready(struct l2cap_chan *chan)
 {
-	struct sock *sk = chan->sk;
-	struct sock *parent;
-
-	lock_sock(sk);
-
-	parent = bt_sk(sk)->parent;
-
-	BT_DBG("sk %p, parent %p", sk, parent);
+	__clear_chan_timer(chan);
 
 	/* This clears all conf flags, including CONF_NOT_COMPLETE */
 	chan->conf_state = 0;
-	__clear_chan_timer(chan);
-
-	__l2cap_state_change(chan, BT_CONNECTED);
-	sk->sk_state_change(sk);
+	chan->state = BT_CONNECTED;
 
-	if (parent)
-		parent->sk_data_ready(parent, 0);
-
-	release_sock(sk);
+	if (chan->ops->ready)
+		chan->ops->ready(chan);
 }
 
 static void l2cap_do_start(struct l2cap_chan *chan)
@@ -1243,7 +1231,6 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 		if (conn->hcon->type == LE_LINK) {
 			if (smp_conn_security(conn, chan->sec_level))
 				l2cap_chan_ready(chan);
-
 		} else if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
 			struct sock *sk = chan->sk;
 			__clear_chan_timer(chan);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 6749d11..3d97b58 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -978,6 +978,27 @@ static void l2cap_sock_unlink_cb(struct l2cap_chan *chan, int err)
 	release_sock(sk);
 }
 
+static void l2cap_sock_chan_ready_cb(struct l2cap_chan *chan)
+{
+	struct sock *sk = chan->sk;
+	struct sock *parent;
+
+	lock_sock(sk);
+
+	parent = bt_sk(sk)->parent;
+
+	BT_DBG("sk %p, parent %p", sk, parent);
+
+	sk->sk_state = BT_CONNECTED;
+
+	sk->sk_state_change(sk);
+
+	if (parent)
+		parent->sk_data_ready(parent, 0);
+
+	release_sock(sk);
+}
+
 static struct l2cap_ops l2cap_chan_ops = {
 	.name		= "L2CAP Socket Interface",
 	.new_connection	= l2cap_sock_new_connection_cb,
@@ -986,6 +1007,7 @@ static struct l2cap_ops l2cap_chan_ops = {
 	.state_change	= l2cap_sock_state_change_cb,
 	.alloc_skb	= l2cap_sock_alloc_skb_cb,
 	.unlink		= l2cap_sock_unlink_cb,
+	.ready		= l2cap_sock_chan_ready_cb,
 };
 
 static void l2cap_sock_destruct(struct sock *sk)
-- 
1.7.9.5

