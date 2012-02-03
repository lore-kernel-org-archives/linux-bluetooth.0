Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 04/10] Bluetooth: Revert to mutexes from RCU list
Date: Fri,  3 Feb 2012 16:36:23 +0200
Message-Id: <1328279789-10870-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1328279789-10870-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328279789-10870-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Usage of RCU list looks not reasonalbe for a number of reasons:
our code sleep and we have to use socket spinlocks, some parts
of code are updaters thus we need to use mutexes anyway.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |  110 ++++++++++++++++++++++---------------------
 1 files changed, 56 insertions(+), 54 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f1a6b3c..010ef75 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -77,36 +77,24 @@ static void l2cap_send_disconn_req(struct l2cap_conn *conn,
 
 static struct l2cap_chan *__l2cap_get_chan_by_dcid(struct l2cap_conn *conn, u16 cid)
 {
-	struct l2cap_chan *c, *r = NULL;
-
-	rcu_read_lock();
+	struct l2cap_chan *c;
 
-	list_for_each_entry_rcu(c, &conn->chan_l, list) {
-		if (c->dcid == cid) {
-			r = c;
-			break;
-		}
+	list_for_each_entry(c, &conn->chan_l, list) {
+		if (c->dcid == cid)
+			return c;
 	}
-
-	rcu_read_unlock();
-	return r;
+	return NULL;
 }
 
 static struct l2cap_chan *__l2cap_get_chan_by_scid(struct l2cap_conn *conn, u16 cid)
 {
-	struct l2cap_chan *c, *r = NULL;
-
-	rcu_read_lock();
+	struct l2cap_chan *c;
 
-	list_for_each_entry_rcu(c, &conn->chan_l, list) {
-		if (c->scid == cid) {
-			r = c;
-			break;
-		}
+	list_for_each_entry(c, &conn->chan_l, list) {
+		if (c->scid == cid)
+			return c;
 	}
-
-	rcu_read_unlock();
-	return r;
+	return NULL;
 }
 
 /* Find channel with given SCID.
@@ -115,36 +103,34 @@ static struct l2cap_chan *l2cap_get_chan_by_scid(struct l2cap_conn *conn, u16 ci
 {
 	struct l2cap_chan *c;
 
+	mutex_lock(&conn->chan_lock);
 	c = __l2cap_get_chan_by_scid(conn, cid);
 	if (c)
 		lock_sock(c->sk);
+	mutex_unlock(&conn->chan_lock);
 	return c;
 }
 
 static struct l2cap_chan *__l2cap_get_chan_by_ident(struct l2cap_conn *conn, u8 ident)
 {
-	struct l2cap_chan *c, *r = NULL;
-
-	rcu_read_lock();
+	struct l2cap_chan *c;
 
-	list_for_each_entry_rcu(c, &conn->chan_l, list) {
-		if (c->ident == ident) {
-			r = c;
-			break;
-		}
+	list_for_each_entry(c, &conn->chan_l, list) {
+		if (c->ident == ident)
+			return c;
 	}
-
-	rcu_read_unlock();
-	return r;
+	return NULL;
 }
 
 static inline struct l2cap_chan *l2cap_get_chan_by_ident(struct l2cap_conn *conn, u8 ident)
 {
 	struct l2cap_chan *c;
 
+	mutex_lock(&conn->chan_lock);
 	c = __l2cap_get_chan_by_ident(conn, ident);
 	if (c)
 		lock_sock(c->sk);
+	mutex_unlock(&conn->chan_lock);
 	return c;
 }
 
@@ -259,6 +245,7 @@ static void l2cap_chan_timeout(struct work_struct *work)
 
 	BT_DBG("chan %p state %d", chan, chan->state);
 
+	mutex_lock(&chan->conn->chan_lock);
 	lock_sock(sk);
 
 	if (chan->state == BT_CONNECTED || chan->state == BT_CONFIG)
@@ -272,6 +259,7 @@ static void l2cap_chan_timeout(struct work_struct *work)
 	l2cap_chan_close(chan, reason);
 
 	release_sock(sk);
+	mutex_unlock(&chan->conn->chan_lock);
 
 	chan->ops->close(chan->data);
 	l2cap_chan_put(chan);
@@ -357,7 +345,9 @@ static void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 
 	l2cap_chan_hold(chan);
 
-	list_add_rcu(&chan->list, &conn->chan_l);
+	mutex_lock(&conn->chan_lock);
+	list_add(&chan->list, &conn->chan_l);
+	mutex_unlock(&conn->chan_lock);
 }
 
 /* Delete channel.
@@ -374,8 +364,7 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 
 	if (conn) {
 		/* Delete from channel list */
-		list_del_rcu(&chan->list);
-		synchronize_rcu();
+		list_del(&chan->list);
 
 		l2cap_chan_put(chan);
 
@@ -426,10 +415,14 @@ static void l2cap_chan_cleanup_listen(struct sock *parent)
 	/* Close not yet accepted channels */
 	while ((sk = bt_accept_dequeue(parent, NULL))) {
 		struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+
+		mutex_lock(&chan->conn->chan_lock);
 		__clear_chan_timer(chan);
 		lock_sock(sk);
 		l2cap_chan_close(chan, ECONNRESET);
 		release_sock(sk);
+		mutex_unlock(&chan->conn->chan_lock);
+
 		chan->ops->close(chan->data);
 	}
 }
@@ -743,13 +736,13 @@ static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *c
 /* ---- L2CAP connections ---- */
 static void l2cap_conn_start(struct l2cap_conn *conn)
 {
-	struct l2cap_chan *chan;
+	struct l2cap_chan *chan, *tmp;
 
 	BT_DBG("conn %p", conn);
 
-	rcu_read_lock();
+	mutex_lock(&conn->chan_lock);
 
-	list_for_each_entry_rcu(chan, &conn->chan_l, list) {
+	list_for_each_entry_safe(chan, tmp, &conn->chan_l, list) {
 		struct sock *sk = chan->sk;
 
 		bh_lock_sock(sk);
@@ -829,7 +822,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 		bh_unlock_sock(sk);
 	}
 
-	rcu_read_unlock();
+	mutex_unlock(&conn->chan_lock);
 }
 
 /* Find socket with cid and source bdaddr.
@@ -941,9 +934,9 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 	if (conn->hcon->out && conn->hcon->type == LE_LINK)
 		smp_conn_security(conn, conn->hcon->pending_sec_level);
 
-	rcu_read_lock();
+	mutex_lock(&conn->chan_lock);
 
-	list_for_each_entry_rcu(chan, &conn->chan_l, list) {
+	list_for_each_entry(chan, &conn->chan_l, list) {
 		struct sock *sk = chan->sk;
 
 		bh_lock_sock(sk);
@@ -963,7 +956,7 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 		bh_unlock_sock(sk);
 	}
 
-	rcu_read_unlock();
+	mutex_unlock(&conn->chan_lock);
 }
 
 /* Notify sockets that we cannot guaranty reliability anymore */
@@ -973,16 +966,16 @@ static void l2cap_conn_unreliable(struct l2cap_conn *conn, int err)
 
 	BT_DBG("conn %p", conn);
 
-	rcu_read_lock();
+	mutex_lock(&conn->chan_lock);
 
-	list_for_each_entry_rcu(chan, &conn->chan_l, list) {
+	list_for_each_entry(chan, &conn->chan_l, list) {
 		struct sock *sk = chan->sk;
 
 		if (test_bit(FLAG_FORCE_RELIABLE, &chan->flags))
 			sk->sk_err = err;
 	}
 
-	rcu_read_unlock();
+	mutex_unlock(&conn->chan_lock);
 }
 
 static void l2cap_info_timeout(struct work_struct *work)
@@ -1009,6 +1002,8 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 
 	kfree_skb(conn->rx_skb);
 
+	mutex_lock(&conn->chan_lock);
+
 	/* Kill channels */
 	list_for_each_entry_safe(chan, l, &conn->chan_l, list) {
 		sk = chan->sk;
@@ -1018,6 +1013,8 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 		chan->ops->close(chan->data);
 	}
 
+	mutex_unlock(&conn->chan_lock);
+
 	hci_chan_del(conn->hchan);
 
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
@@ -1075,6 +1072,7 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
 	conn->feat_mask = 0;
 
 	spin_lock_init(&conn->lock);
+	mutex_init(&conn->chan_lock);
 
 	INIT_LIST_HEAD(&conn->chan_l);
 
@@ -1815,9 +1813,9 @@ static void l2cap_raw_recv(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	BT_DBG("conn %p", conn);
 
-	rcu_read_lock();
+	mutex_lock(&conn->chan_lock);
 
-	list_for_each_entry_rcu(chan, &conn->chan_l, list) {
+	list_for_each_entry(chan, &conn->chan_l, list) {
 		struct sock *sk = chan->sk;
 		if (chan->chan_type != L2CAP_CHAN_RAW)
 			continue;
@@ -1833,7 +1831,7 @@ static void l2cap_raw_recv(struct l2cap_conn *conn, struct sk_buff *skb)
 			kfree_skb(nskb);
 	}
 
-	rcu_read_unlock();
+	mutex_unlock(&conn->chan_lock);
 }
 
 /* ---- L2CAP signalling commands ---- */
@@ -2755,6 +2753,7 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 			return -EFAULT;
 	}
 
+	mutex_lock(&conn->chan_lock);
 	sk = chan->sk;
 
 	switch (result) {
@@ -2782,6 +2781,8 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	}
 
 	release_sock(sk);
+	mutex_unlock(&conn->chan_lock);
+
 	return 0;
 }
 
@@ -3032,6 +3033,7 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn, struct l2cap_cmd
 	if (!chan)
 		return 0;
 
+	mutex_lock(&conn->chan_lock);
 	sk = chan->sk;
 
 	rsp.dcid = cpu_to_le16(chan->scid);
@@ -3042,6 +3044,7 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn, struct l2cap_cmd
 
 	l2cap_chan_del(chan, ECONNRESET);
 	release_sock(sk);
+	mutex_unlock(&conn->chan_lock);
 
 	chan->ops->close(chan->data);
 	return 0;
@@ -3063,6 +3066,7 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn, struct l2cap_cmd
 	if (!chan)
 		return 0;
 
+	mutex_lock(&conn->chan_lock);
 	sk = chan->sk;
 
 	l2cap_chan_del(chan, 0);
@@ -4514,11 +4518,9 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 		cancel_delayed_work(&conn->security_timer);
 	}
 
-	rcu_read_lock();
-
-	list_for_each_entry_rcu(chan, &conn->chan_l, list) {
-		struct sock *sk = chan->sk;
+	mutex_lock(&conn->chan_lock);
 
+	list_for_each_entry(chan, &conn->chan_l, list) {
 		bh_lock_sock(sk);
 
 		BT_DBG("chan->scid %d", chan->scid);
@@ -4596,7 +4598,7 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 		bh_unlock_sock(sk);
 	}
 
-	rcu_read_unlock();
+	mutex_unlock(&conn->chan_lock);
 
 	return 0;
 }
-- 
1.7.8.3

