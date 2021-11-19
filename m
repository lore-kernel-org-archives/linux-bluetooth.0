Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9A9C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 22:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbhKSW25 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Nov 2021 17:28:57 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:53254 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235899AbhKSW24 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Nov 2021 17:28:56 -0500
X-UUID: 9f3e7bb6dee24575a4d3242d535019c9-20211120
X-UUID: 9f3e7bb6dee24575a4d3242d535019c9-20211120
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1196404892; Sat, 20 Nov 2021 06:25:50 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 20 Nov 2021 06:25:49 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 20 Nov
 2021 06:25:48 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 20 Nov 2021 06:25:48 +0800
From:   <sean.wang@mediatek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <Mark-YW.Chen@mediatek.com>, <sean.wang@mediatek.com>,
        <Soul.Huang@mediatek.com>, <YN.Chen@mediatek.com>,
        <Leon.Yen@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <Tom.Chou@mediatek.com>,
        <steve.lee@mediatek.com>, <jsiuda@google.com>,
        <frankgor@google.com>, <jemele@google.com>,
        <abhishekpandit@google.com>, <michaelfsun@google.com>,
        <mcchou@chromium.org>, <shawnku@google.com>,
        <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/4] Bluetooth: btmtksdio: drop the unnecessary variable created
Date:   Sat, 20 Nov 2021 06:25:43 +0800
Message-ID: <4176102d8bbc36e5156e348df666a3e12c5a3d75.1637360076.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Use the existent variable to drop the unnecessary variable created.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtksdio.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index ce6a6c00ff98..4f3412ad8fca 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -98,6 +98,7 @@ MODULE_DEVICE_TABLE(sdio, btmtksdio_table);
 #define MTK_SDIO_BLOCK_SIZE	256
 
 #define BTMTKSDIO_TX_WAIT_VND_EVT	1
+#define BTMTKSDIO_HW_TX_READY		2
 
 struct mtkbtsdio_hdr {
 	__le16	len;
@@ -113,7 +114,6 @@ struct btmtksdio_dev {
 	struct work_struct txrx_work;
 	unsigned long tx_state;
 	struct sk_buff_head txq;
-	bool hw_tx_ready;
 
 	struct sk_buff *evt_skb;
 
@@ -254,7 +254,7 @@ static int btmtksdio_tx_packet(struct btmtksdio_dev *bdev,
 	sdio_hdr->reserved = cpu_to_le16(0);
 	sdio_hdr->bt_type = hci_skb_pkt_type(skb);
 
-	bdev->hw_tx_ready = false;
+	clear_bit(BTMTKSDIO_HW_TX_READY, &bdev->tx_state);
 	err = sdio_writesb(bdev->func, MTK_REG_CTDR, skb->data,
 			   round_up(skb->len, MTK_SDIO_BLOCK_SIZE));
 	if (err < 0)
@@ -463,11 +463,12 @@ static void btmtksdio_txrx_work(struct work_struct *work)
 			bt_dev_dbg(bdev->hdev, "Get fw own back");
 
 		if (int_status & TX_EMPTY)
-			bdev->hw_tx_ready = true;
+			set_bit(BTMTKSDIO_HW_TX_READY, &bdev->tx_state);
+
 		else if (unlikely(int_status & TX_FIFO_OVERFLOW))
 			bt_dev_warn(bdev->hdev, "Tx fifo overflow");
 
-		if (bdev->hw_tx_ready) {
+		if (test_bit(BTMTKSDIO_HW_TX_READY, &bdev->tx_state)) {
 			skb = skb_dequeue(&bdev->txq);
 			if (skb) {
 				err = btmtksdio_tx_packet(bdev, skb);
@@ -811,7 +812,7 @@ static int btmtksdio_setup(struct hci_dev *hdev)
 	u32 fw_version = 0;
 
 	calltime = ktime_get();
-	bdev->hw_tx_ready = true;
+	set_bit(BTMTKSDIO_HW_TX_READY, &bdev->tx_state);
 
 	switch (bdev->data->chipid) {
 	case 0x7921:
-- 
2.25.1

