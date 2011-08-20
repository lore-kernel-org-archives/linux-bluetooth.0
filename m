Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 01/11] Bluetooth: Use the LTK after receiving a LE Security Request
Date: Fri, 19 Aug 2011 21:08:05 -0300
Message-Id: <1313798895-8705-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1313798895-8705-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1313798895-8705-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When receiving a security request from the remote device we should find
if there is already a LTK associated with the remote device, if found
we should use it to encrypt the link.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 net/bluetooth/smp.c |   46 ++++++++++++++++++++++++++++------------------
 1 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 74afdb7..fd5e1ca 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -513,6 +513,29 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	return 0;
 }
 
+static u8 smp_ltk_encrypt(struct l2cap_conn *conn)
+{
+	struct link_key *key;
+	struct key_master_id *master;
+	struct hci_conn *hcon = conn->hcon;
+
+	key = hci_find_link_key_type(hcon->hdev, conn->dst,
+						HCI_LK_SMP_LTK);
+	if (!key)
+		return 0;
+
+	if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND,
+					&hcon->pend))
+		return 1;
+
+	master = (void *) key->data;
+	hci_le_start_enc(hcon, master->ediv, master->rand,
+						key->val);
+	hcon->enc_key_size = key->pin_len;
+
+	return 1;
+
+}
 static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_cmd_security_req *rp = (void *) skb->data;
@@ -522,6 +545,9 @@ static u8 smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	BT_DBG("conn %p", conn);
 
+	if (smp_ltk_encrypt(conn))
+		return 0;
+
 	if (test_and_set_bit(HCI_CONN_LE_SMP_PEND, &hcon->pend))
 		return 0;
 
@@ -556,25 +582,9 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 	if (hcon->sec_level >= sec_level)
 		return 1;
 
-	if (hcon->link_mode & HCI_LM_MASTER) {
-		struct link_key *key;
-
-		key = hci_find_link_key_type(hcon->hdev, conn->dst,
-							HCI_LK_SMP_LTK);
-		if (key) {
-			struct key_master_id *master = (void *) key->data;
-
-			if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND,
-							&hcon->pend))
-				goto done;
-
-			hci_le_start_enc(hcon, master->ediv, master->rand,
-								key->val);
-			hcon->enc_key_size = key->pin_len;
-
+	if (hcon->link_mode & HCI_LM_MASTER)
+		if (smp_ltk_encrypt(conn))
 			goto done;
-		}
-	}
 
 	if (test_and_set_bit(HCI_CONN_LE_SMP_PEND, &hcon->pend))
 		return 0;
-- 
1.7.6

