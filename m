Return-Path: <SRS0=mLwb=T5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C903BC28CC0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 May 2019 17:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A36523F99
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 May 2019 17:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbfE2R2o (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 May 2019 13:28:44 -0400
Received: from mga04.intel.com ([192.55.52.120]:18630 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbfE2R2o (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 May 2019 13:28:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 May 2019 10:28:41 -0700
X-ExtLoop1: 1
Received: from bgix-dell-lap.sea.intel.com ([10.255.231.30])
  by fmsmga006.fm.intel.com with ESMTP; 29 May 2019 10:28:40 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com,
        michal.lowas-rzechonek@silvair.com, marcel@holtmann.org,
        johan.hedberg@gmail.com, denkenz@gmail.com
Subject: [PATCH BlueZ 1/1] mesh: Convert crypto to use ELL wrappers
Date:   Wed, 29 May 2019 10:28:18 -0700
Message-Id: <20190529172818.8844-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190529172818.8844-1-brian.gix@intel.com>
References: <20190529172818.8844-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Use ELL implementations of aead-ccm(aes), ecb(aes) and cmac(aes). These
standard encryption and hashing routines are provided by ELL.
---
 Makefile.am   |   4 +
 mesh/crypto.c | 518 ++++++----------------------------------------------------
 2 files changed, 58 insertions(+), 464 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index f84a1faba..2583fbdd9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -116,6 +116,8 @@ ell_headers = ell/util.h \
 			ell/random.h \
 			ell/signal.h \
 			ell/timeout.h \
+			ell/cipher.h \
+			ell/checksum.h \
 			ell/io.h \
 			ell/idle.h \
 			ell/main.h \
@@ -138,6 +140,8 @@ ell_sources = ell/private.h ell/missing.h \
 			ell/main.c \
 			ell/strv.c \
 			ell/string.c \
+			ell/cipher.c \
+			ell/checksum.c \
 			ell/dbus-private.h \
 			ell/dbus.c \
 			ell/dbus-message.c \
diff --git a/mesh/crypto.c b/mesh/crypto.c
index 085e72798..3fa0df246 100644
--- a/mesh/crypto.c
+++ b/mesh/crypto.c
@@ -44,193 +44,52 @@
 /* Multiply used Zero array */
 static const uint8_t zero[16] = { 0, };
 
-static int alg_new(int fd, const void *keyval, socklen_t keylen,
-							size_t mic_size)
+static bool aes_ecb_one(const uint8_t key[16], const uint8_t in[16],
+								uint8_t out[16])
 {
-	if (setsockopt(fd, SOL_ALG, ALG_SET_KEY, keyval, keylen) < 0)
-		return -1;
+	void *cipher;
+	bool result = false;
 
-	if (mic_size &&
-		setsockopt(fd, SOL_ALG, ALG_SET_AEAD_AUTHSIZE,
-							NULL, mic_size) < 0)
-		return -1;
+	cipher = l_cipher_new(L_CIPHER_AES, key, 16);
 
-	/* FIXME: This should use accept4() with SOCK_CLOEXEC */
-	return accept(fd, NULL, 0);
-}
-
-static bool alg_encrypt(int fd, const void *inbuf, size_t inlen,
-						void *outbuf, size_t outlen)
-{
-	__u32 alg_op = ALG_OP_ENCRYPT;
-	char cbuf[CMSG_SPACE(sizeof(alg_op))];
-	struct cmsghdr *cmsg;
-	struct msghdr msg;
-	struct iovec iov;
-	ssize_t len;
-
-	memset(cbuf, 0, sizeof(cbuf));
-	memset(&msg, 0, sizeof(msg));
-
-	msg.msg_control = cbuf;
-	msg.msg_controllen = sizeof(cbuf);
-
-	cmsg = CMSG_FIRSTHDR(&msg);
-	cmsg->cmsg_level = SOL_ALG;
-	cmsg->cmsg_type = ALG_SET_OP;
-	cmsg->cmsg_len = CMSG_LEN(sizeof(alg_op));
-	memcpy(CMSG_DATA(cmsg), &alg_op, sizeof(alg_op));
-
-	iov.iov_base = (void *) inbuf;
-	iov.iov_len = inlen;
-
-	msg.msg_iov = &iov;
-	msg.msg_iovlen = 1;
-
-	len = sendmsg(fd, &msg, 0);
-	if (len < 0)
-		return false;
-
-	len = read(fd, outbuf, outlen);
-	if (len < 0)
-		return false;
-
-	return true;
-}
-
-static int aes_ecb_setup(const uint8_t key[16])
-{
-	struct sockaddr_alg salg;
-	int fd, nfd;
-
-	fd = socket(PF_ALG, SOCK_SEQPACKET | SOCK_CLOEXEC, 0);
-	if (fd < 0)
-		return -1;
-
-	memset(&salg, 0, sizeof(salg));
-	salg.salg_family = AF_ALG;
-	strcpy((char *) salg.salg_type, "skcipher");
-	strcpy((char *) salg.salg_name, "ecb(aes)");
-
-	if (bind(fd, (struct sockaddr *) &salg, sizeof(salg)) < 0) {
-		close(fd);
-		return -1;
+	if (cipher) {
+		result = l_cipher_encrypt(cipher, in, out, 16);
+		l_cipher_free(cipher);
 	}
 
-	nfd = alg_new(fd, key, 16, 0);
-
-	close(fd);
-
-	return nfd;
-}
-
-static bool aes_ecb(int fd, const uint8_t plaintext[16], uint8_t encrypted[16])
-{
-	return alg_encrypt(fd, plaintext, 16, encrypted, 16);
-}
-
-static void aes_ecb_destroy(int fd)
-{
-	close(fd);
-}
-
-static bool aes_ecb_one(const uint8_t key[16],
-			const uint8_t plaintext[16], uint8_t encrypted[16])
-{
-	bool result;
-	int fd;
-
-	fd = aes_ecb_setup(key);
-	if (fd < 0)
-		return false;
-
-	result = aes_ecb(fd, plaintext, encrypted);
-
-	aes_ecb_destroy(fd);
-
 	return result;
 }
 
-bool mesh_aes_ecb_one(const uint8_t key[16],
-			const uint8_t plaintext[16], uint8_t encrypted[16])
-{
-	return aes_ecb_one(key, plaintext, encrypted);
-}
-
-/* Maximum message length that can be passed to aes_cmac */
-#define CMAC_MSG_MAX	(64 + 64 + 17)
-
-static int aes_cmac_setup(const uint8_t key[16])
-{
-	struct sockaddr_alg salg;
-	int fd, nfd;
-
-	fd = socket(PF_ALG, SOCK_SEQPACKET | SOCK_CLOEXEC, 0);
-	if (fd < 0)
-		return -1;
-
-	memset(&salg, 0, sizeof(salg));
-	salg.salg_family = AF_ALG;
-	strcpy((char *) salg.salg_type, "hash");
-	strcpy((char *) salg.salg_name, "cmac(aes)");
-
-	if (bind(fd, (struct sockaddr *) &salg, sizeof(salg)) < 0) {
-		close(fd);
-		return -1;
-	}
-
-	nfd = alg_new(fd, key, 16, 0);
-
-	close(fd);
-
-	return nfd;
-}
-
-static bool aes_cmac(int fd, const uint8_t *msg,
+static bool aes_cmac(void *checksum, const uint8_t *msg,
 					size_t msg_len, uint8_t res[16])
 {
-	ssize_t len;
-
-	if (msg_len > CMAC_MSG_MAX)
-		return false;
-
-	len = send(fd, msg, msg_len, 0);
-	if (len < 0)
-		return false;
-
-	len = read(fd, res, 16);
-	if (len < 0)
+	if (!l_checksum_update(checksum, msg, msg_len))
 		return false;
 
-	return true;
-}
-
-static void aes_cmac_destroy(int fd)
-{
-	close(fd);
-}
-
-static int aes_cmac_N_start(const uint8_t N[16])
-{
-	int fd;
+	if (16 == l_checksum_get_digest(checksum, res, 16))
+		return true;
 
-	fd = aes_cmac_setup(N);
-	return fd;
+	return false;
 }
 
 static bool aes_cmac_one(const uint8_t key[16], const void *msg,
 					size_t msg_len, uint8_t res[16])
 {
+	void *checksum;
 	bool result;
-	int fd;
 
-	fd = aes_cmac_setup(key);
-	if (fd < 0)
+	checksum = l_checksum_new_cmac_aes(key, 16);
+	if (!checksum)
 		return false;
 
-	result = aes_cmac(fd, msg, msg_len, res);
+	result = l_checksum_update(checksum, msg, msg_len);
 
-	aes_cmac_destroy(fd);
+	if (result) {
+		ssize_t len = l_checksum_get_digest(checksum, res, 16);
+		result = !!(len == 16);
+	}
+
+	l_checksum_free(checksum);
 
 	return result;
 }
@@ -247,161 +106,22 @@ bool mesh_crypto_aes_ccm_encrypt(const uint8_t nonce[13], const uint8_t key[16],
 					uint8_t *out_msg,
 					void *out_mic, size_t mic_size)
 {
-	uint8_t pmsg[16], cmic[16], cmsg[16];
-	uint8_t mic[16], Xn[16];
-	uint16_t blk_cnt, last_blk;
+	void *cipher;
 	bool result;
-	size_t i, j;
-	int fd;
-
-	/* Mesh limits AAD length to 16 */
-	if (aad_len > 16)
-		return false;
-
-	fd = aes_ecb_setup(key);
-	if (fd < 0)
-		return false;
-
-	/* C_mic = e(AppKey, 0x01 || nonce || 0x0000) */
-	pmsg[0] = 0x01;
-	memcpy(pmsg + 1, nonce, 13);
-	l_put_be16(0x0000, pmsg + 14);
-
-	result = aes_ecb(fd, pmsg, cmic);
-	if (!result)
-		goto done;
-
-	/* X_0 = e(AppKey, 0x09 || nonce || length) */
-	if (mic_size == 8)
-		pmsg[0] = 0x19 | (aad_len ? 0x40 : 0x00);
-	else
-		pmsg[0] = 0x09 | (aad_len ? 0x40 : 0x00);
-
-	memcpy(pmsg + 1, nonce, 13);
-	l_put_be16(msg_len, pmsg + 14);
-
-	result = aes_ecb(fd, pmsg, Xn);
-	if (!result)
-		goto done;
-
-	/* If AAD is being used to authenticate, include it here */
-	if (aad_len) {
-		l_put_be16(aad_len, pmsg);
-
-		for (i = 0; i < sizeof(uint16_t); i++)
-			pmsg[i] = Xn[i] ^ pmsg[i];
 
-		j = 0;
-		aad_len += sizeof(uint16_t);
-		while (aad_len > 16) {
-			do {
-				pmsg[i] = Xn[i] ^ aad[j];
-				i++, j++;
-			} while (i < 16);
+	cipher = l_aead_cipher_new(L_AEAD_CIPHER_AES_CCM, key, 16, mic_size);
 
-			aad_len -= 16;
-			i = 0;
+	result = l_aead_cipher_encrypt(cipher, msg, msg_len, aad, aad_len,
+					nonce, 13, out_msg, msg_len + mic_size);
 
-			result = aes_ecb(fd, pmsg, Xn);
-			if (!result)
-				goto done;
-		}
-
-		for (i = 0; i < aad_len; i++, j++)
-			pmsg[i] = Xn[i] ^ aad[j];
-
-		for (i = aad_len; i < 16; i++)
-			pmsg[i] = Xn[i];
-
-		result = aes_ecb(fd, pmsg, Xn);
-		if (!result)
-			goto done;
-	}
-
-	last_blk = msg_len % 16;
-	blk_cnt = (msg_len + 15) / 16;
-	if (!last_blk)
-		last_blk = 16;
-
-	for (j = 0; j < blk_cnt; j++) {
-		if (j + 1 == blk_cnt) {
-			/* X_1 = e(AppKey, X_0 ^ Payload[0-15]) */
-			for (i = 0; i < last_blk; i++)
-				pmsg[i] = Xn[i] ^ msg[(j * 16) + i];
-			for (i = last_blk; i < 16; i++)
-				pmsg[i] = Xn[i] ^ 0x00;
-
-			result = aes_ecb(fd, pmsg, Xn);
-			if (!result)
-				goto done;
-
-			/* MIC = C_mic ^ X_1 */
-			for (i = 0; i < sizeof(mic); i++)
-				mic[i] = cmic[i] ^ Xn[i];
-
-			/* C_1 = e(AppKey, 0x01 || nonce || 0x0001) */
-			pmsg[0] = 0x01;
-			memcpy(pmsg + 1, nonce, 13);
-			l_put_be16(j + 1, pmsg + 14);
-
-			result = aes_ecb(fd, pmsg, cmsg);
-			if (!result)
-				goto done;
-
-			if (out_msg) {
-				/* Encrypted = Payload[0-15] ^ C_1 */
-				for (i = 0; i < last_blk; i++)
-					out_msg[(j * 16) + i] =
-						msg[(j * 16) + i] ^ cmsg[i];
-
-			}
-		} else {
-			/* X_1 = e(AppKey, X_0 ^ Payload[0-15]) */
-			for (i = 0; i < 16; i++)
-				pmsg[i] = Xn[i] ^ msg[(j * 16) + i];
-
-			result = aes_ecb(fd, pmsg, Xn);
-			if (!result)
-				goto done;
-
-			/* C_1 = e(AppKey, 0x01 || nonce || 0x0001) */
-			pmsg[0] = 0x01;
-			memcpy(pmsg + 1, nonce, 13);
-			l_put_be16(j + 1, pmsg + 14);
-
-			result = aes_ecb(fd, pmsg, cmsg);
-			if (!result)
-				goto done;
-
-			if (out_msg) {
-				/* Encrypted = Payload[0-15] ^ C_N */
-				for (i = 0; i < 16; i++)
-					out_msg[(j * 16) + i] =
-						msg[(j * 16) + i] ^ cmsg[i];
-			}
-
-		}
-	}
-
-	if (out_msg)
-		memcpy(out_msg + msg_len, mic, mic_size);
-
-	if (out_mic) {
-		switch (mic_size) {
-		case 4:
-			*(uint32_t *)out_mic = l_get_be32(mic);
-			break;
-		case 8:
-			*(uint64_t *)out_mic = l_get_be64(mic);
-			break;
-		default:
-			/* Unsupported MIC size */
-			result = false;
-		}
+	if (result && out_mic) {
+		if (mic_size == 4)
+			*(uint32_t *)out_mic = l_get_be32(out_msg + msg_len);
+		else
+			*(uint64_t *)out_mic = l_get_be64(out_msg + msg_len);
 	}
 
-done:
-	aes_ecb_destroy(fd);
+	l_aead_cipher_free(cipher);
 
 	return result;
 }
@@ -412,156 +132,26 @@ bool mesh_crypto_aes_ccm_decrypt(const uint8_t nonce[13], const uint8_t key[16],
 				uint8_t *out_msg,
 				void *out_mic, size_t mic_size)
 {
-	uint8_t msg[16], pmsg[16], cmic[16], cmsg[16], Xn[16];
-	uint8_t mic[16];
-	uint16_t msg_len = enc_msg_len - mic_size;
-	uint16_t last_blk, blk_cnt;
+	void *cipher;
 	bool result;
-	size_t i, j;
-	int fd;
-
-	if (enc_msg_len < 5 || aad_len > 16)
-		return false;
-
-	fd = aes_ecb_setup(key);
-	if (fd < 0)
-		return false;
-
-	/* C_mic = e(AppKey, 0x01 || nonce || 0x0000) */
-	pmsg[0] = 0x01;
-	memcpy(pmsg + 1, nonce, 13);
-	l_put_be16(0x0000, pmsg + 14);
-
-	result = aes_ecb(fd, pmsg, cmic);
-	if (!result)
-		goto done;
-
-	/* X_0 = e(AppKey, 0x09 || nonce || length) */
-	if (mic_size == 8)
-		pmsg[0] = 0x19 | (aad_len ? 0x40 : 0x00);
-	else
-		pmsg[0] = 0x09 | (aad_len ? 0x40 : 0x00);
+	size_t out_msg_len = enc_msg_len - mic_size;
 
-	memcpy(pmsg + 1, nonce, 13);
-	l_put_be16(msg_len, pmsg + 14);
-
-	result = aes_ecb(fd, pmsg, Xn);
-	if (!result)
-		goto done;
-
-	/* If AAD is being used to authenticate, include it here */
-	if (aad_len) {
-		l_put_be16(aad_len, pmsg);
-
-		for (i = 0; i < sizeof(uint16_t); i++)
-			pmsg[i] = Xn[i] ^ pmsg[i];
-
-		j = 0;
-		aad_len += sizeof(uint16_t);
-		while (aad_len > 16) {
-			do {
-				pmsg[i] = Xn[i] ^ aad[j];
-				i++, j++;
-			} while (i < 16);
-
-			aad_len -= 16;
-			i = 0;
-
-			result = aes_ecb(fd, pmsg, Xn);
-			if (!result)
-				goto done;
-		}
+	cipher = l_aead_cipher_new(L_AEAD_CIPHER_AES_CCM, key, 16, mic_size);
 
-		for (i = 0; i < aad_len; i++, j++)
-			pmsg[i] = Xn[i] ^ aad[j];
+	result = l_aead_cipher_decrypt(cipher, enc_msg, enc_msg_len,
+							aad, aad_len, nonce, 13,
+							out_msg, out_msg_len);
 
-		for (i = aad_len; i < 16; i++)
-			pmsg[i] = Xn[i];
-
-		result = aes_ecb(fd, pmsg, Xn);
-		if (!result)
-			goto done;
-	}
-
-	last_blk = msg_len % 16;
-	blk_cnt = (msg_len + 15) / 16;
-	if (!last_blk)
-		last_blk = 16;
-
-	for (j = 0; j < blk_cnt; j++) {
-		if (j + 1 == blk_cnt) {
-			/* C_1 = e(AppKey, 0x01 || nonce || 0x0001) */
-			pmsg[0] = 0x01;
-			memcpy(pmsg + 1, nonce, 13);
-			l_put_be16(j + 1, pmsg + 14);
-
-			result = aes_ecb(fd, pmsg, cmsg);
-			if (!result)
-				goto done;
-
-			/* Encrypted = Payload[0-15] ^ C_1 */
-			for (i = 0; i < last_blk; i++)
-				msg[i] = enc_msg[(j * 16) + i] ^ cmsg[i];
-
-			if (out_msg)
-				memcpy(out_msg + (j * 16), msg, last_blk);
-
-			/* X_1 = e(AppKey, X_0 ^ Payload[0-15]) */
-			for (i = 0; i < last_blk; i++)
-				pmsg[i] = Xn[i] ^ msg[i];
-			for (i = last_blk; i < 16; i++)
-				pmsg[i] = Xn[i] ^ 0x00;
-
-			result = aes_ecb(fd, pmsg, Xn);
-			if (!result)
-				goto done;
-
-			/* MIC = C_mic ^ X_1 */
-			for (i = 0; i < sizeof(mic); i++)
-				mic[i] = cmic[i] ^ Xn[i];
-		} else {
-			/* C_1 = e(AppKey, 0x01 || nonce || 0x0001) */
-			pmsg[0] = 0x01;
-			memcpy(pmsg + 1, nonce, 13);
-			l_put_be16(j + 1, pmsg + 14);
-
-			result = aes_ecb(fd, pmsg, cmsg);
-			if (!result)
-				goto done;
-
-			/* Encrypted = Payload[0-15] ^ C_1 */
-			for (i = 0; i < 16; i++)
-				msg[i] = enc_msg[(j * 16) + i] ^ cmsg[i];
-
-			if (out_msg)
-				memcpy(out_msg + (j * 16), msg, 16);
-
-			/* X_1 = e(AppKey, X_0 ^ Payload[0-15]) */
-			for (i = 0; i < 16; i++)
-				pmsg[i] = Xn[i] ^ msg[i];
-
-			result = aes_ecb(fd, pmsg, Xn);
-			if (!result)
-				goto done;
-		}
-	}
-
-	if (out_mic) {
-		switch (mic_size) {
-		case 4:
-			*(uint32_t *)out_mic = l_get_be32(mic);
-			break;
-		case 8:
-			*(uint64_t *)out_mic = l_get_be64(mic);
-			break;
-		default:
-			/* Unsupported MIC size */
-			result = false;
-		}
+	if (result && out_mic) {
+		if (mic_size == 4)
+			*(uint32_t *)out_mic =
+				l_get_be32(enc_msg + enc_msg_len - mic_size);
+		else
+			*(uint64_t *)out_mic =
+				l_get_be64(enc_msg + enc_msg_len - mic_size);
 	}
 
-done:
-	aes_ecb_destroy(fd);
+	l_aead_cipher_free(cipher);
 
 	return result;
 }
@@ -582,7 +172,7 @@ bool mesh_crypto_k2(const uint8_t n[16], const uint8_t *p, size_t p_len,
 							uint8_t enc_key[16],
 							uint8_t priv_key[16])
 {
-	int fd;
+	void *checksum;
 	uint8_t output[16];
 	uint8_t t[16];
 	uint8_t *stage;
@@ -598,14 +188,14 @@ bool mesh_crypto_k2(const uint8_t n[16], const uint8_t *p, size_t p_len,
 	if (!aes_cmac_one(stage, n, 16, t))
 		goto fail;
 
-	fd = aes_cmac_N_start(t);
-	if (fd < 0)
+	checksum = l_checksum_new_cmac_aes(t, 16);
+	if (!checksum)
 		goto fail;
 
 	memcpy(stage, p, p_len);
 	stage[p_len] = 1;
 
-	if (!aes_cmac(fd, stage, p_len + 1, output))
+	if (!aes_cmac(checksum, stage, p_len + 1, output))
 		goto done;
 
 	net_id[0] = output[15] & 0x7f;
@@ -614,7 +204,7 @@ bool mesh_crypto_k2(const uint8_t n[16], const uint8_t *p, size_t p_len,
 	memcpy(stage + 16, p, p_len);
 	stage[p_len + 16] = 2;
 
-	if (!aes_cmac(fd, stage, p_len + 16 + 1, output))
+	if (!aes_cmac(checksum, stage, p_len + 16 + 1, output))
 		goto done;
 
 	memcpy(enc_key, output, 16);
@@ -623,14 +213,14 @@ bool mesh_crypto_k2(const uint8_t n[16], const uint8_t *p, size_t p_len,
 	memcpy(stage + 16, p, p_len);
 	stage[p_len + 16] = 3;
 
-	if (!aes_cmac(fd, stage, p_len + 16 + 1, output))
+	if (!aes_cmac(checksum, stage, p_len + 16 + 1, output))
 		goto done;
 
 	memcpy(priv_key, output, 16);
 	success = true;
 
 done:
-	aes_cmac_destroy(fd);
+	l_checksum_free(checksum);
 fail:
 	l_free(stage);
 
-- 
2.14.5

