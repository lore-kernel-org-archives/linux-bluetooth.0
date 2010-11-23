Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC 20/20] Bluetooth: Add support for resuming socket when SMP is finished
Date: Tue, 23 Nov 2010 12:06:36 -0300
Message-Id: <1290524796-32246-21-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1290524796-32246-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1290524796-32246-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds support for resuming the user space traffic when SMP
negotiation is complete.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/l2cap_core.c    |   86 +++++++++++++++++++++++++++--------------
 2 files changed, 58 insertions(+), 29 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 1d0555f..196ad4e 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -433,5 +433,6 @@ static inline int l2cap_tx_window_full(struct sock *sk)
 #define __is_sar_start(ctrl) ((ctrl) & L2CAP_CTRL_SAR) == L2CAP_SDU_START
 
 void l2cap_load(void);
+void l2cap_le_do_start(struct l2cap_conn *conn);
 
 #endif /* __L2CAP_H */
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 24719d3..df5402b 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -624,6 +624,31 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 	}
 }
 
+static void l2cap_chan_ready(struct sock *sk)
+{
+	struct sock *parent = bt_sk(sk)->parent;
+
+	BT_DBG("sk %p, parent %p", sk, parent);
+
+	l2cap_pi(sk)->conf_state = 0;
+	l2cap_sock_clear_timer(sk);
+
+	if (!parent) {
+		/* Outgoing channel.
+		 * Wake up socket sleeping on connect.
+		 */
+		sk->sk_state = BT_CONNECTED;
+		sk->sk_state_change(sk);
+	} else {
+		/* Incoming channel.
+		 * Wake up socket sleeping on accept.
+		 */
+		parent->sk_state = BT_CONNECTED;
+		sk->sk_state_change(sk);
+		parent->sk_data_ready(parent, 0);
+	}
+}
+
 static void l2cap_conn_ready(struct l2cap_conn *conn)
 {
 	struct l2cap_chan_list *l = &conn->chan_list;
@@ -640,14 +665,10 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 		bh_lock_sock(sk);
 
 		if (conn->hcon->type == LE_LINK) {
-			l2cap_sock_clear_timer(sk);
-			sk->sk_state = BT_CONNECTED;
-			sk->sk_state_change(sk);
 			if (smp_conn_security(conn, l2cap_pi(sk)->sec_level))
-				BT_DBG("Insufficient security");
-		}
+				l2cap_chan_ready(sk);
 
-		if (sk->sk_type != SOCK_SEQPACKET &&
+		} else if (sk->sk_type != SOCK_SEQPACKET &&
 				sk->sk_type != SOCK_STREAM) {
 			l2cap_sock_clear_timer(sk);
 			sk->sk_state = BT_CONNECTED;
@@ -692,6 +713,7 @@ static void l2cap_info_timeout(unsigned long arg)
 static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
 {
 	struct l2cap_conn *conn = hcon->l2cap_data;
+	struct hci_dev *hdev = hcon->hdev;
 
 	if (conn || status)
 		return conn;
@@ -705,10 +727,10 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
 
 	BT_DBG("hcon %p conn %p", hcon, conn);
 
-	if (hcon->hdev->le_mtu && hcon->type == LE_LINK)
-		conn->mtu = hcon->hdev->le_mtu;
+	if (hdev->le_mtu && hcon->type == LE_LINK)
+		conn->mtu = hdev->le_mtu;
 	else
-		conn->mtu = hcon->hdev->acl_mtu;
+		conn->mtu = hdev->acl_mtu;
 
 	conn->src = &hcon->hdev->bdaddr;
 	conn->dst = &hcon->dst;
@@ -1199,7 +1221,7 @@ static int l2cap_do_connect(struct sock *sk)
 				sk->sk_type != SOCK_STREAM) {
 			l2cap_sock_clear_timer(sk);
 			sk->sk_state = BT_CONNECTED;
-		} else
+		} else if (hcon->type != LE_LINK)
 			l2cap_do_start(sk);
 	}
 
@@ -1467,9 +1489,6 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 
 	l2cap_sock_set_timer(sk, sk->sk_sndtimeo);
 
-	sk->sk_state = BT_CONNECTED;
-	parent->sk_data_ready(parent, 0);
-
 	write_unlock_bh(&list->lock);
 
 clean:
@@ -2409,27 +2428,32 @@ static int l2cap_sock_release(struct socket *sock)
 	return err;
 }
 
-static void l2cap_chan_ready(struct sock *sk)
+void l2cap_le_do_start(struct l2cap_conn *conn)
 {
-	struct sock *parent = bt_sk(sk)->parent;
+	struct l2cap_chan_list *l = &conn->chan_list;
+	struct sock *sk;
 
-	BT_DBG("sk %p, parent %p", sk, parent);
+	read_lock(&l->lock);
 
-	l2cap_pi(sk)->conf_state = 0;
-	l2cap_sock_clear_timer(sk);
+	for (sk = l->head; sk; sk = l2cap_pi(sk)->next_c) {
+		bh_lock_sock(sk);
 
-	if (!parent) {
-		/* Outgoing channel.
-		 * Wake up socket sleeping on connect.
-		 */
-		sk->sk_state = BT_CONNECTED;
-		sk->sk_state_change(sk);
-	} else {
-		/* Incoming channel.
-		 * Wake up socket sleeping on accept.
-		 */
-		parent->sk_data_ready(parent, 0);
+		if (l2cap_pi(sk)->scid == L2CAP_CID_LE_DATA) {
+			struct sock *parent = bt_sk(sk)->parent;
+
+			l2cap_sock_clear_timer(sk);
+
+			if (parent)
+				parent->sk_data_ready(parent, 0);
+
+			sk->sk_state = BT_CONNECTED;
+			sk->sk_state_change(sk);
+		}
+
+		bh_unlock_sock(sk);
 	}
+
+	read_unlock(&l->lock);
 }
 
 /* Copy frame to all raw sockets on that connection */
@@ -4742,6 +4766,10 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 
 	BT_DBG("conn %p", conn);
 
+	if (hcon->type == LE_LINK)
+		if (encrypt)
+			l2cap_le_do_start(conn);
+
 	read_lock(&l->lock);
 
 	for (sk = l->head; sk; sk = l2cap_pi(sk)->next_c) {
-- 
1.7.3.2

