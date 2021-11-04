Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0F6C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Nov 2021 18:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25A686112E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Nov 2021 18:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbhKDS2v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 Nov 2021 14:28:51 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:54208 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233765AbhKDS2v (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 Nov 2021 14:28:51 -0400
X-UUID: 86df4b606f384b378bdd9222761882f4-20211105
X-UUID: 86df4b606f384b378bdd9222761882f4-20211105
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <mark-yw.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1479946574; Fri, 05 Nov 2021 02:26:10 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 5 Nov 2021 02:26:09 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs10n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 5 Nov 2021 02:26:09 +0800
From:   <mark-yw.chen@mediatek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <josephsih@google.com>, <mark-yw.chen@mediatek.com>,
        <will-cy.lee@mediatek.com>, <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] Bluetooth: btusb: enable Mediatek to support AOSP extension
Date:   Fri, 5 Nov 2021 02:26:05 +0800
Message-ID: <20211104182605.30433-1-mark-yw.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: "mark-yw.chen" <mark-yw.chen@mediatek.com>

This patch enables AOSP extension for Mediatek Chip (MT7921 & MT7922).

Signed-off-by: mark-yw.chen <mark-yw.chen@mediatek.com>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 46d892bbde62..30a057e1d4e3 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2565,6 +2565,7 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 		}
 
 		hci_set_msft_opcode(hdev, 0xFD30);
+		hci_set_aosp_capable(hdev);
 		goto done;
 	default:
 		bt_dev_err(hdev, "Unsupported hardware variant (%08x)",
-- 
2.18.0

