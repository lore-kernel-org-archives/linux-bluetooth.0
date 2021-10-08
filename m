Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D7DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 22:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B82F61027
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 22:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243797AbhJHWXp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Oct 2021 18:23:45 -0400
Received: from mailgw01.mediatek.com ([216.200.240.184]:39949 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243760AbhJHWXj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Oct 2021 18:23:39 -0400
X-UUID: 5ad0f34c76e04da5928cbd36733deed1-20211008
X-UUID: 5ad0f34c76e04da5928cbd36733deed1-20211008
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 568399804; Fri, 08 Oct 2021 15:20:32 -0700
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 8 Oct 2021 15:10:41 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 9 Oct 2021 06:10:41 +0800
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
Subject: [PATCH v1 05/10] Bluetooth: btmtksdio: move interrupt service to work
Date:   Sat, 9 Oct 2021 06:10:12 +0800
Message-ID: <83179efa9ececcca608cf86faa13bb52cf95e676.1633728573.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1633728573.git.objelf@gmail.com>
References: <cover.1633728573.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

btmtksdio belongs to WIFI/BT combo chip that would serve two radios in one
sdio_irq so that we have to move interrupt service to worker to ensure ISR
as short as possible.

The worker would serve the both Tx and Rx in a batch to effectively reduce
many interrupts to the host and to avoid excessive sdio lock contention
between various context (even from WiFi driver) and help to be more
efficient to complete command/event transation.

Co-developed-by: Mark-yw Chen <mark-yw.chen@mediatek.com>
Signed-off-by: Mark-yw Chen <mark-yw.chen@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtksdio.c | 132 ++++++++++++++++------------------
 1 file changed, 63 insertions(+), 69 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 57126a95e292..f712b52e5797 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -98,7 +98,7 @@ struct btmtksdio_dev {
 	struct sdio_func *func;
 	struct device *dev;
 
-	struct work_struct tx_work;
+	struct work_struct txrx_work;
 	unsigned long tx_state;
 	struct sk_buff_head txq;
 
@@ -249,32 +249,6 @@ static u32 btmtksdio_drv_own_query(struct btmtksdio_dev *bdev)
 	return sdio_readl(bdev->func, MTK_REG_CHLPCR, NULL);
 }
 
-static void btmtksdio_tx_work(struct work_struct *work)
-{
-	struct btmtksdio_dev *bdev = container_of(work, struct btmtksdio_dev,
-						  tx_work);
-	struct sk_buff *skb;
-	int err;
-
-	pm_runtime_get_sync(bdev->dev);
-
-	sdio_claim_host(bdev->func);
-
-	while ((skb = skb_dequeue(&bdev->txq))) {
-		err = btmtksdio_tx_packet(bdev, skb);
-		if (err < 0) {
-			bdev->hdev->stat.err_tx++;
-			skb_queue_head(&bdev->txq, skb);
-			break;
-		}
-	}
-
-	sdio_release_host(bdev->func);
-
-	pm_runtime_mark_last_busy(bdev->dev);
-	pm_runtime_put_autosuspend(bdev->dev);
-}
-
 static int btmtksdio_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct btmtksdio_dev *bdev = hci_get_drvdata(hdev);
@@ -425,63 +399,81 @@ static int btmtksdio_rx_packet(struct btmtksdio_dev *bdev, u16 rx_size)
 	return err;
 }
 
-static void btmtksdio_interrupt(struct sdio_func *func)
+static void btmtksdio_txrx_work(struct work_struct *work)
 {
-	struct btmtksdio_dev *bdev = sdio_get_drvdata(func);
+	struct btmtksdio_dev *bdev = container_of(work, struct btmtksdio_dev,
+						  txrx_work);
+	unsigned long txrx_timeout;
+	struct sk_buff *skb;
 	u32 int_status;
 	u16 rx_size;
-
-	/* It is required that the host gets ownership from the device before
-	 * accessing any register, however, if SDIO host is not being released,
-	 * a potential deadlock probably happens in a circular wait between SDIO
-	 * IRQ work and PM runtime work. So, we have to explicitly release SDIO
-	 * host here and claim again after the PM runtime work is all done.
-	 */
-	sdio_release_host(bdev->func);
+	int err;
 
 	pm_runtime_get_sync(bdev->dev);
 
 	sdio_claim_host(bdev->func);
 
 	/* Disable interrupt */
-	sdio_writel(func, C_INT_EN_CLR, MTK_REG_CHLPCR, NULL);
+	sdio_writel(bdev->func, C_INT_EN_CLR, MTK_REG_CHLPCR, 0);
 
-	int_status = sdio_readl(func, MTK_REG_CHISR, NULL);
+	while ((skb = skb_dequeue(&bdev->txq))) {
+		err = btmtksdio_tx_packet(bdev, skb);
+		if (err < 0) {
+			bdev->hdev->stat.err_tx++;
+			skb_queue_head(&bdev->txq, skb);
+			break;
+		}
+	}
 
-	/* Ack an interrupt as soon as possible before any operation on
-	 * hardware.
-	 *
-	 * Note that we don't ack any status during operations to avoid race
-	 * condition between the host and the device such as it's possible to
-	 * mistakenly ack RX_DONE for the next packet and then cause interrupts
-	 * not be raised again but there is still pending data in the hardware
-	 * FIFO.
-	 */
-	sdio_writel(func, int_status, MTK_REG_CHISR, NULL);
+	txrx_timeout = jiffies + 5 * HZ;
+
+	do {
+		int_status = sdio_readl(bdev->func, MTK_REG_CHISR, NULL);
+
+		/* Ack an interrupt as soon as possible before any operation on
+		 * hardware.
+		 *
+		 * Note that we don't ack any status during operations to avoid race
+		 * condition between the host and the device such as it's possible to
+		 * mistakenly ack RX_DONE for the next packet and then cause interrupts
+		 * not be raised again but there is still pending data in the hardware
+		 * FIFO.
+		 */
+		sdio_writel(bdev->func, int_status, MTK_REG_CHISR, NULL);
+
+		if (int_status & FW_OWN_BACK_INT)
+			bt_dev_dbg(bdev->hdev, "Get fw own back");
+
+		if (int_status & TX_EMPTY)
+			schedule_work(&bdev->txrx_work);
+		else if (unlikely(int_status & TX_FIFO_OVERFLOW))
+			bt_dev_warn(bdev->hdev, "Tx fifo overflow");
+
+		if (int_status & RX_DONE_INT) {
+			rx_size = (int_status & RX_PKT_LEN) >> 16;
+			if (btmtksdio_rx_packet(bdev, rx_size) < 0)
+				bdev->hdev->stat.err_rx++;
+		}
 
-	if (unlikely(!int_status))
-		bt_dev_err(bdev->hdev, "CHISR is 0");
+	} while (int_status || time_is_before_jiffies(txrx_timeout));
 
-	if (int_status & FW_OWN_BACK_INT)
-		bt_dev_dbg(bdev->hdev, "Get fw own back");
+	/* Enable interrupt */
+	sdio_writel(bdev->func, C_INT_EN_SET, MTK_REG_CHLPCR, 0);
 
-	if (int_status & TX_EMPTY)
-		schedule_work(&bdev->tx_work);
-	else if (unlikely(int_status & TX_FIFO_OVERFLOW))
-		bt_dev_warn(bdev->hdev, "Tx fifo overflow");
+	sdio_release_host(bdev->func);
 
-	if (int_status & RX_DONE_INT) {
-		rx_size = (int_status & RX_PKT_LEN) >> 16;
+	pm_runtime_mark_last_busy(bdev->dev);
+	pm_runtime_put_autosuspend(bdev->dev);
+}
 
-		if (btmtksdio_rx_packet(bdev, rx_size) < 0)
-			bdev->hdev->stat.err_rx++;
-	}
+static void btmtksdio_interrupt(struct sdio_func *func)
+{
+	struct btmtksdio_dev *bdev = sdio_get_drvdata(func);
 
-	/* Enable interrupt */
-	sdio_writel(func, C_INT_EN_SET, MTK_REG_CHLPCR, NULL);
+	/* Disable interrupt */
+	sdio_writel(bdev->func, C_INT_EN_CLR, MTK_REG_CHLPCR, 0);
 
-	pm_runtime_mark_last_busy(bdev->dev);
-	pm_runtime_put_autosuspend(bdev->dev);
+	schedule_work(&bdev->txrx_work);
 }
 
 static int btmtksdio_open(struct hci_dev *hdev)
@@ -583,6 +575,8 @@ static int btmtksdio_close(struct hci_dev *hdev)
 
 	sdio_release_irq(bdev->func);
 
+	cancel_work_sync(&bdev->txrx_work);
+
 	/* Return ownership to the device */
 	sdio_writel(bdev->func, C_FW_OWN_REQ_SET, MTK_REG_CHLPCR, NULL);
 
@@ -604,7 +598,7 @@ static int btmtksdio_flush(struct hci_dev *hdev)
 
 	skb_queue_purge(&bdev->txq);
 
-	cancel_work_sync(&bdev->tx_work);
+	cancel_work_sync(&bdev->txrx_work);
 
 	return 0;
 }
@@ -795,7 +789,7 @@ static int btmtksdio_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
 	skb_queue_tail(&bdev->txq, skb);
 
-	schedule_work(&bdev->tx_work);
+	schedule_work(&bdev->txrx_work);
 
 	return 0;
 }
@@ -818,7 +812,7 @@ static int btmtksdio_probe(struct sdio_func *func,
 	bdev->dev = &func->dev;
 	bdev->func = func;
 
-	INIT_WORK(&bdev->tx_work, btmtksdio_tx_work);
+	INIT_WORK(&bdev->txrx_work, btmtksdio_txrx_work);
 	skb_queue_head_init(&bdev->txq);
 
 	/* Initialize and register HCI device */
-- 
2.25.1

