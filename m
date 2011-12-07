Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 4/8] Bluetooth: Change SMP procedures to use the new key structures
Date: Tue,  6 Dec 2011 21:48:08 -0300
Message-Id: <1323218892-15785-5-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1323218892-15785-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1323218892-15785-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Using separated messages and list for Long Term Keys allow simplification
of the code.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |   31 +++++------
 net/bluetooth/hci_core.c         |  105 ++++++++++++++++++++++---------------
 net/bluetooth/hci_event.c        |    5 ++-
 net/bluetooth/mgmt.c             |    6 ++
 net/bluetooth/smp.c              |   29 +++++-----
 5 files changed, 102 insertions(+), 74 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e34cd71..6939012 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -84,18 +84,15 @@ struct bt_uuid {
 	u8 svc_hint;
 };
 
-struct key_master_id {
-	__le16 ediv;
-	u8 rand[8];
-} __packed;
-
-struct link_key_data {
+struct smp_ltk {
+	struct list_head list;
 	bdaddr_t bdaddr;
+	u8 pin_len;
 	u8 type;
+	u8 enc_size;
+	__le16 ediv;
+	u8 rand[8];
 	u8 val[16];
-	u8 pin_len;
-	u8 dlen;
-	u8 data[0];
 } __packed;
 
 struct link_key {
@@ -104,8 +101,6 @@ struct link_key {
 	u8 type;
 	u8 val[16];
 	u8 pin_len;
-	u8 dlen;
-	u8 data[0];
 };
 
 struct oob_data {
@@ -229,6 +224,8 @@ struct hci_dev {
 
 	struct list_head	link_keys;
 
+	struct list_head	ltks;
+
 	struct list_head	remote_oob_data;
 
 	struct list_head	adv_entries;
@@ -632,12 +629,14 @@ int hci_link_keys_clear(struct hci_dev *hdev);
 struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 			bdaddr_t *bdaddr, u8 *val, u8 type, u8 pin_len);
-struct link_key *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8]);
-struct link_key *hci_find_link_key_type(struct hci_dev *hdev,
-					bdaddr_t *bdaddr, u8 type);
-int hci_add_ltk(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
-			u8 key_size, __le16 ediv, u8 rand[8], u8 ltk[16]);
+int hci_smp_ltks_clear(struct hci_dev *hdev);
+struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8]);
+struct smp_ltk *hci_find_ltk_addr(struct hci_dev *hdev, bdaddr_t *bdaddr);
+int hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type, int new_key,
+					u8 pin_len, u8 tk[16], u8 enc_size,
+					u16 ediv, u8 rand[8]);
 int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
+int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr);
 
 int hci_remote_oob_data_clear(struct hci_dev *hdev);
 struct oob_data *hci_find_remote_oob_data(struct hci_dev *hdev,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ce3727e..5b819cd 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1008,6 +1008,18 @@ int hci_link_keys_clear(struct hci_dev *hdev)
 	return 0;
 }
 
+int hci_smp_ltks_clear(struct hci_dev *hdev)
+{
+	struct smp_ltk *k, *tmp;
+
+	list_for_each_entry_safe(k, tmp, &hdev->ltks, list) {
+		list_del(&k->list);
+		kfree(k);
+	}
+
+	return 0;
+}
+
 struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 {
 	struct link_key *k;
@@ -1055,41 +1067,38 @@ static int hci_persistent_key(struct hci_dev *hdev, struct hci_conn *conn,
 	return 0;
 }
 
-struct link_key *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8])
+/* If the returned key is a STK it should be free'd by the caller */
+struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8])
 {
-	struct link_key *k;
-
-	list_for_each_entry(k, &hdev->link_keys, list) {
-		struct key_master_id *id;
+	struct smp_ltk *k, *tmp;
 
-		if (k->type != HCI_LK_SMP_LTK)
+	list_for_each_entry_safe(k, tmp, &hdev->ltks, list) {
+		if (k->ediv != ediv ||
+				memcmp(rand, k->rand, sizeof(k->rand)))
 			continue;
 
-		if (k->dlen != sizeof(*id))
-			continue;
+		/* The STK should only be used once, no need to keep it */
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
 EXPORT_SYMBOL(hci_find_ltk);
 
-struct link_key *hci_find_link_key_type(struct hci_dev *hdev,
-					bdaddr_t *bdaddr, u8 type)
+struct smp_ltk *hci_find_ltk_addr(struct hci_dev *hdev, bdaddr_t *bdaddr)
 {
-	struct link_key *k;
+	struct smp_ltk *k;
 
-	list_for_each_entry(k, &hdev->link_keys, list)
-		if (k->type == type && bacmp(bdaddr, &k->bdaddr) == 0)
+	list_for_each_entry(k, &hdev->ltks, list)
+		if (bacmp(bdaddr, &k->bdaddr) == 0)
 			return k;
 
 	return NULL;
 }
-EXPORT_SYMBOL(hci_find_link_key_type);
+EXPORT_SYMBOL(hci_find_ltk_addr);
 
 int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 				bdaddr_t *bdaddr, u8 *val, u8 type, u8 pin_len)
@@ -1146,40 +1155,31 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 	return 0;
 }
 
-int hci_add_ltk(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
-			u8 key_size, __le16 ediv, u8 rand[8], u8 ltk[16])
+int hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type, int new_key,
+					u8 pin_len, u8 tk[16], u8 enc_size,
+					u16 ediv, u8 rand[8])
 {
-	struct link_key *key, *old_key;
-	struct key_master_id *id;
-	u8 old_key_type;
+	struct smp_ltk *key, *old_key;
 
-	BT_DBG("%s addr %s", hdev->name, batostr(bdaddr));
+	if (type != HCI_LK_SMP_STK && type != HCI_LK_SMP_LTK)
+		return 0;
 
-	old_key = hci_find_link_key_type(hdev, bdaddr, HCI_LK_SMP_LTK);
-	if (old_key) {
+	old_key = hci_find_ltk_addr(hdev, bdaddr);
+	if (old_key)
 		key = old_key;
-		old_key_type = old_key->type;
-	} else {
-		key = kzalloc(sizeof(*key) + sizeof(*id), GFP_ATOMIC);
+	else {
+		key = kzalloc(sizeof(*key), GFP_ATOMIC);
 		if (!key)
 			return -ENOMEM;
-		list_add(&key->list, &hdev->link_keys);
-		old_key_type = 0xff;
+		list_add(&key->list, &hdev->ltks);
 	}
 
-	key->dlen = sizeof(*id);
-
 	bacpy(&key->bdaddr, bdaddr);
-	memcpy(key->val, ltk, sizeof(key->val));
-	key->type = HCI_LK_SMP_LTK;
-	key->pin_len = key_size;
-
-	id = (void *) &key->data;
-	id->ediv = ediv;
-	memcpy(id->rand, rand, sizeof(id->rand));
-
-	if (new_key)
-		mgmt_new_link_key(hdev, key, old_key_type);
+	memcpy(key->val, tk, sizeof(key->val));
+	key->pin_len = pin_len;
+	key->ediv = ediv;
+	key->enc_size = enc_size;
+	memcpy(key->rand, rand, sizeof(key->rand));
 
 	return 0;
 }
@@ -1200,6 +1200,23 @@ int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 	return 0;
 }
 
+int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr)
+{
+	struct smp_ltk *k, *tmp;
+
+	list_for_each_entry_safe(k, tmp, &hdev->ltks, list) {
+		if (bacmp(bdaddr, &k->bdaddr))
+			continue;
+
+		BT_DBG("%s removing %s", hdev->name, batostr(bdaddr));
+
+		list_del(&k->list);
+		kfree(k);
+	}
+
+	return 0;
+}
+
 /* HCI command timer function */
 static void hci_cmd_timer(unsigned long arg)
 {
@@ -1483,6 +1500,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	INIT_LIST_HEAD(&hdev->uuids);
 
 	INIT_LIST_HEAD(&hdev->link_keys);
+	INIT_LIST_HEAD(&hdev->ltks);
 
 	INIT_LIST_HEAD(&hdev->remote_oob_data);
 
@@ -1583,6 +1601,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	hci_blacklist_clear(hdev);
 	hci_uuids_clear(hdev);
 	hci_link_keys_clear(hdev);
+	hci_smp_ltks_clear(hdev);
 	hci_remote_oob_data_clear(hdev);
 	hci_adv_entries_clear(hdev);
 	hci_dev_unlock_bh(hdev);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 35cb56e..f2006e9 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3012,7 +3012,7 @@ static inline void hci_le_ltk_request_evt(struct hci_dev *hdev,
 	struct hci_cp_le_ltk_reply cp;
 	struct hci_cp_le_ltk_neg_reply neg;
 	struct hci_conn *conn;
-	struct link_key *ltk;
+	struct smp_ltk *ltk;
 
 	BT_DBG("%s handle %d", hdev->name, cpu_to_le16(ev->handle));
 
@@ -3032,6 +3032,9 @@ static inline void hci_le_ltk_request_evt(struct hci_dev *hdev,
 
 	hci_send_cmd(hdev, HCI_OP_LE_LTK_REPLY, sizeof(cp), &cp);
 
+	if (ltk->type == HCI_LK_SMP_STK)
+		kfree(ltk);
+
 	hci_dev_unlock(hdev);
 
 	return;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 7a23f21..49729fa 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1088,6 +1088,12 @@ static int remove_keys(struct sock *sk, u16 index, unsigned char *data,
 	bacpy(&rp.bdaddr, &cp->bdaddr);
 	rp.status = MGMT_STATUS_FAILED;
 
+	err = hci_remove_ltk(hdev, &cp->bdaddr);
+	if (err < 0) {
+		err = cmd_status(sk, index, MGMT_OP_REMOVE_KEYS, -err);
+		goto unlock;
+	}
+
 	err = hci_remove_link_key(hdev, &cp->bdaddr);
 	if (err < 0) {
 		rp.status = MGMT_STATUS_NOT_PAIRED;
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index d943f9f..4763719 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -358,8 +358,8 @@ static void random_work(struct work_struct *work)
 		memset(stk + smp->enc_key_size, 0,
 				SMP_MAX_ENC_KEY_SIZE - smp->enc_key_size);
 
-		hci_add_ltk(hcon->hdev, 0, conn->dst, smp->enc_key_size,
-							ediv, rand, stk);
+		hci_add_ltk(hcon->hdev, conn->dst, HCI_LK_SMP_STK, 0,
+				0, stk, smp->enc_key_size, ediv, rand);
 	}
 
 	return;
@@ -520,12 +520,10 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 
 static u8 smp_ltk_encrypt(struct l2cap_conn *conn)
 {
-	struct link_key *key;
-	struct key_master_id *master;
+	struct smp_ltk *key;
 	struct hci_conn *hcon = conn->hcon;
 
-	key = hci_find_link_key_type(hcon->hdev, conn->dst,
-						HCI_LK_SMP_LTK);
+	key = hci_find_ltk_addr(hcon->hdev, conn->dst);
 	if (!key)
 		return 0;
 
@@ -533,10 +531,8 @@ static u8 smp_ltk_encrypt(struct l2cap_conn *conn)
 					&hcon->pend))
 		return 1;
 
-	master = (void *) key->data;
-	hci_le_start_enc(hcon, master->ediv, master->rand,
-						key->val);
-	hcon->enc_key_size = key->pin_len;
+	hci_le_start_enc(hcon, key->ediv, key->rand, key->val);
+	hcon->enc_key_size = key->enc_size;
 
 	return 1;
 
@@ -634,13 +630,17 @@ static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_cmd_master_ident *rp = (void *) skb->data;
 	struct smp_chan *smp = conn->smp_chan;
+	struct hci_dev *hdev = conn->hcon->hdev;
 
 	skb_pull(skb, sizeof(*rp));
 
-	hci_add_ltk(conn->hcon->hdev, 1, conn->src, smp->enc_key_size,
-						rp->ediv, rp->rand, smp->tk);
+	hci_dev_lock(hdev);
+	hci_add_ltk(conn->hcon->hdev, conn->dst, HCI_LK_SMP_LTK, 1,
+					conn->hcon->pin_length, smp->tk,
+					smp->enc_key_size, rp->ediv, rp->rand);
 
 	smp_distribute_keys(conn, 1);
+	hci_dev_unlock(hdev);
 
 	return 0;
 }
@@ -758,8 +758,9 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 
 		smp_send_cmd(conn, SMP_CMD_ENCRYPT_INFO, sizeof(enc), &enc);
 
-		hci_add_ltk(conn->hcon->hdev, 1, conn->dst, smp->enc_key_size,
-						ediv, ident.rand, enc.ltk);
+		hci_add_ltk(conn->hcon->hdev, conn->src, HCI_LK_SMP_LTK, 1,
+					conn->hcon->pin_length, enc.ltk,
+					smp->enc_key_size, ediv, ident.rand);
 
 		ident.ediv = cpu_to_le16(ediv);
 
-- 
1.7.8

