Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Ville Tervo <ville.tervo@nokia.com>
Subject: [bluetooth-next 05/24] Bluetooth: Add server socket support for LE connection
Date: Wed,  9 Feb 2011 22:18:05 -0300
Message-Id: <1297300704-30006-6-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1297300704-30006-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1297300704-30006-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ville Tervo <ville.tervo@nokia.com>

Add support for LE server sockets.

Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
---
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/hci_event.c     |   10 +++++-
 net/bluetooth/l2cap_core.c    |   61 +++++++++++++++++++++++++++++++++++++++--
 net/bluetooth/l2cap_sock.c    |    7 +++-
 4 files changed, 72 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 78552a0..031e9cd 100644
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
index 3155ad5..74f04a2 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2405,8 +2405,14 @@ static inline void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff
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
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b322cf5..7690e6d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -183,8 +183,16 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct sock *sk, struct so
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
@@ -583,6 +591,49 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 	}
 }
 
+static void l2cap_le_conn_ready(struct l2cap_conn *conn)
+{
+	struct l2cap_chan_list *list = &conn->chan_list;
+	struct sock *parent, *uninitialized_var(sk);
+
+	BT_DBG("");
+
+	/* Check if we have socket listening on cid */
+	parent = l2cap_get_chan_by_scid(list, L2CAP_CID_LE_DATA);
+	if (!parent)
+		return;
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
 static void l2cap_conn_ready(struct l2cap_conn *conn)
 {
 	struct l2cap_chan_list *l = &conn->chan_list;
@@ -590,6 +641,9 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 
 	BT_DBG("conn %p", conn);
 
+	if (!conn->hcon->out && conn->hcon->type == LE_LINK)
+		l2cap_le_conn_ready(conn);
+
 	read_lock(&l->lock);
 
 	for (sk = l->head; sk; sk = l2cap_pi(sk)->next_c) {
@@ -672,7 +726,8 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
 	spin_lock_init(&conn->lock);
 	rwlock_init(&conn->chan_list.lock);
 
-	setup_timer(&conn->info_timer, l2cap_info_timeout,
+	if (hcon->type != LE_LINK)
+		setup_timer(&conn->info_timer, l2cap_info_timeout,
 						(unsigned long) conn);
 
 	conn->disc_reason = 0x13;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index b435e5f..0c695be 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -103,7 +103,7 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 	len = min_t(unsigned int, sizeof(la), alen);
 	memcpy(&la, addr, len);
 
-	if (la.l2_cid)
+	if (la.l2_cid && la.l2_psm)
 		return -EINVAL;
 
 	lock_sock(sk);
@@ -145,6 +145,9 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 			l2cap_pi(sk)->sec_level = BT_SECURITY_SDP;
 	}
 
+	if (la.l2_cid)
+		l2cap_pi(sk)->scid = la.l2_cid;
+
 	write_unlock_bh(&l2cap_sk_list.lock);
 
 done:
@@ -266,7 +269,7 @@ static int l2cap_sock_listen(struct socket *sock, int backlog)
 		goto done;
 	}
 
-	if (!l2cap_pi(sk)->psm) {
+	if (!l2cap_pi(sk)->psm && !l2cap_pi(sk)->dcid) {
 		bdaddr_t *src = &bt_sk(sk)->src;
 		u16 psm;
 
-- 
1.7.4

