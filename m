Return-Path: <SRS0=3U9n=EK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C457C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 12:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D47A8223AB
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Nov 2020 12:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbgKDME3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Nov 2020 07:04:29 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:39303 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbgKDME2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Nov 2020 07:04:28 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 0A4C4IES0003516, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb01.realtek.com.tw[172.21.6.94])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 0A4C4IES0003516
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 4 Nov 2020 20:04:18 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.34) by
 RTEXMB01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Wed, 4 Nov 2020 20:04:18 +0800
Received: from localhost.localdomain (172.21.132.186) by
 RTEXMBS03.realtek.com.tw (172.21.6.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 4 Nov 2020 20:04:18 +0800
From:   <max.chou@realtek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alex_lu@realsil.com.cn>, <hildawu@realtek.com>
CC:     <kidman@realtek.com>, <max.chou@realtek.com>
Subject: [PATCH] Bluetooth: btrtl: Refine the ic_id_table for clearer and more regular
Date:   Wed, 4 Nov 2020 20:04:14 +0800
Message-ID: <20201104120414.12772-1-max.chou@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.132.186]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMBS03.realtek.com.tw (172.21.6.34)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Max Chou <max.chou@realtek.com>

Enhance the ic_id_table that it's able to maintain regularly.
To judge which chip should be initialized by LMP subversion, HCI revision,
 HCI version and HCI bus which were given in the ic_id_table.
Also, refine the incorrect LMP subversion of ROM for RTL8723D and
RTL8723A.

Suggested-by: Alex Lu <alex_lu@realsil.com.cn>
Signed-off-by: Max Chou <max.chou@realtek.com>
---
 drivers/bluetooth/btrtl.c | 65 ++++++++++++---------------------------
 1 file changed, 19 insertions(+), 46 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 3a9afc905f24..1ab9f27e4fa7 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -18,10 +18,8 @@
 #define VERSION "0.1"
 
 #define RTL_EPATCH_SIGNATURE	"Realtech"
-#define RTL_ROM_LMP_3499	0x3499
 #define RTL_ROM_LMP_8723A	0x1200
 #define RTL_ROM_LMP_8723B	0x8723
-#define RTL_ROM_LMP_8723D	0x8873
 #define RTL_ROM_LMP_8821A	0x8821
 #define RTL_ROM_LMP_8761A	0x8761
 #define RTL_ROM_LMP_8822B	0x8822
@@ -31,10 +29,13 @@
 #define IC_MATCH_FL_HCIREV	(1 << 1)
 #define IC_MATCH_FL_HCIVER	(1 << 2)
 #define IC_MATCH_FL_HCIBUS	(1 << 3)
-#define IC_INFO(lmps, hcir) \
-	.match_flags = IC_MATCH_FL_LMPSUBV | IC_MATCH_FL_HCIREV, \
+#define IC_INFO(lmps, hcir, hciv, bus) \
+	.match_flags = IC_MATCH_FL_LMPSUBV | IC_MATCH_FL_HCIREV | \
+		       IC_MATCH_FL_HCIVER | IC_MATCH_FL_HCIBUS, \
 	.lmp_subver = (lmps), \
-	.hci_rev = (hcir)
+	.hci_rev = (hcir), \
+	.hci_ver = (hciv), \
+	.hci_bus = (bus)
 
 struct id_table {
 	__u16 match_flags;
@@ -58,112 +59,85 @@ struct btrtl_device_info {
 };
 
 static const struct id_table ic_id_table[] = {
-	{ IC_MATCH_FL_LMPSUBV, RTL_ROM_LMP_8723A, 0x0,
-	  .config_needed = false,
-	  .has_rom_version = false,
-	  .fw_name = "rtl_bt/rtl8723a_fw.bin",
-	  .cfg_name = NULL },
-
-	{ IC_MATCH_FL_LMPSUBV, RTL_ROM_LMP_3499, 0x0,
+	/* 8723A */
+	{ IC_INFO(RTL_ROM_LMP_8723A, 0xb, 0x6, HCI_USB),
 	  .config_needed = false,
 	  .has_rom_version = false,
 	  .fw_name = "rtl_bt/rtl8723a_fw.bin",
 	  .cfg_name = NULL },
 
 	/* 8723BS */
-	{ .match_flags = IC_MATCH_FL_LMPSUBV | IC_MATCH_FL_HCIREV |
-			 IC_MATCH_FL_HCIVER | IC_MATCH_FL_HCIBUS,
-	  .lmp_subver = RTL_ROM_LMP_8723B,
-	  .hci_rev = 0xb,
-	  .hci_ver = 6,
-	  .hci_bus = HCI_UART,
+	{ IC_INFO(RTL_ROM_LMP_8723B, 0xb, 0x6, HCI_UART),
 	  .config_needed = true,
 	  .has_rom_version = true,
 	  .fw_name  = "rtl_bt/rtl8723bs_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8723bs_config" },
 
 	/* 8723B */
-	{ IC_INFO(RTL_ROM_LMP_8723B, 0xb),
+	{ IC_INFO(RTL_ROM_LMP_8723B, 0xb, 0x6, HCI_USB),
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .fw_name  = "rtl_bt/rtl8723b_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8723b_config" },
 
 	/* 8723D */
-	{ IC_INFO(RTL_ROM_LMP_8723B, 0xd),
+	{ IC_INFO(RTL_ROM_LMP_8723B, 0xd, 0x8, HCI_USB),
 	  .config_needed = true,
 	  .has_rom_version = true,
 	  .fw_name  = "rtl_bt/rtl8723d_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8723d_config" },
 
 	/* 8723DS */
-	{ .match_flags = IC_MATCH_FL_LMPSUBV | IC_MATCH_FL_HCIREV |
-			 IC_MATCH_FL_HCIVER | IC_MATCH_FL_HCIBUS,
-	  .lmp_subver = RTL_ROM_LMP_8723B,
-	  .hci_rev = 0xd,
-	  .hci_ver = 8,
-	  .hci_bus = HCI_UART,
+	{ IC_INFO(RTL_ROM_LMP_8723B, 0xd, 0x8, HCI_UART),
 	  .config_needed = true,
 	  .has_rom_version = true,
 	  .fw_name  = "rtl_bt/rtl8723ds_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8723ds_config" },
 
-	/* 8723DU */
-	{ IC_INFO(RTL_ROM_LMP_8723D, 0x826C),
-	  .config_needed = true,
-	  .has_rom_version = true,
-	  .fw_name  = "rtl_bt/rtl8723d_fw.bin",
-	  .cfg_name = "rtl_bt/rtl8723d_config" },
-
 	/* 8821A */
-	{ IC_INFO(RTL_ROM_LMP_8821A, 0xa),
+	{ IC_INFO(RTL_ROM_LMP_8821A, 0xa, 0x6, HCI_USB),
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .fw_name  = "rtl_bt/rtl8821a_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8821a_config" },
 
 	/* 8821C */
-	{ IC_INFO(RTL_ROM_LMP_8821A, 0xc),
+	{ IC_INFO(RTL_ROM_LMP_8821A, 0xc, 0x8, HCI_USB),
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .fw_name  = "rtl_bt/rtl8821c_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8821c_config" },
 
 	/* 8761A */
-	{ IC_INFO(RTL_ROM_LMP_8761A, 0xa),
+	{ IC_INFO(RTL_ROM_LMP_8761A, 0xa, 0x6, HCI_USB),
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .fw_name  = "rtl_bt/rtl8761a_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8761a_config" },
 
 	/* 8761B */
-	{ IC_INFO(RTL_ROM_LMP_8761A, 0xb),
+	{ IC_INFO(RTL_ROM_LMP_8761A, 0xb, 0xa, HCI_USB),
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .fw_name  = "rtl_bt/rtl8761b_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8761b_config" },
 
 	/* 8822C with UART interface */
-	{ .match_flags = IC_MATCH_FL_LMPSUBV | IC_MATCH_FL_HCIREV |
-			 IC_MATCH_FL_HCIBUS,
-	  .lmp_subver = RTL_ROM_LMP_8822B,
-	  .hci_rev = 0x000c,
-	  .hci_ver = 0x0a,
-	  .hci_bus = HCI_UART,
+	{ IC_INFO(RTL_ROM_LMP_8822B, 0xc, 0xa, HCI_UART),
 	  .config_needed = true,
 	  .has_rom_version = true,
 	  .fw_name  = "rtl_bt/rtl8822cs_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8822cs_config" },
 
 	/* 8822C with USB interface */
-	{ IC_INFO(RTL_ROM_LMP_8822B, 0xc),
+	{ IC_INFO(RTL_ROM_LMP_8822B, 0xc, 0xa, HCI_USB),
 	  .config_needed = false,
 	  .has_rom_version = true,
 	  .fw_name  = "rtl_bt/rtl8822cu_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8822cu_config" },
 
 	/* 8822B */
-	{ IC_INFO(RTL_ROM_LMP_8822B, 0xb),
+	{ IC_INFO(RTL_ROM_LMP_8822B, 0xb, 0x7, HCI_USB),
 	  .config_needed = true,
 	  .has_rom_version = true,
 	  .fw_name  = "rtl_bt/rtl8822b_fw.bin",
@@ -654,7 +628,6 @@ int btrtl_download_firmware(struct hci_dev *hdev,
 
 	switch (btrtl_dev->ic_info->lmp_subver) {
 	case RTL_ROM_LMP_8723A:
-	case RTL_ROM_LMP_3499:
 		return btrtl_setup_rtl8723a(hdev, btrtl_dev);
 	case RTL_ROM_LMP_8723B:
 	case RTL_ROM_LMP_8821A:
-- 
2.17.1

