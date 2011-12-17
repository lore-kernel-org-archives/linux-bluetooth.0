Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [RFC 10/22] Bluetooth: convert chan_lock to mutex
Date: Sat, 17 Dec 2011 19:29:30 -0200
Message-Id: <1324157382-1815-11-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1324157382-1815-10-git-send-email-padovan@profusion.mobi>
References: <1324157382-1815-1-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-2-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-3-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-4-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-5-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-6-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-7-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-8-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-9-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-10-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

spin lock doesn't fit ok anymore on the new code based on workqueues.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    2 +-
 net/bluetooth/l2cap_core.c    |   52 ++++++++++++++++++++--------------------
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 03be911..a175091 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -536,7 +536,7 @@ struct l2cap_conn {
 	struct smp_chan *smp_chan;
 
 	struct list_head chan_l;
-	rwlock_t	chan_lock;
+	struct mutex	chan_lock;
 };
 
 #define L2CAP_INFO_CL_MTU_REQ_SENT	0x01
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 31c94fd..5c5948f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -115,11 +115,11 @@ static struct l2cap_chan *l2cap_get_chan_by_scid(struct l2cap_conn *conn, u16 ci
 {
 	struct l2cap_chan *c;
 
-	read_lock(&conn->chan_lock);
+	mutex_lock(&conn->chan_lock);
 	c = __l2cap_get_chan_by_scid(conn, cid);
 	if (c)
 		lock_sock(c->sk);
-	read_unlock(&conn->chan_lock);
+	mutex_unlock(&conn->chan_lock);
 	return c;
 }
 
@@ -138,11 +138,11 @@ static inline struct l2cap_chan *l2cap_get_chan_by_ident(struct l2cap_conn *conn
 {
 	struct l2cap_chan *c;
 
-	read_lock(&conn->chan_lock);
+	mutex_lock(&conn->chan_lock);
 	c = __l2cap_get_chan_by_ident(conn, ident);
 	if (c)
 		lock_sock(c->sk);
-	read_unlock(&conn->chan_lock);
+	mutex_unlock(&conn->chan_lock);
 	return c;
 }
 
@@ -381,9 +381,9 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 
 	if (conn) {
 		/* Delete from channel list */
-		write_lock_bh(&conn->chan_lock);
+		mutex_lock(&conn->chan_lock);
 		list_del(&chan->list);
-		write_unlock_bh(&conn->chan_lock);
+		mutex_unlock(&conn->chan_lock);
 		chan_put(chan);
 
 		chan->conn = NULL;
@@ -754,7 +754,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 
 	BT_DBG("conn %p", conn);
 
-	read_lock(&conn->chan_lock);
+	mutex_lock(&conn->chan_lock);
 
 	list_for_each_entry_safe(chan, tmp, &conn->chan_l, list) {
 		struct sock *sk = chan->sk;
@@ -780,9 +780,9 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 					&chan->conf_state)) {
 				/* l2cap_chan_close() calls list_del(chan)
 				 * so release the lock */
-				read_unlock(&conn->chan_lock);
+				mutex_unlock(&conn->chan_lock);
 				l2cap_chan_close(chan, ECONNRESET);
-				read_lock(&conn->chan_lock);
+				utex_lock(&conn->chan_lock);
 				bh_unlock_sock(sk);
 				continue;
 			}
@@ -838,7 +838,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 		bh_unlock_sock(sk);
 	}
 
-	read_unlock(&conn->chan_lock);
+	mutex_unlock(&conn->chan_lock);
 }
 
 /* Find socket with cid and source bdaddr.
@@ -903,7 +903,7 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 
 	sk = chan->sk;
 
-	write_lock_bh(&conn->chan_lock);
+	mutex_lock(&conn->chan_lock);
 
 	hci_conn_hold(conn->hcon);
 
@@ -919,7 +919,7 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 	l2cap_state_change(chan, BT_CONNECTED);
 	parent->sk_data_ready(parent, 0);
 
-	write_unlock_bh(&conn->chan_lock);
+	mutex_unlock(&conn->chan_lock);
 
 clean:
 	release_sock(parent);
@@ -954,7 +954,7 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 	if (conn->hcon->out && conn->hcon->type == LE_LINK)
 		smp_conn_security(conn, conn->hcon->pending_sec_level);
 
-	read_lock(&conn->chan_lock);
+	mutex_lock(&conn->chan_lock);
 
 	list_for_each_entry(chan, &conn->chan_l, list) {
 		struct sock *sk = chan->sk;
@@ -976,7 +976,7 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 		bh_unlock_sock(sk);
 	}
 
-	read_unlock(&conn->chan_lock);
+	mutex_unlock(&conn->chan_lock);
 }
 
 /* Notify sockets that we cannot guaranty reliability anymore */
@@ -986,7 +986,7 @@ static void l2cap_conn_unreliable(struct l2cap_conn *conn, int err)
 
 	BT_DBG("conn %p", conn);
 
-	read_lock(&conn->chan_lock);
+	mutex_lock(&conn->chan_lock);
 
 	list_for_each_entry(chan, &conn->chan_l, list) {
 		struct sock *sk = chan->sk;
@@ -995,7 +995,7 @@ static void l2cap_conn_unreliable(struct l2cap_conn *conn, int err)
 			sk->sk_err = err;
 	}
 
-	read_unlock(&conn->chan_lock);
+	mutex_unlock(&conn->chan_lock);
 }
 
 static void l2cap_info_timeout(unsigned long arg)
@@ -1086,7 +1086,7 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
 	conn->feat_mask = 0;
 
 	spin_lock_init(&conn->lock);
-	rwlock_init(&conn->chan_lock);
+	mutex_init(&conn->chan_lock);
 
 	INIT_LIST_HEAD(&conn->chan_l);
 
@@ -1104,9 +1104,9 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
 
 static inline void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 {
-	write_lock_bh(&conn->chan_lock);
+	mutex_lock(&conn->chan_lock);
 	__l2cap_chan_add(conn, chan);
-	write_unlock_bh(&conn->chan_lock);
+	mutex_unlock(&conn->chan_lock);
 }
 
 /* ---- Socket interface ---- */
@@ -1771,7 +1771,7 @@ static void l2cap_raw_recv(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	BT_DBG("conn %p", conn);
 
-	read_lock(&conn->chan_lock);
+	mutex_lock(&conn->chan_lock);
 	list_for_each_entry(chan, &conn->chan_l, list) {
 		struct sock *sk = chan->sk;
 		if (chan->chan_type != L2CAP_CHAN_RAW)
@@ -1787,7 +1787,7 @@ static void l2cap_raw_recv(struct l2cap_conn *conn, struct sk_buff *skb)
 		if (chan->ops->recv(chan->data, nskb))
 			kfree_skb(nskb);
 	}
-	read_unlock(&conn->chan_lock);
+	mutex_unlock(&conn->chan_lock);
 }
 
 /* ---- L2CAP signalling commands ---- */
@@ -2587,11 +2587,11 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 
 	sk = chan->sk;
 
-	write_lock_bh(&conn->chan_lock);
+	mutex_lock(&conn->chan_lock);
 
 	/* Check if we already have channel with that dcid */
 	if (__l2cap_get_chan_by_dcid(conn, scid)) {
-		write_unlock_bh(&conn->chan_lock);
+		mutex_unlock(&conn->chan_lock);
 		sock_set_flag(sk, SOCK_ZAPPED);
 		chan->ops->close(chan->data);
 		goto response;
@@ -2637,7 +2637,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 		status = L2CAP_CS_NO_INFO;
 	}
 
-	write_unlock_bh(&conn->chan_lock);
+	mutex_unlock(&conn->chan_lock);
 
 response:
 	release_sock(parent);
@@ -4474,7 +4474,7 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 		del_timer(&conn->security_timer);
 	}
 
-	read_lock(&conn->chan_lock);
+	mutex_lock(&conn->chan_lock);
 
 	list_for_each_entry(chan, &conn->chan_l, list) {
 		struct sock *sk = chan->sk;
@@ -4554,7 +4554,7 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 		bh_unlock_sock(sk);
 	}
 
-	read_unlock(&conn->chan_lock);
+	mutex_unlock(&conn->chan_lock);
 
 	return 0;
 }
-- 
1.7.6.4

