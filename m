Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/6] Bluetooth: Add flexible buffer byte order swapping function
Date: Mon, 16 Jun 2014 11:00:33 +0300
Message-Id: <1402905633-470-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1402905633-470-1-git-send-email-johan.hedberg@gmail.com>
References: <1402905633-470-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Since the SMP code needs to swap ordering of variable length buffers add
a convenience function that can be used for any length buffer.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 513a92cb0356..142b6083a18a 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -64,18 +64,12 @@ struct smp_chan {
 	unsigned long	flags;
 };
 
-static inline void swap128(const u8 src[16], u8 dst[16])
+static inline void swap_buf(const u8 *src, u8 *dst, size_t len)
 {
-	int i;
-	for (i = 0; i < 16; i++)
-		dst[15 - i] = src[i];
-}
+	size_t i;
 
-static inline void swap56(const u8 src[7], u8 dst[7])
-{
-	int i;
-	for (i = 0; i < 7; i++)
-		dst[6 - i] = src[i];
+	for (i = 0; i < len; i++)
+		dst[len - 1 - i] = src[i];
 }
 
 static int smp_e(struct crypto_blkcipher *tfm, const u8 *k, u8 *r)
@@ -94,7 +88,7 @@ static int smp_e(struct crypto_blkcipher *tfm, const u8 *k, u8 *r)
 	desc.flags = 0;
 
 	/* The most significant octet of key corresponds to k[0] */
-	swap128(k, tmp);
+	swap_buf(k, tmp, 16);
 
 	err = crypto_blkcipher_setkey(tfm, tmp, 16);
 	if (err) {
@@ -103,7 +97,7 @@ static int smp_e(struct crypto_blkcipher *tfm, const u8 *k, u8 *r)
 	}
 
 	/* Most significant octet of plaintextData corresponds to data[0] */
-	swap128(r, data);
+	swap_buf(r, data, 16);
 
 	sg_init_one(&sg, data, 16);
 
@@ -112,7 +106,7 @@ static int smp_e(struct crypto_blkcipher *tfm, const u8 *k, u8 *r)
 		BT_ERR("Encrypt data error %d", err);
 
 	/* Most significant octet of encryptedData corresponds to data[0] */
-	swap128(data, r);
+	swap_buf(data, r, 16);
 
 	return err;
 }
-- 
1.9.3

