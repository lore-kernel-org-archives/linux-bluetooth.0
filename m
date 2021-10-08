Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E591CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 22:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C20FB6103C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 22:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243703AbhJHWXW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Oct 2021 18:23:22 -0400
Received: from mailgw01.mediatek.com ([216.200.240.184]:36675 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243610AbhJHWXP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Oct 2021 18:23:15 -0400
X-UUID: 39e8449bbf0c4831bb95660803be2337-20211008
X-UUID: 39e8449bbf0c4831bb95660803be2337-20211008
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 523008174; Fri, 08 Oct 2021 15:20:06 -0700
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 8 Oct 2021 15:10:47 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 9 Oct 2021 06:10:46 +0800
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
Subject: [PATCH v1 06/10] Bluetooth: btmtksdio: update register CSDIOCSR operation
Date:   Sat, 9 Oct 2021 06:10:13 +0800
Message-ID: <629e6a12a0f1698fb78934d36b2c1ff65573957d.1633728573.git.objelf@gmail.com>
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

Update register CSDIOCSR operation that is suggested from the vendor
driver and is compatible to the all devices.

Co-developed-by: Mark-yw Chen <mark-yw.chen@mediatek.com>
Signed-off-by: Mark-yw Chen <mark-yw.chen@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtksdio.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index f712b52e5797..3381c8844902 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -520,8 +520,12 @@ static int btmtksdio_open(struct hci_dev *hdev)
 	/* SDIO CMD 5 allows the SDIO device back to idle state an
 	 * synchronous interrupt is supported in SDIO 4-bit mode
 	 */
-	sdio_writel(bdev->func, SDIO_INT_CTL | SDIO_RE_INIT_EN,
-		    MTK_REG_CSDIOCSR, &err);
+	val = sdio_readl(bdev->func, MTK_REG_CSDIOCSR, &err);
+	if (err < 0)
+		goto err_release_irq;
+
+	val |= SDIO_INT_CTL;
+	sdio_writel(bdev->func, val, MTK_REG_CSDIOCSR, &err);
 	if (err < 0)
 		goto err_release_irq;
 
-- 
2.25.1

