Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 2/7] Bluetooth: Add a flag to indicate that SMP is going on
Date: Fri, 19 Aug 2011 21:06:51 -0300
Message-Id: <1313798816-8647-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1313798816-8647-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1313798816-8647-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add HCI_CONN_LE_SMP_PEND flag to indicate that SMP is pending
for that connection. This allows to have information that an SMP
procedure is going on for that connection.

We use the HCI_CONN_ENCRYPT_PEND to indicate that encryption
(HCI_LE_Start_Encryption) is pending for that connection.

While a SMP procedure is going on we hold an reference to the
connection, to avoid disconnections.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/l2cap_core.c       |    4 ++-
 net/bluetooth/smp.c              |   44 +++++++++++++++++++++++++++++--------
 3 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 8f441b8..4376780 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -348,6 +348,7 @@ enum {
 	HCI_CONN_RSWITCH_PEND,
 	HCI_CONN_MODE_CHANGE_PEND,
 	HCI_CONN_SCO_SETUP_PEND,
+	HCI_CONN_LE_SMP_PEND,
 };
 
 static inline void hci_conn_hash_init(struct hci_dev *hdev)
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index be30c32..d5ef9a2 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -986,8 +986,10 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
 		del_timer_sync(&conn->info_timer);
 
-	if (test_bit(HCI_CONN_ENCRYPT_PEND, &hcon->pend))
+	if (test_and_clear_bit(HCI_CONN_LE_SMP_PEND, &hcon->pend)) {
 		del_timer(&conn->security_timer);
+		hci_conn_put(hcon);
+	}
 
 	hcon->l2cap_data = NULL;
 	kfree(conn);
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 20c82c7..f0c67f6 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -248,6 +248,9 @@ static u8 smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	BT_DBG("conn %p", conn);
 
+	if (!test_and_set_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->pend))
+		hci_conn_hold(conn->hcon);
+
 	conn->preq[0] = SMP_CMD_PAIRING_REQ;
 	memcpy(&conn->preq[1], req, sizeof(*req));
 	skb_pull(skb, sizeof(*req));
@@ -397,6 +400,9 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 		memset(stk + conn->smp_key_size, 0,
 				SMP_MAX_ENC_KEY_SIZE - conn->smp_key_size);
 
+		if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND, &hcon->pend))
+			return SMP_UNSPECIFIED;
+
 		hci_le_start_enc(hcon, ediv, rand, stk);
 		hcon->enc_key_size = conn->smp_key_size;
 	} else {
@@ -430,9 +436,11 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	BT_DBG("conn %p", conn);
 
-	if (test_bit(HCI_CONN_ENCRYPT_PEND, &hcon->pend))
+	if (test_and_set_bit(HCI_CONN_LE_SMP_PEND, &hcon->pend))
 		return 0;
 
+	hci_conn_hold(hcon);
+
 	skb_pull(skb, sizeof(*rp));
 
 	memset(&cp, 0, sizeof(cp));
@@ -443,8 +451,6 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
 
-	set_bit(HCI_CONN_ENCRYPT_PEND, &hcon->pend);
-
 	return 0;
 }
 
@@ -461,19 +467,13 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 	if (IS_ERR(hcon->hdev->tfm))
 		return 1;
 
-	if (test_bit(HCI_CONN_ENCRYPT_PEND, &hcon->pend))
-		return 0;
-
 	if (sec_level == BT_SECURITY_LOW)
 		return 1;
 
 	if (hcon->sec_level >= sec_level)
 		return 1;
 
-	authreq = seclevel_to_authreq(sec_level);
-
 	if (hcon->link_mode & HCI_LM_MASTER) {
-		struct smp_cmd_pairing cp;
 		struct link_key *key;
 
 		key = hci_find_link_key_type(hcon->hdev, conn->dst,
@@ -481,12 +481,28 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 		if (key) {
 			struct key_master_id *master = (void *) key->data;
 
+			if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND,
+							&hcon->pend))
+				goto done;
+
 			hci_le_start_enc(hcon, master->ediv, master->rand,
 								key->val);
 			hcon->enc_key_size = key->pin_len;
 
 			goto done;
 		}
+	}
+
+	if (test_and_set_bit(HCI_CONN_LE_SMP_PEND, &hcon->pend))
+		return 0;
+
+	/* While SMP is going on */
+	hci_conn_hold(hcon);
+
+	authreq = seclevel_to_authreq(sec_level);
+
+	if (hcon->link_mode & HCI_LM_MASTER) {
+		struct smp_cmd_pairing cp;
 
 		build_pairing_cmd(conn, &cp, NULL, authreq);
 		conn->preq[0] = SMP_CMD_PAIRING_REQ;
@@ -501,7 +517,6 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 
 done:
 	hcon->pending_sec_level = sec_level;
-	set_bit(HCI_CONN_ENCRYPT_PEND, &hcon->pend);
 
 	return 0;
 }
@@ -619,6 +634,9 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 	if (IS_ERR(conn->hcon->hdev->tfm))
 		return PTR_ERR(conn->hcon->hdev->tfm);
 
+	if (!test_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->pend))
+		return 0;
+
 	rsp = (void *) &conn->prsp[1];
 
 	/* The responder sends its keys first */
@@ -689,5 +707,11 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 		*keydist &= ~SMP_DIST_SIGN;
 	}
 
+	if (conn->hcon->out || force) {
+		clear_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->pend);
+		del_timer(&conn->security_timer);
+		hci_conn_put(conn->hcon);
+	}
+
 	return 0;
 }
-- 
1.7.6

