Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 46/49] Bluetooth: Organize SMP crypto functions to logical sections
Date: Wed,  3 Dec 2014 17:02:40 +0200
Message-Id: <1417618963-18010-47-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch organizes the various SMP crypto functions so that the LE SC
functions appear in one section and the legacy SMP functions in a
separate one.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 134 ++++++++++++++++++++++++++++------------------------
 1 file changed, 71 insertions(+), 63 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 423e99d13207..c5dcb6563579 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -141,6 +141,10 @@ static inline void swap_buf(const u8 *src, u8 *dst, size_t len)
 		dst[len - 1 - i] = src[i];
 }
 
+/* The following functions map to the LE SC SMP crypto functions
+ * AES-CMAC, f4, f5, f6, g2 and h6.
+ */
+
 static int aes_cmac(struct crypto_hash *tfm, const u8 k[16], const u8 *m,
 		    size_t len, u8 mac[16])
 {
@@ -325,6 +329,26 @@ static int smp_g2(struct crypto_hash *tfm_cmac, const u8 u[32], const u8 v[32],
 	return 0;
 }
 
+static int smp_h6(struct crypto_hash *tfm_cmac, const u8 w[16],
+		  const u8 key_id[4], u8 res[16])
+{
+	int err;
+
+	SMP_DBG("w %16phN key_id %4phN", w, key_id);
+
+	err = aes_cmac(tfm_cmac, w, key_id, 4, res);
+	if (err)
+		return err;
+
+	SMP_DBG("res %16phN", res);
+
+	return err;
+}
+
+/* The following functions map to the legacy SMP crypto functions e, c1,
+ * s1 and ah.
+ */
+
 static int smp_e(struct crypto_blkcipher *tfm, const u8 *k, u8 *r)
 {
 	struct blkcipher_desc desc;
@@ -364,18 +388,59 @@ static int smp_e(struct crypto_blkcipher *tfm, const u8 *k, u8 *r)
 	return err;
 }
 
-static int smp_h6(struct crypto_hash *tfm_cmac, const u8 w[16],
-		  const u8 key_id[4], u8 res[16])
+static int smp_c1(struct crypto_blkcipher *tfm_aes, const u8 k[16],
+		  const u8 r[16], const u8 preq[7], const u8 pres[7], u8 _iat,
+		  const bdaddr_t *ia, u8 _rat, const bdaddr_t *ra, u8 res[16])
 {
+	u8 p1[16], p2[16];
 	int err;
 
-	SMP_DBG("w %16phN key_id %4phN", w, key_id);
+	memset(p1, 0, 16);
 
-	err = aes_cmac(tfm_cmac, w, key_id, 4, res);
-	if (err)
+	/* p1 = pres || preq || _rat || _iat */
+	p1[0] = _iat;
+	p1[1] = _rat;
+	memcpy(p1 + 2, preq, 7);
+	memcpy(p1 + 9, pres, 7);
+
+	/* p2 = padding || ia || ra */
+	memcpy(p2, ra, 6);
+	memcpy(p2 + 6, ia, 6);
+	memset(p2 + 12, 0, 4);
+
+	/* res = r XOR p1 */
+	u128_xor((u128 *) res, (u128 *) r, (u128 *) p1);
+
+	/* res = e(k, res) */
+	err = smp_e(tfm_aes, k, res);
+	if (err) {
+		BT_ERR("Encrypt data error");
 		return err;
+	}
 
-	SMP_DBG("res %16phN", res);
+	/* res = res XOR p2 */
+	u128_xor((u128 *) res, (u128 *) res, (u128 *) p2);
+
+	/* res = e(k, res) */
+	err = smp_e(tfm_aes, k, res);
+	if (err)
+		BT_ERR("Encrypt data error");
+
+	return err;
+}
+
+static int smp_s1(struct crypto_blkcipher *tfm_aes, const u8 k[16],
+		  const u8 r1[16], const u8 r2[16], u8 _r[16])
+{
+	int err;
+
+	/* Just least significant octets from r1 and r2 are considered */
+	memcpy(_r, r2, 8);
+	memcpy(_r + 8, r1, 8);
+
+	err = smp_e(tfm_aes, k, _r);
+	if (err)
+		BT_ERR("Encrypt data error");
 
 	return err;
 }
@@ -454,63 +519,6 @@ int smp_generate_rpa(struct hci_dev *hdev, const u8 irk[16], bdaddr_t *rpa)
 	return 0;
 }
 
-static int smp_c1(struct crypto_blkcipher *tfm_aes, const u8 k[16],
-		  const u8 r[16], const u8 preq[7], const u8 pres[7], u8 _iat,
-		  const bdaddr_t *ia, u8 _rat, const bdaddr_t *ra, u8 res[16])
-{
-	u8 p1[16], p2[16];
-	int err;
-
-	memset(p1, 0, 16);
-
-	/* p1 = pres || preq || _rat || _iat */
-	p1[0] = _iat;
-	p1[1] = _rat;
-	memcpy(p1 + 2, preq, 7);
-	memcpy(p1 + 9, pres, 7);
-
-	/* p2 = padding || ia || ra */
-	memcpy(p2, ra, 6);
-	memcpy(p2 + 6, ia, 6);
-	memset(p2 + 12, 0, 4);
-
-	/* res = r XOR p1 */
-	u128_xor((u128 *) res, (u128 *) r, (u128 *) p1);
-
-	/* res = e(k, res) */
-	err = smp_e(tfm_aes, k, res);
-	if (err) {
-		BT_ERR("Encrypt data error");
-		return err;
-	}
-
-	/* res = res XOR p2 */
-	u128_xor((u128 *) res, (u128 *) res, (u128 *) p2);
-
-	/* res = e(k, res) */
-	err = smp_e(tfm_aes, k, res);
-	if (err)
-		BT_ERR("Encrypt data error");
-
-	return err;
-}
-
-static int smp_s1(struct crypto_blkcipher *tfm_aes, const u8 k[16],
-		  const u8 r1[16], const u8 r2[16], u8 _r[16])
-{
-	int err;
-
-	/* Just least significant octets from r1 and r2 are considered */
-	memcpy(_r, r2, 8);
-	memcpy(_r + 8, r1, 8);
-
-	err = smp_e(tfm_aes, k, _r);
-	if (err)
-		BT_ERR("Encrypt data error");
-
-	return err;
-}
-
 static void smp_send_cmd(struct l2cap_conn *conn, u8 code, u16 len, void *data)
 {
 	struct l2cap_chan *chan = conn->smp;
-- 
2.1.0

