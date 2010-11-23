Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC 18/20] Bluetooth: Add support for SMP confirmation checks
Date: Tue, 23 Nov 2010 12:06:34 -0300
Message-Id: <1290524796-32246-19-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1290524796-32246-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1290524796-32246-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds supports for verifying the confirmation value that the
remote side has sent. This includes support for generating and sending
the random value used to produce the confirmation value.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
---
 include/net/bluetooth/l2cap.h |    5 +
 net/bluetooth/smp.c           |  240 +++++++++++++++++++++++++++--------------
 2 files changed, 164 insertions(+), 81 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index cba4423..1d0555f 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -290,6 +290,11 @@ struct l2cap_conn {
 
 	__u8		disc_reason;
 
+	__u8		preq[7];
+	__u8		pres[7];
+	__u8		prnd[16];
+	__u8		pcnf[16];
+
 	struct l2cap_chan_list chan_list;
 };
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 8e8be47..a8d2e12 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -27,21 +27,31 @@
 #include <linux/crypto.h>
 #include <crypto/b128ops.h>
 
-/* Criptographic toolbox functions */
+static inline void swap128(u8 src[16], u8 dst[16])
+{
+	int i;
+	for (i = 0; i < 16; i++)
+		dst[15 - i] = src[i];
+}
 
-static int smp_e(const u8 *k, const u8 *r)
+static inline void swap56(u8 src[7], u8 dst[7])
+{
+	int i;
+	for (i = 0; i < 7; i++)
+		dst[6 - i] = src[i];
+}
+
+static int smp_e(struct crypto_blkcipher *tfm, const u8 *k, u8 *r)
 {
-	struct crypto_blkcipher *tfm;
 	struct blkcipher_desc desc;
-	struct scatterlist sg[1];
+	struct scatterlist sg;
 	int err, iv_len;
 	unsigned char iv[128];
 
-	tfm = crypto_alloc_blkcipher("ecb(aes)", 0, CRYPTO_ALG_ASYNC);
-	if (IS_ERR(tfm)) {
-		BT_ERR("Failed to load transform for ecb(aes): %ld",
-				PTR_ERR(tfm));
-		return PTR_ERR(tfm);
+	if (tfm == NULL) {
+		BT_ERR("tfm %p", tfm);
+		err = -1;
+		goto out;
 	}
 
 	desc.tfm = tfm;
@@ -49,12 +59,11 @@ static int smp_e(const u8 *k, const u8 *r)
 
 	err = crypto_blkcipher_setkey(tfm, k, 16);
 	if (err) {
-		BT_ERR("smp_e: cipher setkey failed: %d", err);
+		BT_ERR("cipher setkey failed: %d", err);
 		goto out;
 	}
 
-	sg_init_table(sg, 1);
-	sg_set_buf(sg, r, 16);
+	sg_init_one(&sg, r, 16);
 
 	iv_len = crypto_blkcipher_ivsize(tfm);
 	if (iv_len) {
@@ -62,73 +71,57 @@ static int smp_e(const u8 *k, const u8 *r)
 		crypto_blkcipher_set_iv(tfm, iv, iv_len);
 	}
 
-	err = crypto_blkcipher_encrypt(&desc, sg, sg, 16);
+	err = crypto_blkcipher_encrypt(&desc, &sg, &sg, 16);
 	if (err)
-		BT_ERR("smp_e: Encrypt data error %d", err);
+		BT_ERR("Encrypt data error %d", err);
 
 out:
-	crypto_free_blkcipher(tfm);
 	return err;
 }
 
-static int smp_ah(const u8 *k, const u8 *r, u8 *res)
+static int smp_c1(struct crypto_blkcipher *tfm, u8 k[16], u8 r[16],
+		u8 preq[7], u8 pres[7], u8 _iat, bdaddr_t *ia,
+		u8 _rat, bdaddr_t *ra, u8 res[16])
 {
-	u8 _r[16];
-	int err;
-
-	/* _r = padding || r */
-	memset(_r, 0, 16);
-	memcpy(_r + 13, r, 3);
-
-	err = smp_e(k, _r);
-	if (err) {
-		BT_ERR("smp_ah: Encrypt data error");
-		goto out;
-	}
-
-	/* Returns last 24 bits from previous intermediate result _r */
-	memcpy(res, _r + 13, 3);
-
-out:
-	return err;
-}
-
-static int smp_c1(const u8 *k, const u8 *r, const u8 *pres, const u8 *preq,
-		const u8 _iat, const u8 *ia, const u8 _rat, const u8 *ra,
-		u8 *res)
-{
-	u8 p1[16], p2[16];
+	u8 p1[16], p2[16], pair[7];
+	bdaddr_t addr;
 	int err;
 
 	/* p1 = pres || preq || _rat || _iat */
 	memset(p1, 0, 16);
-	memcpy(p1, pres, 7);
-	memcpy(p1 + 7, preq, 7);
+	swap56(pres, pair);
+
+	memcpy(p1, pair, 7);
+	swap56(preq, pair);
+
+	memcpy(p1 + 7, pair, 7);
 	*(p1 + 14) = _rat;
 	*(p1 + 15) = _iat;
 
 	/* p2 = padding || ia || ra */
 	memset(p2, 0, 16);
-	memcpy(p2 + 4, ia, 6);
-	memcpy(p2 + 10, ra, 6);
+	baswap(&addr, ia);
+	memcpy(p2 + 4, &addr, 6);
+	baswap(&addr, ra);
+	memcpy(p2 + 10, &addr, 6);
 
 	/* res = r XOR p1 */
-	u128_xor((u128 *)res, (u128 *)r, (u128 *)p1);
+	u128_xor((u128 *) res, (u128 *) r, (u128 *) p1);
 
 	/* res = e(k, res) */
-	err = smp_e(k, res);
+	err = smp_e(tfm, k, res);
 	if (err) {
-		BT_ERR("smp_c1: Encrypt data error");
+		BT_ERR("Encrypt data error");
 		goto out;
 	}
 
 	/* res = res XOR p2 */
-	u128_xor((u128 *)res, (u128 *)res, (u128 *)p2);
+	u128_xor((u128 *) res, (u128 *) res, (u128 *) p2);
 
 	/* res = e(k, res) */
-	err = smp_e(k, res);
+	err = smp_e(tfm, k, res);
 	if (err) {
-		BT_ERR("smp_c1: Encrypt data error");
+		BT_ERR("Encrypt data error");
 		goto out;
 	}
 
@@ -136,15 +129,19 @@ out:
 	return err;
 }
 
-static int smp_s1(const u_char *k, const u_char *r1, const u_char *r2, u_char *_r)
+static int smp_s1(struct crypto_blkcipher *tfm, u8 k[16],
+			u8 r1[16], u8 r2[16], u8 _r[16])
 {
+	u8 r[16];
 	int err;
 
 	/* Just least significant octets from r1 and r2 are considered */
-	memcpy(_r, r1 + 8, 8);
-	memcpy(_r + 8, r2 + 8, 8);
+	swap128(r1, r);
+	memcpy(_r, r + 8, 8);
+	swap128(r2, r);
+	memcpy(_r + 8, r + 8, 8);
 
-	err = smp_e(k, _r);
+	err = smp_e(tfm, k, _r);
 	if (err) {
 		BT_ERR("smp_s1: Encrypt data error");
 		goto out;
@@ -154,6 +151,13 @@ out:
 	return err;
 }
 
+static int smp_rand(u8 *buf)
+{
+	get_random_bytes(buf, 16);
+
+	return 0;
+}
+
 static struct sk_buff *smp_build_cmd(struct l2cap_conn *conn, u8 code,
 		u16 dlen, void *data)
 {
@@ -199,7 +203,9 @@ static void smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	BT_DBG("");
 
-	skb_pull(skb, sizeof(struct smp_cmd_pairing));
+	conn->preq[0] = SMP_CMD_PAIRING_REQ;
+	memcpy(&conn->preq[1], rp, sizeof(*rp));
+	skb_pull(skb, sizeof(*rp));
 
 	rp->io_capability = 0x00;
 	rp->oob_flag = 0x00;
@@ -208,64 +214,126 @@ static void smp_cmd_pairing_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	rp->resp_key_dist = 0x00;
 	rp->auth_req &= 0x05;
 
+	conn->pres[0] = SMP_CMD_PAIRING_RSP;
+	memcpy(&conn->pres[1], rp, sizeof(rp));
+
 	smp_send_cmd(conn, SMP_CMD_PAIRING_RSP, sizeof(*rp), rp);
 }
 
 static void smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 {
+	struct smp_cmd_pairing *rp = (void *) skb->data;
 	struct smp_cmd_pairing_confirm cp;
+	struct crypto_blkcipher *tfm = conn->hcon->hdev->tfm;
+	int ret;
+	u8 k[16], res[16];
 
-	BT_DBG("");
+	/* Just Works */
+	memset(k, 0, sizeof(k));
+
+	conn->pres[0] = SMP_CMD_PAIRING_RSP;
+	memcpy(&conn->pres[1], rp, sizeof(*rp));
+	skb_pull(skb, sizeof(*rp));
 
-	memset(&cp, 0, sizeof(struct smp_cmd_pairing_confirm));
+	ret = smp_rand(conn->prnd);
+	if (ret)
+		return;
+
+	ret = smp_c1(tfm, k, conn->prnd, conn->preq, conn->pres, 0,
+			conn->src, 0, conn->dst, res);
+	if (ret)
+		return;
 
 	smp_send_cmd(conn, SMP_CMD_PAIRING_CONFIRM, sizeof(cp), &cp);
 }
 
 static void smp_cmd_pairing_confirm(struct l2cap_conn *conn, struct sk_buff *skb)
 {
+	struct crypto_blkcipher *tfm = conn->hcon->hdev->tfm;
+
 	BT_DBG("");
 
-	if (conn->hcon->out) {
-		struct smp_cmd_pairing_random random;
+	memcpy(conn->pcnf, skb->data, 16);
+	skb_pull(skb, 16);
 
-		BT_DBG("master");
+	if (conn->hcon->out) {
+		u8 random[16];
 
-		memset(&random, 0, sizeof(struct smp_cmd_pairing_random));
+		swap128(conn->prnd, random);
 
-		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(random),
-								&random);
+		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, 16, random);
 	} else {
-		struct smp_cmd_pairing_confirm confirm;
+		struct smp_cmd_pairing_confirm cp;
+		int ret;
+		u8 k[16], res[16];
+
+		/* Just Works */
+		memset(k, 0, sizeof(k));
 
-		BT_DBG("slave");
+		ret = smp_rand(conn->prnd);
+		if (ret)
+			return;
 
-		memset(&confirm, 0, sizeof(struct smp_cmd_pairing_confirm));
+		ret = smp_c1(tfm, k, conn->prnd, conn->preq, conn->pres, 0,
+				conn->dst, 0, conn->src, res);
+		if (ret)
+			return;
 
-		smp_send_cmd(conn, SMP_CMD_PAIRING_CONFIRM, sizeof(confirm),
-								&confirm);
+		swap128(res, cp.confirm_val);
+
+		smp_send_cmd(conn, SMP_CMD_PAIRING_CONFIRM, sizeof(cp), &cp);
 	}
 }
 
 static void smp_cmd_pairing_random(struct l2cap_conn *conn, struct sk_buff *skb)
 {
-	struct smp_cmd_pairing_random cp;
+	struct crypto_blkcipher *tfm = conn->hcon->hdev->tfm;
+	int ret;
+	u8 k[16], key[16], res[16], random[16], confirm[16], buf[128];
+
+	swap128(skb->data, random);
+	skb_pull(skb, 16);
+
+	memset(k, 0, sizeof(k));
+
+	if (conn->hcon->out)
+		ret = smp_c1(tfm, k, random, conn->preq, conn->pres, 0,
+				conn->src, 0, conn->dst, res);
+	else
+		ret = smp_c1(tfm, k, random, conn->preq, conn->pres, 0,
+				conn->dst, 0, conn->src, res);
+	if (ret)
+		return;
 
-	BT_DBG("");
+	swap128(res, confirm);
 
-	skb_pull(skb, sizeof(struct smp_cmd_pairing_random));
+	if (memcmp(conn->pcnf, confirm, 16) != 0) {
+		struct smp_cmd_pairing_fail cp;
 
-	/* FIXME: check if random matches */
+		BT_ERR("Pairing failed (confirmation values mismatch)");
+		cp.reason = SMP_CONFIRM_FAILED;
+		smp_send_cmd(conn, SMP_CMD_PAIRING_FAIL, sizeof(cp), &cp);
+		return;
+	}
 
 	if (conn->hcon->out) {
-		BT_DBG("master");
-		/* FIXME: start encryption */
+		smp_s1(tfm, k, random, conn->prnd, key);
+
+		hex_dump_to_buffer(key, sizeof(key), 16, 1, buf, sizeof(buf), 0);
+
+		BT_DBG("key %s", buf);
 	} else {
-		BT_DBG("slave");
+		u8 r[16];
+
+		swap128(conn->prnd, r);
+
+		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, 16, r);
+
+		smp_s1(tfm, k, conn->prnd, random, key);
 
-		memset(&cp, 0, sizeof(struct smp_cmd_pairing_random));
+		hex_dump_to_buffer(key, sizeof(key), 16, 1, buf, sizeof(buf), 0);
 
-		smp_send_cmd(conn, SMP_CMD_PAIRING_RANDOM, sizeof(cp), &cp);
+		BT_DBG("key %s", buf);
 	}
 }
 
@@ -276,8 +344,9 @@ static void smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 
 	BT_DBG("");
 
-	skb_pull(skb, sizeof(struct smp_cmd_security_req));
-	memset(&cp, 0, sizeof(struct smp_cmd_pairing));
+	skb_pull(skb, sizeof(*rp));
+
+	memset(&cp, 0, sizeof(cp));
 
 	cp.io_capability = 0x00;
 	cp.oob_flag = 0x00;
@@ -286,11 +355,15 @@ static void smp_cmd_security_req(struct l2cap_conn *conn, struct sk_buff *skb)
 	cp.resp_key_dist = 0x00;
 	cp.auth_req = rp->auth_req & 0x05;
 
+	conn->preq[0] = SMP_CMD_PAIRING_REQ;
+	memcpy(&conn->preq[1], &cp, sizeof(cp));
+
 	smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
 }
 
 int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 {
+	struct hci_conn *hcon = conn->hcon;
 	__u8 authreq;
 
 	BT_DBG("conn %p hcon %p level 0x%2.2x", conn, conn->hcon, sec_level);
@@ -311,14 +384,19 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 		return 1;
 	}
 
-	if (conn->hcon->out) {
+	if (hcon->out) {
 		struct smp_cmd_pairing cp;
+
 		cp.io_capability = 0x00;
 		cp.oob_flag = 0x00;
 		cp.max_key_size = 16;
 		cp.init_key_dist = 0x00;
 		cp.resp_key_dist = 0x00;
 		cp.auth_req = authreq;
+
+		conn->preq[0] = SMP_CMD_PAIRING_REQ;
+		memcpy(&conn->preq[1], &cp, sizeof(cp));
+
 		smp_send_cmd(conn, SMP_CMD_PAIRING_REQ, sizeof(cp), &cp);
 	} else {
 		struct smp_cmd_security_req cp;
-- 
1.7.3.2

