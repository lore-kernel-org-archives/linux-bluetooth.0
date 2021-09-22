Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB989C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Sep 2021 13:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF074610A1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Sep 2021 13:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbhIVNx0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Sep 2021 09:53:26 -0400
Received: from mail.zju.edu.cn ([61.164.42.155]:37198 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232213AbhIVNx0 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Sep 2021 09:53:26 -0400
Received: from localhost.localdomain (unknown [10.192.168.152])
        by mail-app3 (Coremail) with SMTP id cC_KCgC3t2x8NEthnTqKBQ--.42479S4;
        Wed, 22 Sep 2021 21:49:53 +0800 (CST)
From:   Dinghao Liu <dinghao.liu@zju.edu.cn>
To:     dinghao.liu@zju.edu.cn
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btmtkuart: fix a memleak in mtk_hci_wmt_sync
Date:   Wed, 22 Sep 2021 21:49:45 +0800
Message-Id: <20210922134945.27503-1-dinghao.liu@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: cC_KCgC3t2x8NEthnTqKBQ--.42479S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1kAw17trWxZr1rCw18AFb_yoW8AFW5pF
        Wqg3Z8ZrWUtr4fZr9Iya1fXayrAa1SqrWjg3yrC3s5Gr4YyrZ5JF1Fka4jqrWakrZ7Jw42
        yF1ktrZ5Ca4UurJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvm1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
        z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
        Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
        6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
        vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28I
        cxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GFWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJV
        W8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF
        1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6x
        IIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvE
        x4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnU
        UI43ZEXa7VUbXdbUUUUUU==
X-CM-SenderInfo: qrrzjiaqtzq6lmxovvfxof0/1tbiAg0OBlZdtV6LsAAVsJ
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

bdev->evt_skb will get freed in the normal path and one error path
of mtk_hci_wmt_sync, while the other error paths do not free it,
which may cause a memleak. This bug is suggested by a static analysis
tool, please advise.

Fixes: e0b67035a90b ("Bluetooth: mediatek: update the common setup between MT7622 and other devices")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
---
 drivers/bluetooth/btmtkuart.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btmtkuart.c b/drivers/bluetooth/btmtkuart.c
index e9d91d7c0db4..9ba22b13b4fa 100644
--- a/drivers/bluetooth/btmtkuart.c
+++ b/drivers/bluetooth/btmtkuart.c
@@ -158,8 +158,10 @@ static int mtk_hci_wmt_sync(struct hci_dev *hdev,
 	int err;
 
 	hlen = sizeof(*hdr) + wmt_params->dlen;
-	if (hlen > 255)
-		return -EINVAL;
+	if (hlen > 255) {
+		err = -EINVAL;
+		goto err_free_skb;
+	}
 
 	hdr = (struct mtk_wmt_hdr *)&wc;
 	hdr->dir = 1;
@@ -173,7 +175,7 @@ static int mtk_hci_wmt_sync(struct hci_dev *hdev,
 	err = __hci_cmd_send(hdev, 0xfc6f, hlen, &wc);
 	if (err < 0) {
 		clear_bit(BTMTKUART_TX_WAIT_VND_EVT, &bdev->tx_state);
-		return err;
+		goto err_free_skb;
 	}
 
 	/* The vendor specific WMT commands are all answered by a vendor
@@ -190,13 +192,14 @@ static int mtk_hci_wmt_sync(struct hci_dev *hdev,
 	if (err == -EINTR) {
 		bt_dev_err(hdev, "Execution of wmt command interrupted");
 		clear_bit(BTMTKUART_TX_WAIT_VND_EVT, &bdev->tx_state);
-		return err;
+		goto err_free_skb;
 	}
 
 	if (err) {
 		bt_dev_err(hdev, "Execution of wmt command timed out");
 		clear_bit(BTMTKUART_TX_WAIT_VND_EVT, &bdev->tx_state);
-		return -ETIMEDOUT;
+		err = -ETIMEDOUT;
+		goto err_free_skb;
 	}
 
 	/* Parse and handle the return WMT event */
-- 
2.17.1

