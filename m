Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB252C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Sep 2021 07:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B854261056
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Sep 2021 07:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347620AbhICHRk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Sep 2021 03:17:40 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:38186 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234713AbhICHRj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Sep 2021 03:17:39 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0Un5.81V_1630653397;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0Un5.81V_1630653397)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 03 Sep 2021 15:16:38 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     marcel@holtmann.org
Cc:     johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] Bluetooth: btusb: Fix the application of sizeof to pointer
Date:   Fri,  3 Sep 2021 15:16:32 +0800
Message-Id: <1630653392-45523-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

sizeof() when applied to a pointer typed expression gives the size of
the pointer.

Clean up coccicheck warning:
./drivers/bluetooth/btusb.c:2210:36-42: ERROR: application of sizeof to
pointer

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/bluetooth/btusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 928cbfa..5bf479e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2207,7 +2207,7 @@ static int btusb_set_bdaddr_mtk(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 	struct sk_buff *skb;
 	long ret;
 
-	skb = __hci_cmd_sync(hdev, 0xfc1a, sizeof(bdaddr), bdaddr, HCI_INIT_TIMEOUT);
+	skb = __hci_cmd_sync(hdev, 0xfc1a, sizeof(*bdaddr), bdaddr, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		ret = PTR_ERR(skb);
 		bt_dev_err(hdev, "changing Mediatek device address failed (%ld)",
-- 
1.8.3.1

