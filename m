Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6C7C5320B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Jan 2023 19:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbjATTro (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Jan 2023 14:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjATTrn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Jan 2023 14:47:43 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA89BB96
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jan 2023 11:47:42 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id g23so6212259plq.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jan 2023 11:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xihyoGLoq4NizzNVJflJU/DJRtaNJSSHtGzJsHcSm7U=;
        b=PplDpcfkT8FwQuW7psvprXEvMb6rO51YSWWvqmIseq3AnoSo0RFZJY//TI8lzN1PKu
         az9vaLxnifzetOOq7b5sGCfA4UaYwbXOOspwXWPMAZUNYvDTGum39FkVn5T4pma0xtQ8
         PoywmbxfnPZ1Asw+MzZE2bGJhsWMyauREbTvS57MSKQ3PiWDcyyM+TVNDiWYMiilwOxc
         +sJDxDPEASfpCa2rBswzRJbFtbWjvnHoDZwOSFPjivKXpbXTWg1FRaZGWDs0xozvEr9L
         gIRIls1+ltFq6aYl6+bZki9d5ojNLVOcBsyba2PdRnFxnGj9/dPy49zraSjiDGymlpkE
         8Seg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xihyoGLoq4NizzNVJflJU/DJRtaNJSSHtGzJsHcSm7U=;
        b=0OJnRUNT8FbccVvZoIb+pTcwv7ia21YDmQoQYWuAXjMsj86dzh7QqgMRBmKbANN1Lj
         wwFqUgp/UdBdy1lSzv4XYd1wVFaligcbQPETqElp49msxfyosiDuX3/dqGLlST7HspQE
         1HdmtH689hhfegeoB9pl2xecY919vYz3H9pIiMZa7bxhDqs3tyzxGy8J6t8BhXLXfWeb
         9yWBcYglVctCp+Pvfh9iKHIVccYABgK++3qe+MtdbaQhuVv0+tdbFiv/dTj4tS2Sboxn
         4V4VPL3RSnIUV2OlkMlleivGv4Epkjkr0ik40IVDWJyfwssbMq/T4nfljk2pCGpGjayu
         S92A==
X-Gm-Message-State: AFqh2kpLt2pgEvYr0qg1rngLAR5xQFf92Np9gT4LFtQyfxVrAqeDlDt2
        LyQBOu0jqXmSusM0xvzcFJKT4Aup5CUBWw==
X-Google-Smtp-Source: AMrXdXuSlTqSQ+l4+r7ZE9aspD2Blal9hlFcNT97Jfa4VO1bsEaC+Bu2ss5s4wSNi92oU6tm2MOomA==
X-Received: by 2002:a17:903:186:b0:194:7ba1:938 with SMTP id z6-20020a170903018600b001947ba10938mr36686995plg.65.1674244061112;
        Fri, 20 Jan 2023 11:47:41 -0800 (PST)
Received: from fedora.. (174-21-24-126.tukw.qwest.net. [174.21.24.126])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090322cd00b001896af10ca7sm5149967plg.134.2023.01.20.11.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 11:47:40 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ v2 05/11] unit/mesh:  Add unit testing of Mesh Private Beaconing
Date:   Fri, 20 Jan 2023 11:47:25 -0800
Message-Id: <20230120194731.90065-6-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230120194731.90065-1-brian.gix@gmail.com>
References: <20230120194731.90065-1-brian.gix@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Brian Gix <brian.gix@intel.com>

This includes the Sample Data from the Mesh Profile specification v1.1,
and validates that the beacon crypto functions work as expected.
---
 unit/test-mesh-crypto.c | 100 +++++++++++++++++++++++++++++++---------
 1 file changed, 79 insertions(+), 21 deletions(-)

diff --git a/unit/test-mesh-crypto.c b/unit/test-mesh-crypto.c
index f9b7d81da..ff6e653a7 100644
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
 
@@ -926,7 +956,7 @@ static void check_encrypt(const struct mesh_crypto_test *keys)
 	uint8_t *dev_key;
 	uint8_t *app_key;
 	uint8_t *net_key;
-	uint8_t nid;
+	uint8_t nid = 0;
 	uint8_t enc_key[16];
 	uint8_t priv_key[16];
 	uint8_t net_nonce[13];
@@ -960,8 +990,7 @@ static void check_encrypt(const struct mesh_crypto_test *keys)
 
 	show_data("NetworkKey", 0, net_key, 16);
 
-	if (keys->akf) {
-		mesh_crypto_k4(app_key, &key_aid);
+	if (keys->akf && mesh_crypto_k4(app_key, &key_aid)) {
 		key_aid |= KEY_ID_AKF;
 	} else {
 		key_aid = 0;
@@ -1265,7 +1294,8 @@ static void check_decrypt_segment(const struct mesh_crypto_test *keys,
 	uint8_t net_clr[29];
 	uint64_t net_mic64, calc_net_mic64;
 	uint32_t hdr, net_mic32, calc_net_mic32;
-	bool ctl, segmented, relay, szmic, key_akf;
+	bool ctl = false;
+	bool  segmented, relay, szmic, key_akf;
 	uint8_t ttl, opcode, key_aid, segO, segN;
 	uint32_t seq;
 	uint16_t src, dst, seqZero;
@@ -1416,7 +1446,8 @@ static void check_decrypt(const struct mesh_crypto_test *keys)
 	uint16_t app_msg_len = 0;
 	uint32_t calc_net_mic32, net_mic32 = 0;
 	uint64_t calc_net_mic64, net_mic64 = 0;
-	bool net_ctl, net_segmented, net_rly, net_akf;
+	bool net_ctl = false;
+	bool net_segmented, net_rly, net_akf;
 	uint8_t net_aid, net_ttl, nid, net_segO, net_segN = 0;
 	uint32_t net_seq, hdr, seqZero = 0;
 	uint16_t net_src, net_dst;
@@ -1731,42 +1762,67 @@ static void check_beacon(const struct mesh_crypto_test *keys)
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
+		beacon[14] = keys->beacon_flags;
+		l_put_be32(keys->iv_index, beacon + 15);
+		mesh_crypto_aes_ccm_encrypt(random, enc_key, NULL, 0,
+							beacon + 14, 5,
+							beacon + 14, NULL, 8);
+		memcpy(beacon + 1, random, 13);
+		verify_data("BeaconMIC", 0, keys->beacon_cmac, beacon + 19, 8);
+		verify_data("PrivBeacon", 0, keys->beacon, beacon, 27);
+	}
 
 	l_info("");
 
+	l_free(random);
 	l_free(beacon_cmac);
 	l_free(net_key);
 }
@@ -2071,6 +2127,8 @@ int main(int argc, char *argv[])
 
 	/* Section 8.4 Beacon Sample Data */
 	check_beacon(&s8_4_3);
+	check_beacon(&s8_4_6_1);
+	check_beacon(&s8_4_6_2);
 
 	/* Section 8.6 Mesh Proxy Service sample data */
 	check_id_beacon(&s8_6_2);
-- 
2.39.0

