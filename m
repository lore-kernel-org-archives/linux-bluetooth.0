Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [bluetooth-next 19/24] Bluetooth: Add support for resuming socket when SMP is finished
Date: Wed,  9 Feb 2011 22:18:19 -0300
Message-Id: <1297300704-30006-20-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1297300704-30006-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1297300704-30006-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds support for resuming the user space traffic when SMP
negotiation is complete.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/l2cap_core.c |   61 ++++++++++++++++++++++---------------------
 net/bluetooth/l2cap_sock.c |   17 ++++++++++++
 net/bluetooth/smp.c        |   44 +++++++++++++++++++++++--------
 3 files changed, 80 insertions(+), 42 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 26d4c72..9a4e7d7 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -635,6 +635,22 @@ clean:
 	bh_unlock_sock(parent);
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
@@ -650,15 +666,11 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 	for (sk = l->head; sk; sk = l2cap_pi(sk)->next_c) {
 		bh_lock_sock(sk);
 
-		if (conn->hcon->type == LE_LINK) {
-			l2cap_sock_clear_timer(sk);
-			sk->sk_state = BT_CONNECTED;
-			sk->sk_state_change(sk);
+		if (l2cap_pi(sk)->scid == L2CAP_CID_LE_DATA) {
 			if (smp_conn_security(conn, l2cap_pi(sk)->sec_level))
-				BT_DBG("Insufficient security");
-		}
+				l2cap_chan_ready(sk);
 
-		if (sk->sk_type != SOCK_SEQPACKET &&
+		} else if (sk->sk_type != SOCK_SEQPACKET &&
 				sk->sk_type != SOCK_STREAM) {
 			l2cap_sock_clear_timer(sk);
 			sk->sk_state = BT_CONNECTED;
@@ -1329,29 +1341,6 @@ int l2cap_sar_segment_sdu(struct sock *sk, struct msghdr *msg, size_t len)
 	return size;
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
@@ -3672,6 +3661,18 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 	for (sk = l->head; sk; sk = l2cap_pi(sk)->next_c) {
 		bh_lock_sock(sk);
 
+		BT_DBG("sk->scid %d", l2cap_pi(sk)->scid);
+
+		if (l2cap_pi(sk)->scid == L2CAP_CID_LE_DATA) {
+			if (!status && encrypt) {
+				l2cap_pi(sk)->sec_level = hcon->sec_level;
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
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index a7eeacc..32211db 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -29,6 +29,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
+#include <net/bluetooth/smp.h>
 
 /* ---- L2CAP timers ---- */
 static void l2cap_sock_timeout(unsigned long arg)
@@ -613,6 +614,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 {
 	struct sock *sk = sock->sk;
 	struct bt_security sec;
+	struct l2cap_conn *conn;
 	int len, err = 0;
 	u32 opt;
 
@@ -649,6 +651,21 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 		}
 
 		l2cap_pi(sk)->sec_level = sec.level;
+
+		conn = l2cap_pi(sk)->conn;
+		if (conn && l2cap_pi(sk)->scid == L2CAP_CID_LE_DATA) {
+			if (!conn->hcon->out) {
+				err = -EINVAL;
+				break;
+			}
+
+			if (!smp_conn_security(conn, sec.level)) {
+				err = -EINVAL;
+				break;
+			}
+
+			sk->sk_state = BT_CONFIG;
+		}
 		break;
 
 	case BT_DEFER_SETUP:
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 49a6372..35ceba6 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -337,9 +337,13 @@ static void smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_cmd_security_req *rp = (void *) skb->data;
 	struct smp_cmd_pairing cp;
+	struct hci_conn *hcon = conn->hcon;
 
 	BT_DBG("conn %p", conn);
 
+	if (test_bit(HCI_CONN_ENCRYPT_PEND, &hcon->pend))
+		return;
+
 	skb_pull(skb, sizeof(*rp));
 	memset(&cp, 0, sizeof(cp));
 
@@ -354,6 +358,24 @@ static void smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	memcpy(&conn->preq[1], &cp, sizeof(cp));
 
 	smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
+
+	set_bit(HCI_CONN_ENCRYPT_PEND, &hcon->pend);
+}
+
+static __u8 seclevel_to_authreq(__u8 seclevel)
+{
+	switch (seclevel) {
+	case BT_SECURITY_MEDIUM:
+		/* Encrypted, no MITM protection */
+		return HCI_AT_NO_BONDING_MITM;
+
+	case BT_SECURITY_HIGH:
+		/* Bonding, MITM protection */
+		return HCI_AT_GENERAL_BONDING_MITM;
+
+	default:
+		return HCI_AT_NO_BONDING;
+	}
 }
 
 int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
@@ -366,21 +388,16 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 	if (IS_ERR(hcon->hdev->tfm))
 		return PTR_ERR(hcon->hdev->tfm);
 
-	switch (sec_level) {
-	case BT_SECURITY_MEDIUM:
-		/* Encrypted, no MITM protection */
-		authreq = HCI_AT_NO_BONDING_MITM;
-		break;
+	if (test_bit(HCI_CONN_ENCRYPT_PEND, &hcon->pend))
+		return -EINPROGRESS;
 
-	case BT_SECURITY_HIGH:
-		/* Bonding, MITM protection */
-		authreq = HCI_AT_GENERAL_BONDING_MITM;
-		break;
+	if (sec_level == BT_SECURITY_LOW)
+		return 1;
 
-	case BT_SECURITY_LOW:
-	default:
+	if (hcon->sec_level > sec_level)
 		return 1;
-	}
+
+	authreq = seclevel_to_authreq(sec_level);
 
 	if (hcon->link_mode & HCI_LM_MASTER) {
 		struct smp_cmd_pairing cp;
@@ -401,6 +418,9 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 		smp_send_cmd(conn, SMP_CMD_SECURITY_REQ, sizeof(cp), &cp);
 	}
 
+	hcon->pending_sec_level = sec_level;
+	set_bit(HCI_CONN_ENCRYPT_PEND, &hcon->pend);
+
 	return 0;
 }
 
-- 
1.7.4

