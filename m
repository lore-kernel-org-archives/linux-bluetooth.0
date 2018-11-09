Return-Path: <SRS0=dX+b=NU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA1EC43441
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Nov 2018 06:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 384B220883
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Nov 2018 06:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3EtHfrs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 384B220883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbeKIQWu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Nov 2018 11:22:50 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45294 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbeKIQWu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Nov 2018 11:22:50 -0500
Received: by mail-pg1-f196.google.com with SMTP id y4so431294pgc.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Nov 2018 22:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lnMiBQuaug1hmFz/PSTokFZxMHAp0G4VPqFOcwAUJ4s=;
        b=p3EtHfrsSEg3D9ye0QXoiN94EjaJKl+AJufzUFKTWMHwATU4WFDPp2HYwh/hSv/sh4
         9+esXUIuk4Mp+JaSnj631wlByvwT48xbvExYECBB0Cb2YL0qnUDG8jEMk5rg4d0KvvBU
         cBnXuhI4h60APVCHCY8Aesssg/n6+n8s3Dn7xnH1zsH+zJqQn8f3GnlD1UXQC16FBQzC
         HLhZty7hxCdjCq8+2aP0oah5vi2wdP1VtPLAzQIq8XeBfgqKvEj4d3I1fUuLG/EaKjVz
         e+9CBMLNZ83i+Q1DSsMHzi74i4LaI3EjHrjQSV/CVZ071vMhhKCMdIVHcJnlIR/AGaJT
         AmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lnMiBQuaug1hmFz/PSTokFZxMHAp0G4VPqFOcwAUJ4s=;
        b=JbbBiXDAvkVAbKItxjwiXeaEbGg9Wk32jUqFSaW4AGztVvFVn8dT2hrvGpx94iNro1
         PvFcTfQPhVtjcyfOz2L2J32BQnMRveFZoJcVZPTsfy5O1O0wnU7HGkIuAil4XVF6hQ+9
         MD2gaqTSa0qthcziJTVSIC1UED2lGRWbXU90id+SZ+pWB0mW00o/FaTSw7rd8TtlPSJc
         JBccqRnZ6MSX0PkqS6gWoLEPNgHEwIT01cB8xaDXQh7pcTJOum3aXHzimAuXJDFnCF4/
         b9ue7IjAGC0cNemC3AZf9D2z+S+MyEN3bZ1bXov9V4KZP0SFfR4F284yasMg5midSqX5
         JBvg==
X-Gm-Message-State: AGRZ1gLlC+sAbZHwWR4lHag46WxElrDFQXSdVZg7ty7HCe1Isfm7/IAy
        Cd2iOzFRjxflebqxyYWxxpNR4qX7ViM=
X-Google-Smtp-Source: AJdET5cUUEWkBzVdZsgMduM9P9HxRNa+Dky+8fGz91DDRBI9NqcMeW032zX8xoK285vQlSv9nnZEDw==
X-Received: by 2002:a62:d8c3:: with SMTP id e186-v6mr7968011pfg.52.1541745821850;
        Thu, 08 Nov 2018 22:43:41 -0800 (PST)
Received: from wcs0336-Latitude-E5440.iind.intel.com ([192.55.54.41])
        by smtp.gmail.com with ESMTPSA id c7-v6sm7006805pfh.25.2018.11.08.22.43.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Nov 2018 22:43:41 -0800 (PST)
From:   Jaganath Kanakkassery <jaganath.k.os@gmail.com>
X-Google-Original-From: Jaganath Kanakkassery <jaganath.kanakkassery@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Jaganath Kanakkassery <jaganath.kanakkassery@intel.com>
Subject: [PATCH v2 BlueZ] btmgmt: Add BREDR PHYs in PHY Configuration commands
Date:   Fri,  9 Nov 2018 12:07:09 +0530
Message-Id: <1541745429-13105-1-git-send-email-jaganath.kanakkassery@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This basically adds BREDR packet types also in the PHY confiuration
commands & events and makes the PHYs 32 bit so that it can be
extended in future. This also add configurable PHYs in the GetPhy
command wherein only those can be selected or deselected in SetPhy.

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

