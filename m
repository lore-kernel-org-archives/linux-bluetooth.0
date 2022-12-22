Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35497C4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Dec 2022 22:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbiLVWnj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Dec 2022 17:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiLVWng (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Dec 2022 17:43:36 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCFCA454
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Dec 2022 14:43:35 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id t18so2161526pfq.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Dec 2022 14:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SHaWOlOm7jgNY7jeaRPYb+rl9KCBQx+25Z+0YLymEv4=;
        b=lM76fjfoOHBpmQmedOCp1dLnEuZp2/vpAZSqVmPL9g7KHiZnGcjdSKY9O9xzKILuJ2
         lFDlfW+Ssj/EZcs7jRHjdtDcYMoAFqvC8EHlMsMPbNeksPEiEQjK7g4NgAn0+3I55Y/v
         fs3BvK9/N/+AQAFY5d/cMxK9KzoHDwkewsupC7rEG9hlUUoilb3U7aIkmx1/6Nd0ANKr
         XolVOgIbQOnMJ5hErarIDtelZ4y/wsu8BX1fR/8uJd3AasMWGTT0mJOusK1q+33oYane
         if0wWtc0+gjzdBy7/vAQ93pM+SbBtX+PtCAsFWiC21rwnXI454pu/cpUWjFQHnQQZYNT
         jweQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SHaWOlOm7jgNY7jeaRPYb+rl9KCBQx+25Z+0YLymEv4=;
        b=2yOedmp0HwCqdL17MNrlqQP2fl0O+gkkvFVucvb7SYLfrMnOC5qUR9zkQ4Q84NqYod
         jX/KFq9xYW4UzDJitWTHBNs7lWVCq3CleyRRje48VX5JTO8l7MDPvAbBZGCjOUYxTZdF
         QQKiK5J1QS/Q/rrW5DuAS/ZbT67OkcRzwPTr5LsoTQvZPVLm/HSYYui/U+kxkWxW+Yx9
         W070kqAKq+V4zuQwTus7uVYrmMVeRNYv0c7701i3cFvX9XE4D++Yo33hk+lJqyeyUs3H
         VYK0i/kSY9UzzV9x6tQ3XOnclwZZgxmxIjE1LRUbWFYqg7TsRnPuvRR8YE1/W3dNxX3F
         t1Lg==
X-Gm-Message-State: AFqh2krNZK+wf5+MEEQHdc6FcTU7jxJyNz8IJttM2e6zjrZKg7+0MQx2
        hvBsVckDGeO3npUWTMKO5iFYRvV34ug3vQ==
X-Google-Smtp-Source: AMrXdXsibb5azhZTaBJ/o/bpKNU+koRdqxkqdKGnCWs4+SchEzFpLsS8G0xMrC+oklBoW55aP0ZYQQ==
X-Received: by 2002:a62:f20f:0:b0:56b:b890:6ccd with SMTP id m15-20020a62f20f000000b0056bb8906ccdmr7967779pfh.4.1671749014058;
        Thu, 22 Dec 2022 14:43:34 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f6-20020aa79d86000000b0056bbeaa82b9sm1187546pfq.113.2022.12.22.14.43.33
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 14:43:33 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/5] shared/crypto: Adds bt_crypto_sef
Date:   Thu, 22 Dec 2022 14:43:27 -0800
Message-Id: <20221222224329.685837-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221222224329.685837-1-luiz.dentz@gmail.com>
References: <20221222224329.685837-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bt_crypto_sef is is used to create a hash as stated on CSIS
spec:

  '4.5. SIRK encryption function sef'

https://www.bluetooth.com/specifications/csis-1-0-1/
---
 src/shared/crypto.c | 171 +++++++++++++++++++++++++++++++++++++++++---
 src/shared/crypto.h |   2 +
 2 files changed, 164 insertions(+), 9 deletions(-)

diff --git a/src/shared/crypto.c b/src/shared/crypto.c
index f164ba69d2a5..4cb2ea857ea8 100644
--- a/src/shared/crypto.c
+++ b/src/shared/crypto.c
@@ -586,41 +586,55 @@ bool bt_crypto_s1(struct bt_crypto *crypto, const uint8_t k[16],
 	return bt_crypto_e(crypto, k, res, res);
 }
 
-static bool aes_cmac(struct bt_crypto *crypto, const uint8_t key[16],
+static bool aes_cmac_be(struct bt_crypto *crypto, const uint8_t key[16],
 			const uint8_t *msg, size_t msg_len, uint8_t res[16])
 {
-	uint8_t key_msb[16], out[16], msg_msb[CMAC_MSG_MAX];
 	ssize_t len;
 	int fd;
 
 	if (msg_len > CMAC_MSG_MAX)
 		return false;
 
-	swap_buf(key, key_msb, 16);
-	fd = alg_new(crypto->cmac_aes, key_msb, 16);
+	fd = alg_new(crypto->cmac_aes, key, 16);
 	if (fd < 0)
 		return false;
 
-	swap_buf(msg, msg_msb, msg_len);
-	len = send(fd, msg_msb, msg_len, 0);
+	len = send(fd, msg, msg_len, 0);
 	if (len < 0) {
 		close(fd);
 		return false;
 	}
 
-	len = read(fd, out, 16);
+	len = read(fd, res, 16);
 	if (len < 0) {
 		close(fd);
 		return false;
 	}
 
-	swap_buf(out, res, 16);
-
 	close(fd);
 
 	return true;
 }
 
+static bool aes_cmac(struct bt_crypto *crypto, const uint8_t key[16],
+			const uint8_t *msg, size_t msg_len, uint8_t res[16])
+{
+	uint8_t key_msb[16], out[16], msg_msb[CMAC_MSG_MAX];
+
+	if (msg_len > CMAC_MSG_MAX)
+		return false;
+
+	swap_buf(key, key_msb, 16);
+	swap_buf(msg, msg_msb, msg_len);
+
+	if (!aes_cmac_be(crypto, key_msb, msg_msb, msg_len, out))
+		return false;
+
+	swap_buf(out, res, 16);
+
+	return true;
+}
+
 bool bt_crypto_f4(struct bt_crypto *crypto, uint8_t u[32], uint8_t v[32],
 				uint8_t x[16], uint8_t z, uint8_t res[16])
 {
@@ -773,3 +787,142 @@ bool bt_crypto_sih(struct bt_crypto *crypto, const uint8_t k[16],
 {
 	return bt_crypto_ah(crypto, k, r, hash);
 }
+
+static bool aes_cmac_zero(struct bt_crypto *crypto, const uint8_t *msg,
+					size_t msg_len, uint8_t res[16])
+{
+	const uint8_t zero[16] = {};
+
+	return aes_cmac_be(crypto, zero, msg, msg_len, res);
+}
+
+/* The inputs to function s1 are:
+ *
+ *   M is a non-zero length octet array or ASCII encoded string
+ *
+ * If M is an ASCII encoded string, M shall be converted into an integer number
+ * by replacing each string character with its ASCII code preserving the order.
+ * For example, if M is the string “CSIS”, M is converted into the integer
+ * number: 0x4353 4953.
+ *
+ * ZERO is the 128-bit value:
+ *
+ *   0x0000 0000 0000 0000 0000 0000 0000 0000
+ *
+ * The output of the salt generation function s1 shall be calculated as follows:
+ *
+ *   s1(M)=AES‐CMACZERO(M)
+ *
+ * Where AES-CMACZERO is the CMAC function defined in Section 4.2.
+ */
+static bool sef_s1(struct bt_crypto *crypto, const uint8_t *m,
+					size_t m_len, uint8_t res[16])
+{
+	/* s1(M)=AES‐CMACZERO(M) */
+	return aes_cmac_zero(crypto, m, m_len, res);
+}
+
+/* The key derivation function k1 is used to derive a key. The derived key is
+ * used to encrypt and decrypt the value of the Set Identity Resolving Key
+ * characteristic (see Section 5.1).
+ *
+ * The definition of this key generation function uses the MAC function
+ * AES-CMACT with a 128-bit key T.
+ *
+ * The inputs to function k1 are:
+ *
+ *   N is 0 or more octets
+ *
+ *   SALT is 128 bits
+ *
+ *   P is 0 or more octets
+ *
+ * The key (T) shall be computed as follows:
+ *
+ *   T=AES‐CMACSALT(N)
+ *
+ * Where AES-CMACSALT is the CMAC function defined in Section 4.2.
+ *
+ * The output of the key generation function k1 shall be calculated as follows:
+ *
+ *   k1(N, SALT, P)=AES‐CMACT(P)
+ *
+ * Where AES-CMACT is the CMAC function defined in Section 4.2.
+ */
+static bool sef_k1(struct bt_crypto *crypto, const uint8_t n[16],
+				uint8_t salt[16], const uint8_t *p,
+				size_t p_len, uint8_t res[16])
+{
+	uint8_t res1[16];
+
+	/* T=AES‐CMACSALT(N) */
+	if (!aes_cmac_be(crypto, salt, n, 16, res1))
+		return false;
+
+	/* k1(N, SALT, P)=AES‐CMACT(P) */
+	return aes_cmac_be(crypto, res1, p, p_len, res);
+}
+
+/*
+ * SIRK encryption function sef
+ *
+ * The SIRK encryption function sef shall be used by the server to encrypt the
+ * SIRK with a key K. The value of K depends on the transport on which the Set
+ * Identity Resolving Key characteristic is read or notified.
+ *
+ * If the Set Identity Resolving Key characteristic is read or notified on the
+ * Basic Rate/Enhanced Data Rate (BR/EDR) transport, K shall be equal to the
+ * Link Key shared by the server and the client.
+ *
+ *   K=LinkKey
+ *
+ * If the Set Identity Resolving Key characteristic is read or notified on the
+ * Bluetooth Low Energy (LE) transport, K shall be equal to the LTK shared by
+ * the server and client. That is,
+ *
+ *   K=LTK
+ *
+ * The inputs to the function sef are:
+ *
+ *   K is the key defined above in this section
+ *
+ *   SIRK is the value of the SIRK to be encrypted
+ *
+ * The output of the SIRK encryption function sef is as follows:
+ *
+ *   sef(K, SIRK)=k1(K, s1(“SIRKenc”), “csis”)^SIRK
+ *
+ * Where ^ is the bitwise exclusive or operation.
+ */
+bool bt_crypto_sef(struct bt_crypto *crypto, const uint8_t k[16],
+			const uint8_t sirk[16], uint8_t out[16])
+{
+	const uint8_t m[] = {'S', 'I', 'R', 'K', 'e', 'n', 'c'};
+	const uint8_t p[] = {'c', 's', 'i', 's'};
+	uint8_t k_msb[16];
+	uint8_t salt[16];
+	uint8_t res_msb[16];
+	uint8_t res[16];
+
+	if (!crypto)
+		return false;
+
+	/* salt = s1(“SIRKenc”) */
+	if (!sef_s1(crypto, m, sizeof(m), salt))
+		return false;
+
+	/* Convert K to MSB/BE format */
+	swap_buf(k, k_msb, 16);
+
+	/* res_msb = k1(K, salt, “csis”) */
+	if (!sef_k1(crypto, k_msb, salt, p, sizeof(p), res_msb))
+		return false;
+
+	/* Convert back to LSB/LE format */
+	swap_buf(res_msb, res, 16);
+
+	/* res^SIRK */
+	u128_xor(res, sirk, out);
+
+	return true;
+}
diff --git a/src/shared/crypto.h b/src/shared/crypto.h
index fca52e38e5e2..fc1ba0c4feeb 100644
--- a/src/shared/crypto.h
+++ b/src/shared/crypto.h
@@ -53,5 +53,7 @@ bool bt_crypto_verify_att_sign(struct bt_crypto *crypto, const uint8_t key[16],
 				const uint8_t *pdu, uint16_t pdu_len);
 bool bt_crypto_gatt_hash(struct bt_crypto *crypto, struct iovec *iov,
 				size_t iov_len, uint8_t res[16]);
+bool bt_crypto_sef(struct bt_crypto *crypto, const uint8_t k[16],
+			const uint8_t sirk[16], uint8_t out[16]);
 bool bt_crypto_sih(struct bt_crypto *crypto, const uint8_t k[16],
 					const uint8_t r[3], uint8_t hash[3]);
-- 
2.37.3

