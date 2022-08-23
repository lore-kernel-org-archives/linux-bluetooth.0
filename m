Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 838E8C25B08
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Aug 2022 03:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240149AbiHWDlV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Aug 2022 23:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbiHWDlT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Aug 2022 23:41:19 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 661475B058;
        Mon, 22 Aug 2022 20:41:18 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id E37A61E80CE3;
        Tue, 23 Aug 2022 11:37:30 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id m13xGaTeu_Iz; Tue, 23 Aug 2022 11:37:28 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zhoujie@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 248401E80CBF;
        Tue, 23 Aug 2022 11:37:28 +0800 (CST)
From:   Zhou jie <zhoujie@nfschina.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhou jie <zhoujie@nfschina.com>
Subject: [PATCH] bluetooth/btbcm: Remove goto in btbcm_patchram function
Date:   Tue, 23 Aug 2022 11:41:10 +0800
Message-Id: <20220823034110.8295-1-zhoujie@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Remove the goto statement in the btbcm_patchram function to optimize
program execution efficiency.

Signed-off-by: Zhou jie <zhoujie@nfschina.com>
---
 drivers/bluetooth/btbcm.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index d9ceca7a7935..60827593ba36 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -175,7 +175,7 @@ int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw)
 		err = PTR_ERR(skb);
 		bt_dev_err(hdev, "BCM: Download Minidrv command failed (%d)",
 			   err);
-		goto done;
+		return err;
 	}
 	kfree_skb(skb);
 
@@ -194,8 +194,7 @@ int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw)
 
 		if (fw_size < cmd->plen) {
 			bt_dev_err(hdev, "BCM: Patch is corrupted");
-			err = -EINVAL;
-			goto done;
+			return -EINVAL;
 		}
 
 		cmd_param = fw_ptr;
@@ -210,7 +209,7 @@ int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw)
 			err = PTR_ERR(skb);
 			bt_dev_err(hdev, "BCM: Patch command %04x failed (%d)",
 				   opcode, err);
-			goto done;
+			return err;
 		}
 		kfree_skb(skb);
 	}
@@ -218,7 +217,6 @@ int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw)
 	/* 250 msec delay after Launch Ram completes */
 	msleep(250);
 
-done:
 	return err;
 }
 EXPORT_SYMBOL(btbcm_patchram);
-- 
2.18.2

