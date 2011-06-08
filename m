Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH -v2 5/8] Bluetooth: Add state tracking to struct l2cap_chan
Date: Wed,  8 Jun 2011 12:18:56 -0300
Message-Id: <1307546339-12035-6-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1307546339-12035-5-git-send-email-padovan@profusion.mobi>
References: <1307546339-12035-1-git-send-email-padovan@profusion.mobi>
 <1307546339-12035-2-git-send-email-padovan@profusion.mobi>
 <1307546339-12035-3-git-send-email-padovan@profusion.mobi>
 <1307546339-12035-4-git-send-email-padovan@profusion.mobi>
 <1307546339-12035-5-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now socket state is tracked by struct sock and channel state is tracked by
chan->state. At this point both says the same, but this is going to change
when we add AMP Support for example.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    3 +
 net/bluetooth/l2cap_core.c    |  113 +++++++++++++++++++++-------------------
 net/bluetooth/l2cap_sock.c    |   12 ++++
 3 files changed, 74 insertions(+), 54 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 0ad61d0..68c8724 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -287,6 +287,8 @@ struct l2cap_chan {
 
 	struct l2cap_conn	*conn;
 
+	__u8		state;
+
 	__le16		psm;
 	__u16		dcid;
 	__u16		scid;
@@ -365,6 +367,7 @@ struct l2cap_ops {
 	struct l2cap_chan	*(*new_connection) (void *data);
 	int			(*recv) (void *data, struct sk_buff *skb);
 	void			(*close) (void *data);
+	void			(*state_change) (void *data, int state);
 };
 
 struct l2cap_conn {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d832cb1..b07adf8 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -210,27 +210,33 @@ static u16 l2cap_alloc_cid(struct l2cap_conn *conn)
 
 static void l2cap_chan_set_timer(struct l2cap_chan *chan, long timeout)
 {
-       BT_DBG("chan %p state %d timeout %ld", chan->sk, chan->sk->sk_state,
-								 timeout);
+       BT_DBG("chan %p state %d timeout %ld", chan->sk, chan->state, timeout);
+
        if (!mod_timer(&chan->chan_timer, jiffies + timeout))
 	       sock_hold(chan->sk);
 }
 
 static void l2cap_chan_clear_timer(struct l2cap_chan *chan)
 {
-       BT_DBG("chan %p state %d", chan, chan->sk->sk_state);
+       BT_DBG("chan %p state %d", chan, chan->state);
 
        if (timer_pending(&chan->chan_timer) && del_timer(&chan->chan_timer))
 	       __sock_put(chan->sk);
 }
 
+static void l2cap_state_change(struct l2cap_chan *chan, int state)
+{
+	chan->state = state;
+	chan->ops->state_change(chan->data, state);
+}
+
 static void l2cap_chan_timeout(unsigned long arg)
 {
 	struct l2cap_chan *chan = (struct l2cap_chan *) arg;
 	struct sock *sk = chan->sk;
 	int reason;
 
-	BT_DBG("chan %p state %d", chan, sk->sk_state);
+	BT_DBG("chan %p state %d", chan, chan->state);
 
 	bh_lock_sock(sk);
 
@@ -242,9 +248,9 @@ static void l2cap_chan_timeout(unsigned long arg)
 		return;
 	}
 
-	if (sk->sk_state == BT_CONNECTED || sk->sk_state == BT_CONFIG)
+	if (chan->state == BT_CONNECTED || chan->state == BT_CONFIG)
 		reason = ECONNREFUSED;
-	else if (sk->sk_state == BT_CONNECT &&
+	else if (chan->state == BT_CONNECT &&
 					chan->sec_level != BT_SECURITY_SDP)
 		reason = ECONNREFUSED;
 	else
@@ -274,6 +280,8 @@ struct l2cap_chan *l2cap_chan_create(struct sock *sk)
 
 	setup_timer(&chan->chan_timer, l2cap_chan_timeout, (unsigned long) chan);
 
+	chan->state = BT_OPEN;
+
 	return chan;
 }
 
@@ -348,7 +356,7 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 		hci_conn_put(conn->hcon);
 	}
 
-	sk->sk_state = BT_CLOSED;
+	l2cap_state_change(chan, BT_CLOSED);
 	sock_set_flag(sk, SOCK_ZAPPED);
 
 	if (err)
@@ -398,9 +406,6 @@ static void l2cap_chan_cleanup_listen(struct sock *parent)
 		release_sock(sk);
 		chan->ops->close(chan->data);
 	}
-
-	parent->sk_state = BT_CLOSED;
-	sock_set_flag(parent, SOCK_ZAPPED);
 }
 
 void l2cap_chan_close(struct l2cap_chan *chan, int reason)
@@ -408,11 +413,14 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
 	struct l2cap_conn *conn = chan->conn;
 	struct sock *sk = chan->sk;
 
-	BT_DBG("chan %p state %d socket %p", chan, sk->sk_state, sk->sk_socket);
+	BT_DBG("chan %p state %d socket %p", chan, chan->state, sk->sk_socket);
 
-	switch (sk->sk_state) {
+	switch (chan->state) {
 	case BT_LISTEN:
 		l2cap_chan_cleanup_listen(sk);
+
+		l2cap_state_change(chan, BT_CLOSED);
+		sock_set_flag(sk, SOCK_ZAPPED);
 		break;
 
 	case BT_CONNECTED:
@@ -436,7 +444,7 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
 				result = L2CAP_CR_SEC_BLOCK;
 			else
 				result = L2CAP_CR_BAD_PSM;
-			sk->sk_state = BT_DISCONN;
+			l2cap_state_change(chan, BT_DISCONN);
 
 			rsp.scid   = cpu_to_le16(chan->dcid);
 			rsp.dcid   = cpu_to_le16(chan->scid);
@@ -548,13 +556,11 @@ static inline void l2cap_send_sframe(struct l2cap_chan *chan, u16 control)
 {
 	struct sk_buff *skb;
 	struct l2cap_hdr *lh;
-	struct l2cap_pinfo *pi = l2cap_pi(chan->sk);
 	struct l2cap_conn *conn = chan->conn;
-	struct sock *sk = (struct sock *)pi;
 	int count, hlen = L2CAP_HDR_SIZE + 2;
 	u8 flags;
 
-	if (sk->sk_state != BT_CONNECTED)
+	if (chan->state != BT_CONNECTED)
 		return;
 
 	if (chan->fcs == L2CAP_FCS_CRC16)
@@ -689,7 +695,7 @@ static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *c
 	l2cap_send_cmd(conn, l2cap_get_ident(conn),
 			L2CAP_DISCONN_REQ, sizeof(req), &req);
 
-	sk->sk_state = BT_DISCONN;
+	l2cap_state_change(chan, BT_DISCONN);
 	sk->sk_err = err;
 }
 
@@ -712,7 +718,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 			continue;
 		}
 
-		if (sk->sk_state == BT_CONNECT) {
+		if (chan->state == BT_CONNECT) {
 			struct l2cap_conn_req req;
 
 			if (!l2cap_check_security(chan) ||
@@ -728,7 +734,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 				/* l2cap_chan_close() calls list_del(chan)
 				 * so release the lock */
 				read_unlock_bh(&conn->chan_lock);
-				 l2cap_chan_close(chan, ECONNRESET);
+				l2cap_chan_close(chan, ECONNRESET);
 				read_lock_bh(&conn->chan_lock);
 				bh_unlock_sock(sk);
 				continue;
@@ -743,7 +749,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 			l2cap_send_cmd(conn, chan->ident, L2CAP_CONN_REQ,
 							sizeof(req), &req);
 
-		} else if (sk->sk_state == BT_CONNECT2) {
+		} else if (chan->state == BT_CONNECT2) {
 			struct l2cap_conn_rsp rsp;
 			char buf[128];
 			rsp.scid = cpu_to_le16(chan->dcid);
@@ -757,7 +763,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 					parent->sk_data_ready(parent, 0);
 
 				} else {
-					sk->sk_state = BT_CONFIG;
+					l2cap_state_change(chan, BT_CONFIG);
 					rsp.result = cpu_to_le16(L2CAP_CR_SUCCESS);
 					rsp.status = cpu_to_le16(L2CAP_CS_NO_INFO);
 				}
@@ -799,7 +805,7 @@ static struct l2cap_chan *l2cap_global_chan_by_scid(int state, __le16 cid, bdadd
 	list_for_each_entry(c, &chan_list, global_l) {
 		struct sock *sk = c->sk;
 
-		if (state && sk->sk_state != state)
+		if (state && c->state != state)
 			continue;
 
 		if (c->scid == cid) {
@@ -862,7 +868,7 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 
 	l2cap_chan_set_timer(chan, sk->sk_sndtimeo);
 
-	sk->sk_state = BT_CONNECTED;
+	l2cap_state_change(chan, BT_CONNECTED);
 	parent->sk_data_ready(parent, 0);
 
 	write_unlock_bh(&conn->chan_lock);
@@ -889,15 +895,15 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 
 		if (conn->hcon->type == LE_LINK) {
 			l2cap_chan_clear_timer(chan);
-			sk->sk_state = BT_CONNECTED;
+			l2cap_state_change(chan, BT_CONNECTED);
 			sk->sk_state_change(sk);
 		}
 
 		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
 			l2cap_chan_clear_timer(chan);
-			sk->sk_state = BT_CONNECTED;
+			l2cap_state_change(chan, BT_CONNECTED);
 			sk->sk_state_change(sk);
-		} else if (sk->sk_state == BT_CONNECT)
+		} else if (chan->state == BT_CONNECT)
 			l2cap_do_start(chan);
 
 		bh_unlock_sock(sk);
@@ -1025,7 +1031,7 @@ static struct l2cap_chan *l2cap_global_chan_by_psm(int state, __le16 psm, bdaddr
 	list_for_each_entry(c, &chan_list, global_l) {
 		struct sock *sk = c->sk;
 
-		if (state && sk->sk_state != state)
+		if (state && c->state != state)
 			continue;
 
 		if (c->psm == psm) {
@@ -1092,14 +1098,14 @@ int l2cap_chan_connect(struct l2cap_chan *chan)
 
 	l2cap_chan_add(conn, chan);
 
-	sk->sk_state = BT_CONNECT;
+	l2cap_state_change(chan, BT_CONNECT);
 	l2cap_chan_set_timer(chan, sk->sk_sndtimeo);
 
 	if (hcon->state == BT_CONNECTED) {
 		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
 			l2cap_chan_clear_timer(chan);
 			if (l2cap_check_security(chan))
-				sk->sk_state = BT_CONNECTED;
+				l2cap_state_change(chan, BT_CONNECTED);
 		} else
 			l2cap_do_start(chan);
 	}
@@ -1288,11 +1294,10 @@ static void l2cap_retransmit_one_frame(struct l2cap_chan *chan, u8 tx_seq)
 int l2cap_ertm_send(struct l2cap_chan *chan)
 {
 	struct sk_buff *skb, *tx_skb;
-	struct sock *sk = chan->sk;
 	u16 control, fcs;
 	int nsent = 0;
 
-	if (sk->sk_state != BT_CONNECTED)
+	if (chan->state != BT_CONNECTED)
 		return -ENOTCONN;
 
 	while ((skb = chan->tx_send_head) && (!l2cap_tx_window_full(chan))) {
@@ -1668,7 +1673,7 @@ static void l2cap_chan_ready(struct sock *sk)
 		/* Outgoing channel.
 		 * Wake up socket sleeping on connect.
 		 */
-		sk->sk_state = BT_CONNECTED;
+		l2cap_state_change(chan, BT_CONNECTED);
 		sk->sk_state_change(sk);
 	} else {
 		/* Incoming channel.
@@ -2364,22 +2369,22 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE) {
 		if (l2cap_check_security(chan)) {
 			if (bt_sk(sk)->defer_setup) {
-				sk->sk_state = BT_CONNECT2;
+				l2cap_state_change(chan, BT_CONNECT2);
 				result = L2CAP_CR_PEND;
 				status = L2CAP_CS_AUTHOR_PEND;
 				parent->sk_data_ready(parent, 0);
 			} else {
-				sk->sk_state = BT_CONFIG;
+				l2cap_state_change(chan, BT_CONFIG);
 				result = L2CAP_CR_SUCCESS;
 				status = L2CAP_CS_NO_INFO;
 			}
 		} else {
-			sk->sk_state = BT_CONNECT2;
+			l2cap_state_change(chan, BT_CONNECT2);
 			result = L2CAP_CR_PEND;
 			status = L2CAP_CS_AUTHEN_PEND;
 		}
 	} else {
-		sk->sk_state = BT_CONNECT2;
+		l2cap_state_change(chan, BT_CONNECT2);
 		result = L2CAP_CR_PEND;
 		status = L2CAP_CS_NO_INFO;
 	}
@@ -2451,7 +2456,7 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 
 	switch (result) {
 	case L2CAP_CR_SUCCESS:
-		sk->sk_state = BT_CONFIG;
+		l2cap_state_change(chan, BT_CONFIG);
 		chan->ident = 0;
 		chan->dcid = dcid;
 		chan->conf_state &= ~L2CAP_CONF_CONNECT_PEND;
@@ -2473,7 +2478,7 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	default:
 		/* don't delete l2cap channel if sk is owned by user */
 		if (sock_owned_by_user(sk)) {
-			sk->sk_state = BT_DISCONN;
+			l2cap_state_change(chan, BT_DISCONN);
 			l2cap_chan_clear_timer(chan);
 			l2cap_chan_set_timer(chan, HZ / 5);
 			break;
@@ -2520,7 +2525,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 
 	sk = chan->sk;
 
-	if (sk->sk_state != BT_CONFIG) {
+	if (chan->state != BT_CONFIG) {
 		struct l2cap_cmd_rej rej;
 
 		rej.reason = cpu_to_le16(0x0002);
@@ -2569,7 +2574,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	if (chan->conf_state & L2CAP_CONF_INPUT_DONE) {
 		set_default_fcs(chan);
 
-		sk->sk_state = BT_CONNECTED;
+		l2cap_state_change(chan, BT_CONNECTED);
 
 		chan->next_tx_seq = 0;
 		chan->expected_tx_seq = 0;
@@ -2661,7 +2666,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	if (chan->conf_state & L2CAP_CONF_OUTPUT_DONE) {
 		set_default_fcs(chan);
 
-		sk->sk_state = BT_CONNECTED;
+		l2cap_state_change(chan, BT_CONNECTED);
 		chan->next_tx_seq = 0;
 		chan->expected_tx_seq = 0;
 		skb_queue_head_init(&chan->tx_q);
@@ -2703,7 +2708,7 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn, struct l2cap_cmd
 
 	/* don't delete l2cap channel if sk is owned by user */
 	if (sock_owned_by_user(sk)) {
-		sk->sk_state = BT_DISCONN;
+		l2cap_state_change(chan, BT_DISCONN);
 		l2cap_chan_clear_timer(chan);
 		l2cap_chan_set_timer(chan, HZ / 5);
 		bh_unlock_sock(sk);
@@ -2737,7 +2742,7 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn, struct l2cap_cmd
 
 	/* don't delete l2cap channel if sk is owned by user */
 	if (sock_owned_by_user(sk)) {
-		sk->sk_state = BT_DISCONN;
+		l2cap_state_change(chan,BT_DISCONN);
 		l2cap_chan_clear_timer(chan);
 		l2cap_chan_set_timer(chan, HZ / 5);
 		bh_unlock_sock(sk);
@@ -3874,7 +3879,7 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
 
 	BT_DBG("chan %p, len %d", chan, skb->len);
 
-	if (sk->sk_state != BT_CONNECTED)
+	if (chan->state != BT_CONNECTED)
 		goto drop;
 
 	switch (chan->mode) {
@@ -3959,7 +3964,7 @@ static inline int l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm, str
 
 	BT_DBG("sk %p, len %d", sk, skb->len);
 
-	if (sk->sk_state != BT_BOUND && sk->sk_state != BT_CONNECTED)
+	if (chan->state != BT_BOUND && chan->state != BT_CONNECTED)
 		goto drop;
 
 	if (l2cap_pi(sk)->chan->imtu < skb->len)
@@ -3992,7 +3997,7 @@ static inline int l2cap_att_channel(struct l2cap_conn *conn, __le16 cid, struct
 
 	BT_DBG("sk %p, len %d", sk, skb->len);
 
-	if (sk->sk_state != BT_BOUND && sk->sk_state != BT_CONNECTED)
+	if (chan->state != BT_BOUND && chan->state != BT_CONNECTED)
 		goto drop;
 
 	if (l2cap_pi(sk)->chan->imtu < skb->len)
@@ -4066,7 +4071,7 @@ static int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 	list_for_each_entry(c, &chan_list, global_l) {
 		struct sock *sk = c->sk;
 
-		if (sk->sk_state != BT_LISTEN)
+		if (c->state != BT_LISTEN)
 			continue;
 
 		if (!bacmp(&bt_sk(sk)->src, &hdev->bdaddr)) {
@@ -4167,14 +4172,14 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 			continue;
 		}
 
-		if (!status && (sk->sk_state == BT_CONNECTED ||
-						sk->sk_state == BT_CONFIG)) {
+		if (!status && (chan->state == BT_CONNECTED ||
+						chan->state == BT_CONFIG)) {
 			l2cap_check_encryption(chan, encrypt);
 			bh_unlock_sock(sk);
 			continue;
 		}
 
-		if (sk->sk_state == BT_CONNECT) {
+		if (chan->state == BT_CONNECT) {
 			if (!status) {
 				struct l2cap_conn_req req;
 				req.scid = cpu_to_le16(chan->scid);
@@ -4189,15 +4194,15 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 				l2cap_chan_clear_timer(chan);
 				l2cap_chan_set_timer(chan, HZ / 10);
 			}
-		} else if (sk->sk_state == BT_CONNECT2) {
+		} else if (chan->state == BT_CONNECT2) {
 			struct l2cap_conn_rsp rsp;
 			__u16 result;
 
 			if (!status) {
-				sk->sk_state = BT_CONFIG;
+				l2cap_state_change(chan, BT_CONFIG);
 				result = L2CAP_CR_SUCCESS;
 			} else {
-				sk->sk_state = BT_DISCONN;
+				l2cap_state_change(chan, BT_DISCONN);
 				l2cap_chan_set_timer(chan, HZ / 10);
 				result = L2CAP_CR_SEC_BLOCK;
 			}
@@ -4341,7 +4346,7 @@ static int l2cap_debugfs_show(struct seq_file *f, void *p)
 		seq_printf(f, "%s %s %d %d 0x%4.4x 0x%4.4x %d %d %d %d\n",
 					batostr(&bt_sk(sk)->src),
 					batostr(&bt_sk(sk)->dst),
-					sk->sk_state, __le16_to_cpu(c->psm),
+					c->state, __le16_to_cpu(c->psm),
 					c->scid, c->dcid, c->imtu, c->omtu,
 					c->sec_level, c->mode);
 	}
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 9f15a16..1d9c365 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -89,6 +89,8 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 		chan->sec_level = BT_SECURITY_SDP;
 
 	bacpy(&bt_sk(sk)->src, &la.l2_bdaddr);
+
+	chan->state = BT_BOUND;
 	sk->sk_state = BT_BOUND;
 
 done:
@@ -214,6 +216,8 @@ static int l2cap_sock_listen(struct socket *sock, int backlog)
 
 	sk->sk_max_ack_backlog = backlog;
 	sk->sk_ack_backlog = 0;
+
+	chan->state = BT_LISTEN;
 	sk->sk_state = BT_LISTEN;
 
 done:
@@ -803,11 +807,19 @@ static void l2cap_sock_close_cb(void *data)
 	l2cap_sock_kill(sk);
 }
 
+static void l2cap_sock_state_change_cb(void *data, int state)
+{
+	struct sock *sk = data;
+
+	sk->sk_state = state;
+}
+
 static struct l2cap_ops l2cap_chan_ops = {
 	.name		= "L2CAP Socket Interface",
 	.new_connection	= l2cap_sock_new_connection_cb,
 	.recv		= l2cap_sock_recv_cb,
 	.close		= l2cap_sock_close_cb,
+	.state_change	= l2cap_sock_state_change_cb,
 };
 
 static void l2cap_sock_destruct(struct sock *sk)
-- 
1.7.5.1

