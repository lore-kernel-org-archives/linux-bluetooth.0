Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH 4/8] Bluetooth: Change SMP procedures to use the new key structures
Date: Thu, 10 Nov 2011 22:03:52 -0300
Message-Id: <1320973436-13399-5-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1320973436-13399-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1320973436-13399-1-git-send-email-vinicius.gomes@openbossa.org>
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
 net/bluetooth/smp.c              |   32 +++++++-----
 5 files changed, 105 insertions(+), 74 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a67ff88..ee660ce 100644
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
@@ -227,6 +222,8 @@ struct hci_dev {
 
 	struct list_head	link_keys;
 
+	struct list_head	ltks;
+
 	struct list_head	remote_oob_data;
 
 	struct list_head	adv_entries;
@@ -628,12 +625,14 @@ int hci_link_keys_clear(struct hci_dev *hdev);
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
index fb3feeb..0f3e534 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1017,6 +1017,18 @@ int hci_link_keys_clear(struct hci_dev *hdev)
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
@@ -1064,41 +1076,38 @@ static int hci_persistent_key(struct hci_dev *hdev, struct hci_conn *conn,
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
@@ -1155,40 +1164,31 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
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
@@ -1209,6 +1209,23 @@ int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
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
@@ -1493,6 +1510,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	INIT_LIST_HEAD(&hdev->uuids);
 
 	INIT_LIST_HEAD(&hdev->link_keys);
+	INIT_LIST_HEAD(&hdev->ltks);
 
 	INIT_LIST_HEAD(&hdev->remote_oob_data);
 
@@ -1593,6 +1611,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	hci_blacklist_clear(hdev);
 	hci_uuids_clear(hdev);
 	hci_link_keys_clear(hdev);
+	hci_smp_ltks_clear(hdev);
 	hci_remote_oob_data_clear(hdev);
 	hci_adv_entries_clear(hdev);
 	hci_dev_unlock_bh(hdev);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0d55d00..3df4ec7 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2919,7 +2919,7 @@ static inline void hci_le_ltk_request_evt(struct hci_dev *hdev,
 	struct hci_cp_le_ltk_reply cp;
 	struct hci_cp_le_ltk_neg_reply neg;
 	struct hci_conn *conn;
-	struct link_key *ltk;
+	struct smp_ltk *ltk;
 
 	BT_DBG("%s handle %d", hdev->name, cpu_to_le16(ev->handle));
 
@@ -2939,6 +2939,9 @@ static inline void hci_le_ltk_request_evt(struct hci_dev *hdev,
 
 	hci_send_cmd(hdev, HCI_OP_LE_LTK_REPLY, sizeof(cp), &cp);
 
+	if (ltk->type == HCI_LK_SMP_STK)
+		kfree(ltk);
+
 	hci_dev_unlock(hdev);
 
 	return;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5562c21..7378d22 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -981,6 +981,12 @@ static int remove_keys(struct sock *sk, u16 index, unsigned char *data,
 	memset(&rp, 0, sizeof(rp));
 	bacpy(&rp.bdaddr, &cp->bdaddr);
 
+	err = hci_remove_ltk(hdev, &cp->bdaddr);
+	if (err < 0) {
+		err = cmd_status(sk, index, MGMT_OP_REMOVE_KEYS, -err);
+		goto unlock;
+	}
+
 	err = hci_remove_link_key(hdev, &cp->bdaddr);
 	if (err < 0)
 		goto unlock;
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index e30bf6a..028de8e 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -347,8 +347,8 @@ static void random_work(struct work_struct *work)
 		memset(stk + smp->enc_size, 0,
 				SMP_MAX_ENC_KEY_SIZE - smp->enc_size);
 
-		hci_add_ltk(hcon->hdev, 0, conn->dst, smp->enc_size,
-							ediv, rand, stk);
+		hci_add_ltk(hcon->hdev, conn->dst, HCI_LK_SMP_STK, 0,
+				0, stk, smp->enc_size, ediv, rand);
 	}
 
 	return;
@@ -502,12 +502,10 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 
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
 
@@ -515,10 +513,8 @@ static u8 smp_ltk_encrypt(struct l2cap_conn *conn)
 					&hcon->pend))
 		return 1;
 
-	master = (void *) key->data;
-	hci_le_start_enc(hcon, master->ediv, master->rand,
-						key->val);
-	hcon->enc_key_size = key->pin_len;
+	hci_le_start_enc(hcon, key->ediv, key->rand, key->val);
+	hcon->enc_key_size = key->enc_size;
 
 	return 1;
 
@@ -616,11 +612,15 @@ static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_cmd_master_ident *rp = (void *) skb->data;
 	struct smp_chan *smp = conn->smp_chan;
+	struct hci_dev *hdev = conn->hcon->hdev;
 
 	skb_pull(skb, sizeof(*rp));
 
-	hci_add_ltk(conn->hcon->hdev, 1, conn->src, smp->enc_size,
-						rp->ediv, rp->rand, smp->tk);
+	hci_dev_lock(hdev);
+	hci_add_ltk(conn->hcon->hdev, conn->dst, HCI_LK_SMP_LTK, 1,
+					conn->hcon->pin_length, smp->tk,
+					smp->enc_size, rp->ediv, rp->rand);
+	hci_dev_unlock(hdev);
 
 	smp_distribute_keys(conn, 1);
 
@@ -703,6 +703,7 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 {
 	struct smp_cmd_pairing *req, *rsp;
 	struct smp_chan *smp = conn->smp_chan;
+	struct hci_dev *hdev = conn->hcon->hdev;
 	__u8 *keydist;
 
 	BT_DBG("conn %p force %d", conn, force);
@@ -740,8 +741,11 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 
 		smp_send_cmd(conn, SMP_CMD_ENCRYPT_INFO, sizeof(enc), &enc);
 
-		hci_add_ltk(conn->hcon->hdev, 1, conn->dst, smp->enc_size,
-						ediv, ident.rand, enc.ltk);
+		hci_dev_lock(hdev);
+		hci_add_ltk(conn->hcon->hdev, conn->src, HCI_LK_SMP_LTK, 1,
+					conn->hcon->pin_length, enc.ltk,
+					smp->enc_size, ediv, ident.rand);
+		hci_dev_unlock(hdev);
 
 		ident.ediv = cpu_to_le16(ediv);
 
-- 
1.7.7

