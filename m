Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1EBC433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Feb 2021 14:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74FB564F72
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Feb 2021 14:30:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbhBCOaC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Feb 2021 09:30:02 -0500
Received: from m12-16.163.com ([220.181.12.16]:58431 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232317AbhBCOaB (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Feb 2021 09:30:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=V2te+EMxY7SONrR5Cm
        p3/3SCPAP5Bua2LJ16//K4GV8=; b=cVEYkNvyA6O0UChdPKdL7nyoF5Vpy3iRVr
        V9Yo9nrR/vWXEFDsuqzB+z5Y7Lq7TVkjS4U2LVuCz8FTn0Xa85i+8KnDCzd3680v
        VOYIGMlnzlhj+tcqbSKvPPxQKzgJWUKzOHkA8YR6wkYTYx2EB6XG0h6ASvEX2MeC
        n4lwRj2ws=
Received: from zhongjupeng.ccdomain.com (unknown [119.137.55.230])
        by smtp12 (Coremail) with SMTP id EMCowADHzlIUsxpgZuhTaQ--.13240S2;
        Wed, 03 Feb 2021 22:28:37 +0800 (CST)
From:   zjp734690220@163.com
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jupeng Zhong <zhongjupeng@yulong.com>
Subject: [PATCH v4] Bluetooth: btusb: Fix typo and correct the log print
Date:   Wed,  3 Feb 2021 22:28:46 +0800
Message-Id: <20210203142846.39648-1-zjp734690220@163.com>
X-Mailer: git-send-email 2.15.0.windows.1
X-CM-TRANSID: EMCowADHzlIUsxpgZuhTaQ--.13240S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KryDWw48Cw47Gw15tF1UWrg_yoW8JFWfpF
        ZxGFy5AryfGr47KF47A3yvy3y5Xa1qga42kFWUA3s8ZFW5t3y8CF4rJF98W34I9FZxWaya
        ka1DXrW0ga1kGF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jTlk3UUUUU=
X-Originating-IP: [119.137.55.230]
X-CM-SenderInfo: 52msljauwzijisq6il2tof0z/xtbCCw0uFF3LfC4GhAAAs6
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Jupeng Zhong <zhongjupeng@yulong.com>

Change "deivice" to "device"

Correct "Unsupported support hardware variant (%08x)" to
"Unsupported hardware variant (%08x)"

Signed-off-by: Jupeng Zhong <zhongjupeng@yulong.com>
---
v4: update bluetooth-next tree and regenerate the patch again
v3: update bluetooth-next tree and regenerate the patch
v2: correct the log print and update the patch From: and Signed-off-by:
---
 drivers/bluetooth/btusb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index eeafb8432c0f..154e1e76c317 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3631,7 +3631,7 @@ static int btusb_mtk_setup_firmware(struct hci_dev *hdev, const char *fwname)
 	while (fw_size > 0) {
 		dlen = min_t(int, 250, fw_size);
 
-		/* Tell deivice the position in sequence */
+		/* Tell device the position in sequence */
 		if (fw_size - dlen <= 0)
 			flag = 3;
 		else if (fw_size < fw->size - 30)
@@ -3790,7 +3790,7 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 		}
 		goto done;
 	default:
-		bt_dev_err(hdev, "Unsupported support hardware variant (%08x)",
+		bt_dev_err(hdev, "Unsupported hardware variant (%08x)",
 			   dev_id);
 		return -ENODEV;
 	}
-- 
1.9.1


