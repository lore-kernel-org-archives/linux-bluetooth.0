Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@gmail.com, szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 06/10] shared/crypto: Change swap128 to swap_buf
Date: Thu, 29 May 2014 15:49:40 +0200
Message-Id: <1401371384-10427-7-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1401371384-10427-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1401371384-10427-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We will need to swap bigger buffers so lets make swap128 more generic for
that purpose
---
 src/shared/crypto.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/shared/crypto.c b/src/shared/crypto.c
index d4c4cc7..ad89174 100644
--- a/src/shared/crypto.c
+++ b/src/shared/crypto.c
@@ -248,12 +248,12 @@ static bool alg_encrypt(int fd, const void *inbuf, size_t inlen,
 	return true;
 }
 
-static inline void swap128(const uint8_t src[16], uint8_t dst[16])
+static inline void swap_buf(const uint8_t *src, uint8_t *dst, uint16_t len)
 {
 	int i;
 
-	for (i = 0; i < 16; i++)
-		dst[15 - i] = src[i];
+	for (i = 0; i < len; i++)
+		dst[len - 1 - i] = src[i];
 }
 
 bool bt_crypto_sign_att(struct bt_crypto *crypto, const uint8_t key[16],
@@ -276,7 +276,7 @@ bool bt_crypto_sign_att(struct bt_crypto *crypto, const uint8_t key[16],
 	put_le32(sign_cnt, msg + m_len);
 
 	/* The most significant octet of key corresponds to key[0] */
-	swap128(key, tmp);
+	swap_buf(key, tmp, 16);
 
 	memcpy(signature, tmp + 4, 12);
 	fd = alg_new(crypto->cmac_aes, tmp, 16);
@@ -308,7 +308,7 @@ bool bt_crypto_sign_att(struct bt_crypto *crypto, const uint8_t key[16],
 	 * Then truncate in most significant bit first order to a length of
 	 * 12 octets
 	 */
-	swap128(out, tmp);
+	swap_buf(out, tmp, 16);
 	memcpy(signature, tmp + 4, 12);
 
 	return true;
@@ -336,7 +336,7 @@ bool bt_crypto_e(struct bt_crypto *crypto, const uint8_t key[16],
 		return false;
 
 	/* The most significant octet of key corresponds to key[0] */
-	swap128(key, tmp);
+	swap_buf(key, tmp, 16);
 
 	fd = alg_new(crypto->ecb_aes, tmp, 16);
 	if (fd < 0)
@@ -344,7 +344,7 @@ bool bt_crypto_e(struct bt_crypto *crypto, const uint8_t key[16],
 
 
 	/* Most significant octet of plaintextData corresponds to in[0] */
-	swap128(plaintext, in);
+	swap_buf(plaintext, in, 16);
 
 	if (!alg_encrypt(fd, in, 16, out, 16)) {
 		close(fd);
@@ -352,7 +352,7 @@ bool bt_crypto_e(struct bt_crypto *crypto, const uint8_t key[16],
 	}
 
 	/* Most significant octet of encryptedData corresponds to out[0] */
-	swap128(out, encrypted);
+	swap_buf(out, encrypted, 16);
 
 	close(fd);
 
-- 
1.8.4

