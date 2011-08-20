Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 07/11] Bluetooth: Use the smp_keys list for accessing SMP keys
Date: Fri, 19 Aug 2011 21:08:11 -0300
Message-Id: <1313798895-8705-8-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1313798895-8705-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1313798895-8705-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now that we have a separate key list for SMP, we may use it.

For now, there is only support for the Short Term Key (which should
be used only once) and LTK (which should be sent to userspace for
storage).

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |   26 +++----------
 include/net/bluetooth/mgmt.h     |    2 -
 net/bluetooth/hci_core.c         |   73 +++++++++++++++++++------------------
 net/bluetooth/hci_event.c        |   13 ++++---
 net/bluetooth/mgmt.c             |    4 ++-
 net/bluetooth/smp.c              |   26 +++++++------
 6 files changed, 68 insertions(+), 76 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 94097fd..15ee163 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -75,20 +75,6 @@ struct bt_uuid {
 	u8 svc_hint;
 };
 
-struct key_master_id {
-	__le16 ediv;
-	u8 rand[8];
-} __packed;
-
-struct link_key_data {
-	bdaddr_t bdaddr;
-	u8 type;
-	u8 val[16];
-	u8 pin_len;
-	u8 dlen;
-	u8 data[0];
-} __packed;
-
 struct smp_ltk_info {
 	u8 enc_size;
 	u16 ediv;
@@ -117,8 +103,6 @@ struct link_key {
 	u8 type;
 	u8 val[16];
 	u8 pin_len;
-	u8 dlen;
-	u8 data[0];
 };
 
 struct oob_data {
@@ -578,11 +562,13 @@ struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 			bdaddr_t *bdaddr, u8 *val, u8 type, u8 pin_len);
 int hci_smp_keys_clear(struct hci_dev *hdev);
-struct link_key *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8]);
-struct link_key *hci_find_link_key_type(struct hci_dev *hdev,
+struct smp_link_key *hci_find_smp_enc_key(struct hci_dev *hdev, __le16 ediv,
+							u8 rand[8]);
+struct smp_link_key *hci_find_smp_key_type(struct hci_dev *hdev,
 					bdaddr_t *bdaddr, u8 type);
-int hci_add_ltk(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
-			u8 key_size, __le16 ediv, u8 rand[8], u8 ltk[16]);
+int hci_add_smp_enc_key(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 new_key,
+					u8 type, u8 pin_len, u8 tk[16],
+					u8 enc_size, u16 ediv, u8 rand[8]);
 int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
 
 int hci_remote_oob_data_clear(struct hci_dev *hdev);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index f2f09bc..6d103a6 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -101,8 +101,6 @@ struct mgmt_key_info {
 	u8 type;
 	u8 val[16];
 	u8 pin_len;
-	u8 dlen;
-	u8 data[0];
 } __packed;
 
 #define MGMT_OP_LOAD_KEYS		0x000D
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c650e9b..f53ae60 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1069,41 +1069,42 @@ static int hci_persistent_key(struct hci_dev *hdev, struct hci_conn *conn,
 	return 0;
 }
 
-struct link_key *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8])
+/* In the case that the key returned is a STK it should be freed after use */
+struct smp_link_key *hci_find_smp_enc_key(struct hci_dev *hdev, __le16 ediv,
+								u8 rand[8])
 {
-	struct link_key *k;
+	struct smp_link_key *k, *tmp;
 
-	list_for_each_entry(k, &hdev->link_keys, list) {
-		struct key_master_id *id;
+	list_for_each_entry_safe(k, tmp, &hdev->smp_keys, list) {
+		struct smp_ltk_info *info = &k->ltk;
 
-		if (k->type != HCI_LK_SMP_LTK)
+		if (info->ediv != ediv ||
+				memcmp(rand, info->rand, sizeof(info->rand)))
 			continue;
 
-		if (k->dlen != sizeof(*id))
-			continue;
+		/* The STK should be used just once */
+		if (k->type == HCI_LK_SMP_STK)
+			list_del(&k->list);
 
-		id = (void *) &k->data;
-		if (id->ediv == ediv &&
-				(memcmp(rand, id->rand, sizeof(id->rand)) == 0))
-			return k;
+		return k;
 	}
 
 	return NULL;
 }
-EXPORT_SYMBOL(hci_find_ltk);
+EXPORT_SYMBOL(hci_find_smp_enc_key);
 
-struct link_key *hci_find_link_key_type(struct hci_dev *hdev,
+struct smp_link_key *hci_find_smp_key_type(struct hci_dev *hdev,
 					bdaddr_t *bdaddr, u8 type)
 {
-	struct link_key *k;
+	struct smp_link_key *k;
 
-	list_for_each_entry(k, &hdev->link_keys, list)
+	list_for_each_entry(k, &hdev->smp_keys, list)
 		if (k->type == type && bacmp(bdaddr, &k->bdaddr) == 0)
 			return k;
 
 	return NULL;
 }
-EXPORT_SYMBOL(hci_find_link_key_type);
+EXPORT_SYMBOL(hci_find_smp_key_type);
 
 int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 				bdaddr_t *bdaddr, u8 *val, u8 type, u8 pin_len)
@@ -1160,40 +1161,40 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 	return 0;
 }
 
-int hci_add_ltk(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
-			u8 key_size, __le16 ediv, u8 rand[8], u8 ltk[16])
+int hci_add_smp_enc_key(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 new_key,
+					u8 type, u8 pin_len, u8 tk[16],
+					u8 enc_size, u16 ediv, u8 rand[8])
 {
-	struct link_key *key, *old_key;
-	struct key_master_id *id;
-	u8 old_key_type;
+	struct smp_link_key *key, *old_key;
+	struct smp_ltk_info *info;
+
+	BT_DBG("%s addr %s type 0x%2.2x", hdev->name, batostr(bdaddr), type);
 
-	BT_DBG("%s addr %s", hdev->name, batostr(bdaddr));
+	if (type != HCI_LK_SMP_STK && type != HCI_LK_SMP_LTK)
+		return 0;
 
-	old_key = hci_find_link_key_type(hdev, bdaddr, HCI_LK_SMP_LTK);
+	old_key = hci_find_smp_key_type(hdev, bdaddr, type);
 	if (old_key) {
 		key = old_key;
-		old_key_type = old_key->type;
 	} else {
-		key = kzalloc(sizeof(*key) + sizeof(*id), GFP_ATOMIC);
+		key = kzalloc(sizeof(*key), GFP_ATOMIC);
 		if (!key)
 			return -ENOMEM;
-		list_add(&key->list, &hdev->link_keys);
-		old_key_type = 0xff;
+		list_add(&key->list, &hdev->smp_keys);
 	}
 
-	key->dlen = sizeof(*id);
-
 	bacpy(&key->bdaddr, bdaddr);
-	memcpy(key->val, ltk, sizeof(key->val));
-	key->type = HCI_LK_SMP_LTK;
-	key->pin_len = key_size;
+	memcpy(key->val, tk, sizeof(key->val));
+	key->pin_len = pin_len;
+	key->type = type;
 
-	id = (void *) &key->data;
-	id->ediv = ediv;
-	memcpy(id->rand, rand, sizeof(id->rand));
+	info = &key->ltk;
+	info->enc_size = enc_size;
+	info->ediv = ediv;
+	memcpy(info->rand, rand, sizeof(info->rand));
 
 	if (new_key)
-		mgmt_new_key(hdev->id, key, old_key_type);
+		mgmt_new_smp_key(hdev->id, key, 1);
 
 	return 0;
 }
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8483cab..bfab54c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2860,7 +2860,7 @@ static inline void hci_le_ltk_request_evt(struct hci_dev *hdev,
 	struct hci_cp_le_ltk_reply cp;
 	struct hci_cp_le_ltk_neg_reply neg;
 	struct hci_conn *conn;
-	struct link_key *ltk;
+	struct smp_link_key *tk;
 
 	BT_DBG("%s handle %d", hdev->name, cpu_to_le16(ev->handle));
 
@@ -2870,16 +2870,19 @@ static inline void hci_le_ltk_request_evt(struct hci_dev *hdev,
 	if (conn == NULL)
 		goto not_found;
 
-	ltk = hci_find_ltk(hdev, ev->ediv, ev->random);
-	if (ltk == NULL)
+	tk = hci_find_smp_enc_key(hdev, ev->ediv, ev->random);
+	if (tk == NULL)
 		goto not_found;
 
-	memcpy(cp.ltk, ltk->val, sizeof(ltk->val));
+	memcpy(cp.ltk, tk->val, sizeof(tk->val));
 	cp.handle = cpu_to_le16(conn->handle);
-	conn->pin_length = ltk->pin_len;
+	conn->pin_length = tk->pin_len;
 
 	hci_send_cmd(hdev, HCI_OP_LE_LTK_REPLY, sizeof(cp), &cp);
 
+	if (tk->type == HCI_LK_SMP_STK)
+		kfree(tk);
+
 	hci_dev_unlock(hdev);
 
 	return;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ebe6c3f..2e73b77 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1793,7 +1793,9 @@ static int load_smp_keys(struct sock *sk, u16 index, unsigned char *data,
 
 		case HCI_LK_SMP_LTK:
 			ltk = &key->ltk;
-			/* Add key to the smp list */
+			hci_add_smp_enc_key(hdev, &key->bdaddr, 0, key->type,
+					key->pin_len, key->val, ltk->enc_size,
+					ltk->ediv, ltk->rand);
 			break;
 
 		default:
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index eb9e3e7..4531681 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -363,8 +363,8 @@ static void random_work(struct work_struct *work)
 		memset(stk + smp->enc_size, 0,
 				SMP_MAX_ENC_KEY_SIZE - smp->enc_size);
 
-		hci_add_ltk(hcon->hdev, 0, conn->dst, smp->enc_size,
-							ediv, rand, stk);
+		hci_add_smp_enc_key(hcon->hdev, conn->dst, 0, HCI_LK_SMP_STK,
+				0, stk, smp->enc_size, ediv, rand);
 	}
 
 	return;
@@ -515,11 +515,11 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 
 static u8 smp_ltk_encrypt(struct l2cap_conn *conn)
 {
-	struct link_key *key;
-	struct key_master_id *master;
+	struct smp_link_key *key;
+	struct smp_ltk_info *info;
 	struct hci_conn *hcon = conn->hcon;
 
-	key = hci_find_link_key_type(hcon->hdev, conn->dst,
+	key = hci_find_smp_key_type(hcon->hdev, conn->dst,
 						HCI_LK_SMP_LTK);
 	if (!key)
 		return 0;
@@ -528,10 +528,10 @@ static u8 smp_ltk_encrypt(struct l2cap_conn *conn)
 					&hcon->pend))
 		return 1;
 
-	master = (void *) key->data;
-	hci_le_start_enc(hcon, master->ediv, master->rand,
+	info = &key->ltk;
+	hci_le_start_enc(hcon, info->ediv, info->rand,
 						key->val);
-	hcon->enc_key_size = key->pin_len;
+	hcon->enc_key_size = info->enc_size;
 
 	return 1;
 
@@ -630,8 +630,9 @@ static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	skb_pull(skb, sizeof(*rp));
 
-	hci_add_ltk(conn->hcon->hdev, 1, conn->src, smp->enc_size,
-						rp->ediv, rp->rand, smp->tk);
+	hci_add_smp_enc_key(conn->hcon->hdev, conn->dst, 1, HCI_LK_SMP_LTK,
+					conn->hcon->pin_length, smp->tk,
+					smp->enc_size, rp->ediv, rp->rand);
 
 	smp_distribute_keys(conn, 1);
 
@@ -754,8 +755,9 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 
 		smp_send_cmd(conn, SMP_CMD_ENCRYPT_INFO, sizeof(enc), &enc);
 
-		hci_add_ltk(conn->hcon->hdev, 1, conn->dst, smp->enc_size,
-						ediv, ident.rand, enc.ltk);
+		hci_add_smp_enc_key(conn->hcon->hdev, conn->src, 1,
+				HCI_LK_SMP_LTK, conn->hcon->pin_length,
+				enc.ltk, smp->enc_size, ediv, ident.rand);
 
 		ident.ediv = cpu_to_le16(ediv);
 
-- 
1.7.6

