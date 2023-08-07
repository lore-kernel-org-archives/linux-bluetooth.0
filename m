Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032B2C0015E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Aug 2023 02:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjHGCcS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Aug 2023 22:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjHGCcR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Aug 2023 22:32:17 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F561709
        for <linux-bluetooth@vger.kernel.org>; Sun,  6 Aug 2023 19:32:16 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RK0gC6p71zrSGK;
        Mon,  7 Aug 2023 10:31:03 +0800 (CST)
Received: from localhost.localdomain (10.175.104.82) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 10:32:12 +0800
From:   Ziyang Xuan <william.xuanziyang@huawei.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>, <linux-bluetooth@vger.kernel.org>
CC:     <william.xuanziyang@huawei.com>
Subject: [PATCH] Bluetooth: Remove unnecessary NULL check before vfree()
Date:   Mon, 7 Aug 2023 10:32:06 +0800
Message-ID: <20230807023206.2128846-1-william.xuanziyang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Get a coccinelle warning as follows:
net/bluetooth/coredump.c:104:2-7: WARNING: NULL check before some freeing functions is not needed.

Remove the unnecessary NULL check.

Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
---
 net/bluetooth/coredump.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/coredump.c b/net/bluetooth/coredump.c
index d2d2624ec708..ec97a4bab1c9 100644
--- a/net/bluetooth/coredump.c
+++ b/net/bluetooth/coredump.c
@@ -100,8 +100,7 @@ void hci_devcd_reset(struct hci_dev *hdev)
 /* Call with hci_dev_lock only. */
 static void hci_devcd_free(struct hci_dev *hdev)
 {
-	if (hdev->dump.head)
-		vfree(hdev->dump.head);
+	vfree(hdev->dump.head);
 
 	hci_devcd_reset(hdev);
 }
-- 
2.25.1

