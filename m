Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4E1C43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Jul 2022 15:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbiGSPm1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Jul 2022 11:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiGSPm1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Jul 2022 11:42:27 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B724D81C
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Jul 2022 08:42:21 -0700 (PDT)
X-QQ-mid: bizesmtp88t1658245334t9zrfico
Received: from localhost.localdomain ( [182.148.15.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 19 Jul 2022 23:41:49 +0800 (CST)
X-QQ-SSF: 01000000002000409000B00A0000000
X-QQ-FEAT: znfcQSa1hKZorq//bHkWyskKChlV1wLWMVzDa1lh95GkfRwtIyzjH7u4oUR7E
        G52KUgSUl2GPGI3EnqX1TCvmapqrApKeF8q0LkaXATO+lG7HnVgSLKhl0d/qfWz1d5sGBhl
        SbT65BMxUVRbZVzXICB+7Xdq+kr3DmXIFLhYGJDT8JKAigb7zeI9ud/5gbNgOMtOxRMkodP
        TMMU/A1CjiTbUpmIIFMyKgN3m6sv/2CIufHP00F3J2KJALPPv48tNi+uH2Rz1/40sE4t5PM
        TEOLFQv8VWf2LU0IAJPWVrvxOWUqW7Df5rnkfypdSVvriK3mvFCrQ7m79pdG3HUtDpUoCvv
        P4mZJZ/uScnNl/BS6qOTJ/JlU9F7aWVdmY+vgI5o1Gg6rmDdZKTji3p7OeM7I8rEbAmINX3
X-QQ-GoodBg: 0
From:   shaomin Deng <dengshaomin@cdjrlc.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org
Cc:     shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] Bluetooth:btrtl:Fix typo in comment
Date:   Tue, 19 Jul 2022 11:41:48 -0400
Message-Id: <20220719154148.16769-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Delete the repeated word "that" in comments.

Signed-off-by: shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/bluetooth/btrtl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 47c28fd8f006..fb52313a1d45 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -330,7 +330,7 @@ static int rtlbt_parse_firmware(struct hci_dev *hdev,
 	/* Loop from the end of the firmware parsing instructions, until
 	 * we find an instruction that identifies the "project ID" for the
 	 * hardware supported by this firwmare file.
-	 * Once we have that, we double-check that that project_id is suitable
+	 * Once we have that, we double-check that project_id is suitable
 	 * for the hardware we are working with.
 	 */
 	while (fwptr >= btrtl_dev->fw_data + (sizeof(*epatch_info) + 3)) {
-- 
2.35.1


