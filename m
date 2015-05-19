Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add debug logs for legacy SMP crypto functions
Date: Tue, 19 May 2015 21:06:04 +0300
Message-Id: <1432058764-17623-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

To help debug legacy SMP crypto functions add debug logs of the
various values involved.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 1ab3dc9c8f99..659371af39e4 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -371,6 +371,8 @@ static int smp_e(struct crypto_blkcipher *tfm, const u8 *k, u8 *r)
 	uint8_t tmp[16], data[16];
 	int err;
 
+	SMP_DBG("k %16phN r %16phN", k, r);
+
 	if (!tfm) {
 		BT_ERR("tfm %p", tfm);
 		return -EINVAL;
@@ -400,6 +402,8 @@ static int smp_e(struct crypto_blkcipher *tfm, const u8 *k, u8 *r)
 	/* Most significant octet of encryptedData corresponds to data[0] */
 	swap_buf(data, r, 16);
 
+	SMP_DBG("r %16phN", r);
+
 	return err;
 }
 
@@ -410,6 +414,10 @@ static int smp_c1(struct crypto_blkcipher *tfm_aes, const u8 k[16],
 	u8 p1[16], p2[16];
 	int err;
 
+	SMP_DBG("k %16phN r %16phN", k, r);
+	SMP_DBG("iat %u ia %6phN rat %u ra %6phN", _iat, ia, _rat, ra);
+	SMP_DBG("preq %7phN pres %7phN", preq, pres);
+
 	memset(p1, 0, 16);
 
 	/* p1 = pres || preq || _rat || _iat */
@@ -418,10 +426,7 @@ static int smp_c1(struct crypto_blkcipher *tfm_aes, const u8 k[16],
 	memcpy(p1 + 2, preq, 7);
 	memcpy(p1 + 9, pres, 7);
 
-	/* p2 = padding || ia || ra */
-	memcpy(p2, ra, 6);
-	memcpy(p2 + 6, ia, 6);
-	memset(p2 + 12, 0, 4);
+	SMP_DBG("p1 %16phN", p1);
 
 	/* res = r XOR p1 */
 	u128_xor((u128 *) res, (u128 *) r, (u128 *) p1);
@@ -433,6 +438,13 @@ static int smp_c1(struct crypto_blkcipher *tfm_aes, const u8 k[16],
 		return err;
 	}
 
+	/* p2 = padding || ia || ra */
+	memcpy(p2, ra, 6);
+	memcpy(p2 + 6, ia, 6);
+	memset(p2 + 12, 0, 4);
+
+	SMP_DBG("p2 %16phN", p2);
+
 	/* res = res XOR p2 */
 	u128_xor((u128 *) res, (u128 *) res, (u128 *) p2);
 
-- 
2.1.0

