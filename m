Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [RFC 1/2] shared/aes-cmac: Add support for AES-CMAC-128
Date: Tue, 13 May 2014 12:44:27 +0200
Message-Id: <1399977868-31937-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1399977868-31937-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1399977868-31937-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds handling AES-CMAC-128 signing as specified in the NIST
Special Publication 800-38B
---
 src/shared/aes-cmac.c | 346 ++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/aes-cmac.h |  38 ++++++
 2 files changed, 384 insertions(+)
 create mode 100644 src/shared/aes-cmac.c
 create mode 100644 src/shared/aes-cmac.h

diff --git a/src/shared/aes-cmac.c b/src/shared/aes-cmac.c
new file mode 100644
index 0000000..660ceff
--- /dev/null
+++ b/src/shared/aes-cmac.c
@@ -0,0 +1,346 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under typedef struct {
+	uint64_t a, b;
+} u128;the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include "src/shared/aes-cmac.h"
+#include "src/shared/util.h"
+#include "src/shared/crypto.h"
+
+#include <stdio.h>
+#include <string.h>
+
+struct bt_ac {
+	struct bt_crypto *crypto;
+
+	uint8_t k[16];
+	uint8_t k1[16];
+	uint8_t k2[16];
+
+	bool sign_counter;
+	uint32_t sign_counter_val;
+};
+
+static void ac_subkey_gen(const uint8_t l[16], uint8_t sub_k[16])
+{
+	int i;
+
+	memset(sub_k, 0, 16);
+
+	/* Left shifting */
+	for (i = 0; i < 16; i++) {
+		uint16_t p = l[i];
+
+		p <<= 1;
+		sub_k[i] |= p & 0xff;
+
+		if (i == 15)
+			break;
+
+		/* Don't forget moving bit */
+		sub_k[i + 1] = p >> 8;
+	}
+
+	if (l[15] & 0x80)
+		sub_k[0] ^= 0x87;
+}
+
+/*
+ * This function generates sub keys according to AES-CMAC
+ *
+ * As an input we have k which is 128 bits
+ *
+ * There are two sub keys generated in following way:
+ *
+ * L = AES-128 (K, 0^16)
+ * for i = 1,2 {
+ *     if MSB(L)
+ *         K_i = L << 1 ^ 0x87
+ *     else
+ *         K_i = L << 1
+ *
+ *     L = K_i
+ * }
+ */
+static bool ac_subkeys_gen(struct bt_crypto *crypto, const uint8_t k[16],
+					uint8_t k1[16], uint8_t k2[16])
+{
+	uint8_t z[16];
+	uint8_t l[16];
+
+	memset(z, 0, 16);
+	memset(l, 0, 16);
+
+	/* AES encryption of 16 bytes z */
+	if (!bt_crypto_e(crypto, k, z, l))
+		return false;
+
+	/* Generate sub keys - K1, K2 */
+	ac_subkey_gen(l, k1);
+	ac_subkey_gen(k1, k2);
+
+	return true;
+}
+
+struct bt_ac *bt_ac_new(const uint8_t k[16], bool sign_counter)
+{
+	struct bt_ac *ac;
+	struct bt_crypto *crypto;
+
+	ac = new0(struct bt_ac, 1);
+	if (!ac)
+		return NULL;
+
+	crypto = bt_crypto_new();
+	if (!crypto)
+		goto failed;
+
+	if (!ac_subkeys_gen(crypto, k, ac->k1, ac->k2))
+		goto failed;
+
+	memcpy(ac->k, k, 16);
+	ac->crypto = crypto;
+
+	/*
+	 * Enable sign counter as specified in BT Core Spec 4.1 Vol[3], Part H
+	 * Chapter 2.4.5
+	 */
+	ac->sign_counter = sign_counter;
+
+	return ac;
+
+failed:
+	free(ac);
+	return NULL;
+}
+
+void bt_ac_destroy(struct bt_ac *aes_cmac)
+{
+	if (!aes_cmac)
+		return;
+
+	bt_crypto_unref(aes_cmac->crypto);
+
+	free(aes_cmac);
+}
+
+typedef struct {
+	uint64_t a, b;
+} u128;
+
+static inline void u128_xor(const uint8_t p[16], const uint8_t q[16],
+								uint8_t r[16])
+{
+	u128 pp, qq, rr;
+
+	memcpy(&pp, p, 16);
+	memcpy(&qq, q, 16);
+
+	rr.a = pp.a ^ qq.a;
+	rr.b = pp.b ^ qq.b;
+
+	memcpy(r, &rr, 16);
+}
+
+static inline void swap128(const uint8_t src[16], uint8_t dst[16])
+{
+	int i;
+
+	for (i = 0; i < 16; i++)
+		dst[15 - i] = src[i];
+}
+
+static bool encode_block(struct bt_ac *aes_cmac, const uint8_t m[16],
+								uint8_t c[16])
+{
+	uint8_t tmp[16];
+	uint8_t mp[16];
+
+	/* Swap the message so crypto will get less significant byte in m[0] */
+	swap128(m, tmp);
+
+	/* Xor with previous encrypted block */
+	u128_xor(tmp, c, mp);
+
+	/* AES-128 using k */
+	if (!bt_crypto_e(aes_cmac->crypto, aes_cmac->k, mp, c))
+		return false;
+
+	return true;
+}
+
+static bool encode_last_block(struct bt_ac *aes_cmac, const uint8_t m[16],
+						uint16_t len, uint8_t c[16])
+{
+	uint8_t tmp[16];
+	uint8_t mp[16];
+	uint8_t mpp[16];
+	bool flag;
+
+	/* Flag if msg is complete */
+	flag = (len != 16);
+
+	/* Swap the message so crypto will get less significant byte in m[0] */
+	swap128(m, tmp);
+
+	/* Note: add padding on swapped message*/
+	if (flag)
+		tmp[15-len] |= 0x80;
+
+	/* Last block we need to xor with K1 or K2 */
+	u128_xor(tmp, flag ? aes_cmac->k2 : aes_cmac->k1, mp);
+
+	/* Xor with previous encrypted block */
+	u128_xor(mp, c, mpp);
+
+	/* AES-128 using k */
+	if (!bt_crypto_e(aes_cmac->crypto, aes_cmac->k, mpp, c))
+		return false;
+
+	return true;
+}
+
+/*
+ * AES-CMAC-128 signing function
+ *
+ * This function is used to sign data with algorithm defined in the NIST Special
+ * Publication 800-38B
+ *
+ * The following are inputs of the signing algorithm:
+ *     m is a variable length
+ *     key k is 128 bits
+ *     sign_counter is 32 bits
+ *
+ * Before this functions is called, sub keys k1 and k2 are generated.
+ * See ac_subkeys_gen.
+ *
+ * If sing_counter has been enabled then message before will be concatenated
+ * with 32 bits sing_counter as described in BT Core Spec 4.1 Vol[3], Part H
+ * Chapter 2.4.5
+ *
+ *     M = m || sign_counter
+ *
+ * Message is build from blocks M_i:
+ *     M = M_1 || M_2 || ... || M_{n-1} || M_n
+ *
+ * Length of M_i is 128 bits for 0 < i < n and the length of last block is less
+ * than or equal to 128 bits.
+ *
+ *     If length of M_n is less than 128 then
+ *         (M_n)' = (M_n || padding) ^ K2
+ *     else
+ *         (M_n)' = M_n ^ K1
+ *
+ * Where padding is 10^i and i = 128 - 8 * len(M_n) - 1
+ *
+ * For example: M_n            = 0x30c81c46a35ce411
+ *              M_n || padding = 0x30c81c46a35ce4118000000000000000
+ *
+ * Signing procedure uses AES-CBC (Cipher block chaining mode):
+ *
+ * C = 0
+ * For each M_i
+ *     Y = C ^ M_i
+ *     C = AES-128(K,Y)
+ *
+ * Last encrypted block X, truncated to 12 octects taken in MSB order is the
+ * sign result T.
+ */
+bool bt_ac_sign(struct bt_ac *aes_cmac, const uint8_t *m, uint16_t m_len,
+								uint8_t t[12])
+{
+	uint8_t sc_len = aes_cmac->sign_counter ? sizeof(uint32_t) : 0;
+	uint16_t len = m_len + sc_len;
+	uint8_t mp[len];
+	uint8_t c[16];
+	uint8_t tmp[16];
+	int i = 0;
+
+	/* Handle sign_counter if necessary */
+	memset(mp, 0, len);
+	memcpy(mp, m, m_len);
+
+	if (aes_cmac->sign_counter)
+		put_le32(aes_cmac->sign_counter_val++, mp + m_len);
+	/*
+	 * We are doing AES-CBC. In C we will keep last encrypted block.
+	 * C(0) is just 16 bytes zeros message.
+	 */
+	memset(c, 0, 16);
+
+	/* Start AES-CBC of n-1 blocks of data.*/
+	for (i = 0; len - i > 16; i += 16) {
+		memcpy(tmp, mp + i , 16);
+
+		/*
+		 * In C we provide last encrypted block and next encrypted block
+		 * will be returned
+		 */
+		if (!encode_block(aes_cmac, tmp, c))
+			return false;
+	}
+
+	/* Handle last block of data */
+	memset(tmp, 0, 16);
+	memcpy(tmp, mp + i , len - i);
+
+	/* Padding is handled inside this function */
+	if (!encode_last_block(aes_cmac, tmp, len - i, c))
+		return false;
+
+	/* Signature is a 12 octets of last encrypted block C(n) */
+	memcpy(t, c + 4, 12);
+	return true;
+}
+
+static bool verify(const uint8_t t[12], const uint8_t tp[12])
+{
+	int i;
+	for (i = 0; i < 12; i++)
+		if (t[i] != tp[i])
+			return false;
+
+	return true;
+}
+
+bool bt_ac_verify(struct bt_ac *aes_cmac, const uint8_t *m,
+						uint16_t m_len, uint8_t t[12])
+{
+	uint8_t tp[12];
+
+	memset(tp, 0, 12);
+
+	if (!bt_ac_sign(aes_cmac, m, m_len, tp))
+		return false;
+
+	return verify(t, tp);
+}
+
+uint32_t bt_ac_get_sign_counter(struct bt_ac *aes_cmac)
+{
+	return aes_cmac->sign_counter_val;
+}
diff --git a/src/shared/aes-cmac.h b/src/shared/aes-cmac.h
new file mode 100644
index 0000000..62068aa
--- /dev/null
+++ b/src/shared/aes-cmac.h
@@ -0,0 +1,38 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include <stdbool.h>
+#include <stdint.h>
+
+struct bt_ac;
+
+struct bt_ac *bt_ac_new(const uint8_t k[16], bool sign_counter);
+void bt_ac_destroy(struct bt_ac *aes_cmac);
+
+bool bt_ac_sign(struct bt_ac *aes_cmac, const uint8_t *m, uint16_t m_len,
+								uint8_t t[12]);
+
+bool bt_ac_verify(struct bt_ac *aes_cmac, const uint8_t *m, uint16_t m_len,
+								uint8_t t[12]);
+
+uint32_t bt_ac_get_sign_counter(struct bt_ac *aes_cmac);
-- 
1.8.4

