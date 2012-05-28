Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Subject: [PATCH -v3 03/10] Bluetooth: Add l2cap_chan->ops->ready()
Date: Sun, 27 May 2012 22:27:53 -0300
Message-Id: <1338168480-9646-3-git-send-email-gustavo@padovan.org>
In-Reply-To: <1338168480-9646-1-git-send-email-gustavo@padovan.org>
References: <1338168480-9646-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This move socket specific code to l2cap_sock.c.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/l2cap_core.c    |   18 +++---------------
 net/bluetooth/l2cap_sock.c    |   21 +++++++++++++++++++++
 3 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 76b0e7e..c5726c2 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -534,6 +534,7 @@ struct l2cap_ops {
 	void			(*close) (struct l2cap_chan *chan);
 	void			(*state_change) (struct l2cap_chan *chan,
 						 int state);
+	void			(*ready) (struct l2cap_chan *chan);
 	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
 					       unsigned long len, int nb);
 };
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 1f4c720..5947eb1 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -931,26 +931,14 @@ static void l2cap_send_conn_req(struct l2cap_chan *chan)
 
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
-
 	/* This clears all conf flags, including CONF_NOT_COMPLETE */
 	chan->conf_state = 0;
 	__clear_chan_timer(chan);
 
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
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 3f59463..5563023 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1014,6 +1014,26 @@ static struct sk_buff *l2cap_sock_alloc_skb_cb(struct l2cap_chan *chan,
 	return skb;
 }
 
+static void l2cap_sock_ready_cb(struct l2cap_chan *chan)
+{
+	struct sock *sk = chan->data;
+	struct sock *parent;
+
+	lock_sock(sk);
+
+	parent = bt_sk(sk)->parent;
+
+	BT_DBG("sk %p, parent %p", sk, parent);
+
+	sk->sk_state = BT_CONNECTED;
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
@@ -1021,6 +1041,7 @@ static struct l2cap_ops l2cap_chan_ops = {
 	.close		= l2cap_sock_close_cb,
 	.teardown	= l2cap_sock_teardown_cb,
 	.state_change	= l2cap_sock_state_change_cb,
+	.ready		= l2cap_sock_ready_cb,
 	.alloc_skb	= l2cap_sock_alloc_skb_cb,
 };
 
-- 
1.7.10.2

