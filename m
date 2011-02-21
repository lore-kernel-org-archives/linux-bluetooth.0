Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [bluetooth-next 14/15] Bluetooth: Add support for SMP timeout
Date: Mon, 21 Feb 2011 14:24:01 -0300
Message-Id: <7323f72406eb52cfa487fee16cb2a98fda6cc0cd.1298307667.git.vinicius.gomes@openbossa.org>
In-Reply-To: <cover.1298307667.git.vinicius.gomes@openbossa.org>
References: <cover.1298307667.git.vinicius.gomes@openbossa.org>
In-Reply-To: <cover.1298307667.git.vinicius.gomes@openbossa.org>
References: <cover.1298307667.git.vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for disconnecting the link when SMP procedure
takes more than 30 seconds.

SMP begins when either the Pairing Request command is sent or the
Pairing Response is received, and it ends when the link is encrypted
(or terminated). Vol 3, Part H Section 3.4.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/l2cap.h |    2 +
 net/bluetooth/l2cap_core.c    |   70 ++++++++++++++++++++++++----------------
 net/bluetooth/smp.c           |   14 ++++++++
 3 files changed, 58 insertions(+), 28 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index ed65d65..c2d4ff4 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -313,6 +313,8 @@ struct l2cap_conn {
 	__u8		pcnf[16]; /* SMP Pairing Confirm */
 	__u8		tk[16]; /* SMP Temporary Key */
 
+	struct timer_list security_timer;
+
 	struct l2cap_chan_list chan_list;
 };
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 991b349..d781703 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -733,6 +733,36 @@ static void l2cap_conn_unreliable(struct l2cap_conn *conn, int err)
 	read_unlock(&l->lock);
 }
 
+static void l2cap_conn_del(struct hci_conn *hcon, int err)
+{
+	struct l2cap_conn *conn = hcon->l2cap_data;
+	struct sock *sk;
+
+	if (!conn)
+		return;
+
+	BT_DBG("hcon %p conn %p, err %d", hcon, conn, err);
+
+	kfree_skb(conn->rx_skb);
+
+	/* Kill channels */
+	while ((sk = conn->chan_list.head)) {
+		bh_lock_sock(sk);
+		l2cap_chan_del(sk, err);
+		bh_unlock_sock(sk);
+		l2cap_sock_kill(sk);
+	}
+
+	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
+		del_timer_sync(&conn->info_timer);
+
+	if (hcon->type == LE_LINK)
+		del_timer(&conn->security_timer);
+
+	hcon->l2cap_data = NULL;
+	kfree(conn);
+}
+
 static void l2cap_info_timeout(unsigned long arg)
 {
 	struct l2cap_conn *conn = (void *) arg;
@@ -743,6 +773,13 @@ static void l2cap_info_timeout(unsigned long arg)
 	l2cap_conn_start(conn);
 }
 
+static void security_timeout(unsigned long arg)
+{
+	struct l2cap_conn *conn = (void *) arg;
+
+	l2cap_conn_del(conn->hcon, ETIMEDOUT);
+}
+
 static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
 {
 	struct l2cap_conn *conn = hcon->l2cap_data;
@@ -772,7 +809,10 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
 	spin_lock_init(&conn->lock);
 	rwlock_init(&conn->chan_list.lock);
 
-	if (hcon->type != LE_LINK)
+	if (hcon->type == LE_LINK)
+		setup_timer(&conn->security_timer, security_timeout,
+						(unsigned long) conn);
+	else
 		setup_timer(&conn->info_timer, l2cap_info_timeout,
 						(unsigned long) conn);
 
@@ -781,33 +821,6 @@ static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
 	return conn;
 }
 
-static void l2cap_conn_del(struct hci_conn *hcon, int err)
-{
-	struct l2cap_conn *conn = hcon->l2cap_data;
-	struct sock *sk;
-
-	if (!conn)
-		return;
-
-	BT_DBG("hcon %p conn %p, err %d", hcon, conn, err);
-
-	kfree_skb(conn->rx_skb);
-
-	/* Kill channels */
-	while ((sk = conn->chan_list.head)) {
-		bh_lock_sock(sk);
-		l2cap_chan_del(sk, err);
-		bh_unlock_sock(sk);
-		l2cap_sock_kill(sk);
-	}
-
-	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
-		del_timer_sync(&conn->info_timer);
-
-	hcon->l2cap_data = NULL;
-	kfree(conn);
-}
-
 static inline void l2cap_chan_add(struct l2cap_conn *conn, struct sock *sk, struct sock *parent)
 {
 	struct l2cap_chan_list *l = &conn->chan_list;
@@ -3794,6 +3807,7 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 		if (l2cap_pi(sk)->scid == L2CAP_CID_LE_DATA) {
 			if (!status && encrypt) {
 				l2cap_pi(sk)->sec_level = hcon->sec_level;
+				del_timer(&conn->security_timer);
 				l2cap_chan_ready(sk);
 			}
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 496a1ba..33a2932 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -27,6 +27,8 @@
 #include <linux/crypto.h>
 #include <crypto/b128ops.h>
 
+#define SMP_TIMEOUT 30000 /* 30 seconds */
+
 static inline void swap128(u8 src[16], u8 dst[16])
 {
 	int i;
@@ -232,6 +234,9 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	smp_send_cmd(conn, SMP_CMD_PAIRING_RSP, sizeof(*rp), rp);
 
+	mod_timer(&conn->security_timer, jiffies +
+					msecs_to_jiffies(SMP_TIMEOUT));
+
 	return 0;
 }
 
@@ -306,6 +311,9 @@ static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 		smp_send_cmd(conn, SMP_CMD_PAIRING_CONFIRM, sizeof(cp), &cp);
 	}
 
+	mod_timer(&conn->security_timer, jiffies +
+					msecs_to_jiffies(SMP_TIMEOUT));
+
 	return 0;
 }
 
@@ -384,6 +392,9 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
 
+	mod_timer(&conn->security_timer, jiffies +
+					msecs_to_jiffies(SMP_TIMEOUT));
+
 	set_bit(HCI_CONN_ENCRYPT_PEND, &hcon->pend);
 
 	return 0;
@@ -417,6 +428,9 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 		conn->preq[0] = SMP_CMD_PAIRING_REQ;
 		memcpy(&conn->preq[1], &cp, sizeof(cp));
 
+		mod_timer(&conn->security_timer, jiffies +
+					msecs_to_jiffies(SMP_TIMEOUT));
+
 		smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
 	} else {
 		struct smp_cmd_security_req cp;
-- 
1.7.4.1

