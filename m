Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471BBC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 22:21:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C87C61027
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 22:21:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243683AbhJHWXj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Oct 2021 18:23:39 -0400
Received: from mailgw01.mediatek.com ([216.200.240.184]:39949 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243761AbhJHWXd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Oct 2021 18:23:33 -0400
X-UUID: 5ccfa8a55bb44a518e97b3160e05ce27-20211008
X-UUID: 5ccfa8a55bb44a518e97b3160e05ce27-20211008
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1717558128; Fri, 08 Oct 2021 15:20:32 -0700
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 8 Oct 2021 15:10:50 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 9 Oct 2021 06:10:50 +0800
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
Subject: [PATCH v1 07/10] Bluetooth: btmtksdio: use register CRPLR to read packet length
Date:   Sat, 9 Oct 2021 06:10:14 +0800
Message-ID: <5a42eeb8f2f5122b4da2585ac90a9c7fcc115a98.1633728573.git.objelf@gmail.com>
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

That is a preliminary patch to introduce mt7921s support.

Use the register CRPLR to read packet length to make all the devices
share the common logic.

Co-developed-by: Mark-yw Chen <mark-yw.chen@mediatek.com>
Signed-off-by: Mark-yw Chen <mark-yw.chen@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtksdio.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 3381c8844902..f816a7cb0a74 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -83,6 +83,8 @@ MODULE_DEVICE_TABLE(sdio, btmtksdio_table);
 
 #define MTK_REG_CRDR		0x1c
 
+#define MTK_REG_CRPLR		0x24
+
 #define MTK_SDIO_BLOCK_SIZE	256
 
 #define BTMTKSDIO_TX_WAIT_VND_EVT	1
@@ -404,9 +406,8 @@ static void btmtksdio_txrx_work(struct work_struct *work)
 	struct btmtksdio_dev *bdev = container_of(work, struct btmtksdio_dev,
 						  txrx_work);
 	unsigned long txrx_timeout;
+	u32 int_status, rx_size;
 	struct sk_buff *skb;
-	u32 int_status;
-	u16 rx_size;
 	int err;
 
 	pm_runtime_get_sync(bdev->dev);
@@ -450,11 +451,11 @@ static void btmtksdio_txrx_work(struct work_struct *work)
 			bt_dev_warn(bdev->hdev, "Tx fifo overflow");
 
 		if (int_status & RX_DONE_INT) {
-			rx_size = (int_status & RX_PKT_LEN) >> 16;
+			rx_size = sdio_readl(bdev->func, MTK_REG_CRPLR, NULL);
+			rx_size = (rx_size & RX_PKT_LEN) >> 16;
 			if (btmtksdio_rx_packet(bdev, rx_size) < 0)
 				bdev->hdev->stat.err_rx++;
 		}
-
 	} while (int_status || time_is_before_jiffies(txrx_timeout));
 
 	/* Enable interrupt */
-- 
2.25.1

