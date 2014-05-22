Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 01/12] shared/crypto: Extend bt_crypto_sign_att with sign counter
Date: Thu, 22 May 2014 10:07:31 +0200
Message-Id: <1400746062-24766-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1400746062-24766-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1400746062-24766-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Sign counter is use in two places during att signing:
1) Shall be concatenated with siging message before sigining: BT spec
4.1, Vol[3], Part H, chapter 2.4.5

2) Shall be a part of signature send in the att packet: BT spec 4.1
Vol[3], Part C, chapter 10.4.1

With this patch, bt_crypto_sign_att returns correct signature.

Note: For testing purpose it is possible to provide sign counter
less then 0.
---
 src/shared/crypto.c | 24 ++++++++++++++++++++----
 src/shared/crypto.h |  1 +
 unit/test-crypto.c  |  2 +-
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/src/shared/crypto.c b/src/shared/crypto.c
index 0aec373..fed8912 100644
--- a/src/shared/crypto.c
+++ b/src/shared/crypto.c
@@ -258,23 +258,32 @@ static inline void swap128(const uint8_t src[16], uint8_t dst[16])
 
 bool bt_crypto_sign_att(struct bt_crypto *crypto, const uint8_t key[16],
 					const uint8_t *m, uint16_t m_len,
-					uint8_t signature[12])
+					int32_t sign_cnt, uint8_t signature[12])
 {
 	int fd;
 	int len;
 	uint8_t tmp[16], out[16];
+	uint16_t msg_len = m_len + sizeof(uint32_t);
+	uint8_t msg[msg_len];
 
-	if (!crypto)
-		return false;
+	memset(msg, 0, msg_len);
+	memcpy(msg, m, m_len);
+
+	/* Add sign_counter to the message */
+	if (sign_cnt >= 0)
+		put_le32(sign_cnt, msg + msg_len);
+	else
+		msg_len = m_len;
 
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
 
@@ -283,6 +292,13 @@ bool bt_crypto_sign_att(struct bt_crypto *crypto, const uint8_t key[16],
 		return false;
 
 	/*
+	 *  If there is sign counter available it should be placed in the
+	 *  signature as specified in BT spec. 4.1 Vol[3], Part C,
+	 *  chapter 10.4.1
+	 */
+	if (sign_cnt >= 0)
+		put_le32(sign_cnt, out + 8);
+	/*
 	 * The most significant octet of hash corresponds to out[0]  - swap it.
 	 * Then truncate in most significant bit first order to a length of
 	 * 12 octets
diff --git a/src/shared/crypto.h b/src/shared/crypto.h
index 64faed2..1985424 100644
--- a/src/shared/crypto.h
+++ b/src/shared/crypto.h
@@ -48,4 +48,5 @@ bool bt_crypto_s1(struct bt_crypto *crypto, const uint8_t k[16],
 			uint8_t res[16]);
 bool bt_crypto_sign_att(struct bt_crypto *crypto, const uint8_t key[16],
 					const uint8_t *m, uint16_t m_len,
+					int32_t sign_cnt,
 					uint8_t signature[12]);
diff --git a/unit/test-crypto.c b/unit/test-crypto.c
index 8b44f4e..34828e0 100644
--- a/unit/test-crypto.c
+++ b/unit/test-crypto.c
@@ -139,7 +139,7 @@ static void test_sign(gconstpointer data)
 	const struct test_data *d = data;
 
 	memset(t, 0, 12);
-	if (!bt_crypto_sign_att(crypto, key, d->msg, d->msg_len, t))
+	if (!bt_crypto_sign_att(crypto, key, d->msg, d->msg_len, -1, t))
 		g_assert(true);
 
 	if (g_test_verbose()) {
-- 
1.8.4

