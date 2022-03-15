Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AACC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 15 Mar 2022 09:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346724AbiCOJxh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 15 Mar 2022 05:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346719AbiCOJxf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 15 Mar 2022 05:53:35 -0400
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8264F45B
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Mar 2022 02:52:23 -0700 (PDT)
X-QQ-mid: bizesmtp90t1647337913tmnd84bi
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 15 Mar 2022 17:51:39 +0800 (CST)
X-QQ-SSF: 01400000002000D0H000B00A0000000
X-QQ-FEAT: Mzskoac49Oj6w5+UYV3oqZVb/U2XFB1ApMF8/taX6Z6lrTuuaioY7ytSdmbkA
        RnSbsPPRxP2MGLG/r9Qms0lb4Dk/N/g4WZ/E7ruIYLO4oFamswG7TA2elUUI2T0yOvAm87h
        00SYyJ0G373WLSiVtbRw2nhLFEd4CVXMIGaV2j5nATfcMFYQQ1JmZ4xsmu8Jbh1CCYK8KJc
        rrU1E/6fJn8f0wbZrWSppRt6HhqQoxeNpZk7p3BcDJgqTypxEnnrVX20LzmhEliCnyFgKLl
        KYXr5/cskB/fGe+jLtoTyqQn/6v69Ggfzaw4YFPPy30szeR9D4+2oR68RwOAGdSFYTs4X+u
        n5UdiK5fJWkEbrCgXgM6rhc9s02k6/yGqviRNqO
X-QQ-GoodBg: 2
From:   Meng Tang <tangmeng@uniontech.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     martin.blumenstingl@googlemail.com,
        linux-bluetooth@vger.kernel.org, Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH v3 2/2] Bluetooth: btrtl: btmrvl: Fix firmware filename for some rtl chipsets
Date:   Tue, 15 Mar 2022 17:51:29 +0800
Message-Id: <20220315095129.15254-2-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220315095129.15254-1-tangmeng@uniontech.com>
References: <20220315095129.15254-1-tangmeng@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign7
X-QQ-Bgrelay: 1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Firmware for rtl chipset is as part of the linux-firmware repository
in dir linux-firmware/rtl_bt. Today, the rtl8761a_config,
rtl8821a_config and rtl8723b_config files are used in btrtl, but it
doesn't actually exist, which causes errors like:

bluetooth: Direct firmware load for rtl_bt/rtl8821a_config.bin
failed with error -2

According to the files in the rtl_bt directory in the Linux firmware,
fixes the driver to load correct firmware file for rtl.

Fixes: f96dbd322a8f1 (Bluetooth: btrtl: add MODULE_FIRMWARE declarations)
Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 drivers/bluetooth/btrtl.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 449858b65e8e..56cec18475f7 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -921,15 +921,12 @@ MODULE_VERSION(VERSION);
 MODULE_LICENSE("GPL");
 MODULE_FIRMWARE("rtl_bt/rtl8723a_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723b_fw.bin");
-MODULE_FIRMWARE("rtl_bt/rtl8723b_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723bs_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723bs_config-OBDA8723.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723ds_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8723ds_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8761a_fw.bin");
-MODULE_FIRMWARE("rtl_bt/rtl8761a_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8821a_fw.bin");
-MODULE_FIRMWARE("rtl_bt/rtl8821a_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8822b_fw.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8822b_config.bin");
 MODULE_FIRMWARE("rtl_bt/rtl8852au_fw.bin");
-- 
2.20.1



