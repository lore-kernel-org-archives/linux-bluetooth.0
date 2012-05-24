Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [RFC 3/8] Bluetooth: Add l2cap_chan->ops->ready()
Date: Wed, 23 May 2012 22:12:39 -0300
Message-Id: <1337821964-4618-4-git-send-email-gustavo@padovan.org>
In-Reply-To: <1337821964-4618-3-git-send-email-gustavo@padovan.org>
References: <1337821964-4618-1-git-send-email-gustavo@padovan.org>
 <1337821964-4618-2-git-send-email-gustavo@padovan.org>
 <1337821964-4618-3-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

This move socket specific code to l2cap_sock.c.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/l2cap_core.c    |   18 +++---------------
 net/bluetooth/l2cap_sock.c    |   21 +++++++++++++++++++++
 3 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 29f7b06..d1f6819 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -530,6 +530,7 @@ struct l2cap_ops {
 	void			(*state_change) (void *data, int state);
 	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
 					       unsigned long len, int nb);
+	void			(*ready) (void *data);
 };
 
 struct l2cap_conn {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f77b134..7d671ad 100644
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
-
-	if (parent)
-		parent->sk_data_ready(parent, 0);
+	chan->state = BT_CONNECTED;
 
-	release_sock(sk);
+	if (chan->ops->ready)
+		chan->ops->ready(chan->data);
 }
 
 static void l2cap_do_start(struct l2cap_chan *chan)
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 0302cb4..8a3620b 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1016,6 +1016,26 @@ static struct sk_buff *l2cap_sock_alloc_skb_cb(struct l2cap_chan *chan,
 	return skb;
 }
 
+static void l2cap_sock_ready_cb(void *data)
+{
+	struct sock *sk = data;
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
@@ -1024,6 +1044,7 @@ static struct l2cap_ops l2cap_chan_ops = {
 	.finalize	= l2cap_sock_finalize_cb,
 	.state_change	= l2cap_sock_state_change_cb,
 	.alloc_skb	= l2cap_sock_alloc_skb_cb,
+	.ready		= l2cap_sock_ready_cb,
 };
 
 static void l2cap_sock_destruct(struct sock *sk)
-- 
1.7.10.1

