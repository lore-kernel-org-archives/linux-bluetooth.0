Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82D8C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Oct 2021 21:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 890116113D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Oct 2021 21:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbhJRVdI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Oct 2021 17:33:08 -0400
Received: from mailgw01.mediatek.com ([216.200.240.184]:46672 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbhJRVdF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Oct 2021 17:33:05 -0400
X-UUID: 899a9a72d3d84c6a9b957b9f6df1ad73-20211018
X-UUID: 899a9a72d3d84c6a9b957b9f6df1ad73-20211018
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1499909244; Mon, 18 Oct 2021 14:30:53 -0700
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 18 Oct 2021 14:30:51 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 19 Oct 2021 05:30:50 +0800
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
        <linux-kernel@vger.kernel.org>,
        Mark-yw Chen <mark-yw.chen@mediatek.com>
Subject: [PATCH v2 08/10] Bluetooth: btmtksdio: transmit packet according to status TX_EMPTY
Date:   Tue, 19 Oct 2021 05:30:19 +0800
Message-ID: <3dccea770a3f656dffbae573b6d2b577af0ca324.1634592181.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1634592181.git.objelf@gmail.com>
References: <cover.1634592181.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Mark-yw Chen <mark-yw.chen@mediatek.com>

Each packet should be sent out until the device emits the TX_EMPTY signal
to the host, that is firmware people suggested to add to meet the actual
firmware behavior and that is compatible among all the devices.

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Mark-yw Chen <mark-yw.chen@mediatek.com>
---
 drivers/bluetooth/btmtksdio.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index f816a7cb0a74..3266c5d83cae 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -103,6 +103,7 @@ struct btmtksdio_dev {
 	struct work_struct txrx_work;
 	unsigned long tx_state;
 	struct sk_buff_head txq;
+	bool hw_tx_ready;
 
 	struct sk_buff *evt_skb;
 
@@ -229,6 +230,7 @@ static int btmtksdio_tx_packet(struct btmtksdio_dev *bdev,
 	sdio_hdr->reserved = cpu_to_le16(0);
 	sdio_hdr->bt_type = hci_skb_pkt_type(skb);
 
+	bdev->hw_tx_ready = false;
 	err = sdio_writesb(bdev->func, MTK_REG_CTDR, skb->data,
 			   round_up(skb->len, MTK_SDIO_BLOCK_SIZE));
 	if (err < 0)
@@ -417,15 +419,6 @@ static void btmtksdio_txrx_work(struct work_struct *work)
 	/* Disable interrupt */
 	sdio_writel(bdev->func, C_INT_EN_CLR, MTK_REG_CHLPCR, 0);
 
-	while ((skb = skb_dequeue(&bdev->txq))) {
-		err = btmtksdio_tx_packet(bdev, skb);
-		if (err < 0) {
-			bdev->hdev->stat.err_tx++;
-			skb_queue_head(&bdev->txq, skb);
-			break;
-		}
-	}
-
 	txrx_timeout = jiffies + 5 * HZ;
 
 	do {
@@ -446,10 +439,21 @@ static void btmtksdio_txrx_work(struct work_struct *work)
 			bt_dev_dbg(bdev->hdev, "Get fw own back");
 
 		if (int_status & TX_EMPTY)
-			schedule_work(&bdev->txrx_work);
+			bdev->hw_tx_ready = true;
 		else if (unlikely(int_status & TX_FIFO_OVERFLOW))
 			bt_dev_warn(bdev->hdev, "Tx fifo overflow");
 
+		if (bdev->hw_tx_ready) {
+			skb = skb_dequeue(&bdev->txq);
+			if (skb) {
+				err = btmtksdio_tx_packet(bdev, skb);
+				if (err < 0) {
+					bdev->hdev->stat.err_tx++;
+					skb_queue_head(&bdev->txq, skb);
+				}
+			}
+		}
+
 		if (int_status & RX_DONE_INT) {
 			rx_size = sdio_readl(bdev->func, MTK_REG_CRPLR, NULL);
 			rx_size = (rx_size & RX_PKT_LEN) >> 16;
@@ -642,6 +646,7 @@ static int btmtksdio_setup(struct hci_dev *hdev)
 	u8 param = 0x1;
 
 	calltime = ktime_get();
+	bdev->hw_tx_ready = true;
 
 	/* Query whether the firmware is already download */
 	wmt_params.op = BTMTK_WMT_SEMAPHORE;
-- 
2.25.1

