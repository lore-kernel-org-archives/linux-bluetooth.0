Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 2/3] shared/crypto: Add support to sign data with AES-CMAC
Date: Thu, 15 May 2014 08:15:31 +0200
Message-Id: <1400134532-26574-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1400134532-26574-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1400134532-26574-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support to generate hash using AES-CMAC algorithm
---
 src/shared/crypto.c | 36 ++++++++++++++++++++++++++++++++++++
 src/shared/crypto.h |  3 +++
 2 files changed, 39 insertions(+)

diff --git a/src/shared/crypto.c b/src/shared/crypto.c
index f0b2979..0aec373 100644
--- a/src/shared/crypto.c
+++ b/src/shared/crypto.c
@@ -256,6 +256,42 @@ static inline void swap128(const uint8_t src[16], uint8_t dst[16])
 		dst[15 - i] = src[i];
 }
 
+bool bt_crypto_sign_att(struct bt_crypto *crypto, const uint8_t key[16],
+					const uint8_t *m, uint16_t m_len,
+					uint8_t signature[12])
+{
+	int fd;
+	int len;
+	uint8_t tmp[16], out[16];
+
+	if (!crypto)
+		return false;
+
+	/* The most significant octet of key corresponds to key[0] */
+	swap128(key, tmp);
+
+	fd = alg_new(crypto->cmac_aes, tmp, 16);
+	if (fd < 0)
+		return false;
+
+	len = send(fd, m, m_len, 0);
+	if (len < 0)
+		return false;
+
+	len = read(fd, out, 16);
+	if (len < 0)
+		return false;
+
+	/*
+	 * The most significant octet of hash corresponds to out[0]  - swap it.
+	 * Then truncate in most significant bit first order to a length of
+	 * 12 octets
+	 */
+	swap128(out, tmp);
+	memcpy(signature, tmp + 4, 12);
+
+	return true;
+}
 /*
  * Security function e
  *
diff --git a/src/shared/crypto.h b/src/shared/crypto.h
index cae8daa..64faed2 100644
--- a/src/shared/crypto.h
+++ b/src/shared/crypto.h
@@ -46,3 +46,6 @@ bool bt_crypto_c1(struct bt_crypto *crypto, const uint8_t k[16],
 bool bt_crypto_s1(struct bt_crypto *crypto, const uint8_t k[16],
 			const uint8_t r1[16], const uint8_t r2[16],
 			uint8_t res[16]);
+bool bt_crypto_sign_att(struct bt_crypto *crypto, const uint8_t key[16],
+					const uint8_t *m, uint16_t m_len,
+					uint8_t signature[12]);
-- 
1.8.4

