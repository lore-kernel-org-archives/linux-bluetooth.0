Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CDAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Oct 2021 21:30:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 447FE6113D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Oct 2021 21:30:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbhJRVct (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Oct 2021 17:32:49 -0400
Received: from mailgw02.mediatek.com ([216.200.240.185]:24721 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbhJRVct (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Oct 2021 17:32:49 -0400
X-UUID: 4caaa648d7ec4175b7851ca336735ebc-20211018
X-UUID: 4caaa648d7ec4175b7851ca336735ebc-20211018
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 730971796; Mon, 18 Oct 2021 14:30:35 -0700
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 18 Oct 2021 14:30:33 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 19 Oct 2021 05:30:32 +0800
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
Subject: [PATCH v2 02/10] Bluetooth: btmtksido: rely on BT_MTK module
Date:   Tue, 19 Oct 2021 05:30:13 +0800
Message-ID: <bc03fff4c15bd7f7ec39a6424addb10948c1fba6.1634592181.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1634592181.git.objelf@gmail.com>
References: <cover.1634592181.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Rely on btmtk module to reduce duplicated code

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/Kconfig     |   1 +
 drivers/bluetooth/btmtk.h     |   3 +
 drivers/bluetooth/btmtksdio.c | 192 +++++-----------------------------
 3 files changed, 28 insertions(+), 168 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 24c3aea4a7d6..36380e618ba4 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -388,6 +388,7 @@ config BT_ATH3K
 config BT_MTKSDIO
 	tristate "MediaTek HCI SDIO driver"
 	depends on MMC
+	select BT_MTK
 	help
 	  MediaTek Bluetooth HCI SDIO driver.
 	  This driver is required if you want to use MediaTek Bluetooth
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
index 87c25c6cf969..18f43c641b3b 100644
--- a/drivers/bluetooth/btmtk.h
+++ b/drivers/bluetooth/btmtk.h
@@ -9,6 +9,9 @@
 
 enum {
 	BTMTK_WMT_PATCH_DWNLD = 0x1,
+	BTMTK_WMT_TEST = 0x2,
+	BTMTK_WMT_WAKEUP = 0x3,
+	BTMTK_WMT_HIF = 0x4,
 	BTMTK_WMT_FUNC_CTRL = 0x6,
 	BTMTK_WMT_RST = 0x7,
 	BTMTK_WMT_SEMAPHORE = 0x17,
diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 9872ef18f9fe..53682a4c2ced 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -12,7 +12,6 @@
 
 #include <asm/unaligned.h>
 #include <linux/atomic.h>
-#include <linux/firmware.h>
 #include <linux/init.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
@@ -28,12 +27,10 @@
 #include <net/bluetooth/hci_core.h>
 
 #include "h4_recv.h"
+#include "btmtk.h"
 
 #define VERSION "0.1"
 
-#define FIRMWARE_MT7663		"mediatek/mt7663pr2h.bin"
-#define FIRMWARE_MT7668		"mediatek/mt7668pr2h.bin"
-
 #define MTKBTSDIO_AUTOSUSPEND_DELAY	8000
 
 static bool enable_autosuspend;
@@ -90,69 +87,12 @@ MODULE_DEVICE_TABLE(sdio, btmtksdio_table);
 
 #define BTMTKSDIO_TX_WAIT_VND_EVT	1
 
-enum {
-	MTK_WMT_PATCH_DWNLD = 0x1,
-	MTK_WMT_TEST = 0x2,
-	MTK_WMT_WAKEUP = 0x3,
-	MTK_WMT_HIF = 0x4,
-	MTK_WMT_FUNC_CTRL = 0x6,
-	MTK_WMT_RST = 0x7,
-	MTK_WMT_SEMAPHORE = 0x17,
-};
-
-enum {
-	BTMTK_WMT_INVALID,
-	BTMTK_WMT_PATCH_UNDONE,
-	BTMTK_WMT_PATCH_DONE,
-	BTMTK_WMT_ON_UNDONE,
-	BTMTK_WMT_ON_DONE,
-	BTMTK_WMT_ON_PROGRESS,
-};
-
 struct mtkbtsdio_hdr {
 	__le16	len;
 	__le16	reserved;
 	u8	bt_type;
 } __packed;
 
-struct mtk_wmt_hdr {
-	u8	dir;
-	u8	op;
-	__le16	dlen;
-	u8	flag;
-} __packed;
-
-struct mtk_hci_wmt_cmd {
-	struct mtk_wmt_hdr hdr;
-	u8 data[256];
-} __packed;
-
-struct btmtk_hci_wmt_evt {
-	struct hci_event_hdr hhdr;
-	struct mtk_wmt_hdr whdr;
-} __packed;
-
-struct btmtk_hci_wmt_evt_funcc {
-	struct btmtk_hci_wmt_evt hwhdr;
-	__be16 status;
-} __packed;
-
-struct btmtk_tci_sleep {
-	u8 mode;
-	__le16 duration;
-	__le16 host_duration;
-	u8 host_wakeup_pin;
-	u8 time_compensation;
-} __packed;
-
-struct btmtk_hci_wmt_params {
-	u8 op;
-	u8 flag;
-	u16 dlen;
-	const void *data;
-	u32 *status;
-};
-
 struct btmtksdio_dev {
 	struct hci_dev *hdev;
 	struct sdio_func *func;
@@ -174,27 +114,32 @@ static int mtk_hci_wmt_sync(struct hci_dev *hdev,
 	struct btmtk_hci_wmt_evt_funcc *wmt_evt_funcc;
 	u32 hlen, status = BTMTK_WMT_INVALID;
 	struct btmtk_hci_wmt_evt *wmt_evt;
-	struct mtk_hci_wmt_cmd wc;
-	struct mtk_wmt_hdr *hdr;
+	struct btmtk_hci_wmt_cmd *wc;
+	struct btmtk_wmt_hdr *hdr;
 	int err;
 
+	/* Send the WMT command and wait until the WMT event returns */
 	hlen = sizeof(*hdr) + wmt_params->dlen;
 	if (hlen > 255)
 		return -EINVAL;
 
-	hdr = (struct mtk_wmt_hdr *)&wc;
+	wc = kzalloc(hlen, GFP_KERNEL);
+	if (!wc)
+		return -ENOMEM;
+
+	hdr = &wc->hdr;
 	hdr->dir = 1;
 	hdr->op = wmt_params->op;
 	hdr->dlen = cpu_to_le16(wmt_params->dlen + 1);
 	hdr->flag = wmt_params->flag;
-	memcpy(wc.data, wmt_params->data, wmt_params->dlen);
+	memcpy(wc->data, wmt_params->data, wmt_params->dlen);
 
 	set_bit(BTMTKSDIO_TX_WAIT_VND_EVT, &bdev->tx_state);
 
-	err = __hci_cmd_send(hdev, 0xfc6f, hlen, &wc);
+	err = __hci_cmd_send(hdev, 0xfc6f, hlen, wc);
 	if (err < 0) {
 		clear_bit(BTMTKSDIO_TX_WAIT_VND_EVT, &bdev->tx_state);
-		return err;
+		goto err_free_wc;
 	}
 
 	/* The vendor specific WMT commands are all answered by a vendor
@@ -211,13 +156,14 @@ static int mtk_hci_wmt_sync(struct hci_dev *hdev,
 	if (err == -EINTR) {
 		bt_dev_err(hdev, "Execution of wmt command interrupted");
 		clear_bit(BTMTKSDIO_TX_WAIT_VND_EVT, &bdev->tx_state);
-		return err;
+		goto err_free_wc;
 	}
 
 	if (err) {
 		bt_dev_err(hdev, "Execution of wmt command timed out");
 		clear_bit(BTMTKSDIO_TX_WAIT_VND_EVT, &bdev->tx_state);
-		return -ETIMEDOUT;
+		err = -ETIMEDOUT;
+		goto err_free_wc;
 	}
 
 	/* Parse and handle the return WMT event */
@@ -230,13 +176,13 @@ static int mtk_hci_wmt_sync(struct hci_dev *hdev,
 	}
 
 	switch (wmt_evt->whdr.op) {
-	case MTK_WMT_SEMAPHORE:
+	case BTMTK_WMT_SEMAPHORE:
 		if (wmt_evt->whdr.flag == 2)
 			status = BTMTK_WMT_PATCH_UNDONE;
 		else
 			status = BTMTK_WMT_PATCH_DONE;
 		break;
-	case MTK_WMT_FUNC_CTRL:
+	case BTMTK_WMT_FUNC_CTRL:
 		wmt_evt_funcc = (struct btmtk_hci_wmt_evt_funcc *)wmt_evt;
 		if (be16_to_cpu(wmt_evt_funcc->status) == 0x404)
 			status = BTMTK_WMT_ON_DONE;
@@ -253,6 +199,8 @@ static int mtk_hci_wmt_sync(struct hci_dev *hdev,
 err_free_skb:
 	kfree_skb(bdev->evt_skb);
 	bdev->evt_skb = NULL;
+err_free_wc:
+	kfree(wc);
 
 	return err;
 }
@@ -663,7 +611,7 @@ static int btmtksdio_func_query(struct hci_dev *hdev)
 	u8 param = 0;
 
 	/* Query whether the function is enabled */
-	wmt_params.op = MTK_WMT_FUNC_CTRL;
+	wmt_params.op = BTMTK_WMT_FUNC_CTRL;
 	wmt_params.flag = 4;
 	wmt_params.dlen = sizeof(param);
 	wmt_params.data = &param;
@@ -678,96 +626,6 @@ static int btmtksdio_func_query(struct hci_dev *hdev)
 	return status;
 }
 
-static int mtk_setup_firmware(struct hci_dev *hdev, const char *fwname)
-{
-	struct btmtk_hci_wmt_params wmt_params;
-	const struct firmware *fw;
-	const u8 *fw_ptr;
-	size_t fw_size;
-	int err, dlen;
-	u8 flag, param;
-
-	err = request_firmware(&fw, fwname, &hdev->dev);
-	if (err < 0) {
-		bt_dev_err(hdev, "Failed to load firmware file (%d)", err);
-		return err;
-	}
-
-	/* Power on data RAM the firmware relies on. */
-	param = 1;
-	wmt_params.op = MTK_WMT_FUNC_CTRL;
-	wmt_params.flag = 3;
-	wmt_params.dlen = sizeof(param);
-	wmt_params.data = &param;
-	wmt_params.status = NULL;
-
-	err = mtk_hci_wmt_sync(hdev, &wmt_params);
-	if (err < 0) {
-		bt_dev_err(hdev, "Failed to power on data RAM (%d)", err);
-		goto free_fw;
-	}
-
-	fw_ptr = fw->data;
-	fw_size = fw->size;
-
-	/* The size of patch header is 30 bytes, should be skip */
-	if (fw_size < 30) {
-		err = -EINVAL;
-		goto free_fw;
-	}
-
-	fw_size -= 30;
-	fw_ptr += 30;
-	flag = 1;
-
-	wmt_params.op = MTK_WMT_PATCH_DWNLD;
-	wmt_params.status = NULL;
-
-	while (fw_size > 0) {
-		dlen = min_t(int, 250, fw_size);
-
-		/* Tell device the position in sequence */
-		if (fw_size - dlen <= 0)
-			flag = 3;
-		else if (fw_size < fw->size - 30)
-			flag = 2;
-
-		wmt_params.flag = flag;
-		wmt_params.dlen = dlen;
-		wmt_params.data = fw_ptr;
-
-		err = mtk_hci_wmt_sync(hdev, &wmt_params);
-		if (err < 0) {
-			bt_dev_err(hdev, "Failed to send wmt patch dwnld (%d)",
-				   err);
-			goto free_fw;
-		}
-
-		fw_size -= dlen;
-		fw_ptr += dlen;
-	}
-
-	wmt_params.op = MTK_WMT_RST;
-	wmt_params.flag = 4;
-	wmt_params.dlen = 0;
-	wmt_params.data = NULL;
-	wmt_params.status = NULL;
-
-	/* Activate funciton the firmware providing to */
-	err = mtk_hci_wmt_sync(hdev, &wmt_params);
-	if (err < 0) {
-		bt_dev_err(hdev, "Failed to send wmt rst (%d)", err);
-		goto free_fw;
-	}
-
-	/* Wait a few moments for firmware activation done */
-	usleep_range(10000, 12000);
-
-free_fw:
-	release_firmware(fw);
-	return err;
-}
-
 static int btmtksdio_setup(struct hci_dev *hdev)
 {
 	struct btmtksdio_dev *bdev = hci_get_drvdata(hdev);
@@ -782,7 +640,7 @@ static int btmtksdio_setup(struct hci_dev *hdev)
 	calltime = ktime_get();
 
 	/* Query whether the firmware is already download */
-	wmt_params.op = MTK_WMT_SEMAPHORE;
+	wmt_params.op = BTMTK_WMT_SEMAPHORE;
 	wmt_params.flag = 1;
 	wmt_params.dlen = 0;
 	wmt_params.data = NULL;
@@ -800,7 +658,7 @@ static int btmtksdio_setup(struct hci_dev *hdev)
 	}
 
 	/* Setup a firmware which the device definitely requires */
-	err = mtk_setup_firmware(hdev, bdev->data->fwname);
+	err = btmtk_setup_firmware(hdev, bdev->data->fwname, mtk_hci_wmt_sync);
 	if (err < 0)
 		return err;
 
@@ -823,7 +681,7 @@ static int btmtksdio_setup(struct hci_dev *hdev)
 	}
 
 	/* Enable Bluetooth protocol */
-	wmt_params.op = MTK_WMT_FUNC_CTRL;
+	wmt_params.op = BTMTK_WMT_FUNC_CTRL;
 	wmt_params.flag = 0;
 	wmt_params.dlen = sizeof(param);
 	wmt_params.data = &param;
@@ -891,7 +749,7 @@ static int btmtksdio_shutdown(struct hci_dev *hdev)
 	pm_runtime_get_sync(bdev->dev);
 
 	/* Disable the device */
-	wmt_params.op = MTK_WMT_FUNC_CTRL;
+	wmt_params.op = BTMTK_WMT_FUNC_CTRL;
 	wmt_params.flag = 0;
 	wmt_params.dlen = sizeof(param);
 	wmt_params.data = &param;
@@ -1112,5 +970,3 @@ MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
 MODULE_DESCRIPTION("MediaTek Bluetooth SDIO driver ver " VERSION);
 MODULE_VERSION(VERSION);
 MODULE_LICENSE("GPL");
-MODULE_FIRMWARE(FIRMWARE_MT7663);
-MODULE_FIRMWARE(FIRMWARE_MT7668);
-- 
2.25.1

