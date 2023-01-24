Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E7AC61D97
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Jan 2023 20:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbjAXU0s (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Jan 2023 15:26:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233939AbjAXU0g (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Jan 2023 15:26:36 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD864F873
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jan 2023 12:26:26 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id u1-20020a17090a450100b0022936a63a21so19845742pjg.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Jan 2023 12:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+Vxc5Lmw2e5GfBn6S6D6mlWj+7LT2bzMAaPCIOWAtI=;
        b=XqJ04vXAeul/nBDRS9XVKW+z1QkFH8pyWLV3fZuFx1+9Wd00tFsaPG9wFbjhXCWTBS
         lMlz8u+myRI3wcG6zx6fGtHd9jGrVcPuR2V1Kdes5Yn8iXWwSKnXZwIRxcSO0TY/x1Ow
         Z4HRrIGNhoLgT5hsycX+6/kqQaqZWe5I+LhPi8zF0Kn+u2IL8LlNThvDD2MwoNW1NAZl
         cPcUuYe+ir2Xm0M0KMA7OnAeEANm7Z0Zn8Et/oKYRnge/HvOiv+FgTo5zII0ReSJMWc4
         /zAgruIweMbQQe2OM2GS/qPlVoJQPuDL6KRYhdWWTBDa8dyGoryqmf82qozWDNbaEtej
         Y4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+Vxc5Lmw2e5GfBn6S6D6mlWj+7LT2bzMAaPCIOWAtI=;
        b=ZIhCt1SNOBKgBy0U8hlmZ9uc5MDAGwpbIzxK/MakdQ0Y/DI0RzatgPGGyMphTR4nM/
         0Xgm/BW8LN3CUfehz69lje5gH6U/cXcx2lYVMnhBFvIPV+u6IzXmRqzrzlb1w7PGIkUu
         W21xZYvl55A6OSQ/YVwTVW6GX1inB6KCP5Yv3aBI6l5Wb7zCUGf4ZRCRY5jZ5hun6y+v
         5kK9WYMKhwLEUZWlT7NDCfJBla0xwdpuy6Ds3nBe+eK9yr1MhwgZfTb6uT5SxRyRojV6
         duniixedwGAaqOWpv7BevUvOQhmHaaBCR7lybo3f/eu0o8tsNACz22SwR0Pe0W7ur5HR
         gLag==
X-Gm-Message-State: AFqh2kq6OiCiEatQoYzLlfhPcnK49qXHmlJeyKGkclFAHUt8xuLrPQdp
        yt+LzhvW9LXrxRIfGof7iQGO7w7FJfD3Cg==
X-Google-Smtp-Source: AMrXdXuNXxFr9IYV2umAc27l+8o0XEj84HeX4i3vfui1f6z2jyFT+ce11T5RNYHrYe9xmtoIJs4pKw==
X-Received: by 2002:a17:902:e751:b0:195:32b3:2604 with SMTP id p17-20020a170902e75100b0019532b32604mr24030576plf.5.1674591985186;
        Tue, 24 Jan 2023 12:26:25 -0800 (PST)
Received: from fedora.. (97-126-124-199.tukw.qwest.net. [97.126.124.199])
        by smtp.gmail.com with ESMTPSA id ju21-20020a170903429500b0019600b78487sm2108099plb.33.2023.01.24.12.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jan 2023 12:26:24 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ v4 05/13] unit/mesh:  Add unit testing of Mesh Private Beaconing
Date:   Tue, 24 Jan 2023 12:26:08 -0800
Message-Id: <20230124202616.310544-6-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230124202616.310544-1-brian.gix@gmail.com>
References: <20230124202616.310544-1-brian.gix@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Brian Gix <brian.gix@intel.com>

This includes the Sample Data from the Mesh Profile specification v1.1,
and validates that the beacon crypto functions work as expected.
---
 unit/test-mesh-crypto.c | 128 ++++++++++++++++++++++++++++++++--------
 1 file changed, 103 insertions(+), 25 deletions(-)

diff --git a/unit/test-mesh-crypto.c b/unit/test-mesh-crypto.c
index f9b7d81da..79add0c29 100644
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
@@ -926,7 +967,7 @@ static void check_encrypt(const struct mesh_crypto_test *keys)
 	uint8_t *dev_key;
 	uint8_t *app_key;
 	uint8_t *net_key;
-	uint8_t nid;
+	uint8_t nid = 0;
 	uint8_t enc_key[16];
 	uint8_t priv_key[16];
 	uint8_t net_nonce[13];
@@ -960,8 +1001,7 @@ static void check_encrypt(const struct mesh_crypto_test *keys)
 
 	show_data("NetworkKey", 0, net_key, 16);
 
-	if (keys->akf) {
-		mesh_crypto_k4(app_key, &key_aid);
+	if (keys->akf && mesh_crypto_k4(app_key, &key_aid)) {
 		key_aid |= KEY_ID_AKF;
 	} else {
 		key_aid = 0;
@@ -1265,19 +1305,20 @@ static void check_decrypt_segment(const struct mesh_crypto_test *keys,
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
@@ -1286,6 +1327,10 @@ static void check_decrypt_segment(const struct mesh_crypto_test *keys,
 			&segO, &segN,
 			&msg, &msg_len);
 
+	verify_bool("Crypto Decode-Parse", 0, true, status);
+	if (!status)
+		return;
+
 	if (ctl) {
 		net_mic64 = l_get_be64(pkt + pkt_len - 8);
 		show_data("EncryptedPayload", 7, pkt + 7, pkt_len - 7 - 8);
@@ -1416,7 +1461,7 @@ static void check_decrypt(const struct mesh_crypto_test *keys)
 	uint16_t app_msg_len = 0;
 	uint32_t calc_net_mic32, net_mic32 = 0;
 	uint64_t calc_net_mic64, net_mic64 = 0;
-	bool net_ctl, net_segmented, net_rly, net_akf;
+	bool net_ctl, net_segmented, net_rly, net_akf, status;
 	uint8_t net_aid, net_ttl, nid, net_segO, net_segN = 0;
 	uint32_t net_seq, hdr, seqZero = 0;
 	uint16_t net_src, net_dst;
@@ -1501,8 +1546,14 @@ static void check_decrypt(const struct mesh_crypto_test *keys)
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
 
@@ -1731,42 +1782,67 @@ static void check_beacon(const struct mesh_crypto_test *keys)
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
@@ -2071,6 +2147,8 @@ int main(int argc, char *argv[])
 
 	/* Section 8.4 Beacon Sample Data */
 	check_beacon(&s8_4_3);
+	check_beacon(&s8_4_6_1);
+	check_beacon(&s8_4_6_2);
 
 	/* Section 8.6 Mesh Proxy Service sample data */
 	check_id_beacon(&s8_6_2);
-- 
2.39.1

