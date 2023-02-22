Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F7DC6379F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Feb 2023 09:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjBVJte (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Feb 2023 04:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjBVJtM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Feb 2023 04:49:12 -0500
Received: from out198-2.us.a.mail.aliyun.com (out198-2.us.a.mail.aliyun.com [47.90.198.2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797FB3BD85;
        Wed, 22 Feb 2023 01:46:56 -0800 (PST)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.4224786|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0415084-0.000958596-0.957533;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047205;MF=victor@allwinnertech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.RTl-qaj_1677059188;
Received: from SunxiBot.allwinnertech.com(mailfrom:victor@allwinnertech.com fp:SMTPD_---.RTl-qaj_1677059188)
          by smtp.aliyun-inc.com;
          Wed, 22 Feb 2023 17:46:29 +0800
From:   Victor Hassan <victor@allwinnertech.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND v2] Bluetooth: btrtl: Add support for RTL8852BS
Date:   Wed, 22 Feb 2023 17:47:20 +0800
Message-Id: <20230222094720.67185-1-victor@allwinnertech.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add the support for RTL8852BS BT controller on UART interface.
The necessary firmware file will be submitted to linux-firmware.

Signed-off-by: Victor Hassan <victor@allwinnertech.com>
---
 drivers/bluetooth/btrtl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 69c3fe649ca7..aee75f278e60 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -190,6 +190,14 @@ static const struct id_table ic_id_table[] = {
 	  .fw_name  = "rtl_bt/rtl8852au_fw.bin",
 	  .cfg_name = "rtl_bt/rtl8852au_config" },
 
+	/* 8852B with UART interface */
+	{ IC_INFO(RTL_ROM_LMP_8852A, 0xb, 0xb, HCI_UART),
+	  .config_needed = true,
+	  .has_rom_version = true,
+	  .has_msft_ext = true,
+	  .fw_name  = "rtl_bt/rtl8852bs_fw.bin",
+	  .cfg_name = "rtl_bt/rtl8852bs_config" },
+
 	/* 8852B */
 	{ IC_INFO(RTL_ROM_LMP_8852A, 0xb, 0xb, HCI_USB),
 	  .config_needed = false,
@@ -963,6 +971,8 @@ MODULE_FIRMWARE("rtl_bt/rtl8822b_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8822b_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852au_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852au_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8852bs_fw.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8852bs_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852bu_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852bu_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852cu_fw.bin");
-- 
2.29.0

