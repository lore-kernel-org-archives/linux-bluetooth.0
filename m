Return-Path: <SRS0=iTYz=VN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57552C7618F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jul 2019 22:56:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29FF821743
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Jul 2019 22:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388674AbfGPW4v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Jul 2019 18:56:51 -0400
Received: from mga02.intel.com ([134.134.136.20]:2095 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728414AbfGPW4v (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Jul 2019 18:56:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2019 15:56:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,271,1559545200"; 
   d="scan'208";a="170073273"
Received: from bgix-dell-lap.sea.intel.com ([10.251.137.82])
  by orsmga003.jf.intel.com with ESMTP; 16 Jul 2019 15:56:50 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     inga.stotland@intel.com, brian.gix@intel.com,
        michal.lowas-rzechonek@silvair.com
Subject: [PATCH BlueZ 2/3] mesh: Normalize Access Key AID naming convention
Date:   Tue, 16 Jul 2019 15:56:43 -0700
Message-Id: <20190716225644.11449-3-brian.gix@intel.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20190716225644.11449-1-brian.gix@intel.com>
References: <20190716225644.11449-1-brian.gix@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 mesh/crypto.c | 37 ++++++++++++++++++-------------------
 mesh/crypto.h |  8 ++++----
 mesh/net.h    |  4 +---
 3 files changed, 23 insertions(+), 26 deletions(-)

diff --git a/mesh/crypto.c b/mesh/crypto.c
index a4679d88e..b1b1fa9a8 100644
--- a/mesh/crypto.c
+++ b/mesh/crypto.c
@@ -429,8 +429,9 @@ bool mesh_crypto_device_nonce(uint32_t seq, uint16_t src,
 	return true;
 }
 
-bool mesh_crypto_application_encrypt(uint8_t key_id, uint32_t seq, uint16_t src,
-					uint16_t dst, uint32_t iv_index,
+bool mesh_crypto_application_encrypt(uint8_t key_aid, uint32_t seq,
+					uint16_t src, uint16_t dst,
+					uint32_t iv_index,
 					const uint8_t app_key[16],
 					const uint8_t *aad, uint8_t aad_len,
 					const uint8_t *msg, uint8_t msg_len,
@@ -440,11 +441,11 @@ bool mesh_crypto_application_encrypt(uint8_t key_id, uint32_t seq, uint16_t src,
 	uint8_t nonce[13];
 	bool aszmic = (mic_size == 8) ? true : false;
 
-	if (!key_id && !mesh_crypto_device_nonce(seq, src, dst,
+	if (!key_aid && !mesh_crypto_device_nonce(seq, src, dst,
 						iv_index, aszmic, nonce))
 		return false;
 
-	if (key_id && !mesh_crypto_application_nonce(seq, src, dst,
+	if (key_aid && !mesh_crypto_application_nonce(seq, src, dst,
 						iv_index, aszmic, nonce))
 		return false;
 
@@ -453,8 +454,8 @@ bool mesh_crypto_application_encrypt(uint8_t key_id, uint32_t seq, uint16_t src,
 						out, app_mic, mic_size);
 }
 
-bool mesh_crypto_application_decrypt(uint8_t key_id, uint32_t seq, uint16_t src,
-				uint16_t dst, uint32_t iv_index,
+bool mesh_crypto_application_decrypt(uint8_t key_aid, uint32_t seq,
+				uint16_t src, uint16_t dst, uint32_t iv_index,
 				const uint8_t app_key[16],
 				const uint8_t *aad, uint8_t aad_len,
 				const uint8_t *enc_msg, uint8_t enc_msg_len,
@@ -463,11 +464,11 @@ bool mesh_crypto_application_decrypt(uint8_t key_id, uint32_t seq, uint16_t src,
 	uint8_t nonce[13];
 	bool aszmic = (mic_size == 8) ? true : false;
 
-	if (!key_id && !mesh_crypto_device_nonce(seq, src, dst,
+	if (!key_aid && !mesh_crypto_device_nonce(seq, src, dst,
 						iv_index, aszmic, nonce))
 		return false;
 
-	if (key_id && !mesh_crypto_application_nonce(seq, src, dst,
+	if (key_aid && !mesh_crypto_application_nonce(seq, src, dst,
 						iv_index, aszmic, nonce))
 		return false;
 
@@ -638,7 +639,7 @@ bool mesh_crypto_packet_build(bool ctl, uint8_t ttl,
 				uint32_t seq,
 				uint16_t src, uint16_t dst,
 				uint8_t opcode,
-				bool segmented, uint8_t key_id,
+				bool segmented, uint8_t key_aid,
 				bool szmic, bool relay, uint16_t seqZero,
 				uint8_t segO, uint8_t segN,
 				const uint8_t *payload, uint8_t payload_len,
@@ -656,7 +657,7 @@ bool mesh_crypto_packet_build(bool ctl, uint8_t ttl,
 
 	if (!ctl) {
 		hdr = segmented << SEG_HDR_SHIFT;
-		hdr |= (key_id & KEY_ID_MASK) << KEY_HDR_SHIFT;
+		hdr |= (key_aid & KEY_ID_MASK) << KEY_HDR_SHIFT;
 		if (segmented) {
 			hdr |= szmic << SZMIC_HDR_SHIFT;
 			hdr |= (seqZero & SEQ_ZERO_MASK) << SEQ_ZERO_HDR_SHIFT;
@@ -700,7 +701,7 @@ bool mesh_crypto_packet_parse(const uint8_t *packet, uint8_t packet_len,
 				bool *ctl, uint8_t *ttl, uint32_t *seq,
 				uint16_t *src, uint16_t *dst,
 				uint32_t *cookie, uint8_t *opcode,
-				bool *segmented, uint8_t *key_id,
+				bool *segmented, uint8_t *key_aid,
 				bool *szmic, bool *relay, uint16_t *seqZero,
 				uint8_t *segO, uint8_t *segN,
 				const uint8_t **payload, uint8_t *payload_len)
@@ -769,8 +770,8 @@ bool mesh_crypto_packet_parse(const uint8_t *packet, uint8_t packet_len,
 		if (cookie)
 			*cookie = l_get_be32(packet + packet_len - 8);
 
-		if (key_id)
-			*key_id = (hdr >> KEY_HDR_SHIFT) & KEY_ID_MASK;
+		if (key_aid)
+			*key_aid = (hdr >> KEY_HDR_SHIFT) & KEY_ID_MASK;
 
 		if (is_segmented) {
 			if (szmic)
@@ -805,7 +806,7 @@ bool mesh_crypto_packet_parse(const uint8_t *packet, uint8_t packet_len,
 
 bool mesh_crypto_payload_encrypt(uint8_t *aad, const uint8_t *payload,
 				uint8_t *out, uint16_t payload_len,
-				uint16_t src, uint16_t dst, uint8_t key_id,
+				uint16_t src, uint16_t dst, uint8_t key_aid,
 				uint32_t seq_num, uint32_t iv_index,
 				bool aszmic,
 				const uint8_t application_key[16])
@@ -815,8 +816,7 @@ bool mesh_crypto_payload_encrypt(uint8_t *aad, const uint8_t *payload,
 	if (payload_len < 1)
 		return false;
 
-	/* Key_ID == 0 means the Device Key is being used */
-	if (!key_id)
+	if (key_aid == APP_AID_DEV)
 		application_nonce[0] = 0x02;
 
 	/* Seq Num */
@@ -848,7 +848,7 @@ bool mesh_crypto_payload_decrypt(uint8_t *aad, uint16_t aad_len,
 				const uint8_t *payload, uint16_t payload_len,
 				bool szmict,
 				uint16_t src, uint16_t dst,
-				uint8_t key_id, uint32_t seq_num,
+				uint8_t key_aid, uint32_t seq_num,
 				uint32_t iv_index, uint8_t *out,
 				const uint8_t app_key[16])
 {
@@ -859,8 +859,7 @@ bool mesh_crypto_payload_decrypt(uint8_t *aad, uint16_t aad_len,
 	if (payload_len < 5 || !out)
 		return false;
 
-	/* Key_ID == 0 means the Device Key is being used */
-	if (!key_id)
+	if (key_aid == APP_AID_DEV)
 		app_nonce[0] = 0x02;
 
 	/* Seq Num */
diff --git a/mesh/crypto.h b/mesh/crypto.h
index 3e6815a35..1a73bcaa3 100644
--- a/mesh/crypto.h
+++ b/mesh/crypto.h
@@ -119,7 +119,7 @@ bool mesh_crypto_packet_build(bool ctl, uint8_t ttl,
 				uint32_t seq,
 				uint16_t src, uint16_t dst,
 				uint8_t opcode,
-				bool segmented, uint8_t key_id,
+				bool segmented, uint8_t key_aid,
 				bool szmic, bool relay, uint16_t seqZero,
 				uint8_t segO, uint8_t segN,
 				const uint8_t *payload, uint8_t payload_len,
@@ -128,20 +128,20 @@ bool mesh_crypto_packet_parse(const uint8_t *packet, uint8_t packet_len,
 				bool *ctl, uint8_t *ttl, uint32_t *seq,
 				uint16_t *src, uint16_t *dst,
 				uint32_t *cookie, uint8_t *opcode,
-				bool *segmented, uint8_t *key_id,
+				bool *segmented, uint8_t *key_aid,
 				bool *szmic, bool *relay, uint16_t *seqZero,
 				uint8_t *segO, uint8_t *segN,
 				const uint8_t **payload, uint8_t *payload_len);
 bool mesh_crypto_payload_encrypt(uint8_t *aad, const uint8_t *payload,
 				uint8_t *out, uint16_t payload_len,
-				uint16_t src, uint16_t dst, uint8_t key_id,
+				uint16_t src, uint16_t dst, uint8_t key_aid,
 				uint32_t seq_num, uint32_t iv_index,
 				bool aszmic,
 				const uint8_t application_key[16]);
 bool mesh_crypto_payload_decrypt(uint8_t *aad, uint16_t aad_len,
 				const uint8_t *payload, uint16_t payload_len,
 				bool szmict,
-				uint16_t src, uint16_t dst, uint8_t key_id,
+				uint16_t src, uint16_t dst, uint8_t key_aid,
 				uint32_t seq_num, uint32_t iv_index,
 				uint8_t *out,
 				const uint8_t application_key[16]);
diff --git a/mesh/net.h b/mesh/net.h
index 8848e6df0..7b0733578 100644
--- a/mesh/net.h
+++ b/mesh/net.h
@@ -28,9 +28,7 @@ struct mesh_node;
 
 #define UNUSED_KEY_IDX	0xffff
 
-#define APP_ID_DEV	0
-#define APP_ID_ANY	((unsigned int) -1)
-#define NET_ID_ANY	(APP_ID_ANY - 1)
+#define APP_AID_DEV	0x00
 
 #define CTL		0x80
 #define TTL_MASK	0x7f
-- 
2.14.5

