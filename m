Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 02/15] Bluetooth: Use struct list_head for L2CAP channels list
Date: Fri,  1 Apr 2011 19:33:07 -0300
Message-Id: <1301697200-2446-3-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1301697200-2446-2-git-send-email-padovan@profusion.mobi>
References: <1301697200-2446-1-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-2-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use a well known Kernel API is always a good idea than implement your own
list.
In the future we might use RCU on this list.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |   12 +--
 net/bluetooth/l2cap_core.c    |  195 +++++++++++++++++++----------------------
 2 files changed, 93 insertions(+), 114 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 6378bcc..ddf4bc5 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -277,16 +277,9 @@ struct l2cap_conn_param_update_rsp {
 #define L2CAP_CONN_PARAM_REJECTED	0x0001
 
 /* ----- L2CAP channels and connections ----- */
-
 struct l2cap_chan {
 	struct sock *sk;
-	struct l2cap_chan	*next_c;
-	struct l2cap_chan	*prev_c;
-};
-
-struct l2cap_chan_list {
-	struct l2cap_chan *head;
-	rwlock_t	lock;
+	struct list_head list;
 };
 
 struct l2cap_conn {
@@ -312,7 +305,8 @@ struct l2cap_conn {
 
 	__u8		disc_reason;
 
-	struct l2cap_chan_list chan_list;
+	struct list_head chan_l;
+	rwlock_t	chan_lock;
 };
 
 struct sock_del_list {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index e49d8f7..ce68896 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -74,66 +74,75 @@ static struct sk_buff *l2cap_build_cmd(struct l2cap_conn *conn,
 static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb);
 
 /* ---- L2CAP channels ---- */
-static struct l2cap_chan *__l2cap_get_chan_by_dcid(struct l2cap_chan_list *l, u16 cid)
+static struct l2cap_chan *__l2cap_get_chan_by_dcid(struct l2cap_conn *conn, u16 cid)
 {
 	struct l2cap_chan *c;
-	for (c = l->head; c; c = c->next_c) {
-		if (l2cap_pi(c->sk)->dcid == cid)
-			break;
+
+	list_for_each_entry(c, &conn->chan_l, list) {
+		struct sock *s = c->sk;
+		if (l2cap_pi(s)->dcid == cid)
+			return c;
 	}
-	return c;
+	return NULL;
+
 }
 
-static struct l2cap_chan *__l2cap_get_chan_by_scid(struct l2cap_chan_list *l, u16 cid)
+static struct l2cap_chan *__l2cap_get_chan_by_scid(struct l2cap_conn *conn, u16 cid)
 {
 	struct l2cap_chan *c;
-	for (c = l->head; c; c = c->next_c) {
-		if (l2cap_pi(c->sk)->scid == cid)
-			break;
+
+	list_for_each_entry(c, &conn->chan_l, list) {
+		struct sock *s = c->sk;
+		if (l2cap_pi(s)->scid == cid)
+			return c;
 	}
-	return c;
+	return NULL;
 }
 
 /* Find channel with given SCID.
  * Returns locked socket */
-static inline struct l2cap_chan *l2cap_get_chan_by_scid(struct l2cap_chan_list *l, u16 cid)
+static struct l2cap_chan *l2cap_get_chan_by_scid(struct l2cap_conn *conn, u16 cid)
 {
 	struct l2cap_chan *c;
-	read_lock(&l->lock);
-	c = __l2cap_get_chan_by_scid(l, cid);
+
+	read_lock(&conn->chan_lock);
+	c = __l2cap_get_chan_by_scid(conn, cid);
 	if (c)
 		bh_lock_sock(c->sk);
-	read_unlock(&l->lock);
+	read_unlock(&conn->chan_lock);
 	return c;
 }
 
-static struct l2cap_chan *__l2cap_get_chan_by_ident(struct l2cap_chan_list *l, u8 ident)
+static struct l2cap_chan *__l2cap_get_chan_by_ident(struct l2cap_conn *conn, u8 ident)
 {
 	struct l2cap_chan *c;
-	for (c = l->head; c; c = c->next_c) {
-		if (l2cap_pi(c->sk)->ident == ident)
-			break;
+
+	list_for_each_entry(c, &conn->chan_l, list) {
+		struct sock *s = c->sk;
+		if (l2cap_pi(s)->ident == ident)
+			return c;
 	}
-	return c;
+	return NULL;
 }
 
-static inline struct l2cap_chan *l2cap_get_chan_by_ident(struct l2cap_chan_list *l, u8 ident)
+static inline struct l2cap_chan *l2cap_get_chan_by_ident(struct l2cap_conn *conn, u8 ident)
 {
 	struct l2cap_chan *c;
-	read_lock(&l->lock);
-	c = __l2cap_get_chan_by_ident(l, ident);
+
+	read_lock(&conn->chan_lock);
+	c = __l2cap_get_chan_by_ident(conn, ident);
 	if (c)
 		bh_lock_sock(c->sk);
-	read_unlock(&l->lock);
+	read_unlock(&conn->chan_lock);
 	return c;
 }
 
-static u16 l2cap_alloc_cid(struct l2cap_chan_list *l)
+static u16 l2cap_alloc_cid(struct l2cap_conn *conn)
 {
 	u16 cid = L2CAP_CID_DYN_START;
 
 	for (; cid < L2CAP_CID_DYN_END; cid++) {
-		if (!__l2cap_get_chan_by_scid(l, cid))
+		if (!__l2cap_get_chan_by_scid(conn, cid))
 			return cid;
 	}
 
@@ -153,38 +162,8 @@ static struct l2cap_chan *l2cap_chan_alloc(struct sock *sk)
 	return chan;
 }
 
-static inline void __l2cap_chan_link(struct l2cap_chan_list *l, struct l2cap_chan *chan)
-{
-	sock_hold(chan->sk);
-
-	if (l->head)
-		l->head->prev_c = chan;
-
-	chan->next_c = l->head;
-	chan->prev_c = NULL;
-	l->head = chan;
-}
-
-static inline void l2cap_chan_unlink(struct l2cap_chan_list *l, struct l2cap_chan *chan)
-{
-	struct l2cap_chan *next = chan->next_c, *prev = chan->prev_c;
-
-	write_lock_bh(&l->lock);
-	if (chan == l->head)
-		l->head = next;
-
-	if (next)
-		next->prev_c = prev;
-	if (prev)
-		prev->next_c = next;
-	write_unlock_bh(&l->lock);
-
-	__sock_put(chan->sk);
-}
-
 static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 {
-	struct l2cap_chan_list *l = &conn->chan_list;
 	struct sock *sk = chan->sk;
 
 	BT_DBG("conn %p, psm 0x%2.2x, dcid 0x%4.4x", conn,
@@ -202,7 +181,7 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 			l2cap_pi(sk)->dcid = L2CAP_CID_LE_DATA;
 		} else {
 			/* Alloc CID for connection-oriented socket */
-			l2cap_pi(sk)->scid = l2cap_alloc_cid(l);
+			l2cap_pi(sk)->scid = l2cap_alloc_cid(conn);
 			l2cap_pi(sk)->omtu = L2CAP_DEFAULT_MTU;
 		}
 	} else if (sk->sk_type == SOCK_DGRAM) {
@@ -217,7 +196,9 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 		l2cap_pi(sk)->omtu = L2CAP_DEFAULT_MTU;
 	}
 
-	__l2cap_chan_link(l, chan);
+	sock_hold(sk);
+
+	list_add(&chan->list, &conn->chan_l);
 }
 
 /* Delete channel.
@@ -233,8 +214,12 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 	BT_DBG("sk %p, conn %p, err %d", sk, conn, err);
 
 	if (conn) {
-		/* Unlink from channel list */
-		l2cap_chan_unlink(&conn->chan_list, chan);
+		/* Delete from channel list */
+		write_lock_bh(&conn->chan_lock);
+		list_del(&chan->list);
+		write_unlock_bh(&conn->chan_lock);
+		__sock_put(sk);
+
 		l2cap_pi(sk)->conn = NULL;
 		hci_conn_put(conn->hcon);
 	}
@@ -502,7 +487,6 @@ void l2cap_send_disconn_req(struct l2cap_conn *conn, struct sock *sk, int err)
 /* ---- L2CAP connections ---- */
 static void l2cap_conn_start(struct l2cap_conn *conn)
 {
-	struct l2cap_chan_list *l = &conn->chan_list;
 	struct sock_del_list del, *tmp1, *tmp2;
 	struct l2cap_chan *chan;
 
@@ -510,10 +494,11 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 
 	INIT_LIST_HEAD(&del.list);
 
-	read_lock(&l->lock);
+	read_lock(&conn->chan_lock);
 
-	for (chan = l->head; chan; chan = chan->next_c) {
+	list_for_each_entry(chan, &conn->chan_l, list) {
 		struct sock *sk = chan->sk;
+
 		bh_lock_sock(sk);
 
 		if (sk->sk_type != SOCK_SEQPACKET &&
@@ -593,7 +578,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 		bh_unlock_sock(sk);
 	}
 
-	read_unlock(&l->lock);
+	read_unlock(&conn->chan_lock);
 
 	list_for_each_entry_safe(tmp1, tmp2, &del.list, list) {
 		bh_lock_sock(tmp1->sk);
@@ -638,7 +623,6 @@ static struct sock *l2cap_get_sock_by_scid(int state, __le16 cid, bdaddr_t *src)
 
 static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 {
-	struct l2cap_chan_list *list = &conn->chan_list;
 	struct sock *parent, *uninitialized_var(sk);
 	struct l2cap_chan *chan;
 
@@ -666,11 +650,12 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 		goto clean;
 	}
 
-	write_lock_bh(&list->lock);
+	write_lock_bh(&conn->chan_lock);
 
 	hci_conn_hold(conn->hcon);
 
 	l2cap_sock_init(sk, parent);
+
 	bacpy(&bt_sk(sk)->src, conn->src);
 	bacpy(&bt_sk(sk)->dst, conn->dst);
 
@@ -685,7 +670,7 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 	sk->sk_state = BT_CONNECTED;
 	parent->sk_data_ready(parent, 0);
 
-	write_unlock_bh(&list->lock);
+	write_unlock_bh(&conn->chan_lock);
 
 clean:
 	bh_unlock_sock(parent);
@@ -693,7 +678,6 @@ clean:
 
 static void l2cap_conn_ready(struct l2cap_conn *conn)
 {
-	struct l2cap_chan_list *l = &conn->chan_list;
 	struct l2cap_chan *chan;
 
 	BT_DBG("conn %p", conn);
@@ -701,10 +685,11 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 	if (!conn->hcon->out && conn->hcon->type == LE_LINK)
 		l2cap_le_conn_ready(conn);
 
-	read_lock(&l->lock);
+	read_lock(&conn->chan_lock);
 
-	for (chan = l->head; chan; chan = chan->next_c) {
+	list_for_each_entry(chan, &conn->chan_l, list) {
 		struct sock *sk = chan->sk;
+
 		bh_lock_sock(sk);
 
 		if (conn->hcon->type == LE_LINK) {
@@ -724,26 +709,27 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 		bh_unlock_sock(sk);
 	}
 
-	read_unlock(&l->lock);
+	read_unlock(&conn->chan_lock);
 }
 
 /* Notify sockets that we cannot guaranty reliability anymore */
 static void l2cap_conn_unreliable(struct l2cap_conn *conn, int err)
 {
-	struct l2cap_chan_list *l = &conn->chan_list;
 	struct l2cap_chan *chan;
+	struct sock *sk;
 
 	BT_DBG("conn %p", conn);
 
-	read_lock(&l->lock);
+	read_lock(&conn->chan_lock);
+
+	list_for_each_entry(chan, &conn->chan_l, list) {
+		sk = chan->sk;
 
-	for (chan = l->head; chan; chan = chan->next_c) {
-		struct sock *sk = chan->sk;
 		if (l2cap_pi(sk)->force_reliable)
 			sk->sk_err = err;
 	}
 
-	read_unlock(&l->lock);
+	read_unlock(&conn->chan_lock);
 }
 
 static void l2cap_info_timeout(unsigned long arg)
@@ -783,7 +769,9 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
 	conn->feat_mask = 0;
 
 	spin_lock_init(&conn->lock);
-	rwlock_init(&conn->chan_list.lock);
+	rwlock_init(&conn->chan_lock);
+
+	INIT_LIST_HEAD(&conn->chan_l);
 
 	if (hcon->type != LE_LINK)
 		setup_timer(&conn->info_timer, l2cap_info_timeout,
@@ -797,7 +785,7 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
 static void l2cap_conn_del(struct hci_conn *hcon, int err)
 {
 	struct l2cap_conn *conn = hcon->l2cap_data;
-	struct l2cap_chan *chan;
+	struct l2cap_chan *chan, *l;
 	struct sock *sk;
 
 	if (!conn)
@@ -808,7 +796,7 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 	kfree_skb(conn->rx_skb);
 
 	/* Kill channels */
-	while ((chan = conn->chan_list.head)) {
+	list_for_each_entry_safe(chan, l, &conn->chan_l, list) {
 		sk = chan->sk;
 		bh_lock_sock(sk);
 		l2cap_chan_del(chan, err);
@@ -825,10 +813,9 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 
 static inline void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 {
-	struct l2cap_chan_list *l = &conn->chan_list;
-	write_lock_bh(&l->lock);
+	write_lock_bh(&conn->chan_lock);
 	__l2cap_chan_add(conn, chan);
-	write_unlock_bh(&l->lock);
+	write_unlock_bh(&conn->chan_lock);
 }
 
 /* ---- Socket interface ---- */
@@ -1426,14 +1413,13 @@ static void l2cap_chan_ready(struct sock *sk)
 /* Copy frame to all raw sockets on that connection */
 static void l2cap_raw_recv(struct l2cap_conn *conn, struct sk_buff *skb)
 {
-	struct l2cap_chan_list *l = &conn->chan_list;
 	struct sk_buff *nskb;
 	struct l2cap_chan *chan;
 
 	BT_DBG("conn %p", conn);
 
-	read_lock(&l->lock);
-	for (chan = l->head; chan; chan = chan->next_c) {
+	read_lock(&conn->chan_lock);
+	list_for_each_entry(chan, &conn->chan_l, list) {
 		struct sock *sk = chan->sk;
 		if (sk->sk_type != SOCK_RAW)
 			continue;
@@ -1448,7 +1434,7 @@ static void l2cap_raw_recv(struct l2cap_conn *conn, struct sk_buff *skb)
 		if (sock_queue_rcv_skb(sk, nskb))
 			kfree_skb(nskb);
 	}
-	read_unlock(&l->lock);
+	read_unlock(&conn->chan_lock);
 }
 
 /* ---- L2CAP signalling commands ---- */
@@ -2015,7 +2001,6 @@ static inline int l2cap_command_rej(struct l2cap_conn *conn, struct l2cap_cmd_hd
 
 static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr *cmd, u8 *data)
 {
-	struct l2cap_chan_list *list = &conn->chan_list;
 	struct l2cap_conn_req *req = (struct l2cap_conn_req *) data;
 	struct l2cap_conn_rsp rsp;
 	struct l2cap_chan *chan;
@@ -2062,11 +2047,11 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 		goto response;
 	}
 
-	write_lock_bh(&list->lock);
+	write_lock_bh(&conn->chan_lock);
 
 	/* Check if we already have channel with that dcid */
-	if (__l2cap_get_chan_by_dcid(list, scid)) {
-		write_unlock_bh(&list->lock);
+	if (__l2cap_get_chan_by_dcid(conn, scid)) {
+		write_unlock_bh(&conn->chan_lock);
 		sock_set_flag(sk, SOCK_ZAPPED);
 		l2cap_sock_kill(sk);
 		goto response;
@@ -2115,7 +2100,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 		status = L2CAP_CS_NO_INFO;
 	}
 
-	write_unlock_bh(&list->lock);
+	write_unlock_bh(&conn->chan_lock);
 
 response:
 	bh_unlock_sock(parent);
@@ -2169,11 +2154,11 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	BT_DBG("dcid 0x%4.4x scid 0x%4.4x result 0x%2.2x status 0x%2.2x", dcid, scid, result, status);
 
 	if (scid) {
-		chan = l2cap_get_chan_by_scid(&conn->chan_list, scid);
+		chan = l2cap_get_chan_by_scid(conn, scid);
 		if (!chan)
 			return -EFAULT;
 	} else {
-		chan = l2cap_get_chan_by_ident(&conn->chan_list, cmd->ident);
+		chan = l2cap_get_chan_by_ident(conn, cmd->ident);
 		if (!chan)
 			return -EFAULT;
 	}
@@ -2243,7 +2228,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 
 	BT_DBG("dcid 0x%4.4x flags 0x%2.2x", dcid, flags);
 
-	chan = l2cap_get_chan_by_scid(&conn->chan_list, dcid);
+	chan = l2cap_get_chan_by_scid(conn, dcid);
 	if (!chan)
 		return -ENOENT;
 
@@ -2338,7 +2323,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	BT_DBG("scid 0x%4.4x flags 0x%2.2x result 0x%2.2x",
 			scid, flags, result);
 
-	chan = l2cap_get_chan_by_scid(&conn->chan_list, scid);
+	chan = l2cap_get_chan_by_scid(conn, scid);
 	if (!chan)
 		return 0;
 
@@ -2418,7 +2403,7 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn, struct l2cap_cmd
 
 	BT_DBG("scid 0x%4.4x dcid 0x%4.4x", scid, dcid);
 
-	chan = l2cap_get_chan_by_scid(&conn->chan_list, dcid);
+	chan = l2cap_get_chan_by_scid(conn, dcid);
 	if (!chan)
 		return 0;
 
@@ -2458,7 +2443,7 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn, struct l2cap_cmd
 
 	BT_DBG("dcid 0x%4.4x scid 0x%4.4x", dcid, scid);
 
-	chan = l2cap_get_chan_by_scid(&conn->chan_list, scid);
+	chan = l2cap_get_chan_by_scid(conn, scid);
 	if (!chan)
 		return 0;
 
@@ -3612,7 +3597,7 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 	u8 tx_seq;
 	int len;
 
-	chan = l2cap_get_chan_by_scid(&conn->chan_list, cid);
+	chan = l2cap_get_chan_by_scid(conn, cid);
 	if (!chan) {
 		BT_DBG("unknown cid 0x%4.4x", cid);
 		goto drop;
@@ -3855,21 +3840,20 @@ static inline void l2cap_check_encryption(struct sock *sk, u8 encrypt)
 
 static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 {
-	struct l2cap_chan_list *l;
 	struct l2cap_conn *conn = hcon->l2cap_data;
 	struct l2cap_chan *chan;
+	struct sock *sk;
 
 	if (!conn)
 		return 0;
 
-	l = &conn->chan_list;
-
 	BT_DBG("conn %p", conn);
 
-	read_lock(&l->lock);
+	read_lock(&conn->chan_lock);
+
+	list_for_each_entry(chan, &conn->chan_l, list) {
+		sk = chan->sk;
 
-	for (chan = l->head; chan; chan = chan->next_c) {
-		struct sock *sk = chan->sk;
 		bh_lock_sock(sk);
 
 		if (l2cap_pi(sk)->conf_state & L2CAP_CONF_CONNECT_PEND) {
@@ -3923,7 +3907,7 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 		bh_unlock_sock(sk);
 	}
 
-	read_unlock(&l->lock);
+	read_unlock(&conn->chan_lock);
 
 	return 0;
 }
@@ -3980,7 +3964,7 @@ static int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 fl
 			goto drop;
 		}
 
-		chan = l2cap_get_chan_by_scid(&conn->chan_list, cid);
+		chan = l2cap_get_chan_by_scid(conn, cid);
 
 		if (chan && chan->sk) {
 			struct sock *sk = chan->sk;
@@ -3996,6 +3980,7 @@ static int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 fl
 			bh_unlock_sock(sk);
 		}
 
+
 		/* Allocate skb for the complete frame (with header) */
 		conn->rx_skb = bt_skb_alloc(len, GFP_ATOMIC);
 		if (!conn->rx_skb)
-- 
1.7.4.1

