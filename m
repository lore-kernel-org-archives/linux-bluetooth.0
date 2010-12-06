Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC v2 9/9] Bluetooth: Add support for resuming socket when SMP is finished
Date: Mon,  6 Dec 2010 18:43:52 -0300
Message-Id: <1291671832-13435-10-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1291671832-13435-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1291671832-13435-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds support for resuming the user space traffic when SMP
negotiation is complete.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/l2cap_core.c |   72 +++++++++++++++++++++++++------------------
 net/bluetooth/smp.c        |    9 +++++
 2 files changed, 51 insertions(+), 30 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index da4f13d..061248f 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -624,6 +624,22 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
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
+	sk->sk_state = BT_CONNECTED;
+	sk->sk_state_change(sk);
+
+	if (parent)
+		parent->sk_data_ready(parent, 0);
+}
+
 static void l2cap_conn_ready(struct l2cap_conn *conn)
 {
 	struct l2cap_chan_list *l = &conn->chan_list;
@@ -640,14 +656,10 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
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
@@ -1199,7 +1211,7 @@ static int l2cap_do_connect(struct sock *sk)
 				sk->sk_type != SOCK_STREAM) {
 			l2cap_sock_clear_timer(sk);
 			sk->sk_state = BT_CONNECTED;
-		} else
+		} else if (hcon->type == ACL_LINK)
 			l2cap_do_start(sk);
 	}
 
@@ -2162,6 +2174,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 {
 	struct sock *sk = sock->sk;
 	struct bt_security sec;
+	struct l2cap_conn *conn;
 	int len, err = 0;
 	u32 opt;
 
@@ -2198,6 +2211,18 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 		}
 
 		l2cap_pi(sk)->sec_level = sec.level;
+
+		conn = l2cap_pi(sk)->conn;
+		if (conn && conn->hcon->type == LE_LINK) {
+			if (!conn->hcon->out) {
+				err = -EINVAL;
+				break;
+			}
+
+			sk->sk_state = BT_CONFIG;
+			smp_conn_security(conn, sec.level);
+		}
+
 		break;
 
 	case BT_DEFER_SETUP:
@@ -2410,29 +2435,6 @@ static int l2cap_sock_release(struct socket *sock)
 	return err;
 }
 
-static void l2cap_chan_ready(struct sock *sk)
-{
-	struct sock *parent = bt_sk(sk)->parent;
-
-	BT_DBG("sk %p, parent %p", sk, parent);
-
-	l2cap_pi(sk)->conf_state = 0;
-	l2cap_sock_clear_timer(sk);
-
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
-	}
-}
-
 /* Copy frame to all raw sockets on that connection */
 static void l2cap_raw_recv(struct l2cap_conn *conn, struct sk_buff *skb)
 {
@@ -4753,6 +4755,16 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 	for (sk = l->head; sk; sk = l2cap_pi(sk)->next_c) {
 		bh_lock_sock(sk);
 
+		if (l2cap_pi(sk)->scid == L2CAP_CID_LE_DATA) {
+			if (!status && encrypt) {
+				l2cap_pi(sk)->sec_level = BT_SECURITY_MEDIUM;
+				l2cap_chan_ready(sk);
+			}
+
+			bh_unlock_sock(sk);
+			continue;
+		}
+
 		if (l2cap_pi(sk)->conf_state & L2CAP_CONF_CONNECT_PEND) {
 			bh_unlock_sock(sk);
 			continue;
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index d19b8a2..c7a0e63 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -346,9 +346,13 @@ static void smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_cmd_security_req *rp = (void *) skb->data;
 	struct smp_cmd_pairing cp;
+	struct hci_conn *hcon = conn->hcon;
 
 	BT_DBG("");
 
+	if (test_bit(HCI_CONN_ENCRYPT_PEND, &hcon->pend))
+		return;
+
 	skb_pull(skb, sizeof(*rp));
 
 	memset(&cp, 0, sizeof(cp));
@@ -364,10 +368,13 @@ static void smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	memcpy(&conn->preq[1], &cp, sizeof(cp));
 
 	smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
+
+	set_bit(HCI_CONN_ENCRYPT_PEND, &hcon->pend);
 }
 
 int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 {
+	struct hci_conn *hcon = conn->hcon;
 	__u8 authreq;
 
 	BT_DBG("conn %p hcon %p level 0x%2.2x", conn, conn->hcon, sec_level);
@@ -407,6 +414,8 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 		smp_send_cmd(conn, SMP_CMD_SECURITY_REQ, sizeof(cp), &cp);
 	}
 
+	set_bit(HCI_CONN_ENCRYPT_PEND, &hcon->pend);
+
 	return 0;
 }
 
-- 
1.7.3.2

