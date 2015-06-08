Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Fix encryption key size handling for LTKs
Date: Mon,  8 Jun 2015 18:14:39 +0300
Message-Id: <1433776479-20712-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The encryption key size for LTKs is supposed to be applied only at the
moment of encryption. When generating a Link Key (using LE SC) from
the LTK the full non-shortened value should be used. This patch
modifies the code to always keep the full value around and only apply
the key size when passing the value to HCI.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/hci_conn.c         |  4 ++--
 net/bluetooth/hci_event.c        |  3 ++-
 net/bluetooth/smp.c              | 15 +++------------
 4 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a056c2bfeb81..24c0e4577a93 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1408,7 +1408,7 @@ void mgmt_smp_complete(struct hci_conn *conn, bool complete);
 u8 hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
 		      u16 to_multiplier);
 void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
-							__u8 ltk[16]);
+		      __u8 ltk[16], __u8 key_size);
 
 void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			       u8 *bdaddr_type);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index ee5e59839b02..2c48bf0b5afb 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -276,7 +276,7 @@ u8 hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
 }
 
 void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
-		      __u8 ltk[16])
+		      __u8 ltk[16], __u8 key_size)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_cp_le_start_enc cp;
@@ -288,7 +288,7 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
 	cp.handle = cpu_to_le16(conn->handle);
 	cp.rand = rand;
 	cp.ediv = ediv;
-	memcpy(cp.ltk, ltk, sizeof(cp.ltk));
+	memcpy(cp.ltk, ltk, key_size);
 
 	hci_send_cmd(hdev, HCI_OP_LE_START_ENC, sizeof(cp), &cp);
 }
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 7b61be73650f..fcbfa4138eb1 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4955,7 +4955,8 @@ static void hci_le_ltk_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 			goto not_found;
 	}
 
-	memcpy(cp.ltk, ltk->val, sizeof(ltk->val));
+	memcpy(cp.ltk, ltk->val, ltk->enc_size);
+	memset(cp.ltk + ltk->enc_size, 0, sizeof(cp.ltk) - ltk->enc_size);
 	cp.handle = cpu_to_le16(conn->handle);
 
 	conn->pending_sec_level = smp_ltk_sec_level(ltk);
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 659371af39e4..3921cba056d3 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -997,13 +997,10 @@ static u8 smp_random(struct smp_chan *smp)
 
 		smp_s1(smp->tfm_aes, smp->tk, smp->rrnd, smp->prnd, stk);
 
-		memset(stk + smp->enc_key_size, 0,
-		       SMP_MAX_ENC_KEY_SIZE - smp->enc_key_size);
-
 		if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND, &hcon->flags))
 			return SMP_UNSPECIFIED;
 
-		hci_le_start_enc(hcon, ediv, rand, stk);
+		hci_le_start_enc(hcon, ediv, rand, stk, smp->enc_key_size);
 		hcon->enc_key_size = smp->enc_key_size;
 		set_bit(HCI_CONN_STK_ENCRYPT, &hcon->flags);
 	} else {
@@ -1016,9 +1013,6 @@ static u8 smp_random(struct smp_chan *smp)
 
 		smp_s1(smp->tfm_aes, smp->tk, smp->prnd, smp->rrnd, stk);
 
-		memset(stk + smp->enc_key_size, 0,
-		       SMP_MAX_ENC_KEY_SIZE - smp->enc_key_size);
-
 		if (hcon->pending_sec_level == BT_SECURITY_HIGH)
 			auth = 1;
 		else
@@ -1156,9 +1150,6 @@ static void sc_add_ltk(struct smp_chan *smp)
 	else
 		auth = 0;
 
-	memset(smp->tk + smp->enc_key_size, 0,
-	       SMP_MAX_ENC_KEY_SIZE - smp->enc_key_size);
-
 	smp->ltk = hci_add_ltk(hcon->hdev, &hcon->dst, hcon->dst_type,
 			       key_type, auth, smp->tk, smp->enc_key_size,
 			       0, 0);
@@ -2202,7 +2193,7 @@ static bool smp_ltk_encrypt(struct l2cap_conn *conn, u8 sec_level)
 	if (test_and_set_bit(HCI_CONN_ENCRYPT_PEND, &hcon->flags))
 		return true;
 
-	hci_le_start_enc(hcon, key->ediv, key->rand, key->val);
+	hci_le_start_enc(hcon, key->ediv, key->rand, key->val, key->enc_size);
 	hcon->enc_key_size = key->enc_size;
 
 	/* We never store STKs for master role, so clear this flag */
@@ -2750,7 +2741,7 @@ static int smp_cmd_dhkey_check(struct l2cap_conn *conn, struct sk_buff *skb)
 	sc_add_ltk(smp);
 
 	if (hcon->out) {
-		hci_le_start_enc(hcon, 0, 0, smp->tk);
+		hci_le_start_enc(hcon, 0, 0, smp->tk, smp->enc_key_size);
 		hcon->enc_key_size = smp->enc_key_size;
 	}
 
-- 
2.4.2

