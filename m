Return-Path: <SRS0=Cqm8=VG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAA8C606B0
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jul 2019 01:29:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA35621537
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 Jul 2019 01:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbfGIB30 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 Jul 2019 21:29:26 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40856 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725886AbfGIB3Z (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 Jul 2019 21:29:25 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7407DB1F755D0F616C3A;
        Tue,  9 Jul 2019 09:29:23 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Tue, 9 Jul 2019 09:29:16 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-bluetooth@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] Bluetooth: hci_qca: Use kfree_skb() instead of kfree()
Date:   Tue, 9 Jul 2019 01:35:30 +0000
Message-ID: <20190709013530.11865-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Use kfree_skb() instead of kfree() to free sk_buff.

Fixes: 2faa3f15fa2f ("Bluetooth: hci_qca: wcn3990: Drop baudrate change vendor event")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/bluetooth/hci_qca.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 9a5c9c1f9484..cbae86e55aed 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -909,7 +909,7 @@ static int qca_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 		if (hdr->evt == HCI_EV_VENDOR)
 			complete(&qca->drop_ev_comp);
 
-		kfree(skb);
+		kfree_skb(skb);
 
 		return 0;
 	}



