Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2927BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Oct 2021 21:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0464D60F11
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Oct 2021 21:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhJRVjt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Oct 2021 17:39:49 -0400
Received: from mailgw02.mediatek.com ([216.200.240.185]:26640 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbhJRVjr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Oct 2021 17:39:47 -0400
X-UUID: eb5871de9be64c6bb285f517cd5b2737-20211018
X-UUID: eb5871de9be64c6bb285f517cd5b2737-20211018
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (musrelay.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1459930928; Mon, 18 Oct 2021 14:37:31 -0700
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 18 Oct 2021 14:30:29 -0700
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 19 Oct 2021 05:30:27 +0800
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
Subject: [PATCH v2 01/10] Bluetooth: mediatek: add BT_MTK module
Date:   Tue, 19 Oct 2021 05:30:12 +0800
Message-ID: <d980cc36abbb8b0d4b67e119768ffc6811af54ff.1634592181.git.objelf@gmail.com>
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

Add BT_MTK module that is a preliminary patch to introduce mt7921s support
to share the logic betweem btusb and btmtksdio.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/bluetooth/Kconfig  |   5 +
 drivers/bluetooth/Makefile |   1 +
 drivers/bluetooth/btmtk.c  | 289 ++++++++++++++++++++++++++++++++
 drivers/bluetooth/btmtk.h  |  97 +++++++++++
 drivers/bluetooth/btusb.c  | 331 +------------------------------------
 5 files changed, 398 insertions(+), 325 deletions(-)
 create mode 100644 drivers/bluetooth/btmtk.c
 create mode 100644 drivers/bluetooth/btmtk.h

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 851842372c9b..24c3aea4a7d6 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -19,6 +19,10 @@ config BT_QCA
 	tristate
 	select FW_LOADER
 
+config BT_MTK
+	tristate
+	select FW_LOADER
+
 config BT_HCIBTUSB
 	tristate "HCI USB driver"
 	depends on USB
@@ -55,6 +59,7 @@ config BT_HCIBTUSB_BCM
 config BT_HCIBTUSB_MTK
 	bool "MediaTek protocol support"
 	depends on BT_HCIBTUSB
+	select BT_MTK
 	default n
 	help
 	  The MediaTek protocol support enables firmware download
diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index 16286ea2655d..3321a8aea4a0 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_BT_QCOMSMD)	+= btqcomsmd.o
 obj-$(CONFIG_BT_BCM)		+= btbcm.o
 obj-$(CONFIG_BT_RTL)		+= btrtl.o
 obj-$(CONFIG_BT_QCA)		+= btqca.o
+obj-$(CONFIG_BT_MTK)		+= btmtk.o
 
 obj-$(CONFIG_BT_VIRTIO)		+= virtio_bt.o
 
diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
new file mode 100644
index 000000000000..c2ee5c4b975a
--- /dev/null
+++ b/drivers/bluetooth/btmtk.c
@@ -0,0 +1,289 @@
+// SPDX-License-Identifier: ISC
+/* Copyright (C) 2021 MediaTek Inc.
+ *
+ */
+#include <linux/module.h>
+#include <linux/firmware.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#include "btmtk.h"
+
+#define VERSION "0.1"
+
+/* It is for mt79xx download rom patch*/
+#define MTK_FW_ROM_PATCH_HEADER_SIZE	32
+#define MTK_FW_ROM_PATCH_GD_SIZE	64
+#define MTK_FW_ROM_PATCH_SEC_MAP_SIZE	64
+#define MTK_SEC_MAP_COMMON_SIZE	12
+#define MTK_SEC_MAP_NEED_SEND_SIZE	52
+
+struct btmtk_patch_header {
+	u8 datetime[16];
+	u8 platform[4];
+	__le16 hwver;
+	__le16 swver;
+	__le32 magicnum;
+} __packed;
+
+struct btmtk_global_desc {
+	__le32 patch_ver;
+	__le32 sub_sys;
+	__le32 feature_opt;
+	__le32 section_num;
+} __packed;
+
+struct btmtk_section_map {
+	__le32 sectype;
+	__le32 secoffset;
+	__le32 secsize;
+	union {
+		__le32 u4SecSpec[13];
+		struct {
+			__le32 dlAddr;
+			__le32 dlsize;
+			__le32 seckeyidx;
+			__le32 alignlen;
+			__le32 sectype;
+			__le32 dlmodecrctype;
+			__le32 crc;
+			__le32 reserved[6];
+		} bin_info_spec;
+	};
+} __packed;
+
+int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
+			      wmt_cmd_sync_func_t wmt_cmd_sync)
+{
+	struct btmtk_hci_wmt_params wmt_params;
+	struct btmtk_global_desc *globaldesc = NULL;
+	struct btmtk_section_map *sectionmap;
+	const struct firmware *fw;
+	const u8 *fw_ptr;
+	const u8 *fw_bin_ptr;
+	int err, dlen, i, status;
+	u8 flag, first_block, retry;
+	u32 section_num, dl_size, section_offset;
+	u8 cmd[64];
+
+	err = request_firmware(&fw, fwname, &hdev->dev);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to load firmware file (%d)", err);
+		return err;
+	}
+
+	fw_ptr = fw->data;
+	fw_bin_ptr = fw_ptr;
+	globaldesc = (struct btmtk_global_desc *)(fw_ptr + MTK_FW_ROM_PATCH_HEADER_SIZE);
+	section_num = le32_to_cpu(globaldesc->section_num);
+
+	for (i = 0; i < section_num; i++) {
+		first_block = 1;
+		fw_ptr = fw_bin_ptr;
+		sectionmap = (struct btmtk_section_map *)(fw_ptr + MTK_FW_ROM_PATCH_HEADER_SIZE +
+			      MTK_FW_ROM_PATCH_GD_SIZE + MTK_FW_ROM_PATCH_SEC_MAP_SIZE * i);
+
+		section_offset = le32_to_cpu(sectionmap->secoffset);
+		dl_size = le32_to_cpu(sectionmap->bin_info_spec.dlsize);
+
+		if (dl_size > 0) {
+			retry = 20;
+			while (retry > 0) {
+				cmd[0] = 0; /* 0 means legacy dl mode. */
+				memcpy(cmd + 1,
+				       fw_ptr + MTK_FW_ROM_PATCH_HEADER_SIZE +
+				       MTK_FW_ROM_PATCH_GD_SIZE +
+				       MTK_FW_ROM_PATCH_SEC_MAP_SIZE * i +
+				       MTK_SEC_MAP_COMMON_SIZE,
+				       MTK_SEC_MAP_NEED_SEND_SIZE + 1);
+
+				wmt_params.op = BTMTK_WMT_PATCH_DWNLD;
+				wmt_params.status = &status;
+				wmt_params.flag = 0;
+				wmt_params.dlen = MTK_SEC_MAP_NEED_SEND_SIZE + 1;
+				wmt_params.data = &cmd;
+
+				err = wmt_cmd_sync(hdev, &wmt_params);
+				if (err < 0) {
+					bt_dev_err(hdev, "Failed to send wmt patch dwnld (%d)",
+						   err);
+					goto err_release_fw;
+				}
+
+				if (status == BTMTK_WMT_PATCH_UNDONE) {
+					break;
+				} else if (status == BTMTK_WMT_PATCH_PROGRESS) {
+					msleep(100);
+					retry--;
+				} else if (status == BTMTK_WMT_PATCH_DONE) {
+					goto next_section;
+				} else {
+					bt_dev_err(hdev, "Failed wmt patch dwnld status (%d)",
+						   status);
+					goto err_release_fw;
+				}
+			}
+
+			fw_ptr += section_offset;
+			wmt_params.op = BTMTK_WMT_PATCH_DWNLD;
+			wmt_params.status = NULL;
+
+			while (dl_size > 0) {
+				dlen = min_t(int, 250, dl_size);
+				if (first_block == 1) {
+					flag = 1;
+					first_block = 0;
+				} else if (dl_size - dlen <= 0) {
+					flag = 3;
+				} else {
+					flag = 2;
+				}
+
+				wmt_params.flag = flag;
+				wmt_params.dlen = dlen;
+				wmt_params.data = fw_ptr;
+
+				err = wmt_cmd_sync(hdev, &wmt_params);
+				if (err < 0) {
+					bt_dev_err(hdev, "Failed to send wmt patch dwnld (%d)",
+						   err);
+					goto err_release_fw;
+				}
+
+				dl_size -= dlen;
+				fw_ptr += dlen;
+			}
+		}
+next_section:
+		continue;
+	}
+	/* Wait a few moments for firmware activation done */
+	usleep_range(100000, 120000);
+
+err_release_fw:
+	release_firmware(fw);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(btmtk_setup_firmware_79xx);
+
+int btmtk_setup_firmware(struct hci_dev *hdev, const char *fwname,
+			 wmt_cmd_sync_func_t wmt_cmd_sync)
+{
+	struct btmtk_hci_wmt_params wmt_params;
+	const struct firmware *fw;
+	const u8 *fw_ptr;
+	size_t fw_size;
+	int err, dlen;
+	u8 flag, param;
+
+	err = request_firmware(&fw, fwname, &hdev->dev);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to load firmware file (%d)", err);
+		return err;
+	}
+
+	/* Power on data RAM the firmware relies on. */
+	param = 1;
+	wmt_params.op = BTMTK_WMT_FUNC_CTRL;
+	wmt_params.flag = 3;
+	wmt_params.dlen = sizeof(param);
+	wmt_params.data = &param;
+	wmt_params.status = NULL;
+
+	err = wmt_cmd_sync(hdev, &wmt_params);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to power on data RAM (%d)", err);
+		goto err_release_fw;
+	}
+
+	fw_ptr = fw->data;
+	fw_size = fw->size;
+
+	/* The size of patch header is 30 bytes, should be skip */
+	if (fw_size < 30) {
+		err = -EINVAL;
+		goto err_release_fw;
+	}
+
+	fw_size -= 30;
+	fw_ptr += 30;
+	flag = 1;
+
+	wmt_params.op = BTMTK_WMT_PATCH_DWNLD;
+	wmt_params.status = NULL;
+
+	while (fw_size > 0) {
+		dlen = min_t(int, 250, fw_size);
+
+		/* Tell device the position in sequence */
+		if (fw_size - dlen <= 0)
+			flag = 3;
+		else if (fw_size < fw->size - 30)
+			flag = 2;
+
+		wmt_params.flag = flag;
+		wmt_params.dlen = dlen;
+		wmt_params.data = fw_ptr;
+
+		err = wmt_cmd_sync(hdev, &wmt_params);
+		if (err < 0) {
+			bt_dev_err(hdev, "Failed to send wmt patch dwnld (%d)",
+				   err);
+			goto err_release_fw;
+		}
+
+		fw_size -= dlen;
+		fw_ptr += dlen;
+	}
+
+	wmt_params.op = BTMTK_WMT_RST;
+	wmt_params.flag = 4;
+	wmt_params.dlen = 0;
+	wmt_params.data = NULL;
+	wmt_params.status = NULL;
+
+	/* Activate funciton the firmware providing to */
+	err = wmt_cmd_sync(hdev, &wmt_params);
+	if (err < 0) {
+		bt_dev_err(hdev, "Failed to send wmt rst (%d)", err);
+		goto err_release_fw;
+	}
+
+	/* Wait a few moments for firmware activation done */
+	usleep_range(10000, 12000);
+
+err_release_fw:
+	release_firmware(fw);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(btmtk_setup_firmware);
+
+int btmtk_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
+{
+	struct sk_buff *skb;
+	long ret;
+
+	skb = __hci_cmd_sync(hdev, 0xfc1a, 6, bdaddr, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		ret = PTR_ERR(skb);
+		bt_dev_err(hdev, "changing Mediatek device address failed (%ld)",
+			   ret);
+		return ret;
+	}
+	kfree_skb(skb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btmtk_set_bdaddr);
+
+MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
+MODULE_AUTHOR("Mark Chen <mark-yw.chen@mediatek.com>");
+MODULE_DESCRIPTION("Bluetooth support for MediaTek devices ver " VERSION);
+MODULE_VERSION(VERSION);
+MODULE_LICENSE("GPL");
+MODULE_FIRMWARE(FIRMWARE_MT7663);
+MODULE_FIRMWARE(FIRMWARE_MT7668);
+MODULE_FIRMWARE(FIRMWARE_MT7961);
diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
new file mode 100644
index 000000000000..87c25c6cf969
--- /dev/null
+++ b/drivers/bluetooth/btmtk.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: ISC */
+/* Copyright (C) 2021 MediaTek Inc. */
+
+#define FIRMWARE_MT7663		"mediatek/mt7663pr2h.bin"
+#define FIRMWARE_MT7668		"mediatek/mt7668pr2h.bin"
+#define FIRMWARE_MT7961		"mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin"
+
+#define HCI_WMT_MAX_EVENT_SIZE		64
+
+enum {
+	BTMTK_WMT_PATCH_DWNLD = 0x1,
+	BTMTK_WMT_FUNC_CTRL = 0x6,
+	BTMTK_WMT_RST = 0x7,
+	BTMTK_WMT_SEMAPHORE = 0x17,
+};
+
+enum {
+	BTMTK_WMT_INVALID,
+	BTMTK_WMT_PATCH_UNDONE,
+	BTMTK_WMT_PATCH_PROGRESS,
+	BTMTK_WMT_PATCH_DONE,
+	BTMTK_WMT_ON_UNDONE,
+	BTMTK_WMT_ON_DONE,
+	BTMTK_WMT_ON_PROGRESS,
+};
+
+struct btmtk_wmt_hdr {
+	u8	dir;
+	u8	op;
+	__le16	dlen;
+	u8	flag;
+} __packed;
+
+struct btmtk_hci_wmt_cmd {
+	struct btmtk_wmt_hdr hdr;
+	u8 data[];
+} __packed;
+
+struct btmtk_hci_wmt_evt {
+	struct hci_event_hdr hhdr;
+	struct btmtk_wmt_hdr whdr;
+} __packed;
+
+struct btmtk_hci_wmt_evt_funcc {
+	struct btmtk_hci_wmt_evt hwhdr;
+	__be16 status;
+} __packed;
+
+struct btmtk_tci_sleep {
+	u8 mode;
+	__le16 duration;
+	__le16 host_duration;
+	u8 host_wakeup_pin;
+	u8 time_compensation;
+} __packed;
+
+struct btmtk_hci_wmt_params {
+	u8 op;
+	u8 flag;
+	u16 dlen;
+	const void *data;
+	u32 *status;
+};
+
+typedef int (*wmt_cmd_sync_func_t)(struct hci_dev *,
+				   struct btmtk_hci_wmt_params *);
+
+#if IS_ENABLED(CONFIG_BT_MTK)
+
+int btmtk_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
+
+int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
+			      wmt_cmd_sync_func_t wmt_cmd_sync);
+
+int btmtk_setup_firmware(struct hci_dev *hdev, const char *fwname,
+			 wmt_cmd_sync_func_t wmt_cmd_sync);
+#else
+
+static inline int btmtk_set_bdaddr(struct hci_dev *hdev,
+				   const bdaddr_t *bdaddr)
+{
+	return -EOPNOTSUPP;
+}
+
+static int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
+				     wmt_cmd_sync_func_t wmt_cmd_sync)
+{
+	return -EOPNOTSUPP;
+}
+
+static int btmtk_setup_firmware(struct hci_dev *hdev, const char *fwname,
+				wmt_cmd_sync_func_t wmt_cmd_sync)
+{
+	return -EOPNOTSUPP;
+}
+
+#endif
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 87b71740fad8..88bfdf1347a7 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -24,6 +24,7 @@
 #include "btintel.h"
 #include "btbcm.h"
 #include "btrtl.h"
+#include "btmtk.h"
 
 #define VERSION "0.8"
 
@@ -2131,122 +2132,6 @@ static int btusb_send_frame_intel(struct hci_dev *hdev, struct sk_buff *skb)
 #define MTK_BT_RST_DONE		0x00000100
 #define MTK_BT_RESET_WAIT_MS	100
 #define MTK_BT_RESET_NUM_TRIES	10
-#define FIRMWARE_MT7663		"mediatek/mt7663pr2h.bin"
-#define FIRMWARE_MT7668		"mediatek/mt7668pr2h.bin"
-
-#define HCI_WMT_MAX_EVENT_SIZE		64
-/* It is for mt79xx download rom patch*/
-#define MTK_FW_ROM_PATCH_HEADER_SIZE	32
-#define MTK_FW_ROM_PATCH_GD_SIZE	64
-#define MTK_FW_ROM_PATCH_SEC_MAP_SIZE	64
-#define MTK_SEC_MAP_COMMON_SIZE	12
-#define MTK_SEC_MAP_NEED_SEND_SIZE	52
-
-enum {
-	BTMTK_WMT_PATCH_DWNLD = 0x1,
-	BTMTK_WMT_FUNC_CTRL = 0x6,
-	BTMTK_WMT_RST = 0x7,
-	BTMTK_WMT_SEMAPHORE = 0x17,
-};
-
-enum {
-	BTMTK_WMT_INVALID,
-	BTMTK_WMT_PATCH_UNDONE,
-	BTMTK_WMT_PATCH_PROGRESS,
-	BTMTK_WMT_PATCH_DONE,
-	BTMTK_WMT_ON_UNDONE,
-	BTMTK_WMT_ON_DONE,
-	BTMTK_WMT_ON_PROGRESS,
-};
-
-struct btmtk_wmt_hdr {
-	u8	dir;
-	u8	op;
-	__le16	dlen;
-	u8	flag;
-} __packed;
-
-struct btmtk_hci_wmt_cmd {
-	struct btmtk_wmt_hdr hdr;
-	u8 data[];
-} __packed;
-
-struct btmtk_hci_wmt_evt {
-	struct hci_event_hdr hhdr;
-	struct btmtk_wmt_hdr whdr;
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
-struct btmtk_patch_header {
-	u8 datetime[16];
-	u8 platform[4];
-	__le16 hwver;
-	__le16 swver;
-	__le32 magicnum;
-} __packed;
-
-struct btmtk_global_desc {
-	__le32 patch_ver;
-	__le32 sub_sys;
-	__le32 feature_opt;
-	__le32 section_num;
-} __packed;
-
-struct btmtk_section_map {
-	__le32 sectype;
-	__le32 secoffset;
-	__le32 secsize;
-	union {
-		__le32 u4SecSpec[13];
-		struct {
-			__le32 dlAddr;
-			__le32 dlsize;
-			__le32 seckeyidx;
-			__le32 alignlen;
-			__le32 sectype;
-			__le32 dlmodecrctype;
-			__le32 crc;
-			__le32 reserved[6];
-		} bin_info_spec;
-	};
-} __packed;
-
-static int btusb_set_bdaddr_mtk(struct hci_dev *hdev, const bdaddr_t *bdaddr)
-{
-	struct sk_buff *skb;
-	long ret;
-
-	skb = __hci_cmd_sync(hdev, 0xfc1a, 6, bdaddr, HCI_INIT_TIMEOUT);
-	if (IS_ERR(skb)) {
-		ret = PTR_ERR(skb);
-		bt_dev_err(hdev, "changing Mediatek device address failed (%ld)",
-			   ret);
-		return ret;
-	}
-	kfree_skb(skb);
-
-	return 0;
-}
 
 static void btusb_mtk_wmt_recv(struct urb *urb)
 {
@@ -2502,209 +2387,6 @@ static int btusb_mtk_hci_wmt_sync(struct hci_dev *hdev,
 	return err;
 }
 
-static int btusb_mtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname)
-{
-	struct btmtk_hci_wmt_params wmt_params;
-	struct btmtk_global_desc *globaldesc = NULL;
-	struct btmtk_section_map *sectionmap;
-	const struct firmware *fw;
-	const u8 *fw_ptr;
-	const u8 *fw_bin_ptr;
-	int err, dlen, i, status;
-	u8 flag, first_block, retry;
-	u32 section_num, dl_size, section_offset;
-	u8 cmd[64];
-
-	err = request_firmware(&fw, fwname, &hdev->dev);
-	if (err < 0) {
-		bt_dev_err(hdev, "Failed to load firmware file (%d)", err);
-		return err;
-	}
-
-	fw_ptr = fw->data;
-	fw_bin_ptr = fw_ptr;
-	globaldesc = (struct btmtk_global_desc *)(fw_ptr + MTK_FW_ROM_PATCH_HEADER_SIZE);
-	section_num = le32_to_cpu(globaldesc->section_num);
-
-	for (i = 0; i < section_num; i++) {
-		first_block = 1;
-		fw_ptr = fw_bin_ptr;
-		sectionmap = (struct btmtk_section_map *)(fw_ptr + MTK_FW_ROM_PATCH_HEADER_SIZE +
-			      MTK_FW_ROM_PATCH_GD_SIZE + MTK_FW_ROM_PATCH_SEC_MAP_SIZE * i);
-
-		section_offset = le32_to_cpu(sectionmap->secoffset);
-		dl_size = le32_to_cpu(sectionmap->bin_info_spec.dlsize);
-
-		if (dl_size > 0) {
-			retry = 20;
-			while (retry > 0) {
-				cmd[0] = 0; /* 0 means legacy dl mode. */
-				memcpy(cmd + 1,
-				       fw_ptr + MTK_FW_ROM_PATCH_HEADER_SIZE +
-				       MTK_FW_ROM_PATCH_GD_SIZE + MTK_FW_ROM_PATCH_SEC_MAP_SIZE * i +
-				       MTK_SEC_MAP_COMMON_SIZE,
-				       MTK_SEC_MAP_NEED_SEND_SIZE + 1);
-
-				wmt_params.op = BTMTK_WMT_PATCH_DWNLD;
-				wmt_params.status = &status;
-				wmt_params.flag = 0;
-				wmt_params.dlen = MTK_SEC_MAP_NEED_SEND_SIZE + 1;
-				wmt_params.data = &cmd;
-
-				err = btusb_mtk_hci_wmt_sync(hdev, &wmt_params);
-				if (err < 0) {
-					bt_dev_err(hdev, "Failed to send wmt patch dwnld (%d)",
-						   err);
-					goto err_release_fw;
-				}
-
-				if (status == BTMTK_WMT_PATCH_UNDONE) {
-					break;
-				} else if (status == BTMTK_WMT_PATCH_PROGRESS) {
-					msleep(100);
-					retry--;
-				} else if (status == BTMTK_WMT_PATCH_DONE) {
-					goto next_section;
-				} else {
-					bt_dev_err(hdev, "Failed wmt patch dwnld status (%d)",
-						   status);
-					goto err_release_fw;
-				}
-			}
-
-			fw_ptr += section_offset;
-			wmt_params.op = BTMTK_WMT_PATCH_DWNLD;
-			wmt_params.status = NULL;
-
-			while (dl_size > 0) {
-				dlen = min_t(int, 250, dl_size);
-				if (first_block == 1) {
-					flag = 1;
-					first_block = 0;
-				} else if (dl_size - dlen <= 0) {
-					flag = 3;
-				} else {
-					flag = 2;
-				}
-
-				wmt_params.flag = flag;
-				wmt_params.dlen = dlen;
-				wmt_params.data = fw_ptr;
-
-				err = btusb_mtk_hci_wmt_sync(hdev, &wmt_params);
-				if (err < 0) {
-					bt_dev_err(hdev, "Failed to send wmt patch dwnld (%d)",
-						   err);
-					goto err_release_fw;
-				}
-
-				dl_size -= dlen;
-				fw_ptr += dlen;
-			}
-		}
-next_section:
-		continue;
-	}
-	/* Wait a few moments for firmware activation done */
-	usleep_range(100000, 120000);
-
-err_release_fw:
-	release_firmware(fw);
-
-	return err;
-}
-
-static int btusb_mtk_setup_firmware(struct hci_dev *hdev, const char *fwname)
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
-	wmt_params.op = BTMTK_WMT_FUNC_CTRL;
-	wmt_params.flag = 3;
-	wmt_params.dlen = sizeof(param);
-	wmt_params.data = &param;
-	wmt_params.status = NULL;
-
-	err = btusb_mtk_hci_wmt_sync(hdev, &wmt_params);
-	if (err < 0) {
-		bt_dev_err(hdev, "Failed to power on data RAM (%d)", err);
-		goto err_release_fw;
-	}
-
-	fw_ptr = fw->data;
-	fw_size = fw->size;
-
-	/* The size of patch header is 30 bytes, should be skip */
-	if (fw_size < 30) {
-		err = -EINVAL;
-		goto err_release_fw;
-	}
-
-	fw_size -= 30;
-	fw_ptr += 30;
-	flag = 1;
-
-	wmt_params.op = BTMTK_WMT_PATCH_DWNLD;
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
-		err = btusb_mtk_hci_wmt_sync(hdev, &wmt_params);
-		if (err < 0) {
-			bt_dev_err(hdev, "Failed to send wmt patch dwnld (%d)",
-				   err);
-			goto err_release_fw;
-		}
-
-		fw_size -= dlen;
-		fw_ptr += dlen;
-	}
-
-	wmt_params.op = BTMTK_WMT_RST;
-	wmt_params.flag = 4;
-	wmt_params.dlen = 0;
-	wmt_params.data = NULL;
-	wmt_params.status = NULL;
-
-	/* Activate funciton the firmware providing to */
-	err = btusb_mtk_hci_wmt_sync(hdev, &wmt_params);
-	if (err < 0) {
-		bt_dev_err(hdev, "Failed to send wmt rst (%d)", err);
-		goto err_release_fw;
-	}
-
-	/* Wait a few moments for firmware activation done */
-	usleep_range(10000, 12000);
-
-err_release_fw:
-	release_firmware(fw);
-
-	return err;
-}
-
 static int btusb_mtk_func_query(struct hci_dev *hdev)
 {
 	struct btmtk_hci_wmt_params wmt_params;
@@ -2862,7 +2544,8 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 		snprintf(fw_bin_name, sizeof(fw_bin_name),
 			"mediatek/BT_RAM_CODE_MT%04x_1_%x_hdr.bin",
 			 dev_id & 0xffff, (fw_version & 0xff) + 1);
-		err = btusb_mtk_setup_firmware_79xx(hdev, fw_bin_name);
+		err = btmtk_setup_firmware_79xx(hdev, fw_bin_name,
+						btusb_mtk_hci_wmt_sync);
 
 		/* It's Device EndPoint Reset Option Register */
 		btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, MTK_EP_RST_IN_OUT_OPT);
@@ -2908,7 +2591,8 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
 	}
 
 	/* Setup a firmware which the device definitely requires */
-	err = btusb_mtk_setup_firmware(hdev, fwname);
+	err = btmtk_setup_firmware(hdev, fwname,
+				   btusb_mtk_hci_wmt_sync);
 	if (err < 0)
 		return err;
 
@@ -3069,9 +2753,6 @@ static int btusb_recv_acl_mtk(struct hci_dev *hdev, struct sk_buff *skb)
 	return hci_recv_frame(hdev, skb);
 }
 
-MODULE_FIRMWARE(FIRMWARE_MT7663);
-MODULE_FIRMWARE(FIRMWARE_MT7668);
-
 #ifdef CONFIG_PM
 /* Configure an out-of-band gpio as wake-up pin, if specified in device tree */
 static int marvell_config_oob_wake(struct hci_dev *hdev)
@@ -3873,7 +3554,7 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->shutdown = btusb_mtk_shutdown;
 		hdev->manufacturer = 70;
 		hdev->cmd_timeout = btusb_mtk_cmd_timeout;
-		hdev->set_bdaddr = btusb_set_bdaddr_mtk;
+		hdev->set_bdaddr = btmtk_set_bdaddr;
 		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
 		data->recv_acl = btusb_recv_acl_mtk;
 	}
-- 
2.25.1

