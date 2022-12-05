Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C304EC47089
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Dec 2022 15:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230246AbiLEPME (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Dec 2022 10:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbiLEPMB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Dec 2022 10:12:01 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20BB2DEA
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Dec 2022 07:11:59 -0800 (PST)
Received: from dggpemm500007.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NQn7M22kYz15N5k;
        Mon,  5 Dec 2022 23:11:11 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 5 Dec
 2022 23:11:57 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <luiz.dentz@gmail.com>
CC:     <linux-bluetooth@vger.kernel.org>, <yangyingliang@huawei.com>
Subject: [PATCH 2/6] Bluetooth: hci_ll: don't call kfree_skb() under spin_lock_irqsave()
Date:   Mon, 5 Dec 2022 23:09:24 +0800
Message-ID: <20221205150928.4017973-3-yangyingliang@huawei.com>
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
context or with interrupts being disabled. Call it after the
spin_unlock_irqrestore().

Fixes: 166d2f6a4332 ("[Bluetooth] Add UART driver for Texas Instruments' BRF63xx chips")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/bluetooth/hci_ll.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 4eb420a9ed04..5f8a267fd8a5 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -345,8 +345,9 @@ static int ll_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 	default:
 		BT_ERR("illegal hcill state: %ld (losing packet)",
 		       ll->hcill_state);
+		spin_unlock_irqrestore(&ll->hcill_lock, flags);
 		kfree_skb(skb);
-		break;
+		return 0;
 	}
 
 	spin_unlock_irqrestore(&ll->hcill_lock, flags);
-- 
2.25.1

