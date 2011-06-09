Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [bluetooth-next v4 10/16] Bluetooth: Add support for resuming socket when SMP is finished
Date: Thu,  9 Jun 2011 18:50:49 -0300
Message-Id: <1307656255-8659-11-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1307656255-8659-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1307656255-8659-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds support for resuming the user space traffic when SMP
negotiation is complete.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/l2cap_core.c |   61 ++++++++++++++++++++++---------------------
 net/bluetooth/l2cap_sock.c |   16 +++++++++++
 net/bluetooth/smp.c        |   40 ++++++++++++++++++++--------
 3 files changed, 75 insertions(+), 42 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index e9c053c..d2036b5 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -879,6 +879,23 @@ clean:
 	bh_unlock_sock(parent);
 }
 
+static void l2cap_chan_ready(struct sock *sk)
+{
+	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+	struct sock *parent = bt_sk(sk)->parent;
+
+	BT_DBG("sk %p, parent %p", sk, parent);
+
+	chan->conf_state = 0;
+	l2cap_chan_clear_timer(chan);
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
 	struct l2cap_chan *chan;
@@ -895,13 +912,9 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 
 		bh_lock_sock(sk);
 
-		if (conn->hcon->type == LE_LINK) {
-			l2cap_chan_clear_timer(chan);
-			sk->sk_state = BT_CONNECTED;
-			sk->sk_state_change(sk);
+		if (conn->hcon->type == LE_LINK)
 			if (smp_conn_security(conn, chan->sec_level))
-				BT_DBG("Insufficient security");
-		}
+				l2cap_chan_ready(sk);
 
 		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
 			l2cap_chan_clear_timer(chan);
@@ -1664,30 +1677,6 @@ int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 	return err;
 }
 
-static void l2cap_chan_ready(struct sock *sk)
-{
-	struct sock *parent = bt_sk(sk)->parent;
-	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
-
-	BT_DBG("sk %p, parent %p", sk, parent);
-
-	chan->conf_state = 0;
-	l2cap_chan_clear_timer(chan);
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
@@ -4184,6 +4173,18 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 
 		bh_lock_sock(sk);
 
+		BT_DBG("chan->scid %d", chan->scid);
+
+		if (chan->scid == L2CAP_CID_LE_DATA) {
+			if (!status && encrypt) {
+				chan->sec_level = hcon->sec_level;
+				l2cap_chan_ready(sk);
+			}
+
+			bh_unlock_sock(sk);
+			continue;
+		}
+
 		if (chan->conf_state & L2CAP_CONF_CONNECT_PEND) {
 			bh_unlock_sock(sk);
 			continue;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index ab81894..d6cc558 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -29,6 +29,7 @@
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/l2cap.h>
+#include <net/bluetooth/smp.h>
 
 static const struct proto_ops l2cap_sock_ops;
 
@@ -556,6 +557,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 	struct bt_security sec;
 	struct bt_power pwr;
+	struct l2cap_conn *conn;
 	int len, err = 0;
 	u32 opt;
 
@@ -592,6 +594,20 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 		}
 
 		chan->sec_level = sec.level;
+
+		conn = chan->conn;
+		if (conn && chan->scid == L2CAP_CID_LE_DATA) {
+			if (!conn->hcon->out) {
+				err = -EINVAL;
+				break;
+			}
+
+			if (smp_conn_security(conn, sec.level))
+				break;
+
+			err = 0;
+			sk->sk_state = BT_CONFIG;
+		}
 		break;
 
 	case BT_DEFER_SETUP:
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 6983979..da46d76 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -336,9 +336,13 @@ static void smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
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
 
@@ -353,6 +357,20 @@ static void smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	memcpy(&conn->preq[1], &cp, sizeof(cp));
 
 	smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
+
+	set_bit(HCI_CONN_ENCRYPT_PEND, &hcon->pend);
+}
+
+static __u8 seclevel_to_authreq(__u8 level)
+{
+	switch (level) {
+	case BT_SECURITY_HIGH:
+		/* For now we don't support bonding */
+		return SMP_AUTH_MITM;
+
+	default:
+		return SMP_AUTH_NONE;
+	}
 }
 
 int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
@@ -365,21 +383,16 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 	if (IS_ERR(hcon->hdev->tfm))
 		return 1;
 
-	switch (sec_level) {
-	case BT_SECURITY_MEDIUM:
-		/* Encrypted, no MITM protection */
-		authreq = HCI_AT_NO_BONDING_MITM;
-		break;
+	if (test_bit(HCI_CONN_ENCRYPT_PEND, &hcon->pend))
+		return 0;
 
-	case BT_SECURITY_HIGH:
-		/* Bonding, MITM protection */
-		authreq = HCI_AT_GENERAL_BONDING_MITM;
-		break;
+	if (sec_level == BT_SECURITY_LOW)
+		return 1;
 
-	case BT_SECURITY_LOW:
-	default:
+	if (hcon->sec_level >= sec_level)
 		return 1;
-	}
+
+	authreq = seclevel_to_authreq(sec_level);
 
 	if (hcon->link_mode & HCI_LM_MASTER) {
 		struct smp_cmd_pairing cp;
@@ -400,6 +413,9 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 		smp_send_cmd(conn, SMP_CMD_SECURITY_REQ, sizeof(cp), &cp);
 	}
 
+	hcon->pending_sec_level = sec_level;
+	set_bit(HCI_CONN_ENCRYPT_PEND, &hcon->pend);
+
 	return 0;
 }
 
-- 
1.7.5.4

