Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC 14/15] Bluetooth: Add support for storing the key length
Date: Tue,  5 Apr 2011 23:11:27 -0300
Message-Id: <1302055888-28177-15-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1302055888-28177-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1302055888-28177-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In some cases it will be useful having the key size used for
encrypting the link. For example, some profiles may restrict
some operations depending on the key length.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    2 +-
 net/bluetooth/hci_core.c         |    3 ++-
 net/bluetooth/hci_event.c        |    1 +
 net/bluetooth/mgmt.c             |    4 ++--
 net/bluetooth/smp.c              |   16 ++++++++++------
 5 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b402acd..1f95f03 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -549,7 +549,7 @@ struct link_key *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8]);
 struct link_key *hci_find_link_key_type(struct hci_dev *hdev,
 					bdaddr_t *bdaddr, u8 type);
 int hci_add_ltk(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
-					__le16 ediv, u8 rand[8], u8 ltk[16]);
+			u8 key_size, __le16 ediv, u8 rand[8], u8 ltk[16]);
 int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
 
 int hci_remote_oob_data_clear(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ab8ee1e..a573837 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1103,7 +1103,7 @@ int hci_add_link_key(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
 }
 
 int hci_add_ltk(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
-					__le16 ediv, u8 rand[8], u8 ltk[16])
+			u8 key_size, __le16 ediv, u8 rand[8], u8 ltk[16])
 {
 	struct link_key *key, *old_key;
 	struct key_master_id *id;
@@ -1128,6 +1128,7 @@ int hci_add_ltk(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
 	bacpy(&key->bdaddr, bdaddr);
 	memcpy(key->val, ltk, sizeof(key->val));
 	key->type = KEY_TYPE_LTK;
+	key->pin_len = key_size;
 
 	id = (void *) &key->data;
 	id->ediv = ediv;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7282c39..2b57b99 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2649,6 +2649,7 @@ static inline void hci_le_ltk_request_evt(struct hci_dev *hdev,
 
 	memcpy(cp.ltk, ltk->val, sizeof(ltk->val));
 	cp.handle = cpu_to_le16(conn->handle);
+	conn->pin_length = ltk->pin_len;
 
 	hci_send_cmd(hdev, HCI_OP_LE_LTK_REPLY, sizeof(cp), &cp);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9c25513..ffbcd6e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -956,8 +956,8 @@ static int load_keys(struct sock *sk, u16 index, unsigned char *data, u16 len)
 			if (key->dlen != sizeof(struct key_master_id))
 				continue;
 
-			hci_add_ltk(hdev, 0, &key->bdaddr, id->ediv,
-							id->rand, key->val);
+			hci_add_ltk(hdev, 0, &key->bdaddr, key->pin_len,
+						id->ediv, id->rand, key->val);
 
 			continue;
 		}
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index ba90f2c..990c89f 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -404,6 +404,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 				SMP_MAX_ENC_KEY_SIZE - conn->smp_key_size);
 
 		hci_le_start_enc(hcon, ediv, rand, stk);
+		hcon->pin_length = conn->smp_key_size;
 
 		hex_dump_to_buffer(key, sizeof(key), 16, 1, buf,
 							sizeof(buf), 0);
@@ -424,7 +425,8 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 		memset(stk + conn->smp_key_size, 0,
 				SMP_MAX_ENC_KEY_SIZE - conn->smp_key_size);
 
-		hci_add_ltk(conn->hcon->hdev, 0, conn->dst, ediv, rand, stk);
+		hci_add_ltk(conn->hcon->hdev, 0, conn->dst, conn->smp_key_size,
+							ediv, rand, stk);
 
 		hex_dump_to_buffer(key, sizeof(key), 16, 1, buf,
 							sizeof(buf), 0);
@@ -494,6 +496,8 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 
 			hci_le_start_enc(hcon, master->ediv, master->rand,
 								key->val);
+			hcon->pin_length = key->pin_len;
+
 			goto done;
 		}
 	}
@@ -534,7 +538,7 @@ static int smp_cmd_encrypt_info(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	memset(rand, 0, sizeof(rand));
 
-	err = hci_add_ltk(conn->hcon->hdev, 0, conn->dst, 0, rand, rp->ltk);
+	err = hci_add_ltk(conn->hcon->hdev, 0, conn->dst, 0, 0, rand, rp->ltk);
 	if (err)
 		return SMP_UNSPECIFIED;
 
@@ -561,8 +565,8 @@ static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 	id->ediv = rp->ediv;
 	memcpy(id->rand, rp->rand, sizeof(rp->rand));
 
-	hci_add_ltk(conn->hcon->hdev, 1, conn->src, rp->ediv,
-						rp->rand, key->val);
+	hci_add_ltk(conn->hcon->hdev, 1, conn->src, conn->smp_key_size,
+						rp->ediv, rp->rand, key->val);
 
 	smp_distribute_keys(conn, 1);
 
@@ -681,8 +685,8 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 
 		smp_send_cmd(conn, SMP_CMD_ENCRYPT_INFO, sizeof(enc), &enc);
 
-		hci_add_ltk(conn->hcon->hdev, 1, conn->dst, ediv,
-							ident.rand, enc.ltk);
+		hci_add_ltk(conn->hcon->hdev, 1, conn->dst, conn->smp_key_size,
+						ediv, ident.rand, enc.ltk);
 
 		ident.ediv = cpu_to_le16(ediv);
 
-- 
1.7.4.1

