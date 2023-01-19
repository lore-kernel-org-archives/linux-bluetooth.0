Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6280DC6379F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Jan 2023 23:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjASX6R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Jan 2023 18:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjASX6P (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Jan 2023 18:58:15 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2459F3BE
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jan 2023 15:58:09 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id lp10so615132pjb.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jan 2023 15:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08CrBAafLslfGPyiK/2T0o4lZBM7Wi0H+qTwkhmyjWU=;
        b=pOKgL0pHXi4ZMJrazSPF+bBj7qn8b0BH3XGnbKkBybOouDTuAe6mF11C3w/U77U3AJ
         2o6rAvXL/XJqcOfGe3OsCdQ1PiUAIUGVYkpTAQDEnsFUDZyLpV2ZqlItUak2XX+yQl7w
         CWRtnr6pB2axNJ1Vda/IaN7JREFS8XYsfIE0a3FGKqTm8XmFHPb6z7u+ZYaMfCGP06Lz
         appayVfaZ9gB2qoHtsigKOZLD1fyYmA9q0tVBAe1Ycdmt6SMFKTirzyDCFp/dUGSiBlK
         KGn7/KPHKcp1xDuFVGrJ8MZ3wH/TmAwf7Pv28DOrPGs7gyi3M86oNMelQDNE2Rv+lB8d
         mc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=08CrBAafLslfGPyiK/2T0o4lZBM7Wi0H+qTwkhmyjWU=;
        b=1zKUWoEEoVSZSpJ0yLnPZiSgnPDbIO4hv/gsliqdm9jUrG0zVmVPRXzc1Of5t4Ty70
         wo0To7+u26uDU4BsXYQ9gKGFcpXeTWDvWh2ZvTD79tT505n00zLFFURp3fu23RGrOVQ2
         C+q0KgPBlWa0/mNO9y7IkkBmW8aPpEjZAJinP3ZN1W/bx6/8zcJyNB/HC6BjgzWL5+qY
         TfZH5+tzCnASrJyXFlBTjSrO6D8wkxvbi168Lfb74uYR9IK2nJXs1MMhbxslYPHp4CNc
         oAcg7tiQjy4rYwJUUFH4jBBslMCLXDis8wrZU9UeRNRPDxYZib5m9l8cETxm75RNgAc+
         IK+A==
X-Gm-Message-State: AFqh2kq6GB7lnujXDYmnJdx2kJOFcaUsuijKCZCaQJ0RryYvuQ5Dy46A
        XapgdLaTVd4j4ZHfyNtO45EnLLpV23VfTQ==
X-Google-Smtp-Source: AMrXdXu4C2m9mI77pVyOTncWy2rg5LZRdlo3XRVeHY4bRdRm4vp1ZwFExlAUgw2LGSAE+mPPDbXw5A==
X-Received: by 2002:a17:902:d706:b0:193:2c1b:3367 with SMTP id w6-20020a170902d70600b001932c1b3367mr13429556ply.1.1674172688245;
        Thu, 19 Jan 2023 15:58:08 -0800 (PST)
Received: from fedora.. (97-113-173-242.tukw.qwest.net. [97.113.173.242])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902d2ca00b0019460c34839sm14826373plc.185.2023.01.19.15.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 15:58:07 -0800 (PST)
From:   Brian Gix <brian.gix@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Brian Gix <brian.gix@intel.com>
Subject: [PATCH BlueZ 05/12] unit/mesh:  Add unit testing of Mesh Private Beaconing
Date:   Thu, 19 Jan 2023 15:57:48 -0800
Message-Id: <20230119235755.46002-6-brian.gix@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230119235755.46002-1-brian.gix@gmail.com>
References: <20230119235755.46002-1-brian.gix@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Brian Gix <brian.gix@intel.com>

This includes the Sample Data from the Mesh Profile specification v1.1,
and validates that the beacon crypto functions work as expected.
---
 unit/test-mesh-crypto.c | 87 ++++++++++++++++++++++++++++++++++-------
 1 file changed, 72 insertions(+), 15 deletions(-)

diff --git a/unit/test-mesh-crypto.c b/unit/test-mesh-crypto.c
index f9b7d81da..86aa265a5 100644
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
 
@@ -1731,42 +1761,67 @@ static void check_beacon(const struct mesh_crypto_test *keys)
 {
 	uint8_t *net_key;
 	uint8_t *beacon_cmac;
-	uint8_t beacon[22];
+	uint8_t *random = NULL;
+	uint8_t beacon[29];
 	uint8_t enc_key[16];
 	uint8_t net_id[8];
 	uint8_t cmac[8];
 	uint64_t cmac_tmp;
 
+	if (keys->beacon_type < 1 || keys->beacon_type > 2)
+		verify_uint8("Unknown Beacon", 0, true,
+			(keys->beacon_type >= 1 || keys->beacon_type <= 2));
+
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
@@ -2071,6 +2126,8 @@ int main(int argc, char *argv[])
 
 	/* Section 8.4 Beacon Sample Data */
 	check_beacon(&s8_4_3);
+	check_beacon(&s8_4_6_1);
+	check_beacon(&s8_4_6_2);
 
 	/* Section 8.6 Mesh Proxy Service sample data */
 	check_id_beacon(&s8_6_2);
-- 
2.39.0

