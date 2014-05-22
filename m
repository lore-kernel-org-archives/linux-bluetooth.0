Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v3 01/12] shared/crypto: Extend bt_crypto_sign_att with sign counter
Date: Thu, 22 May 2014 21:06:15 +0200
Message-Id: <1400785586-22710-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1400785586-22710-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1400785586-22710-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Sign counter is use in two places during att signing:
1) Shall be concatenated with message to be sign as specified in BT spec
4.1, Vol[3], Part H, chapter 2.4.5

2) Shall be a part of signature send in the att packet as specified in
BT spec 4.1 Vol[3], Part C, chapter 10.4.1

With this patch, bt_crypto_sign_att returns signature as specified in 2)

This patch also updates unit tests so now it uses sign counter 0. Note
that test vectors no longer match that one from  NIST Special
Publication 800-38B
---
 src/shared/crypto.c | 19 +++++++++++++++++--
 src/shared/crypto.h |  1 +
 unit/test-crypto.c  | 10 +++++-----
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/src/shared/crypto.c b/src/shared/crypto.c
index 0aec373..9140ceb 100644
--- a/src/shared/crypto.c
+++ b/src/shared/crypto.c
@@ -258,23 +258,32 @@ static inline void swap128(const uint8_t src[16], uint8_t dst[16])
 
 bool bt_crypto_sign_att(struct bt_crypto *crypto, const uint8_t key[16],
 					const uint8_t *m, uint16_t m_len,
-					uint8_t signature[12])
+					uint32_t sign_cnt, uint8_t signature[12])
 {
 	int fd;
 	int len;
 	uint8_t tmp[16], out[16];
+	uint16_t msg_len = m_len + sizeof(uint32_t);
+	uint8_t msg[msg_len];
 
 	if (!crypto)
 		return false;
 
+	memset(msg, 0, msg_len);
+	memcpy(msg, m, m_len);
+
+	/* Add sign_counter to the message */
+	put_le32(sign_cnt, msg + msg_len);
+
 	/* The most significant octet of key corresponds to key[0] */
 	swap128(key, tmp);
 
+	memcpy(signature, tmp + 4, 12);
 	fd = alg_new(crypto->cmac_aes, tmp, 16);
 	if (fd < 0)
 		return false;
 
-	len = send(fd, m, m_len, 0);
+	len = send(fd, msg, msg_len, 0);
 	if (len < 0)
 		return false;
 
@@ -283,6 +292,12 @@ bool bt_crypto_sign_att(struct bt_crypto *crypto, const uint8_t key[16],
 		return false;
 
 	/*
+	 * As to BT spec. 4.1 Vol[3], Part C, chapter 10.4.1 sign counter should
+	 * be placed in the signature
+	 */
+	put_le32(sign_cnt, out + 8);
+
+	/*
 	 * The most significant octet of hash corresponds to out[0]  - swap it.
 	 * Then truncate in most significant bit first order to a length of
 	 * 12 octets
diff --git a/src/shared/crypto.h b/src/shared/crypto.h
index 64faed2..c4588ee 100644
--- a/src/shared/crypto.h
+++ b/src/shared/crypto.h
@@ -48,4 +48,5 @@ bool bt_crypto_s1(struct bt_crypto *crypto, const uint8_t k[16],
 			uint8_t res[16]);
 bool bt_crypto_sign_att(struct bt_crypto *crypto, const uint8_t key[16],
 					const uint8_t *m, uint16_t m_len,
+					uint32_t sign_cnt,
 					uint8_t signature[12]);
diff --git a/unit/test-crypto.c b/unit/test-crypto.c
index 8b44f4e..9bc072b 100644
--- a/unit/test-crypto.c
+++ b/unit/test-crypto.c
@@ -46,7 +46,7 @@ static const uint8_t key[] = {
 static const uint8_t msg_1[] = { 0x00 };
 
 static const uint8_t t_msg_1[] = {
-	0x12, 0x7d, 0xa3, 0x7f, 0x28, 0x37, 0x59, 0xe9, 0x29, 0x69, 0x1d, 0xbb
+	0x00, 0x00, 0x00, 0x00, 0xb3, 0xa8, 0x59, 0x41, 0x27, 0xeb, 0xc2, 0xc0
 };
 
 static const struct test_data test_data_1 = {
@@ -62,7 +62,7 @@ static const uint8_t msg_2[] = {
 };
 
 static const uint8_t t_msg_2[] = {
-	0x9d, 0xdd, 0x9b, 0xf7, 0x44, 0x41, 0x4d, 0x6b, 0xb4, 0x16, 0x0a, 0x07
+	0x00, 0x00, 0x00, 0x00, 0x79, 0xc1, 0x60, 0x5b, 0x71, 0x32, 0x68, 0x59
 };
 
 static const struct test_data test_data_2 = {
@@ -79,7 +79,7 @@ static const uint8_t msg_3[] = {
 };
 
 static const uint8_t t_msg_3[12] = {
-	0x61, 0x32, 0xca, 0x30, 0x30, 0xe6, 0x9a, 0xde, 0x47, 0x67, 0xa6, 0xdf
+	0x00, 0x00, 0x00, 0x00, 0x3e, 0xc3, 0x46, 0x95, 0x2c, 0xdf, 0x88, 0x32
 };
 
 static const struct test_data test_data_3 = {
@@ -98,7 +98,7 @@ static const uint8_t msg_4[] = {
 };
 
 static const uint8_t t_msg_4[12] = {
-	0x17, 0x74, 0x49, 0xfc, 0x92, 0x9d, 0x3b, 0x7e, 0xbf, 0xbe, 0xf0, 0x51
+	0x00, 0x00, 0x00, 0x00, 0x43, 0x0c, 0xaa, 0x71, 0x19, 0x73, 0xbb, 0x59
 };
 
 static const struct test_data test_data_4 = {
@@ -139,7 +139,7 @@ static void test_sign(gconstpointer data)
 	const struct test_data *d = data;
 
 	memset(t, 0, 12);
-	if (!bt_crypto_sign_att(crypto, key, d->msg, d->msg_len, t))
+	if (!bt_crypto_sign_att(crypto, key, d->msg, d->msg_len, 0, t))
 		g_assert(true);
 
 	if (g_test_verbose()) {
-- 
1.8.4

