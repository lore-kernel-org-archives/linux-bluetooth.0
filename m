Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Ville Tervo <ville.tervo@nokia.com>
Subject: [RFC 05/20] Bluetooth: Add server socket support for LE connection
Date: Tue, 23 Nov 2010 12:06:21 -0300
Message-Id: <1290524796-32246-6-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1290524796-32246-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1290524796-32246-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ville Tervo <ville.tervo@nokia.com>

Add support for LE server sockets.

Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
---
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/hci_event.c     |   10 +++-
 net/bluetooth/l2cap.c         |  102 +++++++++++++++++++++++++++++++++++++++--
 3 files changed, 106 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index cc3a140..cba4423 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -38,6 +38,7 @@
 #define L2CAP_DEFAULT_MAX_PDU_SIZE	1009    /* Sized for 3-DH5 packet */
 #define L2CAP_DEFAULT_ACK_TO		200
 #define L2CAP_LOCAL_BUSY_TRIES		12
+#define L2CAP_LE_DEFAULT_MTU		23
 
 #define L2CAP_CONN_TIMEOUT	(40000) /* 40 seconds */
 #define L2CAP_INFO_TIMEOUT	(4000)  /*  4 seconds */
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6735804..df6eaa1 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1985,8 +1985,14 @@ static inline void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff
 	hci_dev_lock(hdev);
 
 	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &ev->bdaddr);
-	if (!conn)
-		goto unlock;
+	if (!conn) {
+		conn = hci_conn_add(hdev, LE_LINK, &ev->bdaddr);
+		if (!conn) {
+			BT_ERR("No memory for new connection");
+			hci_dev_unlock(hdev);
+			return;
+		}
+	}
 
 	if (ev->status) {
 		hci_proto_connect_cfm(conn, ev->status);
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index b7a5074..0b583c4 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -82,6 +82,8 @@ static struct sk_buff *l2cap_build_cmd(struct l2cap_conn *conn,
 
 static int l2cap_ertm_data_rcv(struct sock *sk, struct sk_buff *skb);
 
+static void l2cap_le_conn_ready(struct l2cap_conn *conn);
+
 /* ---- L2CAP timers ---- */
 static void l2cap_sock_set_timer(struct sock *sk, long timeout)
 {
@@ -236,8 +238,16 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct sock *sk, struct so
 	l2cap_pi(sk)->conn = conn;
 
 	if (sk->sk_type == SOCK_SEQPACKET || sk->sk_type == SOCK_STREAM) {
-		/* Alloc CID for connection-oriented socket */
-		l2cap_pi(sk)->scid = l2cap_alloc_cid(l);
+		if (conn->hcon->type == LE_LINK) {
+			/* LE connection */
+			l2cap_pi(sk)->omtu = L2CAP_LE_DEFAULT_MTU;
+			l2cap_pi(sk)->scid = L2CAP_CID_LE_DATA;
+			l2cap_pi(sk)->dcid = L2CAP_CID_LE_DATA;
+		} else {
+			/* Alloc CID for connection-oriented socket */
+			l2cap_pi(sk)->scid = l2cap_alloc_cid(l);
+			l2cap_pi(sk)->omtu = L2CAP_DEFAULT_MTU;
+		}
 	} else if (sk->sk_type == SOCK_DGRAM) {
 		/* Connectionless socket */
 		l2cap_pi(sk)->scid = L2CAP_CID_CONN_LESS;
@@ -620,6 +630,9 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 
 	BT_DBG("conn %p", conn);
 
+	if (!conn->hcon->out && conn->hcon->type == LE_LINK)
+		l2cap_le_conn_ready(conn);
+
 	read_lock(&l->lock);
 
 	for (sk = l->head; sk; sk = l2cap_pi(sk)->next_c) {
@@ -702,7 +715,8 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
 	spin_lock_init(&conn->lock);
 	rwlock_init(&conn->chan_list.lock);
 
-	setup_timer(&conn->info_timer, l2cap_info_timeout,
+	if (hcon->type != LE_LINK)
+		setup_timer(&conn->info_timer, l2cap_info_timeout,
 						(unsigned long) conn);
 
 	conn->disc_reason = 0x13;
@@ -796,6 +810,37 @@ static void l2cap_sock_destruct(struct sock *sk)
 	skb_queue_purge(&sk->sk_write_queue);
 }
 
+static inline struct sock *l2cap_get_sock_by_cid(int state, __le16 cid, bdaddr_t *src)
+{
+	struct sock *s;
+	struct sock *sk = NULL, *sk1 = NULL;
+	struct hlist_node *node;
+
+	read_lock(&l2cap_sk_list.lock);
+	sk_for_each(sk, node, &l2cap_sk_list.head) {
+		if (state && sk->sk_state != state)
+			continue;
+
+		if (l2cap_pi(sk)->dcid == cid) {
+			/* Exact match. */
+			if (!bacmp(&bt_sk(sk)->src, src))
+				break;
+
+			/* Closest match */
+			if (!bacmp(&bt_sk(sk)->src, BDADDR_ANY))
+				sk1 = sk;
+		}
+	}
+
+	s = node ? sk : sk1;
+
+	if (s)
+		bh_lock_sock(s);
+	read_unlock(&l2cap_sk_list.lock);
+
+	return s;
+}
+
 static void l2cap_sock_cleanup_listen(struct sock *parent)
 {
 	struct sock *sk;
@@ -1008,7 +1053,7 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 	len = min_t(unsigned int, sizeof(la), alen);
 	memcpy(&la, addr, len);
 
-	if (la.l2_cid)
+	if (la.l2_cid && la.l2_psm)
 		return -EINVAL;
 
 	lock_sock(sk);
@@ -1050,6 +1095,9 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 			l2cap_pi(sk)->sec_level = BT_SECURITY_SDP;
 	}
 
+	if (la.l2_cid)
+		l2cap_pi(sk)->dcid = la.l2_cid;
+
 	write_unlock_bh(&l2cap_sk_list.lock);
 
 done:
@@ -1267,7 +1315,7 @@ static int l2cap_sock_listen(struct socket *sock, int backlog)
 		goto done;
 	}
 
-	if (!l2cap_pi(sk)->psm) {
+	if (!l2cap_pi(sk)->psm && !l2cap_pi(sk)->dcid) {
 		bdaddr_t *src = &bt_sk(sk)->src;
 		u16 psm;
 
@@ -1377,6 +1425,50 @@ static int l2cap_sock_getname(struct socket *sock, struct sockaddr *addr, int *l
 	return 0;
 }
 
+static void l2cap_le_conn_ready(struct l2cap_conn *conn)
+{
+	struct l2cap_chan_list *list = &conn->chan_list;
+	struct sock *parent, *uninitialized_var(sk);
+
+	BT_DBG("");
+
+	/* Check if we have socket listening on cid */
+	parent = l2cap_get_sock_by_cid(BT_LISTEN, L2CAP_CID_LE_DATA,
+					conn->src);
+	if (!parent)
+		goto clean;
+
+	/* Check for backlog size */
+	if (sk_acceptq_is_full(parent)) {
+		BT_DBG("backlog full %d", parent->sk_ack_backlog);
+		goto clean;
+	}
+
+	sk = l2cap_sock_alloc(sock_net(parent), NULL, BTPROTO_L2CAP, GFP_ATOMIC);
+	if (!sk)
+		goto clean;
+
+	write_lock_bh(&list->lock);
+
+	hci_conn_hold(conn->hcon);
+
+	l2cap_sock_init(sk, parent);
+	bacpy(&bt_sk(sk)->src, conn->src);
+	bacpy(&bt_sk(sk)->dst, conn->dst);
+
+	__l2cap_chan_add(conn, sk, parent);
+
+	l2cap_sock_set_timer(sk, sk->sk_sndtimeo);
+
+	sk->sk_state = BT_CONNECTED;
+	parent->sk_data_ready(parent, 0);
+
+	write_unlock_bh(&list->lock);
+
+clean:
+	bh_unlock_sock(parent);
+}
+
 static int __l2cap_wait_ack(struct sock *sk)
 {
 	DECLARE_WAITQUEUE(wait, current);
-- 
1.7.3.2

