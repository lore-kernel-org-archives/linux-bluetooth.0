Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 3/7] Bluetooth: Use the updated key structures for handling LTKs
Date: Thu,  2 Feb 2012 21:08:01 -0300
Message-Id: <1328227685-27245-4-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1328227685-27245-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1328227685-27245-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This updates all the users of the older way, that was using the
link_keys list to store the SMP keys, to use the new way.

This includes defining new types for the keys, we have a type for each
combination of STK/LTK and Master/Slave.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |   11 +++--
 net/bluetooth/hci_core.c         |   76 ++++++++++++++++---------------------
 net/bluetooth/hci_event.c        |   11 ++++-
 net/bluetooth/smp.c              |   38 +++++++++++-------
 4 files changed, 71 insertions(+), 65 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c998176..3f22f03 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -658,12 +658,13 @@ int hci_link_keys_clear(struct hci_dev *hdev);
 struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 			bdaddr_t *bdaddr, u8 *val, u8 type, u8 pin_len);
-struct link_key *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8]);
-struct link_key *hci_find_link_key_type(struct hci_dev *hdev,
-					bdaddr_t *bdaddr, u8 type);
+struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8]);
+int hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type, u8 type,
+				int new_key, u8 authenticated, u8 tk[16],
+				u8 enc_size, u16 ediv, u8 rand[8]);
+struct smp_ltk *hci_find_ltk_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
+								u8 addr_type);
 int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr);
-int hci_add_ltk(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
-			u8 key_size, __le16 ediv, u8 rand[8], u8 ltk[16]);
 int hci_smp_ltks_clear(struct hci_dev *hdev);
 int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a28e637..ff519b5 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1222,41 +1222,35 @@ static int hci_persistent_key(struct hci_dev *hdev, struct hci_conn *conn,
 	return 0;
 }
 
-struct link_key *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8])
+struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8])
 {
-	struct link_key *k;
-
-	list_for_each_entry(k, &hdev->link_keys, list) {
-		struct key_master_id *id;
+	struct smp_ltk *k;
 
-		if (k->type != HCI_LK_SMP_LTK)
+	list_for_each_entry(k, &hdev->long_term_keys, list) {
+		if (k->ediv != ediv ||
+				memcmp(rand, k->rand, sizeof(k->rand)))
 			continue;
 
-		if (k->dlen != sizeof(*id))
-			continue;
-
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
+struct smp_ltk *hci_find_ltk_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
+								u8 addr_type)
 {
-	struct link_key *k;
+	struct smp_ltk *k;
 
-	list_for_each_entry(k, &hdev->link_keys, list)
-		if (k->type == type && bacmp(bdaddr, &k->bdaddr) == 0)
+	list_for_each_entry(k, &hdev->long_term_keys, list)
+		if (addr_type == k->bdaddr_type &&
+					bacmp(bdaddr, &k->bdaddr) == 0)
 			return k;
 
 	return NULL;
 }
-EXPORT_SYMBOL(hci_find_link_key_type);
+EXPORT_SYMBOL(hci_find_ltk_addr);
 
 int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 				bdaddr_t *bdaddr, u8 *val, u8 type, u8 pin_len)
@@ -1313,40 +1307,36 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 	return 0;
 }
 
-int hci_add_ltk(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
-			u8 key_size, __le16 ediv, u8 rand[8], u8 ltk[16])
+int hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type, u8 type,
+				int new_key, u8 authenticated, u8 tk[16],
+				u8 enc_size, u16 ediv, u8 rand[8])
 {
-	struct link_key *key, *old_key;
-	struct key_master_id *id;
-	u8 old_key_type;
+	struct smp_ltk *key, *old_key;
 
-	BT_DBG("%s addr %s", hdev->name, batostr(bdaddr));
+	if (!(type & HCI_SMP_STK) && !(type & HCI_SMP_LTK))
+		return 0;
 
-	old_key = hci_find_link_key_type(hdev, bdaddr, HCI_LK_SMP_LTK);
-	if (old_key) {
+	old_key = hci_find_ltk_addr(hdev, bdaddr, addr_type);
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
+		list_add(&key->list, &hdev->long_term_keys);
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
+	key->bdaddr_type = addr_type;
+	memcpy(key->val, tk, sizeof(key->val));
+	key->authenticated = authenticated;
+	key->ediv = ediv;
+	key->enc_size = enc_size;
+	key->type = type;
+	memcpy(key->rand, rand, sizeof(key->rand));
 
-	if (new_key)
-		mgmt_new_link_key(hdev, key, old_key_type);
+	if (!new_key)
+		return 0;
 
 	return 0;
 }
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a86f82b..23dbb31 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3256,7 +3256,7 @@ static inline void hci_le_ltk_request_evt(struct hci_dev *hdev,
 	struct hci_cp_le_ltk_reply cp;
 	struct hci_cp_le_ltk_neg_reply neg;
 	struct hci_conn *conn;
-	struct link_key *ltk;
+	struct smp_ltk *ltk;
 
 	BT_DBG("%s handle %d", hdev->name, cpu_to_le16(ev->handle));
 
@@ -3272,10 +3272,17 @@ static inline void hci_le_ltk_request_evt(struct hci_dev *hdev,
 
 	memcpy(cp.ltk, ltk->val, sizeof(ltk->val));
 	cp.handle = cpu_to_le16(conn->handle);
-	conn->pin_length = ltk->pin_len;
+
+	if (ltk->authenticated)
+		conn->sec_level = BT_SECURITY_HIGH;
 
 	hci_send_cmd(hdev, HCI_OP_LE_LTK_REPLY, sizeof(cp), &cp);
 
+	if (ltk->type & HCI_SMP_STK) {
+		list_del(&ltk->list);
+		kfree(ltk);
+	}
+
 	hci_dev_unlock(hdev);
 
 	return;
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 9ff56e1..19d1371 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -475,8 +475,9 @@ static void random_work(struct work_struct *work)
 		memset(stk + smp->enc_key_size, 0,
 				SMP_MAX_ENC_KEY_SIZE - smp->enc_key_size);
 
-		hci_add_ltk(hcon->hdev, 0, conn->dst, smp->enc_key_size,
-							ediv, rand, stk);
+		hci_add_ltk(hcon->hdev, conn->dst, hcon->dst_type,
+						HCI_SMP_STK_SLAVE, 0, 0, stk,
+						smp->enc_key_size, ediv, rand);
 	}
 
 	return;
@@ -701,22 +702,18 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 
 static u8 smp_ltk_encrypt(struct l2cap_conn *conn)
 {
-	struct link_key *key;
-	struct key_master_id *master;
+	struct smp_ltk *key;
 	struct hci_conn *hcon = conn->hcon;
 
-	key = hci_find_link_key_type(hcon->hdev, conn->dst,
-						HCI_LK_SMP_LTK);
+	key = hci_find_ltk_addr(hcon->hdev, conn->dst, hcon->dst_type);
 	if (!key)
 		return 0;
 
 	if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND, &hcon->flags))
 		return 1;
 
-	master = (void *) key->data;
-	hci_le_start_enc(hcon, master->ediv, master->rand,
-						key->val);
-	hcon->enc_key_size = key->pin_len;
+	hci_le_start_enc(hcon, key->ediv, key->rand, key->val);
+	hcon->enc_key_size = key->enc_size;
 
 	return 1;
 
@@ -819,13 +816,19 @@ static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 {
 	struct smp_cmd_master_ident *rp = (void *) skb->data;
 	struct smp_chan *smp = conn->smp_chan;
+	struct hci_dev *hdev = conn->hcon->hdev;
+	struct hci_conn *hcon = conn->hcon;
+	u8 authenticated;
 
 	skb_pull(skb, sizeof(*rp));
 
-	hci_add_ltk(conn->hcon->hdev, 1, conn->dst, smp->enc_key_size,
-						rp->ediv, rp->rand, smp->tk);
-
+	hci_dev_lock(hdev);
+	authenticated = (conn->hcon->sec_level == BT_SECURITY_HIGH);
+	hci_add_ltk(conn->hcon->hdev, conn->dst, hcon->dst_type,
+					HCI_SMP_LTK, 1, authenticated, smp->tk,
+					smp->enc_key_size, rp->ediv, rp->rand);
 	smp_distribute_keys(conn, 1);
+	hci_dev_unlock(hdev);
 
 	return 0;
 }
@@ -935,6 +938,8 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 	if (*keydist & SMP_DIST_ENC_KEY) {
 		struct smp_cmd_encrypt_info enc;
 		struct smp_cmd_master_ident ident;
+		struct hci_conn *hcon = conn->hcon;
+		u8 authenticated;
 		__le16 ediv;
 
 		get_random_bytes(enc.ltk, sizeof(enc.ltk));
@@ -943,8 +948,11 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 
 		smp_send_cmd(conn, SMP_CMD_ENCRYPT_INFO, sizeof(enc), &enc);
 
-		hci_add_ltk(conn->hcon->hdev, 1, conn->dst, smp->enc_key_size,
-						ediv, ident.rand, enc.ltk);
+		authenticated = hcon->sec_level == BT_SECURITY_HIGH;
+		hci_add_ltk(conn->hcon->hdev, conn->dst, hcon->dst_type,
+					HCI_SMP_LTK_SLAVE, 1, authenticated,
+					enc.ltk, smp->enc_key_size,
+					ediv, ident.rand);
 
 		ident.ediv = cpu_to_le16(ediv);
 
-- 
1.7.8.1

