Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 01/15] Bluetooth: Create struct l2cap_chan
Date: Fri,  1 Apr 2011 19:33:06 -0300
Message-Id: <1301697200-2446-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1301697200-2446-1-git-send-email-padovan@profusion.mobi>
References: <1301697200-2446-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

struct l2cap_chan cames to create a clear separation between what
properties and data belongs to the L2CAP channel and what belongs to the
socket. By now we just fold the struct sock * in struct l2cap_chan as all
the channel info is struct l2cap_pinfo today.

In the next commits we will see a move of channel stuff to struct
l2cap_chan.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |   18 ++-
 net/bluetooth/l2cap_core.c    |  247 ++++++++++++++++++++++++++--------------
 net/bluetooth/l2cap_sock.c    |    6 +-
 3 files changed, 175 insertions(+), 96 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 2b9ca0d..6378bcc 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -276,9 +276,16 @@ struct l2cap_conn_param_update_rsp {
 #define L2CAP_CONN_PARAM_ACCEPTED	0x0000
 #define L2CAP_CONN_PARAM_REJECTED	0x0001
 
-/* ----- L2CAP connections ----- */
+/* ----- L2CAP channels and connections ----- */
+
+struct l2cap_chan {
+	struct sock *sk;
+	struct l2cap_chan	*next_c;
+	struct l2cap_chan	*prev_c;
+};
+
 struct l2cap_chan_list {
-	struct sock	*head;
+	struct l2cap_chan *head;
 	rwlock_t	lock;
 };
 
@@ -317,7 +324,7 @@ struct sock_del_list {
 #define L2CAP_INFO_FEAT_MASK_REQ_SENT	0x04
 #define L2CAP_INFO_FEAT_MASK_REQ_DONE	0x08
 
-/* ----- L2CAP channel and socket info ----- */
+/* ----- L2CAP socket info ----- */
 #define l2cap_pi(sk) ((struct l2cap_pinfo *) sk)
 #define TX_QUEUE(sk) (&l2cap_pi(sk)->tx_queue)
 #define SREJ_QUEUE(sk) (&l2cap_pi(sk)->srej_queue)
@@ -389,8 +396,7 @@ struct l2cap_pinfo {
 	struct work_struct	busy_work;
 	struct srej_list	srej_l;
 	struct l2cap_conn	*conn;
-	struct sock		*next_c;
-	struct sock		*prev_c;
+	struct l2cap_chan	*chan;
 };
 
 #define L2CAP_CONF_REQ_SENT       0x01
@@ -471,7 +477,7 @@ void l2cap_sock_init(struct sock *sk, struct sock *parent);
 struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 							int proto, gfp_t prio);
 void l2cap_send_disconn_req(struct l2cap_conn *conn, struct sock *sk, int err);
-void l2cap_chan_del(struct sock *sk, int err);
+void l2cap_chan_del(struct l2cap_chan *chan, int err);
 int l2cap_do_connect(struct sock *sk);
 
 #endif /* __L2CAP_H */
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c3cebed..e49d8f7 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -74,58 +74,58 @@ static struct sk_buff *l2cap_build_cmd(struct l2cap_conn *conn,
 static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb);
 
 /* ---- L2CAP channels ---- */
-static struct sock *__l2cap_get_chan_by_dcid(struct l2cap_chan_list *l, u16 cid)
+static struct l2cap_chan *__l2cap_get_chan_by_dcid(struct l2cap_chan_list *l, u16 cid)
 {
-	struct sock *s;
-	for (s = l->head; s; s = l2cap_pi(s)->next_c) {
-		if (l2cap_pi(s)->dcid == cid)
+	struct l2cap_chan *c;
+	for (c = l->head; c; c = c->next_c) {
+		if (l2cap_pi(c->sk)->dcid == cid)
 			break;
 	}
-	return s;
+	return c;
 }
 
-static struct sock *__l2cap_get_chan_by_scid(struct l2cap_chan_list *l, u16 cid)
+static struct l2cap_chan *__l2cap_get_chan_by_scid(struct l2cap_chan_list *l, u16 cid)
 {
-	struct sock *s;
-	for (s = l->head; s; s = l2cap_pi(s)->next_c) {
-		if (l2cap_pi(s)->scid == cid)
+	struct l2cap_chan *c;
+	for (c = l->head; c; c = c->next_c) {
+		if (l2cap_pi(c->sk)->scid == cid)
 			break;
 	}
-	return s;
+	return c;
 }
 
 /* Find channel with given SCID.
  * Returns locked socket */
-static inline struct sock *l2cap_get_chan_by_scid(struct l2cap_chan_list *l, u16 cid)
+static inline struct l2cap_chan *l2cap_get_chan_by_scid(struct l2cap_chan_list *l, u16 cid)
 {
-	struct sock *s;
+	struct l2cap_chan *c;
 	read_lock(&l->lock);
-	s = __l2cap_get_chan_by_scid(l, cid);
-	if (s)
-		bh_lock_sock(s);
+	c = __l2cap_get_chan_by_scid(l, cid);
+	if (c)
+		bh_lock_sock(c->sk);
 	read_unlock(&l->lock);
-	return s;
+	return c;
 }
 
-static struct sock *__l2cap_get_chan_by_ident(struct l2cap_chan_list *l, u8 ident)
+static struct l2cap_chan *__l2cap_get_chan_by_ident(struct l2cap_chan_list *l, u8 ident)
 {
-	struct sock *s;
-	for (s = l->head; s; s = l2cap_pi(s)->next_c) {
-		if (l2cap_pi(s)->ident == ident)
+	struct l2cap_chan *c;
+	for (c = l->head; c; c = c->next_c) {
+		if (l2cap_pi(c->sk)->ident == ident)
 			break;
 	}
-	return s;
+	return c;
 }
 
-static inline struct sock *l2cap_get_chan_by_ident(struct l2cap_chan_list *l, u8 ident)
+static inline struct l2cap_chan *l2cap_get_chan_by_ident(struct l2cap_chan_list *l, u8 ident)
 {
-	struct sock *s;
+	struct l2cap_chan *c;
 	read_lock(&l->lock);
-	s = __l2cap_get_chan_by_ident(l, ident);
-	if (s)
-		bh_lock_sock(s);
+	c = __l2cap_get_chan_by_ident(l, ident);
+	if (c)
+		bh_lock_sock(c->sk);
 	read_unlock(&l->lock);
-	return s;
+	return c;
 }
 
 static u16 l2cap_alloc_cid(struct l2cap_chan_list *l)
@@ -140,38 +140,52 @@ static u16 l2cap_alloc_cid(struct l2cap_chan_list *l)
 	return 0;
 }
 
-static inline void __l2cap_chan_link(struct l2cap_chan_list *l, struct sock *sk)
+static struct l2cap_chan *l2cap_chan_alloc(struct sock *sk)
+{
+	struct l2cap_chan *chan;
+
+	chan = kzalloc(sizeof(*chan), GFP_ATOMIC);
+	if (!chan)
+		return NULL;
+
+	chan->sk = sk;
+
+	return chan;
+}
+
+static inline void __l2cap_chan_link(struct l2cap_chan_list *l, struct l2cap_chan *chan)
 {
-	sock_hold(sk);
+	sock_hold(chan->sk);
 
 	if (l->head)
-		l2cap_pi(l->head)->prev_c = sk;
+		l->head->prev_c = chan;
 
-	l2cap_pi(sk)->next_c = l->head;
-	l2cap_pi(sk)->prev_c = NULL;
-	l->head = sk;
+	chan->next_c = l->head;
+	chan->prev_c = NULL;
+	l->head = chan;
 }
 
-static inline void l2cap_chan_unlink(struct l2cap_chan_list *l, struct sock *sk)
+static inline void l2cap_chan_unlink(struct l2cap_chan_list *l, struct l2cap_chan *chan)
 {
-	struct sock *next = l2cap_pi(sk)->next_c, *prev = l2cap_pi(sk)->prev_c;
+	struct l2cap_chan *next = chan->next_c, *prev = chan->prev_c;
 
 	write_lock_bh(&l->lock);
-	if (sk == l->head)
+	if (chan == l->head)
 		l->head = next;
 
 	if (next)
-		l2cap_pi(next)->prev_c = prev;
+		next->prev_c = prev;
 	if (prev)
-		l2cap_pi(prev)->next_c = next;
+		prev->next_c = next;
 	write_unlock_bh(&l->lock);
 
-	__sock_put(sk);
+	__sock_put(chan->sk);
 }
 
-static void __l2cap_chan_add(struct l2cap_conn *conn, struct sock *sk)
+static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 {
 	struct l2cap_chan_list *l = &conn->chan_list;
+	struct sock *sk = chan->sk;
 
 	BT_DBG("conn %p, psm 0x%2.2x, dcid 0x%4.4x", conn,
 			l2cap_pi(sk)->psm, l2cap_pi(sk)->dcid);
@@ -203,13 +217,14 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct sock *sk)
 		l2cap_pi(sk)->omtu = L2CAP_DEFAULT_MTU;
 	}
 
-	__l2cap_chan_link(l, sk);
+	__l2cap_chan_link(l, chan);
 }
 
 /* Delete channel.
  * Must be called on the locked socket. */
-void l2cap_chan_del(struct sock *sk, int err)
+void l2cap_chan_del(struct l2cap_chan *chan, int err)
 {
+	struct sock *sk = chan->sk;
 	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
 	struct sock *parent = bt_sk(sk)->parent;
 
@@ -219,7 +234,7 @@ void l2cap_chan_del(struct sock *sk, int err)
 
 	if (conn) {
 		/* Unlink from channel list */
-		l2cap_chan_unlink(&conn->chan_list, sk);
+		l2cap_chan_unlink(&conn->chan_list, chan);
 		l2cap_pi(sk)->conn = NULL;
 		hci_conn_put(conn->hcon);
 	}
@@ -253,6 +268,8 @@ void l2cap_chan_del(struct sock *sk, int err)
 			kfree(l);
 		}
 	}
+
+	kfree(chan);
 }
 
 static inline u8 l2cap_get_auth_type(struct sock *sk)
@@ -487,7 +504,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 {
 	struct l2cap_chan_list *l = &conn->chan_list;
 	struct sock_del_list del, *tmp1, *tmp2;
-	struct sock *sk;
+	struct l2cap_chan *chan;
 
 	BT_DBG("conn %p", conn);
 
@@ -495,7 +512,8 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 
 	read_lock(&l->lock);
 
-	for (sk = l->head; sk; sk = l2cap_pi(sk)->next_c) {
+	for (chan = l->head; chan; chan = chan->next_c) {
+		struct sock *sk = chan->sk;
 		bh_lock_sock(sk);
 
 		if (sk->sk_type != SOCK_SEQPACKET &&
@@ -622,6 +640,7 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 {
 	struct l2cap_chan_list *list = &conn->chan_list;
 	struct sock *parent, *uninitialized_var(sk);
+	struct l2cap_chan *chan;
 
 	BT_DBG("");
 
@@ -641,6 +660,12 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 	if (!sk)
 		goto clean;
 
+	chan = l2cap_chan_alloc(sk);
+	if (!chan) {
+		l2cap_sock_kill(sk);
+		goto clean;
+	}
+
 	write_lock_bh(&list->lock);
 
 	hci_conn_hold(conn->hcon);
@@ -651,7 +676,9 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 
 	bt_accept_enqueue(parent, sk);
 
-	__l2cap_chan_add(conn, sk);
+	__l2cap_chan_add(conn, chan);
+
+	l2cap_pi(sk)->chan = chan;
 
 	l2cap_sock_set_timer(sk, sk->sk_sndtimeo);
 
@@ -667,7 +694,7 @@ clean:
 static void l2cap_conn_ready(struct l2cap_conn *conn)
 {
 	struct l2cap_chan_list *l = &conn->chan_list;
-	struct sock *sk;
+	struct l2cap_chan *chan;
 
 	BT_DBG("conn %p", conn);
 
@@ -676,7 +703,8 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 
 	read_lock(&l->lock);
 
-	for (sk = l->head; sk; sk = l2cap_pi(sk)->next_c) {
+	for (chan = l->head; chan; chan = chan->next_c) {
+		struct sock *sk = chan->sk;
 		bh_lock_sock(sk);
 
 		if (conn->hcon->type == LE_LINK) {
@@ -703,13 +731,14 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 static void l2cap_conn_unreliable(struct l2cap_conn *conn, int err)
 {
 	struct l2cap_chan_list *l = &conn->chan_list;
-	struct sock *sk;
+	struct l2cap_chan *chan;
 
 	BT_DBG("conn %p", conn);
 
 	read_lock(&l->lock);
 
-	for (sk = l->head; sk; sk = l2cap_pi(sk)->next_c) {
+	for (chan = l->head; chan; chan = chan->next_c) {
+		struct sock *sk = chan->sk;
 		if (l2cap_pi(sk)->force_reliable)
 			sk->sk_err = err;
 	}
@@ -768,6 +797,7 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
 static void l2cap_conn_del(struct hci_conn *hcon, int err)
 {
 	struct l2cap_conn *conn = hcon->l2cap_data;
+	struct l2cap_chan *chan;
 	struct sock *sk;
 
 	if (!conn)
@@ -778,9 +808,10 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 	kfree_skb(conn->rx_skb);
 
 	/* Kill channels */
-	while ((sk = conn->chan_list.head)) {
+	while ((chan = conn->chan_list.head)) {
+		sk = chan->sk;
 		bh_lock_sock(sk);
-		l2cap_chan_del(sk, err);
+		l2cap_chan_del(chan, err);
 		bh_unlock_sock(sk);
 		l2cap_sock_kill(sk);
 	}
@@ -792,11 +823,11 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 	kfree(conn);
 }
 
-static inline void l2cap_chan_add(struct l2cap_conn *conn, struct sock *sk)
+static inline void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 {
 	struct l2cap_chan_list *l = &conn->chan_list;
 	write_lock_bh(&l->lock);
-	__l2cap_chan_add(conn, sk);
+	__l2cap_chan_add(conn, chan);
 	write_unlock_bh(&l->lock);
 }
 
@@ -837,6 +868,7 @@ int l2cap_do_connect(struct sock *sk)
 	bdaddr_t *src = &bt_sk(sk)->src;
 	bdaddr_t *dst = &bt_sk(sk)->dst;
 	struct l2cap_conn *conn;
+	struct l2cap_chan *chan;
 	struct hci_conn *hcon;
 	struct hci_dev *hdev;
 	__u8 auth_type;
@@ -872,10 +904,19 @@ int l2cap_do_connect(struct sock *sk)
 		goto done;
 	}
 
+	chan = l2cap_chan_alloc(sk);
+	if (!chan) {
+		hci_conn_put(hcon);
+		err = -ENOMEM;
+		goto done;
+	}
+
 	/* Update source addr of the socket */
 	bacpy(src, conn->src);
 
-	l2cap_chan_add(conn, sk);
+	l2cap_chan_add(conn, chan);
+
+	l2cap_pi(sk)->chan = chan;
 
 	sk->sk_state = BT_CONNECT;
 	l2cap_sock_set_timer(sk, sk->sk_sndtimeo);
@@ -1387,12 +1428,13 @@ static void l2cap_raw_recv(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct l2cap_chan_list *l = &conn->chan_list;
 	struct sk_buff *nskb;
-	struct sock *sk;
+	struct l2cap_chan *chan;
 
 	BT_DBG("conn %p", conn);
 
 	read_lock(&l->lock);
-	for (sk = l->head; sk; sk = l2cap_pi(sk)->next_c) {
+	for (chan = l->head; chan; chan = chan->next_c) {
+		struct sock *sk = chan->sk;
 		if (sk->sk_type != SOCK_RAW)
 			continue;
 
@@ -1976,6 +2018,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	struct l2cap_chan_list *list = &conn->chan_list;
 	struct l2cap_conn_req *req = (struct l2cap_conn_req *) data;
 	struct l2cap_conn_rsp rsp;
+	struct l2cap_chan *chan;
 	struct sock *parent, *sk = NULL;
 	int result, status = L2CAP_CS_NO_INFO;
 
@@ -2013,6 +2056,12 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	if (!sk)
 		goto response;
 
+	chan = l2cap_chan_alloc(sk);
+	if (!chan) {
+		l2cap_sock_kill(sk);
+		goto response;
+	}
+
 	write_lock_bh(&list->lock);
 
 	/* Check if we already have channel with that dcid */
@@ -2033,7 +2082,10 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 
 	bt_accept_enqueue(parent, sk);
 
-	__l2cap_chan_add(conn, sk);
+	__l2cap_chan_add(conn, chan);
+
+	l2cap_pi(sk)->chan = chan;
+
 	dcid = l2cap_pi(sk)->scid;
 
 	l2cap_sock_set_timer(sk, sk->sk_sndtimeo);
@@ -2105,6 +2157,7 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 {
 	struct l2cap_conn_rsp *rsp = (struct l2cap_conn_rsp *) data;
 	u16 scid, dcid, result, status;
+	struct l2cap_chan *chan;
 	struct sock *sk;
 	u8 req[128];
 
@@ -2116,15 +2169,17 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	BT_DBG("dcid 0x%4.4x scid 0x%4.4x result 0x%2.2x status 0x%2.2x", dcid, scid, result, status);
 
 	if (scid) {
-		sk = l2cap_get_chan_by_scid(&conn->chan_list, scid);
-		if (!sk)
+		chan = l2cap_get_chan_by_scid(&conn->chan_list, scid);
+		if (!chan)
 			return -EFAULT;
 	} else {
-		sk = l2cap_get_chan_by_ident(&conn->chan_list, cmd->ident);
-		if (!sk)
+		chan = l2cap_get_chan_by_ident(&conn->chan_list, cmd->ident);
+		if (!chan)
 			return -EFAULT;
 	}
 
+	sk = chan->sk;
+
 	switch (result) {
 	case L2CAP_CR_SUCCESS:
 		sk->sk_state = BT_CONFIG;
@@ -2155,7 +2210,7 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 			break;
 		}
 
-		l2cap_chan_del(sk, ECONNREFUSED);
+		l2cap_chan_del(chan, ECONNREFUSED);
 		break;
 	}
 
@@ -2179,6 +2234,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	struct l2cap_conf_req *req = (struct l2cap_conf_req *) data;
 	u16 dcid, flags;
 	u8 rsp[64];
+	struct l2cap_chan *chan;
 	struct sock *sk;
 	int len;
 
@@ -2187,10 +2243,12 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 
 	BT_DBG("dcid 0x%4.4x flags 0x%2.2x", dcid, flags);
 
-	sk = l2cap_get_chan_by_scid(&conn->chan_list, dcid);
-	if (!sk)
+	chan = l2cap_get_chan_by_scid(&conn->chan_list, dcid);
+	if (!chan)
 		return -ENOENT;
 
+	sk = chan->sk;
+
 	if (sk->sk_state != BT_CONFIG) {
 		struct l2cap_cmd_rej rej;
 
@@ -2269,6 +2327,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 {
 	struct l2cap_conf_rsp *rsp = (struct l2cap_conf_rsp *)data;
 	u16 scid, flags, result;
+	struct l2cap_chan *chan;
 	struct sock *sk;
 	int len = cmd->len - sizeof(*rsp);
 
@@ -2279,10 +2338,12 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	BT_DBG("scid 0x%4.4x flags 0x%2.2x result 0x%2.2x",
 			scid, flags, result);
 
-	sk = l2cap_get_chan_by_scid(&conn->chan_list, scid);
-	if (!sk)
+	chan = l2cap_get_chan_by_scid(&conn->chan_list, scid);
+	if (!chan)
 		return 0;
 
+	sk = chan->sk;
+
 	switch (result) {
 	case L2CAP_CONF_SUCCESS:
 		l2cap_conf_rfc_get(sk, rsp->data, len);
@@ -2349,6 +2410,7 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn, struct l2cap_cmd
 	struct l2cap_disconn_req *req = (struct l2cap_disconn_req *) data;
 	struct l2cap_disconn_rsp rsp;
 	u16 dcid, scid;
+	struct l2cap_chan *chan;
 	struct sock *sk;
 
 	scid = __le16_to_cpu(req->scid);
@@ -2356,10 +2418,12 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn, struct l2cap_cmd
 
 	BT_DBG("scid 0x%4.4x dcid 0x%4.4x", scid, dcid);
 
-	sk = l2cap_get_chan_by_scid(&conn->chan_list, dcid);
-	if (!sk)
+	chan = l2cap_get_chan_by_scid(&conn->chan_list, dcid);
+	if (!chan)
 		return 0;
 
+	sk = chan->sk;
+
 	rsp.dcid = cpu_to_le16(l2cap_pi(sk)->scid);
 	rsp.scid = cpu_to_le16(l2cap_pi(sk)->dcid);
 	l2cap_send_cmd(conn, cmd->ident, L2CAP_DISCONN_RSP, sizeof(rsp), &rsp);
@@ -2375,7 +2439,7 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn, struct l2cap_cmd
 		return 0;
 	}
 
-	l2cap_chan_del(sk, ECONNRESET);
+	l2cap_chan_del(chan, ECONNRESET);
 	bh_unlock_sock(sk);
 
 	l2cap_sock_kill(sk);
@@ -2386,6 +2450,7 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn, struct l2cap_cmd
 {
 	struct l2cap_disconn_rsp *rsp = (struct l2cap_disconn_rsp *) data;
 	u16 dcid, scid;
+	struct l2cap_chan *chan;
 	struct sock *sk;
 
 	scid = __le16_to_cpu(rsp->scid);
@@ -2393,10 +2458,12 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn, struct l2cap_cmd
 
 	BT_DBG("dcid 0x%4.4x scid 0x%4.4x", dcid, scid);
 
-	sk = l2cap_get_chan_by_scid(&conn->chan_list, scid);
-	if (!sk)
+	chan = l2cap_get_chan_by_scid(&conn->chan_list, scid);
+	if (!chan)
 		return 0;
 
+	sk = chan->sk;
+
 	/* don't delete l2cap channel if sk is owned by user */
 	if (sock_owned_by_user(sk)) {
 		sk->sk_state = BT_DISCONN;
@@ -2406,7 +2473,7 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn, struct l2cap_cmd
 		return 0;
 	}
 
-	l2cap_chan_del(sk, 0);
+	l2cap_chan_del(chan, 0);
 	bh_unlock_sock(sk);
 
 	l2cap_sock_kill(sk);
@@ -3538,18 +3605,20 @@ drop:
 
 static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk_buff *skb)
 {
+	struct l2cap_chan *chan;
 	struct sock *sk;
 	struct l2cap_pinfo *pi;
 	u16 control;
 	u8 tx_seq;
 	int len;
 
-	sk = l2cap_get_chan_by_scid(&conn->chan_list, cid);
-	if (!sk) {
+	chan = l2cap_get_chan_by_scid(&conn->chan_list, cid);
+	if (!chan) {
 		BT_DBG("unknown cid 0x%4.4x", cid);
 		goto drop;
 	}
 
+	sk = chan->sk;
 	pi = l2cap_pi(sk);
 
 	BT_DBG("sk %p, len %d", sk, skb->len);
@@ -3788,7 +3857,7 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 {
 	struct l2cap_chan_list *l;
 	struct l2cap_conn *conn = hcon->l2cap_data;
-	struct sock *sk;
+	struct l2cap_chan *chan;
 
 	if (!conn)
 		return 0;
@@ -3799,7 +3868,8 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 
 	read_lock(&l->lock);
 
-	for (sk = l->head; sk; sk = l2cap_pi(sk)->next_c) {
+	for (chan = l->head; chan; chan = chan->next_c) {
+		struct sock *sk = chan->sk;
 		bh_lock_sock(sk);
 
 		if (l2cap_pi(sk)->conf_state & L2CAP_CONF_CONNECT_PEND) {
@@ -3872,7 +3942,7 @@ static int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 fl
 
 	if (!(flags & ACL_CONT)) {
 		struct l2cap_hdr *hdr;
-		struct sock *sk;
+		struct l2cap_chan *chan;
 		u16 cid;
 		int len;
 
@@ -3910,18 +3980,21 @@ static int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 fl
 			goto drop;
 		}
 
-		sk = l2cap_get_chan_by_scid(&conn->chan_list, cid);
+		chan = l2cap_get_chan_by_scid(&conn->chan_list, cid);
 
-		if (sk && l2cap_pi(sk)->imtu < len - L2CAP_HDR_SIZE) {
-			BT_ERR("Frame exceeding recv MTU (len %d, MTU %d)",
-					len, l2cap_pi(sk)->imtu);
-			bh_unlock_sock(sk);
-			l2cap_conn_unreliable(conn, ECOMM);
-			goto drop;
-		}
+		if (chan && chan->sk) {
+			struct sock *sk = chan->sk;
 
-		if (sk)
+			if (l2cap_pi(sk)->imtu < len - L2CAP_HDR_SIZE) {
+				BT_ERR("Frame exceeding recv MTU (len %d, "
+							"MTU %d)", len,
+							l2cap_pi(sk)->imtu);
+				bh_unlock_sock(sk);
+				l2cap_conn_unreliable(conn, ECOMM);
+				goto drop;
+			}
 			bh_unlock_sock(sk);
+		}
 
 		/* Allocate skb for the complete frame (with header) */
 		conn->rx_skb = bt_skb_alloc(len, GFP_ATOMIC);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index f77308e..7df8118 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -902,7 +902,7 @@ void __l2cap_sock_close(struct sock *sk, int reason)
 			l2cap_sock_set_timer(sk, sk->sk_sndtimeo);
 			l2cap_send_disconn_req(conn, sk, reason);
 		} else
-			l2cap_chan_del(sk, reason);
+			l2cap_chan_del(l2cap_pi(sk)->chan, reason);
 		break;
 
 	case BT_CONNECT2:
@@ -925,12 +925,12 @@ void __l2cap_sock_close(struct sock *sk, int reason)
 					L2CAP_CONN_RSP, sizeof(rsp), &rsp);
 		}
 
-		l2cap_chan_del(sk, reason);
+		l2cap_chan_del(l2cap_pi(sk)->chan, reason);
 		break;
 
 	case BT_CONNECT:
 	case BT_DISCONN:
-		l2cap_chan_del(sk, reason);
+		l2cap_chan_del(l2cap_pi(sk)->chan, reason);
 		break;
 
 	default:
-- 
1.7.4.1

