Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D97BEE49A0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Aug 2023 03:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbjHWDrC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Aug 2023 23:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbjHWDrB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Aug 2023 23:47:01 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E598AE57
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Aug 2023 20:46:57 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RVsYg066Tz1L9Mf;
        Wed, 23 Aug 2023 11:45:26 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 23 Aug
 2023 11:46:55 +0800
From:   Jinjie Ruan <ruanjinjie@huawei.com>
To:     <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Hsin-Yu Chao <hychao@chromium.org>,
        Sathish Narasimman <sathish.narasimman@intel.com>,
        Amit K Bag <amit.k.bag@intel.com>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] Bluetooth: btusb: Do not call kfree_skb() under spin_lock_irqsave()
Date:   Wed, 23 Aug 2023 11:46:37 +0800
Message-ID: <20230823034638.1281539-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

It is not allowed to call kfree_skb() from hardware interrupt
context or with hardware interrupts being disabled.
So replace kfree_skb() with dev_kfree_skb_irq() under
spin_lock_irqsave(). Compile tested only.

Fixes: baac6276c0a9 ("Bluetooth: btusb: handle mSBC audio over USB Endpoints")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/bluetooth/btusb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 1bb3b09013b0..52309ece6145 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2162,7 +2162,7 @@ static int btusb_switch_alt_setting(struct hci_dev *hdev, int new_alts)
 		 * alternate setting.
 		 */
 		spin_lock_irqsave(&data->rxlock, flags);
-		kfree_skb(data->sco_skb);
+		dev_kfree_skb_irq(data->sco_skb);
 		data->sco_skb = NULL;
 		spin_unlock_irqrestore(&data->rxlock, flags);
 
-- 
2.34.1

