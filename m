Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 11/12] Bluetooth: Add support for storing the key size
Date: Fri,  1 Jul 2011 16:07:46 -0300
Message-Id: <1309547267-9514-12-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1309547267-9514-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1309547267-9514-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In some cases it will be useful having the key size used for
encrypting the link. For example, some profiles may restrict
some operations depending on the key length.

The key size is stored in the key that is passed to userspace
using the pin_length field in the key structure.

For now this field is only valid for LE controllers. 3.0+HS
controllers define the Read Encryption Key Size command, this
field is intended for storing the value returned by that
command.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    3 ++-
 net/bluetooth/hci_core.c         |    3 ++-
 net/bluetooth/hci_event.c        |    1 +
 net/bluetooth/mgmt.c             |    4 ++--
 net/bluetooth/smp.c              |   14 +++++++++-----
 5 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 308a9f7..1c291e0 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -261,6 +261,7 @@ struct hci_conn {
 	__u8		sec_level;
 	__u8		pending_sec_level;
 	__u8		pin_length;
+	__u8		enc_key_size;
 	__u8		io_capability;
 	__u8		power_save;
 	__u16		disc_timeout;
@@ -557,7 +558,7 @@ struct link_key *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8]);
 struct link_key *hci_find_link_key_type(struct hci_dev *hdev,
 					bdaddr_t *bdaddr, u8 type);
 int hci_add_ltk(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
-					__le16 ediv, u8 rand[8], u8 ltk[16]);
+			u8 key_size, __le16 ediv, u8 rand[8], u8 ltk[16]);
 int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
 
 int hci_remote_oob_data_clear(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index bf9c023..5f50dc2 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1159,7 +1159,7 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 }
 
 int hci_add_ltk(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
-					__le16 ediv, u8 rand[8], u8 ltk[16])
+			u8 key_size, __le16 ediv, u8 rand[8], u8 ltk[16])
 {
 	struct link_key *key, *old_key;
 	struct key_master_id *id;
@@ -1184,6 +1184,7 @@ int hci_add_ltk(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
 	bacpy(&key->bdaddr, bdaddr);
 	memcpy(key->val, ltk, sizeof(key->val));
 	key->type = HCI_LK_SMP_LTK;
+	key->pin_len = key_size;
 
 	id = (void *) &key->data;
 	id->ediv = ediv;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 9c7c370..620f307 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2811,6 +2811,7 @@ static inline void hci_le_ltk_request_evt(struct hci_dev *hdev,
 
 	memcpy(cp.ltk, ltk->val, sizeof(ltk->val));
 	cp.handle = cpu_to_le16(conn->handle);
+	conn->pin_length = ltk->pin_len;
 
 	hci_send_cmd(hdev, HCI_OP_LE_LTK_REPLY, sizeof(cp), &cp);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 336f971..8cae839 100644
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
index d9fffbd..62d6670 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -401,6 +401,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 				SMP_MAX_ENC_KEY_SIZE - conn->smp_key_size);
 
 		hci_le_start_enc(hcon, ediv, rand, stk);
+		hcon->enc_key_size = conn->smp_key_size;
 	} else {
 		u8 stk[16], r[16], rand[8];
 		__le16 ediv;
@@ -417,7 +418,8 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 		memset(stk + conn->smp_key_size, 0,
 				SMP_MAX_ENC_KEY_SIZE - conn->smp_key_size);
 
-		hci_add_ltk(conn->hcon->hdev, 0, conn->dst, ediv, rand, stk);
+		hci_add_ltk(conn->hcon->hdev, 0, conn->dst, conn->smp_key_size,
+							ediv, rand, stk);
 	}
 
 	return 0;
@@ -483,6 +485,8 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 
 			hci_le_start_enc(hcon, master->ediv, master->rand,
 								key->val);
+			hcon->enc_key_size = key->pin_len;
+
 			goto done;
 		}
 	}
@@ -528,8 +532,8 @@ static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	skb_pull(skb, sizeof(*rp));
 
-	hci_add_ltk(conn->hcon->hdev, 1, conn->src, rp->ediv,
-						rp->rand, conn->tk);
+	hci_add_ltk(conn->hcon->hdev, 1, conn->src, conn->smp_key_size,
+						rp->ediv, rp->rand, conn->tk);
 
 	smp_distribute_keys(conn, 1);
 
@@ -648,8 +652,8 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 
 		smp_send_cmd(conn, SMP_CMD_ENCRYPT_INFO, sizeof(enc), &enc);
 
-		hci_add_ltk(conn->hcon->hdev, 1, conn->dst, ediv,
-							ident.rand, enc.ltk);
+		hci_add_ltk(conn->hcon->hdev, 1, conn->dst, conn->smp_key_size,
+						ediv, ident.rand, enc.ltk);
 
 		ident.ediv = cpu_to_le16(ediv);
 
-- 
1.7.6

