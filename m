Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC] Bluetooth: Add more specific types to SMP keys
Date: Tue,  6 Dec 2011 21:53:54 -0300
Message-Id: <1323219234-15903-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This way we can better identify which kind of key we exchanging
with userspace and userspace can take better decisions about
what to do with each type of key.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/hci.h  |   10 +++++-----
 include/net/bluetooth/mgmt.h |    1 +
 net/bluetooth/hci_core.c     |    7 ++++---
 net/bluetooth/hci_event.c    |    2 +-
 net/bluetooth/mgmt.c         |   15 ++++++++++++---
 net/bluetooth/smp.c          |    6 +++---
 6 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5eb236e..a916e19 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -267,11 +267,11 @@ enum {
 #define HCI_LK_UNAUTH_COMBINATION	0x04
 #define HCI_LK_AUTH_COMBINATION		0x05
 #define HCI_LK_CHANGED_COMBINATION	0x06
-/* The spec doesn't define types for SMP keys */
-#define HCI_LK_SMP_STK			0x80
-#define HCI_LK_SMP_LTK			0x81
-#define HCI_LK_SMP_IRK			0x82
-#define HCI_LK_SMP_CSRK			0x83
+/* The spec doesn't define types for SMP keys, the _MASTER suffix is implied */
+#define HCI_SMP_STK			0x80
+#define HCI_SMP_STK_SLAVE		0x81
+#define HCI_SMP_LTK			0x82
+#define HCI_SMP_LTK_SLAVE		0x83
 
 /* ---- HCI Error Codes ---- */
 #define HCI_ERROR_AUTH_FAILURE		0x05
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 0f100fa9..db11475 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -268,6 +268,7 @@ struct mgmt_ltk_info {
 	bdaddr_t bdaddr;
 	__u8 pin_len;
 	__u8 enc_size;
+	__u8 master;
 	__le16 ediv;
 	__u8 rand[8];
 	__u8 val[16];
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8d96125..f81c08b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1078,7 +1078,7 @@ struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8])
 			continue;
 
 		/* The STK should only be used once, no need to keep it */
-		if (k->type == HCI_LK_SMP_STK)
+		if (k->type & HCI_SMP_STK)
 			list_del(&k->list);
 
 		return k;
@@ -1161,7 +1161,7 @@ int hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type, int new_key,
 {
 	struct smp_ltk *key, *old_key;
 
-	if (type != HCI_LK_SMP_STK && type != HCI_LK_SMP_LTK)
+	if (!(type & HCI_SMP_STK) && !(type & HCI_SMP_LTK))
 		return 0;
 
 	old_key = hci_find_ltk_addr(hdev, bdaddr);
@@ -1179,12 +1179,13 @@ int hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type, int new_key,
 	key->pin_len = pin_len;
 	key->ediv = ediv;
 	key->enc_size = enc_size;
+	key->type = type;
 	memcpy(key->rand, rand, sizeof(key->rand));
 
 	if (!new_key)
 		return 0;
 
-	if (type == HCI_LK_SMP_LTK)
+	if (type & HCI_SMP_LTK)
 		mgmt_new_ltk(hdev, key, 1);
 
 	return 0;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index f2006e9..19cc22a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3032,7 +3032,7 @@ static inline void hci_le_ltk_request_evt(struct hci_dev *hdev,
 
 	hci_send_cmd(hdev, HCI_OP_LE_LTK_REPLY, sizeof(cp), &cp);
 
-	if (ltk->type == HCI_LK_SMP_STK)
+	if (ltk->type & HCI_SMP_STK)
 		kfree(ltk);
 
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f7314d1..fd509ca 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2104,10 +2104,15 @@ static int load_long_term_keys(struct sock *sk, u16 index,
 
 	for (i = 0; i < key_count; i++) {
 		struct mgmt_ltk_info *key = &cp->keys[i];
+		u8 type;
 
-		hci_add_ltk(hdev, &key->bdaddr, HCI_LK_SMP_LTK, 0,
-				key->pin_len, key->val, key->enc_size,
-				key->ediv, key->rand);
+		if (key->master)
+			type = HCI_SMP_LTK;
+		else
+			type = HCI_SMP_LTK_SLAVE;
+
+		hci_add_ltk(hdev, &key->bdaddr, type, 0, key->pin_len,
+				key->val, key->enc_size, key->ediv, key->rand);
 	}
 
 	hci_dev_unlock_bh(hdev);
@@ -2417,6 +2422,10 @@ int mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key, u8 persistent)
 	ev.key.pin_len = key->pin_len;
 	ev.key.enc_size = key->enc_size;
 	ev.key.ediv = key->ediv;
+
+	if (key->type == HCI_SMP_LTK)
+		ev.key.master = 1;
+
 	memcpy(ev.key.rand, key->rand, sizeof(key->rand));
 	memcpy(ev.key.val, key->val, sizeof(key->val));
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 4763719..14e554c 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -358,7 +358,7 @@ static void random_work(struct work_struct *work)
 		memset(stk + smp->enc_key_size, 0,
 				SMP_MAX_ENC_KEY_SIZE - smp->enc_key_size);
 
-		hci_add_ltk(hcon->hdev, conn->dst, HCI_LK_SMP_STK, 0,
+		hci_add_ltk(hcon->hdev, conn->dst, HCI_SMP_STK_SLAVE, 0,
 				0, stk, smp->enc_key_size, ediv, rand);
 	}
 
@@ -635,7 +635,7 @@ static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 	skb_pull(skb, sizeof(*rp));
 
 	hci_dev_lock(hdev);
-	hci_add_ltk(conn->hcon->hdev, conn->dst, HCI_LK_SMP_LTK, 1,
+	hci_add_ltk(conn->hcon->hdev, conn->dst, HCI_SMP_LTK, 1,
 					conn->hcon->pin_length, smp->tk,
 					smp->enc_key_size, rp->ediv, rp->rand);
 
@@ -758,7 +758,7 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 
 		smp_send_cmd(conn, SMP_CMD_ENCRYPT_INFO, sizeof(enc), &enc);
 
-		hci_add_ltk(conn->hcon->hdev, conn->src, HCI_LK_SMP_LTK, 1,
+		hci_add_ltk(conn->hcon->hdev, conn->src, HCI_SMP_LTK_SLAVE, 1,
 					conn->hcon->pin_length, enc.ltk,
 					smp->enc_key_size, ediv, ident.rand);
 
-- 
1.7.8

