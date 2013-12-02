Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Remove dead code from SMP encryption function
Date: Mon,  2 Dec 2013 10:49:04 +0200
Message-Id: <1385974144-8836-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1385974144-8836-1-git-send-email-johan.hedberg@gmail.com>
References: <1385974144-8836-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The AES cipher is used in ECB mode by SMP and therefore doesn't use an
IV (crypto_blkcipher_ivsize returns 0) so the code trying to set the IV
was never getting called. Simply remove this code to avoid anyone from
thinking it actually makes some difference.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 3bcb765b6a92..e61e74a1aabb 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -53,8 +53,7 @@ static int smp_e(struct crypto_blkcipher *tfm, const u8 *k, u8 *r)
 {
 	struct blkcipher_desc desc;
 	struct scatterlist sg;
-	int err, iv_len;
-	unsigned char iv[128];
+	int err;
 
 	if (tfm == NULL) {
 		BT_ERR("tfm %p", tfm);
@@ -72,12 +71,6 @@ static int smp_e(struct crypto_blkcipher *tfm, const u8 *k, u8 *r)
 
 	sg_init_one(&sg, r, 16);
 
-	iv_len = crypto_blkcipher_ivsize(tfm);
-	if (iv_len) {
-		memset(&iv, 0xff, iv_len);
-		crypto_blkcipher_set_iv(tfm, iv, iv_len);
-	}
-
 	err = crypto_blkcipher_encrypt(&desc, &sg, &sg, 16);
 	if (err)
 		BT_ERR("Encrypt data error %d", err);
-- 
1.8.4.2

