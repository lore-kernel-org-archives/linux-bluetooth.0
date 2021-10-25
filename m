Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C00EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 15:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B13060F0F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 15:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbhJYPFy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 11:05:54 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:45892 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233125AbhJYPFx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 11:05:53 -0400
X-UUID: 38140ce91005447fbac6eea769e392a8-20211025
X-UUID: 38140ce91005447fbac6eea769e392a8-20211025
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <mark-yw.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1155202787; Mon, 25 Oct 2021 23:03:27 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 25 Oct 2021 23:03:26 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 25 Oct 2021 23:03:25 +0800
From:   <mark-yw.chen@mediatek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <mark-yw.chen@mediatek.com>, <will-cy.lee@mediatek.com>,
        <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] Bluetooth: btusb: Fix failed to send func ctrl for MediaTek devices.
Date:   Mon, 25 Oct 2021 23:03:25 +0800
Message-ID: <20211025150325.2143-1-mark-yw.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: "mark-yw.chen" <mark-yw.chen@mediatek.com>

* Use usb_autopm_get_interface() and usb_autopm_put_interface()
  in btusb_mtk_shutdown(), it could send func ctrl after enabling
  autosuspend.

Bluetooth: btusb_mtk_hci_wmt_sync() hci0: Execution of wmt command timed
out
Bluetooth: btusb_mtk_shutdown() hci0: Failed to send wmt func ctrl
(-110)

Signed-off-by: mark-yw.chen <mark-yw.chen@mediatek.com>
---
 drivers/bluetooth/btusb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 87b71740fad8..9e61395d1ff2 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2973,9 +2973,14 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 static int btusb_mtk_shutdown(struct hci_dev *hdev)
 {
 	struct btmtk_hci_wmt_params wmt_params;
+	struct btusb_data *data = hci_get_drvdata(hdev);
 	u8 param = 0;
 	int err;
 
+	err = usb_autopm_get_interface(data->intf);
+	if (err < 0)
+		return err;
+
 	/* Disable the device */
 	wmt_params.op = BTMTK_WMT_FUNC_CTRL;
 	wmt_params.flag = 0;
@@ -2986,9 +2991,11 @@ static int btusb_mtk_shutdown(struct hci_dev *hdev)
 	err = btusb_mtk_hci_wmt_sync(hdev, &wmt_params);
 	if (err < 0) {
 		bt_dev_err(hdev, "Failed to send wmt func ctrl (%d)", err);
+		usb_autopm_put_interface(data->intf);
 		return err;
 	}
 
+	usb_autopm_put_interface(data->intf);
 	return 0;
 }
 
-- 
2.18.0

