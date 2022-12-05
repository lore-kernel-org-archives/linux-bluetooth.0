Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4FDC4321E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Dec 2022 15:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiLEPMN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Dec 2022 10:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiLEPMC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Dec 2022 10:12:02 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD5A2AD6
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Dec 2022 07:12:02 -0800 (PST)
Received: from dggpemm500007.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NQn7L58lszRnsK;
        Mon,  5 Dec 2022 23:11:10 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 5 Dec
 2022 23:11:58 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>
CC:     <linux-bluetooth@vger.kernel.org>, <yangyingliang@huawei.com>
Subject: [PATCH 4/6] Bluetooth: hci_bcsp: don't call kfree_skb() under spin_lock_irqsave()
Date:   Mon, 5 Dec 2022 23:09:26 +0800
Message-ID: <20221205150928.4017973-5-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221205150928.4017973-1-yangyingliang@huawei.com>
References: <20221205150928.4017973-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

It is not allowed to call kfree_skb() from hardware interrupt
context or with interrupts being disabled. So add all skb to
a free list, then free them after spin_unlock_irqrestore() at
once.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/bluetooth/hci_bcsp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
index cf4a56095817..c47ddb2fb22b 100644
--- a/drivers/bluetooth/hci_bcsp.c
+++ b/drivers/bluetooth/hci_bcsp.c
@@ -347,11 +347,13 @@ static int bcsp_flush(struct hci_uart *hu)
 /* Remove ack'ed packets */
 static void bcsp_pkt_cull(struct bcsp_struct *bcsp)
 {
+	struct sk_buff_head free_list;
 	struct sk_buff *skb, *tmp;
 	unsigned long flags;
 	int i, pkts_to_be_removed;
 	u8 seqno;
 
+	skb_queue_head_init(&free_list);
 	spin_lock_irqsave(&bcsp->unack.lock, flags);
 
 	pkts_to_be_removed = skb_queue_len(&bcsp->unack);
@@ -378,7 +380,7 @@ static void bcsp_pkt_cull(struct bcsp_struct *bcsp)
 		i++;
 
 		__skb_unlink(skb, &bcsp->unack);
-		kfree_skb(skb);
+		__skb_queue_tail(&free_list, skb);
 	}
 
 	if (skb_queue_empty(&bcsp->unack))
@@ -386,6 +388,8 @@ static void bcsp_pkt_cull(struct bcsp_struct *bcsp)
 
 	spin_unlock_irqrestore(&bcsp->unack.lock, flags);
 
+	__skb_queue_purge(&free_list);
+
 	if (i != pkts_to_be_removed)
 		BT_ERR("Removed only %u out of %u pkts", i, pkts_to_be_removed);
 }
-- 
2.25.1

