Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90464C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 May 2022 20:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385619AbiEEULW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 May 2022 16:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385641AbiEEULR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 May 2022 16:11:17 -0400
X-Greylist: delayed 1036 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 May 2022 13:07:33 PDT
Received: from finn.localdomain (finn.gateworks.com [108.161.129.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3C65F8CF
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 May 2022 13:07:33 -0700 (PDT)
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1nmhUL-00D2Yj-VY; Thu, 05 May 2022 19:50:14 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] Bluetooth: btbcm: Add entry for BCM4373A0 UART Bluetooth
Date:   Thu,  5 May 2022 12:50:10 -0700
Message-Id: <20220505195010.31329-1-tharvey@gateworks.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds the device ID for the BCM4373A0 module, found e.g. in
the Infineon (Cypress) CYW4373E chip. The required firmware file is
named 'BCM4373A0.hcd'.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/bluetooth/btbcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index d9ceca7a7935..ced0ad25ffc4 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -457,6 +457,7 @@ static const struct bcm_subver_table bcm_uart_subver_table[] = {
 	{ 0x6106, "BCM4359C0"	},	/* 003.001.006 */
 	{ 0x4106, "BCM4335A0"	},	/* 002.001.006 */
 	{ 0x410c, "BCM43430B0"	},	/* 002.001.012 */
+	{ 0x2119, "BCM4373A0"	},	/* 001.001.025 */
 	{ }
 };
 
-- 
2.17.1

