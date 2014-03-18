Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: Fix smp_e byte order to be consistent with SMP specification
Date: Tue, 18 Mar 2014 12:58:24 +0200
Message-Id: <1395140304-15747-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1395140304-15747-1-git-send-email-johan.hedberg@gmail.com>
References: <1395140304-15747-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The SMP specification is written with the assumption that both key
information, plaintextData and encryptedData follow the same little
endian byte ordering as the rest of SMP.

Since the kernel crypto routines expect big endian data the code has had
to do various byte swapping tricks to make the behavior as expected,
however the swapping has been scattered all around the place.

This patch centralizes the byte order swapping into the smp_e function
by making its public interface match what the other SMP functions expect
as per specification. The benefit is vastly simplified calls to smp_e.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
v2: Fix stk generation

 net/bluetooth/smp.c | 101 ++++++++++++++++++++++++----------------------------
 1 file changed, 46 insertions(+), 55 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 4f3cde9dd1ea..6f29430c29c4 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -53,6 +53,7 @@ static int smp_e(struct crypto_blkcipher *tfm, const u8 *k, u8 *r)
 {
 	struct blkcipher_desc desc;
 	struct scatterlist sg;
+	uint8_t tmp[16], data[16];
 	int err;
 
 	if (tfm == NULL) {
@@ -63,34 +64,40 @@ static int smp_e(struct crypto_blkcipher *tfm, const u8 *k, u8 *r)
 	desc.tfm = tfm;
 	desc.flags = 0;
 
-	err = crypto_blkcipher_setkey(tfm, k, 16);
+	/* The most significant octet of key corresponds to k[0] */
+	swap128(k, tmp);
+
+	err = crypto_blkcipher_setkey(tfm, tmp, 16);
 	if (err) {
 		BT_ERR("cipher setkey failed: %d", err);
 		return err;
 	}
 
-	sg_init_one(&sg, r, 16);
+	/* Most significant octet of plaintextData corresponds to data[0] */
+	swap128(r, data);
+
+	sg_init_one(&sg, data, 16);
 
 	err = crypto_blkcipher_encrypt(&desc, &sg, &sg, 16);
 	if (err)
 		BT_ERR("Encrypt data error %d", err);
 
+	/* Most significant octet of encryptedData corresponds to data[0] */
+	swap128(data, r);
+
 	return err;
 }
 
 static int smp_ah(struct crypto_blkcipher *tfm, u8 irk[16], u8 r[3], u8 res[3])
 {
-	u8 _res[16], k[16];
+	u8 _res[16];
 	int err;
 
 	/* r' = padding || r */
-	memset(_res, 0, 13);
-	_res[13] = r[2];
-	_res[14] = r[1];
-	_res[15] = r[0];
+	memcpy(_res, r, 3);
+	memset(_res + 3, 0, 13);
 
-	swap128(irk, k);
-	err = smp_e(tfm, k, _res);
+	err = smp_e(tfm, irk, _res);
 	if (err) {
 		BT_ERR("Encrypt error");
 		return err;
@@ -102,9 +109,7 @@ static int smp_ah(struct crypto_blkcipher *tfm, u8 irk[16], u8 r[3], u8 res[3])
 	 * by taking the least significant 24 bits of the output of e as the
 	 * result of ah.
 	 */
-	res[0] = _res[15];
-	res[1] = _res[14];
-	res[2] = _res[13];
+	memcpy(res, _res, 3);
 
 	return 0;
 }
@@ -152,16 +157,15 @@ static int smp_c1(struct crypto_blkcipher *tfm, u8 k[16], u8 r[16],
 	memset(p1, 0, 16);
 
 	/* p1 = pres || preq || _rat || _iat */
-	swap56(pres, p1);
-	swap56(preq, p1 + 7);
-	p1[14] = _rat;
-	p1[15] = _iat;
-
-	memset(p2, 0, 16);
+	p1[0] = _iat;
+	p1[1] = _rat;
+	memcpy(p1 + 2, preq, 7);
+	memcpy(p1 + 9, pres, 7);
 
 	/* p2 = padding || ia || ra */
-	baswap((bdaddr_t *) (p2 + 4), ia);
-	baswap((bdaddr_t *) (p2 + 10), ra);
+	memcpy(p2, ra, 6);
+	memcpy(p2 + 6, ia, 6);
+	memset(p2 + 12, 0, 4);
 
 	/* res = r XOR p1 */
 	u128_xor((u128 *) res, (u128 *) r, (u128 *) p1);
@@ -190,8 +194,8 @@ static int smp_s1(struct crypto_blkcipher *tfm, u8 k[16], u8 r1[16],
 	int err;
 
 	/* Just least significant octets from r1 and r2 are considered */
-	memcpy(_r, r1 + 8, 8);
-	memcpy(_r + 8, r2 + 8, 8);
+	memcpy(_r, r2, 8);
+	memcpy(_r + 8, r1, 8);
 
 	err = smp_e(tfm, k, _r);
 	if (err)
@@ -405,13 +409,10 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
 
 	/* Generate random passkey. Not valid until confirmed. */
 	if (method == CFM_PASSKEY) {
-		u8 key[16];
-
-		memset(key, 0, sizeof(key));
+		memset(smp->tk, 0, sizeof(smp->tk));
 		get_random_bytes(&passkey, sizeof(passkey));
 		passkey %= 1000000;
-		put_unaligned_le32(passkey, key);
-		swap128(key, smp->tk);
+		put_unaligned_le32(passkey, smp->tk);
 		BT_DBG("PassKey: %d", passkey);
 	}
 
@@ -438,7 +439,7 @@ static void confirm_work(struct work_struct *work)
 	struct crypto_blkcipher *tfm = hdev->tfm_aes;
 	struct smp_cmd_pairing_confirm cp;
 	int ret;
-	u8 res[16], reason;
+	u8 reason;
 
 	BT_DBG("conn %p", conn);
 
@@ -447,7 +448,8 @@ static void confirm_work(struct work_struct *work)
 
 	ret = smp_c1(tfm, smp->tk, smp->prnd, smp->preq, smp->prsp,
 		     conn->hcon->init_addr_type, &conn->hcon->init_addr,
-		     conn->hcon->resp_addr_type, &conn->hcon->resp_addr, res);
+		     conn->hcon->resp_addr_type, &conn->hcon->resp_addr,
+		     cp.confirm_val);
 
 	hci_dev_unlock(hdev);
 
@@ -458,7 +460,6 @@ static void confirm_work(struct work_struct *work)
 
 	clear_bit(SMP_FLAG_CFM_PENDING, &smp->smp_flags);
 
-	swap128(res, cp.confirm_val);
 	smp_send_cmd(smp->conn, SMP_CMD_PAIRING_CONFIRM, sizeof(cp), &cp);
 
 	return;
@@ -474,7 +475,7 @@ static void random_work(struct work_struct *work)
 	struct hci_conn *hcon = conn->hcon;
 	struct hci_dev *hdev = hcon->hdev;
 	struct crypto_blkcipher *tfm = hdev->tfm_aes;
-	u8 reason, confirm[16], res[16], key[16];
+	u8 reason, confirm[16];
 	int ret;
 
 	if (IS_ERR_OR_NULL(tfm)) {
@@ -489,7 +490,7 @@ static void random_work(struct work_struct *work)
 
 	ret = smp_c1(tfm, smp->tk, smp->rrnd, smp->preq, smp->prsp,
 		     hcon->init_addr_type, &hcon->init_addr,
-		     hcon->resp_addr_type, &hcon->resp_addr, res);
+		     hcon->resp_addr_type, &hcon->resp_addr, confirm);
 
 	hci_dev_unlock(hdev);
 
@@ -498,8 +499,6 @@ static void random_work(struct work_struct *work)
 		goto error;
 	}
 
-	swap128(res, confirm);
-
 	if (memcmp(smp->pcnf, confirm, sizeof(smp->pcnf)) != 0) {
 		BT_ERR("Pairing failed (confirmation values mismatch)");
 		reason = SMP_CONFIRM_FAILED;
@@ -511,8 +510,7 @@ static void random_work(struct work_struct *work)
 		__le64 rand = 0;
 		__le16 ediv = 0;
 
-		smp_s1(tfm, smp->tk, smp->rrnd, smp->prnd, key);
-		swap128(key, stk);
+		smp_s1(tfm, smp->tk, smp->rrnd, smp->prnd, stk);
 
 		memset(stk + smp->enc_key_size, 0,
 		       SMP_MAX_ENC_KEY_SIZE - smp->enc_key_size);
@@ -525,15 +523,14 @@ static void random_work(struct work_struct *work)
 		hci_le_start_enc(hcon, ediv, rand, stk);
 		hcon->enc_key_size = smp->enc_key_size;
 	} else {
-		u8 stk[16], r[16];
+		u8 stk[16];
 		__le64 rand = 0;
 		__le16 ediv = 0;
 
-		swap128(smp->prnd, r);
-		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(r), r);
+		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(smp->prnd),
+			     smp->prnd);
 
-		smp_s1(tfm, smp->tk, smp->prnd, smp->rrnd, key);
-		swap128(key, stk);
+		smp_s1(tfm, smp->tk, smp->prnd, smp->rrnd, stk);
 
 		memset(stk + smp->enc_key_size, 0,
 		       SMP_MAX_ENC_KEY_SIZE - smp->enc_key_size);
@@ -628,7 +625,6 @@ int smp_user_confirm_reply(struct hci_conn *hcon, u16 mgmt_op, __le32 passkey)
 	struct l2cap_conn *conn = hcon->smp_conn;
 	struct smp_chan *smp;
 	u32 value;
-	u8 key[16];
 
 	BT_DBG("");
 
@@ -640,10 +636,9 @@ int smp_user_confirm_reply(struct hci_conn *hcon, u16 mgmt_op, __le32 passkey)
 	switch (mgmt_op) {
 	case MGMT_OP_USER_PASSKEY_REPLY:
 		value = le32_to_cpu(passkey);
-		memset(key, 0, sizeof(key));
+		memset(smp->tk, 0, sizeof(smp->tk));
 		BT_DBG("PassKey: %d", value);
-		put_unaligned_le32(value, key);
-		swap128(key, smp->tk);
+		put_unaligned_le32(value, smp->tk);
 		/* Fall Through */
 	case MGMT_OP_USER_CONFIRM_REPLY:
 		set_bit(SMP_FLAG_TK_VALID, &smp->smp_flags);
@@ -787,17 +782,13 @@ static u8 smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 	memcpy(smp->pcnf, skb->data, sizeof(smp->pcnf));
 	skb_pull(skb, sizeof(smp->pcnf));
 
-	if (conn->hcon->out) {
-		u8 random[16];
-
-		swap128(smp->prnd, random);
-		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(random),
-			     random);
-	} else if (test_bit(SMP_FLAG_TK_VALID, &smp->smp_flags)) {
+	if (conn->hcon->out)
+		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(smp->prnd),
+			     smp->prnd);
+	else if (test_bit(SMP_FLAG_TK_VALID, &smp->smp_flags))
 		queue_work(hdev->workqueue, &smp->confirm);
-	} else {
+	else
 		set_bit(SMP_FLAG_CFM_PENDING, &smp->smp_flags);
-	}
 
 	return 0;
 }
@@ -812,7 +803,7 @@ static u8 smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 	if (skb->len < sizeof(smp->rrnd))
 		return SMP_UNSPECIFIED;
 
-	swap128(skb->data, smp->rrnd);
+	memcpy(smp->rrnd, skb->data, sizeof(smp->rrnd));
 	skb_pull(skb, sizeof(smp->rrnd));
 
 	queue_work(hdev->workqueue, &smp->random);
-- 
1.8.5.3

