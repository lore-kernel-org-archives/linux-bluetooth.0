Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: Use __le64 type for LE random numbers
Date: Thu, 27 Feb 2014 16:00:28 -0800
Message-Id: <1393545628-29566-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The random numbers in Bluetooth Low Energy are 64-bit numbers and should
also be little endian since the HCI specification is little endian.

Change the whole Low Energy pairing to use __le64 instead of a byte
array.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h      |  4 ++--
 include/net/bluetooth/hci_core.h |  8 ++++----
 include/net/bluetooth/mgmt.h     |  2 +-
 net/bluetooth/hci_conn.c         |  6 +++---
 net/bluetooth/hci_core.c         | 13 ++++++-------
 net/bluetooth/hci_event.c        |  2 +-
 net/bluetooth/mgmt.c             |  2 +-
 net/bluetooth/smp.c              | 22 ++++++++++------------
 net/bluetooth/smp.h              |  2 +-
 9 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c3834d3aecbb..4755a28ace85 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1219,7 +1219,7 @@ struct hci_cp_le_conn_update {
 #define HCI_OP_LE_START_ENC		0x2019
 struct hci_cp_le_start_enc {
 	__le16	handle;
-	__u8	rand[8];
+	__le64	rand;
 	__le16	ediv;
 	__u8	ltk[16];
 } __packed;
@@ -1631,7 +1631,7 @@ struct hci_ev_le_conn_complete {
 #define HCI_EV_LE_LTK_REQ		0x05
 struct hci_ev_le_ltk_req {
 	__le16	handle;
-	__u8	random[8];
+	__le64	rand;
 	__le16	ediv;
 } __packed;
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 093d05eeb3fa..f1652430dee8 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -99,7 +99,7 @@ struct smp_ltk {
 	u8 type;
 	u8 enc_size;
 	__le16 ediv;
-	u8 rand[8];
+	__le64 rand;
 	u8 val[16];
 };
 
@@ -822,11 +822,11 @@ void hci_link_keys_clear(struct hci_dev *hdev);
 struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
 int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 		     bdaddr_t *bdaddr, u8 *val, u8 type, u8 pin_len);
-struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8],
+struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, __le64 rand,
 			     bool master);
 struct smp_ltk *hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			    u8 addr_type, u8 type, u8 authenticated,
-			    u8 tk[16], u8 enc_size, __le16 ediv, u8 rand[8]);
+			    u8 tk[16], u8 enc_size, __le16 ediv, __le64 rand);
 struct smp_ltk *hci_find_ltk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				     u8 addr_type, bool master);
 int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 bdaddr_type);
@@ -1287,7 +1287,7 @@ struct hci_sec_filter {
 
 void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max,
 					u16 latency, u16 to_multiplier);
-void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
+void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
 							__u8 ltk[16]);
 
 int hci_update_random_address(struct hci_request *req, bool require_privacy,
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 62d560624e3d..0326648fd799 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -187,7 +187,7 @@ struct mgmt_ltk_info {
 	__u8	master;
 	__u8	enc_size;
 	__le16	ediv;
-	__u8	rand[8];
+	__le64	rand;
 	__u8	val[16];
 } __packed;
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 7d6f05e3cae8..5b0802994cbb 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -231,7 +231,7 @@ void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max,
 	hci_send_cmd(hdev, HCI_OP_LE_CONN_UPDATE, sizeof(cp), &cp);
 }
 
-void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
+void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
 		      __u8 ltk[16])
 {
 	struct hci_dev *hdev = conn->hdev;
@@ -242,9 +242,9 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
 	memset(&cp, 0, sizeof(cp));
 
 	cp.handle = cpu_to_le16(conn->handle);
-	memcpy(cp.ltk, ltk, sizeof(cp.ltk));
+	cp.rand = rand;
 	cp.ediv = ediv;
-	memcpy(cp.rand, rand, sizeof(cp.rand));
+	memcpy(cp.ltk, ltk, sizeof(cp.ltk));
 
 	hci_send_cmd(hdev, HCI_OP_LE_START_ENC, sizeof(cp), &cp);
 }
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 7113d4cc085f..ba888e2ef39e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -740,10 +740,10 @@ static int long_term_keys_show(struct seq_file *f, void *ptr)
 	hci_dev_lock(hdev);
 	list_for_each_safe(p, n, &hdev->long_term_keys) {
 		struct smp_ltk *ltk = list_entry(p, struct smp_ltk, list);
-		seq_printf(f, "%pMR (type %u) %u 0x%02x %u %.4x %*phN %*phN\n",
+		seq_printf(f, "%pMR (type %u) %u 0x%02x %u %.4x %.16llx %*phN\n",
 			   &ltk->bdaddr, ltk->bdaddr_type, ltk->authenticated,
 			   ltk->type, ltk->enc_size, __le16_to_cpu(ltk->ediv),
-			   8, ltk->rand, 16, ltk->val);
+			   __le64_to_cpu(ltk->rand), 16, ltk->val);
 	}
 	hci_dev_unlock(hdev);
 
@@ -2891,14 +2891,13 @@ static bool ltk_type_master(u8 type)
 	return false;
 }
 
-struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8],
+struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, __le64 rand,
 			     bool master)
 {
 	struct smp_ltk *k;
 
 	list_for_each_entry(k, &hdev->long_term_keys, list) {
-		if (k->ediv != ediv ||
-		    memcmp(rand, k->rand, sizeof(k->rand)))
+		if (k->ediv != ediv || k->rand != rand)
 			continue;
 
 		if (ltk_type_master(k->type) != master)
@@ -3016,7 +3015,7 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 
 struct smp_ltk *hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			    u8 addr_type, u8 type, u8 authenticated,
-			    u8 tk[16], u8 enc_size, __le16 ediv, u8 rand[8])
+			    u8 tk[16], u8 enc_size, __le16 ediv, __le64 rand)
 {
 	struct smp_ltk *key, *old_key;
 	bool master = ltk_type_master(type);
@@ -3036,9 +3035,9 @@ struct smp_ltk *hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr,
 	memcpy(key->val, tk, sizeof(key->val));
 	key->authenticated = authenticated;
 	key->ediv = ediv;
+	key->rand = rand;
 	key->enc_size = enc_size;
 	key->type = type;
-	memcpy(key->rand, rand, sizeof(key->rand));
 
 	return key;
 }
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 162235633bf5..40e5bfebb484 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3788,7 +3788,7 @@ static void hci_le_ltk_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (conn == NULL)
 		goto not_found;
 
-	ltk = hci_find_ltk(hdev, ev->ediv, ev->random, conn->out);
+	ltk = hci_find_ltk(hdev, ev->ediv, ev->rand, conn->out);
 	if (ltk == NULL)
 		goto not_found;
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 78ac7c864044..a271c482ecdc 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4995,11 +4995,11 @@ void mgmt_new_ltk(struct hci_dev *hdev, struct smp_ltk *key)
 	ev.key.type = key->authenticated;
 	ev.key.enc_size = key->enc_size;
 	ev.key.ediv = key->ediv;
+	ev.key.rand = key->rand;
 
 	if (key->type == HCI_SMP_LTK)
 		ev.key.master = 1;
 
-	memcpy(ev.key.rand, key->rand, sizeof(key->rand));
 	memcpy(ev.key.val, key->val, sizeof(key->val));
 
 	mgmt_event(MGMT_EV_NEW_LONG_TERM_KEY, hdev, &ev, sizeof(ev), NULL);
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 0de98fe23330..6ace0b48dc6a 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -517,11 +517,9 @@ static void random_work(struct work_struct *work)
 	}
 
 	if (hcon->out) {
-		u8 stk[16], rand[8];
-		__le16 ediv;
-
-		memset(rand, 0, sizeof(rand));
-		ediv = 0;
+		u8 stk[16];
+		__le64 rand = 0;
+		__le16 ediv = 0;
 
 		smp_s1(tfm, smp->tk, smp->rrnd, smp->prnd, key);
 		swap128(key, stk);
@@ -537,11 +535,9 @@ static void random_work(struct work_struct *work)
 		hci_le_start_enc(hcon, ediv, rand, stk);
 		hcon->enc_key_size = smp->enc_key_size;
 	} else {
-		u8 stk[16], r[16], rand[8];
-		__le16 ediv;
-
-		memset(rand, 0, sizeof(rand));
-		ediv = 0;
+		u8 stk[16], r[16];
+		__le16 rand = 0;
+		__le16 ediv = 0;
 
 		swap128(smp->prnd, r);
 		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(r), r);
@@ -1205,20 +1201,22 @@ int smp_distribute_keys(struct l2cap_conn *conn)
 		struct smp_ltk *ltk;
 		u8 authenticated;
 		__le16 ediv;
+		__le64 rand;
 
 		get_random_bytes(enc.ltk, sizeof(enc.ltk));
 		get_random_bytes(&ediv, sizeof(ediv));
-		get_random_bytes(ident.rand, sizeof(ident.rand));
+		get_random_bytes(&rand, sizeof(rand));
 
 		smp_send_cmd(conn, SMP_CMD_ENCRYPT_INFO, sizeof(enc), &enc);
 
 		authenticated = hcon->sec_level == BT_SECURITY_HIGH;
 		ltk = hci_add_ltk(hdev, &hcon->dst, hcon->dst_type,
 				  HCI_SMP_LTK_SLAVE, authenticated, enc.ltk,
-				  smp->enc_key_size, ediv, ident.rand);
+				  smp->enc_key_size, ediv, rand);
 		smp->slave_ltk = ltk;
 
 		ident.ediv = ediv;
+		ident.rand = rand;
 
 		smp_send_cmd(conn, SMP_CMD_MASTER_IDENT, sizeof(ident), &ident);
 
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index 1b8af35b292c..a11d4281542c 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -78,7 +78,7 @@ struct smp_cmd_encrypt_info {
 #define SMP_CMD_MASTER_IDENT	0x07
 struct smp_cmd_master_ident {
 	__le16	ediv;
-	__u8	rand[8];
+	__le64	rand;
 } __packed;
 
 #define SMP_CMD_IDENT_INFO	0x08
-- 
1.8.5.3

