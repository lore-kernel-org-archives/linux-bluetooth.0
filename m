Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2851C43334
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Jul 2022 14:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbiGTOK4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Jul 2022 10:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiGTOKz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Jul 2022 10:10:55 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FBD3AB27
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Jul 2022 07:10:48 -0700 (PDT)
X-QQ-mid: bizesmtp64t1658326237t3asgal3
Received: from localhost.localdomain ( [182.148.15.157])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 20 Jul 2022 22:10:34 +0800 (CST)
X-QQ-SSF: 01000000002000409000B00A0000000
X-QQ-FEAT: 3M0okmaRx3h3LaiaLjLG9iCaclxlrlQqIfk1pj0QVz7a7EASekiK1y303eWSg
        VuVicnWn2XCtqWMbPlsb0y/IRCGZQ7T7Ycb/ueg/IX2oNTYdHNP7pKTChtCxHIDcV4QJZgB
        j/d/SUTemG/vuna2D9Eg2F8a9B6O6aZ4So2VvjUD/mL8+VCDoyzqC1W4NvLiQu8UzYG/HZT
        fzxPdEJFyjv6PUC8Ha5CcdIeD1Cmf72rMtIwREsGN/dBYFQJsR8xsa+l3+UIViTN/WOwxpm
        uUU+HAjRPCzm/Yp11OWrsW8xCkiEyvgEe3yQZqCRFvMJ6tO7c4HR5RAdm1yltaN/Xuo+BDv
        QVfT6R+V7eKTaIgHHcWZSkx8XjS32YZcf/Mxrm5Dy5feQC/G0VsWKu0RELg1g==
X-QQ-GoodBg: 0
From:   shaomin Deng <dengshaomin@cdjrlc.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org
Cc:     shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] Bluetooth: btrtl: Fix typo in comment
Date:   Wed, 20 Jul 2022 10:10:33 -0400
Message-Id: <20220720141033.12521-1-dengshaomin@cdjrlc.com>
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


