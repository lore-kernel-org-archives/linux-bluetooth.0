Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67021C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 22:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbhKSW27 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Nov 2021 17:28:59 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:37822 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235928AbhKSW26 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Nov 2021 17:28:58 -0500
X-UUID: 1da5324359b24343b5ff1f8ccbbe61b2-20211120
X-UUID: 1da5324359b24343b5ff1f8ccbbe61b2-20211120
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1733938610; Sat, 20 Nov 2021 06:25:53 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 20 Nov 2021 06:25:52 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 20 Nov 2021 06:25:51 +0800
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
Subject: [PATCH 2/4] Bluetooth: btmtksdio: handle runtime pm only when sdio_func is available
Date:   Sat, 20 Nov 2021 06:25:44 +0800
Message-ID: <07cd9db8ef295bfe3e6b42796ccb8c9fb59dd9ba.1637360076.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <4176102d8bbc36e5156e348df666a3e12c5a3d75.1637360076.git.objelf@gmail.com>
References: <4176102d8bbc36e5156e348df666a3e12c5a3d75.1637360076.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Runtime pm ops is not aware the sdio_func status that is probably
being disabled by btmtksdio_close. Thus, we are only able to access the
sdio_func for the runtime pm operations only when the sdio_func is
available.

Fixes: 7f3c563c575e7 ("Bluetooth: btmtksdio: Add runtime PM support to SDIO based Bluetooth")
Co-developed-by: Mark-yw Chen <mark-yw.chen@mediatek.com>
Signed-off-by: Mark-yw Chen <mark-yw.chen@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtksdio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 4f3412ad8fca..4c46c62e4623 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -1037,6 +1037,9 @@ static int btmtksdio_runtime_suspend(struct device *dev)
 	if (!bdev)
 		return 0;
 
+	if (!test_bit(HCI_RUNNING, &bdev->hdev->flags))
+		return 0;
+
 	sdio_claim_host(bdev->func);
 
 	sdio_writel(bdev->func, C_FW_OWN_REQ_SET, MTK_REG_CHLPCR, &err);
@@ -1064,6 +1067,9 @@ static int btmtksdio_runtime_resume(struct device *dev)
 	if (!bdev)
 		return 0;
 
+	if (!test_bit(HCI_RUNNING, &bdev->hdev->flags))
+		return 0;
+
 	sdio_claim_host(bdev->func);
 
 	sdio_writel(bdev->func, C_FW_OWN_REQ_CLR, MTK_REG_CHLPCR, &err);
-- 
2.25.1

