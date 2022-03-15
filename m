Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B744C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Mar 2022 09:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243962AbiCOJxA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Mar 2022 05:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239448AbiCOJw7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Mar 2022 05:52:59 -0400
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13ACA4F45B
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Mar 2022 02:51:46 -0700 (PDT)
X-QQ-mid: bizesmtp90t1647337897tiinsj2l
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 15 Mar 2022 17:51:31 +0800 (CST)
X-QQ-SSF: 01400000002000D0H000B00A0000000
X-QQ-FEAT: Mzskoac49OhYKIdzJedMNQcLV79ZiXzWAmUbFs9mZ40dgHWSdAWqId88qn+ci
        1cgZrdmoJzPnX/zN6aUKOkGsiYlpnE4QiwZ3BPkDi2O+REGcasT9B6Z82Q7JC2k8+luc/R4
        2KeEom0gCLV56l30KUgqnmoRtnHeVp+t1kv7DHwUe3Q5wVvQKBk2mceB9gFRLpR2qMrFk0k
        2pqhFtymVIgo5rd9RuRt8sAKTOeP8YIA79Jjlj3QiKceuF1HxEHkTah7Sdo2YPyxE9idHNX
        B9ou3REBJ4OjynvEDoRhXGPoA2bvFmJyNxV3l2cA77ef2pQz+1bGyJCMT1+l0epk46LB0Ib
        GD7UNzGp4aJbQKJ3XMLJa57EJEJFsUpTZcWvWSL
X-QQ-GoodBg: 2
From:   Meng Tang <tangmeng@uniontech.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     martin.blumenstingl@googlemail.com,
        linux-bluetooth@vger.kernel.org, Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH v3 1/2] Bluetooth: btrtl: btmrvl: Fix firmware filename for rtl8723bs chipset
Date:   Tue, 15 Mar 2022 17:51:28 +0800
Message-Id: <20220315095129.15254-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Firmware for rtl8723bs chipset is as part of the linux-firmware
repository in filename rtl8723bs_config-OBDA8723.bin.

This patch fixes mwifiex driver to load correct firmware file for
rtl8723bs.

Fixes: c50903e3ee1b5 (Bluetooth: btrtl: add support for the RTL8723BS and RTL8723DS chips)

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 drivers/bluetooth/btrtl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index c2030f7e25b4..449858b65e8e 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -88,7 +88,7 @@ static const struct id_table ic_id_table[] = {
 	  .config_needed = true,
 	  .has_rom_version = true,
 	  .fw_name  = "rtl_bt/rtl8723bs_fw.bin",
-	  .cfg_name = "rtl_bt/rtl8723bs_config" },
+	  .cfg_name = "rtl_bt/rtl8723bs_config-OBDA8723" },
 
 	/* 8723B */
 	{ IC_INFO(RTL_ROM_LMP_8723B, 0xb, 0x6, HCI_USB),
@@ -923,7 +923,7 @@ MODULE_FIRMWARE("rtl_bt/rtl8723a_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723b_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723b_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723bs_fw.bin");
-MODULE_FIRMWARE("rtl_bt/rtl8723bs_config.bin");
+MODULE_FIRMWARE("rtl_bt/rtl8723bs_config-OBDA8723.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723ds_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723ds_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8761a_fw.bin");
-- 
2.20.1



