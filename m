Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEAAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 22:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0209961038
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 22:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243777AbhJHWXn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Oct 2021 18:23:43 -0400
Received: from mailgw01.mediatek.com ([216.200.240.184]:41570 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243768AbhJHWXf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Oct 2021 18:23:35 -0400
X-UUID: b6b57755fc5742609ab90e271b4b8db8-20211008
X-UUID: b6b57755fc5742609ab90e271b4b8db8-20211008
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 145919019; Fri, 08 Oct 2021 15:20:32 -0700
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 8 Oct 2021 15:11:05 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 9 Oct 2021 06:11:05 +0800
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
Subject: [PATCH v1 10/10] Bluetooth: btmtksdio: add MT7921s Bluetooth support
Date:   Sat, 9 Oct 2021 06:10:17 +0800
Message-ID: <cae32b7d93a13273c7610ce7c2b82129847ee587.1633728573.git.objelf@gmail.com>
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

add MT7921s Bluetooth support

Co-developed-by: Mark-yw Chen <mark-yw.chen@mediatek.com>
Signed-off-by: Mark-yw Chen <mark-yw.chen@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/btmtk.h     |   1 +
 drivers/bluetooth/btmtksdio.c | 141 ++++++++++++++++++++++++++++++++--
 2 files changed, 134 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index 18f43c641b3b..d6913657d552 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -14,6 +14,7 @@ enum {
 	BTMTK_WMT_HIF = 0x4,
 	BTMTK_WMT_FUNC_CTRL = 0x6,
 	BTMTK_WMT_RST = 0x7,
+	BTMTK_WMT_REGISTER = 0x8,
 	BTMTK_WMT_SEMAPHORE = 0x17,
 };
 
diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 3266c5d83cae..86568fba1d2b 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -37,14 +37,22 @@ static bool enable_autosuspend;
 
 struct btmtksdio_data {
 	const char *fwname;
+	u16 chipid;
 };
 
 static const struct btmtksdio_data mt7663_data = {
 	.fwname = FIRMWARE_MT7663,
+	.chipid = 0x7663,
 };
 
 static const struct btmtksdio_data mt7668_data = {
 	.fwname = FIRMWARE_MT7668,
+	.chipid = 0x7668,
+};
+
+static const struct btmtksdio_data mt7961_data = {
+	.fwname = FIRMWARE_MT7961,
+	.chipid = 0x7921,
 };
 
 static const struct sdio_device_id btmtksdio_table[] = {
@@ -52,6 +60,8 @@ static const struct sdio_device_id btmtksdio_table[] = {
 	 .driver_data = (kernel_ulong_t)&mt7663_data },
 	{SDIO_DEVICE(SDIO_VENDOR_ID_MEDIATEK, SDIO_DEVICE_ID_MEDIATEK_MT7668),
 	 .driver_data = (kernel_ulong_t)&mt7668_data },
+	{SDIO_DEVICE(SDIO_VENDOR_ID_MEDIATEK, SDIO_DEVICE_ID_MEDIATEK_MT7961),
+	 .driver_data = (kernel_ulong_t)&mt7961_data },
 	{ }	/* Terminating entry */
 };
 MODULE_DEVICE_TABLE(sdio, btmtksdio_table);
@@ -194,6 +204,20 @@ static int mtk_hci_wmt_sync(struct hci_dev *hdev,
 		else
 			status = BTMTK_WMT_ON_UNDONE;
 		break;
+	case BTMTK_WMT_PATCH_DWNLD:
+		if (wmt_evt->whdr.flag == 2)
+			status = BTMTK_WMT_PATCH_DONE;
+		else if (wmt_evt->whdr.flag == 1)
+			status = BTMTK_WMT_PATCH_PROGRESS;
+		else
+			status = BTMTK_WMT_PATCH_UNDONE;
+		break;
+	case BTMTK_WMT_REGISTER:
+		if (bdev->evt_skb->len == 18) {
+			memcpy(&status, bdev->evt_skb->data + 14, sizeof(u32));
+			status = le32_to_cpu(status);
+		}
+		break;
 	}
 
 	if (wmt_params->status)
@@ -634,20 +658,14 @@ static int btmtksdio_func_query(struct hci_dev *hdev)
 	return status;
 }
 
-static int btmtksdio_setup(struct hci_dev *hdev)
+static int mt76xx_setup(struct hci_dev *hdev, const char *fwname)
 {
-	struct btmtksdio_dev *bdev = hci_get_drvdata(hdev);
 	struct btmtk_hci_wmt_params wmt_params;
-	ktime_t calltime, delta, rettime;
 	struct btmtk_tci_sleep tci_sleep;
-	unsigned long long duration;
 	struct sk_buff *skb;
 	int err, status;
 	u8 param = 0x1;
 
-	calltime = ktime_get();
-	bdev->hw_tx_ready = true;
-
 	/* Query whether the firmware is already download */
 	wmt_params.op = BTMTK_WMT_SEMAPHORE;
 	wmt_params.flag = 1;
@@ -667,7 +685,7 @@ static int btmtksdio_setup(struct hci_dev *hdev)
 	}
 
 	/* Setup a firmware which the device definitely requires */
-	err = btmtk_setup_firmware(hdev, bdev->data->fwname, mtk_hci_wmt_sync);
+	err = btmtk_setup_firmware(hdev, fwname, mtk_hci_wmt_sync);
 	if (err < 0)
 		return err;
 
@@ -719,6 +737,113 @@ static int btmtksdio_setup(struct hci_dev *hdev)
 	}
 	kfree_skb(skb);
 
+	return 0;
+}
+
+static int mt79xx_setup(struct hci_dev *hdev, const char *fwname)
+{
+	struct btmtk_hci_wmt_params wmt_params;
+	u8 param = 0x1;
+	int err;
+
+	err = btmtk_setup_firmware_79xx(hdev, fwname, mtk_hci_wmt_sync);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to setup 79xx firmware (%d)", err);
+		return err;
+	}
+
+	/* Enable Bluetooth protocol */
+	wmt_params.op = BTMTK_WMT_FUNC_CTRL;
+	wmt_params.flag = 0;
+	wmt_params.dlen = sizeof(param);
+	wmt_params.data = &param;
+	wmt_params.status = NULL;
+
+	err = mtk_hci_wmt_sync(hdev, &wmt_params);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to send wmt func ctrl (%d)", err);
+		return err;
+	}
+
+	return err;
+}
+
+static int btsdio_mtk_reg_read(struct hci_dev *hdev, u32 reg, u32 *val)
+{
+	struct btmtk_hci_wmt_params wmt_params;
+	struct reg_read_cmd {
+		u8 type;
+		u8 rsv;
+		u8 num;
+		__le32 addr;
+	} __packed reg_read = {
+		.type = 1,
+		.num = 1,
+	};
+
+	int err, status;
+
+	reg_read.addr = cpu_to_le32(reg);
+	wmt_params.op = BTMTK_WMT_REGISTER;
+	wmt_params.flag = 2;
+	wmt_params.dlen = 7;
+	wmt_params.data = &reg_read;
+	wmt_params.status = &status;
+
+	err = mtk_hci_wmt_sync(hdev, &wmt_params);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to read reg(%d)", err);
+		return err;
+	}
+
+	*val = status;
+
+	return err;
+}
+
+static int btmtksdio_setup(struct hci_dev *hdev)
+{
+	struct btmtksdio_dev *bdev = hci_get_drvdata(hdev);
+	ktime_t calltime, delta, rettime;
+	unsigned long long duration;
+	char fwname[64];
+	int err, dev_id;
+	u32 fw_version = 0;
+
+	calltime = ktime_get();
+	bdev->hw_tx_ready = true;
+
+	switch (bdev->data->chipid) {
+	case 0x7921:
+		err = btsdio_mtk_reg_read(hdev, 0x70010200, &dev_id);
+		if (err < 0) {
+			bt_dev_err(hdev, "Failed to get device id (%d)", err);
+			return err;
+		}
+
+		err = btsdio_mtk_reg_read(hdev, 0x80021004, &fw_version);
+		if (err < 0) {
+			bt_dev_err(hdev, "Failed to get fw version (%d)", err);
+			return err;
+		}
+
+		snprintf(fwname, sizeof(fwname),
+			 "mediatek/BT_RAM_CODE_MT%04x_1_%x_hdr.bin",
+			 dev_id & 0xffff, (fw_version & 0xff) + 1);
+		err = mt79xx_setup(hdev, fwname);
+		if (err < 0)
+			return err;
+		break;
+	case 0x7663:
+	case 0x7668:
+		err = mt76xx_setup(hdev, bdev->data->fwname);
+		if (err < 0)
+			return err;
+		break;
+	default:
+		return -ENODEV;
+	}
+
 	rettime = ktime_get();
 	delta = ktime_sub(rettime, calltime);
 	duration = (unsigned long long)ktime_to_ns(delta) >> 10;
-- 
2.25.1

