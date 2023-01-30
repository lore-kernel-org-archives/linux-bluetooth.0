Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C59C54EAA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Jan 2023 23:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjA3Xw1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Jan 2023 18:52:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjA3XwZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Jan 2023 18:52:25 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE932E0CE
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 15:52:23 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so12725383pjb.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 15:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8FICHa8d+V8Y+WrmeEJ+IuZuXrYvXGOMQpKG/88a4ow=;
        b=iaLB5+UL5pxfyGX4Uw1xfzbrPQRcUo+qMOw/Z1UX7kNoWY7Bk28j+ZlyyuhH3YrKjO
         wlYM04V6bkLWtRCKkZKo46UoIBBXUyzXO064fA3d0LECIHXjIgFFnmcctgPaPdo2a0SK
         2rG4N4OOT0JsKXDjDGwyxBkBosij7pvZcWHVJPELbg6Ev5mdAVzT3fY/0Ijr1E2zO50K
         52whaENWg4d0HJ1dIbEMyWVvKcK37MYcgBsz3YsIghOjpmCqYLYwc33x0BSXr9+IYkbd
         NW7kDNRX0tOOly0cY/W75ZoHgRhoknc6pVCKjp8J2TvO6jdswf+C8F4J9tUVPC9JoNRv
         9org==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8FICHa8d+V8Y+WrmeEJ+IuZuXrYvXGOMQpKG/88a4ow=;
        b=knGJ/e9ouXKewFLU1r7rJaQfzuiZRrYAmmjtr5feUSDLCmTHCvA7e7IBwz2T6B34Tt
         t8JRfW9z2MhwaHiWYe/SHtLOS40l+0xgt2KuyQBZMrLE+GQ0CmjJcjywx5TN74/8R3nK
         XLw37VjRVvQZ/WHvCbWEVTxo/7LVtRLINLAMOsWq08/TPdSM/gsOPVghT/491+xDdl3x
         cuPcKlxT4jl6ftb3623YnqIZMb2DVuXd23eHl1uZ5ygN81ITCjvXpS7XF0PiQbvAhi45
         VN0kxCMC1KJfmPIPfKL2R8QQR5nqZTrn4OXXQl5943z3g52lmtGZDQcz3woPeZQymt64
         AHXA==
X-Gm-Message-State: AO0yUKWsdsWPD8jn1W8/qwmr57AKyZIFJFG9HiG73MJW5evBPY/60ty6
        dUnVQEHf01u02BZ+PGswU9FMSc0fVYBWnQ==
X-Google-Smtp-Source: AK7set+GAAcpikkqGPPrwf67THgeh9TKHs7aQegaJRrZyiBrjo9l5mdYRg81dT0NRzu0DbIKZ8WRDQ==
X-Received: by 2002:a05:6a20:6917:b0:bc:caea:6cea with SMTP id q23-20020a056a20691700b000bccaea6ceamr8142562pzj.6.1675122741870;
        Mon, 30 Jan 2023 15:52:21 -0800 (PST)
Received: from fedora.. (97-126-124-199.tukw.qwest.net. [97.126.124.199])
        by smtp.gmail.com with ESMTPSA id t191-20020a6381c8000000b004e8f7f23c4bsm2663948pgd.76.2023.01.30.15.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 15:52:20 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH BlueZ v5 05/14] unit/mesh:  Add unit testing of Mesh Private Beaconing
Date:   Mon, 30 Jan 2023 15:52:01 -0800
Message-Id: <20230130235210.94385-6-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230130235210.94385-1-brian.gix@gmail.com>
References: <20230130235210.94385-1-brian.gix@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Brian Gix <brian.gix@intel.com>

This includes the Sample Data from the Mesh Profile specification v1.1,
and validates that the beacon crypto functions work as expected.
---
 unit/test-mesh-crypto.c | 182 ++++++++++++++++++++++++++++++++--------
 1 file changed, 147 insertions(+), 35 deletions(-)

diff --git a/unit/test-mesh-crypto.c b/unit/test-mesh-crypto.c
index f9b7d81da..39632d973 100644
--- a/unit/test-mesh-crypto.c
+++ b/unit/test-mesh-crypto.c
@@ -633,6 +633,36 @@ static const struct mesh_crypto_test s8_4_3 = {
 	.beacon		= "01003ecaff672f673370123456788ea261582f364f6f",
 };
 
+static const struct mesh_crypto_test s8_4_6_1 = {
+	.name		= "8.4.6.1 Private Beacon IVU",
+
+	.net_key	= "f7a2a44f8e8a8029064f173ddc1e2b00",
+	.iv_index	= 0x1010abcd,
+
+	.enc_key	= "6be76842460b2d3a5850d4698409f1bb",
+	.rand		= "435f18f85cf78a3121f58478a5",
+
+	.beacon_type	= 0x02,
+	.beacon_flags	= 0x02,
+	.beacon_cmac	= "f3174f022a514741",
+	.beacon	= "02435f18f85cf78a3121f58478a561e488e7cbf3174f022a514741",
+};
+
+static const struct mesh_crypto_test s8_4_6_2 = {
+	.name		= "8.4.6.2 Private Beacon IVU Complete",
+
+	.net_key	= "3bbb6f1fbd53e157417f308ce7aec58f",
+	.iv_index	= 0x00000000,
+
+	.enc_key	= "ca478cdac626b7a8522d7272dd124f26",
+	.rand		= "1b998f82927535ea6f3076f422",
+
+	.beacon_type	= 0x02,
+	.beacon_flags	= 0x00,
+	.beacon_cmac	= "2f0ffb94cf97f881",
+	.beacon	= "021b998f82927535ea6f3076f422ce827408ab2f0ffb94cf97f881",
+};
+
 static const struct mesh_crypto_test s8_6_2 = {
 	.name		= "8.6.2 Service Data using Node Identity",
 
@@ -683,6 +713,17 @@ static void verify_data(const char *label, unsigned int indent,
 	l_free(str);
 }
 
+static void verify_bool(const char *label, unsigned int indent,
+						bool sample, bool data)
+{
+	l_info("%-20s =%*c%s", label, 1 + (indent * 2), ' ',
+						sample ? "true" : "false");
+	l_info("%-20s  %*c%s => %s", "", 1 + (indent * 2), ' ',
+						data ? "true" : "false",
+						EVALNUM(sample, data));
+	EXITNUM(sample, data);
+}
+
 static void verify_bool_not_both(const char *label, unsigned int indent,
 						bool sample, bool data)
 {
@@ -796,10 +837,11 @@ static void check_encrypt_segment(const struct mesh_crypto_test *keys,
 	uint32_t hdr;
 	uint64_t net_mic64, net_mic32;
 	size_t net_msg_len;
+	bool status;
 	uint8_t key_aid = keys->key_aid | (keys->akf ? KEY_ID_AKF : 0x00);
 
 	if (keys->ctl) {
-		mesh_crypto_packet_build(keys->ctl, keys->net_ttl,
+		status = mesh_crypto_packet_build(keys->ctl, keys->net_ttl,
 				keys->net_seq[0],
 				keys->net_src, keys->net_dst,
 				keys->opcode,
@@ -809,7 +851,7 @@ static void check_encrypt_segment(const struct mesh_crypto_test *keys,
 				enc_msg, len,
 				packet, &packet_len);
 	} else {
-		mesh_crypto_packet_build(keys->ctl, keys->net_ttl,
+		status = mesh_crypto_packet_build(keys->ctl, keys->net_ttl,
 				keys->net_seq[0],
 				keys->net_src, keys->net_dst,
 				keys->opcode,
@@ -822,6 +864,10 @@ static void check_encrypt_segment(const struct mesh_crypto_test *keys,
 
 	l_info(COLOR_YELLOW "Segment-%d" COLOR_OFF, seg);
 
+	verify_bool("Crypto packet build", 0, true, status);
+	if (!status)
+		return;
+
 	hdr = l_get_be32(packet + 9);
 	verify_uint8("SEG", 9, keys->segmented << (SEG_HDR_SHIFT % 8),
 			packet[9] & (1 << (SEG_HDR_SHIFT % 8)));
@@ -870,15 +916,20 @@ static void check_encrypt_segment(const struct mesh_crypto_test *keys,
 	net_msg_len = len + 2;
 	show_data("TransportPayload", 7, packet + 7, net_msg_len);
 
-	mesh_crypto_packet_encrypt(packet, packet_len,
+	status = mesh_crypto_packet_encrypt(packet, packet_len,
 						enc_key,
 						keys->iv_index, false,
 						keys->ctl, keys->net_ttl,
 						keys->net_seq[0],
 						keys->net_src);
 
+	verify_bool("Crypto packet encrypt", 0, true, status);
+	if (!status)
+		return;
+
 	mesh_crypto_privacy_counter(keys->iv_index, packet + 7, priv_rand);
 
+
 	l_info("");
 	show_uint32("IVindex", 0, keys->iv_index);
 	verify_data("NetworkNonce", 0, keys->net_nonce[0], net_nonce, 13);
@@ -907,10 +958,15 @@ static void check_encrypt_segment(const struct mesh_crypto_test *keys,
 	}
 
 	show_data("PreObsPayload", 1, packet + 1, 6 + net_msg_len);
-	mesh_crypto_network_obfuscate(packet, priv_key,
+	status = mesh_crypto_network_obfuscate(packet, priv_key,
 					keys->iv_index,
 					keys->ctl, keys->net_ttl,
 					keys->net_seq[0], keys->net_src);
+
+	verify_bool("Crypto network obfuscate", 0, true, status);
+	if (!status)
+		return;
+
 	show_data("PostObsPayload", 1, packet + 1, 6 + net_msg_len);
 
 	packet[0] = (keys->iv_index & 0x01) << 7 | nid;
@@ -926,7 +982,7 @@ static void check_encrypt(const struct mesh_crypto_test *keys)
 	uint8_t *dev_key;
 	uint8_t *app_key;
 	uint8_t *net_key;
-	uint8_t nid;
+	uint8_t nid = 0;
 	uint8_t enc_key[16];
 	uint8_t priv_key[16];
 	uint8_t net_nonce[13];
@@ -949,6 +1005,7 @@ static void check_encrypt(const struct mesh_crypto_test *keys)
 	uint8_t packet_len;
 	uint16_t i, seg_max, seg_len = 0;
 	uint32_t seqZero, hdr;
+	bool status;
 
 	l_info(COLOR_BLUE "[Encrypt %s]" COLOR_OFF, keys->name);
 	verify_bool_not_both("CTL && Segmented", 0, keys->ctl, keys->segmented);
@@ -960,8 +1017,7 @@ static void check_encrypt(const struct mesh_crypto_test *keys)
 
 	show_data("NetworkKey", 0, net_key, 16);
 
-	if (keys->akf) {
-		mesh_crypto_k4(app_key, &key_aid);
+	if (keys->akf && mesh_crypto_k4(app_key, &key_aid)) {
 		key_aid |= KEY_ID_AKF;
 	} else {
 		key_aid = 0;
@@ -1034,7 +1090,7 @@ static void check_encrypt(const struct mesh_crypto_test *keys)
 			seg_max = SEG_MAX(keys->segmented, app_msg_len + 8);
 			enc_msg = l_malloc(app_msg_len + 8);
 
-			mesh_crypto_payload_encrypt(aad, app_msg,
+			status = mesh_crypto_payload_encrypt(aad, app_msg,
 					enc_msg, app_msg_len,
 					keys->net_src, keys->net_dst, key_aid,
 					keys->app_seq, keys->iv_index,
@@ -1044,7 +1100,7 @@ static void check_encrypt(const struct mesh_crypto_test *keys)
 			seg_max = SEG_MAX(keys->segmented, app_msg_len + 4);
 			enc_msg = l_malloc(app_msg_len + 4);
 
-			mesh_crypto_payload_encrypt(aad, app_msg,
+			status = mesh_crypto_payload_encrypt(aad, app_msg,
 					enc_msg, app_msg_len,
 					keys->net_src, keys->net_dst, key_aid,
 					keys->app_seq, keys->iv_index,
@@ -1052,6 +1108,10 @@ static void check_encrypt(const struct mesh_crypto_test *keys)
 					keys->akf ? app_key : dev_key);
 		}
 
+		verify_bool("Crypto payload encrypt", 0, true, status);
+		if (!status)
+			return;
+
 		if (keys->dev_key && !keys->akf)
 			show_data("DeviceKey", 0, dev_key, 16);
 
@@ -1097,7 +1157,8 @@ static void check_encrypt(const struct mesh_crypto_test *keys)
 		}
 
 		if (keys->ctl) {
-			mesh_crypto_packet_build(keys->ctl, keys->net_ttl,
+			status = mesh_crypto_packet_build(keys->ctl,
+					keys->net_ttl,
 					keys->net_seq[i],
 					keys->net_src, keys->net_dst,
 					keys->opcode,
@@ -1107,7 +1168,8 @@ static void check_encrypt(const struct mesh_crypto_test *keys)
 					enc_msg + 1, seg_len,
 					packet, &packet_len);
 		} else {
-			mesh_crypto_packet_build(keys->ctl, keys->net_ttl,
+			status = mesh_crypto_packet_build(keys->ctl,
+					keys->net_ttl,
 					keys->net_seq[i],
 					keys->net_src, keys->net_dst,
 					keys->opcode,
@@ -1120,6 +1182,10 @@ static void check_encrypt(const struct mesh_crypto_test *keys)
 
 		if (seg_max) l_info(COLOR_YELLOW "Segment-%d" COLOR_OFF, i);
 
+		verify_bool("Crypto packet build", 0, true, status);
+		if (!status)
+			return;
+
 		hdr = l_get_be32(packet + 9);
 		verify_uint8("SEG", 9, keys->segmented << (SEG_HDR_SHIFT % 8),
 					packet[9] & (1 << (SEG_HDR_SHIFT % 8)));
@@ -1193,12 +1259,16 @@ static void check_encrypt(const struct mesh_crypto_test *keys)
 		net_msg_len = seg_len + 2;
 		show_data("TransportPayload", 7, packet + 7, net_msg_len);
 
-		mesh_crypto_packet_encrypt(packet, packet_len, enc_key,
+		status = mesh_crypto_packet_encrypt(packet, packet_len, enc_key,
 						keys->iv_index, false,
 						keys->ctl, keys->net_ttl,
 						keys->net_seq[i],
 						keys->net_src);
 
+		verify_bool("Crypto packet encrypt", 0, true, status);
+		if (!status)
+			return;
+
 		mesh_crypto_privacy_counter(keys->iv_index, packet + 7,
 								priv_rand);
 
@@ -1232,11 +1302,15 @@ static void check_encrypt(const struct mesh_crypto_test *keys)
 		}
 
 		show_data("PreObsPayload", 1, packet + 1, 6 + net_msg_len);
-		mesh_crypto_network_obfuscate(packet, priv_key,
+		status = mesh_crypto_network_obfuscate(packet, priv_key,
 					keys->iv_index,
 					keys->ctl, keys->net_ttl,
 					keys->net_seq[i], keys->net_src);
 
+		verify_bool("Crypto network obfuscate", 0, true, status);
+		if (!status)
+			return;
+
 		show_data("PostObsPayload", 1, packet + 1, 6 + net_msg_len);
 
 		packet[0] = (keys->iv_index & 0x01) << 7 | nid;
@@ -1265,19 +1339,20 @@ static void check_decrypt_segment(const struct mesh_crypto_test *keys,
 	uint8_t net_clr[29];
 	uint64_t net_mic64, calc_net_mic64;
 	uint32_t hdr, net_mic32, calc_net_mic32;
-	bool ctl, segmented, relay, szmic, key_akf;
+	bool ctl, segmented, relay, szmic, key_akf, status;
 	uint8_t ttl, opcode, key_aid, segO, segN;
 	uint32_t seq;
 	uint16_t src, dst, seqZero;
 
 	memcpy(net_clr, pkt, pkt_len);
 	show_data("NetworkMessage", 0, pkt, pkt_len);
-	mesh_crypto_packet_decode(pkt, pkt_len,
+	status = mesh_crypto_packet_decode(pkt, pkt_len,
 				false, net_clr, keys->iv_index,
 				enc_key, priv_key);
 	show_data("Decoded", 0, net_clr, pkt_len);
 
-	mesh_crypto_packet_parse(net_clr, pkt_len,
+	if (status)
+		status = mesh_crypto_packet_parse(net_clr, pkt_len,
 			&ctl, &ttl, &seq,
 			&src, &dst,
 			NULL, &opcode,
@@ -1286,6 +1361,10 @@ static void check_decrypt_segment(const struct mesh_crypto_test *keys,
 			&segO, &segN,
 			&msg, &msg_len);
 
+	verify_bool("Crypto Decode-Parse", 0, true, status);
+	if (!status)
+		return;
+
 	if (ctl) {
 		net_mic64 = l_get_be64(pkt + pkt_len - 8);
 		show_data("EncryptedPayload", 7, pkt + 7, pkt_len - 7 - 8);
@@ -1416,7 +1495,7 @@ static void check_decrypt(const struct mesh_crypto_test *keys)
 	uint16_t app_msg_len = 0;
 	uint32_t calc_net_mic32, net_mic32 = 0;
 	uint64_t calc_net_mic64, net_mic64 = 0;
-	bool net_ctl, net_segmented, net_rly, net_akf;
+	bool net_ctl, net_segmented, net_rly, net_akf, status;
 	uint8_t net_aid, net_ttl, nid, net_segO, net_segN = 0;
 	uint32_t net_seq, hdr, seqZero = 0;
 	uint16_t net_src, net_dst;
@@ -1501,8 +1580,14 @@ static void check_decrypt(const struct mesh_crypto_test *keys)
 		net_msg = packet + 7;
 		net_msg_len = packet_len - 7;
 
-		mesh_crypto_network_clarify(packet, priv_key, keys->iv_index,
-				&net_ctl, &net_ttl, &net_seq, &net_src);
+		status = mesh_crypto_network_clarify(packet, priv_key,
+				keys->iv_index, &net_ctl, &net_ttl, &net_seq,
+				&net_src);
+
+		verify_bool("Crypto Clarify", 0, true, status);
+		if (!status)
+			return;
+
 
 		show_str("Packet", 0, keys->packet[i]);
 
@@ -1731,42 +1816,67 @@ static void check_beacon(const struct mesh_crypto_test *keys)
 {
 	uint8_t *net_key;
 	uint8_t *beacon_cmac;
-	uint8_t beacon[22];
+	uint8_t *random = NULL;
+	uint8_t beacon[29];
 	uint8_t enc_key[16];
 	uint8_t net_id[8];
 	uint8_t cmac[8];
-	uint64_t cmac_tmp;
+	uint64_t cmac_tmp = 0;
+
+	if (keys->beacon_type < 1 || keys->beacon_type > 2)
+		verify_uint8("Unknown Beacon", 0, true,
+			(keys->beacon_type >= 1 || keys->beacon_type <= 2));
 
 	net_key = l_util_from_hexstring(keys->net_key, NULL);
 	beacon_cmac = l_util_from_hexstring(keys->beacon_cmac, NULL);
 
-	mesh_crypto_nkbk(net_key, enc_key);
+	if (keys->beacon_type == 1) {
+		mesh_crypto_nkbk(net_key, enc_key);
+	} else {
+		mesh_crypto_nkpk(net_key, enc_key);
+		random = l_util_from_hexstring(keys->rand, NULL);
+	}
+
 	mesh_crypto_k3(net_key, net_id);
 
 	l_info(COLOR_BLUE "[%s]" COLOR_OFF, keys->name);
 
 	verify_data("NetworkKey", 0, keys->net_key, net_key, 16);
+	show_uint8("Beacon Flags", 0, keys->beacon_flags);
 	show_uint32("IVindex", 0, keys->iv_index);
 
 	verify_data("BeaconKey", 0, keys->enc_key, enc_key, 16);
-	verify_data("NetworkID", 0, keys->net_id, net_id, 8);
 
 	beacon[0] = keys->beacon_type;
-	beacon[1] = keys->beacon_flags;
-	memcpy(beacon + 2, net_id, 8);
-	l_put_be32(keys->iv_index, beacon + 10);
-	mesh_crypto_beacon_cmac(enc_key, net_id, keys->iv_index,
-					!!(keys->beacon_flags & 0x01),
-					!!(keys->beacon_flags & 0x02),
-					&cmac_tmp);
-
-	l_put_be64(cmac_tmp, cmac);
-	l_put_be64(cmac_tmp, beacon + 14);
-	verify_data("BeaconCMAC", 0, keys->beacon_cmac, cmac, 8);
-	verify_data("Beacon", 0, keys->beacon, beacon, sizeof(beacon));
+	if (keys->beacon_type == 1) {
+		verify_data("NetworkID", 0, keys->net_id, net_id, 8);
+		beacon[1] = keys->beacon_flags;
+		memcpy(beacon + 2, net_id, 8);
+		l_put_be32(keys->iv_index, beacon + 10);
+		mesh_crypto_beacon_cmac(enc_key, net_id, keys->iv_index,
+				!!(keys->beacon_flags & 0x01),
+				!!(keys->beacon_flags & 0x02),
+				&cmac_tmp);
+
+		l_put_be64(cmac_tmp, cmac);
+		l_put_be64(cmac_tmp, beacon + 14);
+		verify_data("BeaconCMAC", 0, keys->beacon_cmac, cmac, 8);
+		verify_data("SNBeacon", 0, keys->beacon, beacon, 22);
+	} else {
+		show_data("Random", 0, random, sizeof(random));
+		memcpy(beacon + 1, random, 13);
+		beacon[14] = keys->beacon_flags;
+		l_put_be32(keys->iv_index, beacon + 15);
+		mesh_crypto_aes_ccm_encrypt(random, enc_key, NULL, 0,
+							beacon + 14, 5,
+							beacon + 14, NULL, 8);
+		verify_data("BeaconMIC", 0, keys->beacon_cmac, beacon + 19, 8);
+		verify_data("PrivBeacon", 0, keys->beacon, beacon, 27);
+	}
 
 	l_info("");
 
+	l_free(random);
 	l_free(beacon_cmac);
 	l_free(net_key);
 }
@@ -2071,6 +2181,8 @@ int main(int argc, char *argv[])
 
 	/* Section 8.4 Beacon Sample Data */
 	check_beacon(&s8_4_3);
+	check_beacon(&s8_4_6_1);
+	check_beacon(&s8_4_6_2);
 
 	/* Section 8.6 Mesh Proxy Service sample data */
 	check_id_beacon(&s8_6_2);
-- 
2.39.1

