Return-Path: <SRS0=9IM7=WP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CD0C3A5A0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Aug 2019 09:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD6FA2087E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Aug 2019 09:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="xL8CXbLm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfHSJdj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Aug 2019 05:33:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40756 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726491AbfHSJdj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Aug 2019 05:33:39 -0400
Received: by mail-wr1-f68.google.com with SMTP id c3so7959041wrd.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Aug 2019 02:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Z1ei1zXLZJH1QlokYH8LchmO/uP9gsnM7nGZYMd1RPk=;
        b=xL8CXbLmXGt3D9Wfku8PHsHEAIHcwfWjXYTdr0JiOFKTfsJVkFMaR1Vj4u569F3KFx
         3NqbgMnplcbbdkYrlQzppQTRVuNsfWo/2TZqIiUgjIT1LNozGSuI9VQ0H34lCluLfJ+s
         0IPork6oAENybxOtc5r6sc0vDdgAafOb9HmwvRemBgRCrY9nChk7E4Qq+HlRd0Agmm20
         nroTC5rbKdLBZsnQGjlin/gspDFpGyyQOswf6HXK5mHJkaeRleBqdL47SZ6P4s0ItBcU
         BrUOUh9SK3ud7OIxIqQJ9D2+ggLd++TyjslHuxiJS5+mC3xhSwaoPFTbN/mcR6W6FEeW
         FAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z1ei1zXLZJH1QlokYH8LchmO/uP9gsnM7nGZYMd1RPk=;
        b=OuA61oP3EvdFHA0G3JNcnhHKilbIs3T8jKpXVSPhgPbRyEJUD2f1i66kuAkYMdGxAz
         ZTY7ZuuL0IVmkmBRjPwzli1WuU6+sZjVJEHI8TCjwPPtfqp5k5hbTWNkyjjCbZPrzyjK
         d5RuGhlbFRIrkZ/P2peyfDjowEpjgB4OGhptlJ7lh5Qa2txIayveyzOCAb5enLyDA3fz
         oykthWjLfNMbV9RPSLuWFLUr9iaNiKu8vUkFuJrSXTKT0RCjsw9qNFTCdpnGjW1R/dVc
         rOWySomFdcHo0y/tCHjf+WDhCpaN73bkpctRH6yZ0dqnLCONgOyjw5ljIepd3S217zS9
         XQhQ==
X-Gm-Message-State: APjAAAV4G6t3g9bm7ODmcYwcbNgcG3hiOODigJX6S1w4QZdXgd7D9JYP
        ShX7yOXtx46Y5r74Px9cSPr3q7TEDFk=
X-Google-Smtp-Source: APXvYqymcE0KILqJcrpwktGChrxRNseG0ZUoC/3BOJOVXYKaj82qWt1q93DkX592AHdg1tfcBkmY1A==
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr18219524wrs.108.1566207215905;
        Mon, 19 Aug 2019 02:33:35 -0700 (PDT)
Received: from mlowasrzechonek2133.silvair.lan ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id o9sm21675360wrm.88.2019.08.19.02.33.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 02:33:35 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20Lowas-Rzechonek?= 
        <michal.lowas-rzechonek@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] mesh: Remove redundant code from mesh/crypto
Date:   Mon, 19 Aug 2019 11:33:24 +0200
Message-Id: <20190819093324.10566-5-michal.lowas-rzechonek@silvair.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190819093324.10566-1-michal.lowas-rzechonek@silvair.com>
References: <20190819093324.10566-1-michal.lowas-rzechonek@silvair.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

- Refactor mesh_crypto_privacy_counter into mesh_crypto_pecb and make it
  private
- Make *_nonce functions private and align their implementation to be
  more consistent
- Remove network_encrypt/network_decrypt
- Remove application_encrypt/application_decrypt
- Refactor packet_encode/packet_decode and
  payload_encrypt/payload_decrypt to use *_nonce functions
---
 mesh/crypto.c | 424 ++++++++++++++++----------------------------------
 mesh/crypto.h |  48 +-----
 2 files changed, 139 insertions(+), 333 deletions(-)

diff --git a/mesh/crypto.c b/mesh/crypto.c
index 9862e5856..39d92b00f 100644
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
-}
-
-bool mesh_crypto_application_encrypt(uint8_t key_aid, uint32_t seq,
-					uint16_t src, uint16_t dst,
-					uint32_t iv_index,
-					const uint8_t app_key[16],
-					const uint8_t *aad, uint8_t aad_len,
-					const uint8_t *msg, uint8_t msg_len,
-					uint8_t *out,
-					void *app_mic, size_t mic_size)
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
-	return mesh_crypto_aes_ccm_encrypt(nonce, app_key, aad, aad_len,
-						msg, msg_len,
-						out, app_mic, mic_size);
 }
 
-bool mesh_crypto_application_decrypt(uint8_t key_aid, uint32_t seq,
-				uint16_t src, uint16_t dst, uint32_t iv_index,
-				const uint8_t app_key[16],
-				const uint8_t *aad, uint8_t aad_len,
-				const uint8_t *enc_msg, uint8_t enc_msg_len,
-				uint8_t *out, void *app_mic, size_t mic_size)
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
@@ -557,69 +472,61 @@ bool mesh_crypto_virtual_addr(const uint8_t virtual_label[16],
 	return true;
 }
 
-bool mesh_crypto_privacy_counter(uint32_t iv_index,
+static bool mesh_crypto_pecb(const uint8_t privacy_key[16],
+						uint32_t iv_index,
 						const uint8_t *payload,
-						uint8_t privacy_counter[16])
+						uint8_t pecb[16])
 {
-	memset(privacy_counter, 0, 5);
-	l_put_be32(iv_index, privacy_counter + 5);
-	memcpy(privacy_counter + 9, payload, 7);
+	memset(pecb, 0, 5);
+	l_put_be32(iv_index, pecb + 5);
+	memcpy(pecb + 9, payload, 7);
 
-	return true;
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
+		net_hdr[i] = pecb[i] ^ net_hdr[i];
 
-	if (ctl)
-		*ctl = !!(tmp[0] & CTL);
-
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
@@ -686,24 +593,13 @@ bool mesh_crypto_packet_build(bool ctl, uint8_t ttl,
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
 	if (packet_len < 14)
 		return false;
 
-	this_dst = l_get_be16(packet + 7);
-
 	/* Try to keep bits in the order they exist within the packet */
 	if (ctl)
 		*ctl = !!(packet[1] & CTL);
@@ -717,6 +613,30 @@ bool mesh_crypto_packet_parse(const uint8_t *packet, uint8_t packet_len,
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
 
@@ -796,38 +716,27 @@ bool mesh_crypto_packet_parse(const uint8_t *packet, uint8_t packet_len,
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
+		mesh_crypto_device_nonce(seq, src, dst, iv_index, aszmic,
+									nonce);
+	else
+		mesh_crypto_application_nonce(seq, src, dst, iv_index, aszmic,
+									nonce);
 
-	if (!mesh_crypto_aes_ccm_encrypt(application_nonce, application_key,
-					aad, aad ? 16 : 0,
-					payload, payload_len,
-					out, NULL,
-					aszmic ? 8 : 4))
+	if (!mesh_crypto_aes_ccm_encrypt(nonce, app_key,
+							aad, aad ? 16 : 0,
+							payload, payload_len,
+							out, NULL,
+							aszmic ? 8 : 4))
 		return false;
 
 	return true;
@@ -835,13 +744,13 @@ bool mesh_crypto_payload_encrypt(uint8_t *aad, const uint8_t *payload,
 
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
 
@@ -849,27 +758,16 @@ bool mesh_crypto_payload_decrypt(uint8_t *aad, uint16_t aad_len,
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
@@ -881,7 +779,7 @@ bool mesh_crypto_payload_decrypt(uint8_t *aad, uint16_t aad_len,
 		if (mic64)
 			return false;
 	} else {
-		if (!mesh_crypto_aes_ccm_decrypt(app_nonce, app_key,
+		if (!mesh_crypto_aes_ccm_decrypt(nonce, app_key,
 					aad, aad_len,
 					payload, payload_len,
 					out, &mic32, sizeof(mic32)))
@@ -902,62 +800,39 @@ bool mesh_crypto_packet_encode(uint8_t *packet, uint8_t packet_len,
 				uint32_t iv_index,
 				const uint8_t privacy_key[16])
 {
-	uint8_t network_nonce[13] = { 0x00, 0x00 };
-	uint8_t privacy_counter[16] = { 0x00, 0x00, 0x00, 0x00, 0x00, };
-	uint8_t tmp[16];
-	int i;
+	uint8_t nonce[13];
+	bool ctl;
+	uint8_t ttl;
+	uint32_t seq;
+	uint16_t src, dst;
 
-	if (packet_len < 14)
+	if (!network_header_parse(packet, packet_len,
+						&ctl, &ttl, &seq, &src, &dst))
 		return false;
 
 	/* Detect Proxy packet by CTL == true && DST == 0x0000 */
-	if ((packet[1] & CTL) && l_get_be16(packet + 7) == 0)
-		network_nonce[0] = 0x03; /* Proxy Nonce */
+	if (ctl && !dst)
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
-	return true;
+	return mesh_crypto_network_obfuscate(packet, privacy_key, iv_index,
+							ctl, ttl, seq, src);
 }
 
 bool mesh_crypto_packet_decode(const uint8_t *packet, uint8_t packet_len,
@@ -965,59 +840,36 @@ bool mesh_crypto_packet_decode(const uint8_t *packet, uint8_t packet_len,
 				const uint8_t network_key[16],
 				const uint8_t privacy_key[16])
 {
-	uint8_t privacy_counter[16] = { 0x00, 0x00, 0x00, 0x00, 0x00, };
-	uint8_t network_nonce[13] = { 0x00, 0x00, };
-	uint8_t tmp[16];
+	uint8_t nonce[13];
+	bool ctl;
+	uint8_t ttl;
+	uint32_t seq;
 	uint16_t src;
-	int i;
 
 	if (packet_len < 14)
 		return false;
 
-	l_put_be32(iv_index, privacy_counter + 5);
-	memcpy(privacy_counter + 9, packet + 7, 7);
-
-	if (!aes_ecb_one(privacy_key, privacy_counter, tmp))
-		return false;
-
 	memcpy(out, packet, packet_len);
-	for (i = 0; i < 6; i++)
-		out[1 + i] ^= tmp[i];
 
-	src = l_get_be16(out + 5);
+	if (!mesh_crypto_network_clarify(out, privacy_key, iv_index,
+						&ctl, &ttl, &seq, &src))
+		return false;
 
 	/* Pre-check SRC address for illegal values */
-	if (!src || src >= 0x8000)
+	if (!IS_UNICAST(src))
 		return false;
 
 	/* Detect Proxy packet by CTL == true && proxy == true */
-	if ((out[1] & CTL) && proxy)
-		network_nonce[0] = 0x03; /* Proxy Nonce */
+	if (ctl && proxy)
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
+		if (!mesh_crypto_aes_ccm_decrypt(nonce, network_key,
 					NULL, 0, packet + 7, packet_len - 7,
 					out + 7, &mic, sizeof(mic)))
 			return false;
@@ -1030,7 +882,7 @@ bool mesh_crypto_packet_decode(const uint8_t *packet, uint8_t packet_len,
 	} else {
 		uint32_t mic;
 
-		if (!mesh_crypto_aes_ccm_decrypt(network_nonce, network_key,
+		if (!mesh_crypto_aes_ccm_decrypt(nonce, network_key,
 					NULL, 0, packet + 7, packet_len - 7,
 					out + 7, &mic, sizeof(mic)))
 			return false;
diff --git a/mesh/crypto.h b/mesh/crypto.h
index 1a73bcaa3..26c8bd939 100644
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
-- 
2.19.1

