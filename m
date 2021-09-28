Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D028AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 18:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B09AA61352
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 18:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241498AbhI1SMe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Sep 2021 14:12:34 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:49123 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239306AbhI1SMd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Sep 2021 14:12:33 -0400
Received: from fedora.. (p5b3d2185.dip0.t-ipconnect.de [91.61.33.133])
        by mail.holtmann.org (Postfix) with ESMTPSA id 56939CECE1
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Sep 2021 20:10:52 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: btrtl: Set VsMsftOpCode based on device table
Date:   Tue, 28 Sep 2021 20:10:50 +0200
Message-Id: <20210928181050.47565-1-marcel@holtmann.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The device table already has the option to hold device specific details
and thus include the support for Microsoft extensions there as well.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btrtl.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 5a1090b7c69a..22b84405c257 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -59,6 +59,7 @@ struct id_table {
 	__u8 hci_bus;
 	bool config_needed;
 	bool has_rom_version;
+	bool has_msft_ext;
 	char *fw_name;
 	char *cfg_name;
 };
@@ -135,6 +136,7 @@ static const struct id_table ic_id_table[] = {
 	{ IC_INFO(RTL_ROM_LMP_8761A, 0xb, 0xa, HCI_UART),
 	  .config_needed = false,
 	  .has_rom_version = true,
+	  .has_msft_ext = true,
 	  .fw_name  = "rtl_bt/rtl8761b_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8761b_config" },
 
@@ -149,6 +151,7 @@ static const struct id_table ic_id_table[] = {
 	{ IC_INFO(RTL_ROM_LMP_8822B, 0xc, 0xa, HCI_UART),
 	  .config_needed = true,
 	  .has_rom_version = true,
+	  .has_msft_ext = true,
 	  .fw_name  = "rtl_bt/rtl8822cs_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8822cs_config" },
 
@@ -156,6 +159,7 @@ static const struct id_table ic_id_table[] = {
 	{ IC_INFO(RTL_ROM_LMP_8822B, 0xc, 0xa, HCI_USB),
 	  .config_needed = false,
 	  .has_rom_version = true,
+	  .has_msft_ext = true,
 	  .fw_name  = "rtl_bt/rtl8822cu_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8822cu_config" },
 
@@ -163,6 +167,7 @@ static const struct id_table ic_id_table[] = {
 	{ IC_INFO(RTL_ROM_LMP_8822B, 0xb, 0x7, HCI_USB),
 	  .config_needed = true,
 	  .has_rom_version = true,
+	  .has_msft_ext = true,
 	  .fw_name  = "rtl_bt/rtl8822b_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8822b_config" },
 
@@ -170,6 +175,7 @@ static const struct id_table ic_id_table[] = {
 	{ IC_INFO(RTL_ROM_LMP_8852A, 0xa, 0xb, HCI_USB),
 	  .config_needed = false,
 	  .has_rom_version = true,
+	  .has_msft_ext = true,
 	  .fw_name  = "rtl_bt/rtl8852au_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8852au_config" },
 	};
@@ -684,12 +690,8 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 	/* The following chips supports the Microsoft vendor extension,
 	 * therefore set the corresponding VsMsftOpCode.
 	 */
-	switch (lmp_subver) {
-	case RTL_ROM_LMP_8822B:
-	case RTL_ROM_LMP_8852A:
+	if (btrtl_dev->ic_info->has_msft_ext)
 		hci_set_msft_opcode(hdev, 0xFCF0);
-		break;
-	}
 
 	return btrtl_dev;
 
-- 
2.31.1

