Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Remove l2cap_sk_list
Date: Wed, 27 Apr 2011 18:49:17 -0300
Message-Id: <1303940957-22694-3-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1303940957-22694-2-git-send-email-padovan@profusion.mobi>
References: <1303940957-22694-1-git-send-email-padovan@profusion.mobi>
 <1303940957-22694-2-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A new list was added to replace the socket based one. This new list
doesn't depent on sock and then fits better inside l2cap_core.c code.

It also rename l2cap_chan_alloc() to l2cap_chan_create() and
l2cap_chan_free() to l2cap_chan_destruct()

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    6 +-
 net/bluetooth/l2cap_core.c    |  165 ++++++++++++++++++++++-------------------
 net/bluetooth/l2cap_sock.c    |    6 +-
 3 files changed, 95 insertions(+), 82 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index fb3f90e..2ba675c 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -350,6 +350,7 @@ struct l2cap_chan {
 	struct list_head	srej_l;
 
 	struct list_head list;
+	struct list_head global_l;
 };
 
 struct l2cap_conn {
@@ -441,7 +442,6 @@ static inline int l2cap_tx_window_full(struct l2cap_chan *ch)
 #define __is_sar_start(ctrl)	(((ctrl) & L2CAP_CTRL_SAR) == L2CAP_SDU_START)
 
 extern int disable_ertm;
-extern struct bt_sock_list l2cap_sk_list;
 
 int l2cap_init_sockets(void);
 void l2cap_cleanup_sockets(void);
@@ -469,9 +469,9 @@ void l2cap_sock_init(struct sock *sk, struct sock *parent);
 struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 							int proto, gfp_t prio);
 void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *chan, int err);
-struct l2cap_chan *l2cap_chan_alloc(struct sock *sk);
+struct l2cap_chan *l2cap_chan_create(struct sock *sk);
 void l2cap_chan_del(struct l2cap_chan *chan, int err);
-void l2cap_chan_free(struct l2cap_chan *chan);
+void l2cap_chan_destruct(struct l2cap_chan *chan);
 int l2cap_chan_connect(struct l2cap_chan *chan);
 
 #endif /* __L2CAP_H */
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9e3f64f..c1d08f1 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -62,9 +62,8 @@ static u8 l2cap_fixed_chan[8] = { 0x02, };
 
 static struct workqueue_struct *_busy_wq;
 
-struct bt_sock_list l2cap_sk_list = {
-	.lock = __RW_LOCK_UNLOCKED(l2cap_sk_list.lock)
-};
+LIST_HEAD(chan_list);
+DEFINE_RWLOCK(chan_list_lock);
 
 static void l2cap_busy_work(struct work_struct *work);
 
@@ -135,29 +134,27 @@ static inline struct l2cap_chan *l2cap_get_chan_by_ident(struct l2cap_conn *conn
 	return c;
 }
 
-static struct sock *__l2cap_get_sock_by_addr(__le16 psm, bdaddr_t *src)
+static struct l2cap_chan *__l2cap_global_chan_by_addr(__le16 psm, bdaddr_t *src)
 {
-	struct sock *sk;
-	struct hlist_node *node;
-	sk_for_each(sk, node, &l2cap_sk_list.head) {
-		struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+	struct l2cap_chan *c;
 
-		if (chan->sport == psm && !bacmp(&bt_sk(sk)->src, src))
+	list_for_each_entry(c, &chan_list, global_l) {
+		if (c->sport == psm && !bacmp(&bt_sk(c->sk)->src, src))
 			goto found;
 	}
 
-	sk = NULL;
+	c = NULL;
 found:
-	return sk;
+	return c;
 }
 
 int l2cap_add_psm(struct l2cap_chan *chan, bdaddr_t *src, __le16 psm)
 {
 	int err;
 
-	write_lock_bh(&l2cap_sk_list.lock);
+	write_lock_bh(&chan_list_lock);
 
-	if (psm && __l2cap_get_sock_by_addr(psm, src)) {
+	if (psm && __l2cap_global_chan_by_addr(psm, src)) {
 		err = -EADDRINUSE;
 		goto done;
 	}
@@ -171,7 +168,7 @@ int l2cap_add_psm(struct l2cap_chan *chan, bdaddr_t *src, __le16 psm)
 
 		err = -EINVAL;
 		for (p = 0x1001; p < 0x1100; p += 2)
-			if (!__l2cap_get_sock_by_addr(cpu_to_le16(p), src)) {
+			if (!__l2cap_global_chan_by_addr(cpu_to_le16(p), src)) {
 				chan->psm   = cpu_to_le16(p);
 				chan->sport = cpu_to_le16(p);
 				err = 0;
@@ -180,17 +177,17 @@ int l2cap_add_psm(struct l2cap_chan *chan, bdaddr_t *src, __le16 psm)
 	}
 
 done:
-	write_unlock_bh(&l2cap_sk_list.lock);
+	write_unlock_bh(&chan_list_lock);
 	return err;
 }
 
 int l2cap_add_scid(struct l2cap_chan *chan,  __u16 scid)
 {
-	write_lock_bh(&l2cap_sk_list.lock);
+	write_lock_bh(&chan_list_lock);
 
 	chan->scid = scid;
 
-	write_unlock_bh(&l2cap_sk_list.lock);
+	write_unlock_bh(&chan_list_lock);
 
 	return 0;
 }
@@ -207,7 +204,7 @@ static u16 l2cap_alloc_cid(struct l2cap_conn *conn)
 	return 0;
 }
 
-struct l2cap_chan *l2cap_chan_alloc(struct sock *sk)
+struct l2cap_chan *l2cap_chan_create(struct sock *sk)
 {
 	struct l2cap_chan *chan;
 
@@ -217,11 +214,19 @@ struct l2cap_chan *l2cap_chan_alloc(struct sock *sk)
 
 	chan->sk = sk;
 
+	write_lock_bh(&chan_list_lock);
+	list_add(&chan->global_l, &chan_list);
+	write_unlock_bh(&chan_list_lock);
+
 	return chan;
 }
 
-void l2cap_chan_free(struct l2cap_chan *chan)
+void l2cap_chan_destruct(struct l2cap_chan *chan)
 {
+	write_lock_bh(&chan_list_lock);
+	list_del(&chan->global_l);
+	write_unlock_bh(&chan_list_lock);
+
 	kfree(chan);
 }
 
@@ -651,48 +656,51 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 /* Find socket with cid and source bdaddr.
  * Returns closest match, locked.
  */
-static struct sock *l2cap_get_sock_by_scid(int state, __le16 cid, bdaddr_t *src)
+static struct l2cap_chan *l2cap_global_chan_by_scid(int state, __le16 cid, bdaddr_t *src)
 {
-	struct sock *sk = NULL, *sk1 = NULL;
-	struct hlist_node *node;
+	struct l2cap_chan *c, *c1 = NULL;
 
-	read_lock(&l2cap_sk_list.lock);
+	read_lock(&chan_list_lock);
 
-	sk_for_each(sk, node, &l2cap_sk_list.head) {
-		struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+	list_for_each_entry(c, &chan_list, global_l) {
+		struct sock *sk = c->sk;
 
 		if (state && sk->sk_state != state)
 			continue;
 
-		if (chan->scid == cid) {
+		if (c->scid == cid) {
 			/* Exact match. */
-			if (!bacmp(&bt_sk(sk)->src, src))
-				break;
+			if (!bacmp(&bt_sk(sk)->src, src)) {
+				read_unlock(&chan_list_lock);
+				return c;
+			}
 
 			/* Closest match */
 			if (!bacmp(&bt_sk(sk)->src, BDADDR_ANY))
-				sk1 = sk;
+				c1 = c;
 		}
 	}
 
-	read_unlock(&l2cap_sk_list.lock);
+	read_unlock(&chan_list_lock);
 
-	return node ? sk : sk1;
+	return c1;
 }
 
 static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 {
 	struct sock *parent, *sk;
-	struct l2cap_chan *chan;
+	struct l2cap_chan *chan, *pchan;
 
 	BT_DBG("");
 
 	/* Check if we have socket listening on cid */
-	parent = l2cap_get_sock_by_scid(BT_LISTEN, L2CAP_CID_LE_DATA,
+	pchan = l2cap_global_chan_by_scid(BT_LISTEN, L2CAP_CID_LE_DATA,
 							conn->src);
-	if (!parent)
+	if (!pchan)
 		return;
 
+	parent = pchan->sk;
+
 	bh_lock_sock(parent);
 
 	/* Check for backlog size */
@@ -705,7 +713,7 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 	if (!sk)
 		goto clean;
 
-	chan = l2cap_chan_alloc(sk);
+	chan = l2cap_chan_create(sk);
 	if (!chan) {
 		l2cap_sock_kill(sk);
 		goto clean;
@@ -883,33 +891,34 @@ static inline void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *ch
 /* Find socket with psm and source bdaddr.
  * Returns closest match.
  */
-static struct sock *l2cap_get_sock_by_psm(int state, __le16 psm, bdaddr_t *src)
+static struct l2cap_chan *l2cap_global_chan_by_psm(int state, __le16 psm, bdaddr_t *src)
 {
-	struct sock *sk = NULL, *sk1 = NULL;
-	struct hlist_node *node;
+	struct l2cap_chan *c, *c1 = NULL;
 
-	read_lock(&l2cap_sk_list.lock);
+	read_lock(&chan_list_lock);
 
-	sk_for_each(sk, node, &l2cap_sk_list.head) {
-		struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+	list_for_each_entry(c, &chan_list, global_l) {
+		struct sock *sk = c->sk;
 
 		if (state && sk->sk_state != state)
 			continue;
 
-		if (chan->psm == psm) {
+		if (c->psm == psm) {
 			/* Exact match. */
-			if (!bacmp(&bt_sk(sk)->src, src))
-				break;
+			if (!bacmp(&bt_sk(sk)->src, src)) {
+				read_unlock_bh(&chan_list_lock);
+				return c;
+			}
 
 			/* Closest match */
 			if (!bacmp(&bt_sk(sk)->src, BDADDR_ANY))
-				sk1 = sk;
+				c1 = c;
 		}
 	}
 
-	read_unlock(&l2cap_sk_list.lock);
+	read_unlock(&chan_list_lock);
 
-	return node ? sk : sk1;
+	return c1;
 }
 
 int l2cap_chan_connect(struct l2cap_chan *chan)
@@ -2079,22 +2088,26 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 {
 	struct l2cap_conn_req *req = (struct l2cap_conn_req *) data;
 	struct l2cap_conn_rsp rsp;
-	struct l2cap_chan *chan = NULL;
+	struct l2cap_chan *chan = NULL, *pchan;
 	struct sock *parent, *sk = NULL;
 	int result, status = L2CAP_CS_NO_INFO;
 
 	u16 dcid = 0, scid = __le16_to_cpu(req->scid);
 	__le16 psm = req->psm;
 
-	BT_DBG("psm 0x%2.2x scid 0x%4.4x", psm, scid);
+	BT_ERR("psm 0x%2.2x scid 0x%4.4x", psm, scid);
 
 	/* Check if we have socket listening on psm */
-	parent = l2cap_get_sock_by_psm(BT_LISTEN, psm, conn->src);
-	if (!parent) {
+	pchan = l2cap_global_chan_by_psm(BT_LISTEN, psm, conn->src);
+	if (!pchan) {
 		result = L2CAP_CR_BAD_PSM;
 		goto sendresp;
 	}
 
+	BT_ERR("%p 0x%2.2x", pchan, pchan->psm);
+
+	parent = pchan->sk;
+
 	bh_lock_sock(parent);
 
 	/* Check if the ACL is secure enough (if not SDP) */
@@ -2117,7 +2130,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	if (!sk)
 		goto response;
 
-	chan = l2cap_chan_alloc(sk);
+	chan = l2cap_chan_create(sk);
 	if (!chan) {
 		l2cap_sock_kill(sk);
 		goto response;
@@ -3745,11 +3758,14 @@ done:
 static inline int l2cap_conless_channel(struct l2cap_conn *conn, __le16 psm, struct sk_buff *skb)
 {
 	struct sock *sk;
+	struct l2cap_chan *chan;
 
-	sk = l2cap_get_sock_by_psm(0, psm, conn->src);
-	if (!sk)
+	chan = l2cap_global_chan_by_psm(0, psm, conn->src);
+	if (!chan)
 		goto drop;
 
+	sk = chan->sk;
+
 	bh_lock_sock(sk);
 
 	BT_DBG("sk %p, len %d", sk, skb->len);
@@ -3775,11 +3791,14 @@ done:
 static inline int l2cap_att_channel(struct l2cap_conn *conn, __le16 cid, struct sk_buff *skb)
 {
 	struct sock *sk;
+	struct l2cap_chan *chan;
 
-	sk = l2cap_get_sock_by_scid(0, cid, conn->src);
-	if (!sk)
+	chan = l2cap_global_chan_by_scid(0, cid, conn->src);
+	if (!chan)
 		goto drop;
 
+	sk = chan->sk;
+
 	bh_lock_sock(sk);
 
 	BT_DBG("sk %p, len %d", sk, skb->len);
@@ -3846,8 +3865,7 @@ static void l2cap_recv_frame(struct l2cap_conn *conn, struct sk_buff *skb)
 static int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 {
 	int exact = 0, lm1 = 0, lm2 = 0;
-	register struct sock *sk;
-	struct hlist_node *node;
+	struct l2cap_chan *c;
 
 	if (type != ACL_LINK)
 		return -EINVAL;
@@ -3855,25 +3873,25 @@ static int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 	BT_DBG("hdev %s, bdaddr %s", hdev->name, batostr(bdaddr));
 
 	/* Find listening sockets and check their link_mode */
-	read_lock(&l2cap_sk_list.lock);
-	sk_for_each(sk, node, &l2cap_sk_list.head) {
-		struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+	read_lock(&chan_list_lock);
+	list_for_each_entry(c, &chan_list, global_l) {
+		struct sock *sk = c->sk;
 
 		if (sk->sk_state != BT_LISTEN)
 			continue;
 
 		if (!bacmp(&bt_sk(sk)->src, &hdev->bdaddr)) {
 			lm1 |= HCI_LM_ACCEPT;
-			if (chan->role_switch)
+			if (c->role_switch)
 				lm1 |= HCI_LM_MASTER;
 			exact++;
 		} else if (!bacmp(&bt_sk(sk)->src, BDADDR_ANY)) {
 			lm2 |= HCI_LM_ACCEPT;
-			if (chan->role_switch)
+			if (c->role_switch)
 				lm2 |= HCI_LM_MASTER;
 		}
 	}
-	read_unlock(&l2cap_sk_list.lock);
+	read_unlock(&chan_list_lock);
 
 	return exact ? lm1 : lm2;
 }
@@ -4126,25 +4144,22 @@ drop:
 
 static int l2cap_debugfs_show(struct seq_file *f, void *p)
 {
-	struct sock *sk;
-	struct hlist_node *node;
+	struct l2cap_chan *c;
 
-	read_lock_bh(&l2cap_sk_list.lock);
+	read_lock_bh(&chan_list_lock);
 
-	sk_for_each(sk, node, &l2cap_sk_list.head) {
-		struct l2cap_pinfo *pi = l2cap_pi(sk);
-		struct l2cap_chan *chan = pi->chan;
+	list_for_each_entry(c, &chan_list, global_l) {
+		struct sock *sk = c->sk;
 
 		seq_printf(f, "%s %s %d %d 0x%4.4x 0x%4.4x %d %d %d %d\n",
 					batostr(&bt_sk(sk)->src),
 					batostr(&bt_sk(sk)->dst),
-					sk->sk_state, __le16_to_cpu(chan->psm),
-					chan->scid, chan->dcid,
-					chan->imtu, chan->omtu, chan->sec_level,
-					chan->mode);
+					sk->sk_state, __le16_to_cpu(c->psm),
+					c->scid, c->dcid, c->imtu, c->omtu,
+					c->sec_level, c->mode);
 	}
 
-	read_unlock_bh(&l2cap_sk_list.lock);
+	read_unlock_bh(&chan_list_lock);
 
 	return 0;
 }
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index aca99cd..3a78e46 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -808,8 +808,7 @@ void l2cap_sock_kill(struct sock *sk)
 
 	/* Kill poor orphan */
 
-	l2cap_chan_free(l2cap_pi(sk)->chan);
-	bt_sock_unlink(&l2cap_sk_list, sk);
+	l2cap_chan_destruct(l2cap_pi(sk)->chan);
 	sock_set_flag(sk, SOCK_DEAD);
 	sock_put(sk);
 }
@@ -1025,7 +1024,6 @@ struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock, int proto, g
 
 	setup_timer(&sk->sk_timer, l2cap_sock_timeout, (unsigned long) sk);
 
-	bt_sock_link(&l2cap_sk_list, sk);
 	return sk;
 }
 
@@ -1052,7 +1050,7 @@ static int l2cap_sock_create(struct net *net, struct socket *sock, int protocol,
 	if (!sk)
 		return -ENOMEM;
 
-	chan = l2cap_chan_alloc(sk);
+	chan = l2cap_chan_create(sk);
 	if (!chan) {
 		l2cap_sock_kill(sk);
 		return -ENOMEM;
-- 
1.7.5.rc1

