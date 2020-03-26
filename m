Return-Path: <SRS0=EGLw=5L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6AAC43331
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Mar 2020 21:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D30AC2073E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Mar 2020 21:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="SVWLet9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbgCZVRT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:17:19 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:33425 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbgCZVRT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Mar 2020 17:17:19 -0400
Received: by mail-lj1-f177.google.com with SMTP id f20so8069109ljm.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2020 14:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ioZlytInZqN0hVjpxJwNRHuvJVaI5oxa3DwFfFUa15g=;
        b=SVWLet9GrM2vELXqs1rjdBP+r4ohkSU6Xd0pT5kSzFmWDbQY07N8S4+IuNMl4yWQa8
         HCJADF9G8pgCKyzDlBp1rvyDNPTuktWsW/n41sJWQj3oG2gQVdfSLynDP5lG3i04PAzb
         C7H+/zdgDPzb3iGSfLGdoyAdHWsv61BtuO0i+ogRwXvtqbVUFhUs2IplA6ICm8pq/50D
         3/Er70LVTN57BwERBkQcSNTy21eUo8qtEmByga9w1M2c/01478N5F1i/u9c0DUO+PGTC
         3CKaJW/9OjNebBPsM4t2FMzwg2XTApeg/yvWz0iCfhUwwshqYp3xijvfG7rZck8D5ghD
         Wg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ioZlytInZqN0hVjpxJwNRHuvJVaI5oxa3DwFfFUa15g=;
        b=QpSGLiMGfEX5iRqzzRogLh5cBjJ+q3Vh7t4hAlFWjFXgPp9QsZIwDCANHXFIMxj35I
         r58jKcqMpUDWK5NxjgC5MW+egXzZQP+o8lF5pU7Aas576Ym8huIAUd06/LV/UaZd2AG+
         OB+VfD998n//CgEDzw3K8CgrKEqAy98+HuNDEx2zXBz/5W+QRPGEHZQbXT4Ox9Yy+sCA
         cXOCSaQfaL8YJWjNYATRyPStMJtSeNPeBdVFZSW8gXDxwh69D4nkLieo4UiDLIsiCobK
         8M/1m9Q5jlFnN/p2Iqho/Vddrw42mmYIw6G0iXiL33fbiVPl0F/spcy4EZ+xCT+E14J3
         7bTQ==
X-Gm-Message-State: ANhLgQ1AoEAxwCZdxuA3oOHM0/dW1JgmmLCtc2s9R3aGki2lDDAcGmAB
        kkS4Ddd8iEuqRiGl+JfHAMBV2b9gkDU=
X-Google-Smtp-Source: APiQypKiJ+3by8XiBTUVU5BI/mVE9d5V93KgkFN6AB0lo0UZhiMygHZq3e8LASaFClSQ9CBRnKgzIA==
X-Received: by 2002:a2e:800a:: with SMTP id j10mr6314056ljg.65.1585257432173;
        Thu, 26 Mar 2020 14:17:12 -0700 (PDT)
Received: from kynes.internet.domowy (apn-37-7-76-34.dynamic.gprs.plus.pl. [37.7.76.34])
        by smtp.gmail.com with ESMTPSA id i2sm2288037ljj.72.2020.03.26.14.17.10
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 14:17:11 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ RESEND] mesh: Remove redundant code from mesh/crypto
Date:   Thu, 26 Mar 2020 22:17:05 +0100
Message-Id: <20200326211705.18678-1-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

- Remove application_encrypt/application_decrypt
- Make mesh_crypto_privacy_counter private, add mesh_crypto_pecb
- Make *_nonce functions private and align their implementation to be
  more consistent
- Refactor network_encrypt/network_decrypt to use *_nonce functions and
  rename them to packet_encrypt/packet_decrypt
- Refactor packet_encode/packet_decode
---
 mesh/crypto.c           | 481 ++++++++++++++++------------------------
 mesh/crypto.h           |  50 +----
 mesh/net-keys.c         |   2 +-
 unit/test-mesh-crypto.c | 205 ++++++++---------
 4 files changed, 291 insertions(+), 447 deletions(-)

diff --git a/mesh/crypto.c b/mesh/crypto.c
index 596a289f9..ce335bbec 100644
--- a/mesh/crypto.c
+++ b/mesh/crypto.c
@@ -327,144 +327,59 @@ bool mesh_crypto_beacon_cmac(const uint8_t encryption_key[16],
 	return true;
 }
 
-bool mesh_crypto_network_nonce(bool ctl, uint8_t ttl, uint32_t seq,
-				uint16_t src, uint32_t iv_index,
-				uint8_t nonce[13])
+static void mesh_crypto_network_nonce(bool ctl, uint8_t ttl,
+					uint32_t seq, uint16_t src,
+					uint32_t iv_index, uint8_t nonce[13])
 {
-	nonce[0] = 0;
+	nonce[0] = 0x00;
 	nonce[1] = (ttl & TTL_MASK) | (ctl ? CTL : 0x00);
 	nonce[2] = (seq >> 16) & 0xff;
 	nonce[3] = (seq >> 8) & 0xff;
 	nonce[4] = seq & 0xff;
-
-	/* SRC */
 	l_put_be16(src, nonce + 5);
-
 	l_put_be16(0, nonce + 7);
-
-	/* IV Index */
 	l_put_be32(iv_index, nonce + 9);
-
-	return true;
-}
-
-bool mesh_crypto_network_encrypt(bool ctl, uint8_t ttl,
-				uint32_t seq, uint16_t src,
-				uint32_t iv_index,
-				const uint8_t net_key[16],
-				const uint8_t *enc_msg, uint8_t enc_msg_len,
-				uint8_t *out, void *net_mic)
-{
-	uint8_t nonce[13];
-
-	if (!mesh_crypto_network_nonce(ctl, ttl, seq, src, iv_index, nonce))
-		return false;
-
-	return mesh_crypto_aes_ccm_encrypt(nonce, net_key, NULL, 0, enc_msg,
-				enc_msg_len, out, net_mic,
-				ctl ? 8 : 4);
 }
 
-bool mesh_crypto_network_decrypt(bool ctl, uint8_t ttl,
-				uint32_t seq, uint16_t src,
-				uint32_t iv_index,
-				const uint8_t net_key[16],
-				const uint8_t *enc_msg, uint8_t enc_msg_len,
-				uint8_t *out, void *net_mic, size_t mic_size)
-{
-	uint8_t nonce[13];
-
-	if (!mesh_crypto_network_nonce(ctl, ttl, seq, src, iv_index, nonce))
-		return false;
-
-	return mesh_crypto_aes_ccm_decrypt(nonce, net_key, NULL, 0,
-						enc_msg, enc_msg_len, out,
-						net_mic, mic_size);
-}
-
-bool mesh_crypto_application_nonce(uint32_t seq, uint16_t src,
+static void mesh_crypto_application_nonce(uint32_t seq, uint16_t src,
 					uint16_t dst, uint32_t iv_index,
 					bool aszmic, uint8_t nonce[13])
 {
 	nonce[0] = 0x01;
 	nonce[1] = aszmic ? 0x80 : 0x00;
-	nonce[2] = (seq & 0x00ff0000) >> 16;
-	nonce[3] = (seq & 0x0000ff00) >> 8;
-	nonce[4] = (seq & 0x000000ff);
-	nonce[5] = (src & 0xff00) >> 8;
-	nonce[6] = (src & 0x00ff);
-	nonce[7] = (dst & 0xff00) >> 8;
-	nonce[8] = (dst & 0x00ff);
+	nonce[2] = (seq >> 16 ) & 0xff;
+	nonce[3] = (seq >> 8) & 0xff;
+	nonce[4] = seq & 0xff;
+	l_put_be16(src, nonce + 5);
+	l_put_be16(dst, nonce + 7);
 	l_put_be32(iv_index, nonce + 9);
-
-	return true;
 }
 
-bool mesh_crypto_device_nonce(uint32_t seq, uint16_t src,
+static void mesh_crypto_device_nonce(uint32_t seq, uint16_t src,
 					uint16_t dst, uint32_t iv_index,
 					bool aszmic, uint8_t nonce[13])
 {
 	nonce[0] = 0x02;
 	nonce[1] = aszmic ? 0x80 : 0x00;
-	nonce[2] = (seq & 0x00ff0000) >> 16;
-	nonce[3] = (seq & 0x0000ff00) >> 8;
-	nonce[4] = (seq & 0x000000ff);
-	nonce[5] = (src & 0xff00) >> 8;
-	nonce[6] = (src & 0x00ff);
-	nonce[7] = (dst & 0xff00) >> 8;
-	nonce[8] = (dst & 0x00ff);
+	nonce[2] = (seq >> 16 ) & 0xff;
+	nonce[3] = (seq >> 8) & 0xff;
+	nonce[4] = seq & 0xff;
+	l_put_be16(src, nonce + 5);
+	l_put_be16(dst, nonce + 7);
 	l_put_be32(iv_index, nonce + 9);
-
-	return true;
 }
 
-bool mesh_crypto_application_encrypt(uint8_t key_aid, uint32_t seq,
-					uint16_t src, uint16_t dst,
-					uint32_t iv_index,
-					const uint8_t app_key[16],
-					const uint8_t *aad, uint8_t aad_len,
-					const uint8_t *msg, uint8_t msg_len,
-					uint8_t *out,
-					void *app_mic, size_t mic_size)
+static void mesh_crypto_proxy_nonce(uint32_t seq, uint16_t src,
+					uint32_t iv_index, uint8_t nonce[13])
 {
-	uint8_t nonce[13];
-	bool aszmic = (mic_size == 8) ? true : false;
-
-	if (!key_aid && !mesh_crypto_device_nonce(seq, src, dst,
-						iv_index, aszmic, nonce))
-		return false;
-
-	if (key_aid && !mesh_crypto_application_nonce(seq, src, dst,
-						iv_index, aszmic, nonce))
-		return false;
-
-	return mesh_crypto_aes_ccm_encrypt(nonce, app_key, aad, aad_len,
-						msg, msg_len,
-						out, app_mic, mic_size);
-}
-
-bool mesh_crypto_application_decrypt(uint8_t key_aid, uint32_t seq,
-				uint16_t src, uint16_t dst, uint32_t iv_index,
-				const uint8_t app_key[16],
-				const uint8_t *aad, uint8_t aad_len,
-				const uint8_t *enc_msg, uint8_t enc_msg_len,
-				uint8_t *out, void *app_mic, size_t mic_size)
-{
-	uint8_t nonce[13];
-	bool aszmic = (mic_size == 8) ? true : false;
-
-	if (!key_aid && !mesh_crypto_device_nonce(seq, src, dst,
-						iv_index, aszmic, nonce))
-		return false;
-
-	if (key_aid && !mesh_crypto_application_nonce(seq, src, dst,
-						iv_index, aszmic, nonce))
-		return false;
-
-	return mesh_crypto_aes_ccm_decrypt(nonce, app_key,
-						aad, aad_len, enc_msg,
-						enc_msg_len, out,
-						app_mic, mic_size);
+	nonce[0] = 0x03;
+	nonce[1] = 0;
+	nonce[2] = (seq >> 16) & 0xff;
+	nonce[3] = (seq >> 8) & 0xff;
+	nonce[4] = seq & 0xff;
+	l_put_be16(src, nonce + 5);
+	l_put_be16(0, nonce + 7);
+	l_put_be32(iv_index, nonce + 9);
 }
 
 bool mesh_crypto_session_key(const uint8_t secret[32],
@@ -557,69 +472,67 @@ bool mesh_crypto_virtual_addr(const uint8_t virtual_label[16],
 	return true;
 }
 
-bool mesh_crypto_privacy_counter(uint32_t iv_index,
+static void mesh_crypto_privacy_counter(uint32_t iv_index,
 						const uint8_t *payload,
 						uint8_t privacy_counter[16])
 {
 	memset(privacy_counter, 0, 5);
 	l_put_be32(iv_index, privacy_counter + 5);
 	memcpy(privacy_counter + 9, payload, 7);
+}
 
-	return true;
+static bool mesh_crypto_pecb(const uint8_t privacy_key[16],
+						uint32_t iv_index,
+						const uint8_t *payload,
+						uint8_t pecb[16])
+{
+	mesh_crypto_privacy_counter(iv_index, payload, pecb);
+	return aes_ecb_one(privacy_key, pecb, pecb);
 }
 
-bool mesh_crypto_network_obfuscate(const uint8_t privacy_key[16],
-					const uint8_t privacy_counter[16],
-					bool ctl, uint8_t ttl, uint32_t seq,
-					uint16_t src, uint8_t *out)
+static bool mesh_crypto_network_obfuscate(uint8_t *packet,
+						const uint8_t privacy_key[16],
+						uint32_t iv_index,
+						bool ctl, uint8_t ttl,
+						uint32_t seq, uint16_t src)
 {
-	uint8_t ecb[16], tmp[16];
+	uint8_t pecb[16];
+	uint8_t *net_hdr = packet + 1;
 	int i;
 
-	if (!aes_ecb_one(privacy_key, privacy_counter, ecb))
+	if (!mesh_crypto_pecb(privacy_key, iv_index, packet + 7, pecb))
 		return false;
 
-	tmp[0] = ((!!ctl) << 7) | (ttl & TTL_MASK);
-	tmp[1] = (seq & 0xff0000) >> 16;
-	tmp[2] = (seq & 0x00ff00) >> 8;
-	tmp[3] = (seq & 0x0000ff);
-	tmp[4] = (src & 0xff00) >> 8;
-	tmp[5] = (src & 0x00ff);
+	l_put_be16(src, net_hdr + 4);
+	l_put_be32(seq & SEQ_MASK, net_hdr);
+	net_hdr[0] = ((!!ctl) << 7) | (ttl & TTL_MASK);
 
-	if (out) {
-		for (i = 0; i < 6; i++)
-			out[i] = ecb[i] ^ tmp[i];
-	}
+	for (i = 0; i < 6; i++)
+		net_hdr[i] = pecb[i] ^ net_hdr[i];
 
 	return true;
 }
 
-bool mesh_crypto_network_clarify(const uint8_t privacy_key[16],
-				const uint8_t privacy_counter[16],
-				const uint8_t net_hdr[6],
-				bool *ctl, uint8_t *ttl,
-				uint32_t *seq, uint16_t *src)
+static bool mesh_crypto_network_clarify(uint8_t *packet,
+						const uint8_t privacy_key[16],
+						uint32_t iv_index,
+						bool *ctl, uint8_t *ttl,
+						uint32_t *seq, uint16_t *src)
 {
-	uint8_t ecb[16], tmp[6];
+	uint8_t pecb[16];
+	uint8_t *net_hdr = packet + 1;
 	int i;
 
-	if (!aes_ecb_one(privacy_key, privacy_counter, ecb))
+	if (!mesh_crypto_pecb(privacy_key, iv_index, packet + 7, pecb))
 		return false;
 
 	for (i = 0; i < 6; i++)
-		tmp[i] = ecb[i] ^ net_hdr[i];
-
-	if (ctl)
-		*ctl = !!(tmp[0] & CTL);
+		net_hdr[i] = pecb[i] ^ net_hdr[i];
 
-	if (ttl)
-		*ttl = tmp[0] & TTL_MASK;
-
-	if (seq)
-		*seq = l_get_be32(tmp) & SEQ_MASK;
-
-	if (src)
-		*src = l_get_be16(tmp + 4);
+	*src = l_get_be16(net_hdr + 4);
+	*seq = l_get_be32(net_hdr) & SEQ_MASK;
+	*ttl = net_hdr[0] & TTL_MASK;
+	*ctl = !!(net_hdr[0] & CTL);
 
 	return true;
 }
@@ -689,24 +602,13 @@ bool mesh_crypto_packet_build(bool ctl, uint8_t ttl,
 	return true;
 }
 
-bool mesh_crypto_packet_parse(const uint8_t *packet, uint8_t packet_len,
+static bool network_header_parse(const uint8_t *packet, uint8_t packet_len,
 				bool *ctl, uint8_t *ttl, uint32_t *seq,
-				uint16_t *src, uint16_t *dst,
-				uint32_t *cookie, uint8_t *opcode,
-				bool *segmented, uint8_t *key_aid,
-				bool *szmic, bool *relay, uint16_t *seqZero,
-				uint8_t *segO, uint8_t *segN,
-				const uint8_t **payload, uint8_t *payload_len)
+				uint16_t *src, uint16_t *dst)
 {
-	uint32_t hdr;
-	uint16_t this_dst;
-	bool is_segmented;
-
 	if (packet_len < 10)
 		return false;
 
-	this_dst = l_get_be16(packet + 7);
-
 	/* Try to keep bits in the order they exist within the packet */
 	if (ctl)
 		*ctl = !!(packet[1] & CTL);
@@ -720,6 +622,30 @@ bool mesh_crypto_packet_parse(const uint8_t *packet, uint8_t packet_len,
 	if (src)
 		*src = l_get_be16(packet + 5);
 
+	if (dst)
+		*dst = l_get_be16(packet + 7);
+
+	return true;
+
+}
+
+bool mesh_crypto_packet_parse(const uint8_t *packet, uint8_t packet_len,
+				bool *ctl, uint8_t *ttl, uint32_t *seq,
+				uint16_t *src, uint16_t *dst,
+				uint32_t *cookie, uint8_t *opcode,
+				bool *segmented, uint8_t *key_aid,
+				bool *szmic, bool *relay, uint16_t *seqZero,
+				uint8_t *segO, uint8_t *segN,
+				const uint8_t **payload, uint8_t *payload_len)
+{
+	uint32_t hdr;
+	uint16_t this_dst;
+	bool is_segmented;
+
+	if (!network_header_parse(packet, packet_len,
+					ctl, ttl, seq, src, &this_dst))
+		return false;
+
 	if (dst)
 		*dst = this_dst;
 
@@ -799,38 +725,27 @@ bool mesh_crypto_packet_parse(const uint8_t *packet, uint8_t packet_len,
 bool mesh_crypto_payload_encrypt(uint8_t *aad, const uint8_t *payload,
 				uint8_t *out, uint16_t payload_len,
 				uint16_t src, uint16_t dst, uint8_t key_aid,
-				uint32_t seq_num, uint32_t iv_index,
+				uint32_t seq, uint32_t iv_index,
 				bool aszmic,
-				const uint8_t application_key[16])
+				const uint8_t app_key[16])
 {
-	uint8_t application_nonce[13] = { 0x01, };
+	uint8_t nonce[13];
 
 	if (payload_len < 1)
 		return false;
 
 	if (key_aid == APP_AID_DEV)
-		application_nonce[0] = 0x02;
-
-	/* Seq Num */
-	l_put_be32(seq_num, application_nonce + 1);
-
-	/* ASZMIC */
-	application_nonce[1] |= aszmic ? 0x80 : 0x00;
-
-	/* SRC */
-	l_put_be16(src, application_nonce + 5);
-
-	/* DST */
-	l_put_be16(dst, application_nonce + 7);
-
-	/* IV Index */
-	l_put_be32(iv_index, application_nonce + 9);
-
-	if (!mesh_crypto_aes_ccm_encrypt(application_nonce, application_key,
-					aad, aad ? 16 : 0,
-					payload, payload_len,
-					out, NULL,
-					aszmic ? 8 : 4))
+		mesh_crypto_device_nonce(seq, src, dst, iv_index, aszmic,
+									nonce);
+	else
+		mesh_crypto_application_nonce(seq, src, dst, iv_index, aszmic,
+									nonce);
+
+	if (!mesh_crypto_aes_ccm_encrypt(nonce, app_key,
+							aad, aad ? 16 : 0,
+							payload, payload_len,
+							out, NULL,
+							aszmic ? 8 : 4))
 		return false;
 
 	return true;
@@ -838,13 +753,13 @@ bool mesh_crypto_payload_encrypt(uint8_t *aad, const uint8_t *payload,
 
 bool mesh_crypto_payload_decrypt(uint8_t *aad, uint16_t aad_len,
 				const uint8_t *payload, uint16_t payload_len,
-				bool szmict,
+				bool aszmic,
 				uint16_t src, uint16_t dst,
-				uint8_t key_aid, uint32_t seq_num,
+				uint8_t key_aid, uint32_t seq,
 				uint32_t iv_index, uint8_t *out,
 				const uint8_t app_key[16])
 {
-	uint8_t app_nonce[13] = { 0x01, };
+	uint8_t nonce[13];
 	uint32_t mic32;
 	uint64_t mic64;
 
@@ -852,27 +767,16 @@ bool mesh_crypto_payload_decrypt(uint8_t *aad, uint16_t aad_len,
 		return false;
 
 	if (key_aid == APP_AID_DEV)
-		app_nonce[0] = 0x02;
-
-	/* Seq Num */
-	l_put_be32(seq_num, app_nonce + 1);
-
-	/* ASZMIC */
-	app_nonce[1] |= szmict ? 0x80 : 0x00;
-
-	/* SRC */
-	l_put_be16(src, app_nonce + 5);
-
-	/* DST */
-	l_put_be16(dst, app_nonce + 7);
-
-	/* IV Index */
-	l_put_be32(iv_index, app_nonce + 9);
+		mesh_crypto_device_nonce(seq, src, dst, iv_index, aszmic,
+									nonce);
+	else
+		mesh_crypto_application_nonce(seq, src, dst, iv_index, aszmic,
+									nonce);
 
 	memcpy(out, payload, payload_len);
 
-	if (szmict) {
-		if (!mesh_crypto_aes_ccm_decrypt(app_nonce, app_key,
+	if (aszmic) {
+		if (!mesh_crypto_aes_ccm_decrypt(nonce, app_key,
 					aad, aad_len,
 					payload, payload_len,
 					out, &mic64, sizeof(mic64)))
@@ -884,7 +788,7 @@ bool mesh_crypto_payload_decrypt(uint8_t *aad, uint16_t aad_len,
 		if (mic64)
 			return false;
 	} else {
-		if (!mesh_crypto_aes_ccm_decrypt(app_nonce, app_key,
+		if (!mesh_crypto_aes_ccm_decrypt(nonce, app_key,
 					aad, aad_len,
 					payload, payload_len,
 					out, &mic32, sizeof(mic32)))
@@ -900,146 +804,107 @@ bool mesh_crypto_payload_decrypt(uint8_t *aad, uint16_t aad_len,
 	return true;
 }
 
-bool mesh_crypto_packet_encode(uint8_t *packet, uint8_t packet_len,
+static bool mesh_crypto_packet_encrypt(uint8_t *packet, uint8_t packet_len,
 				const uint8_t network_key[16],
-				uint32_t iv_index,
-				const uint8_t privacy_key[16])
+				uint32_t iv_index, bool proxy,
+				bool ctl, uint8_t ttl, uint32_t seq,
+				uint16_t src)
 {
-	uint8_t network_nonce[13] = { 0x00, 0x00 };
-	uint8_t privacy_counter[16] = { 0x00, 0x00, 0x00, 0x00, 0x00, };
-	uint8_t tmp[16];
-	int i;
-
-	if (packet_len < 14)
-		return false;
+	uint8_t nonce[13];
 
 	/* Detect Proxy packet by CTL == true && DST == 0x0000 */
-	if ((packet[1] & CTL) && l_get_be16(packet + 7) == 0)
-		network_nonce[0] = 0x03; /* Proxy Nonce */
+	if (ctl && proxy)
+		mesh_crypto_proxy_nonce(seq, src, iv_index, nonce);
 	else
-		/* CTL + TTL */
-		network_nonce[1] = packet[1];
-
-	/* Seq Num */
-	network_nonce[2] = packet[2];
-	network_nonce[3] = packet[3];
-	network_nonce[4] = packet[4];
-
-	/* SRC */
-	network_nonce[5] = packet[5];
-	network_nonce[6] = packet[6];
-
-	/* DST not available */
-	network_nonce[7] = 0;
-	network_nonce[8] = 0;
-
-	/* IV Index */
-	l_put_be32(iv_index, network_nonce + 9);
+		mesh_crypto_network_nonce(ctl, ttl, seq, src, iv_index, nonce);
 
 	/* Check for Long net-MIC */
-	if (packet[1] & CTL) {
-		if (!mesh_crypto_aes_ccm_encrypt(network_nonce, network_key,
+	if (ctl) {
+		if (!mesh_crypto_aes_ccm_encrypt(nonce, network_key,
 					NULL, 0,
 					packet + 7, packet_len - 7 - 8,
 					packet + 7, NULL, 8))
 			return false;
 	} else {
-		if (!mesh_crypto_aes_ccm_encrypt(network_nonce, network_key,
+		if (!mesh_crypto_aes_ccm_encrypt(nonce, network_key,
 					NULL, 0,
 					packet + 7, packet_len - 7 - 4,
 					packet + 7, NULL, 4))
 			return false;
 	}
 
-	l_put_be32(iv_index, privacy_counter + 5);
-	memcpy(privacy_counter + 9, packet + 7, 7);
-
-	if (!aes_ecb_one(privacy_key, privacy_counter, tmp))
-		return false;
-
-	for (i = 0; i < 6; i++)
-		packet[1 + i] ^= tmp[i];
-
 	return true;
 }
 
-bool mesh_crypto_packet_decode(const uint8_t *packet, uint8_t packet_len,
-				bool proxy, uint8_t *out, uint32_t iv_index,
+bool mesh_crypto_packet_encode(uint8_t *packet, uint8_t packet_len,
+				uint32_t iv_index,
 				const uint8_t network_key[16],
 				const uint8_t privacy_key[16])
 {
-	uint8_t privacy_counter[16] = { 0x00, 0x00, 0x00, 0x00, 0x00, };
-	uint8_t network_nonce[13] = { 0x00, 0x00, };
-	uint8_t tmp[16];
+	bool ctl;
+	uint8_t ttl;
+	uint32_t seq;
 	uint16_t src;
-	int i;
+	uint16_t dst;
 
-	if (packet_len < 14)
+	if (!network_header_parse(packet, packet_len,
+						&ctl, &ttl, &seq, &src, &dst))
 		return false;
 
-	l_put_be32(iv_index, privacy_counter + 5);
-	memcpy(privacy_counter + 9, packet + 7, 7);
+	if (!mesh_crypto_packet_encrypt(packet, packet_len, network_key,
+							iv_index, !dst,
+							ctl, ttl, seq, src))
 
-	if (!aes_ecb_one(privacy_key, privacy_counter, tmp))
 		return false;
 
-	memcpy(out, packet, packet_len);
-	for (i = 0; i < 6; i++)
-		out[1 + i] ^= tmp[i];
+	return mesh_crypto_network_obfuscate(packet, privacy_key, iv_index,
+							ctl, ttl, seq, src);
+}
 
-	src = l_get_be16(out + 5);
+static bool mesh_crypto_packet_decrypt(uint8_t *packet, uint8_t packet_len,
+				const uint8_t network_key[16],
+				uint32_t iv_index, bool proxy,
+				bool ctl, uint8_t ttl, uint32_t seq,
+				uint16_t src)
+{
+	uint8_t nonce[13];
 
 	/* Pre-check SRC address for illegal values */
-	if (!src || src >= 0x8000)
+	if (!IS_UNICAST(src))
 		return false;
 
 	/* Detect Proxy packet by CTL == true && proxy == true */
-	if ((out[1] & CTL) && proxy)
-		network_nonce[0] = 0x03; /* Proxy Nonce */
+	if (ctl & proxy)
+		mesh_crypto_proxy_nonce(seq, src, iv_index, nonce);
 	else
-		/* CTL + TTL */
-		network_nonce[1] = out[1];
-
-	/* Seq Num */
-	network_nonce[2] = out[2];
-	network_nonce[3] = out[3];
-	network_nonce[4] = out[4];
-
-	/* SRC */
-	network_nonce[5] = out[5];
-	network_nonce[6] = out[6];
-
-	/* DST not available */
-	network_nonce[7] = 0;
-	network_nonce[8] = 0;
-
-	/* IV Index */
-	l_put_be32(iv_index, network_nonce + 9);
+		mesh_crypto_network_nonce(ctl, ttl, seq, src, iv_index, nonce);
 
 	/* Check for Long MIC */
-	if (out[1] & CTL) {
+	if (ctl) {
 		uint64_t mic;
 
-		if (!mesh_crypto_aes_ccm_decrypt(network_nonce, network_key,
-					NULL, 0, packet + 7, packet_len - 7,
-					out + 7, &mic, sizeof(mic)))
+		if (!mesh_crypto_aes_ccm_decrypt(nonce, network_key,
+					NULL, 0,
+					packet + 7, packet_len - 7,
+					packet + 7, &mic, sizeof(mic)))
 			return false;
 
-		mic ^= l_get_be64(out + packet_len - 8);
-		l_put_be64(mic, out + packet_len - 8);
+		mic ^= l_get_be64(packet + packet_len - 8);
+		l_put_be64(mic, packet + packet_len - 8);
 
 		if (mic)
 			return false;
 	} else {
 		uint32_t mic;
 
-		if (!mesh_crypto_aes_ccm_decrypt(network_nonce, network_key,
-					NULL, 0, packet + 7, packet_len - 7,
-					out + 7, &mic, sizeof(mic)))
+		if (!mesh_crypto_aes_ccm_decrypt(nonce, network_key,
+					NULL, 0,
+					packet + 7, packet_len - 7,
+					packet + 7, &mic, sizeof(mic)))
 			return false;
 
-		mic ^= l_get_be32(out + packet_len - 4);
-		l_put_be32(mic, out + packet_len - 4);
+		mic ^= l_get_be32(packet + packet_len - 4);
+		l_put_be32(mic, packet + packet_len - 4);
 
 		if (mic)
 			return false;
@@ -1048,6 +913,30 @@ bool mesh_crypto_packet_decode(const uint8_t *packet, uint8_t packet_len,
 	return true;
 }
 
+bool mesh_crypto_packet_decode(const uint8_t *packet, uint8_t packet_len,
+				bool proxy, uint8_t *out, uint32_t iv_index,
+				const uint8_t network_key[16],
+				const uint8_t privacy_key[16])
+{
+	bool ctl;
+	uint8_t ttl;
+	uint32_t seq;
+	uint16_t src;
+
+	if (packet_len < 14)
+		return false;
+
+	memcpy(out, packet, packet_len);
+
+	if (!mesh_crypto_network_clarify(out, privacy_key, iv_index,
+						&ctl, &ttl, &seq, &src))
+		return false;
+
+	return mesh_crypto_packet_decrypt(out, packet_len, network_key,
+							iv_index, proxy,
+							ctl, ttl, seq, src);
+}
+
 bool mesh_crypto_packet_label(uint8_t *packet, uint8_t packet_len,
 				uint16_t iv_index, uint8_t network_id)
 {
diff --git a/mesh/crypto.h b/mesh/crypto.h
index e5ce840b4..7d3f89cde 100644
--- a/mesh/crypto.h
+++ b/mesh/crypto.h
@@ -19,6 +19,7 @@
 
 #include <stdbool.h>
 #include <stdint.h>
+#include <stdlib.h>
 
 bool mesh_crypto_aes_ccm_encrypt(const uint8_t nonce[13], const uint8_t key[16],
 					const uint8_t *aad, uint16_t aad_len,
@@ -41,40 +42,6 @@ bool mesh_crypto_beacon_cmac(const uint8_t encryption_key[16],
 				const uint8_t network_id[16],
 				uint32_t iv_index, bool kr,
 				bool iu, uint64_t *cmac);
-bool mesh_crypto_network_nonce(bool frnd, uint8_t ttl, uint32_t seq,
-				uint16_t src, uint32_t iv_index,
-				uint8_t nonce[13]);
-bool mesh_crypto_network_encrypt(bool ctl, uint8_t ttl,
-				uint32_t seq, uint16_t src,
-				uint32_t iv_index,
-				const uint8_t net_key[16],
-				const uint8_t *enc_msg, uint8_t enc_msg_len,
-				uint8_t *out, void *net_mic);
-bool mesh_crypto_network_decrypt(bool frnd, uint8_t ttl,
-				uint32_t seq, uint16_t src,
-				uint32_t iv_index,
-				const uint8_t net_key[16],
-				const uint8_t *enc_msg, uint8_t enc_msg_len,
-				uint8_t *out, void *net_mic, size_t mic_size);
-bool mesh_crypto_application_nonce(uint32_t seq, uint16_t src,
-				uint16_t dst, uint32_t iv_index,
-				bool aszmic, uint8_t nonce[13]);
-bool mesh_crypto_device_nonce(uint32_t seq, uint16_t src,
-				uint16_t dst, uint32_t iv_index,
-				bool aszmic, uint8_t nonce[13]);
-bool mesh_crypto_application_encrypt(uint8_t akf, uint32_t seq, uint16_t src,
-					uint16_t dst, uint32_t iv_index,
-					const uint8_t app_key[16],
-					const uint8_t *aad, uint8_t aad_len,
-					const uint8_t *msg, uint8_t msg_len,
-					uint8_t *out,
-					void *app_mic, size_t mic_size);
-bool mesh_crypto_application_decrypt(uint8_t akf, uint32_t seq, uint16_t src,
-				uint16_t dst, uint32_t iv_index,
-				const uint8_t app_key[16],
-				const uint8_t *aad, uint8_t aad_len,
-				const uint8_t *enc_msg, uint8_t enc_msg_len,
-				uint8_t *out, void *app_mic, size_t mic_size);
 bool mesh_crypto_device_key(const uint8_t secret[32],
 						const uint8_t salt[16],
 						uint8_t device_key[16]);
@@ -102,19 +69,6 @@ bool mesh_crypto_prov_conf_key(const uint8_t secret[32],
 bool mesh_crypto_session_key(const uint8_t secret[32],
 					const uint8_t salt[16],
 					uint8_t session_key[16]);
-bool mesh_crypto_privacy_counter(uint32_t iv_index,
-						const uint8_t *payload,
-						uint8_t privacy_counter[16]);
-bool mesh_crypto_network_obfuscate(const uint8_t privacy_key[16],
-					const uint8_t privacy_counter[16],
-					bool ctl, uint8_t ttl, uint32_t seq,
-					uint16_t src, uint8_t *out);
-bool mesh_crypto_network_clarify(const uint8_t privacy_key[16],
-				const uint8_t privacy_counter[16],
-				const uint8_t net_hdr[6],
-				bool *ctl, uint8_t *ttl,
-				uint32_t *seq, uint16_t *src);
-
 bool mesh_crypto_packet_build(bool ctl, uint8_t ttl,
 				uint32_t seq,
 				uint16_t src, uint16_t dst,
@@ -146,8 +100,8 @@ bool mesh_crypto_payload_decrypt(uint8_t *aad, uint16_t aad_len,
 				uint8_t *out,
 				const uint8_t application_key[16]);
 bool mesh_crypto_packet_encode(uint8_t *packet, uint8_t packet_len,
-				const uint8_t network_key[16],
 				uint32_t iv_index,
+				const uint8_t network_key[16],
 				const uint8_t privacy_key[16]);
 bool mesh_crypto_packet_decode(const uint8_t *packet, uint8_t packet_len,
 				bool proxy, uint8_t *out, uint32_t iv_index,
diff --git a/mesh/net-keys.c b/mesh/net-keys.c
index 683a924c4..f7eb2ca68 100644
--- a/mesh/net-keys.c
+++ b/mesh/net-keys.c
@@ -263,7 +263,7 @@ bool net_key_encrypt(uint32_t id, uint32_t iv_index, uint8_t *pkt, size_t len)
 	if (!key)
 		return false;
 
-	result = mesh_crypto_packet_encode(pkt, len, key->encrypt, iv_index,
+	result = mesh_crypto_packet_encode(pkt, len, iv_index, key->encrypt,
 							key->privacy);
 
 	if (!result)
diff --git a/unit/test-mesh-crypto.c b/unit/test-mesh-crypto.c
index 0043b0b10..3ecb3d026 100644
--- a/unit/test-mesh-crypto.c
+++ b/unit/test-mesh-crypto.c
@@ -780,8 +780,8 @@ static void check_encrypt_segment(const struct mesh_crypto_test *keys,
 	uint8_t priv_rand[16];
 	uint8_t packet[29];
 	uint8_t packet_len;
-	uint64_t net_mic64;
-	uint32_t hdr, net_mic32;
+	uint32_t hdr;
+	uint64_t net_mic64, net_mic32;
 	size_t net_msg_len;
 	uint8_t key_aid = keys->key_aid | (keys->akf ? KEY_ID_AKF : 0x00);
 
@@ -857,13 +857,12 @@ static void check_encrypt_segment(const struct mesh_crypto_test *keys,
 	net_msg_len = len + 2;
 	show_data("TransportPayload", 7, packet + 7, net_msg_len);
 
-	mesh_crypto_network_encrypt(keys->ctl,
-			keys->net_ttl, keys->net_seq[0],
-			keys->net_src,
-			keys->iv_index, enc_key,
-			packet + 7, len + 2, packet + 7,
-			keys->ctl ? (void *)&net_mic64 :
-			(void *)&net_mic32);
+	mesh_crypto_packet_encrypt(packet, packet_len,
+						enc_key,
+						keys->iv_index, false,
+						keys->ctl, keys->net_ttl,
+						keys->net_seq[0],
+						keys->net_src);
 
 	mesh_crypto_privacy_counter(keys->iv_index, packet + 7, priv_rand);
 
@@ -883,20 +882,22 @@ static void check_encrypt_segment(const struct mesh_crypto_test *keys,
 	verify_data("EncNetworkPayload", 7, keys->net_msg[0],
 			packet + 7, net_msg_len);
 	if (keys->ctl) {
+		net_mic64 = l_get_be64(packet + 7 + net_msg_len);
 		verify_uint64("NetworkMIC", 7 + net_msg_len,
-				keys->net_mic64, net_mic64);
+						keys->net_mic64, net_mic64);
 		net_msg_len += 8;
 	} else {
+		net_mic32 = l_get_be32(packet + 7 + net_msg_len);
 		verify_uint32("NetworkMIC", 7 + net_msg_len,
-				keys->net_mic32[0], net_mic32);
+						keys->net_mic32[0], net_mic32);
 		net_msg_len += 4;
 	}
 
 	show_data("PreObsPayload", 1, packet + 1, 6 + net_msg_len);
-	mesh_crypto_network_obfuscate(priv_key, priv_rand,
-			keys->ctl,
-			keys->net_ttl, keys->net_seq[0],
-			keys->net_src, packet + 1);
+	mesh_crypto_network_obfuscate(packet, priv_key,
+					keys->iv_index,
+					keys->ctl, keys->net_ttl,
+					keys->net_seq[0], keys->net_src);
 	show_data("PostObsPayload", 1, packet + 1, 6 + net_msg_len);
 
 	packet[0] = (keys->iv_index & 0x01) << 7 | nid;
@@ -1019,25 +1020,23 @@ static void check_encrypt(const struct mesh_crypto_test *keys)
 		if (keys->szmic) {
 			seg_max = SEG_MAX(keys->segmented, app_msg_len + 8);
 			enc_msg = l_malloc(app_msg_len + 8);
-			mesh_crypto_application_encrypt(key_aid, keys->app_seq,
-					keys->net_src, keys->net_dst,
-					keys->iv_index,
-					keys->akf ? app_key : dev_key,
-					aad, aad_len,
-					app_msg, app_msg_len,
-					enc_msg, &app_mic64, sizeof(app_mic64));
-			l_put_be64(app_mic64, enc_msg + app_msg_len);
+
+			mesh_crypto_payload_encrypt(aad, app_msg,
+					enc_msg, app_msg_len,
+					keys->net_src, keys->net_dst, key_aid,
+					keys->app_seq, keys->iv_index,
+					keys->szmic,
+					keys->akf ? app_key : dev_key);
 		} else {
 			seg_max = SEG_MAX(keys->segmented, app_msg_len + 4);
 			enc_msg = l_malloc(app_msg_len + 4);
-			mesh_crypto_application_encrypt(key_aid, keys->app_seq,
-					keys->net_src, keys->net_dst,
-					keys->iv_index,
-					keys->akf ? app_key : dev_key,
-					aad, aad_len,
-					app_msg, app_msg_len,
-					enc_msg, &app_mic32, sizeof(app_mic32));
-			l_put_be32(app_mic32, enc_msg + app_msg_len);
+
+			mesh_crypto_payload_encrypt(aad, app_msg,
+					enc_msg, app_msg_len,
+					keys->net_src, keys->net_dst, key_aid,
+					keys->app_seq, keys->iv_index,
+					keys->szmic,
+					keys->akf ? app_key : dev_key);
 		}
 
 		if (keys->dev_key && !keys->akf)
@@ -1057,10 +1056,12 @@ static void check_encrypt(const struct mesh_crypto_test *keys)
 		verify_data("EncryptedAppPayload", 0, keys->enc_msg, enc_msg,
 								app_msg_len);
 		if (keys->szmic) {
+			app_mic64 = l_get_be64(enc_msg + app_msg_len);
 			verify_uint64("ApplicationMIC", app_msg_len,
 						keys->app_mic64, app_mic64);
 			app_msg_len += 8;
 		} else {
+			app_mic32 = l_get_be32(enc_msg + app_msg_len);
 			verify_uint32("ApplicationMIC", app_msg_len,
 						keys->app_mic32, app_mic32);
 			app_msg_len += 4;
@@ -1172,20 +1173,18 @@ static void check_encrypt(const struct mesh_crypto_test *keys)
 					keys->net_seq[i], keys->net_src,
 					keys->iv_index, net_nonce);
 
-			verify_data("TransportData", 9, keys->trans_pkt[i],
+		verify_data("TransportData", 9, keys->trans_pkt[i],
 							packet + 9, seg_len);
 
 		verify_uint16("DST", 7, keys->net_dst, l_get_be16(packet + 7));
 		net_msg_len = seg_len + 2;
 		show_data("TransportPayload", 7, packet + 7, net_msg_len);
 
-		mesh_crypto_network_encrypt(keys->ctl,
-				keys->net_ttl, keys->net_seq[i],
-				keys->net_src,
-				keys->iv_index, enc_key,
-				packet + 7, seg_len + 2, packet + 7,
-				keys->ctl ? (void *)&net_mic64 :
-							(void *)&net_mic32);
+		mesh_crypto_packet_encrypt(packet, packet_len, enc_key,
+						keys->iv_index, false,
+						keys->ctl, keys->net_ttl,
+						keys->net_seq[i],
+						keys->net_src);
 
 		mesh_crypto_privacy_counter(keys->iv_index, packet + 7,
 								priv_rand);
@@ -1208,20 +1207,23 @@ static void check_encrypt(const struct mesh_crypto_test *keys)
 		verify_data("EncNetworkPayload", 7, keys->net_msg[i],
 						packet + 7, net_msg_len);
 		if (keys->ctl) {
+			net_mic64 = l_get_be64(packet + packet_len - 8);
 			verify_uint64("NetworkMIC", 7 + net_msg_len,
 						keys->net_mic64, net_mic64);
 			net_msg_len += 8;
 		} else {
+			net_mic32 = l_get_be32(packet + packet_len - 4);
 			verify_uint32("NetworkMIC", 7 + net_msg_len,
 						keys->net_mic32[i], net_mic32);
 			net_msg_len += 4;
 		}
 
 		show_data("PreObsPayload", 1, packet + 1, 6 + net_msg_len);
-		mesh_crypto_network_obfuscate(priv_key, priv_rand,
-				keys->ctl,
-				keys->net_ttl, keys->net_seq[i],
-				keys->net_src, packet + 1);
+		mesh_crypto_network_obfuscate(packet, priv_key,
+					keys->iv_index,
+					keys->ctl, keys->net_ttl,
+					keys->net_seq[i], keys->net_src);
+
 		show_data("PostObsPayload", 1, packet + 1, 6 + net_msg_len);
 
 		packet[0] = (keys->iv_index & 0x01) << 7 | nid;
@@ -1242,7 +1244,7 @@ done:
 
 static void check_decrypt_segment(const struct mesh_crypto_test *keys,
 				uint16_t seg, uint16_t seg_max,
-				const uint8_t *pkt, uint8_t pkt_len,
+				uint8_t *pkt, uint8_t pkt_len,
 				const uint8_t *msg, uint8_t msg_len,
 				uint8_t *enc_key, uint8_t *priv_key,
 				uint8_t nid)
@@ -1274,26 +1276,30 @@ static void check_decrypt_segment(const struct mesh_crypto_test *keys,
 	if (ctl) {
 		net_mic64 = l_get_be64(pkt + pkt_len - 8);
 		show_data("EncryptedPayload", 7, pkt + 7, pkt_len - 7 - 8);
-		mesh_crypto_network_decrypt(ctl, ttl, seq,
-				src, keys->iv_index, enc_key,
-				pkt + 7, pkt_len - 7, net_clr + 7,
-				&calc_net_mic64,
-				sizeof(calc_net_mic64));
+
+		mesh_crypto_packet_decrypt(pkt, pkt_len,
+							enc_key,
+							keys->iv_index, false,
+							ctl, ttl, seq,
+							src);
+		calc_net_mic64 = l_get_be64(pkt + pkt_len - 8);
+
 		verify_uint64("NetworkMIC", pkt_len - 8, net_mic64,
-				calc_net_mic64);
+						net_mic64 ^ calc_net_mic64);
 		show_data("DecryptedPayload", 7, net_clr + 7, pkt_len - 7 - 8);
 	} else {
 		net_mic32 = l_get_be32(pkt + pkt_len - 4);
 		show_data("EncryptedPayload", 7, pkt + 7, pkt_len - 7 - 4);
 
-		mesh_crypto_network_decrypt(ctl, ttl, seq,
-				src, keys->iv_index, enc_key,
-				pkt + 7, pkt_len - 7, net_clr + 7,
-				&calc_net_mic32,
-				sizeof(calc_net_mic32));
+		mesh_crypto_packet_decrypt(pkt, pkt_len,
+							enc_key,
+							keys->iv_index, false,
+							ctl, ttl, seq,
+							src);
+		calc_net_mic32 = l_get_be32(pkt + pkt_len - 4);
 
 		verify_uint32("NetworkMIC", pkt_len - 4, net_mic32,
-				calc_net_mic32);
+						net_mic32 ^ calc_net_mic32);
 		show_data("DecryptedPayload", 7, net_clr + 7, pkt_len - 7 - 4);
 	}
 
@@ -1387,15 +1393,11 @@ static void check_decrypt(const struct mesh_crypto_test *keys)
 	uint8_t *app_key;
 	uint8_t *net_key;
 	uint8_t enc_key[16];
-	uint8_t net_nonce[13];
-	uint8_t app_nonce[13];
 	uint8_t priv_key[16];
-	uint8_t priv_rand[16];
 	uint8_t p[9];
 	size_t p_len;
 	uint8_t *packet = NULL;
 	size_t packet_len;
-	const uint8_t *net_hdr;
 	uint8_t *net_msg;
 	uint8_t net_msg_len;
 	uint16_t app_msg_len = 0;
@@ -1469,9 +1471,6 @@ static void check_decrypt(const struct mesh_crypto_test *keys)
 		goto done;
 	}
 
-	mesh_crypto_application_nonce(keys->app_seq, keys->net_src,
-						keys->net_dst, keys->iv_index,
-						keys->szmic, app_nonce);
 	app_msg = l_malloc(384);
 
 	seg_max = (sizeof(keys->packet) / sizeof(keys->packet[0])) - 1;
@@ -1483,19 +1482,13 @@ static void check_decrypt(const struct mesh_crypto_test *keys)
 		if (keys->segmented)
 			l_info(COLOR_YELLOW "Segment-%d" COLOR_OFF, i);
 
-		mesh_crypto_network_nonce(keys->frnd, keys->net_ttl,
-				keys->net_seq[i], keys->net_src, keys->iv_index,
-				net_nonce);
 		l_free(packet);
 		packet = l_util_from_hexstring(keys->packet[i], &packet_len);
 
-		net_hdr = packet + 1;
 		net_msg = packet + 7;
 		net_msg_len = packet_len - 7;
 
-		mesh_crypto_privacy_counter(keys->iv_index, net_msg, priv_rand);
-
-		mesh_crypto_network_clarify(priv_key, priv_rand, net_hdr,
+		mesh_crypto_network_clarify(packet, priv_key, keys->iv_index,
 				&net_ctl, &net_ttl, &net_seq, &net_src);
 
 		show_str("Packet", 0, keys->packet[i]);
@@ -1504,29 +1497,31 @@ static void check_decrypt(const struct mesh_crypto_test *keys)
 			net_mic64 = l_get_be64(packet + packet_len - 8);
 			show_data("NetworkMessage", 7, net_msg,
 							net_msg_len - 8);
-			mesh_crypto_network_decrypt(net_ctl, net_ttl, net_seq,
-					net_src, keys->iv_index, enc_key,
-					net_msg, net_msg_len, net_msg,
-					&calc_net_mic64,
-					sizeof(calc_net_mic64));
+			mesh_crypto_packet_decrypt(packet, packet_len,
+						enc_key,
+						keys->iv_index, false,
+						net_ctl, net_ttl,
+						net_seq,
+						net_src);
+			calc_net_mic64 = l_get_be64(packet + packet_len - 8);
 			net_msg_len -= 8;
 			verify_uint64("NetworkMIC", 7 + net_msg_len, net_mic64,
-								calc_net_mic64);
+						net_mic64 ^ calc_net_mic64);
 			show_data("DecryptedNetwork", 7, net_msg, net_msg_len);
 		} else {
 			net_mic32 = l_get_be32(packet + packet_len - 4);
 			show_data("NetworkMessage", 7, net_msg,
 							net_msg_len - 4);
-
-			mesh_crypto_network_decrypt(net_ctl, net_ttl, net_seq,
-					net_src, keys->iv_index, enc_key,
-					net_msg, net_msg_len, net_msg,
-					&calc_net_mic32,
-					sizeof(calc_net_mic32));
-
+			mesh_crypto_packet_decrypt(packet, packet_len,
+						enc_key,
+						keys->iv_index, false,
+						net_ctl, net_ttl,
+						net_seq,
+						net_src);
+			calc_net_mic32 = l_get_be32(packet + packet_len - 4);
 			net_msg_len -= 4;
 			verify_uint32("NetworkMIC", 7 + net_msg_len, net_mic32,
-								calc_net_mic32);
+						net_mic32 ^ calc_net_mic32);
 			show_data("DecryptedNetwork", 7, net_msg, net_msg_len);
 		}
 
@@ -1645,8 +1640,8 @@ static void check_decrypt(const struct mesh_crypto_test *keys)
 				packet, &pkt_len);
 		verify_data("TransportData", 9, keys->trans_pkt[i], packet + 9,
 								payload_len);
-		mesh_crypto_packet_encode(packet, pkt_len, enc_key,
-						keys->iv_index, priv_key);
+		mesh_crypto_packet_encode(packet, pkt_len, keys->iv_index,
+							enc_key, priv_key);
 		mesh_crypto_packet_label(packet, pkt_len, keys->iv_index, nid);
 
 		verify_data("Encoded-Packet", 0, keys->packet[i], packet,
@@ -1666,39 +1661,45 @@ static void check_decrypt(const struct mesh_crypto_test *keys)
 							app_msg_len - 8);
 		app_mic64 = l_get_be64(app_msg + app_msg_len - 8);
 
-		mesh_crypto_application_decrypt(
-				keys_aid | (keys->akf ? KEY_ID_AKF : 0),
-				seqZero, net_src,
-				net_dst, keys->iv_index,
-				keys->akf ? app_key : dev_key,
+		mesh_crypto_payload_decrypt(
 				aad, aad_len,
 				app_msg, app_msg_len,
-				app_msg, &calc_app_mic64,
-				sizeof(calc_app_mic64));
+				true,
+				net_src, net_dst,
+				keys->akf ? keys_aid | KEY_ID_AKF : APP_AID_DEV,
+				seqZero,
+				keys->iv_index,
+				app_msg,
+				keys->akf ? app_key : dev_key);
+
+		calc_app_mic64 = l_get_be64(app_msg + app_msg_len - 8);
 
 		verify_data("Payload", 0, keys->app_msg, app_msg,
 							app_msg_len - 8);
 		verify_uint64("ApplicationMIC", app_msg_len - 8, app_mic64,
-								calc_app_mic64);
+						app_mic64 ^ calc_app_mic64);
 	} else if (!keys->ctl) {
 		verify_data("EncryptedPayload", 0, keys->enc_msg, app_msg,
 							app_msg_len - 4);
 		app_mic32 = l_get_be32(app_msg + app_msg_len - 4);
 
-		mesh_crypto_application_decrypt(
-				keys_aid | (keys->akf ? KEY_ID_AKF : 0),
-				seqZero, net_src,
-				net_dst, keys->iv_index,
-				keys->akf ? app_key : dev_key,
+		mesh_crypto_payload_decrypt(
 				aad, aad_len,
 				app_msg, app_msg_len,
-				app_msg, &calc_app_mic32,
-				sizeof(calc_app_mic32));
+				false,
+				net_src, net_dst,
+				keys->akf ? keys_aid | KEY_ID_AKF : APP_AID_DEV,
+				seqZero,
+				keys->iv_index,
+				app_msg,
+				keys->akf ? app_key : dev_key);
+
+		calc_app_mic32 = l_get_be64(app_msg + app_msg_len - 4);
 
 		verify_data("Payload", 0, keys->app_msg, app_msg,
 							app_msg_len - 4);
 		verify_uint32("ApplicationMIC", app_msg_len - 4, app_mic32,
-								calc_app_mic32);
+						app_mic32 ^ calc_app_mic32);
 	}
 
 done:
-- 
2.25.0

