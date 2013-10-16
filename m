Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 5/7] Bluetooth: Create recv_raw() channel callback
Date: Wed, 16 Oct 2013 16:08:33 -0300
Message-Id: <1381950515-25256-5-git-send-email-gustavo@padovan.org>
In-Reply-To: <1381950515-25256-1-git-send-email-gustavo@padovan.org>
References: <1381950515-25256-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

This new callback isolates socket specific code from L2CAP core.
A dummy version of the callback, l2cap_chan_no_recv_raw() is provided for
users that do not need to receive raw data.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 include/net/bluetooth/l2cap.h |  8 ++++++++
 net/bluetooth/a2mp.c          |  1 +
 net/bluetooth/l2cap_core.c    | 12 +-----------
 net/bluetooth/l2cap_sock.c    | 22 ++++++++++++++++++++++
 4 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 3d922b9..af5eb23 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -548,6 +548,8 @@ struct l2cap_ops {
 	struct l2cap_chan	*(*new_connection) (struct l2cap_chan *chan);
 	int			(*recv) (struct l2cap_chan * chan,
 					 struct sk_buff *skb);
+	int			(*recv_raw) (struct l2cap_chan * chan,
+					 struct sk_buff *skb);
 	void			(*teardown) (struct l2cap_chan *chan, int err);
 	void			(*close) (struct l2cap_chan *chan);
 	void			(*state_change) (struct l2cap_chan *chan,
@@ -785,6 +787,12 @@ static inline struct l2cap_chan *l2cap_chan_no_new_connection(struct l2cap_chan
 	return NULL;
 }
 
+static inline int l2cap_chan_no_recv_raw(struct l2cap_chan *chan,
+					 struct sk_buff *skb)
+{
+	return 0;
+}
+
 static inline void l2cap_chan_no_teardown(struct l2cap_chan *chan, int err)
 {
 }
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index efcd108..72540a7 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -707,6 +707,7 @@ static struct l2cap_ops a2mp_chan_ops = {
 
 	/* Not implemented for A2MP */
 	.new_connection = l2cap_chan_no_new_connection,
+	.recv_raw = l2cap_chan_no_recv_raw,
 	.teardown = l2cap_chan_no_teardown,
 	.ready = l2cap_chan_no_ready,
 	.defer = l2cap_chan_no_defer,
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index e30a53a..45fcf5e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -2797,7 +2797,6 @@ static void l2cap_pass_to_tx_fbit(struct l2cap_chan *chan,
 /* Copy frame to all raw sockets on that connection */
 static void l2cap_raw_recv(struct l2cap_conn *conn, struct sk_buff *skb)
 {
-	struct sk_buff *nskb;
 	struct l2cap_chan *chan;
 
 	BT_DBG("conn %p", conn);
@@ -2805,19 +2804,10 @@ static void l2cap_raw_recv(struct l2cap_conn *conn, struct sk_buff *skb)
 	mutex_lock(&conn->chan_lock);
 
 	list_for_each_entry(chan, &conn->chan_l, list) {
-		struct sock *sk = chan->sk;
 		if (chan->chan_type != L2CAP_CHAN_RAW)
 			continue;
 
-		/* Don't send frame to the socket it came from */
-		if (skb->sk == sk)
-			continue;
-		nskb = skb_clone(skb, GFP_KERNEL);
-		if (!nskb)
-			continue;
-
-		if (chan->ops->recv(chan, nskb))
-			kfree_skb(nskb);
+		chan->ops->recv_raw(chan, skb);
 	}
 
 	mutex_unlock(&conn->chan_lock);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index f5a7c66..b8be4fb 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1078,6 +1078,27 @@ done:
 	return err;
 }
 
+static int l2cap_sock_recv_raw_cb(struct l2cap_chan *chan, struct sk_buff *skb)
+{
+	struct sock *sk = chan->data;
+	struct sk_buff *nskb;
+	int err;
+
+	/* Don't send frame to the socket it came from */
+	if (skb->sk == sk)
+		return 0;
+
+	nskb = skb_clone(skb, GFP_KERNEL);
+	if (!nskb)
+		return -ENOMEM;
+
+	err = sock_queue_rcv_skb(sk, nskb);
+	if (err < 0)
+		kfree_skb(nskb);
+
+	return err;
+}
+
 static void l2cap_sock_close_cb(struct l2cap_chan *chan)
 {
 	struct sock *sk = chan->data;
@@ -1214,6 +1235,7 @@ static struct l2cap_ops l2cap_chan_ops = {
 	.name		= "L2CAP Socket Interface",
 	.new_connection	= l2cap_sock_new_connection_cb,
 	.recv		= l2cap_sock_recv_cb,
+	.recv_raw	= l2cap_sock_recv_raw_cb,
 	.close		= l2cap_sock_close_cb,
 	.teardown	= l2cap_sock_teardown_cb,
 	.state_change	= l2cap_sock_state_change_cb,
-- 
1.8.3.1

