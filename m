Return-Path: <SRS0=5QOG=NF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773EDC46475
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Oct 2018 08:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E8C92075D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Oct 2018 08:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jz9UiyoZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E8C92075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbeJYRHw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Oct 2018 13:07:52 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:35881 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbeJYRHw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Oct 2018 13:07:52 -0400
Received: by mail-pf1-f180.google.com with SMTP id l81-v6so3828511pfg.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Oct 2018 01:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LsX2VCg/lNnaPaHbIIug4VGLxiCXfAOJxoVcIdgVME4=;
        b=Jz9UiyoZx2QwUORBYyxLSq4Q97Ncobp9r+jRd+J1PEEv5TS1oYn2MyNN9v6GX/psa5
         GiTWPVQZa3OYQD1mSBRvqV47mpT3RkEcfQDz4SzqcNLIyY73vXG3a2kW+DMqRxv39G21
         9ZxxWbdzNh3ldmcAmcnyrJOcPbvRjzBGVtC39RUaOG5oSu+VyD7XL2lJlTQSorPc4hVA
         mnHS9wk5Pvq9ctargPGs/txIRP9x9TZ5Cw8Me0oOXiqnvvnyQ27jVxx7idT3d9G09S7h
         7KzTtGo5JEizHxJuXsd+YqWAFNHCl0R/f0XCtTrlSaUqBBhWryWrJ+OnDZwgY2Fd103w
         E/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LsX2VCg/lNnaPaHbIIug4VGLxiCXfAOJxoVcIdgVME4=;
        b=dSYjqqIv2Cfp5hv7gaIkx0fm79INk2dB6iSWIXSVZUAynN0kdlBfPfK3w8Zt8afRx8
         2JLyrH7P+nTgl5zpiI/WrwsQNZtBBOsBfDqgOqbx+0NYNwqKCH5TWjCYzWWbw9cLxO+t
         davPiLzMouZJmEJnDhoMLCuU/Ki8lf1OQwv+C3TcwgZsjS278jN8eB+K/PqizuN6Xr4w
         gfluMv1QQZjo0mZIFM7uZneP8Uhr4+p3lo8w30bTF1OOFPeei6znudZlYWfxgqU06jKI
         mc+eK9thowHC5lRnHvEZREsCekKrgknIMCRF39qHPcXXXGwFL4BaGOiQemKgkXLcdctI
         TeNQ==
X-Gm-Message-State: AGRZ1gK60bLfiNEJTRqqnmQ8BiaSA+ZjI7Gft3CINURaldlkwgobrC0M
        EFXavOXfB//rFVxxyels60psm3aGpkE=
X-Google-Smtp-Source: AJdET5fuIykMsUfLrUuIUnys0h2uUmKVI0bEMLfNCK/44HIr8yRapKXhm8QToUJ12ZphOsz5WxVoiA==
X-Received: by 2002:a63:b90a:: with SMTP id z10-v6mr589108pge.221.1540456566804;
        Thu, 25 Oct 2018 01:36:06 -0700 (PDT)
Received: from wcs0336-Latitude-E5440.iind.intel.com ([192.55.54.40])
        by smtp.gmail.com with ESMTPSA id v19-v6sm8619585pgl.80.2018.10.25.01.36.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Oct 2018 01:36:06 -0700 (PDT)
From:   Jaganath Kanakkassery <jaganath.k.os@gmail.com>
X-Google-Original-From: Jaganath Kanakkassery <jaganath.kanakkassery@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Jaganath Kanakkassery <jaganath.kanakkassery@intel.com>
Subject: [PATCH v1] btmgmt: Add BREDR PHYs in PHY Configuration commands
Date:   Thu, 25 Oct 2018 13:59:54 +0530
Message-Id: <1540456194-26031-1-git-send-email-jaganath.kanakkassery@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This also adds LE prefix for LE phys to make it more
descriptive
---
 lib/mgmt.h     | 32 ++++++++++++++++---------
 tools/btmgmt.c | 75 ++++++++++++++++++++++++++++++++++------------------------
 2 files changed, 65 insertions(+), 42 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index ec6a380..570dec9 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -552,16 +552,26 @@ struct mgmt_cp_set_appearance {
 
 #define MGMT_OP_GET_PHY_CONFIGURATION	0x0044
 struct mgmt_rp_get_phy_confguration {
-	uint16_t	supported_phys;
-	uint16_t	selected_phys;
-} __packed;
-
-#define MGMT_PHY_LE_1M_TX		0x0001
-#define MGMT_PHY_LE_1M_RX		0x0002
-#define MGMT_PHY_LE_2M_TX		0x0004
-#define MGMT_PHY_LE_2M_RX		0x0008
-#define MGMT_PHY_LE_CODED_TX		0x0010
-#define MGMT_PHY_LE_CODED_RX		0x0020
+	uint32_t	supported_phys;
+	uint32_t	configurable_phys;
+	uint32_t	selected_phys;
+} __packed;
+
+#define MGMT_PHY_BR_1M_1SLOT	0x00000001
+#define MGMT_PHY_BR_1M_3SLOT	0x00000002
+#define MGMT_PHY_BR_1M_5SLOT	0x00000004
+#define MGMT_PHY_EDR_2M_1SLOT	0x00000008
+#define MGMT_PHY_EDR_2M_3SLOT	0x00000010
+#define MGMT_PHY_EDR_2M_5SLOT	0x00000020
+#define MGMT_PHY_EDR_3M_1SLOT	0x00000040
+#define MGMT_PHY_EDR_3M_3SLOT	0x00000080
+#define MGMT_PHY_EDR_3M_5SLOT	0x00000100
+#define MGMT_PHY_LE_1M_TX		0x00000200
+#define MGMT_PHY_LE_1M_RX		0x00000400
+#define MGMT_PHY_LE_2M_TX		0x00000800
+#define MGMT_PHY_LE_2M_RX		0x00001000
+#define MGMT_PHY_LE_CODED_TX	0x00002000
+#define MGMT_PHY_LE_CODED_RX	0x00004000
 
 #define MGMT_PHY_LE_TX_MASK (MGMT_PHY_LE_1M_TX | MGMT_PHY_LE_2M_TX | \
 			     MGMT_PHY_LE_CODED_TX)
@@ -570,7 +580,7 @@ struct mgmt_rp_get_phy_confguration {
 
 #define MGMT_OP_SET_PHY_CONFIGURATION	0x0045
 struct mgmt_cp_set_phy_confguration {
-	uint16_t	default_phys;
+	uint32_t	selected_phys;
 } __packed;
 
 
diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 9e3a3ca..6922f3d 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -4181,15 +4181,24 @@ static void cmd_appearance(int argc, char **argv)
 }
 
 static const char *phys_str[] = {
-	"1MTX",
-	"1MRX",
-	"2MTX",
-	"2MRX",
-	"CODEDTX",
-	"CODEDRX",
+	"BR1M1SLOT",
+	"BR1M3SLOT",
+	"BR1M5SLOT",
+	"EDR2M1SLOT",
+	"EDR2M3SLOT",
+	"EDR2M5SLOT",
+	"EDR3M1SLOT",
+	"EDR3M3SLOT",
+	"EDR3M5SLOT",
+	"LE1MTX",
+	"LE1MRX",
+	"LE2MTX",
+	"LE2MRX",
+	"LECODEDTX",
+	"LECODEDRX",
 };
 
-static const char *phys2str(uint16_t phys)
+static const char *phys2str(uint32_t phys)
 {
 	static char str[256];
 	unsigned int i;
@@ -4207,11 +4216,25 @@ static const char *phys2str(uint16_t phys)
 	return str;
 }
 
+static bool str2phy(const char *phy_str, uint32_t *phy_val)
+{
+	unsigned int i;
+
+	for (i = 0; i < NELEM(phys_str); i++) {
+		if (strcasecmp(phys_str[i], phy_str) == 0) {
+			*phy_val = (1 << i);
+			return true;
+		}
+	}
+
+	return false;
+}
+
 static void get_phy_rsp(uint8_t status, uint16_t len, const void *param,
 							void *user_data)
 {
 	const struct mgmt_rp_get_phy_confguration *rp = param;
-	uint16_t supported_flags, selected_phys;
+	uint32_t supported_phys, selected_phys, configurable_phys;
 
 	if (status != 0) {
 		error("Get PHY Configuration failed with status 0x%02x (%s)",
@@ -4224,10 +4247,12 @@ static void get_phy_rsp(uint8_t status, uint16_t len, const void *param,
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	supported_flags = get_le16(&rp->supported_phys);
-	selected_phys = get_le16(&rp->selected_phys);
+	supported_phys = get_le32(&rp->supported_phys);
+	configurable_phys = get_le32(&rp->configurable_phys);
+	selected_phys = get_le32(&rp->selected_phys);
 
-	print("Supported phys: %s", phys2str(supported_flags));
+	print("Supported phys: %s", phys2str(supported_phys));
+	print("Configurable phys: %s", phys2str(configurable_phys));
 	print("Selected phys: %s", phys2str(selected_phys));
 
 	bt_shell_noninteractive_quit(EXIT_SUCCESS);
@@ -4266,33 +4291,20 @@ static void cmd_phy(int argc, char **argv)
 {
 	struct mgmt_cp_set_phy_confguration cp;
 	int i;
-	uint16_t phys = 0;
+	uint32_t phys = 0;
 	uint16_t index;
 
 	if (argc < 2)
 		return get_phy();
 
 	for (i = 1; i < argc; i++) {
-		if (strcasecmp(argv[i], "1MTX") == 0)
-			phys |= MGMT_PHY_LE_1M_TX;
-
-		if (strcasecmp(argv[i], "1MRX") == 0)
-			phys |= MGMT_PHY_LE_1M_RX;
-
-		if (strcasecmp(argv[i], "2MTX") == 0)
-			phys |= MGMT_PHY_LE_2M_TX;
-
-		if (strcasecmp(argv[i], "2MRX") == 0)
-			phys |= MGMT_PHY_LE_2M_RX;
-
-		if (strcasecmp(argv[i], "CODEDTX") == 0)
-			phys |= MGMT_PHY_LE_CODED_TX;
+		uint32_t phy_val;
 
-		if (strcasecmp(argv[i], "CODEDRX") == 0)
-			phys |= MGMT_PHY_LE_CODED_RX;
+		if (str2phy(argv[i], &phy_val))
+			phys |= phy_val;
 	}
 
-	cp.default_phys = cpu_to_le16(phys);
+	cp.selected_phys = cpu_to_le32(phys);
 
 	index = mgmt_index;
 	if (index == MGMT_INDEX_NONE)
@@ -4501,8 +4513,9 @@ static const struct bt_shell_menu main_menu = {
 		cmd_clr_adv,		"Clear advertising instances"	},
 	{ "appearance",		"<appearance>",
 		cmd_appearance,		"Set appearance"		},
-	{ "phy",		"[1MTX] [1MRX] [2MTX] [2MRX] [CODEDTX] "
-				"[CODEDRX] [BR1M1SLOT] [BR1M3SLOT] [BR1M5SLOT]"
+	{ "phy",		"[LE1MTX] [LE1MRX] [LE2MTX] [LE2MRX] "
+				"[LECODEDTX] [LECODEDRX] "
+				"[BR1M1SLOT] [BR1M3SLOT] [BR1M5SLOT]"
 				"[EDR2M1SLOT] [EDR2M3SLOT] [EDR2M5SLOT]"
 				"[EDR3M1SLOT] [EDR3M3SLOT] [EDR3M5SLOT]",
 		cmd_phy,		"Get/Set PHY Configuration"	},
-- 
2.7.4

