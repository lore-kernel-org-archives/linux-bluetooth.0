Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AFAC64E8A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 07:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 244F7206DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Nov 2020 07:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgK3HSl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Nov 2020 02:18:41 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:58864 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726518AbgK3HSk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Nov 2020 02:18:40 -0500
X-UUID: 296236a49ec241468e7f369fcb5fc119-20201130
X-UUID: 296236a49ec241468e7f369fcb5fc119-20201130
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <peter.tsao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2021648852; Mon, 30 Nov 2020 15:17:03 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 30 Nov 2020 15:16:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 30 Nov 2020 15:16:58 +0800
From:   <peter.tsao@mediatek.com>
To:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>
CC:     <linux-bluetooth@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mark-yw.chen@mediatek.com>,
        <justin.tsai@mediatek.com>, <peter.tsao@mediatek.com>,
        <can.chen@mediatek.com>
Subject: [PATCH] MTK mt7921 driver upstream
Date:   Mon, 30 Nov 2020 15:16:55 +0800
Message-ID: <20201130071655.31515-1-peter.tsao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 407247CCC7249D1D9D2E76511CAF2BE0B043A2D7A335E2A211D9467D75DCE3632000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Peter Tsao <peter.tsao@mediatek.com>

Signed-off-by: Peter Tsao <peter.tsao@mediatek.com>
---
 drivers/bluetooth/btmtk_buffer_mode.c         |  263 +
 drivers/bluetooth/btmtk_main.c                | 5517 +++++++++++++++++
 drivers/bluetooth/include/btmtk_buffer_mode.h |   78 +
 drivers/bluetooth/include/btmtk_chip_if.h     |   30 +
 drivers/bluetooth/include/btmtk_define.h      |  304 +
 drivers/bluetooth/include/btmtk_drv.h         |  157 +
 drivers/bluetooth/include/btmtk_main.h        |  587 ++
 drivers/bluetooth/include/sdio/btmtk_sdio.h   |  147 +
 drivers/bluetooth/include/uart/btmtk_uart.h   |   86 +
 drivers/bluetooth/include/usb/btmtk_usb.h     |  100 +
 drivers/bluetooth/sdio/btmtksdio.c            | 2004 ++++++
 drivers/bluetooth/usb/btmtkusb.c              | 3218 ++++++++++
 12 files changed, 12491 insertions(+)
 create mode 100644 drivers/bluetooth/btmtk_buffer_mode.c
 create mode 100644 drivers/bluetooth/btmtk_main.c
 create mode 100644 drivers/bluetooth/include/btmtk_buffer_mode.h
 create mode 100644 drivers/bluetooth/include/btmtk_chip_if.h
 create mode 100644 drivers/bluetooth/include/btmtk_define.h
 create mode 100644 drivers/bluetooth/include/btmtk_drv.h
 create mode 100644 drivers/bluetooth/include/btmtk_main.h
 create mode 100644 drivers/bluetooth/include/sdio/btmtk_sdio.h
 create mode 100644 drivers/bluetooth/include/uart/btmtk_uart.h
 create mode 100644 drivers/bluetooth/include/usb/btmtk_usb.h
 create mode 100644 drivers/bluetooth/sdio/btmtksdio.c
 create mode 100644 drivers/bluetooth/usb/btmtkusb.c

diff --git a/drivers/bluetooth/btmtk_buffer_mode.c b/drivers/bluetooth/btmtk_buffer_mode.c
new file mode 100644
index 000000000000..a4216ce4a440
--- /dev/null
+++ b/drivers/bluetooth/btmtk_buffer_mode.c
@@ -0,0 +1,263 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/**
+ *  Copyright (c) 2018 MediaTek Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *  See http://www.gnu.org/licenses/gpl-2.0.html for more details.
+ */
+
+#include "btmtk_define.h"
+#include "btmtk_main.h"
+
+static struct btmtk_buffer_mode_struct btmtk_buffer_mode;
+
+static int btmtk_buffer_mode_check_auto_mode(struct btmtk_buffer_mode_struct *buffer_mode)
+{
+	u16 addr = 1;
+	u8 value = 0;
+
+	if (buffer_mode->efuse_mode != AUTO_MODE)
+		return 0;
+
+	if (btmtk_efuse_read(buffer_mode->bdev, addr, &value)) {
+		BTMTK_WARN("read fail");
+		BTMTK_WARN("Use EEPROM Bin file mode");
+		buffer_mode->efuse_mode = BIN_FILE_MODE;
+		return -EIO;
+	}
+
+	if (value == ((buffer_mode->bdev->chip_id & 0xFF00) >> 8)) {
+		BTMTK_WARN("get efuse[1]: 0x%02x", value);
+		BTMTK_WARN("use efuse mode");
+		buffer_mode->efuse_mode = EFUSE_MODE;
+	} else {
+		BTMTK_WARN("get efuse[1]: 0x%02x", value);
+		BTMTK_WARN("Use EEPROM Bin file mode");
+		buffer_mode->efuse_mode = BIN_FILE_MODE;
+	}
+
+	return 0;
+}
+
+static int btmtk_buffer_mode_parse_mode(uint8_t *buf, size_t buf_size)
+{
+	int efuse_mode = EFUSE_MODE;
+	char *p_buf = NULL;
+	char *ptr = NULL, *p = NULL;
+
+	if (!buf) {
+		BTMTK_WARN("buf is null");
+		return efuse_mode;
+	} else if (buf_size < (strlen(BUFFER_MODE_SWITCH_FIELD) + 2)) {
+		BTMTK_WARN("incorrect buf size(%d)", (int)buf_size);
+		return efuse_mode;
+	}
+
+	p_buf = kmalloc(buf_size + 1, GFP_KERNEL);
+	if (!p_buf)
+		return efuse_mode;
+	memcpy(p_buf, buf, buf_size);
+	p_buf[buf_size] = '\0';
+
+	/* find string */
+	p = ptr = strstr(p_buf, BUFFER_MODE_SWITCH_FIELD);
+	if (!ptr) {
+		BTMTK_ERR("Can't find %s", BUFFER_MODE_SWITCH_FIELD);
+		goto out;
+	}
+
+	if (p > p_buf) {
+		p--;
+		while ((*p == ' ') && (p != p_buf))
+			p--;
+		if (*p == '#') {
+			BTMTK_ERR("It's not EEPROM - Bin file mode");
+			goto out;
+		}
+	}
+
+	/* check access mode */
+	ptr += (strlen(BUFFER_MODE_SWITCH_FIELD) + 1);
+	BTMTK_WARN("It's EEPROM bin mode: %c", *ptr);
+	efuse_mode = *ptr - '0';
+	if (efuse_mode > AUTO_MODE)
+		efuse_mode = EFUSE_MODE;
+out:
+	kfree(p_buf);
+	return efuse_mode;
+}
+
+static int btmtk_buffer_mode_set_addr(struct btmtk_buffer_mode_struct *buffer_mode)
+{
+	u8 cmd[] = {0x01, 0x1A, 0xFC, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
+	/* To-Do, for event check */
+	u8 event[] = {0x04, 0x0E, 0x04, 0x01, 0x1A, 0xFC, 0x00};
+	int ret = 0;
+
+	cmd[9] = buffer_mode->bt0_mac[0];
+	cmd[8] = buffer_mode->bt0_mac[1];
+	cmd[7] = buffer_mode->bt0_mac[2];
+	cmd[6] = buffer_mode->bt0_mac[3];
+	cmd[5] = buffer_mode->bt0_mac[4];
+	cmd[4] = buffer_mode->bt0_mac[5];
+
+	BTMTK_INFO_RAW(cmd, sizeof(cmd), "%s: Send", __func__);
+	ret = btmtk_main_send_cmd(buffer_mode->bdev, cmd, sizeof(cmd), event, sizeof(event), 0, 0,
+			BTMTK_TX_CMD_FROM_DRV);
+
+	BTMTK_INFO("%s done", __func__);
+	return ret;
+}
+
+static int btmtk_buffer_mode_set_radio(struct btmtk_buffer_mode_struct *buffer_mode)
+{
+	u8 cmd[] = {0x01, 0x2C, 0xFC, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
+	/* To-Do, for event check */
+	u8 event[] = {0x04, 0x0E, 0x04, 0x01, 0x2C, 0xFC, 0x00};
+	int ret = 0;
+
+	cmd[4] = buffer_mode->bt0_radio.radio_0 & 0x3F;		/* edr_init_pwr */
+	cmd[8] = buffer_mode->bt0_radio.radio_2 & 0x3F;		/* ble_default_pwr */
+	cmd[9] = buffer_mode->bt0_radio.radio_1 & 0x3F;		/* edr_max_pwr */
+	cmd[11] = (buffer_mode->bt0_radio.radio_0 & 0xC0) >> 6;	/* edr_pwr_mode */
+
+	BTMTK_INFO_RAW(cmd, sizeof(cmd), "%s: Send", __func__);
+	ret = btmtk_main_send_cmd(buffer_mode->bdev, cmd, sizeof(cmd), event, sizeof(event), 0, 0,
+			BTMTK_TX_CMD_FROM_DRV);
+
+	BTMTK_INFO("%s done", __func__);
+	return ret;
+}
+
+static int btmtk_buffer_mode_set_group_boundary(struct btmtk_buffer_mode_struct *buffer_mode)
+{
+	u8 cmd[] = {0x01, 0xEA, 0xFC, 0x09, 0x02, 0x0B, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
+	/* To-Do, for event check */
+	u8 event[] = {0x04, 0x0E, 0x04, 0x01, 0xEA, 0xFC, 0x00};
+	int ret = 0;
+
+	memcpy(&cmd[8], buffer_mode->bt0_ant0_grp_boundary,
+		sizeof(buffer_mode->bt0_ant0_grp_boundary));
+
+	BTMTK_INFO_RAW(cmd, sizeof(cmd), "%s: Send", __func__);
+	ret = btmtk_main_send_cmd(buffer_mode->bdev, cmd, sizeof(cmd), event, sizeof(event), 0, 0,
+			BTMTK_TX_CMD_FROM_DRV);
+
+	BTMTK_INFO("%s done", __func__);
+	return ret;
+}
+
+static int btmtk_buffer_mode_set_power_offset(struct btmtk_buffer_mode_struct *buffer_mode)
+{
+	u8 cmd[] = {0x01, 0xEA, 0xFC, 0x0A, 0x02, 0x0A,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
+	/* To-Do, for event check */
+	u8 event[] = {0x04, 0x0E, 0x04, 0x01, 0xEA, 0xFC, 0x00};
+	int ret = 0;
+
+	memcpy(&cmd[8], buffer_mode->bt0_ant0_pwr_offset, sizeof(buffer_mode->bt0_ant0_pwr_offset));
+
+	BTMTK_INFO_RAW(cmd, sizeof(cmd), "%s: Send", __func__);
+	ret = btmtk_main_send_cmd(buffer_mode->bdev, cmd, sizeof(cmd), event, sizeof(event), 0, 0,
+			BTMTK_TX_CMD_FROM_DRV);
+
+	BTMTK_INFO("%s done", __func__);
+	return ret;
+}
+
+int btmtk_buffer_mode_send(struct btmtk_buffer_mode_struct *buffer_mode)
+{
+	int ret = 0;
+
+	if (buffer_mode == NULL) {
+		BTMTK_INFO("buffer_mode is NULL, not support");
+		return -EIO;
+	}
+
+	if (btmtk_buffer_mode_check_auto_mode(buffer_mode)) {
+		BTMTK_ERR("check auto mode failed");
+		return -EIO;
+	}
+
+	if (buffer_mode->efuse_mode == BIN_FILE_MODE) {
+		ret = btmtk_buffer_mode_set_addr(buffer_mode);
+		if (ret < 0)
+			BTMTK_ERR("set addr failed");
+
+		ret = btmtk_buffer_mode_set_radio(buffer_mode);
+		if (ret < 0)
+			BTMTK_ERR("set radio failed");
+
+		ret = btmtk_buffer_mode_set_group_boundary(buffer_mode);
+		if (ret < 0)
+			BTMTK_ERR("set group_boundary failed");
+
+		ret = btmtk_buffer_mode_set_power_offset(buffer_mode);
+		if (ret < 0)
+			BTMTK_ERR("set power_offset failed");
+	}
+	return 0;
+}
+
+void btmtk_buffer_mode_initialize(struct btmtk_dev *bdev,
+				struct btmtk_buffer_mode_struct **buffer_mode)
+{
+	int ret = 0;
+	u32 code_len = 0;
+
+	btmtk_buffer_mode.bdev = bdev;
+	ret = btmtk_load_code_from_setting_files(BUFFER_MODE_SWITCH_FILE, bdev->intf_dev,
+						&code_len, bdev);
+
+	btmtk_buffer_mode.efuse_mode = btmtk_buffer_mode_parse_mode(bdev->setting_file, code_len);
+	if (btmtk_buffer_mode.efuse_mode == EFUSE_MODE)
+		return;
+
+	if (bdev->flavor)
+		snprintf(btmtk_buffer_mode.file_name, MAX_BIN_FILE_NAME_LEN, "EEPROM_MT%04x_1a.bin",
+				bdev->chip_id & 0xffff);
+	else
+		snprintf(btmtk_buffer_mode.file_name, MAX_BIN_FILE_NAME_LEN, "EEPROM_MT%04x_1.bin",
+				bdev->chip_id & 0xffff);
+
+	ret = btmtk_load_code_from_setting_files(btmtk_buffer_mode.file_name,
+						bdev->intf_dev, &code_len, bdev);
+	if (ret < 0) {
+		BTMTK_ERR("set load %s failed", btmtk_buffer_mode.file_name);
+		return;
+	}
+
+	memcpy(btmtk_buffer_mode.bt0_mac, &bdev->setting_file[BT0_MAC_OFFSET],
+				BUFFER_MODE_MAC_LENGTH);
+	memcpy(btmtk_buffer_mode.bt1_mac, &bdev->setting_file[BT1_MAC_OFFSET],
+				BUFFER_MODE_MAC_LENGTH);
+	memcpy(&btmtk_buffer_mode.bt0_radio, &bdev->setting_file[BT0_RADIO_OFFSET],
+				BUFFER_MODE_RADIO_LENGTH);
+	memcpy(&btmtk_buffer_mode.bt1_radio, &bdev->setting_file[BT1_RADIO_OFFSET],
+				BUFFER_MODE_RADIO_LENGTH);
+	memcpy(btmtk_buffer_mode.bt0_ant0_grp_boundary, &bdev->setting_file[BT0_GROUP_ANT0_OFFSET],
+				BUFFER_MODE_GROUP_LENGTH);
+	memcpy(btmtk_buffer_mode.bt0_ant1_grp_boundary, &bdev->setting_file[BT0_GROUP_ANT1_OFFSET],
+				BUFFER_MODE_GROUP_LENGTH);
+	memcpy(btmtk_buffer_mode.bt1_ant0_grp_boundary, &bdev->setting_file[BT1_GROUP_ANT0_OFFSET],
+				BUFFER_MODE_GROUP_LENGTH);
+	memcpy(btmtk_buffer_mode.bt1_ant1_grp_boundary, &bdev->setting_file[BT1_GROUP_ANT1_OFFSET],
+				BUFFER_MODE_GROUP_LENGTH);
+	memcpy(btmtk_buffer_mode.bt0_ant0_pwr_offset, &bdev->setting_file[BT0_CAL_ANT0_OFFSET],
+				BUFFER_MODE_CAL_LENGTH);
+	memcpy(btmtk_buffer_mode.bt0_ant1_pwr_offset, &bdev->setting_file[BT0_CAL_ANT1_OFFSET],
+				BUFFER_MODE_CAL_LENGTH);
+	memcpy(btmtk_buffer_mode.bt1_ant0_pwr_offset, &bdev->setting_file[BT1_CAL_ANT0_OFFSET],
+				BUFFER_MODE_CAL_LENGTH);
+	memcpy(btmtk_buffer_mode.bt1_ant1_pwr_offset, &bdev->setting_file[BT1_CAL_ANT1_OFFSET],
+				BUFFER_MODE_CAL_LENGTH);
+
+	*buffer_mode = &btmtk_buffer_mode;
+}
+
diff --git a/drivers/bluetooth/btmtk_main.c b/drivers/bluetooth/btmtk_main.c
new file mode 100644
index 000000000000..748684a36b91
--- /dev/null
+++ b/drivers/bluetooth/btmtk_main.c
@@ -0,0 +1,5517 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/**
+ *  Copyright (c) 2018 MediaTek Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *  See http://www.gnu.org/licenses/gpl-2.0.html for more details.
+ */
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/input.h>
+#include <linux/pm_wakeup.h>
+#include <linux/reboot.h>
+#include <linux/string.h>
+
+#include "btmtk_define.h"
+#include "btmtk_main.h"
+
+#define MTKBT_UNSLEEPABLE_LOCK(x, y)	spin_lock_irqsave(x, y)
+#define MTKBT_UNSLEEPABLE_UNLOCK(x, y)	spin_unlock_irqsave(x, y)
+
+/* TODO, need to modify the state mutex for each hci dev*/
+static DEFINE_MUTEX(btmtk_chip_state_mutex);
+#define CHIP_STATE_MUTEX_LOCK()	mutex_lock(&btmtk_chip_state_mutex)
+#define CHIP_STATE_MUTEX_UNLOCK()	mutex_unlock(&btmtk_chip_state_mutex)
+static DEFINE_MUTEX(btmtk_fops_state_mutex);
+#define FOPS_MUTEX_LOCK()	mutex_lock(&btmtk_fops_state_mutex)
+#define FOPS_MUTEX_UNLOCK()	mutex_unlock(&btmtk_fops_state_mutex)
+
+const struct file_operations BT_fopsfwlog = {
+	.open = btmtk_fops_openfwlog,
+	.release = btmtk_fops_closefwlog,
+	.read = btmtk_fops_readfwlog,
+	.write = btmtk_fops_writefwlog,
+	.poll = btmtk_fops_pollfwlog,
+	.unlocked_ioctl = btmtk_fops_unlocked_ioctlfwlog
+};
+
+static int btmtk_fops_get_state(struct btmtk_dev *bdev);
+
+/**
+ * Global parameters(mtkbt_)
+ */
+u8 btmtk_log_lvl = BTMTK_LOG_LVL_DEF;
+
+/* To support dynamic mount of interface can be probed */
+static int btmtk_intf_num = BT_MCU_MINIMUM_INTERFACE_NUM;
+/* To allow g_bdev being sized from btmtk_intf_num setting */
+static struct btmtk_dev **g_bdev;
+/* For fwlog dev node setting */
+static struct btmtk_fops_fwlog *g_fwlog;
+
+const u8 RESET_EVENT[] = { 0x0E, 0x04, 0x01, 0x03, 0x0c, 0x00 };
+const u8 READ_ISO_PACKET_SIZE_CMD[] = { 0x01, 0x98, 0xFD, 0x02 };
+
+u8 wmt_over_hci_header[] = { 0x01, 0x6F, 0xFC};
+
+/*btmtk main information*/
+static struct btmtk_main_info main_info;
+
+/* bluetooth kpi */
+static u8 btmtk_bluetooth_kpi;
+
+/* save Hci Snoop for debug*/
+static u8 hci_cmd_buf[HCI_SNOOP_ENTRY_NUM][HCI_SNOOP_MAX_BUF_SIZE];
+static u8 hci_cmd_len[HCI_SNOOP_ENTRY_NUM] = { 0 };
+static u16 hci_cmd_actual_len[HCI_SNOOP_ENTRY_NUM] = { 0 };
+static unsigned int hci_cmd_timestamp[HCI_SNOOP_ENTRY_NUM];
+static int hci_cmd_index = HCI_SNOOP_ENTRY_NUM - 1;
+
+static u8 hci_event_buf[HCI_SNOOP_ENTRY_NUM][HCI_SNOOP_MAX_BUF_SIZE];
+static u8 hci_event_len[HCI_SNOOP_ENTRY_NUM] = { 0 };
+static u16 hci_event_actual_len[HCI_SNOOP_ENTRY_NUM] = { 0 };
+static unsigned int hci_event_timestamp[HCI_SNOOP_ENTRY_NUM];
+static int hci_event_index = HCI_SNOOP_ENTRY_NUM - 1;
+
+static u8 hci_adv_event_buf[HCI_SNOOP_ENTRY_NUM][HCI_SNOOP_MAX_BUF_SIZE];
+static u8 hci_adv_event_len[HCI_SNOOP_ENTRY_NUM] = { 0 };
+static u16 hci_adv_event_actual_len[HCI_SNOOP_ENTRY_NUM] = { 0 };
+static unsigned int hci_adv_event_timestamp[HCI_SNOOP_ENTRY_NUM];
+static int hci_adv_event_index = HCI_SNOOP_ENTRY_NUM - 1;
+
+static u8 hci_acl_buf[HCI_SNOOP_ENTRY_NUM][HCI_SNOOP_MAX_BUF_SIZE];
+static u8 hci_acl_len[HCI_SNOOP_ENTRY_NUM] = { 0 };
+static u16 hci_acl_actual_len[HCI_SNOOP_ENTRY_NUM] = { 0 };
+static unsigned int hci_acl_timestamp[HCI_SNOOP_ENTRY_NUM];
+static int hci_acl_index = HCI_SNOOP_ENTRY_NUM - 1;
+
+/* State machine table that clarify through each HIF events,
+ * To specify HIF event on
+ * Entering / End / Error
+ */
+static const struct btmtk_cif_state g_cif_state[] = {
+	/* HIF_EVENT_PROBE */
+	{BTMTK_STATE_PROBE, BTMTK_STATE_WORKING, BTMTK_STATE_DISCONNECT},
+	/* HIF_EVENT_DISCONNECT */
+	{BTMTK_STATE_DISCONNECT, BTMTK_STATE_DISCONNECT, BTMTK_STATE_DISCONNECT},
+	/* HIF_EVENT_SUSPEND */
+	{BTMTK_STATE_SUSPEND, BTMTK_STATE_SUSPEND, BTMTK_STATE_FW_DUMP},
+	/* HIF_EVENT_RESUME */
+	{BTMTK_STATE_RESUME, BTMTK_STATE_WORKING, BTMTK_STATE_FW_DUMP},
+	/* HIF_EVENT_STANDBY */
+	{BTMTK_STATE_STANDBY, BTMTK_STATE_STANDBY, BTMTK_STATE_FW_DUMP},
+	/* BTMTK_STATE_FW_DUMP */
+	{BTMTK_STATE_SUBSYS_RESET, BTMTK_STATE_WORKING, BTMTK_STATE_FW_DUMP},
+	/* BTMTK_STATE_FW_DUMP */
+	{BTMTK_STATE_FW_DUMP, BTMTK_STATE_DISCONNECT, BTMTK_STATE_FW_DUMP},
+	/* BTMTK_STATE_FW_DUMP */
+	{BTMTK_STATE_FW_DUMP, BTMTK_STATE_FW_DUMP, BTMTK_STATE_FW_DUMP},
+};
+
+__weak int btmtk_cif_register(void)
+{
+	BTMTK_ERR("No cif register function");
+	return -1;
+}
+
+__weak int btmtk_cif_deregister(void)
+{
+	BTMTK_ERR("No cif deregister function");
+	return -1;
+}
+
+__weak int btmtk_cif_send_calibration(struct btmtk_dev *bdev)
+{
+	BTMTK_ERR("No cif %s", __func__);
+	return -1;
+}
+
+__weak void do_gettimeofday(struct timeval *tv)
+{
+	struct timespec64 ts;
+
+	ktime_get_real_ts64(&ts);
+	tv->tv_sec = ts.tv_sec;
+	tv->tv_usec = ts.tv_nsec / 1000;
+}
+
+static int btmtk_enter_standby(void);
+static int btmtk_send_hci_tci_set_sleep_cmd_766x(struct btmtk_dev *bdev);
+
+void btmtk_woble_wake_lock(struct btmtk_dev *bdev)
+{
+	if (bdev->bt_cfg.support_woble_wakelock) {
+		BTMTK_INFO("%s: enter", __func__);
+		__pm_stay_awake(main_info.woble_ws);
+		BTMTK_INFO("%s: exit", __func__);
+	}
+}
+
+void btmtk_woble_wake_unlock(struct btmtk_dev *bdev)
+{
+	if (bdev->bt_cfg.support_woble_wakelock) {
+		BTMTK_INFO("%s: enter", __func__);
+		__pm_relax(main_info.woble_ws);
+		BTMTK_INFO("%s: exit", __func__);
+	}
+}
+
+void btmtk_fwdump_wake_lock(struct btmtk_dev *bdev)
+{
+	BTMTK_INFO("%s: enter", __func__);
+	__pm_stay_awake(main_info.fwdump_ws);
+	BTMTK_INFO("%s: exit", __func__);
+}
+
+void btmtk_fwdump_wake_unlock(struct btmtk_dev *bdev)
+{
+	BTMTK_INFO("%s: enter", __func__);
+	__pm_relax(main_info.fwdump_ws);
+	BTMTK_INFO("%s: exit", __func__);
+}
+
+/*get 1 byte only*/
+int btmtk_efuse_read(struct btmtk_dev *bdev, u16 addr, u8 *value)
+{
+	u8 efuse_r[] = {0x01, 0x6F, 0xFC, 0x0E,
+				0x01, 0x0D, 0x0A, 0x00, 0x02, 0x04,
+				0x00, 0x00, 0x00, 0x00,
+				0x00, 0x00, 0x00, 0x00};/*4 sub block number(sub block 0~3)*/
+
+	u8 efuse_r_event[] = {0x04, 0xE4, 0x1E, 0x02, 0x0D, 0x1A, 0x00, 02, 04};
+	/*check event
+	 *04 E4 LEN(1B) 02 0D LEN(2Byte) 02 04 ADDR(2Byte) VALUE(4B) ADDR(2Byte) VALUE(4Byte)
+	 *ADDR(2Byte) VALUE(4B)  ADDR(2Byte) VALUE(4Byte)
+	 */
+	int ret = 0;
+	u8 sub_block_addr_in_event = 0;
+	u16 sub_block = (addr / 16) * 4;
+	u8 temp = 0;
+
+	efuse_r[10] = sub_block & 0xFF;
+	efuse_r[11] = (sub_block & 0xFF00) >> 8;
+	efuse_r[12] = (sub_block + 1) & 0xFF;
+	efuse_r[13] = ((sub_block + 1) & 0xFF00) >> 8;
+	efuse_r[14] = (sub_block + 2) & 0xFF;
+	efuse_r[15] = ((sub_block + 2) & 0xFF00) >> 8;
+	efuse_r[16] = (sub_block + 3) & 0xFF;
+	efuse_r[17] = ((sub_block + 3) & 0xFF00) >> 8;
+
+	ret = btmtk_main_send_cmd(bdev,
+				  efuse_r, sizeof(efuse_r),
+				  efuse_r_event, sizeof(efuse_r_event),
+				  0, 0, BTMTK_TX_CMD_FROM_DRV);
+	if (ret) {
+		BTMTK_WARN("btmtk_main_send_cmd error");
+		return ret;
+	}
+
+	if (memcmp(bdev->io_buf, efuse_r_event, sizeof(efuse_r_event)) == 0) {
+		/*compare rxbuf format ok, compare addr*/
+		BTMTK_DBG("compare rxbuf format ok");
+		if (efuse_r[10] == bdev->io_buf[9] &&
+		    efuse_r[11] == bdev->io_buf[10] &&
+		    efuse_r[12] == bdev->io_buf[15] &&
+		    efuse_r[13] == bdev->io_buf[16] &&
+		    efuse_r[14] == bdev->io_buf[21] &&
+		    efuse_r[15] == bdev->io_buf[22] &&
+		    efuse_r[16] == bdev->io_buf[27] &&
+		    efuse_r[17] == bdev->io_buf[28]) {
+			BTMTK_DBG("address compare ok");
+			/*Get value*/
+			sub_block_addr_in_event = ((addr / 16) / 4);/*cal block num*/
+			temp = addr % 16;
+			BTMTK_DBG("address in block %d", temp);
+			switch (temp) {
+			case 0:
+			case 1:
+			case 2:
+			case 3:
+				*value = bdev->io_buf[11 + temp];
+				break;
+			case 4:
+			case 5:
+			case 6:
+			case 7:
+				*value = bdev->io_buf[17 + temp];
+				break;
+			case 8:
+			case 9:
+			case 10:
+			case 11:
+				*value = bdev->io_buf[22 + temp];
+				break;
+
+			case 12:
+			case 13:
+			case 14:
+			case 15:
+				*value = bdev->io_buf[34 + temp];
+				break;
+			}
+		} else {
+			BTMTK_WARN("address compare fail");
+			ret = -1;
+		}
+	} else {
+		BTMTK_WARN("compare rxbuf format fail");
+		ret = -1;
+	}
+
+	return ret;
+}
+
+static int btmtk_skb_enq_fwlog(struct hci_dev *hdev,
+			       void *src, u32 len, u8 type, struct sk_buff_head *queue)
+{
+	struct btmtk_dev *bdev = hci_get_drvdata(hdev);
+	struct sk_buff *skb_tmp = NULL;
+	ulong flags = 0;
+	int retry = 10, index = FWLOG_TL_SIZE;
+
+	do {
+		skb_tmp = alloc_skb(len + FWLOG_PRSV_LEN, GFP_ATOMIC);
+		if (skb_tmp) {
+			break;
+		} else if (retry <= 0) {
+			pr_err("%s: alloc_skb return 0, error", __func__);
+			return -ENOMEM;
+		}
+		pr_err("%s: alloc_skb return 0, error, retry = %d", __func__, retry);
+	} while (retry-- > 0);
+
+	if (type) {
+		skb_tmp->data[0] = FWLOG_TYPE;
+		/* 01 for dongle index */
+		skb_tmp->data[index] = FWLOG_DONGLE_IDX;
+		skb_tmp->data[index + 1] = sizeof(bdev->dongle_index);
+		skb_tmp->data[index + 2] = bdev->dongle_index;
+		index += (FWLOG_ATTR_RX_LEN_LEN + FWLOG_ATTR_TYPE_LEN);
+		/* 11 for rx data*/
+		skb_tmp->data[index] = FWLOG_RX;
+		if (type == HCI_ACLDATA_PKT || type == HCI_EVENT_PKT || type == HCI_COMMAND_PKT) {
+			skb_tmp->data[index + 1] = len & 0x00FF;
+			skb_tmp->data[index + 2] = (len & 0xFF00) >> 8;
+			skb_tmp->data[index + 3] = type;
+			index += (HCI_TYPE_SIZE + FWLOG_ATTR_RX_LEN_LEN + FWLOG_ATTR_TYPE_LEN);
+		} else {
+			skb_tmp->data[index + 1] = len & 0x00FF;
+			skb_tmp->data[index + 2] = (len & 0xFF00) >> 8;
+			index += (FWLOG_ATTR_RX_LEN_LEN + FWLOG_ATTR_TYPE_LEN);
+		}
+		memcpy(&skb_tmp->data[index], src, len);
+		skb_tmp->data[1] = (len + index - FWLOG_TL_SIZE) & 0x00FF;
+		skb_tmp->data[2] = ((len + index - FWLOG_TL_SIZE) & 0xFF00) >> 8;
+		skb_tmp->len = len + index;
+	} else {
+		memcpy(skb_tmp->data, src, len);
+		skb_tmp->len = len;
+	}
+
+	spin_lock_irqsave(&g_fwlog->fwlog_lock, flags);
+	skb_queue_tail(queue, skb_tmp);
+	spin_unlock_irqrestore(&g_fwlog->fwlog_lock, flags);
+	return 0;
+}
+
+static int btmtk_dispatch_data_bluetooth_kpi(struct hci_dev *hdev, u8 *buf, int len, u8 type)
+{
+	struct btmtk_dev *bdev = hci_get_drvdata(hdev);
+	static u8 fwlog_blocking_warn;
+	int ret = 0;
+
+	if (btmtk_bluetooth_kpi &&
+	    skb_queue_len(&g_fwlog->fwlog_queue) < FWLOG_BLUETOOTH_KPI_QUEUE_COUNT) {
+		/* sent event to queue, picus tool will log it for bluetooth KPI feature */
+		if (btmtk_skb_enq_fwlog(bdev->hdev, buf, len, type, &g_fwlog->fwlog_queue) == 0) {
+			wake_up_interruptible(&g_fwlog->fw_log_inq);
+			fwlog_blocking_warn = 0;
+		}
+	} else {
+		if (fwlog_blocking_warn == 0) {
+			fwlog_blocking_warn = 1;
+			pr_warn("btmtk_usb fwlog queue size is full(bluetooth_kpi)");
+		}
+	}
+	return ret;
+}
+
+ssize_t btmtk_fops_readfwlog(struct file *filp, char __user *buf, size_t count, loff_t *f_pos)
+{
+	int copy_len = 0;
+	ulong flags = 0;
+	struct sk_buff *skb = NULL;
+
+	/* picus read a queue, it may occur performace issue */
+	spin_lock_irqsave(&g_fwlog->fwlog_lock, flags);
+	if (skb_queue_len(&g_fwlog->fwlog_queue))
+		skb = skb_dequeue(&g_fwlog->fwlog_queue);
+
+	spin_unlock_irqrestore(&g_fwlog->fwlog_lock, flags);
+	if (!skb)
+		return 0;
+
+	if (skb->len <= count) {
+		if (copy_to_user(buf, skb->data, skb->len))
+			BT_ERR("%s: copy_to_user failed!", __func__);
+
+		copy_len = skb->len;
+	} else {
+		BTMTK_DBG("%s: socket buffer length error(count: %d, skb.len: %d)",
+			  __func__, (int)count, skb->len);
+	}
+	kfree_skb(skb);
+	return copy_len;
+}
+
+static int whole_reset_flag;
+ssize_t btmtk_fops_writefwlog(struct file *filp, const char __user *buf,
+			      size_t count, loff_t *f_pos)
+{
+	int i = 0, len = 0, ret = -1;
+	int hci_idx = 0;
+	int vlen = 0, index = 3;
+	struct sk_buff *skb = NULL;
+	int state = BTMTK_STATE_INIT;
+	int fstate = BTMTK_FOPS_STATE_INIT;
+	struct btmtk_dev *bdev = NULL;
+
+	u8 *i_fwlog_buf = kmalloc(HCI_MAX_COMMAND_BUF_SIZE, GFP_KERNEL);
+	u8 *o_fwlog_buf = kmalloc(HCI_MAX_COMMAND_SIZE, GFP_KERNEL);
+
+	for (i = 0; i < btmtk_intf_num; i++) {
+		/* Find valid dev for already probe interface. */
+		if (g_bdev[i]->hdev) {
+			bdev = g_bdev[i];
+
+			state = btmtk_get_chip_state(bdev);
+			if (state != BTMTK_STATE_WORKING) {
+				ret = -EBADFD;
+				goto exit;
+			}
+
+			fstate = btmtk_fops_get_state(bdev);
+			if (fstate != BTMTK_FOPS_STATE_OPENED) {
+				BTMTK_WARN("%s: fops is not open yet(%d)!", __func__, fstate);
+				ret = -ENODEV;
+				goto exit;
+			}
+
+			if (bdev->power_state == BTMTK_DONGLE_STATE_POWER_OFF) {
+				BTMTK_WARN("%s: dongle state already power off, do not write",
+					   __func__);
+				ret = -EFAULT;
+				goto exit;
+			}
+		}
+	}
+
+	if (count > HCI_MAX_COMMAND_BUF_SIZE) {
+		BTMTK_ERR("%s: your command is larger than maximum length, count = %zd\n",
+			  __func__, count);
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	memset(i_fwlog_buf, 0, HCI_MAX_COMMAND_BUF_SIZE);
+	memset(o_fwlog_buf, 0, HCI_MAX_COMMAND_SIZE);
+	if (copy_from_user(i_fwlog_buf, buf, count) != 0) {
+		BT_ERR("%s: Failed to copy data", __func__);
+		ret = -ENODATA;
+		goto exit;
+	}
+
+	/* For log level, EX: echo log_lvl=1 > /dev/stpbtfwlog */
+	if (strncmp(i_fwlog_buf, "log_lvl=", strlen("log_lvl=")) == 0) {
+		u8 val = *(i_fwlog_buf + strlen("log_lvl=")) - 48;
+
+		if (val > BTMTK_LOG_LVL_MAX || val <= 0) {
+			BTMTK_ERR("Got incorrect value for log level(%d)", val);
+			count =  -EINVAL;
+			goto exit;
+		}
+		btmtk_log_lvl = val;
+		BT_INFO("btmtk_log_lvl = %d", btmtk_log_lvl);
+		ret = count;
+		goto exit;
+	}
+
+	if (strncmp(i_fwlog_buf, "whole chip reset", strlen("whole chip reset")) == 0) {
+		BT_INFO("whole chip reset start");
+		whole_reset_flag = 1;
+		schedule_work(&bdev->reset_waker);
+		ret = count;
+		goto exit;
+	}
+	if (strncmp(i_fwlog_buf, "subsys chip reset", strlen("subsys chip reset")) == 0) {
+		BT_INFO("subsys chip reset");
+		schedule_work(&bdev->reset_waker);
+		ret = count;
+		goto exit;
+	}
+
+	/* For bperf, EX: echo bperf=1 > /dev/stpbtfwlog */
+	if (strncmp(i_fwlog_buf, "bperf=", strlen("bperf=")) == 0) {
+		u8 val = *(i_fwlog_buf + strlen("bperf=")) - 48;
+
+		btmtk_bluetooth_kpi = val;
+		BT_INFO("%s: set bluetooth KPI feature(bperf) to %d",
+			__func__, btmtk_bluetooth_kpi);
+		ret = count;
+		goto exit;
+	}
+
+	/* hci input command format : echo 01 be fc 01 05 > /dev/stpbtfwlog */
+	/* We take the data from index three to end. */
+	for (i = 0; i < count; i++) {
+		char *pos = i_fwlog_buf + i;
+		char temp_str[3] = {'\0'};
+		long res = 0;
+
+		if (*pos == ' ' || *pos == '\t' || *pos == '\r' || *pos == '\n') {
+			continue;
+		} else if (*pos == '0' && (*(pos + 1) == 'x' || *(pos + 1) == 'X')) {
+			i++;
+			continue;
+		} else if (!(*pos >= '0' && *pos <= '9') && !(*pos >= 'A' && *pos <= 'F') &&
+			   !(*pos >= 'a' && *pos <= 'f')) {
+			BTMTK_ERR("%s: There is an invalid input(%c)", __func__, *pos);
+			ret = -EINVAL;
+			goto exit;
+		}
+		temp_str[0] = *pos;
+		temp_str[1] = *(pos + 1);
+		i++;
+		ret = kstrtol(temp_str, 16, &res);
+		if (ret == 0)
+			o_fwlog_buf[len++] = (u8)res;
+		else
+			BT_ERR("%s: Convert %s failed(%d)", __func__, temp_str, ret);
+	}
+
+	if (o_fwlog_buf[0] != HCI_COMMAND_PKT && o_fwlog_buf[0] != FWLOG_TYPE) {
+		BT_ERR("%s: Not support 0x%02X yet", __func__, o_fwlog_buf[0]);
+		ret = -EPROTONOSUPPORT;
+		goto exit;
+	}
+	/* check HCI command length */
+	if (len > HCI_MAX_COMMAND_SIZE) {
+		BT_ERR("%s: command is larger than max buf size, length = %d", __func__, len);
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	skb = alloc_skb(sizeof(buf) + BT_SKB_RESERVE, GFP_ATOMIC);
+	if (!skb) {
+		BTMTK_ERR("%s allocate skb failed!!", __func__);
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	/* send HCI command */
+	bt_cb(skb)->pkt_type = HCI_COMMAND_PKT;
+
+	/* format */
+	/* 0xF0 XX XX 00 01 AA 10 BB CC CC CC CC ... */
+	/* XX XX total length */
+	/* 00 : hci index setting type */
+	/* AA hci index to indicate which hci send following command*/
+	/* 10 : raw data type*/
+	/* BB command length */
+	/* CC command */
+	if (o_fwlog_buf[0] == FWLOG_TYPE) {
+		while (index < ((o_fwlog_buf[2] << 8) + o_fwlog_buf[1])) {
+			switch (o_fwlog_buf[index]) {
+			case FWLOG_HCI_IDX:    /* hci index */
+				vlen = o_fwlog_buf[index + 1];
+				hci_idx = o_fwlog_buf[index + 2];
+				BTMTK_DBG("%s: send to hci%d", __func__, hci_idx);
+				index += (FWLOG_ATTR_TL_SIZE + vlen);
+				break;
+			case FWLOG_TX:    /* tx raw data */
+				vlen = o_fwlog_buf[index + 1];
+				memcpy(skb->data, o_fwlog_buf + index + FWLOG_ATTR_TL_SIZE, vlen);
+				skb->len = vlen;
+				index = index + FWLOG_ATTR_TL_SIZE + vlen;
+				break;
+			default:
+				BTMTK_WARN("Invalid opcode");
+				ret = -1;
+				goto free_skb;
+			}
+		}
+	} else {
+		memcpy(skb->data, o_fwlog_buf, len);
+		skb->len = len;
+		g_bdev[hci_idx]->opcode_usr[0] = o_fwlog_buf[1];
+		g_bdev[hci_idx]->opcode_usr[1] = o_fwlog_buf[2];
+	}
+
+	/* won't send command if g_bdev not define */
+	if (!g_bdev[hci_idx]->hdev) {
+		BTMTK_DBG("g_bdev[%d] not define", hci_idx);
+		ret = count;
+		goto free_skb;
+	}
+
+	/* clean fwlog queue before enable picus log */
+	if (skb_queue_len(&g_fwlog->fwlog_queue) && skb->data[0] == 0x01 &&
+	    skb->data[1] == 0x5d && skb->data[2] == 0xfc && skb->data[4] == 0x00) {
+		skb_queue_purge(&g_fwlog->fwlog_queue);
+		BTMTK_INFO("clean fwlog_queue, skb_queue_len = %d",
+			   skb_queue_len(&g_fwlog->fwlog_queue));
+	}
+
+	btmtk_dispatch_data_bluetooth_kpi(bdev->hdev, skb->data, skb->len, KPI_WITHOUT_TYPE);
+
+	ret = main_info.hif_hook.send_cmd(g_bdev[hci_idx], skb, 0, 0, (int)BTMTK_TX_PKT_FROM_HOST);
+	if (ret < 0) {
+		BTMTK_ERR("%s failed!!", __func__);
+		goto free_skb;
+	} else {
+		BTMTK_INFO("%s: OK", __func__);
+	}
+
+	BTMTK_INFO("%s: Write end(len: %d)", __func__, len);
+	ret = count;
+	goto exit;
+
+free_skb:
+	kfree_skb(skb);
+	skb = NULL;
+exit:
+	kfree(i_fwlog_buf);
+	kfree(o_fwlog_buf);
+
+	return ret;	/* If input is correct should return the same length */
+}
+
+int btmtk_fops_openfwlog(struct inode *inode, struct file *file)
+{
+	BTMTK_INFO("%s: Start.", __func__);
+
+	return 0;
+}
+
+int btmtk_fops_closefwlog(struct inode *inode, struct file *file)
+{
+	BTMTK_INFO("%s: Start.", __func__);
+
+	return 0;
+}
+
+long btmtk_fops_unlocked_ioctlfwlog(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	BTMTK_INFO("%s: Start.", __func__);
+
+	return 0;
+}
+
+unsigned int btmtk_fops_pollfwlog(struct file *file, poll_table *wait)
+{
+	unsigned int mask = 0;
+
+	poll_wait(file, &g_fwlog->fw_log_inq, wait);
+	if (skb_queue_len(&g_fwlog->fwlog_queue) > 0)
+		mask |= POLLIN | POLLRDNORM;			/* readable */
+
+	return mask;
+}
+
+static void btmtk_free_fw_cfg_struct(struct fw_cfg_struct *fw_cfg,
+	int count)
+{
+	int i = 0;
+
+	for (i = 0; i < count; i++) {
+		if (fw_cfg[i].content) {
+			BTMTK_INFO("%s:kfree %d", __func__, i);
+			kfree(fw_cfg[i].content);
+			fw_cfg[i].content = NULL;
+			fw_cfg[i].length = 0;
+		} else {
+			fw_cfg[i].length = 0;
+		}
+	}
+}
+
+void btmtk_free_setting_file(struct btmtk_dev *bdev)
+{
+	BTMTK_INFO("%s begin", __func__);
+	if (!bdev) {
+		BTMTK_ERR("%s: bdev == NULL", __func__);
+		return;
+	}
+
+	btmtk_free_fw_cfg_struct(bdev->woble_setting_apcf, WOBLE_SETTING_COUNT);
+	btmtk_free_fw_cfg_struct(bdev->woble_setting_apcf_fill_mac, WOBLE_SETTING_COUNT);
+	btmtk_free_fw_cfg_struct(bdev->woble_setting_apcf_fill_mac_location, WOBLE_SETTING_COUNT);
+	btmtk_free_fw_cfg_struct(bdev->woble_setting_apcf_resume, WOBLE_SETTING_COUNT);
+	btmtk_free_fw_cfg_struct(&bdev->woble_setting_radio_off, 1);
+	btmtk_free_fw_cfg_struct(&bdev->woble_setting_radio_off_status_event, 1);
+	btmtk_free_fw_cfg_struct(&bdev->woble_setting_radio_off_comp_event, 1);
+	btmtk_free_fw_cfg_struct(&bdev->woble_setting_radio_on, 1);
+	btmtk_free_fw_cfg_struct(&bdev->woble_setting_radio_on_status_event, 1);
+	btmtk_free_fw_cfg_struct(&bdev->woble_setting_radio_on_comp_event, 1);
+	btmtk_free_fw_cfg_struct(&bdev->woble_setting_wakeup_type, 1);
+
+	bdev->woble_setting_len = 0;
+
+	btmtk_free_fw_cfg_struct(&bdev->bt_cfg.picus_filter, 1);
+	btmtk_free_fw_cfg_struct(&bdev->bt_cfg.picus_enable, 1);
+	btmtk_free_fw_cfg_struct(bdev->bt_cfg.phase1_wmt_cmd, PHASE1_WMT_CMD_COUNT);
+	btmtk_free_fw_cfg_struct(bdev->bt_cfg.vendor_cmd, VENDOR_CMD_COUNT);
+
+	if (bdev->bt_cfg.support_woble_by_eint) {
+		if (bdev->wobt_irq != 0 && atomic_read(&(bdev->irq_enable_count)) == 1) {
+			BTMTK_INFO("disable BT IRQ:%d", bdev->wobt_irq);
+			atomic_dec(&(bdev->irq_enable_count));
+			disable_irq_nosync(bdev->wobt_irq);
+		} else
+			BTMTK_INFO("irq_enable count:%d", atomic_read(&(bdev->irq_enable_count)));
+		free_irq(bdev->wobt_irq, bdev);
+	}
+
+	memset(&bdev->bt_cfg, 0, sizeof(bdev->bt_cfg));
+	/* reset pin initial value need to be -1, used to judge after
+	 * disconnected before probe, can't do chip reset
+	 */
+	bdev->bt_cfg.dongle_reset_gpio_pin = -1;
+}
+
+void btmtk_initialize_cfg_items(struct btmtk_dev *bdev)
+{
+	BTMTK_INFO("%s begin", __func__);
+	if (bdev == NULL) {
+		BTMTK_ERR("%s: bdev is NULL", __func__);
+		return;
+	}
+
+	bdev->bt_cfg.dongle_reset_gpio_pin = 220;
+	bdev->bt_cfg.support_dongle_reset = 0;
+	bdev->bt_cfg.support_full_fw_dump = 0;
+	bdev->bt_cfg.support_unify_woble = 1;
+	bdev->bt_cfg.unify_woble_type = 0;
+	bdev->bt_cfg.support_woble_by_eint = 0;
+	bdev->bt_cfg.support_woble_for_bt_disable = 0;
+	bdev->bt_cfg.support_woble_wakelock = 0;
+	bdev->bt_cfg.reset_stack_after_woble = 0;
+	bdev->bt_cfg.support_auto_picus = 0;
+	bdev->bt_cfg.support_picus_to_host = 0;
+	bdev->bt_cfg.support_bt_single_sku = 0;
+	btmtk_free_fw_cfg_struct(&bdev->bt_cfg.picus_filter, 1);
+	btmtk_free_fw_cfg_struct(&bdev->bt_cfg.picus_enable, 1);
+	btmtk_free_fw_cfg_struct(bdev->bt_cfg.phase1_wmt_cmd, PHASE1_WMT_CMD_COUNT);
+	btmtk_free_fw_cfg_struct(bdev->bt_cfg.vendor_cmd, VENDOR_CMD_COUNT);
+
+	BTMTK_INFO("%s end", __func__);
+}
+
+int btmtk_get_chip_state(struct btmtk_dev *bdev)
+{
+	int state = BTMTK_STATE_INIT;
+
+	CHIP_STATE_MUTEX_LOCK();
+	state = bdev->interface_state;
+	CHIP_STATE_MUTEX_UNLOCK();
+
+	return state;
+}
+
+void btmtk_set_chip_state(struct btmtk_dev *bdev, int new_state)
+{
+	static const char * const state_msg[] = {
+		"UNKNOWN", "INIT", "DISCONNECT", "PROBE", "WORKING", "SUSPEND", "RESUME",
+		"FW_DUMP", "STANDBY", "SUBSYS_RESET",
+	};
+
+	BTMTK_INFO("%s: %s(%d) -> %s(%d)", __func__, state_msg[bdev->interface_state],
+			bdev->interface_state, state_msg[new_state], new_state);
+
+	CHIP_STATE_MUTEX_LOCK();
+	bdev->interface_state = new_state;
+	CHIP_STATE_MUTEX_UNLOCK();
+}
+
+static int btmtk_fops_get_state(struct btmtk_dev *bdev)
+{
+	int state = BTMTK_FOPS_STATE_INIT;
+
+	FOPS_MUTEX_LOCK();
+	state = bdev->fops_state;
+	FOPS_MUTEX_UNLOCK();
+
+	return state;
+}
+
+static void btmtk_fops_set_state(struct btmtk_dev *bdev, int new_state)
+{
+	static const char * const fstate_msg[] = {
+		"UNKNOWN", "INIT", "OPENING", "OPENED", "CLOSING", "CLOSED",
+	};
+
+	BTMTK_INFO("%s: FOPS_%s(%d) -> FOPS_%s(%d)", __func__, fstate_msg[bdev->fops_state],
+			bdev->fops_state, fstate_msg[new_state], new_state);
+	FOPS_MUTEX_LOCK();
+	bdev->fops_state = new_state;
+	FOPS_MUTEX_UNLOCK();
+}
+
+unsigned long btmtk_kallsyms_lookup_name(const char *name)
+{
+	unsigned long ret = 0;
+
+	ret = kallsyms_lookup_name(name);
+	if (ret) {
+#ifdef CONFIG_ARM
+#ifdef CONFIG_THUMB2_KERNEL
+		/*set bit 0 in address for thumb mode*/
+		ret |= 1;
+#endif
+#endif
+	}
+	return ret;
+}
+
+struct btmtk_main_info *btmtk_get_main_info(void)
+{
+	return &main_info;
+}
+
+static void btmtk_hci_snoop_print_to_log(void)
+{
+	int counter, index;
+
+	BTMTK_INFO("HCI Command Dump");
+	BTMTK_INFO("Using A5 A5 to separator the head 32 bytes and the tail 32 bytes data");
+	BTMTK_INFO("index(len)(timestamp:us) :HCI Command");
+	index = hci_cmd_index + 1;
+	if (index >= HCI_SNOOP_ENTRY_NUM)
+		index = 0;
+	for (counter = 0; counter < HCI_SNOOP_ENTRY_NUM; counter++) {
+		if (hci_cmd_len[index] > 0)
+			BTMTK_INFO_RAW(hci_cmd_buf[index], hci_cmd_len[index],
+				"time(%u)-act_len(%d)-len(%d):", hci_cmd_timestamp[index],
+				hci_cmd_actual_len[index], hci_cmd_len[index]);
+		index++;
+		if (index >= HCI_SNOOP_ENTRY_NUM)
+			index = 0;
+	}
+
+	BTMTK_INFO("HCI Event Dump");
+	BTMTK_INFO("Using A5 A5 to separator the head 32 bytes and the tail 32 bytes data");
+	BTMTK_INFO("index(len)(timestamp:us) :HCI Event");
+	index = hci_event_index + 1;
+	if (index >= HCI_SNOOP_ENTRY_NUM)
+		index = 0;
+	for (counter = 0; counter < HCI_SNOOP_ENTRY_NUM; counter++) {
+		if (hci_event_len[index] > 0)
+			BTMTK_INFO_RAW(hci_event_buf[index], hci_event_len[index],
+				"time(%u)-act_len(%d)-len(%d):", hci_event_timestamp[index],
+				hci_event_actual_len[index], hci_event_len[index]);
+		index++;
+		if (index >= HCI_SNOOP_ENTRY_NUM)
+			index = 0;
+	}
+
+	BTMTK_INFO("HCI ADV Event Dump");
+	BTMTK_INFO("Using A5 A5 to separator the head 32 bytes and the tail 32 bytes data");
+	BTMTK_INFO("index(len)(timestamp:us) :HCI ADV Event");
+	index = hci_adv_event_index + 1;
+	if (index >= HCI_SNOOP_ENTRY_NUM)
+		index = 0;
+	for (counter = 0; counter < HCI_SNOOP_ENTRY_NUM; counter++) {
+		if (hci_adv_event_len[index] > 0)
+			BTMTK_INFO_RAW(hci_adv_event_buf[index], hci_adv_event_len[index],
+				"time(%u)-act_len(%d)-len(%d):", hci_adv_event_timestamp[index],
+				hci_adv_event_actual_len[index], hci_adv_event_len[index]);
+		index++;
+		if (index >= HCI_SNOOP_ENTRY_NUM)
+			index = 0;
+	}
+
+	BTMTK_INFO("HCI ACL Dump");
+	BTMTK_INFO("Using A5 A5 to separator the head 32 bytes and the tail 32 bytes data");
+	BTMTK_INFO("index(len)(timestamp:us) :ACL");
+	index = hci_acl_index + 1;
+	if (index >= HCI_SNOOP_ENTRY_NUM)
+		index = 0;
+	for (counter = 0; counter < HCI_SNOOP_ENTRY_NUM; counter++) {
+		if (hci_acl_len[index] > 0) {
+			BTMTK_INFO_RAW(hci_acl_buf[index], hci_acl_len[index],
+				"time(%u)-act_len(%d)-len(%d):", hci_acl_timestamp[index],
+				hci_acl_actual_len[index], hci_acl_len[index]);
+		}
+		index++;
+		if (index >= HCI_SNOOP_ENTRY_NUM)
+			index = 0;
+	}
+}
+
+static unsigned int btmtk_hci_snoop_get_microseconds(void)
+{
+	struct timeval now;
+
+	do_gettimeofday(&now);
+	return now.tv_sec * 1000000 + now.tv_usec;
+}
+
+void btmtk_hci_snoop_save_cmd(u32 len, u8 *buf)
+{
+	u32 copy_len = HCI_SNOOP_BUF_SIZE;
+	u32 copy_tail_len = HCI_SNOOP_BUF_SIZE;
+	u8 separator_char[] = {0xA5, 0xA5};
+	u8 *copy_tail_buf;
+
+	if (buf && len > 0) {
+		if (len < HCI_SNOOP_BUF_SIZE) {
+			copy_len = len;
+			copy_tail_len = 0;
+		} else if (len > HCI_SNOOP_BUF_SIZE && len <= HCI_SNOOP_BUF_SIZE * 2)
+			copy_tail_len = len - copy_len;
+
+		hci_cmd_len[hci_cmd_index] = copy_len & 0xff;
+		hci_cmd_actual_len[hci_cmd_index] = len & 0xffff;
+		hci_cmd_timestamp[hci_cmd_index] = btmtk_hci_snoop_get_microseconds();
+		memset(hci_cmd_buf[hci_cmd_index], 0, HCI_SNOOP_MAX_BUF_SIZE);
+		memcpy(hci_cmd_buf[hci_cmd_index], buf, copy_len & 0xff);
+		/* save less then 32 bytes data in the buffer tail, using A5 A5 to
+		 * separator the head 32 bytes data and the tail 32 bytes data
+		 */
+		if (copy_tail_len > 0) {
+			copy_tail_buf = buf + len - copy_tail_len;
+			hci_cmd_len[hci_cmd_index] +=
+				(copy_tail_len + sizeof(separator_char)) & 0xff;
+			memcpy(hci_cmd_buf[hci_cmd_index] + copy_len, separator_char,
+				sizeof(separator_char));
+			memcpy(hci_cmd_buf[hci_cmd_index] + copy_len + sizeof(separator_char),
+				copy_tail_buf, copy_tail_len);
+		}
+
+		hci_cmd_index--;
+		if (hci_cmd_index < 0)
+			hci_cmd_index = HCI_SNOOP_ENTRY_NUM - 1;
+	}
+}
+
+void btmtk_hci_snoop_save_adv_event(u32 len, u8 *buf)
+{
+	u32 copy_len = HCI_SNOOP_BUF_SIZE;
+	u32 copy_tail_len = HCI_SNOOP_BUF_SIZE;
+	u8 separator_char[] = {0xA5, 0xA5};
+	u8 *copy_tail_buf;
+
+	if (buf && len > 0) {
+		if (len < HCI_SNOOP_BUF_SIZE) {
+			copy_len = len;
+			copy_tail_len = 0;
+		} else if (len > HCI_SNOOP_BUF_SIZE && len <= HCI_SNOOP_BUF_SIZE * 2)
+			copy_tail_len = len - copy_len;
+
+		hci_adv_event_len[hci_adv_event_index] = copy_len & 0xff;
+		hci_adv_event_actual_len[hci_adv_event_index] = len & 0xffff;
+		hci_adv_event_timestamp[hci_adv_event_index] = btmtk_hci_snoop_get_microseconds();
+		memset(hci_adv_event_buf[hci_adv_event_index], 0, HCI_SNOOP_MAX_BUF_SIZE);
+		memcpy(hci_adv_event_buf[hci_adv_event_index], buf, copy_len);
+		/* save less then 32 bytes data in the buffer tail, using A5 A5 to
+		 * separator the head 32 bytes data and the tail 32 bytes data
+		 */
+		if (copy_tail_len > 0) {
+			copy_tail_buf = buf + len - copy_tail_len;
+			hci_adv_event_len[hci_adv_event_index] +=
+				(copy_tail_len + sizeof(separator_char)) & 0xff;
+			memcpy(hci_adv_event_buf[hci_adv_event_index] + copy_len, separator_char,
+			       sizeof(separator_char));
+			memcpy(hci_adv_event_buf[hci_adv_event_index] + copy_len +
+			       sizeof(separator_char), copy_tail_buf, copy_tail_len);
+		}
+
+		hci_adv_event_index--;
+		if (hci_adv_event_index < 0)
+			hci_adv_event_index = HCI_SNOOP_ENTRY_NUM - 1;
+	}
+}
+
+void btmtk_hci_snoop_save_event(u32 len, u8 *buf)
+{
+	u32 copy_len = HCI_SNOOP_BUF_SIZE;
+	u32 copy_tail_len = HCI_SNOOP_BUF_SIZE;
+	u8 separator_char[] = {0xA5, 0xA5};
+	u8 *copy_tail_buf;
+
+	if (buf && len > 0) {
+		if (len < HCI_SNOOP_BUF_SIZE) {
+			copy_len = len;
+			copy_tail_len = 0;
+		} else if (len > HCI_SNOOP_BUF_SIZE && len <= HCI_SNOOP_BUF_SIZE * 2)
+			copy_tail_len = len - copy_len;
+
+		hci_event_len[hci_event_index] = copy_len & 0xff;
+		hci_event_actual_len[hci_event_index] = len & 0xffff;
+		hci_event_timestamp[hci_event_index] = btmtk_hci_snoop_get_microseconds();
+		memset(hci_event_buf[hci_event_index], 0, HCI_SNOOP_MAX_BUF_SIZE);
+		memcpy(hci_event_buf[hci_event_index], buf, copy_len);
+		/* save less then 32 bytes data in the buffer tail, using A5 A5 to
+		 * separator the head 32 bytes data and the tail 32 bytes data
+		 */
+		if (copy_tail_len > 0) {
+			copy_tail_buf = buf + len - copy_tail_len;
+			hci_event_len[hci_event_index] +=
+				(copy_tail_len + sizeof(separator_char)) & 0xff;
+			memcpy(hci_event_buf[hci_event_index] + copy_len, separator_char,
+				sizeof(separator_char));
+			memcpy(hci_event_buf[hci_event_index] + copy_len + sizeof(separator_char),
+				copy_tail_buf, copy_tail_len);
+		}
+
+		hci_event_index--;
+		if (hci_event_index < 0)
+			hci_event_index = HCI_SNOOP_ENTRY_NUM - 1;
+	}
+}
+
+void btmtk_hci_snoop_save_acl(u32 len, u8 *buf)
+{
+	u32 copy_len = HCI_SNOOP_BUF_SIZE;
+	u32 copy_tail_len = HCI_SNOOP_BUF_SIZE;
+	u8 separator_char[] = {0xA5, 0xA5};
+	u8 *copy_tail_buf;
+
+	if (buf && len > 0) {
+		if (len < HCI_SNOOP_BUF_SIZE) {
+			copy_len = len;
+			copy_tail_len = 0;
+		} else if (len > HCI_SNOOP_BUF_SIZE && len <= HCI_SNOOP_BUF_SIZE * 2)
+			copy_tail_len = len - copy_len;
+
+		hci_acl_len[hci_acl_index] = copy_len & 0xff;
+		hci_acl_actual_len[hci_acl_index] = len & 0xffff;
+		hci_acl_timestamp[hci_acl_index] = btmtk_hci_snoop_get_microseconds();
+		memset(hci_acl_buf[hci_acl_index], 0, HCI_SNOOP_MAX_BUF_SIZE);
+		memcpy(hci_acl_buf[hci_acl_index], buf, copy_len & 0xff);
+		/* save less then 32 bytes data in the buffer tail, using A5 A5 to
+		 * separator the head 32 bytes data and the tail 32 bytes data
+		 */
+		if (copy_tail_len > 0) {
+			copy_tail_buf = buf + len - copy_tail_len;
+			hci_acl_len[hci_acl_index] += (copy_tail_len +
+						      sizeof(separator_char)) & 0xff;
+			memcpy(hci_acl_buf[hci_acl_index] + copy_len, separator_char,
+			       sizeof(separator_char));
+			memcpy(hci_acl_buf[hci_acl_index] + copy_len + sizeof(separator_char),
+			       copy_tail_buf, copy_tail_len);
+		}
+
+		hci_acl_index--;
+		if (hci_acl_index < 0)
+			hci_acl_index = HCI_SNOOP_ENTRY_NUM - 1;
+	}
+}
+
+void btmtk_hci_snoop_print(u32 len, const u8 *buf)
+{
+	u32 copy_len = HCI_SNOOP_BUF_SIZE;
+	u32 copy_tail_len = HCI_SNOOP_BUF_SIZE;
+	u8 separator_char[] = {0xA5, 0xA5};
+	const u8 *copy_tail_buf;
+	u8 hci_snoop_buf[HCI_SNOOP_MAX_BUF_SIZE] = {0};
+	u16 hci_snoop_len = 0;
+
+	if (buf && len > 0) {
+		if (len < HCI_SNOOP_BUF_SIZE) {
+			copy_len = len;
+			copy_tail_len = 0;
+		} else if (len > HCI_SNOOP_BUF_SIZE && len <= HCI_SNOOP_BUF_SIZE * 2)
+			copy_tail_len = len - copy_len;
+
+		memcpy(hci_snoop_buf, buf, copy_len & 0xff);
+		hci_snoop_len = copy_len & 0xff;
+
+		/* save less then 32 bytes data in the buffer tail, using A5 A5 to
+		 * separator the head 32 bytes data and the tail 32 bytes data
+		 */
+		if (copy_tail_len > 0) {
+			copy_tail_buf = buf + len - copy_tail_len;
+			hci_snoop_len += (copy_tail_len + sizeof(separator_char)) & 0xff;
+			memcpy(hci_snoop_buf + copy_len, separator_char, sizeof(separator_char));
+			memcpy(hci_snoop_buf + copy_len + sizeof(separator_char),
+				copy_tail_buf, copy_tail_len);
+		}
+
+		if (hci_snoop_len > 0)
+			BTMTK_INFO_RAW(hci_snoop_buf, hci_snoop_len, "act_len(%d)-len(%d)-buf(%p):",
+				len, hci_snoop_len, buf);
+	}
+}
+
+static int btmtk_reboot_notify(struct notifier_block *nb,
+			unsigned long event, void *unused)
+{
+	int ret = 0;
+	int i = 0;
+	int cif_event = 0;
+	int fstate = 0;
+	int state = 0;
+	struct btmtk_cif_state *cif_state = NULL;
+	struct btmtk_dev *bdev = NULL;
+
+	BTMTK_INFO("%s: (%d)", __func__, (int)event);
+
+	if (event == SYS_RESTART) {
+		BTMTK_INFO("%s: enter", __func__);
+		for (i = 0; i < btmtk_intf_num; i++) {
+			/* Find valid dev for already probe interface. */
+			if (!g_bdev[i]->hdev) {
+				bdev = g_bdev[i];
+
+				fstate = btmtk_fops_get_state(bdev);
+				if (fstate != BTMTK_FOPS_STATE_OPENED) {
+					BTMTK_WARN("%s: fops is not opened(%d)", __func__, fstate);
+					continue;
+				}
+
+				state = btmtk_get_chip_state(bdev);
+				if (state != BTMTK_STATE_WORKING) {
+					BTMTK_WARN("%s: not in working(%d).", __func__, state);
+					continue;
+				}
+
+				cif_event = HIF_EVENT_DISCONNECT;
+				if (BTMTK_CIF_IS_NULL(bdev, cif_event)) {
+					/* Error */
+					BTMTK_WARN("%s parameter is NULL", __func__);
+					continue;
+				}
+
+				cif_state = &bdev->cif_state[cif_event];
+				/* Set Entering state */
+				btmtk_set_chip_state((void *)bdev, cif_state->ops_enter);
+
+				btmtk_fops_set_state(bdev, BTMTK_FOPS_STATE_CLOSING);
+
+				if (main_info.hif_hook.cif_mutex_lock)
+					main_info.hif_hook.cif_mutex_lock(bdev);
+
+				ret = btmtk_send_deinit_cmds(bdev);
+				if (ret < 0)
+					BTMTK_ERR("%s, btmtk_send_deinit_cmds failed", __func__);
+
+				main_info.hif_hook.close(bdev->hdev);
+
+				if (main_info.hif_hook.cif_mutex_unlock)
+					main_info.hif_hook.cif_mutex_unlock(bdev);
+
+				btmtk_fops_set_state(bdev, BTMTK_FOPS_STATE_CLOSED);
+
+				/* Set End/Error state */
+				if (ret == 0)
+					btmtk_set_chip_state((void *)bdev, cif_state->ops_end);
+				else
+					btmtk_set_chip_state((void *)bdev, cif_state->ops_error);
+			}
+		}
+	}
+
+	return 0;
+}
+
+static struct notifier_block btmtk_reboot_notifier = {
+	.notifier_call = btmtk_reboot_notify,
+	.next = NULL,
+	.priority = 0,
+};
+
+static int main_init(void)
+{
+	int i = 0;
+
+	BTMTK_INFO("%s", __func__);
+
+	/* Check if user changes default minimum supported intf count */
+	if (btmtk_intf_num < BT_MCU_MINIMUM_INTERFACE_NUM) {
+		btmtk_intf_num = BT_MCU_MINIMUM_INTERFACE_NUM;
+		BTMTK_WARN("%s minimum interface is %d", __func__, btmtk_intf_num);
+	}
+
+	BTMTK_INFO("%s supported intf count <%d>", __func__, btmtk_intf_num);
+
+	/* register system power off callback function. */
+	do {
+		typedef void (*func_ptr) (int (*f) (void));
+		char *func_name = "RegisterPdwncCallback";
+		func_ptr pFunc = (func_ptr) btmtk_kallsyms_lookup_name(func_name);
+
+		if (pFunc) {
+			BTMTK_INFO("%s: Register Pdwnc callback success.", __func__);
+			pFunc(&btmtk_enter_standby);
+		} else
+			BTMTK_WARN("%s: No Exported Func Found [%s], just skip!",
+				   __func__, func_name);
+	} while (0);
+
+	BTMTK_INFO("%s: Register reboot_notifier callback success.", __func__);
+	/* Is it necessary? bt_close will be called by reboot. */
+	register_reboot_notifier(&btmtk_reboot_notifier);
+
+	g_bdev = kzalloc((sizeof(*g_bdev) * btmtk_intf_num), GFP_KERNEL);
+	if (!g_bdev) {
+		BTMTK_WARN("%s insufficient memory", __func__);
+		return -ENOMEM;
+	}
+
+	for (i = 0; i < btmtk_intf_num; i++) {
+		g_bdev[i] = btmtk_allocate_dev_memory(NULL);
+		if (g_bdev[i]) {
+			/* BTMTK_STATE_UNKNOWN instead? */
+			/* btmtk_set_chip_state(g_bdev[i], BTMTK_STATE_INIT); */
+
+			/* BTMTK_FOPS_STATE_UNKNOWN instead? */
+			btmtk_fops_set_state(g_bdev[i], BTMTK_FOPS_STATE_INIT);
+		} else {
+			return -ENOMEM;
+		}
+	}
+
+#ifdef CONFIG_MP_WAKEUP_SOURCE_SYSFS_STAT
+	main_info.fwdump_ws = wakeup_source_register(NULL, "btmtk_fwdump_wakelock");
+	main_info.woble_ws = wakeup_source_register(NULL, "btmtk_woble_wakelock");
+	main_info.eint_ws = wakeup_source_register(NULL, "btevent_eint");
+#else
+	main_info.fwdump_ws = wakeup_source_register("btmtk_fwdump_wakelock");
+	main_info.woble_ws = wakeup_source_register("btmtk_woble_wakelock");
+	main_info.eint_ws = wakeup_source_register("btevent_eint");
+#endif
+	return 0;
+}
+
+static int main_exit(void)
+{
+	int i = 0;
+
+	BTMTK_INFO("%s releasing intf count <%d>", __func__, btmtk_intf_num);
+
+	if (g_bdev == NULL) {
+		BTMTK_WARN("%s g_data is NULL", __func__);
+		return 0;
+	}
+
+	BTMTK_INFO("%s: Register reboot_notifier callback success.", __func__);
+	/* Is it necessary? bt_close will be called by reboot. */
+	unregister_reboot_notifier(&btmtk_reboot_notifier);
+
+	wakeup_source_unregister(main_info.fwdump_ws);
+	wakeup_source_unregister(main_info.woble_ws);
+	wakeup_source_unregister(main_info.eint_ws);
+
+	for (i = 0; i < btmtk_intf_num; i++) {
+		if (g_bdev[i] != NULL)
+			btmtk_free_dev_memory(NULL, g_bdev[i]);
+	}
+
+	kfree(g_bdev);
+	return 0;
+}
+
+/* HCI receive mechnism */
+
+
+static inline struct sk_buff *h4_recv_buf(struct hci_dev *hdev,
+					  struct sk_buff *skb,
+					  const unsigned char *buffer,
+					  int count,
+					  const struct h4_recv_pkt *pkts,
+					  int pkts_count)
+{
+	struct btmtk_dev *bdev = NULL;
+	/* used for print debug log*/
+	const unsigned char *buffer_dbg = buffer;
+	int count_dbg = count;
+
+	if (hdev == NULL || buffer == NULL) {
+		BTMTK_ERR("%s, invalid parameters!", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+
+	bdev = hci_get_drvdata(hdev);
+	if (bdev == NULL) {
+		BTMTK_ERR("%s, bdev is invalid", __func__);
+		return ERR_PTR(-EINVAL);
+	}
+	/* Check for error from previous call */
+	if (IS_ERR(skb))
+		skb = NULL;
+	/* BTMTK_DBG("%s begin, count = %d", __func__, count); */
+
+	while (count) {
+		int i, len;
+
+		if (!skb) {
+			for (i = 0; i < pkts_count; i++) {
+				if (buffer[0] != (&pkts[i])->type)
+					continue;
+
+				skb = bt_skb_alloc((&pkts[i])->maxlen,
+						   GFP_ATOMIC);
+				if (!skb) {
+					BTMTK_ERR("%s, alloc skb failed!", __func__);
+					return ERR_PTR(-ENOMEM);
+				}
+
+				hci_skb_pkt_type(skb) = (&pkts[i])->type;
+				hci_skb_expect(skb) = (&pkts[i])->hlen;
+				break;
+			}
+
+			/* Check for invalid packet type */
+			if (!skb) {
+				BTMTK_ERR("%s,skb is invalid, buffer[0] = %d!", __func__,
+					buffer[0]);
+				btmtk_hci_snoop_print(count_dbg, buffer_dbg);
+				btmtk_hci_snoop_print(count, buffer);
+				btmtk_hci_snoop_print_to_log();
+				return ERR_PTR(-EILSEQ);
+			}
+
+			count -= 1;
+			buffer += 1;
+		}
+
+		len = min_t(uint, hci_skb_expect(skb) - skb->len, count);
+		memcpy(skb_put(skb, len), buffer, len);
+		/* If kernel version > 4.x */
+		/* skb_put_data(skb, buffer, len); */
+
+		count -= len;
+		buffer += len;
+
+		/* BTMTK_DBG("%s skb->len = %d, %d", __func__, skb->len, hci_skb_expect(skb)); */
+
+		/* Check for partial packet */
+		if (skb->len < hci_skb_expect(skb))
+			continue;
+
+		for (i = 0; i < pkts_count; i++) {
+			if (hci_skb_pkt_type(skb) == (&pkts[i])->type)
+				break;
+		}
+
+		if (i >= pkts_count) {
+			BTMTK_ERR("%s, pkt type is invalid!", __func__);
+			btmtk_hci_snoop_print(count_dbg, buffer_dbg);
+			btmtk_hci_snoop_print(count, buffer);
+			btmtk_hci_snoop_print_to_log();
+			kfree_skb(skb);
+			return ERR_PTR(-EILSEQ);
+		}
+
+		if (skb->len == (&pkts[i])->hlen) {
+			u16 dlen;
+
+			/* BTMTK_DBG("%s begin, skb->len = %d, %d, %d", __func__, skb->len, */
+			/* (&pkts[i])->hlen, (&pkts[i])->lsize); */
+			switch ((&pkts[i])->lsize) {
+			case 0:
+				/* No variable data length */
+				dlen = 0;
+				break;
+			case 1:
+				/* Single octet variable length */
+				dlen = skb->data[(&pkts[i])->loff];
+				hci_skb_expect(skb) += dlen;
+
+				if (skb_tailroom(skb) < dlen) {
+					BTMTK_ERR("%s, skb_tailroom is not enough, dlen:%d!",
+						__func__, dlen);
+					btmtk_hci_snoop_print(skb->len, skb->data);
+					btmtk_hci_snoop_print(count_dbg, buffer_dbg);
+					btmtk_hci_snoop_print(count, buffer);
+					btmtk_hci_snoop_print_to_log();
+					kfree_skb(skb);
+					return ERR_PTR(-EMSGSIZE);
+				}
+				break;
+			case 2:
+				/* Double octet variable length */
+				dlen = get_unaligned_le16(skb->data +
+							  (&pkts[i])->loff);
+				hci_skb_expect(skb) += dlen;
+
+				if (skb_tailroom(skb) < dlen) {
+					BTMTK_ERR("%s, skb_tailroom in case 2, dlen:%d!"
+						, __func__, dlen);
+					btmtk_hci_snoop_print(skb->len, skb->data);
+					btmtk_hci_snoop_print(count_dbg, buffer_dbg);
+					btmtk_hci_snoop_print(count, buffer);
+					btmtk_hci_snoop_print_to_log();
+					kfree_skb(skb);
+					return ERR_PTR(-EMSGSIZE);
+				}
+				break;
+			default:
+				/* Unsupported variable length */
+				BTMTK_ERR("%s, Unsupported variable length!", __func__);
+				btmtk_hci_snoop_print(count_dbg, buffer_dbg);
+				btmtk_hci_snoop_print(count, buffer);
+				btmtk_hci_snoop_print_to_log();
+				kfree_skb(skb);
+				return ERR_PTR(-EILSEQ);
+			}
+
+			if (!dlen) {
+				/* No more data, complete frame */
+				(&pkts[i])->recv(hdev, skb);
+				skb = NULL;
+			}
+		} else {
+			/* Complete frame */
+			(&pkts[i])->recv(hdev, skb);
+			skb = NULL;
+		}
+	}
+
+	return skb;
+}
+
+static const struct h4_recv_pkt mtk_recv_pkts[] = {
+	{ H4_RECV_ACL,      .recv = btmtk_recv_acl },
+	{ H4_RECV_SCO,      .recv = hci_recv_frame },
+	{ H4_RECV_EVENT,    .recv = btmtk_recv_event },
+};
+#if ENABLESTP
+static inline struct sk_buff *mtk_add_stp(struct btmtk_dev *bdev, struct sk_buff *skb)
+{
+	struct mtk_stp_hdr *shdr;
+	int dlen, err = 0, type = 0;
+	u8 stp_crc[] = {0x00, 0x00};
+
+	if (unlikely(skb_headroom(skb) < sizeof(*shdr)) ||
+		(skb_tailroom(skb) < MTK_STP_TLR_SIZE)) {
+		BTMTK_DBG("%s, add pskb_expand_head, headroom = %d, tailroom = %d",
+				__func__, skb_headroom(skb), skb_tailroom(skb));
+
+		err = pskb_expand_head(skb, sizeof(*shdr), MTK_STP_TLR_SIZE,
+					   GFP_ATOMIC);
+	}
+	dlen = skb->len;
+	shdr = (void *) skb_push(skb, sizeof(*shdr));
+	shdr->prefix = 0x80;
+	shdr->dlen = cpu_to_be16((dlen & 0x0fff) | (type << 12));
+	shdr->cs = 0;
+	// Add the STP trailer
+	// kernel version > 4.20
+	// skb_put_zero(skb, MTK_STP_TLR_SIZE);
+	// kernel version < 4.20
+	skb_put(skb, sizeof(stp_crc));
+
+	return skb;
+}
+
+static const unsigned char *
+mtk_stp_split(struct btmtk_dev *bdev, const unsigned char *data, int count,
+	      int *sz_h4)
+{
+	struct mtk_stp_hdr *shdr;
+
+	/* The cursor is reset when all the data of STP is consumed out */
+	if (!bdev->stp_dlen && bdev->stp_cursor >= 6) {
+		bdev->stp_cursor = 0;
+		BTMTK_ERR("reset cursor = %d\n", bdev->stp_cursor);
+	}
+
+	/* Filling pad until all STP info is obtained */
+	while (bdev->stp_cursor < 6 && count > 0) {
+		bdev->stp_pad[bdev->stp_cursor] = *data;
+		pr_err("fill stp format (%02x, %d, %d)\n",
+		   bdev->stp_pad[bdev->stp_cursor], bdev->stp_cursor, count);
+		bdev->stp_cursor++;
+		data++;
+		count--;
+	}
+
+	/* Retrieve STP info and have a sanity check */
+	if (!bdev->stp_dlen && bdev->stp_cursor >= 6) {
+		shdr = (struct mtk_stp_hdr *)&bdev->stp_pad[2];
+		bdev->stp_dlen = be16_to_cpu(shdr->dlen) & 0x0fff;
+		pr_err("stp format (%02x, %02x)",
+			   shdr->prefix, bdev->stp_dlen);
+
+		/* Resync STP when unexpected data is being read */
+		if (shdr->prefix != 0x80 || bdev->stp_dlen > 2048) {
+			BTMTK_ERR("stp format unexpect (%02x, %02x)",
+				   shdr->prefix, bdev->stp_dlen);
+			BTMTK_ERR("reset cursor = %d\n", bdev->stp_cursor);
+			bdev->stp_cursor = 2;
+			bdev->stp_dlen = 0;
+		}
+	}
+
+	/* Directly quit when there's no data found for H4 can process */
+	if (count <= 0)
+		return NULL;
+
+	/* Tranlate to how much the size of data H4 can handle so far */
+	*sz_h4 = min_t(int, count, bdev->stp_dlen);
+
+	/* Update the remaining size of STP packet */
+	bdev->stp_dlen -= *sz_h4;
+
+	/* Data points to STP payload which can be handled by H4 */
+	return data;
+}
+#endif
+
+int btmtk_recv(struct hci_dev *hdev, const u8 *data, size_t count)
+{
+	struct btmtk_dev *bdev = NULL;
+	const unsigned char *p_left = data;
+	int sz_left = count;
+	int err;
+#if ENABLESTP
+	const unsigned char **p_h4 = NULL;
+	int sz_h4 = 0, adv = 0;
+#endif
+
+	if (hdev == NULL || data == NULL) {
+		BTMTK_ERR("%s, invalid parameters!", __func__);
+		return -EINVAL;
+	}
+
+	bdev = hci_get_drvdata(hdev);
+	if (bdev == NULL) {
+		BTMTK_ERR("%s, bdev is NULL!", __func__);
+		return -EINVAL;
+	}
+
+	while (sz_left > 0) {
+		/*  The serial data received from MT7622 BT controller is
+		 *  at all time padded around with the STP header and tailer.
+		 *
+		 *  A full STP packet is looking like
+		 *   -----------------------------------
+		 *  | STP header  |  H:4   | STP tailer |
+		 *   -----------------------------------
+		 *  but it doesn't guarantee to contain a full H:4 packet which
+		 *  means that it's possible for multiple STP packets forms a
+		 *  full H:4 packet that means extra STP header + length doesn't
+		 *  indicate a full H:4 frame, things can fragment. Whose length
+		 *  recorded in STP header just shows up the most length the
+		 *  H:4 engine can handle currently.
+		 */
+#if ENABLESTP
+		p_h4 = mtk_stp_split(bdev, p_left, sz_left, &sz_h4);
+		if (!p_h4)
+			break;
+
+		adv = p_h4 - p_left;
+		sz_left -= adv;
+		p_left += adv;
+#endif
+
+#if ENABLESTP
+		bdev->rx_skb = h4_recv_buf(hdev, bdev->rx_skb, p_h4,
+					   sz_h4, mtk_recv_pkts,
+					   ARRAY_SIZE(mtk_recv_pkts));
+#else
+		bdev->rx_skb = h4_recv_buf(hdev, bdev->rx_skb, data,
+					   count, mtk_recv_pkts,
+					   ARRAY_SIZE(mtk_recv_pkts));
+#endif
+
+		if (IS_ERR(bdev->rx_skb)) {
+			err = PTR_ERR(bdev->rx_skb);
+			pr_err("Frame reassembly failed (%d)", err);
+			bdev->rx_skb = NULL;
+			return err;
+		}
+
+#if ENABLESTP
+		sz_left -= sz_h4;
+		p_left += sz_h4;
+#else
+		sz_left -= count;
+		p_left += count;
+#endif
+	}
+
+	return 0;
+}
+
+static int btmtk_dispatch_pkt(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct btmtk_dev *bdev = hci_get_drvdata(hdev);
+	static u8 fwlog_picus_blocking_warn;
+	static u8 fwlog_fwdump_blocking_warn;
+	int state = BTMTK_STATE_INIT;
+
+	if ((bt_cb(skb)->pkt_type == HCI_ACLDATA_PKT) &&
+			skb->data[0] == 0x6f &&
+			skb->data[1] == 0xfc) {
+		static int dump_data_counter;
+		static int dump_data_length;
+
+		state = btmtk_get_chip_state(bdev);
+		if (state != BTMTK_STATE_FW_DUMP) {
+			BTMTK_INFO("%s: FW dump begin", __func__);
+			btmtk_hci_snoop_print_to_log();
+			/* Print too much log, it may cause kernel panic. */
+			dump_data_counter = 0;
+			dump_data_length = 0;
+			btmtk_set_chip_state(bdev, BTMTK_STATE_FW_DUMP);
+			btmtk_fwdump_wake_lock(bdev);
+		}
+
+		dump_data_counter++;
+		dump_data_length += skb->len;
+
+		/* coredump */
+		/* print dump data to console */
+		if (dump_data_counter % 1000 == 0) {
+			BTMTK_INFO("%s: FW dump on-going, total_packet = %d, total_length = %d",
+					__func__, dump_data_counter, dump_data_length);
+		}
+
+		/* print dump data to console */
+		if (dump_data_counter < 20)
+			BTMTK_INFO("%s: FW dump data (%d): %s",
+					__func__, dump_data_counter, &skb->data[4]);
+
+		/* In the new generation, we will check the keyword of coredump (; coredump end)
+		 * Such as : 79xx
+		 */
+		if (skb->data[skb->len - 4] == 'e' &&
+			skb->data[skb->len - 3] == 'n' &&
+			skb->data[skb->len - 2] == 'd') {
+			/* This is the latest coredump packet. */
+			BTMTK_INFO("%s: FW dump end, dump_data_counter = %d",
+				   __func__, dump_data_counter);
+			/* TODO: Chip reset*/
+			main_info.reset_stack_flag = HW_ERR_CODE_CORE_DUMP;
+			btmtk_fwdump_wake_unlock(bdev);
+		}
+
+		if (skb_queue_len(&g_fwlog->fwlog_queue) < FWLOG_ASSERT_QUEUE_COUNT) {
+			/* sent picus data to queue, picus tool will log it */
+			if (btmtk_skb_enq_fwlog(bdev->hdev, skb->data,
+			    skb->len, 0, &g_fwlog->fwlog_queue) == 0) {
+				wake_up_interruptible(&g_fwlog->fw_log_inq);
+				fwlog_fwdump_blocking_warn = 0;
+			}
+		} else {
+			if (fwlog_fwdump_blocking_warn == 0) {
+				fwlog_fwdump_blocking_warn = 1;
+				pr_warn("btmtk fwlog queue size is full(coredump)");
+			}
+		}
+
+		if (!bdev->bt_cfg.support_picus_to_host)
+			return 1;
+	} else if ((bt_cb(skb)->pkt_type == HCI_ACLDATA_PKT) &&
+				(skb->data[0] == 0xff || skb->data[0] == 0xfe) &&
+				skb->data[1] == 0x05 &&
+				!bdev->bt_cfg.support_picus_to_host) {
+		/* picus or syslog */
+		if (skb_queue_len(&g_fwlog->fwlog_queue) < FWLOG_QUEUE_COUNT) {
+			if (btmtk_skb_enq_fwlog(bdev->hdev, skb->data, skb->len,
+				FWLOG_TYPE, &g_fwlog->fwlog_queue) == 0) {
+				wake_up_interruptible(&g_fwlog->fw_log_inq);
+				fwlog_picus_blocking_warn = 0;
+			}
+		} else {
+			if (fwlog_picus_blocking_warn == 0) {
+				fwlog_picus_blocking_warn = 1;
+				pr_warn("btmtk fwlog queue size is full(picus)");
+			}
+		}
+		return 1;
+	} else if ((bt_cb(skb)->pkt_type == HCI_EVENT_PKT) &&
+			skb->data[0] == 0x0E &&
+			bdev->opcode_usr[0] == skb->data[3] &&
+			bdev->opcode_usr[1] == skb->data[4]) {
+		BTMTK_INFO_RAW(skb->data, skb->len,
+			       "%s: Discard event from user hci command - ", __func__);
+		bdev->opcode_usr[0] = 0;
+		bdev->opcode_usr[1] = 0;
+		return 1;
+	} else if (memcmp(skb->data, RESET_EVENT, sizeof(RESET_EVENT)) == 0) {
+		BTMTK_INFO("%s: Get RESET_EVENT", __func__);
+		/* Need confirm with Shawn */
+		/* if (bdev->bt_cfg.support_auto_picus == true) {
+		 * if (btmtk_picus_enable(bdev) < 0) {
+		 * BTMTK_ERR("send picus filter param failed");
+		 * }
+		}
+		*/
+	}
+	return 0;
+}
+
+int btmtk_recv_acl(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct btmtk_dev *bdev = NULL;
+
+	if (hdev == NULL || skb == NULL) {
+		BTMTK_ERR("%s, invalid parameters!", __func__);
+		return -EINVAL;
+	}
+
+	bdev = hci_get_drvdata(hdev);
+	if (bdev == NULL || bdev->workqueue == NULL) {
+		BTMTK_ERR("%s, bdev or workqueue is invalid!", __func__);
+		return -EINVAL;
+	}
+
+	skb_queue_tail(&bdev->rx_q, skb);
+	queue_work(bdev->workqueue, &bdev->rx_work);
+
+	return 0;
+}
+
+
+int btmtk_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct btmtk_dev *bdev = NULL;
+	//struct hci_event_hdr *hdr = (void *)skb->data;
+
+	if (hdev == NULL || skb == NULL) {
+		BTMTK_ERR("%s, invalid parameters!", __func__);
+		return -EINVAL;
+	}
+
+	bdev = hci_get_drvdata(hdev);
+	if (bdev == NULL || bdev->workqueue == NULL) {
+		BTMTK_ERR("%s, bdev or workqueue is invalid!", __func__);
+		kfree_skb(skb);
+		return -EINVAL;
+	}
+
+	/* Fix up the vendor event id with 0xff for vendor specific instead
+	 * of 0xe4 so that event send via monitoring socket can be parsed
+	 * properly.
+	 */
+	/* if (hdr->evt == 0xe4) {
+	 * BTMTK_DBG("%s hdr->evt is %02x", __func__, hdr->evt);
+	 * hdr->evt = HCI_EV_VENDOR;
+	 * }
+	 */
+
+	BTMTK_DBG_RAW(skb->data, skb->len, "%s, recv evt(hci_recv_frame)", __func__);
+
+	skb_queue_tail(&bdev->rx_q, skb);
+	queue_work(bdev->workqueue, &bdev->rx_work);
+
+	return 0;
+}
+
+int btmtk_main_send_cmd(struct btmtk_dev *bdev, const u8 *cmd,
+		const int cmd_len, const u8 *event, const int event_len, int delay,
+		int retry, int pkt_type)
+{
+	struct sk_buff *skb = NULL;
+	int ret = 0;
+	int state = BTMTK_STATE_INIT;
+
+	if (bdev == NULL || bdev->hdev == NULL ||
+		cmd == NULL || cmd_len <= 0) {
+		BTMTK_ERR("%s, invalid parameters!", __func__);
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	if (memcmp(cmd, wmt_over_hci_header, sizeof(wmt_over_hci_header)) &&
+		pkt_type != BTMTK_TX_ACL_FROM_DRV &&
+		bdev->power_state != BTMTK_DONGLE_STATE_POWER_ON) {
+		BTMTK_WARN("%s: chip power isn't on, ignore this command, state is %d",
+			__func__, bdev->power_state);
+		goto exit;
+	}
+
+	state = btmtk_get_chip_state(bdev);
+	if (state == BTMTK_STATE_FW_DUMP) {
+		BTMTK_WARN("%s: FW dumping ongoing, don't send any cmd to FW!!!", __func__);
+		ret = -1;
+		goto exit;
+	}
+
+	skb = alloc_skb(cmd_len + BT_SKB_RESERVE, GFP_ATOMIC);
+	if (skb == NULL) {
+		BTMTK_ERR("%s allocate skb failed!!", __func__);
+		goto exit;
+	}
+	/* Reserv for core and drivers use */
+	skb_reserve(skb, 7);
+	bt_cb(skb)->pkt_type = HCI_COMMAND_PKT;
+	memcpy(skb->data, cmd, cmd_len);
+	skb->len = cmd_len;
+
+#if ENABLESTP
+	skb = mtk_add_stp(bdev, skb);
+#endif
+	/* wmt cmd and download fw patch using wmt cmd with USB interface, need use
+	 * usb_control_msg to recv wmt event;
+	 * other HIF don't use this method to recv wmt event
+	 */
+
+	ret = main_info.hif_hook.send_and_recv(bdev,
+			skb,
+			event, event_len,
+			delay, retry, pkt_type);
+
+	if (ret < 0)
+		BTMTK_ERR("%s send_and_recv failed!!", __func__);
+
+exit:
+	BTMTK_DBG("%s end!!", __func__);
+	return ret;
+}
+
+static int btmtk_check_need_load_rom_patch(struct btmtk_dev *bdev)
+{
+	u8 cmd[] = { 0x01, 0x6F, 0xFC, 0x05, 0x01, 0x17, 0x01, 0x00, 0x01 };
+	/* event[6] is key */
+	u8 event[] = { 0x04, 0xE4, 0x05, 0x02, 0x17, 0x01, 0x00, /* 0x02 */ };
+	int ret = -1;
+
+	if (!bdev) {
+		BTMTK_ERR("%s, invalid parameters!", __func__);
+		ret = -EINVAL;
+		return ret;
+	}
+
+	ret = btmtk_main_send_cmd(bdev, cmd, sizeof(cmd), event, sizeof(event), DELAY_TIMES,
+			RETRY_TIMES, BTMTK_TX_CMD_FROM_DRV);
+	/* can't get correct event */
+	if (ret < 0)
+		return PATCH_ERR;
+
+	if (bdev->recv_evt_len == sizeof(event))
+		return bdev->io_buf[6];
+
+	return PATCH_ERR;
+}
+
+static void btmtk_load_code_from_bin(const struct firmware **fw_firmware,
+				     char *bin_name, struct device *dev, u8 **image, u32 *code_len)
+{
+	int err = 0;
+	int retry = 10;
+
+	if (!bin_name) {
+		BTMTK_ERR("%s, invalid parameters!", __func__);
+		return;
+	}
+
+	do {
+		err = request_firmware(fw_firmware, bin_name, dev);
+		if (err == 0) {
+			break;
+		} else if (retry <= 0) {
+			*fw_firmware = NULL;
+			BTMTK_INFO("%s: request_firmware %d times fail", __func__, 10);
+			BTMTK_INFO("maybe file not exist, err = %d", err);
+			return;
+		}
+		BTMTK_INFO("%s: request_firmware fail, maybe file not exist, err = %d, retry = %d",
+			__func__, err, retry);
+		msleep(100);
+	} while (retry-- > 0);
+
+	*image = (u8 *)(*fw_firmware)->data;
+	*code_len = (*fw_firmware)->size;
+}
+
+static void btmtk_print_bt_patch_info(struct btmtk_dev *bdev, u8 *fwbuf)
+{
+	struct _PATCH_HEADER *patchHdr = NULL;
+	struct _Global_Descr *globalDesrc = NULL;
+
+	if (fwbuf == NULL) {
+		BTMTK_WARN("%s, fwbuf is NULL!", __func__);
+		return;
+	}
+
+	patchHdr = (struct _PATCH_HEADER *)fwbuf;
+
+	if (is_mt7922(bdev->chip_id) || is_mt7961(bdev->chip_id))
+		globalDesrc = (struct _Global_Descr *)(fwbuf + FW_ROM_PATCH_HEADER_SIZE);
+
+	BTMTK_INFO("[btmtk] =============== Patch Info ==============");
+	if (patchHdr) {
+		BTMTK_INFO("[btmtk] Built Time = %s", patchHdr->ucDateTime);
+		BTMTK_INFO("[btmtk] Hw Ver = 0x%04x", patchHdr->u2HwVer);
+		BTMTK_INFO("[btmtk] Sw Ver = 0x%04x", patchHdr->u2SwVer);
+		BTMTK_INFO("[btmtk] Magic Number = 0x%08x", patchHdr->u4MagicNum);
+
+		BTMTK_INFO("[btmtk] Platform = %c%c%c%c",
+				patchHdr->ucPlatform[0],
+				patchHdr->ucPlatform[1],
+				patchHdr->ucPlatform[2],
+				patchHdr->ucPlatform[3]);
+	} else
+		BTMTK_WARN("%s, patchHdr is NULL!", __func__);
+
+	if (globalDesrc) {
+		BTMTK_INFO("[btmtk] Patch Ver = 0x%08x", globalDesrc->u4PatchVer);
+		BTMTK_INFO("[btmtk] Section num = 0x%08x", globalDesrc->u4SectionNum);
+	} else
+		BTMTK_WARN("%s, globalDesrc is NULL!", __func__);
+	BTMTK_INFO("[btmtk] =========================================");
+}
+
+static void btmtk_print_wifi_patch_info(struct btmtk_dev *bdev, u8 *fwbuf)
+{
+	struct _PATCH_HEADER *patchHdr = NULL;
+	struct _Global_Descr *globalDesrc = NULL;
+
+	if (fwbuf == NULL) {
+		BTMTK_WARN("%s, fwbuf is NULL!", __func__);
+		return;
+	}
+
+	patchHdr = (struct _PATCH_HEADER *)fwbuf;
+
+	if (is_mt7922(bdev->chip_id) || is_mt7961(bdev->chip_id))
+		globalDesrc = (struct _Global_Descr *)(fwbuf + FW_ROM_PATCH_HEADER_SIZE);
+
+	BTMTK_INFO("[btmtk] =============== Wifi Patch Info ==============");
+	if (patchHdr) {
+		BTMTK_INFO("[btmtk] Built Time = %s", patchHdr->ucDateTime);
+		BTMTK_INFO("[btmtk] Hw Ver = 0x%04x",
+			((patchHdr->u2HwVer & 0x00ff) << 8) | ((patchHdr->u2HwVer & 0xff00) >> 8));
+		BTMTK_INFO("[btmtk] Sw Ver = 0x%04x",
+			((patchHdr->u2SwVer & 0x00ff) << 8) | ((patchHdr->u2SwVer & 0xff00) >> 8));
+		BTMTK_INFO("[btmtk] Magic Number = 0x%08x", be2cpu32(patchHdr->u4MagicNum));
+
+		BTMTK_INFO("[btmtk] Platform = %c%c%c%c",
+				patchHdr->ucPlatform[0],
+				patchHdr->ucPlatform[1],
+				patchHdr->ucPlatform[2],
+				patchHdr->ucPlatform[3]);
+	} else
+		BTMTK_WARN("%s, patchHdr is NULL!", __func__);
+
+	if (globalDesrc) {
+		BTMTK_INFO("[btmtk] Patch Ver = 0x%08x",
+			be2cpu32(globalDesrc->u4PatchVer));
+		BTMTK_INFO("[btmtk] Section num = 0x%08x",
+			be2cpu32(globalDesrc->u4SectionNum));
+	} else
+		BTMTK_WARN("%s, globalDesrc is NULL!", __func__);
+	BTMTK_INFO("[btmtk] =========================================");
+}
+
+static int btmtk_send_wmt_download_cmd(struct btmtk_dev *bdev, u8 *cmd,
+		int cmd_len, u8 *event, int event_len, struct _Section_Map *sectionMap,
+		u8 fw_state, u8 dma_flag, bool patch_flag)
+{
+	int payload_len = 0;
+	int ret = -1;
+	int i = 0;
+	u32 revert_SecSpec = 0;
+
+	if (bdev == NULL || cmd == NULL || event == NULL || sectionMap == NULL) {
+		BTMTK_ERR("%s: invalid parameter!", __func__);
+		return ret;
+	}
+
+	/* need refine this cmd to mtk_wmt_hdr struct*/
+	/* prepare HCI header */
+	cmd[0] = 0x01;
+	cmd[1] = 0x6F;
+	cmd[2] = 0xFC;
+
+	/* prepare WMT header */
+	cmd[4] = 0x01;
+	cmd[5] = 0x01; /* opcode */
+
+	if (fw_state == 0) {
+		/* prepare WMT DL cmd */
+		payload_len = SEC_MAP_NEED_SEND_SIZE + 2;
+
+		cmd[3] = (payload_len + 4) & 0xFF; /* length*/
+		cmd[6] = payload_len & 0xFF;
+		cmd[7] = (payload_len >> 8) & 0xFF;
+		cmd[8] = 0x00; /* which is the FW download state 0 */
+		cmd[9] = dma_flag; /* 1:using DMA to download, 0:using legacy wmt cmd*/
+		cmd_len = SEC_MAP_NEED_SEND_SIZE + PATCH_HEADER_SIZE;
+
+		if (patch_flag) {
+			for (i = 0; i < SECTION_SPEC_NUM; i++) {
+				revert_SecSpec = be2cpu32(sectionMap->u4SecSpec[i]);
+				memcpy(&cmd[PATCH_HEADER_SIZE] + i * sizeof(u32),
+				       (u8 *)&revert_SecSpec, sizeof(u32));
+			}
+		} else
+			memcpy(&cmd[PATCH_HEADER_SIZE], (u8 *)(sectionMap->u4SecSpec),
+			       SEC_MAP_NEED_SEND_SIZE);
+
+		BTMTK_INFO_RAW(cmd, cmd_len, "%s: CMD:", __func__);
+
+		ret = btmtk_main_send_cmd(bdev, cmd, cmd_len,
+				event, event_len, DELAY_TIMES, RETRY_TIMES, BTMTK_TX_CMD_FROM_DRV);
+		if (ret < 0) {
+			BTMTK_ERR("%s: send wmd dl cmd failed, terminate!", __func__);
+			return PATCH_ERR;
+		}
+
+		if (bdev->recv_evt_len >= event_len)
+			return bdev->io_buf[PATCH_STATUS];
+
+		return PATCH_ERR;
+	}
+
+	BTMTK_ERR("%s: fw state is error!", __func__);
+
+	return ret;
+}
+
+static int btmtk_load_fw_patch_using_wmt_cmd(struct btmtk_dev *bdev,
+		u8 *image, u8 *fwbuf, u8 *event, int event_len, u32 patch_len, int offset)
+{
+	int ret = 0;
+	u32 cur_len = 0;
+	s32 sent_len;
+	int first_block = 1;
+	u8 phase;
+	int delay = PATCH_DOWNLOAD_PHASE1_2_DELAY_TIME;
+	int retry = PATCH_DOWNLOAD_PHASE1_2_RETRY;
+
+	if (bdev == NULL || image == NULL || fwbuf == NULL) {
+		BTMTK_WARN("%s, invalid parameters!", __func__);
+		ret = -1;
+		goto exit;
+	}
+
+	/* loading rom patch */
+	while (1) {
+		s32 sent_len_max = UPLOAD_PATCH_UNIT - PATCH_HEADER_SIZE;
+
+		sent_len = (patch_len - cur_len) >= sent_len_max ?
+			   sent_len_max : (patch_len - cur_len);
+
+		if (sent_len > 0) {
+			if (first_block == 1) {
+				if (sent_len < sent_len_max)
+					phase = PATCH_PHASE3;
+				else
+					phase = PATCH_PHASE1;
+				first_block = 0;
+			} else if (sent_len == sent_len_max) {
+				if (patch_len - cur_len == sent_len_max)
+					phase = PATCH_PHASE3;
+				else
+					phase = PATCH_PHASE2;
+			} else {
+				phase = PATCH_PHASE3;
+			}
+
+
+			/* prepare HCI header */
+			image[0] = 0x02;
+			image[1] = 0x6F;
+			image[2] = 0xFC;
+			image[3] = (sent_len + 5) & 0xFF;
+			image[4] = ((sent_len + 5) >> 8) & 0xFF;
+
+			/* prepare WMT header */
+			image[5] = 0x01;
+			image[6] = 0x01;
+			image[7] = (sent_len + 1) & 0xFF;
+			image[8] = ((sent_len + 1) >> 8) & 0xFF;
+
+			image[9] = phase;
+			memcpy(&image[10], fwbuf + offset + cur_len, sent_len);
+			if (phase == PATCH_PHASE3) {
+				delay = PATCH_DOWNLOAD_PHASE3_DELAY_TIME;
+				retry = PATCH_DOWNLOAD_PHASE3_RETRY;
+			}
+
+			cur_len += sent_len;
+			BTMTK_DBG("%s: sent_len = %d, cur_len = %d, phase = %d", __func__,
+					sent_len, cur_len, phase);
+
+			ret = btmtk_main_send_cmd(bdev, image, sent_len + PATCH_HEADER_SIZE,
+					event, event_len, delay, retry, BTMTK_TX_ACL_FROM_DRV);
+			if (ret < 0) {
+				BTMTK_INFO("%s: send patch failed, terminate", __func__);
+				goto exit;
+			}
+		} else
+			break;
+	}
+
+exit:
+	return ret;
+}
+
+void btmtk_send_hw_err_to_host(struct btmtk_dev *bdev)
+{
+	struct sk_buff *skb = NULL;
+	u8 hwerr_event[] = { 0x04, 0x10, 0x01, 0xff };
+
+	BTMTK_ERR("%s reset_stack_flag = %d!!", __func__, main_info.reset_stack_flag);
+	if (main_info.reset_stack_flag) {
+		skb = alloc_skb(sizeof(hwerr_event) + BT_SKB_RESERVE, GFP_ATOMIC);
+		if (skb == NULL) {
+			BTMTK_ERR("%s allocate skb failed!!", __func__);
+		} else {
+			hci_skb_pkt_type(skb) = HCI_EVENT_PKT;
+			skb->data[0] = hwerr_event[1];
+			skb->data[1] = hwerr_event[2];
+			skb->data[2] = main_info.reset_stack_flag;
+			skb->len = sizeof(hwerr_event) - 1;
+			BTMTK_DBG_RAW(skb->data, skb->len, "%s: hw err event:", __func__);
+			hci_recv_frame(bdev->hdev, skb);
+		}
+	}
+}
+
+static int btmtk_send_fw_rom_patch_79xx(struct btmtk_dev *bdev,
+		u8 *fwbuf, bool patch_flag)
+{
+	u8 *pos;
+	int loop_count = 0;
+	int ret = 0;
+	u32 section_num = 0;
+	u32 section_offset = 0;
+	u32 dl_size = 0;
+	int patch_status = 0;
+	int retry = 20;
+	u8 dma_flag = PATCH_DOWNLOAD_USING_WMT;
+	struct _Section_Map *sectionMap;
+	struct _Global_Descr *globalDescr;
+	u8 event[] = {0x04, 0xE4, 0x05, 0x02, 0x01, 0x01, 0x00, 0x00}; /* event[7] is status*/
+
+	if (fwbuf == NULL) {
+		BTMTK_WARN("%s, fwbuf is NULL!", __func__);
+		ret = -1;
+		goto exit;
+	}
+
+	globalDescr = (struct _Global_Descr *)(fwbuf + FW_ROM_PATCH_HEADER_SIZE);
+
+	BTMTK_INFO("%s: loading rom patch...\n", __func__);
+
+	if (patch_flag)
+		section_num = be2cpu32(globalDescr->u4SectionNum);
+	else
+		section_num = globalDescr->u4SectionNum;
+	BTMTK_INFO("%s: section_num = 0x%08x\n", __func__, section_num);
+
+	pos = kmalloc(UPLOAD_PATCH_UNIT, GFP_ATOMIC);
+	if (!pos) {
+		BTMTK_ERR("%s: alloc memory failed", __func__);
+		goto exit;
+	}
+
+	do {
+		sectionMap = (struct _Section_Map *)(fwbuf + FW_ROM_PATCH_HEADER_SIZE +
+				FW_ROM_PATCH_GD_SIZE + FW_ROM_PATCH_SEC_MAP_SIZE * loop_count);
+		dma_flag = PATCH_DOWNLOAD_USING_WMT;
+		if (patch_flag) {
+			/* wifi is big-endian */
+			section_offset = be2cpu32(sectionMap->u4SecOffset);
+			dl_size = be2cpu32(sectionMap->bin_info_spec.u4DLSize);
+			dma_flag = be2cpu32(sectionMap->bin_info_spec.u4DLModeCrcType) & 0xFF;
+		} else {
+			/* BT is little-endian */
+			section_offset = sectionMap->u4SecOffset;
+			dl_size = sectionMap->bin_info_spec.u4DLSize;
+			/*
+			 * loop_count = 0: BGF patch
+			 *              1: BT ILM
+			 * only BT ILM support DL DMA for Buzzard
+			 */
+			dma_flag = le2cpu32(sectionMap->bin_info_spec.u4DLModeCrcType) & 0xFF;
+		}
+		BTMTK_INFO("%s: loop_count = %d, section_offset = 0x%08x",
+				__func__, loop_count, section_offset);
+		BTMTK_INFO("download patch_len = 0x%08x, dl mode = %d\n", dl_size, dma_flag);
+		if (dl_size > 0) {
+			retry = 20;
+			do {
+				patch_status = btmtk_send_wmt_download_cmd(bdev, pos, 0, event,
+					       sizeof(event) - 1, sectionMap,
+					       0, dma_flag, patch_flag);
+				BTMTK_INFO("%s: patch_status %d", __func__, patch_status);
+
+				if (patch_status > PATCH_READY || patch_status == PATCH_ERR) {
+					BTMTK_ERR("%s: patch_status error", __func__);
+					ret = -1;
+					goto err;
+				} else if (patch_status == PATCH_READY) {
+					BTMTK_INFO("%s: no need to load rom patch section%d",
+						   __func__, loop_count);
+					goto next_section;
+				} else if (patch_status == PATCH_IS_DOWNLOAD_BY_OTHER) {
+					msleep(100);
+					retry--;
+				} else if (patch_status == PATCH_NEED_DOWNLOAD) {
+					break;  /* Download ROM patch directly */
+				}
+			} while (retry > 0);
+
+			if (patch_status == PATCH_IS_DOWNLOAD_BY_OTHER) {
+				BTMTK_WARN("%s: Hold by another fun more than 2 seconds", __func__);
+				ret = -1;
+				goto err;
+			}
+
+			if (dma_flag == PATCH_DOWNLOAD_USING_DMA && main_info.hif_hook.dl_dma) {
+				/* using DMA to download fw patch*/
+				ret = main_info.hif_hook.dl_dma(bdev,
+					pos, fwbuf,
+					dl_size, section_offset);
+				if (ret < 0) {
+					BTMTK_ERR("%s: btmtk_load_fw_patch_using_dma failed!",
+						  __func__);
+					goto err;
+				}
+			} else {
+				/* using legacy wmt cmd to download fw patch */
+				ret = btmtk_load_fw_patch_using_wmt_cmd(bdev, pos, fwbuf, event,
+						sizeof(event) - 1, dl_size, section_offset);
+				if (ret < 0) {
+					BTMTK_ERR("%s: btmtk_load_fw_patch_using_wmt_cmd failed!",
+						  __func__);
+					goto err;
+				}
+			}
+		}
+		/* FW Download finished */
+		if (loop_count == section_num - 1) {
+			/* need to remove delay according to
+			 * Jyun-ji's comment later
+			 */
+			if (patch_flag)
+				mdelay(500);
+		}
+next_section:
+		continue;
+	} while (++loop_count < section_num);
+
+err:
+	kfree(pos);
+	pos = NULL;
+
+exit:
+	return ret;
+}
+
+int btmtk_load_rom_patch_79xx(struct btmtk_dev *bdev, bool patch_flag)
+{
+	int ret = 0;
+	const struct firmware *fw_firmware = NULL;
+	u8 *rom_patch = NULL;
+	unsigned int rom_patch_len = 0;
+
+	BTMTK_ERR("%s, patch_flag = %d!", __func__, patch_flag);
+
+	if (!bdev) {
+		BTMTK_ERR("%s, invalid parameters!", __func__);
+		return -EINVAL;
+	}
+
+	if (patch_flag) {
+		if (bdev->flavor) {
+			/* if flavor equals 1, it represent 7920, else it represent 7921*/
+			snprintf(bdev->rom_patch_bin_file_name, MAX_BIN_FILE_NAME_LEN,
+					"WIFI_MT%04x_patch_mcu_1a_%x_hdr.bin",
+					bdev->chip_id & 0xffff, (bdev->fw_version & 0xff) + 1);
+		} else
+			snprintf(bdev->rom_patch_bin_file_name, MAX_BIN_FILE_NAME_LEN,
+					"WIFI_MT%04x_patch_mcu_1_%x_hdr.bin",
+					bdev->chip_id & 0xffff, (bdev->fw_version & 0xff) + 1);
+	}
+
+	btmtk_load_code_from_bin(&fw_firmware, bdev->rom_patch_bin_file_name, NULL,
+			&rom_patch, &rom_patch_len);
+
+	if (!rom_patch) {
+		BTMTK_ERR("%s: please assign a rom patch(/etc/firmware/%s)or(/lib/firmware/%s)",
+			__func__, bdev->rom_patch_bin_file_name, bdev->rom_patch_bin_file_name);
+		ret = -1;
+		goto err;
+	}
+
+	if (patch_flag)
+		/*Display rom patch info*/
+		btmtk_print_wifi_patch_info(bdev, rom_patch);
+	else
+		btmtk_print_bt_patch_info(bdev, rom_patch);
+
+	ret = btmtk_send_fw_rom_patch_79xx(bdev, rom_patch, patch_flag);
+	if (ret < 0) {
+		BTMTK_ERR("%s, failed!", __func__);
+		goto err;
+	}
+
+	bdev->power_state = BTMTK_DONGLE_STATE_POWER_OFF;
+	BTMTK_INFO("%s end", __func__);
+
+err:
+	if (fw_firmware)
+		release_firmware(fw_firmware);
+	return ret;
+}
+
+int btmtk_load_rom_patch_766x(struct btmtk_dev *bdev)
+{
+	u32 patch_len = 0;
+	int ret = 0;
+	int patch_status = 0;
+	int retry = 20;
+	u8 *pos = NULL;
+	u8 event[] = {0x04, 0xE4, 0x05, 0x02, 0x01, 0x01, 0x00, 0x00};
+	const struct firmware *fw_firmware = NULL;
+	u8 *rom_patch = NULL;
+	unsigned int rom_patch_len = 0;
+	struct _PATCH_HEADER *patchHdr;
+
+	if (!bdev) {
+		BTMTK_ERR("%s, invalid parameters!", __func__);
+		return -EINVAL;
+	}
+
+	btmtk_load_code_from_bin(&fw_firmware, bdev->rom_patch_bin_file_name, NULL,
+			&rom_patch, &rom_patch_len);
+
+	do {
+		patch_status = btmtk_check_need_load_rom_patch(bdev);
+		BTMTK_INFO("%s: patch_status %d", __func__, patch_status);
+
+		if (patch_status > MT766X_PATCH_NEED_DOWNLOAD || patch_status == PATCH_ERR) {
+			BTMTK_ERR("%s: patch_status error", __func__);
+			ret = -1;
+			goto err1;
+		} else if (patch_status == MT766X_PATCH_READY) {
+			BTMTK_INFO("%s: no need to load rom patch", __func__);
+			goto patch_end;
+		} else if (patch_status == MT766X_PATCH_IS_DOWNLOAD_BY_OTHER) {
+			msleep(100);
+			retry--;
+		} else if (patch_status == MT766X_PATCH_NEED_DOWNLOAD) {
+			break;  /* Download ROM patch directly */
+		}
+	} while (retry > 0);
+
+	if (patch_status == PATCH_IS_DOWNLOAD_BY_OTHER) {
+		BTMTK_WARN("%s: Hold by another fun more than 2 seconds", __func__);
+		ret = -1;
+		goto err1;
+	}
+
+	patchHdr = (struct _PATCH_HEADER *)rom_patch;
+	/*Display rom patch info*/
+	btmtk_print_bt_patch_info(bdev, rom_patch);
+
+	pos = kmalloc(UPLOAD_PATCH_UNIT, GFP_ATOMIC);
+	if (!pos) {
+		BTMTK_ERR("%s: alloc memory failed", __func__);
+		ret = -1;
+		goto err1;
+	}
+
+	patch_len = rom_patch_len - PATCH_INFO_SIZE;
+
+	BTMTK_INFO("%s: loading rom patch...\n", __func__);
+	BTMTK_INFO("%s: patch_len = %d\n", __func__, patch_len);
+	ret = btmtk_load_fw_patch_using_wmt_cmd(bdev, pos, rom_patch, event,
+			sizeof(event) - 1, patch_len, PATCH_INFO_SIZE);
+	if (ret < 0) {
+		BTMTK_ERR("%s, btmtk_send_fw_rom_patch_766x failed!", __func__);
+		goto err0;
+	}
+
+	ret = btmtk_send_wmt_reset(bdev);
+	if (ret < 0) {
+		BTMTK_ERR("%s: btmtk_send_wmt_reset failed!", __func__);
+		goto err0;
+	}
+	BTMTK_INFO("%s: loading rom patch... Done", __func__);
+
+	btmtk_send_hw_err_to_host(bdev);
+
+patch_end:
+	bdev->power_state = BTMTK_DONGLE_STATE_POWER_OFF;
+	BTMTK_INFO("btmtk_load_rom_patch end");
+
+err0:
+	kfree(pos);
+	pos = NULL;
+
+err1:
+	if (fw_firmware)
+		release_firmware(fw_firmware);
+	return ret;
+}
+
+int btmtk_load_rom_patch(struct btmtk_dev *bdev)
+{
+	int err = -1;
+
+	if (!bdev || !bdev->hdev) {
+		BTMTK_ERR("%s: invalid parameters!", __func__);
+		return err;
+	}
+
+	if (is_mt7663(bdev->chip_id))
+		err = btmtk_load_rom_patch_766x(bdev);
+	else if (is_mt7922(bdev->chip_id) || is_mt7961(bdev->chip_id)) {
+		err = btmtk_load_rom_patch_79xx(bdev, BT_DOWNLOAD);
+		if (err < 0) {
+			BTMTK_ERR("%s: btmtk_load_rom_patch_79xx bt patch failed!", __func__);
+			return err;
+		}
+
+#if CFG_SUPPORT_BT_DL_WIFI_PATCH
+		err = btmtk_load_rom_patch_79xx(bdev, WIFI_DOWNLOAD);
+		if (err < 0) {
+			BTMTK_WARN("%s: btmtk_load_rom_patch_79xx wifi patch failed!", __func__);
+			err = 0;
+		}
+#endif
+	} else
+		BTMTK_WARN("%s: unknown chip id (%d)", __func__, bdev->chip_id);
+
+	return err;
+}
+
+struct btmtk_dev *btmtk_get_dev(void)
+{
+	int i = 0;
+	struct btmtk_dev *tmp_bdev = NULL;
+
+	BTMTK_INFO("%s", __func__);
+
+	for (i = 0; i < btmtk_intf_num; i++) {
+		/* Find empty slot for newly probe interface.
+		 * Judged from load_rom_patch is done and
+		 * Identified chip_id from cap_init.
+		 */
+		if (g_bdev[i]->hdev == NULL) {
+			if (i == 0)
+				g_bdev[i]->dongle_index = i;
+			else
+				g_bdev[i]->dongle_index = g_bdev[i - 1]->dongle_index + 1;
+
+			/* reset pin initial value need to be -1, used to judge after
+			 * disconnected before probe, can't do chip reset
+			 */
+			g_bdev[i]->bt_cfg.dongle_reset_gpio_pin = -1;
+			tmp_bdev = g_bdev[i];
+
+			/* Hook pre-defined table on state machine */
+			g_bdev[i]->cif_state = (struct btmtk_cif_state *)g_cif_state;
+			break;
+		}
+	}
+
+	return tmp_bdev;
+}
+
+void btmtk_release_dev(struct btmtk_dev *bdev)
+{
+	int i = 0;
+	struct btmtk_dev *tmp_bdev = NULL;
+
+	BTMTK_INFO("%s", __func__);
+
+	tmp_bdev = bdev;
+	if (tmp_bdev != NULL) {
+		for (i = 0; i < btmtk_intf_num; i++) {
+			/* Find slot on probed interface.
+			 * Judged from load_rom_patch is done and
+			 * Identified chip_id from cap_init.
+			 */
+			if (memcmp(tmp_bdev, g_bdev[i], sizeof(*tmp_bdev)) == 0) {
+				memset(tmp_bdev, 0, sizeof(*tmp_bdev));
+				/* reset pin initial value need to be -1, used to judge after
+				 * disconnected before probe, can't do chip reset
+				 */
+				bdev->bt_cfg.dongle_reset_gpio_pin = -1;
+
+				tmp_bdev = NULL;
+				break;
+			}
+		}
+	}
+
+}
+
+struct btmtk_dev *btmtk_allocate_dev_memory(struct device *dev)
+{
+	struct btmtk_dev *bdev;
+	size_t len = sizeof(*bdev);
+
+	BTMTK_INFO("%s", __func__);
+
+	if (dev != NULL)
+		bdev = devm_kzalloc(dev, len, GFP_KERNEL);
+	else
+		bdev = kzalloc(len, GFP_KERNEL);
+
+	if (!bdev)
+		return NULL;
+
+	btmtk_set_chip_state(bdev, BTMTK_STATE_INIT);
+
+	return bdev;
+}
+
+void btmtk_free_dev_memory(struct device *dev, struct btmtk_dev *bdev)
+{
+	BTMTK_INFO("%s", __func__);
+
+	if (bdev != NULL) {
+		if (dev != NULL)
+			devm_kfree(dev, bdev);
+		else
+			kfree(bdev);
+	}
+}
+
+static int btmtk_calibration_flow(struct btmtk_dev *bdev)
+{
+	if (!bdev) {
+		BTMTK_ERR("%s: bdev is NULL !", __func__);
+		return -1;
+	}
+
+	btmtk_cif_send_calibration(bdev);
+	BTMTK_INFO("%s done", __func__);
+	return 0;
+}
+
+static int btmtk_send_hci_reset_cmd(struct btmtk_dev *bdev)
+{
+	u8 cmd[] = { 0x01, 0x03, 0x0C, 0x00 };
+	u8 event[] = { 0x04, 0x0E, 0x04, 0x01, 0x03, 0x0C, 0x00 };
+	int ret = -1;	/* if successful, 0 */
+
+	if (!bdev) {
+		BTMTK_ERR("%s: bdev is NULL !", __func__);
+		return ret;
+	}
+
+	ret = btmtk_main_send_cmd(bdev, cmd, sizeof(cmd), event, sizeof(event), 0, 0,
+			BTMTK_TX_PKT_FROM_HOST);
+
+	BTMTK_INFO("%s done", __func__);
+
+	return ret;
+}
+
+/* Check power status, if power is off, try to set power on */
+int btmtk_reset_power_on(struct btmtk_dev *bdev)
+{
+	if (bdev->power_state == BTMTK_DONGLE_STATE_POWER_OFF) {
+		bdev->power_state = BTMTK_DONGLE_STATE_ERROR;
+		if (btmtk_send_wmt_power_on_cmd(bdev) < 0)
+			return -1;
+		if (is_mt7663(bdev->chip_id)) {
+			if (btmtk_send_hci_tci_set_sleep_cmd_766x(bdev) < 0)
+				return -1;
+
+			if (btmtk_send_hci_reset_cmd(bdev) < 0)
+				return -1;
+		}
+
+		bdev->power_state = BTMTK_DONGLE_STATE_POWER_ON;
+	}
+
+	if (bdev->power_state != BTMTK_DONGLE_STATE_POWER_ON) {
+		BTMTK_WARN("%s: end of Incorrect state:%d", __func__, bdev->power_state);
+		return -1;
+	}
+	BTMTK_INFO("%s: end success", __func__);
+
+	return 0;
+}
+
+int btmtk_send_wmt_reset(struct btmtk_dev *bdev)
+{
+	/* Support 7668 and 7663 */
+	u8 cmd[] = { 0x01, 0x6F, 0xFC, 0x05, 0x01, 0x07, 0x01, 0x00, 0x04 };
+	/* To-Do, for event check */
+	u8 event[] = { 0x04, 0xE4, 0x05, 0x02, 0x07, 0x01, 0x00, 0x00 };
+	int ret = -1;
+
+	if (!bdev) {
+		BTMTK_ERR("%s: bdev is NULL !", __func__);
+		return ret;
+	}
+	if (bdev->power_state == BTMTK_DONGLE_STATE_POWER_OFF) {
+		ret = btmtk_main_send_cmd(bdev, cmd, sizeof(cmd), event, sizeof(event), 20,
+			0, BTMTK_TX_CMD_FROM_DRV);
+
+		if (ret >= 0)
+			bdev->power_state = BTMTK_DONGLE_STATE_POWER_ON;
+		else
+			bdev->power_state = BTMTK_DONGLE_STATE_ERROR;
+	}
+
+	if (bdev->power_state != BTMTK_DONGLE_STATE_POWER_ON) {
+		BTMTK_WARN("%s: end of Incorrect state:%d", __func__, bdev->power_state);
+		return -EBADFD;
+	}
+
+	BTMTK_INFO("%s done", __func__);
+	return ret;
+}
+
+int btmtk_send_wmt_power_on_cmd(struct btmtk_dev *bdev)
+{
+	/* Support 7668 and 7663 and 7961 */
+	u8 cmd[] = { 0x01, 0x6F, 0xFC, 0x06, 0x01, 0x06, 0x02, 0x00, 0x00, 0x01 };
+	/* To-Do, for event check */
+	u8 event[] = { 0x04, 0xE4, 0x05, 0x02, 0x06, 0x01, 0x00 };	/* event[6] is key */
+	int ret = -1, retry = RETRY_TIMES;
+
+	if (!bdev) {
+		BTMTK_ERR("%s: bdev is NULL !", __func__);
+		return ret;
+	}
+
+retry_again:
+
+	ret = btmtk_main_send_cmd(bdev, cmd, sizeof(cmd), event, sizeof(event), WMT_DELAY_TIMES,
+			RETRY_TIMES, BTMTK_TX_CMD_FROM_DRV);
+	if (ret < 0) {
+		BTMTK_ERR("%s: failed(%d)", __func__, ret);
+		bdev->power_state = BTMTK_DONGLE_STATE_ERROR;
+		ret = -1;
+	} else if (ret == 0 && bdev->recv_evt_len > 0) {
+		switch (bdev->io_buf[6]) {
+		case 0:			 /* successful */
+			BTMTK_INFO("%s: OK", __func__);
+			bdev->power_state = BTMTK_DONGLE_STATE_POWER_ON;
+			break;
+		case 2:			 /* TODO:retry */
+			if (retry > 0) {
+				/* comment from fw,
+				 * we need to retry a sec until power on successfully.
+				 */
+				retry--;
+				BTMTK_INFO("%s: need to try again", __func__);
+				mdelay(50);
+				goto retry_again;
+			}
+			break;
+		default:
+			BTMTK_WARN("%s: Unknown result: %02X", __func__, bdev->io_buf[6]);
+			bdev->power_state = BTMTK_DONGLE_STATE_ERROR;
+			ret = -1;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+int btmtk_send_wmt_power_off_cmd(struct btmtk_dev *bdev)
+{
+	/* Support 7668 and 7663 and 7961 */
+	u8 cmd[] = { 0x01, 0x6F, 0xFC, 0x06, 0x01, 0x06, 0x02, 0x00, 0x00, 0x00 };
+	/* To-Do, for event check */
+	u8 event[] = { 0x04, 0xE4, 0x05, 0x02, 0x06, 0x01, 0x00 };
+	int ret = -1;
+
+	if (!bdev) {
+		BTMTK_ERR("%s: bdev is NULL !", __func__);
+		return ret;
+	}
+
+	if (bdev->power_state == BTMTK_DONGLE_STATE_POWER_OFF) {
+		BTMTK_WARN("%s: power_state already power off", __func__);
+		return 0;
+	}
+
+	ret = btmtk_main_send_cmd(bdev, cmd, sizeof(cmd), event, sizeof(event), DELAY_TIMES,
+			RETRY_TIMES, BTMTK_TX_CMD_FROM_DRV);
+	if (ret < 0) {
+		BTMTK_ERR("%s: failed(%d)", __func__, ret);
+		bdev->power_state = BTMTK_DONGLE_STATE_ERROR;
+		return ret;
+	}
+
+	bdev->power_state = BTMTK_DONGLE_STATE_POWER_OFF;
+	BTMTK_INFO("%s done", __func__);
+	return ret;
+}
+
+int btmtk_picus_enable(struct btmtk_dev *bdev)
+{
+	u8 dft_enable_cmd[] = { 0x01, 0x5D, 0xFC, 0x04, 0x00, 0x00, 0x02, 0x02 };
+	u8 *enable_cmd = NULL;
+	u8 enable_event[] = { 0x04, 0x0E, 0x08, 0x01, 0x5D, 0xFC, 0x00, 0x00, 0x00 };
+	int enable_len = 0;
+	int ret = -1;	/* if successful, 0 */
+
+	struct fw_cfg_struct *picus_setting = &bdev->bt_cfg.picus_enable;
+
+	BTMTK_INFO("%s", __func__);
+
+	if (picus_setting->content && picus_setting->length) {
+		BTMTK_INFO("%s load picus from bt.cfg", __func__);
+		enable_cmd = picus_setting->content;
+		enable_len = picus_setting->length;
+	} else {
+		enable_cmd = dft_enable_cmd;
+		enable_len = sizeof(dft_enable_cmd);
+	}
+	BTMTK_INFO_RAW(enable_cmd, enable_len, "%s: Send CMD:", __func__);
+
+	if (is_mt7922(bdev->chip_id) || is_mt7961(bdev->chip_id))
+		ret = btmtk_main_send_cmd(bdev,
+			enable_cmd, enable_len,
+			enable_event, sizeof(enable_event),
+			DELAY_TIMES, RETRY_TIMES,
+			BTMTK_TX_PKT_FROM_HOST);
+	else
+		BTMTK_WARN("%s: not support for 0x%x", __func__, bdev->chip_id);
+
+	BTMTK_INFO("%s: ret %d", __func__, ret);
+	return ret;
+}
+
+int btmtk_picus_disable(struct btmtk_dev *bdev)
+{
+	u8 dft_disable_cmd[] = { 0x01, 0x5D, 0xFC, 0x04, 0x00, 0x00, 0x02, 0x00 };
+	u8 dft_disable_event[] = { 0x04, 0x0E, 0x08, 0x01, 0x5D, 0xFC, 0x00, 0x00, 0x00 };
+	int ret = -1;	/* if successful, 0 */
+
+	BTMTK_INFO("%s\n", __func__);
+
+	if (is_mt7922(bdev->chip_id) || is_mt7961(bdev->chip_id))
+		ret = btmtk_main_send_cmd(bdev,
+			dft_disable_cmd, sizeof(dft_disable_cmd),
+			dft_disable_event, sizeof(dft_disable_event),
+			DELAY_TIMES, RETRY_TIMES,
+			BTMTK_TX_PKT_FROM_HOST);
+	else
+		BTMTK_WARN("%s: not support for 0x%x", __func__, bdev->chip_id);
+
+	BTMTK_INFO("%s: ret %d", __func__, ret);
+	return ret;
+}
+
+static int btmtk_send_apcf_reserved(struct btmtk_dev *bdev)
+{
+	int ret = -1;
+
+	u8 reserve_apcf_cmd[] = { 0x01, 0xC9, 0xFC, 0x05, 0x01, 0x30, 0x02, 0x61, 0x02 };
+	u8 reserve_apcf_event[] = { 0x04, 0xE6, 0x02, 0x08, 0x11 };
+
+	if (bdev == NULL) {
+		BTMTK_ERR("%s: Incorrect bdev", __func__);
+		return ret;
+	}
+
+	if (is_mt7922(bdev->chip_id) || is_mt7961(bdev->chip_id))
+		ret = btmtk_main_send_cmd(bdev, reserve_apcf_cmd, sizeof(reserve_apcf_cmd),
+			reserve_apcf_event, sizeof(reserve_apcf_event), 0, 0,
+			BTMTK_TX_PKT_FROM_HOST);
+	else
+		BTMTK_WARN("%s: not support for 0x%x", __func__, bdev->chip_id);
+
+	BTMTK_INFO("%s: ret %d", __func__, ret);
+	return ret;
+}
+
+int btmtk_send_read_BDADDR_cmd(struct btmtk_dev *bdev)
+{
+	u8 cmd[] = { 0x01, 0x09, 0x10, 0x00 };
+	u8 event[] = { 0x04, 0x0E, 0x0A, 0x01, 0x09, 0x10, 0x00, /* AA, BB, CC, DD, EE, FF */ };
+	int i;
+	int ret = -1;
+
+	BTMTK_INFO("%s: begin", __func__);
+	if (bdev == NULL || bdev->io_buf == NULL) {
+		BTMTK_ERR("%s: Incorrect bdev", __func__);
+		return ret;
+	}
+
+	for (i = 0; i < BD_ADDRESS_SIZE; i++) {
+		if (bdev->bdaddr[i] != 0) {
+			ret = 0;
+			goto done;
+		}
+	}
+
+	ret = btmtk_main_send_cmd(bdev, cmd, sizeof(cmd), event, sizeof(event), 0, 0,
+			BTMTK_TX_PKT_FROM_HOST);
+	/*BD address will get in btmtk_rx_work*/
+	if (ret < 0)
+		BTMTK_ERR("%s: failed(%d)", __func__, ret);
+
+done:
+	BTMTK_INFO("%s, end, ret = %d", __func__, ret);
+	return ret;
+}
+
+static int btmtk_send_unify_woble_suspend_default_cmd(struct btmtk_dev *bdev)
+{
+	int ret = 0;	/* if successful, 0 */
+	u8 cmd[] = { 0x01, 0xC9, 0xFC, 0x24, 0x01, 0x20, 0x02, 0x00, 0x01,
+		0x02, 0x01, 0x00, 0x05, 0x10, 0x00, 0x00, 0x40, 0x06,
+		0x02, 0x40, 0x0A, 0x02, 0x41, 0x0F, 0x05, 0x24, 0x20,
+		0x04, 0x32, 0x00, 0x09, 0x26, 0xC0, 0x12, 0x00, 0x00,
+		0x12, 0x00, 0x00, 0x00};
+	/*u8 status[] = { 0x0F, 0x04, 0x00, 0x01, 0xC9, 0xFC }; */
+	u8 comp_event[] = { 0x04, 0xE6, 0x02, 0x08, 0x00 };
+
+	BTMTK_INFO("%s: begin", __func__);
+	ret = btmtk_main_send_cmd(bdev, cmd, sizeof(cmd), comp_event, sizeof(comp_event),
+			0, 0, BTMTK_TX_PKT_FROM_HOST);
+	if (ret < 0)
+		BTMTK_ERR("%s: failed(%d)", __func__, ret);
+
+	BTMTK_INFO("%s: end. ret = %d", __func__, ret);
+	return ret;
+}
+
+static int btmtk_send_unify_woble_resume_default_cmd(struct btmtk_dev *bdev)
+{
+	int ret = 0;	/* if successful, 0 */
+	u8 cmd[] = { 0x01, 0xC9, 0xFC, 0x05, 0x01, 0x21, 0x02, 0x00, 0x00 };
+	/*u8 status[] = { 0x0F, 0x04, 0x00, 0x01, 0xC9, 0xFC };*/
+	u8 comp_event[] = { 0x04, 0xE6, 0x02, 0x08, 0x01 };
+
+	BTMTK_INFO("%s: begin", __func__);
+	ret = btmtk_main_send_cmd(bdev, cmd, sizeof(cmd), comp_event, sizeof(comp_event),
+			0, 0, BTMTK_TX_PKT_FROM_HOST);
+	if (ret < 0)
+		BTMTK_ERR("%s: failed(%d)", __func__, ret);
+
+	BTMTK_INFO("%s: end. ret = %d", __func__, ret);
+	return ret;
+}
+
+static int btmtk_send_woble_suspend_cmd(struct btmtk_dev *bdev)
+{
+	int ret = 0;	/* if successful, 0 */
+	/* radio off cmd with wobx_mode_disable, used when unify woble off */
+	u8 radio_off_cmd[] = { 0x01, 0xC9, 0xFC, 0x05, 0x01, 0x20, 0x02, 0x00, 0x00 };
+	/*u8 status_event[] = { 0x0F, 0x04, 0x00, 0x01, 0xC9, 0xFC };*/
+	u8 comp_event[] = { 0x04, 0xE6, 0x02, 0x08, 0x00 };
+
+	BTMTK_INFO("%s: not support woble, send radio off cmd", __func__);
+	ret = btmtk_main_send_cmd(bdev, radio_off_cmd, sizeof(radio_off_cmd),
+			comp_event, sizeof(comp_event), 0, 0, BTMTK_TX_PKT_FROM_HOST);
+	if (ret < 0)
+		BTMTK_ERR("%s: failed(%d)", __func__, ret);
+
+	return ret;
+}
+
+static int btmtk_send_woble_resume_cmd(struct btmtk_dev *bdev)
+{
+	int ret = 0;	/* if successful, 0 */
+	/* radio on cmd with wobx_mode_disable, used when unify woble off */
+	u8 radio_on_cmd[] = { 0x01, 0xC9, 0xFC, 0x05, 0x01, 0x21, 0x02, 0x00, 0x00 };
+	/*u8 status[] = { 0x0F, 0x04, 0x00, 0x01, 0xC9, 0xFC };*/
+	u8 comp_event[] = { 0x04, 0xE6, 0x02, 0x08, 0x01 };
+
+	BTMTK_INFO("%s: begin", __func__);
+	ret = btmtk_main_send_cmd(bdev, radio_on_cmd, sizeof(radio_on_cmd),
+			comp_event, sizeof(comp_event), 0, 0, BTMTK_TX_PKT_FROM_HOST);
+	if (ret < 0)
+		BTMTK_ERR("%s: failed(%d)", __func__, ret);
+
+	return ret;
+}
+
+
+int btmtk_set_Woble_APCF_filter_parameter(struct btmtk_dev *bdev)
+{
+	int ret = -1;
+	u8 cmd[] = { 0x01, 0x57, 0xFD, 0x0A, 0x01, 0x00, 0x0A,
+		     0x20, 0x00, 0x20, 0x00, 0x01, 0x80, 0x00 };
+	u8 event_complete[] = { 0x04, 0x0E, 0x07, 0x01, 0x57, 0xFD, 0x00, 0x01/*, 00, 63*/ };
+
+	BTMTK_INFO("%s: begin", __func__);
+	ret = btmtk_main_send_cmd(bdev, cmd, sizeof(cmd),
+		event_complete, sizeof(event_complete), 0, 0, BTMTK_TX_PKT_FROM_HOST);
+	if (ret < 0)
+		BTMTK_ERR("%s: end ret %d", __func__, ret);
+	else
+		ret = 0;
+
+	BTMTK_INFO("%s: end ret=%d", __func__, ret);
+	return ret;
+}
+
+
+/**
+ * Set APCF manufacturer data and filter parameter
+ */
+int btmtk_set_Woble_APCF(struct btmtk_dev *bdev)
+{
+	int ret = -1;
+	int i = 0;
+	u8 manufactur_data[] = { 0x01, 0x57, 0xFD, 0x27, 0x06, 0x00, 0x0A,
+		0x46, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+		0x00, 0x00, 0x00, 0x00, 0x43, 0x52, 0x4B, 0x54, 0x4D,
+		0xFF, 0xFF, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
+		0x00, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF };
+	u8 event[] = { 0x04, 0x0E, 0x07, 0x01, 0x57, 0xFD, 0x00, /* 0x06 00 63 */ };
+
+	BTMTK_INFO("%s: woble_setting_apcf[0].length %d",
+			__func__, bdev->woble_setting_apcf[0].length);
+
+	/* start to send apcf cmd from woble setting file */
+	if (bdev->woble_setting_apcf[0].length) {
+		for (i = 0; i < WOBLE_SETTING_COUNT; i++) {
+			if (!bdev->woble_setting_apcf[i].length)
+				continue;
+
+			BTMTK_INFO("%s: apcf_fill_mac[%d].content[0] = 0x%02x", __func__, i,
+					bdev->woble_setting_apcf_fill_mac[i].content[0]);
+			BTMTK_INFO("%s: apcf_fill_mac_location[%d].length = %d", __func__, i,
+					bdev->woble_setting_apcf_fill_mac_location[i].length);
+
+			if ((bdev->woble_setting_apcf_fill_mac[i].content[0] == 1) &&
+				bdev->woble_setting_apcf_fill_mac_location[i].length) {
+				/* need add BD addr to apcf cmd */
+				memcpy(bdev->woble_setting_apcf[i].content +
+				       (*bdev->woble_setting_apcf_fill_mac_location[i].content + 1),
+					bdev->bdaddr, BD_ADDRESS_SIZE);
+				BTMTK_INFO("%s: apcf[%d], add local BDADDR to location %d",
+					__func__, i,
+					(*bdev->woble_setting_apcf_fill_mac_location[i].content));
+			}
+
+			BTMTK_INFO_RAW(bdev->woble_setting_apcf[i].content,
+				       bdev->woble_setting_apcf[i].length,
+				       "Send woble_setting_apcf[%d] ", i);
+			ret = btmtk_main_send_cmd(bdev, bdev->woble_setting_apcf[i].content,
+				bdev->woble_setting_apcf[i].length, event, sizeof(event), 0, 0,
+				BTMTK_TX_PKT_FROM_HOST);
+			if (ret < 0) {
+				BTMTK_ERR("%s: manufactur_data error ret %d", __func__, ret);
+				return ret;
+			}
+		}
+	} else { /* use default */
+		BTMTK_INFO("%s: use default manufactur data", __func__);
+		memcpy(manufactur_data + 10, bdev->bdaddr, BD_ADDRESS_SIZE);
+		ret = btmtk_main_send_cmd(bdev, manufactur_data, sizeof(manufactur_data),
+			event, sizeof(event), 0, 0, BTMTK_TX_PKT_FROM_HOST);
+		if (ret < 0) {
+			BTMTK_ERR("%s: manufactur_data error ret %d", __func__, ret);
+			return ret;
+		}
+
+		ret = btmtk_set_Woble_APCF_filter_parameter(bdev);
+	}
+
+	BTMTK_INFO("%s: end ret=%d", __func__, ret);
+	return 0;
+}
+
+static int btmtk_set_Woble_Radio_Off(struct btmtk_dev *bdev)
+{
+	int ret = -1;
+	int length = 0;
+	char *radio_off = NULL;
+
+	BTMTK_INFO("%s: woble_setting_radio_off.length %d", __func__,
+		bdev->woble_setting_radio_off.length);
+	if (bdev->woble_setting_radio_off.length) {
+		/* start to send radio off cmd from woble setting file */
+		length = bdev->woble_setting_radio_off.length +
+				bdev->woble_setting_wakeup_type.length;
+		radio_off = kzalloc(length, GFP_KERNEL);
+		if (!radio_off) {
+			BTMTK_ERR("%s: alloc memory fail (radio_off)",
+				__func__);
+			ret = -ENOMEM;
+			goto Finish;
+		}
+
+		memcpy(radio_off,
+			bdev->woble_setting_radio_off.content,
+			bdev->woble_setting_radio_off.length);
+		if (bdev->woble_setting_wakeup_type.length) {
+			memcpy(radio_off + bdev->woble_setting_radio_off.length,
+				bdev->woble_setting_wakeup_type.content,
+				bdev->woble_setting_wakeup_type.length);
+			radio_off[3] += bdev->woble_setting_wakeup_type.length;
+		}
+
+		BTMTK_INFO_RAW(radio_off, length, "Send radio off");
+		ret = btmtk_main_send_cmd(bdev, radio_off, length,
+			bdev->woble_setting_radio_off_comp_event.content,
+			bdev->woble_setting_radio_off_comp_event.length, 0, 0,
+			BTMTK_TX_PKT_FROM_HOST);
+
+		kfree(radio_off);
+		radio_off = NULL;
+	} else { /* use default */
+		BTMTK_INFO("%s: use default radio off cmd", __func__);
+		ret = btmtk_send_unify_woble_suspend_default_cmd(bdev);
+	}
+
+Finish:
+	BTMTK_INFO("%s, end ret=%d", __func__, ret);
+	return ret;
+}
+
+static int btmtk_set_Woble_Radio_On(struct btmtk_dev *bdev)
+{
+	int ret = -1;
+
+	BTMTK_INFO("%s: woble_setting_radio_on.length %d", __func__,
+		bdev->woble_setting_radio_on.length);
+	if (bdev->woble_setting_radio_on.length) {
+		/* start to send radio on cmd from woble setting file */
+		BTMTK_INFO_RAW(bdev->woble_setting_radio_on.content,
+			bdev->woble_setting_radio_on.length, "send radio on");
+
+		ret = btmtk_main_send_cmd(bdev, bdev->woble_setting_radio_on.content,
+			bdev->woble_setting_radio_on.length,
+			bdev->woble_setting_radio_on_comp_event.content,
+			bdev->woble_setting_radio_on_comp_event.length, 0, 0,
+			BTMTK_TX_PKT_FROM_HOST);
+	} else { /* use default */
+		BTMTK_WARN("%s: use default radio on cmd", __func__);
+		ret = btmtk_send_unify_woble_resume_default_cmd(bdev);
+	}
+
+	BTMTK_INFO("%s, end ret=%d", __func__, ret);
+	return ret;
+}
+
+static int btmtk_del_Woble_APCF_index(struct btmtk_dev *bdev)
+{
+	int ret = -1;
+	u8 cmd[] = { 0x01, 0x57, 0xFD, 0x03, 0x01, 0x01, 0x0A };
+	u8 event[] = { 0x04, 0x0e, 0x07, 0x01, 0x57, 0xfd, 0x00, 0x01, /* 00, 63 */ };
+
+	BTMTK_INFO("%s, enter", __func__);
+	ret = btmtk_main_send_cmd(bdev, cmd, sizeof(cmd), event, sizeof(event),
+			0, 0, BTMTK_TX_PKT_FROM_HOST);
+	if (ret < 0)
+		BTMTK_ERR("%s: got error %d", __func__, ret);
+
+	BTMTK_INFO("%s, end", __func__);
+	return ret;
+}
+
+static int btmtk_set_Woble_APCF_Resume(struct btmtk_dev *bdev)
+{
+	int i = 0;
+	int ret = -1;
+	u8 event_complete[] = { 0x04, 0x0e, 0x07, 0x01, 0x57, 0xfd, 0x00 };
+
+	BTMTK_INFO("%s, enter, bdev->woble_setting_apcf_resume[0].length= %d",
+			__func__, bdev->woble_setting_apcf_resume[0].length);
+	if (bdev->woble_setting_apcf_resume[0].length) {
+		BTMTK_INFO("%s: handle leave woble apcf from file", __func__);
+		for (i = 0; i < WOBLE_SETTING_COUNT; i++) {
+			if (!bdev->woble_setting_apcf_resume[i].length)
+				continue;
+
+			BTMTK_INFO_RAW(bdev->woble_setting_apcf_resume[i].content,
+				bdev->woble_setting_apcf_resume[i].length,
+				"%s: send apcf resume %d:", __func__, i);
+
+			ret = btmtk_main_send_cmd(bdev,
+				bdev->woble_setting_apcf_resume[i].content,
+				bdev->woble_setting_apcf_resume[i].length,
+				event_complete, sizeof(event_complete),
+				0, 0, BTMTK_TX_PKT_FROM_HOST);
+			if (ret < 0) {
+				BTMTK_ERR("%s: Send apcf resume fail %d", __func__, ret);
+				return ret;
+			}
+		}
+	} else { /* use default */
+		BTMTK_WARN("%s: use default apcf resume cmd", __func__);
+		ret = btmtk_del_Woble_APCF_index(bdev);
+		if (ret < 0)
+			BTMTK_ERR("%s: btmtk_del_Woble_APCF_index return fail %d", __func__, ret);
+	}
+	BTMTK_INFO("%s, end", __func__);
+	return ret;
+}
+
+int btmtk_load_fw_cfg_setting(char *block_name, struct fw_cfg_struct *save_content,
+		int counter, u8 *searchcontent, enum fw_cfg_index_len index_length)
+{
+	int ret = 0, i = 0;
+	int temp_len = 0;
+	u8 temp[260]; /* save for total hex number */
+	unsigned long parsing_result = 0;
+	char *search_result = NULL;
+	char *search_end = NULL;
+	char search[32];
+	char *next_block = NULL;
+	char number[CHAR2HEX_SIZE + 1];	/* 1 is for '\0' */
+
+	memset(search, 0, sizeof(search));
+	memset(temp, 0, sizeof(temp));
+	memset(number, 0, sizeof(number));
+
+	/* search block name */
+	for (i = 0; i < counter; i++) {
+		temp_len = 0;
+		if (index_length == FW_CFG_INX_LEN_2) /* EX: APCF01 */
+			snprintf(search, sizeof(search), "%s%02d:", block_name, i);
+		else if (index_length == FW_CFG_INX_LEN_3) /* EX: APCF001 */
+			snprintf(search, sizeof(search), "%s%03d:", block_name, i);
+		else
+			snprintf(search, sizeof(search), "%s:", block_name);
+		search_result = strstr((char *)searchcontent, search);
+
+		if (search_result) {
+			memset(temp, 0, sizeof(temp));
+			search_result = strstr(search_result, "0x");
+			/* find next line as end of this command line, if NULL means last line */
+			next_block = strstr(search_result, ":");
+
+			/* Add HCI packet type to front of each command/event */
+			if (!memcmp(block_name, "APCF", sizeof("APCF")) ||
+				!memcmp(block_name, "RADIOOFF", sizeof("RADIOOFF")) ||
+				!memcmp(block_name, "RADIOON", sizeof("RADIOON")) ||
+				!memcmp(block_name, "APCF_RESUME", sizeof("APCF_RESUME")) ||
+				!memcmp(block_name, "VENDOR_CMD", sizeof("VENDOR_CMD")) ||
+				!memcmp(block_name, "PHASE1_WMT_CMD", sizeof("PHASE1_WMT_CMD"))) {
+				temp[0] = 0x01;
+				temp_len++;
+			} else if (!memcmp(block_name, "RADIOOFF_STATUS_EVENT",
+					sizeof("RADIOOFF_STATUS_EVENT")) ||
+				!memcmp(block_name, "RADIOOFF_COMPLETE_EVENT",
+					sizeof("RADIOOFF_COMPLETE_EVENT")) ||
+				!memcmp(block_name, "RADIOON_STATUS_EVENT",
+					sizeof("RADIOON_STATUS_EVENT")) ||
+				!memcmp(block_name, "RADIOON_COMPLETE_EVENT",
+					sizeof("RADIOON_COMPLETE_EVENT"))) {
+				temp[0] = 0x04;
+				temp_len++;
+			}
+
+			do {
+				search_end = strstr(search_result, ",");
+				if (search_end - search_result != CHAR2HEX_SIZE) {
+					BTMTK_ERR("%s: Incorrect Format in %s", __func__, search);
+					break;
+				}
+
+				memset(number, 0, sizeof(number));
+				memcpy(number, search_result, CHAR2HEX_SIZE);
+				ret = kstrtoul(number, 0, &parsing_result);
+				if (ret == 0) {
+					if (temp_len >= sizeof(temp)) {
+						BTMTK_ERR("%s: %s data over %zu",
+							__func__, search, sizeof(temp));
+						break;
+					}
+					temp[temp_len++] = parsing_result;
+				} else {
+					BTMTK_WARN("%s: %s kstrtoul fail: %d",
+							__func__, search, ret);
+					break;
+				}
+				search_result = strstr(search_end, "0x");
+			} while (search_result < next_block ||
+				(search_result && next_block == NULL));
+		} else
+			BTMTK_DBG("%s: %s is not found in %d", __func__, search, i);
+
+		if (temp_len && temp_len < sizeof(temp)) {
+			BTMTK_INFO("%s: %s found & stored in %d", __func__, search, i);
+			save_content[i].content = kzalloc(temp_len, GFP_KERNEL);
+			if (save_content[i].content == NULL) {
+				BTMTK_ERR("%s: Allocate memory fail(%d)", __func__, i);
+				return -ENOMEM;
+			}
+			memcpy(save_content[i].content, temp, temp_len);
+			save_content[i].length = temp_len;
+			BTMTK_DBG_RAW(save_content[i].content,
+				save_content[i].length, "%s", search);
+		}
+	}
+
+	return ret;
+}
+
+int btmtk_load_code_from_setting_files(char *setting_file_name,
+			struct device *dev, u32 *code_len, struct btmtk_dev *bdev)
+{
+	int err;
+	const struct firmware *fw_entry = NULL;
+
+	*code_len = 0;
+
+	if (bdev == NULL) {
+		BTMTK_ERR("%s: g_data is NULL!!", __func__);
+		err = -1;
+		return err;
+	}
+
+	BTMTK_INFO("%s: begin setting_file_name = %s", __func__, setting_file_name);
+	err = request_firmware(&fw_entry, setting_file_name, dev);
+	if (err != 0 || fw_entry == NULL) {
+		BTMTK_INFO("%s: request_firmware fail, file not exist, err = %d, fw_entry = %p",
+				__func__, err, fw_entry);
+		if (fw_entry)
+			release_firmware(fw_entry);
+		return err;
+	}
+
+	BTMTK_INFO("%s: setting file request_firmware size %zu success", __func__, fw_entry->size);
+	if (bdev->setting_file != NULL) {
+		kfree(bdev->setting_file);
+		bdev->setting_file = NULL;
+	}
+	/* alloc setting file memory */
+	bdev->setting_file = kzalloc(fw_entry->size + 1, GFP_KERNEL);
+	if (bdev->setting_file == NULL) {
+		BTMTK_ERR("%s: kzalloc size %zu failed!!", __func__, fw_entry->size);
+		release_firmware(fw_entry);
+		return err;
+	}
+
+	memcpy(bdev->setting_file, fw_entry->data, fw_entry->size);
+	bdev->setting_file[fw_entry->size] = '\0';
+
+	*code_len = fw_entry->size;
+	release_firmware(fw_entry);
+
+	BTMTK_INFO("%s: setting_file len (%d) assign done", __func__, *code_len);
+	return err;
+}
+
+int btmtk_load_woble_setting(char *bin_name,
+		struct device *dev, u32 *code_len, struct btmtk_dev *bdev)
+{
+	int err;
+	*code_len = 0;
+
+	err = btmtk_load_code_from_setting_files(bin_name, dev, code_len, bdev);
+	if (err) {
+		BTMTK_ERR("woble_setting btmtk_load_code_from_setting_files failed!!");
+		goto LOAD_END;
+	}
+
+	err = btmtk_load_fw_cfg_setting("APCF",
+			bdev->woble_setting_apcf, WOBLE_SETTING_COUNT,
+			bdev->setting_file, FW_CFG_INX_LEN_2);
+	if (err)
+		goto LOAD_END;
+
+	err = btmtk_load_fw_cfg_setting("APCF_ADD_MAC",
+			bdev->woble_setting_apcf_fill_mac, WOBLE_SETTING_COUNT,
+			bdev->setting_file, FW_CFG_INX_LEN_2);
+	if (err)
+		goto LOAD_END;
+
+	err = btmtk_load_fw_cfg_setting("APCF_ADD_MAC_LOCATION",
+			bdev->woble_setting_apcf_fill_mac_location, WOBLE_SETTING_COUNT,
+			bdev->setting_file, FW_CFG_INX_LEN_2);
+	if (err)
+		goto LOAD_END;
+
+	err = btmtk_load_fw_cfg_setting("RADIOOFF", &bdev->woble_setting_radio_off, 1,
+			bdev->setting_file, FW_CFG_INX_LEN_2);
+	if (err)
+		goto LOAD_END;
+
+	switch (bdev->bt_cfg.unify_woble_type) {
+	case 0:
+		err = btmtk_load_fw_cfg_setting("WAKEUP_TYPE_LEGACY",
+			&bdev->woble_setting_wakeup_type, 1,
+			bdev->setting_file, FW_CFG_INX_LEN_2);
+		break;
+	case 1:
+		err = btmtk_load_fw_cfg_setting("WAKEUP_TYPE_WAVEFORM",
+			&bdev->woble_setting_wakeup_type, 1,
+			bdev->setting_file, FW_CFG_INX_LEN_2);
+		break;
+	case 2:
+		err = btmtk_load_fw_cfg_setting("WAKEUP_TYPE_IR",
+			&bdev->woble_setting_wakeup_type, 1,
+			bdev->setting_file, FW_CFG_INX_LEN_2);
+		break;
+	default:
+		BTMTK_WARN("%s: unify_woble_type unknown(%d)",
+			__func__, bdev->bt_cfg.unify_woble_type);
+	}
+	if (err)
+		BTMTK_WARN("%s: Parse unify_woble_type(%d) failed",
+			__func__, bdev->bt_cfg.unify_woble_type);
+
+	err = btmtk_load_fw_cfg_setting("RADIOOFF_STATUS_EVENT",
+			&bdev->woble_setting_radio_off_status_event,
+			1, bdev->setting_file, FW_CFG_INX_LEN_2);
+	if (err)
+		goto LOAD_END;
+
+	err = btmtk_load_fw_cfg_setting("RADIOOFF_COMPLETE_EVENT",
+			&bdev->woble_setting_radio_off_comp_event,
+			1, bdev->setting_file, FW_CFG_INX_LEN_2);
+	if (err)
+		goto LOAD_END;
+
+	err = btmtk_load_fw_cfg_setting("RADIOON",
+			&bdev->woble_setting_radio_on, 1, bdev->setting_file, FW_CFG_INX_LEN_2);
+	if (err)
+		goto LOAD_END;
+
+	err = btmtk_load_fw_cfg_setting("RADIOON_STATUS_EVENT",
+			&bdev->woble_setting_radio_on_status_event,
+			1, bdev->setting_file, FW_CFG_INX_LEN_2);
+	if (err)
+		goto LOAD_END;
+
+	err = btmtk_load_fw_cfg_setting("RADIOON_COMPLETE_EVENT",
+			&bdev->woble_setting_radio_on_comp_event,
+			1, bdev->setting_file, FW_CFG_INX_LEN_2);
+	if (err)
+		goto LOAD_END;
+
+	err = btmtk_load_fw_cfg_setting("APCF_RESUME",
+			bdev->woble_setting_apcf_resume, WOBLE_SETTING_COUNT,
+			bdev->setting_file, FW_CFG_INX_LEN_2);
+
+LOAD_END:
+	/* release setting file memory */
+	if (bdev) {
+		kfree(bdev->setting_file);
+		bdev->setting_file = NULL;
+	}
+
+	if (err)
+		BTMTK_ERR("%s: error return %d", __func__, err);
+
+	return err;
+}
+
+static void btmtk_check_wobx_debug_log(struct btmtk_dev *bdev)
+{
+	/* 0xFF, 0xFF, 0xFF, 0xFF is log level */
+	u8 cmd[] = { 0X01, 0xCE, 0xFC, 0x04, 0xFF, 0xFF, 0xFF, 0xFF };
+	u8 event[] = { 0x04, 0xE8 };
+	int ret = -1;
+
+	BTMTK_INFO("%s: begin", __func__);
+
+	ret = btmtk_main_send_cmd(bdev, cmd, sizeof(cmd), event, sizeof(event), 0, 0,
+		BTMTK_TX_PKT_FROM_HOST);
+	if (ret < 0)
+		BTMTK_ERR("%s: failed(%d)", __func__, ret);
+
+	/* Driver just print event to kernel log in rx_work,
+	 * Please reference wiki to know what it is.
+	 */
+}
+
+int btmtk_handle_leaving_WoBLE_state(struct btmtk_dev *bdev)
+{
+	int ret = -1;
+	int fstate = BTMTK_FOPS_STATE_INIT;
+
+	BTMTK_INFO("%s: begin", __func__);
+	fstate = btmtk_fops_get_state(bdev);
+	if (!bdev->bt_cfg.support_woble_for_bt_disable) {
+		if (fstate != BTMTK_FOPS_STATE_OPENED) {
+			BTMTK_WARN("%s: fops is not opened, return", __func__);
+			return 0;
+		}
+	}
+
+	if (fstate != BTMTK_FOPS_STATE_OPENED) {
+		BTMTK_WARN("%s: fops is not open yet(%d), need to start traffic before leaving",
+				__func__, fstate);
+		/* start traffic to recv event*/
+		ret = main_info.hif_hook.open(bdev->hdev);
+		if (ret < 0) {
+			BTMTK_ERR("%s, cif_open failed", __func__);
+			goto Finish;
+		}
+	}
+
+	if (is_support_unify_woble(bdev)) {
+		ret = btmtk_set_Woble_Radio_On(bdev);
+		if (ret < 0)
+			goto Finish;
+
+		ret = btmtk_set_Woble_APCF_Resume(bdev);
+		if (ret < 0)
+			goto Finish;
+	} else {
+		/* radio on cmd with wobx_mode_disable, used when unify woble off */
+		ret = btmtk_send_woble_resume_cmd(bdev);
+	}
+
+Finish:
+	if (ret < 0) {
+		BTMTK_INFO("%s: woble_resume_fail!!!", __func__);
+	} else {
+		/* It's wobx debug log method. */
+		btmtk_check_wobx_debug_log(bdev);
+
+		if (fstate != BTMTK_FOPS_STATE_OPENED) {
+			ret = btmtk_send_deinit_cmds(bdev);
+			if (ret < 0) {
+				BTMTK_ERR("%s, btmtk_send_deinit_cmds failed", __func__);
+				goto exit;
+			}
+
+			BTMTK_WARN("%s: fops is not open(%d) \,
+					need to stop traffic after leaving woble",
+					__func__, fstate);
+			/* stop traffic to stop recv data from fw*/
+			ret = main_info.hif_hook.close(bdev->hdev);
+			if (ret < 0) {
+				BTMTK_ERR("%s, cif_close failed", __func__);
+				goto exit;
+			}
+		} else
+			bdev->power_state = BTMTK_DONGLE_STATE_POWER_ON;
+		BTMTK_INFO("%s: success", __func__);
+	}
+
+exit:
+	BTMTK_INFO("%s: end", __func__);
+	return ret;
+}
+
+int btmtk_handle_entering_WoBLE_state(struct btmtk_dev *bdev)
+{
+	int ret = -1;
+	int fstate = BTMTK_FOPS_STATE_INIT;
+	int state = BTMTK_STATE_INIT;
+
+	BTMTK_INFO("%s: begin", __func__);
+
+	fstate = btmtk_fops_get_state(bdev);
+	if (!bdev->bt_cfg.support_woble_for_bt_disable) {
+		if (fstate != BTMTK_FOPS_STATE_OPENED) {
+			BTMTK_WARN("%s: fops is not open yet(%d)!, return", __func__, fstate);
+			return 0;
+		}
+	}
+
+	state = btmtk_get_chip_state(bdev);
+	if (state == BTMTK_STATE_FW_DUMP) {
+		BTMTK_WARN("%s: FW dumping ongoing, don't send any cmd to FW!!!", __func__);
+		goto Finish;
+	}
+
+	if (bdev->chip_reset || bdev->subsys_reset) {
+		BTMTK_ERR("%s chip_reset is %d, subsys_reset is %d", __func__,
+			bdev->chip_reset, bdev->subsys_reset);
+		goto Finish;
+	}
+
+	/* Power on first if state is power off */
+	ret = btmtk_reset_power_on(bdev);
+	if (ret < 0) {
+		BTMTK_ERR("%s: reset power_on fail return", __func__);
+		goto Finish;
+	}
+
+	if (fstate != BTMTK_FOPS_STATE_OPENED) {
+		BTMTK_WARN("%s: fops is not open yet(%d), need to start traffic before enter woble",
+				__func__, fstate);
+		/* start traffic to recv event*/
+		ret = main_info.hif_hook.open(bdev->hdev);
+		if (ret < 0) {
+			BTMTK_ERR("%s, cif_open failed", __func__);
+			goto Finish;
+		}
+	}
+	if (is_support_unify_woble(bdev)) {
+		do {
+			typedef ssize_t (*func) (u16 u16Key, const char *buf, size_t size);
+			char *func_name = "MDrv_PM_Write_Key";
+			func pFunc = NULL;
+			ssize_t sret = 0;
+			u8 buf = 0;
+
+			pFunc = (func) btmtk_kallsyms_lookup_name(func_name);
+			if (pFunc && bdev->bt_cfg.unify_woble_type == 1) {
+				buf = 1;
+				sret = pFunc(PM_KEY_BTW, &buf, sizeof(u8));
+				BTMTK_INFO("%s: Invoke %s, buf = %d, sret = %zd", __func__,
+					func_name, buf, sret);
+
+			} else {
+				BTMTK_WARN("%s: No Exported Func Found [%s]", __func__, func_name);
+			}
+		} while (0);
+
+		ret = btmtk_send_apcf_reserved(bdev);
+		if (ret < 0)
+			goto STOP_TRAFFIC;
+
+		ret = btmtk_send_read_BDADDR_cmd(bdev);
+		if (ret < 0)
+			goto STOP_TRAFFIC;
+
+		ret = btmtk_set_Woble_APCF(bdev);
+		if (ret < 0)
+			goto STOP_TRAFFIC;
+
+		ret = btmtk_set_Woble_Radio_Off(bdev);
+		if (ret < 0)
+			goto STOP_TRAFFIC;
+	} else {
+		/* radio off cmd with wobx_mode_disable, used when unify woble off */
+		ret = btmtk_send_woble_suspend_cmd(bdev);
+	}
+
+STOP_TRAFFIC:
+	if (fstate != BTMTK_FOPS_STATE_OPENED) {
+		BTMTK_WARN("%s: fops is not open(%d), need to stop traffic after enter woble",
+				__func__, fstate);
+		/* stop traffic to stop recv data from fw*/
+		ret = main_info.hif_hook.close(bdev->hdev);
+		if (ret < 0) {
+			BTMTK_ERR("%s, cif_close failed", __func__);
+			goto Finish;
+		}
+	}
+
+Finish:
+	if (ret) {
+		bdev->power_state = BTMTK_DONGLE_STATE_ERROR;
+		if (bdev->bt_cfg.support_woble_wakelock)
+			btmtk_woble_wake_lock(bdev);
+	}
+
+	BTMTK_INFO("%s: end ret = %d, power_state =%d", __func__, ret, bdev->power_state);
+	return ret;
+}
+
+int btmtk_woble_suspend(struct btmtk_dev *bdev)
+{
+	int ret = 0;
+	int fstate = BTMTK_FOPS_STATE_INIT;
+
+	BTMTK_INFO("%s: enter", __func__);
+
+	fstate = btmtk_fops_get_state(bdev);
+
+	if (!is_support_unify_woble(bdev) && (fstate != BTMTK_FOPS_STATE_OPENED)) {
+		BTMTK_WARN("%s: when not support woble, in bt off state, do nothing!", __func__);
+		goto exit;
+	}
+
+	ret = btmtk_handle_entering_WoBLE_state(bdev);
+	if (ret)
+		BTMTK_ERR("%s: btmtk_handle_entering_WoBLE_state return fail %d", __func__, ret);
+
+	if (bdev->bt_cfg.support_woble_by_eint) {
+		if (bdev->wobt_irq != 0 && atomic_read(&(bdev->irq_enable_count)) == 0) {
+			BTMTK_INFO("enable BT IRQ:%d", bdev->wobt_irq);
+			irq_set_irq_wake(bdev->wobt_irq, 1);
+			enable_irq(bdev->wobt_irq);
+			atomic_inc(&(bdev->irq_enable_count));
+		} else
+			BTMTK_INFO("irq_enable count:%d", atomic_read(&(bdev->irq_enable_count)));
+	}
+
+exit:
+	BTMTK_INFO("%s: end", __func__);
+	return ret;
+}
+
+int btmtk_woble_resume(struct btmtk_dev *bdev)
+{
+	int ret = -1;
+	int fstate = BTMTK_FOPS_STATE_INIT;
+
+	BTMTK_INFO("%s: enter", __func__);
+	fstate = btmtk_fops_get_state(bdev);
+
+	if (!is_support_unify_woble(bdev) && (fstate != BTMTK_FOPS_STATE_OPENED)) {
+		BTMTK_WARN("%s: when not support woble, in bt off state, do nothing!", __func__);
+		goto exit;
+	}
+
+	if (bdev->power_state == BTMTK_DONGLE_STATE_ERROR) {
+		BTMTK_INFO("%s: In BTMTK_DONGLE_STATE_ERROR(Could suspend caused), do assert",
+			__func__);
+		btmtk_send_assert_cmd(bdev);
+		ret = -EBADFD;
+		goto exit;
+	}
+
+
+	if (bdev->bt_cfg.support_woble_by_eint) {
+		if (bdev->wobt_irq != 0 && atomic_read(&(bdev->irq_enable_count)) == 1) {
+			BTMTK_INFO("disable BT IRQ:%d", bdev->wobt_irq);
+			atomic_dec(&(bdev->irq_enable_count));
+			disable_irq_nosync(bdev->wobt_irq);
+		} else
+			BTMTK_INFO("irq_enable count:%d", atomic_read(&(bdev->irq_enable_count)));
+	}
+
+	ret = btmtk_handle_leaving_WoBLE_state(bdev);
+	if (ret < 0) {
+		BTMTK_ERR("%s: btmtk_handle_leaving_WoBLE_state return fail %d", __func__, ret);
+		/* avoid rtc to do suspend again, do FW dump first */
+		btmtk_woble_wake_lock(bdev);
+		btmtk_send_assert_cmd(bdev);
+		goto exit;
+	}
+
+	if (bdev->bt_cfg.reset_stack_after_woble
+		&& main_info.reset_stack_flag == HW_ERR_NONE
+		&& fstate == BTMTK_FOPS_STATE_OPENED)
+		main_info.reset_stack_flag = HW_ERR_CODE_RESET_STACK_AFTER_WOBLE;
+
+	btmtk_send_hw_err_to_host(bdev);
+	BTMTK_INFO("%s: end(%d), reset_stack_flag = %d, fstate = %d", __func__, ret,
+			main_info.reset_stack_flag, fstate);
+
+exit:
+	BTMTK_INFO("%s: end", __func__);
+	return ret;
+}
+
+static int btmtk_enter_standby(void)
+{
+	int ret = 0;
+	int i = 0;
+	int cif_event = 0;
+	struct btmtk_cif_state *cif_state = NULL;
+	struct btmtk_dev *bdev = NULL;
+
+	BTMTK_INFO("%s: enter", __func__);
+	for (i = 0; i < btmtk_intf_num; i++) {
+		/* Find valid dev for already probe interface. */
+		if (g_bdev[i]->hdev != NULL) {
+			bdev = g_bdev[i];
+
+			/* Retrieve current HIF event state */
+			cif_event = HIF_EVENT_STANDBY;
+			if (BTMTK_CIF_IS_NULL(bdev, cif_event)) {
+				/* Error */
+				BTMTK_WARN("%s parameter is NULL", __func__);
+				return -ENODEV;
+			}
+
+			cif_state = &bdev->cif_state[cif_event];
+
+			if (main_info.hif_hook.cif_mutex_lock)
+				main_info.hif_hook.cif_mutex_lock(bdev);
+			/* Set Entering state */
+			btmtk_set_chip_state((void *)bdev, cif_state->ops_enter);
+
+			/* Do HIF events */
+			ret = btmtk_woble_suspend(bdev);
+
+			/* Set End/Error state */
+			if (ret == 0)
+				btmtk_set_chip_state((void *)bdev, cif_state->ops_end);
+			else
+				btmtk_set_chip_state((void *)bdev, cif_state->ops_error);
+
+			if (main_info.hif_hook.cif_mutex_unlock)
+				main_info.hif_hook.cif_mutex_unlock(bdev);
+
+			if (ret)
+				break;
+		}
+	}
+
+	BTMTK_INFO("%s: end", __func__);
+	return ret;
+}
+
+static bool btmtk_parse_bt_cfg_file(char *item_name,
+		char *text, u8 *searchcontent)
+{
+	bool ret = true;
+	int temp_len = 0;
+	char search[32];
+	char *ptr = NULL, *p = NULL;
+	char *temp = text;
+
+	if (text == NULL) {
+		BTMTK_ERR("%s: text param is invalid!", __func__);
+		ret = false;
+		goto out;
+	}
+
+	memset(search, 0, sizeof(search));
+	snprintf(search, sizeof(search), "%s", item_name); /* EX: SUPPORT_UNIFY_WOBLE */
+	p = ptr = strstr((char *)searchcontent, search);
+
+	if (!ptr) {
+		BTMTK_ERR("%s: Can't find %s\n", __func__, item_name);
+		ret = false;
+		goto out;
+	}
+
+	if (p > (char *)searchcontent) {
+		p--;
+		while ((*p == ' ') && (p != (char *)searchcontent))
+			p--;
+		if (*p == '#') {
+			BTMTK_ERR("%s: It's invalid bt cfg item\n", __func__);
+			ret = false;
+			goto out;
+		}
+	}
+
+	p = ptr + strlen(item_name) + 1;
+	ptr = p;
+
+	for (;;) {
+		switch (*p) {
+		case '\n':
+			goto textdone;
+		default:
+			*temp++ = *p++;
+			break;
+		}
+	}
+
+textdone:
+	temp_len = p - ptr;
+	*temp = '\0';
+
+out:
+	return ret;
+}
+
+static void btmtk_bt_cfg_item_value_to_bool(char *item_value, bool *value)
+{
+	unsigned long text_value = 0;
+
+	if (item_value == NULL) {
+		BTMTK_ERR("%s: item_value is NULL!", __func__);
+		return;
+	}
+
+	if (kstrtoul(item_value, 10, &text_value) == 0) {
+		if (text_value == 1)
+			*value = true;
+		else
+			*value = false;
+	} else {
+		BTMTK_WARN("%s: kstrtoul failed!", __func__);
+	}
+}
+
+static bool btmtk_load_bt_cfg_item(struct bt_cfg_struct *bt_cfg_content,
+		u8 *searchcontent, struct btmtk_dev *bdev)
+{
+	bool ret = true;
+	char text[128]; /* save for search text */
+	unsigned long text_value = 0;
+
+	memset(text, 0, sizeof(text));
+	ret = btmtk_parse_bt_cfg_file(BT_UNIFY_WOBLE, text, searchcontent);
+	if (ret) {
+		btmtk_bt_cfg_item_value_to_bool(text, &bt_cfg_content->support_unify_woble);
+		BTMTK_INFO("%s: bt_cfg_content->support_unify_woble = %d", __func__,
+				bt_cfg_content->support_unify_woble);
+	} else {
+		BTMTK_WARN("%s: search item %s is invalid!", __func__, BT_UNIFY_WOBLE);
+	}
+
+	ret = btmtk_parse_bt_cfg_file(BT_UNIFY_WOBLE_TYPE, text, searchcontent);
+	if (ret) {
+		if (kstrtoul(text, 10, &text_value) == 0)
+			bt_cfg_content->unify_woble_type = text_value;
+		else
+			BTMTK_WARN("%s: kstrtoul failed %s!", __func__, BT_UNIFY_WOBLE_TYPE);
+	} else {
+		BTMTK_WARN("%s: search item %s is invalid!", __func__, BT_UNIFY_WOBLE_TYPE);
+	}
+
+	BTMTK_INFO("%s: bt_cfg_content->unify_woble_type = %d", __func__,
+			bt_cfg_content->unify_woble_type);
+
+	ret = btmtk_parse_bt_cfg_file(BT_WOBLE_BY_EINT, text, searchcontent);
+	if (ret) {
+		btmtk_bt_cfg_item_value_to_bool(text, &bt_cfg_content->support_woble_by_eint);
+		BTMTK_INFO("%s: bt_cfg_content->support_woble_by_eint = %d", __func__,
+					bt_cfg_content->support_woble_by_eint);
+	} else {
+		BTMTK_WARN("%s: search item %s is invalid!", __func__, BT_WOBLE_BY_EINT);
+	}
+
+	ret = btmtk_parse_bt_cfg_file(BT_DONGLE_RESET_PIN, text, searchcontent);
+	if (ret) {
+		if (kstrtoul(text, 10, &text_value) == 0)
+			bt_cfg_content->dongle_reset_gpio_pin = text_value;
+		else
+			BTMTK_WARN("%s: kstrtoul failed %s!", __func__, BT_DONGLE_RESET_PIN);
+	} else {
+		BTMTK_WARN("%s: search item %s is invalid!", __func__, BT_DONGLE_RESET_PIN);
+	}
+
+	BTMTK_INFO("%s: bt_cfg_content->dongle_reset_gpio_pin = %d", __func__,
+			bt_cfg_content->dongle_reset_gpio_pin);
+
+	ret = btmtk_parse_bt_cfg_file(BT_RESET_DONGLE, text, searchcontent);
+	if (ret) {
+		btmtk_bt_cfg_item_value_to_bool(text, &bt_cfg_content->support_dongle_reset);
+		BTMTK_INFO("%s: bt_cfg_content->support_dongle_reset = %d", __func__,
+				bt_cfg_content->support_dongle_reset);
+	} else {
+		BTMTK_WARN("%s: search item %s is invalid!", __func__, BT_RESET_DONGLE);
+	}
+
+	ret = btmtk_parse_bt_cfg_file(BT_FULL_FW_DUMP, text, searchcontent);
+	if (ret) {
+		btmtk_bt_cfg_item_value_to_bool(text, &bt_cfg_content->support_full_fw_dump);
+		BTMTK_INFO("%s: bt_cfg_content->support_full_fw_dump = %d", __func__,
+				bt_cfg_content->support_full_fw_dump);
+	} else {
+		BTMTK_WARN("%s: search item %s is invalid!", __func__, BT_FULL_FW_DUMP);
+	}
+
+	ret = btmtk_parse_bt_cfg_file(BT_WOBLE_WAKELOCK, text, searchcontent);
+	if (ret) {
+		btmtk_bt_cfg_item_value_to_bool(text, &bt_cfg_content->support_woble_wakelock);
+		BTMTK_INFO("%s: bt_cfg_content->support_woble_wakelock = %d", __func__,
+				bt_cfg_content->support_woble_wakelock);
+	} else {
+		BTMTK_WARN("%s: search item %s is invalid!", __func__, BT_WOBLE_WAKELOCK);
+	}
+
+	ret = btmtk_parse_bt_cfg_file(BT_WOBLE_FOR_BT_DISABLE, text, searchcontent);
+	if (ret) {
+		btmtk_bt_cfg_item_value_to_bool(text,
+					&bt_cfg_content->support_woble_for_bt_disable);
+		BTMTK_INFO("%s: bt_cfg_content->support_woble_for_bt_disable = %d", __func__,
+				bt_cfg_content->support_woble_for_bt_disable);
+	} else {
+		BTMTK_WARN("%s: search item %s is invalid!", __func__, BT_WOBLE_FOR_BT_DISABLE);
+	}
+
+	ret = btmtk_parse_bt_cfg_file(BT_RESET_STACK_AFTER_WOBLE, text, searchcontent);
+	if (ret) {
+		btmtk_bt_cfg_item_value_to_bool(text, &bt_cfg_content->reset_stack_after_woble);
+		BTMTK_INFO("%s: bt_cfg_content->reset_stack_after_woble = %d", __func__,
+				bt_cfg_content->reset_stack_after_woble);
+	} else {
+		BTMTK_WARN("%s: search item %s is invalid!", __func__, BT_RESET_STACK_AFTER_WOBLE);
+	}
+
+	ret = btmtk_parse_bt_cfg_file(BT_AUTO_PICUS, text, searchcontent);
+	if (ret) {
+		btmtk_bt_cfg_item_value_to_bool(text, &bt_cfg_content->support_auto_picus);
+		BTMTK_INFO("%s: bt_cfg_content->support_auto_picus = %d", __func__,
+				bt_cfg_content->support_auto_picus);
+		if (bt_cfg_content->support_auto_picus == true) {
+			ret = btmtk_load_fw_cfg_setting(BT_AUTO_PICUS_FILTER,
+					&bt_cfg_content->picus_filter,
+					1, searchcontent, FW_CFG_INX_LEN_NONE);
+			if (ret)
+				BTMTK_WARN("%s: search item %s is invalid!",
+					__func__, BT_AUTO_PICUS_FILTER);
+
+			ret = btmtk_load_fw_cfg_setting(BT_AUTO_PICUS_ENABLE,
+					&bt_cfg_content->picus_enable,
+					1, searchcontent, FW_CFG_INX_LEN_NONE);
+			if (ret)
+				BTMTK_WARN("%s: search item %s is invalid!",
+					__func__, BT_AUTO_PICUS_ENABLE);
+		}
+	} else {
+		BTMTK_WARN("%s: search item %s is invalid!", __func__, BT_AUTO_PICUS);
+	}
+
+	ret = btmtk_parse_bt_cfg_file(BT_PICUS_TO_HOST, text, searchcontent);
+	if (ret) {
+		btmtk_bt_cfg_item_value_to_bool(text, &bt_cfg_content->support_picus_to_host);
+		BTMTK_INFO("%s: bt_cfg_content->support_picus_to_host = %d", __func__,
+				bt_cfg_content->support_picus_to_host);
+	} else {
+		BTMTK_WARN("%s: search item %s is invalid!", __func__, BT_PICUS_TO_HOST);
+	}
+
+	ret = btmtk_parse_bt_cfg_file(BT_SINGLE_SKU, text, searchcontent);
+	if (ret) {
+		btmtk_bt_cfg_item_value_to_bool(text, &bt_cfg_content->support_bt_single_sku);
+		BTMTK_INFO("%s: bt_cfg_content->support_bt_single_sku = %d", __func__,
+				bt_cfg_content->support_bt_single_sku);
+	} else {
+		BTMTK_WARN("%s: search item %s is invalid!", __func__, BT_SINGLE_SKU);
+	}
+
+	ret = btmtk_load_fw_cfg_setting(BT_PHASE1_WMT_CMD, bt_cfg_content->phase1_wmt_cmd,
+				PHASE1_WMT_CMD_COUNT, searchcontent, FW_CFG_INX_LEN_3);
+	if (ret)
+		BTMTK_WARN("%s: search item %s is invalid!", __func__, BT_PHASE1_WMT_CMD);
+
+	ret = btmtk_load_fw_cfg_setting(BT_VENDOR_CMD, bt_cfg_content->vendor_cmd,
+				VENDOR_CMD_COUNT, searchcontent, FW_CFG_INX_LEN_3);
+	if (ret)
+		BTMTK_WARN("%s: search item %s is invalid!", __func__, BT_VENDOR_CMD);
+
+	/* release setting file memory */
+	if (bdev) {
+		kfree(bdev->setting_file);
+		bdev->setting_file = NULL;
+	}
+	return ret;
+}
+
+bool btmtk_load_bt_cfg(char *cfg_name, struct device *dev, struct btmtk_dev *bdev)
+{
+	bool err = false;
+	u32 code_len = 0;
+
+	if (btmtk_load_code_from_setting_files(cfg_name, dev, &code_len, bdev)) {
+		BTMTK_ERR("btmtk_usb_load_code_from_setting_files failed!!");
+		goto exit;
+	}
+
+	err = btmtk_load_bt_cfg_item(&bdev->bt_cfg, bdev->setting_file, bdev);
+	if (err)
+		BTMTK_ERR("btmtk_usb_load_bt_cfg_item error return %d", err);
+
+exit:
+	return err;
+}
+
+#if ENABLESTP
+static int btmtk_send_set_stp_cmd(struct btmtk_dev *bdev)
+{
+	u8 cmd[] = { 0x01, 0x6F, 0xFC, 0x09, 0x01, 0x04, 0x05, 0x00, 0x03, 0x11, 0x0E, 0x00, 0x00};
+	/* To-Do, for event check */
+	u8 event[] = { 0x04, 0xE4, 0x06, 0x02, 0x04, 0x02, 0x00, 0x00, 0x03};
+	int ret = 0;
+
+	ret = btmtk_main_send_cmd(bdev, cmd, sizeof(cmd), event, sizeof(event), 0, 0,
+			BTMTK_TX_CMD_FROM_DRV);
+
+	BTMTK_INFO("%s done", __func__);
+	return ret;
+}
+
+static int btmtk_send_set_stp1_cmd(struct btmtk_dev *bdev)
+{
+	u8 cmd[] = {0x01, 0x6F, 0xFC, 0x0C, 0x01, 0x08, 0x08, 0x00,
+			0x02, 0x01, 0x00, 0x01, 0x08, 0x00, 0x00, 0x80};
+	/* To-Do, for event check */
+	u8 event[] = {0x04, 0xE4, 0x10, 0x02, 0x08,
+			0x0C, 0x00, 0x00, 0x00, 0x00, 0x01, 0x08,
+			0x00, 0x00, 0x80, 0x63, 0x76, 0x00, 0x00};
+	int ret = 0;
+
+	ret = btmtk_main_send_cmd(bdev, cmd, sizeof(cmd), event, sizeof(event), 0, 0,
+			BTMTK_TX_CMD_FROM_DRV);
+
+	BTMTK_INFO("%s done", __func__);
+	return ret;
+}
+#endif
+
+static int btmtk_send_hci_tci_set_sleep_cmd_766x(struct btmtk_dev *bdev)
+{
+	u8 cmd[] = { 0x01, 0x7A, 0xFC, 0x07, 0x05, 0x40, 0x06, 0x40, 0x06, 0x00, 0x00 };
+	/* To-Do, for event check */
+	u8 event[] = { 0x04, 0x0E, 0x04, 0x01, 0x7A, 0xFC, 0x00 };
+	int ret = -1;
+
+	if (!bdev) {
+		BTMTK_ERR("%s: bdev is NULL !", __func__);
+		return ret;
+	}
+
+	ret = btmtk_main_send_cmd(bdev, cmd, sizeof(cmd), event, sizeof(event), 0, 0,
+			BTMTK_TX_PKT_FROM_HOST);
+
+	BTMTK_INFO("%s done", __func__);
+
+	return ret;
+}
+
+int btmtk_cap_init(struct btmtk_dev *bdev)
+{
+	if (!bdev) {
+		BTMTK_ERR("%s, bdev is NULL!", __func__);
+		return -1;
+	}
+	/* Todo read wifi fw version
+	 * int wifi_fw_ver;
+
+	 * btmtk_cif_write_register(bdev, 0x7C4001C4, 0x00008800);
+	 * btmtk_cif_read_register(bdev, 0x7c4f0004, &wifi_fw_ver);
+	 * BTMTK_ERR("wifi fw_ver = %04X", wifi_fw_ver);
+	 */
+
+	main_info.hif_hook.reg_read(bdev, CHIP_ID, &bdev->chip_id);
+	if (is_mt7922(bdev->chip_id) || is_mt7961(bdev->chip_id)) {
+		main_info.hif_hook.reg_read(bdev, FLAVOR, &bdev->flavor);
+		main_info.hif_hook.reg_read(bdev, FW_VERSION, &bdev->fw_version);
+	} else {
+		BTMTK_ERR("Unknown Mediatek device(%04X)\n", bdev->chip_id);
+		return -1;
+	}
+
+	BTMTK_INFO("%s: Chip ID = 0x%x", __func__, bdev->chip_id);
+	BTMTK_INFO("%s: flavor = 0x%x", __func__, bdev->flavor);
+	BTMTK_INFO("%s: FW Ver = 0x%x", __func__, bdev->fw_version);
+
+	memset(bdev->rom_patch_bin_file_name, 0, MAX_BIN_FILE_NAME_LEN);
+	if ((bdev->fw_version & 0xff) == 0xff) {
+		BTMTK_ERR("%s: failed, wrong FW version : 0x%x !", __func__, bdev->fw_version);
+		return -1;
+	}
+
+	/* Bin filename format : "BT_RAM_CODE_MT%04x_%x_%x_hdr.bin"
+	 *  $$$$ : chip id
+	 *  % : fw version & 0xFF + 1 (in HEX)
+	 */
+	bdev->flavor = (bdev->flavor & 0x00000080) >> 7;
+	BTMTK_INFO("%s: flavor1 = 0x%x", __func__, bdev->flavor);
+
+	/* if flavor equals 1, it represent 7920, else it represent 7921 */
+	if (bdev->flavor)
+		snprintf(bdev->rom_patch_bin_file_name, MAX_BIN_FILE_NAME_LEN,
+				"BT_RAM_CODE_MT%04x_1a_%x_hdr.bin",
+				bdev->chip_id & 0xffff, (bdev->fw_version & 0xff) + 1);
+	else
+		snprintf(bdev->rom_patch_bin_file_name, MAX_BIN_FILE_NAME_LEN,
+				"BT_RAM_CODE_MT%04x_1_%x_hdr.bin",
+				bdev->chip_id & 0xffff, (bdev->fw_version & 0xff) + 1);
+
+	BTMTK_INFO("%s: rom patch file name is %s", __func__, bdev->rom_patch_bin_file_name);
+
+	if (is_mt7663(bdev->chip_id)) {
+		memcpy(bdev->woble_setting_file_name, WOBLE_SETTING_FILE_NAME_7663,
+			sizeof(WOBLE_SETTING_FILE_NAME_7663));
+		BTMTK_INFO("%s: woble setting file name is %s",
+			__func__, WOBLE_SETTING_FILE_NAME_7663);
+	}
+
+	if (is_mt7922(bdev->chip_id) || is_mt7961(bdev->chip_id)) {
+		memcpy(bdev->woble_setting_file_name, WOBLE_SETTING_FILE_NAME_7961,
+			sizeof(WOBLE_SETTING_FILE_NAME_7961));
+		BTMTK_INFO("%s: woble setting file name is %s",
+			__func__, WOBLE_SETTING_FILE_NAME_7961);
+	}
+
+	memcpy(bdev->bt_cfg_file_name, BT_CFG_NAME, sizeof(BT_CFG_NAME));
+	memset(bdev->bdaddr, 0, BD_ADDRESS_SIZE);
+	return 0;
+}
+
+static int btmtk_send_vendor_cfg(struct btmtk_dev *bdev)
+{
+	int ret = 0;
+	int index = 0;
+	u8 event[2] = { 0x04, 0x0E };
+
+	BTMTK_INFO("%s enter", __func__);
+
+	for (index = 0; index < VENDOR_CMD_COUNT; index++) {
+		if (bdev->bt_cfg.vendor_cmd[index].content &&
+			bdev->bt_cfg.vendor_cmd[index].length) {
+			ret = btmtk_main_send_cmd(bdev, bdev->bt_cfg.vendor_cmd[index].content,
+				bdev->bt_cfg.vendor_cmd[index].length,
+				event, sizeof(event),
+				0, 0, BTMTK_TX_PKT_FROM_HOST);
+			if (ret < 0) {
+				BTMTK_ERR("%s: Send vendor cmd failed(%d)! Index: %d",
+					__func__, ret, index);
+				goto exit;
+			}
+
+			BTMTK_INFO_RAW(bdev->bt_cfg.vendor_cmd[index].content,
+				bdev->bt_cfg.vendor_cmd[index].length, "send vendor cmd");
+		}
+	}
+
+exit:
+	BTMTK_INFO("%s exit", __func__);
+	return ret;
+}
+
+static int btmtk_send_phase1_wmt_cfg(struct btmtk_dev *bdev)
+{
+	int ret = 0;
+	int index = 0;
+	u8 event[2] = { 0x04, 0xE4 };
+
+	BTMTK_INFO("%s", __func__);
+
+	for (index = 0; index < PHASE1_WMT_CMD_COUNT; index++) {
+		if (bdev->bt_cfg.phase1_wmt_cmd[index].content &&
+			bdev->bt_cfg.phase1_wmt_cmd[index].length) {
+			ret = btmtk_main_send_cmd(bdev, bdev->bt_cfg.phase1_wmt_cmd[index].content,
+					bdev->bt_cfg.phase1_wmt_cmd[index].length,
+					event, sizeof(event),
+					20, 20, BTMTK_TX_CMD_FROM_DRV);
+			if (ret < 0) {
+				BTMTK_ERR("%s: Send phase1 wmt cmd failed(%d)! Index: %d",
+					__func__, ret, index);
+				goto exit;
+			}
+
+			BTMTK_INFO_RAW(bdev->bt_cfg.phase1_wmt_cmd[index].content,
+				bdev->bt_cfg.phase1_wmt_cmd[index].length, "send wmt cmd");
+		}
+	}
+
+exit:
+	BTMTK_INFO("%s exit", __func__);
+	return ret;
+}
+
+int btmtk_send_init_cmds(struct btmtk_dev *bdev)
+{
+	int ret = -1;
+
+	if (!bdev) {
+		BTMTK_ERR("%s: bdev is NULL !", __func__);
+		goto exit;
+	}
+
+	BTMTK_INFO("%s", __func__);
+
+#if ENABLESTP
+	btmtk_send_set_stp_cmd(bdev);
+	btmtk_send_set_stp1_cmd(bdev);
+#endif
+	ret = btmtk_calibration_flow(bdev);
+	if (ret < 0) {
+		BTMTK_ERR("%s, btmtk_calibration_flow failed!", __func__);
+		goto exit;
+	}
+	ret = btmtk_send_wmt_power_on_cmd(bdev);
+	if (ret < 0) {
+		if (bdev->power_state != BTMTK_DONGLE_STATE_POWER_ON) {
+			BTMTK_ERR("%s, btmtk_send_wmt_power_on_cmd failed!", __func__);
+			if (main_info.reset_stack_flag == HW_ERR_NONE)
+				main_info.reset_stack_flag = HW_ERR_CODE_POWER_ON;
+			/* TODO */
+			/* btmtk_usb_toggle_rst_pin(); */
+		}
+		goto exit;
+	}
+
+	ret = btmtk_send_phase1_wmt_cfg(bdev);
+	if (ret < 0) {
+		BTMTK_ERR("btmtk_send_wmt_cfg failed");
+		btmtk_send_assert_cmd(bdev);
+		goto exit;
+	}
+
+	if (bdev->bt_cfg.support_auto_picus == true) {
+		if (btmtk_picus_enable(bdev) < 0) {
+			BTMTK_ERR("send picus filter param failed");
+			btmtk_send_assert_cmd(bdev);
+			ret = -1;
+			goto exit;
+		}
+	}
+
+	ret = btmtk_send_vendor_cfg(bdev);
+	if (ret < 0) {
+		BTMTK_ERR("btmtk_send_vendor_cfg failed");
+		btmtk_send_assert_cmd(bdev);
+		goto exit;
+	}
+
+	if (is_mt7663(bdev->chip_id))
+		ret = btmtk_send_hci_tci_set_sleep_cmd_766x(bdev);
+
+exit:
+	return ret;
+}
+
+
+int btmtk_send_deinit_cmds(struct btmtk_dev *bdev)
+{
+	int ret = -1;
+
+	if (!bdev) {
+		BTMTK_ERR("%s: bdev is NULL !", __func__);
+		return ret;
+	}
+
+	BTMTK_INFO("%s", __func__);
+
+	if (bdev->bt_cfg.support_auto_picus == true) {
+		if (btmtk_picus_disable(bdev) < 0) {
+			BTMTK_ERR("send picus filter param failed");
+			btmtk_send_assert_cmd(bdev);
+			return -1;
+		}
+	}
+
+	ret = btmtk_send_wmt_power_off_cmd(bdev);
+	if (bdev->power_state != BTMTK_DONGLE_STATE_POWER_OFF) {
+		BTMTK_WARN("Power off failed, reset it");
+		if (main_info.reset_stack_flag == HW_ERR_NONE)
+			main_info.reset_stack_flag = HW_ERR_CODE_POWER_OFF;
+		btmtk_send_assert_cmd(bdev);
+	}
+
+	return ret;
+}
+
+int btmtk_send_assert_cmd(struct btmtk_dev *bdev)
+{
+	int ret = 0;
+	int state;
+	u8 buf[] = { 0x01, 0x6F, 0xFC, 0x05, 0x01, 0x02, 0x01, 0x00, 0x08 };
+	struct sk_buff *skb = NULL;
+
+	if (!bdev) {
+		BTMTK_ERR("%s, invalid parameters!", __func__);
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	state = btmtk_get_chip_state(bdev);
+	if (state == BTMTK_STATE_FW_DUMP) {
+		BTMTK_WARN("%s: FW dumping already!!!", __func__);
+		return ret;
+	}
+
+	BTMTK_INFO("%s: send assert cmd", __func__);
+
+	skb = alloc_skb(sizeof(buf) + BT_SKB_RESERVE, GFP_ATOMIC);
+	if (!skb) {
+		BTMTK_ERR("%s allocate skb failed!!", __func__);
+		goto exit;
+	}
+	bt_cb(skb)->pkt_type = HCI_COMMAND_PKT;
+	memcpy(skb->data, buf, sizeof(buf));
+	skb->len = sizeof(buf);
+
+	ret = main_info.hif_hook.send_cmd(bdev, skb, 100, 20, (int)BTMTK_TX_CMD_FROM_DRV);
+	if (ret < 0)
+		BTMTK_ERR("%s failed!!", __func__);
+	else
+		BTMTK_INFO("%s: OK", __func__);
+
+exit:
+	return ret;
+}
+
+static int btmtk_send_txpower_cmd(struct btmtk_dev *bdev)
+{
+	/**
+	 *  TCI Set TX Power Command
+	 *  01 2C FC 0C QQ 00 00 00 XX YY ZZ GG AA BB CC DD
+	 *  QQ: EDR init TX power dbm // the value is equal to EDR MAX
+	 *  XX: BLE TX power dbm
+	 *  YY: EDR MAX TX power dbm
+	 *  ZZ: Enable LV9
+	 *  GG: 3db diff mode
+	 *  AA: [5:4] Indicator // [5] 1: command send to BT1, [4] 1: command send to BT0
+	 *      [3:0] Resolution // 0: 1dBm, 1: 0.5dBm, 2: 0.25dBm
+	 *  BB: BLE 2M
+	 *  CC: BLE S2
+	 *  DD: BLE S8
+	 */
+
+	u8 cmd[] = { 0x01, 0x2C, 0xFC, 0x0C, 0x00, 0x00, 0x00, 0x00,
+			0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 };
+	u8 event[] = { 0x04, 0x0E, 0x04, 0x01, 0x2C, 0xFC, 0x00 };
+	int ret = 0;
+
+	cmd[4] = (u8)main_info.PWS.EDR_Max;
+	cmd[8] = (u8)main_info.PWS.BLE_1M;
+	cmd[9] = (u8)main_info.PWS.EDR_Max;
+	cmd[10] = (u8)main_info.PWS.LV9;
+	cmd[11] = (u8)main_info.PWS.DM;
+	cmd[12] = (u8)main_info.PWS.IR;
+	cmd[13] = (u8)main_info.PWS.BLE_2M;
+	cmd[14] = (u8)main_info.PWS.BLE_LR_S2;
+	cmd[15] = (u8)main_info.PWS.BLE_LR_S8;
+
+	ret = btmtk_main_send_cmd(bdev, cmd, sizeof(cmd), event, sizeof(event), 0, 0,
+			BTMTK_TX_CMD_FROM_DRV);
+
+	if (ret < 0)
+		BTMTK_ERR("%s failed!!", __func__);
+	else
+		BTMTK_INFO("%s: OK", __func__);
+
+	return ret;
+}
+
+static int btmtk_set_power_value(char *str, int resolution, int is_edr)
+{
+	int power = ERR_PWR, integer = 0, decimal = 0, ret;
+
+	if (resolution == RES_DOT_25) {
+		/* XX.YY => XX.YY/0.25 = XX*4 + YY/25 */
+		if (strstr(str, ".")) {
+			ret = sscanf(str, "%d.%d", &integer, &decimal);
+			if (ret != 2)
+				return ERR_PWR;
+			if (decimal != 25 && decimal != 75 && decimal != 5 && decimal != 50)
+				return ERR_PWR;
+			if (decimal == 5)
+				decimal = 50;
+			if (integer >= 0)
+				power = integer * 4 + decimal / 25;
+			else
+				power = integer * 4 - decimal / 25;
+		} else {
+			kstrtoint(str, 0, &integer);
+			power = integer * 4;
+		}
+
+		BTMTK_DBG("%s: power = %d", __func__, power);
+
+		if (is_edr) {
+			if (power > EDR_MAX_R2 || power < EDR_MIN_R2)
+				return ERR_PWR;
+			if (power >= EDR_MIN_LV9_R2)
+				main_info.PWS.LV9 = 1;
+		} else if (!is_edr && (power > BLE_MAX_R2 || power < BLE_MIN_R2)) {
+			return ERR_PWR;
+		}
+	} else if (resolution == RES_DOT_5) {
+		/* XX.YY => XX.YY/0.5 = XX*2 + YY/5 */
+		if (strstr(str, ".")) {
+			ret = sscanf(str, "%d.%d", &integer, &decimal);
+			if (ret != 2)
+				return ERR_PWR;
+			if (decimal != 5)
+				return ERR_PWR;
+			if (integer >= 0)
+				power = integer * 2 + decimal / 5;
+			if (integer < 0)
+				power = integer * 2 - decimal / 5;
+		} else {
+			kstrtoint(str, 0, &integer);
+			power = integer * 2;
+		}
+
+		BTMTK_DBG("%s: power = %d", __func__, power);
+
+		if (is_edr) {
+			if (power > EDR_MAX_R1 || power < EDR_MIN_R1)
+				return ERR_PWR;
+			if (power >= EDR_MIN_LV9_R1)
+				main_info.PWS.LV9 = 1;
+		} else if (!is_edr && (power > BLE_MAX_R1 || power < BLE_MIN_R1)) {
+			return ERR_PWR;
+		}
+	} else if (resolution == RES_1) {
+		kstrtoint(str, 0, &power);
+		BTMTK_DBG("%s: power = %d", __func__, power);
+
+		if (is_edr) {
+			if (power > EDR_MAX || power < EDR_MIN)
+				return ERR_PWR;
+			if (power >= EDR_MIN_LV9)
+				main_info.PWS.LV9 = 1;
+		} else if (!is_edr && (power > BLE_MAX || power < BLE_MIN)) {
+			return ERR_PWR;
+		}
+	}
+
+	return power;
+}
+
+static int btmtk_check_power_resolution(char *str)
+{
+	if (!str)
+		return -1;
+	if (strstr(str, ".25") || strstr(str, ".75"))
+		return RES_DOT_25;
+	if (strstr(str, ".5"))
+		return RES_DOT_5;
+	if (!strstr(str, ".") || strstr(str, ".0"))
+		return RES_1;
+	return -1;
+}
+
+static void btmtk_init_power_setting_struct(void)
+{
+	main_info.PWS.BLE_1M = 0;
+	main_info.PWS.EDR_Max = 0;
+	main_info.PWS.LV9 = 0;
+	main_info.PWS.DM = 0;
+	main_info.PWS.IR = 0;
+	main_info.PWS.BLE_2M = 0;
+	main_info.PWS.BLE_LR_S2 = 0;
+	main_info.PWS.BLE_LR_S8 = 0;
+}
+
+static int btmtk_parse_power_table(char *context)
+{
+	char *ptr = NULL;
+	int step = 0, temp;
+	int resolution;
+	int power;
+
+	if (!context) {
+		BTMTK_ERR("%s context is NULL", __func__);
+		return -1;
+	}
+
+	BTMTK_INFO("%s", __func__);
+	btmtk_init_power_setting_struct();
+
+	/* Send to BT0? BT1? */
+	if (strstr(context, "BT0")) {
+		BTMTK_INFO("Parse power for BT0");
+		main_info.PWS.IR |= 0x10;
+		context += strlen("[BT0]");
+	} else if (strstr(context, "BT1")) {
+		BTMTK_INFO("Parse power for BT1");
+		main_info.PWS.IR |= 0x20;
+		context += strlen("[BT1]");
+	} else {
+		BTMTK_ERR("%s BT indicator error", __func__);
+		return -1;
+	}
+
+	resolution = btmtk_check_power_resolution(context);
+	if (resolution == -1) {
+		BTMTK_ERR("Check resolution fail");
+		return -1;
+	}
+
+	main_info.PWS.IR |= resolution;
+	BTMTK_INFO("%s: resolution = %d", __func__, resolution);
+
+	while ((ptr = strsep(&context, ",")) != NULL) {
+		while (*ptr == '\t' || *ptr == ' ')
+			ptr++;
+
+		switch (step) {
+		/* BR_EDR_PWR_MODE */
+		case CHECK_SINGLE_SKU_PWR_MODE:
+			if (kstrtoint(ptr, 0, &temp) == 0) {
+				if (temp == 0 || temp == 1) {
+					main_info.PWS.DM = temp;
+					step++;
+					continue;
+				} else {
+					BTMTK_ERR("PWR MODE value wrong");
+					return -1;
+				}
+			} else {
+				BTMTK_ERR("Read PWR MODE Fail");
+				return -1;
+			}
+			break;
+		/* Parse EDR MAX */
+		case CHECK_SINGLE_SKU_EDR_MAX:
+			power = btmtk_set_power_value(ptr, resolution, 1);
+			if (power == ERR_PWR) {
+				BTMTK_ERR("EDR MAX value wrong");
+				return -1;
+			}
+			main_info.PWS.EDR_Max = power;
+			step++;
+			break;
+		/* Parse BLE Default */
+		case CHECK_SINGLE_SKU_BLE:
+			power = btmtk_set_power_value(ptr, resolution, 0);
+			if (power == ERR_PWR) {
+				BTMTK_ERR("BLE value wrong");
+				return -1;
+			}
+			main_info.PWS.BLE_1M = power;
+			step++;
+			break;
+		/* Parse BLE 2M */
+		case CHECK_SINGLE_SKU_BLE_2M:
+			power = btmtk_set_power_value(ptr, resolution, 0);
+			if (power == ERR_PWR) {
+				BTMTK_ERR("BLE 2M value wrong");
+				return -1;
+			}
+			main_info.PWS.BLE_2M = power;
+			step++;
+			break;
+		/* Parse BLE long range S2 */
+		case CHECK_SINGLE_SKU_BLE_LR_S2:
+			power = btmtk_set_power_value(ptr, resolution, 0);
+			if (power == ERR_PWR) {
+				BTMTK_ERR("BLE LR S2 value wrong");
+				return -1;
+			}
+			main_info.PWS.BLE_LR_S2 = power;
+			step++;
+			break;
+		/* Parse BLE long range S8 */
+		case CHECK_SINGLE_SKU_BLE_LR_S8:
+			power = btmtk_set_power_value(ptr, resolution, 0);
+			if (power == ERR_PWR) {
+				BTMTK_ERR("BLE LR S8 value wrong");
+				return -1;
+			}
+			main_info.PWS.BLE_LR_S8 = power;
+			step++;
+			break;
+		default:
+			BTMTK_ERR("%s step is wrong: %d", __func__, step);
+			break;
+		}
+		continue;
+	}
+
+	return step;
+}
+
+static void btmtk_send_txpower_cmd_to_all_interface(void)
+{
+	int i, ret;
+	struct btmtk_dev *bdev = NULL;
+
+	for (i = 0; i < btmtk_intf_num; i++) {
+		if (g_bdev[i]->hdev) {
+			bdev = g_bdev[i];
+			BTMTK_INFO("send to %d", i);
+			ret = btmtk_send_txpower_cmd(bdev);
+			if (ret < 0)
+				BTMTK_ERR("Device %d send txpower cmd fail", i);
+		}
+	}
+}
+
+static void btmtk_requset_country_cb(const struct firmware *fw, void *context)
+{
+	char *ptr, *data, *p_data = NULL;
+	char *country = NULL;
+	int ret = 0;
+	bool find_country = false;
+	bool read_next = false;
+
+	if (!fw) {
+		BTMTK_ERR("fw is NULL");
+		return;
+	}
+
+	BTMTK_INFO("%s request %s success", __func__, DEFAULT_COUNTRY_TABLE_NAME);
+	data = kzalloc(fw->size, GFP_KERNEL);
+	p_data = data;
+	if (!data) {
+		BTMTK_WARN("%s allocate memory fail (data)", __func__);
+		goto exit;
+	}
+
+	memcpy(data, fw->data, fw->size);
+	while ((ptr = strsep(&p_data, "\n")) != NULL) {
+		/* If the '#' in front of the line, ignore this line */
+		if (*ptr == '#')
+			continue;
+
+		/* Set power for BT1 */
+		if (read_next) {
+			if (strncmp(ptr, "[BT1]", 5) == 0) {
+				ret = btmtk_parse_power_table(ptr);
+				if (ret != CHECK_SINGLE_SKU_ALL) {
+					BTMTK_ERR("Parse power fail, ret = %d", ret);
+					break;
+				}
+
+				btmtk_send_txpower_cmd_to_all_interface();
+			} else {
+				BTMTK_INFO("No power data for BT1");
+			}
+			break;
+		}
+
+		if (find_country) {
+			ret = btmtk_parse_power_table(ptr);
+			/* Check if the next line has power value for BT1 */
+			read_next = true;
+			if (ret != CHECK_SINGLE_SKU_ALL) {
+				BTMTK_ERR("Parse power fail, ret = %d", ret);
+				continue;
+			}
+
+			btmtk_send_txpower_cmd_to_all_interface();
+			continue;
+		}
+
+		while ((country = strsep(&ptr, ",[]")) != NULL) {
+			if (strlen(country) != COUNTRY_CODE_LEN)
+				continue;
+			if (strcmp(country, main_info.PWS.country_code) == 0) {
+				find_country = true;
+				break;
+			}
+		}
+	}
+	kfree(data);
+
+	if (!find_country)
+		BTMTK_ERR("Can't find country in the table");
+
+exit:
+	release_firmware(fw);
+}
+
+static int btmtk_load_country_table(void)
+{
+	int err = 0;
+
+	err = request_firmware_nowait(THIS_MODULE, true, DEFAULT_COUNTRY_TABLE_NAME,
+				      NULL, GFP_KERNEL, NULL, btmtk_requset_country_cb);
+
+	return err;
+}
+
+void btmtk_set_country_code_from_wifi(char *code)
+{
+	int i;
+	struct btmtk_dev *bdev = NULL;
+
+	if (!code)
+		return;
+
+	if (strlen(code) == COUNTRY_CODE_LEN) {
+		BTMTK_INFO("%s country code is %s", __func__, code);
+		memcpy(main_info.PWS.country_code, code, sizeof(main_info.PWS.country_code));
+		for (i = 0; i < btmtk_intf_num; i++) {
+			if (!g_bdev[i]->hdev) {
+				bdev = g_bdev[i];
+				if (bdev->bt_cfg.support_bt_single_sku) {
+					btmtk_load_country_table();
+					break;
+				}
+			}
+		}
+	} else {
+		BTMTK_INFO("%s country code is not valid", __func__);
+	}
+}
+EXPORT_SYMBOL_GPL(btmtk_set_country_code_from_wifi);
+
+int btmtk_fops_init(void)
+{
+	static int BT_majorfwlog;
+	dev_t dev_ID_fwlog = MKDEV(BT_majorfwlog, 0);
+	int ret = 0;
+	int cdev_err = 0;
+	int majorfwlog = 0;
+
+	BTMTK_INFO("%s: Start", __func__);
+
+	if (!g_fwlog) {
+		g_fwlog = kzalloc(sizeof(*g_fwlog), GFP_KERNEL);
+		if (!g_fwlog) {
+			BTMTK_ERR("%s: alloc memory fail (g_data)", __func__);
+			return -1;
+		}
+	}
+
+	BTMTK_INFO("%s: g_fwlog init", __func__);
+	spin_lock_init(&g_fwlog->fwlog_lock);
+	skb_queue_head_init(&g_fwlog->fwlog_queue);
+	init_waitqueue_head(&(g_fwlog->fw_log_inq));
+
+	ret = alloc_chrdev_region(&dev_ID_fwlog, 0, 1, BT_CHR_DEV);
+	if (ret) {
+		BT_ERR("%s: fail to allocate chrdev", __func__);
+		return ret;
+	}
+
+	BT_majorfwlog = majorfwlog = MAJOR(dev_ID_fwlog);
+
+	cdev_init(&g_fwlog->BT_cdevfwlog, &BT_fopsfwlog);
+	g_fwlog->BT_cdevfwlog.owner = THIS_MODULE;
+
+	cdev_err = cdev_add(&g_fwlog->BT_cdevfwlog, dev_ID_fwlog, 1);
+	if (cdev_err)
+		goto error;
+
+	g_fwlog->pBTClass = class_create(THIS_MODULE, BT_CHR_DEV);
+	if (IS_ERR(g_fwlog->pBTClass)) {
+		BT_ERR("%s: class create fail, error code(%ld)\n",
+		       __func__, PTR_ERR(g_fwlog->pBTClass));
+		goto err1;
+	}
+
+	g_fwlog->pBTDevfwlog = device_create(g_fwlog->pBTClass,
+			NULL, dev_ID_fwlog, NULL, BT_DEV_NODE);
+	if (IS_ERR(g_fwlog->pBTDevfwlog)) {
+		BT_ERR("%s: device(stpbtfwlog) create fail, error code(%ld)",
+		       __func__, PTR_ERR(g_fwlog->pBTDevfwlog));
+		goto error;
+	}
+	BT_INFO("%s: BT_majorfwlog %d, dev_ID_fwlog %d", __func__, BT_majorfwlog, dev_ID_fwlog);
+
+	g_fwlog->g_devIDfwlog = dev_ID_fwlog;
+
+	return 0;
+
+err1:
+	if (g_fwlog->pBTClass) {
+		class_destroy(g_fwlog->pBTClass);
+		g_fwlog->pBTClass = NULL;
+	}
+
+error:
+	if (cdev_err == 0)
+		cdev_del(&g_fwlog->BT_cdevfwlog);
+
+	if (ret == 0)
+		unregister_chrdev_region(dev_ID_fwlog, 1);
+
+	return -1;
+}
+
+int btmtk_fops_exit(void)
+{
+	dev_t devIDfwlog = g_fwlog->g_devIDfwlog;
+
+	BT_INFO("%s: Start\n", __func__);
+	if (g_fwlog->pBTDevfwlog) {
+		device_destroy(g_fwlog->pBTClass, devIDfwlog);
+		g_fwlog->pBTDevfwlog = NULL;
+	}
+
+	if (g_fwlog->pBTClass) {
+		class_destroy(g_fwlog->pBTClass);
+		g_fwlog->pBTClass = NULL;
+	}
+	BT_INFO("%s: pBTDevfwlog, pBTClass done\n", __func__);
+	cdev_del(&g_fwlog->BT_cdevfwlog);
+	unregister_chrdev_region(devIDfwlog, 1);
+	BT_INFO("%s: BT_chrdevfwlog driver removed.\n", __func__);
+	kfree(g_fwlog);
+
+	return 0;
+}
+
+/**
+ * Kernel HCI Interface Registration
+ */
+static int bt_flush(struct hci_dev *hdev)
+{
+	return 0;
+}
+
+static int bt_close(struct hci_dev *hdev)
+{
+	int ret = -1;
+	int state = BTMTK_STATE_INIT;
+	int fstate = BTMTK_FOPS_STATE_INIT;
+	struct btmtk_dev *bdev = NULL;
+
+	if (!hdev) {
+		BTMTK_ERR("%s: invalid parameters!", __func__);
+		return ret;
+	}
+
+	bdev = hci_get_drvdata(hdev);
+	if (!bdev) {
+		BTMTK_ERR("%s: bdev is invalid!", __func__);
+		return ret;
+	}
+
+	fstate = btmtk_fops_get_state(bdev);
+	if (fstate != BTMTK_FOPS_STATE_OPENED) {
+		BTMTK_WARN("%s: fops is not allow close(%d)", __func__, fstate);
+		goto err;
+	}
+	btmtk_fops_set_state(bdev, BTMTK_FOPS_STATE_CLOSING);
+
+	state = btmtk_get_chip_state(bdev);
+	if (state != BTMTK_STATE_WORKING && state != BTMTK_STATE_STANDBY) {
+		BTMTK_WARN("%s: not in working state and standby state(%d).", __func__, state);
+		goto exit;
+	}
+
+	BTMTK_INFO("%s, enter", __func__);
+
+	if (main_info.hif_hook.cif_mutex_lock)
+		main_info.hif_hook.cif_mutex_lock(bdev);
+
+#if CFG_SUPPORT_DVT
+	/* Don't send init cmd for DVT
+	 * Such as Lowpower DVT
+	 */
+	bdev->power_state = BTMTK_DONGLE_STATE_POWER_OFF;
+#else
+	if (state != BTMTK_STATE_STANDBY) {
+		ret = btmtk_send_deinit_cmds(bdev);
+		if (ret < 0) {
+			BTMTK_ERR("%s, btmtk_send_deinit_cmds failed", __func__);
+			goto unlock;
+		}
+	}
+#endif /* CFG_SUPPORT_DVT */
+
+	/* Flush RX works */
+	flush_work(&bdev->rx_work);
+
+	/* Drop queues */
+	skb_queue_purge(&bdev->rx_q);
+
+	main_info.hif_hook.close(hdev);
+
+unlock:
+	if (main_info.hif_hook.cif_mutex_unlock)
+		main_info.hif_hook.cif_mutex_unlock(bdev);
+exit:
+	btmtk_fops_set_state(bdev, BTMTK_FOPS_STATE_CLOSED);
+
+err:
+	main_info.reset_stack_flag = HW_ERR_NONE;
+
+	BTMTK_INFO("%s: end, reset_stack_flag = %d", __func__, main_info.reset_stack_flag);
+	return 0;
+}
+
+static int bt_open(struct hci_dev *hdev)
+{
+	int ret = -1;
+	int state = BTMTK_STATE_INIT;
+	int fstate = BTMTK_FOPS_STATE_INIT;
+	struct btmtk_dev *bdev = NULL;
+	void (*rlm_get_alpha2)(char *code);
+	const char *wifi_func_name = "rlm_get_alpha2";
+	char alpha2[5];
+
+	BTMTK_INFO("%s: MTK BT Driver Version : %s", __func__, VERSION);
+
+	if (!hdev) {
+		BTMTK_ERR("%s: invalid parameters!", __func__);
+		return -EFAULT;
+	}
+
+	bdev = hci_get_drvdata(hdev);
+	if (!bdev) {
+		BTMTK_ERR("%s: bdev is invalid", __func__);
+		return -EFAULT;
+	}
+
+	state = btmtk_get_chip_state(bdev);
+	if (state == BTMTK_STATE_INIT || state == BTMTK_STATE_DISCONNECT) {
+		ret = -EAGAIN;
+		goto failed;
+	}
+
+	if (state != BTMTK_STATE_WORKING && state != BTMTK_STATE_STANDBY) {
+		BTMTK_WARN("%s: not in working state and standby state(%d).", __func__, state);
+		ret = -ENODEV;
+		goto failed;
+	}
+
+	fstate = btmtk_fops_get_state(bdev);
+	if (fstate == BTMTK_FOPS_STATE_OPENED) {
+		BTMTK_WARN("%s: fops opened!", __func__);
+		ret = 0;
+		goto failed;
+	}
+
+	if (fstate == BTMTK_FOPS_STATE_CLOSING || fstate == BTMTK_FOPS_STATE_OPENING) {
+		BTMTK_WARN("%s: fops open/close is on-going !", __func__);
+		ret = -EAGAIN;
+		goto failed;
+	}
+
+	BTMTK_INFO("%s", __func__);
+	btmtk_fops_set_state(bdev, BTMTK_FOPS_STATE_OPENING);
+	ret = main_info.hif_hook.open(hdev);
+	if (ret < 0) {
+		BTMTK_ERR("%s, cif_open failed", __func__);
+		goto failed;
+	}
+
+#if CFG_SUPPORT_DVT
+	/* Don't send init cmd for DVT
+	 * Such as Lowpower DVT
+	 */
+	bdev->power_state = BTMTK_DONGLE_STATE_POWER_ON;
+#else
+	ret = btmtk_send_init_cmds(bdev);
+	if (ret < 0) {
+		BTMTK_ERR("%s, btmtk_send_init_cmds failed", __func__);
+		goto failed;
+	}
+#endif /* CFG_SUPPORT_DVT */
+
+	if (main_info.hif_hook.open_done)
+		main_info.hif_hook.open_done(bdev);
+
+	btmtk_fops_set_state(bdev, BTMTK_FOPS_STATE_OPENED);
+	main_info.reset_stack_flag = HW_ERR_NONE;
+
+	if (bdev->bt_cfg.support_bt_single_sku) {
+		rlm_get_alpha2 = (void *)kallsyms_lookup_name(wifi_func_name);
+
+		if (rlm_get_alpha2) {
+			rlm_get_alpha2(alpha2);
+			if (strlen(alpha2) == COUNTRY_CODE_LEN) {
+				BTMTK_INFO("Wifi set country code %s", alpha2);
+				memcpy(main_info.PWS.country_code, alpha2,
+				       sizeof(main_info.PWS.country_code));
+			} else {
+				BTMTK_ERR("Country code length is wrong");
+			}
+		} else {
+			BTMTK_INFO("Wifi didn't set country code");
+		}
+
+		if (strcmp(main_info.PWS.country_code, "") != 0)
+			btmtk_load_country_table();
+	}
+
+	return 0;
+
+failed:
+	btmtk_fops_set_state(bdev, BTMTK_FOPS_STATE_CLOSED);
+
+	return ret;
+}
+
+static int bt_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	int ret = -1;
+	int state = BTMTK_STATE_INIT;
+	int fstate = BTMTK_FOPS_STATE_INIT;
+	/* parsing commands */
+	u8 fw_assert_cmd[] = { 0x01, 0x5B, 0xFD, 0x00 };
+	u8 reset_cmd[] = { 0x01, 0x03, 0x0C, 0x00 };
+	struct btmtk_dev *bdev = NULL;
+
+	if (!hdev || !skb) {
+		BTMTK_ERR("%s, invalid parameters!", __func__);
+		return -ENODEV;
+	}
+
+	bdev = hci_get_drvdata(hdev);
+	if (!bdev) {
+		BTMTK_ERR("%s, bdev is invalid!", __func__);
+		return -ENODEV;
+	}
+
+	fstate = btmtk_fops_get_state(bdev);
+	if (fstate != BTMTK_FOPS_STATE_OPENED) {
+		BTMTK_WARN("%s: fops is not open yet(%d)!", __func__, fstate);
+		ret = -ENODEV;
+		goto exit;
+	}
+
+	state = btmtk_get_chip_state(bdev);
+	if (state != BTMTK_STATE_WORKING) {
+		BTMTK_WARN("%s: chip state is %d.", __func__, state);
+		if (state == BTMTK_STATE_DISCONNECT) {
+			ret = -ENODEV;
+		} else {
+			msleep(3000);
+			ret = -EAGAIN;
+		}
+		goto exit;
+	}
+
+	if (bdev->power_state == BTMTK_DONGLE_STATE_POWER_OFF) {
+		BTMTK_WARN("%s: dongle state already power off, do not write", __func__);
+		ret = -EFAULT;
+		goto exit;
+	}
+
+	if (main_info.reset_stack_flag) {
+		BTMTK_WARN("%s: reset_stack_flag (%d)!", __func__, main_info.reset_stack_flag);
+		ret = -EFAULT;
+		goto exit;
+	}
+
+	btmtk_dispatch_data_bluetooth_kpi(hdev, skb->data, skb->len, hci_skb_pkt_type(skb));
+	memcpy(skb_push(skb, 1), &hci_skb_pkt_type(skb), 1);
+#if ENABLESTP
+	skb = mtk_add_stp(bdev, skb);
+#endif
+
+	/* For Ble ISO packet size */
+	if (memcmp(skb->data, READ_ISO_PACKET_SIZE_CMD, sizeof(READ_ISO_PACKET_SIZE_CMD)) == 0) {
+		bdev->iso_threshold = skb->data[sizeof(READ_ISO_PACKET_SIZE_CMD)] +
+				      (skb->data[sizeof(READ_ISO_PACKET_SIZE_CMD) + 1]  << 8);
+		BTMTK_INFO("%s: Ble iso pkt size is %d", __func__, bdev->iso_threshold);
+	}
+
+	if (hci_skb_pkt_type(skb) == HCI_COMMAND_PKT) {
+		/* save hci cmd pkt for debug */
+		btmtk_hci_snoop_save_cmd(skb->len, skb->data);
+		if (skb->len == sizeof(fw_assert_cmd) &&
+			!memcmp(skb->data, fw_assert_cmd, sizeof(fw_assert_cmd))) {
+			BTMTK_INFO("%s: Dongle FW Assert Triggered by BT Stack!", __func__);
+			btmtk_hci_snoop_print_to_log();
+		} else if (skb->len == sizeof(reset_cmd) &&
+				!memcmp(skb->data, reset_cmd, sizeof(reset_cmd)))
+			BTMTK_INFO("%s: got command: 0x03 0C 00 (HCI_RESET)", __func__);
+	}
+
+	ret = main_info.hif_hook.send_cmd(bdev, skb, 0, 0, (int)BTMTK_TX_PKT_FROM_HOST);
+	if (ret < 0)
+		BTMTK_ERR("%s failed!!", __func__);
+exit:
+	return ret;
+}
+
+static int bt_setup(struct hci_dev *hdev)
+{
+	BTMTK_INFO("%s", __func__);
+	return 0;
+}
+
+void btmtk_reg_hif_hook(struct hif_hook_ptr *hook)
+{
+	memcpy(&main_info.hif_hook, hook, sizeof(struct hif_hook_ptr));
+}
+
+void btmtk_reset_waker(struct work_struct *work)
+{
+	struct btmtk_dev *bdev = container_of(work, struct btmtk_dev, reset_waker);
+	struct btmtk_cif_state *cif_state = NULL;
+	int cif_event = 0, err = 0;
+
+	cif_event = HIF_EVENT_SUBSYS_RESET;
+	if (BTMTK_CIF_IS_NULL(bdev, cif_event)) {
+		/* Error */
+		BTMTK_WARN("%s priv setting is NULL", __func__);
+		goto Finish;
+	}
+
+	while (!bdev->bt_cfg.support_dongle_reset) {
+		BTMTK_ERR("%s chip_reset is not support", __func__);
+		msleep(2000);
+	}
+
+	cif_state = &bdev->cif_state[cif_event];
+
+	/* Set Entering state */
+	btmtk_set_chip_state((void *)bdev, cif_state->ops_enter);
+
+	BTMTK_INFO("%s: Receive a byte (0xFF)", __func__);
+	/* read interrupt EP15 CR */
+
+	bdev->subsys_reset = 1;
+	bdev->sco_num = 0;
+
+	if (whole_reset_flag == 0) {
+		if (main_info.hif_hook.subsys_reset)
+			err = main_info.hif_hook.subsys_reset(bdev);
+		else
+			BTMTK_INFO("%s: Not support subsys chip reset", __func__);
+	} else {
+		err = -1;
+		BTMTK_INFO("%s: whole_reset_flag is %d", __func__, whole_reset_flag);
+	}
+
+	if (err) {
+		/* L0.5 reset failed, do whole chip reset */
+		/* We will add support dongle reset flag, reading from bt.cfg */
+		bdev->subsys_reset = 0;
+		/* TODO: need to confirm with usb host when suspend fail, to do chip reset,
+		 * because usb3.0 need to toggle reset pin after hub_event unfreeze,
+		 * otherwise, it will not occur disconnect on Capy Platform. When Mstar
+		 * chip has usb3.0 port, we will use Mstar platform to do comparison
+		 * test, then found the final solution.
+		 */
+		//msleep(2000);
+		if (main_info.hif_hook.whole_reset)
+			main_info.hif_hook.whole_reset(bdev);
+		else
+			BTMTK_INFO("%s: Not support whole chip reset", __func__);
+		whole_reset_flag = 0;
+		goto Finish;
+	}
+
+	main_info.reset_stack_flag = HW_ERR_CODE_CHIP_RESET;
+	bdev->subsys_reset = 0;
+
+	err = btmtk_cap_init(bdev);
+	if (err < 0) {
+		BTMTK_ERR("btmtk init failed!");
+		goto Finish;
+	}
+
+	err = btmtk_load_rom_patch(bdev);
+	if (err < 0) {
+		BTMTK_ERR("btmtk load rom patch failed!");
+		goto Finish;
+	}
+	btmtk_send_hw_err_to_host(bdev);
+	btmtk_woble_wake_unlock(bdev);
+
+Finish:
+	main_info.hif_hook.chip_reset_notify(bdev);
+
+	/* Set End/Error state */
+	if (err < 0)
+		btmtk_set_chip_state((void *)bdev, cif_state->ops_error);
+	else
+		btmtk_set_chip_state((void *)bdev, cif_state->ops_end);
+}
+
+static void btmtk_rx_work(struct work_struct *work)
+{
+	int err = 0, skip_pkt = 0;
+	struct btmtk_dev *bdev = container_of(work, struct btmtk_dev, rx_work);
+	struct sk_buff *skb;
+	int fstate = BTMTK_FOPS_STATE_INIT;
+	int state = 0;
+
+	BTMTK_DBG("%s enter", __func__);
+
+	while ((skb = skb_dequeue(&bdev->rx_q))) {
+		/* BTMTK_DBG_RAW(skb->data, skb->len, "%s, recv evt", __func__); */
+		skip_pkt = btmtk_dispatch_pkt(bdev->hdev, skb);
+		if (skip_pkt != 0) {
+			/* kfree_skb should be moved to btmtk_dispach_pkt */
+			kfree_skb(skb);
+			continue;
+		}
+
+		if (hci_skb_pkt_type(skb) == HCI_EVENT_PKT) {
+			/* save hci evt pkt for debug */
+			if (skb->data[0] == 0x3E)
+				btmtk_hci_snoop_save_adv_event(skb->len, skb->data);
+			else
+				btmtk_hci_snoop_save_event(skb->len, skb->data);
+
+			if (main_info.hif_hook.event_filter(bdev, skb)) {
+				/* Drop by driver, don't send to stack */
+				kfree_skb(skb);
+				continue;
+			}
+		} else if (hci_skb_pkt_type(skb) == HCI_ACLDATA_PKT) {
+			/* save hci acl pkt for debug, not include picus log and coredump*/
+			btmtk_hci_snoop_save_acl(skb->len, skb->data);
+		}
+
+		fstate = btmtk_fops_get_state(bdev);
+		if (fstate != BTMTK_FOPS_STATE_OPENED) {
+			/* BT close case, drop by driver, don't send to stack */
+			kfree_skb(skb);
+			continue;
+		}
+
+		/* for bluetooth kpi */
+		btmtk_dispatch_data_bluetooth_kpi(bdev->hdev, skb->data,
+						  skb->len, hci_skb_pkt_type(skb));
+
+		/* Can't send to stack when is not WORKING */
+		state = btmtk_get_chip_state(bdev);
+		if (state != BTMTK_STATE_WORKING) {
+			kfree_skb(skb);
+			continue;
+		}
+
+		err = hci_recv_frame(bdev->hdev, skb);
+		if (err < 0) {
+			if (err != -ENXIO)
+				BTMTK_ERR("%s, err = %d", __func__, err);
+			return;
+		}
+	}
+}
+
+static irqreturn_t btmtk_woble_isr(int irq, struct btmtk_dev *bdev)
+{
+#define WAIT_POWERKEY_TIMEOUT 5000
+	BTMTK_DBG("%s begin", __func__);
+	disable_irq_nosync(bdev->wobt_irq);
+	atomic_dec(&(bdev->irq_enable_count));
+	BTMTK_INFO("disable BT IRQ, call wake lock");
+	__pm_wakeup_event(main_info.eint_ws, WAIT_POWERKEY_TIMEOUT);
+
+	input_report_key(bdev->WoBLEInputDev, KEY_WAKEUP, 1);
+	input_sync(bdev->WoBLEInputDev);
+	input_report_key(bdev->WoBLEInputDev, KEY_WAKEUP, 0);
+	input_sync(bdev->WoBLEInputDev);
+	BTMTK_DBG("%s end", __func__);
+	return IRQ_HANDLED;
+}
+
+static int btmtk_RegisterBTIrq(struct btmtk_dev *bdev)
+{
+	struct device_node *eint_node = NULL;
+	int interrupts[2];
+
+	BTMTK_DBG("%s begin", __func__);
+	eint_node = of_find_compatible_node(NULL, NULL, "mediatek,woble_eint");
+	if (eint_node) {
+		BTMTK_INFO("Get woble_eint compatible node");
+		bdev->wobt_irq = irq_of_parse_and_map(eint_node, 0);
+		BTMTK_INFO("woble_irq number:%d", bdev->wobt_irq);
+		if (bdev->wobt_irq) {
+			of_property_read_u32_array(eint_node, "interrupts",
+						   interrupts, ARRAY_SIZE(interrupts));
+			bdev->wobt_irqlevel = interrupts[1];
+			if (request_irq(bdev->wobt_irq, (void *)btmtk_woble_isr,
+					bdev->wobt_irqlevel, "woble-eint", bdev))
+				BTMTK_INFO("WOBTIRQ LINE NOT AVAILABLE!!");
+			else {
+				BTMTK_INFO("disable BT IRQ");
+				disable_irq_nosync(bdev->wobt_irq);
+			}
+
+		} else
+			BTMTK_INFO("can't find woble_eint irq");
+
+	} else {
+		bdev->wobt_irq = 0;
+		BTMTK_INFO("can't find woble_eint compatible node");
+	}
+
+	BTMTK_DBG("%s end", __func__);
+	return 0;
+}
+
+static int btmtk_woble_input_init(struct btmtk_dev *bdev)
+{
+	int ret = 0;
+
+	bdev->WoBLEInputDev = input_allocate_device();
+	if (IS_ERR(bdev->WoBLEInputDev)) {
+		BTMTK_ERR("input_allocate_device error");
+		return -ENOMEM;
+	}
+
+	bdev->WoBLEInputDev->name = "WOBLE_INPUT_DEVICE";
+	bdev->WoBLEInputDev->id.bustype = BUS_HOST;
+	bdev->WoBLEInputDev->id.vendor = 0x0002;
+	bdev->WoBLEInputDev->id.product = 0x0002;
+	bdev->WoBLEInputDev->id.version = 0x0002;
+
+	__set_bit(EV_KEY, bdev->WoBLEInputDev->evbit);
+	__set_bit(KEY_WAKEUP, bdev->WoBLEInputDev->keybit);
+
+	ret = input_register_device(bdev->WoBLEInputDev);
+	if (ret < 0) {
+		input_free_device(bdev->WoBLEInputDev);
+		BTMTK_ERR("input_register_device %d", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+void btmtk_free_hci_device(struct btmtk_dev *bdev, int hci_bus_type)
+{
+	int fstate = BTMTK_FOPS_STATE_INIT;
+
+	if (!bdev)
+		return;
+
+	/* Flush RX works */
+	flush_work(&bdev->rx_work);
+
+	/* Drop queues */
+	skb_queue_purge(&bdev->rx_q);
+	destroy_workqueue(bdev->workqueue);
+
+	BTMTK_INFO("%s", __func__);
+
+	if (bdev->hdev)
+		hci_free_dev(bdev->hdev);
+
+	fstate = btmtk_fops_get_state(bdev);
+	if (fstate == BTMTK_FOPS_STATE_OPENED || fstate == BTMTK_FOPS_STATE_CLOSING) {
+		BTMTK_WARN("%s: fstate = %d , set reset_stack_flag", __func__, fstate);
+		if (main_info.reset_stack_flag == HW_ERR_NONE)
+			main_info.reset_stack_flag = HW_ERR_CODE_USB_DISC;
+	}
+
+	bdev->chip_reset = 0;
+	BTMTK_INFO("%s done", __func__);
+}
+
+int btmtk_allocate_hci_device(struct btmtk_dev *bdev, int hci_bus_type)
+{
+	struct hci_dev *hdev;
+	int err = 0;
+
+	if (!bdev) {
+		BTMTK_ERR("%s, bdev is NULL!", __func__);
+		err = -EINVAL;
+		goto exit;
+	}
+
+	BTMTK_INFO("%s", __func__);
+	/* Add hci device */
+	hdev = hci_alloc_dev();
+	if (!hdev) {
+		BTMTK_ERR("%s, hdev is NULL!", __func__);
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	hdev->bus = hci_bus_type;
+	hci_set_drvdata(hdev, bdev);
+
+	/* HCI_PRIMARY = 0x00 */
+	hdev->dev_type = 0x00;
+
+	bdev->hdev = hdev;
+
+	/* register hci callback */
+	hdev->open	   = bt_open;
+	hdev->close    = bt_close;
+	hdev->flush    = bt_flush;
+	hdev->send	   = bt_send_frame;
+	hdev->setup    = bt_setup;
+
+	INIT_WORK(&bdev->rx_work, btmtk_rx_work);
+
+	init_waitqueue_head(&bdev->p_wait_event_q);
+
+	skb_queue_head_init(&bdev->rx_q);
+
+	bdev->workqueue = alloc_workqueue("BTMTK_RX_WQ", WQ_HIGHPRI | WQ_UNBOUND |
+					  WQ_MEM_RECLAIM, 1);
+	if (!bdev->workqueue) {
+		BTMTK_ERR("%s, bdev->workqueue is NULL!", __func__);
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	BTMTK_INFO("%s done", __func__);
+
+exit:
+	return err;
+}
+
+int btmtk_register_hci_device(struct btmtk_dev *bdev)
+{
+	struct hci_dev *hdev;
+	int err = 0;
+
+	hdev = bdev->hdev;
+
+	err = hci_register_dev(hdev);
+	/* After hci_register_dev completed
+	 * It will set dev_flags to HCI_SETUP
+	 * That cause vendor_lib create socket failed
+	 */
+	if (err < 0) {
+		BTMTK_INFO("%s can't register", __func__);
+		hci_free_dev(hdev);
+		goto exit;
+	}
+
+exit:
+	return err;
+}
+
+int btmtk_deregister_hci_device(struct btmtk_dev *bdev)
+{
+	int err = 0;
+
+	if (bdev && bdev->hdev)
+		hci_unregister_dev(bdev->hdev);
+
+	return err;
+}
+
+static int btmtk_main_allocate_memory(struct btmtk_dev *bdev)
+{
+	BTMTK_INFO("%s", __func__);
+
+	if (bdev->rom_patch_bin_file_name == NULL) {
+		bdev->rom_patch_bin_file_name = kzalloc(MAX_BIN_FILE_NAME_LEN, GFP_KERNEL);
+		if (!bdev->rom_patch_bin_file_name) {
+			BTMTK_ERR("%s: alloc memory fail (bdev->rom_patch_bin_file_name)",
+				__func__);
+			return -1;
+		}
+	}
+
+	if (bdev->io_buf == NULL) {
+		bdev->io_buf = kzalloc(IO_BUF_SIZE, GFP_KERNEL);
+		if (!bdev->io_buf) {
+			BTMTK_ERR("%s: alloc memory fail (bdev->io_buf)", __func__);
+			return -1;
+		}
+	}
+
+	if (bdev->woble_setting_file_name == NULL) {
+		bdev->woble_setting_file_name = kzalloc(MAX_BIN_FILE_NAME_LEN, GFP_KERNEL);
+		if (!bdev->woble_setting_file_name) {
+			BTMTK_ERR("%s: alloc memory fail (bdev->woble_setting_file_name)",
+				__func__);
+			return -1;
+		}
+	}
+
+	if (bdev->bt_cfg_file_name == NULL) {
+		bdev->bt_cfg_file_name = kzalloc(MAX_BIN_FILE_NAME_LEN, GFP_KERNEL);
+		if (!bdev->bt_cfg_file_name) {
+			BTMTK_ERR("%s: alloc memory fail (bdev->bt_cfg_file_name)", __func__);
+			return -1;
+		}
+	}
+
+	BTMTK_INFO("%s: Done", __func__);
+	return 0;
+}
+
+static void btmtk_main_free_memory(struct btmtk_dev *bdev)
+{
+	kfree(bdev->rom_patch_bin_file_name);
+	bdev->rom_patch_bin_file_name = NULL;
+
+	kfree(bdev->woble_setting_file_name);
+	bdev->woble_setting_file_name = NULL;
+
+	kfree(bdev->bt_cfg_file_name);
+	bdev->bt_cfg_file_name = NULL;
+
+	kfree(bdev->io_buf);
+	bdev->io_buf = NULL;
+
+	BTMTK_INFO("%s: Success", __func__);
+}
+
+int btmtk_main_cif_initialize(struct btmtk_dev *bdev, int hci_bus)
+{
+	int err = 0;
+
+	err = btmtk_main_allocate_memory(bdev);
+	if (err < 0) {
+		BTMTK_ERR("btmtk_main_allocate_memory failed!");
+		goto end;
+	}
+
+	btmtk_initialize_cfg_items(bdev);
+
+	err = btmtk_allocate_hci_device(bdev, hci_bus);
+	if (err < 0) {
+		BTMTK_ERR("btmtk_allocate_hci_device failed!");
+		goto free_mem;
+	}
+
+	err = btmtk_cap_init(bdev);
+	if (err < 0) {
+		BTMTK_ERR("btmtk_cap_init failed!");
+		goto free_hci_dev;
+	}
+
+	if (btmtk_load_bt_cfg(bdev->bt_cfg_file_name, bdev->intf_dev, bdev)) {
+		BTMTK_ERR("btmtk_load_bt_cfg failed!");
+		err = -1;
+		goto free_hci_dev;
+	}
+
+	return 0;
+
+free_hci_dev:
+	btmtk_free_hci_device(bdev, hci_bus);
+free_mem:
+	btmtk_main_free_memory(bdev);
+end:
+	return err;
+}
+
+void btmtk_main_cif_uninitialize(struct btmtk_dev *bdev, int hci_bus)
+{
+	btmtk_free_hci_device(bdev, hci_bus);
+	btmtk_initialize_cfg_items(bdev);
+	btmtk_main_free_memory(bdev);
+}
+
+
+int btmtk_main_woble_initialize(struct btmtk_dev *bdev)
+{
+	int err = 0;
+
+	/* Need to add Woble flow */
+	if (is_support_unify_woble(bdev)) {
+		btmtk_load_woble_setting(bdev->woble_setting_file_name,
+			bdev->intf_dev,
+			&bdev->woble_setting_len,
+			bdev);
+		/* if reset_stack is true, when chip reset is done, we need to power on chip to do
+		 * reset stack
+		 */
+		if (main_info.reset_stack_flag) {
+			err = btmtk_reset_power_on(bdev);
+			if (err < 0) {
+				BTMTK_ERR("reset power on failed!");
+				goto end;
+			}
+		}
+	}
+
+	if (bdev->bt_cfg.support_woble_by_eint) {
+		btmtk_woble_input_init(bdev);
+		btmtk_RegisterBTIrq(bdev);
+	}
+
+end:
+	return err;
+}
+
+int btmtk_main_cif_disconnect_notify(struct btmtk_dev *bdev, int hci_bus)
+{
+	btmtk_free_setting_file(bdev);
+	btmtk_deregister_hci_device(bdev);
+	btmtk_free_hci_device(bdev, hci_bus);
+
+	bdev->power_state = BTMTK_DONGLE_STATE_POWER_OFF;
+	btmtk_release_dev(bdev);
+
+	return 0;
+}
+
+/**
+ * Kernel Module init/exit Functions
+ */
+static int __init main_driver_init(void)
+{
+	int ret = 0;
+	int i;
+
+	/* Mediatek Driver Version */
+	BTMTK_INFO("%s: MTK BT Driver Version : %s", __func__, VERSION);
+
+	ret = main_init();
+	if (ret < 0)
+		return ret;
+
+	for (i = 0; i < btmtk_intf_num; i++)
+		btmtk_set_chip_state(g_bdev[i], BTMTK_STATE_DISCONNECT);
+
+	ret = btmtk_cif_register();
+	if (ret < 0) {
+		BTMTK_ERR("*** USB registration failed(%d)! ***", ret);
+		main_exit();
+		return ret;
+	}
+
+	ret = btmtk_fops_init();
+	if (ret < 0) {
+		BTMTK_ERR("*** STPBTFWLOG registration failed(%d)! ***", ret);
+		main_exit();
+		return ret;
+	}
+
+	BTMTK_INFO("%s: Done", __func__);
+	return ret;
+}
+
+static void __exit main_driver_exit(void)
+{
+	BTMTK_INFO("%s", __func__);
+	btmtk_cif_deregister();
+	btmtk_fops_exit();
+	main_exit();
+}
+module_init(main_driver_init);
+module_exit(main_driver_exit);
+
+/**
+ * Module Common Information
+ */
+MODULE_DESCRIPTION("Mediatek Bluetooth Driver");
+MODULE_VERSION(VERSION SUBVER);
+MODULE_LICENSE("GPL");
+module_param(btmtk_intf_num, int, 0444);
diff --git a/drivers/bluetooth/include/btmtk_buffer_mode.h b/drivers/bluetooth/include/btmtk_buffer_mode.h
new file mode 100644
index 000000000000..290b63357d24
--- /dev/null
+++ b/drivers/bluetooth/include/btmtk_buffer_mode.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *  Copyright (c) 2016,2017 MediaTek Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *  See http://www.gnu.org/licenses/gpl-2.0.html for more details.
+ */
+
+#ifndef __BTMTK_BUFFER_MODE_H__
+#define __BTMTK_BUFFER_MODE_H__
+
+#include "btmtk_main.h"
+
+#define BUFFER_MODE_SWITCH_FILE	"wifi.cfg"
+#define BUFFER_MODE_SWITCH_FIELD	"EfuseBufferModeCal"
+#define BUFFER_MODE_CFG_FILE		"EEPROM_MT%X_1.bin"
+#define EFUSE_MODE			0
+#define BIN_FILE_MODE			1
+#define AUTO_MODE			2
+
+#define BUFFER_MODE_MAC_LENGTH	6
+#define BT0_MAC_OFFSET			0x139
+#define BT1_MAC_OFFSET			0x13F
+
+#define BUFFER_MODE_RADIO_LENGTH	4
+#define BT0_RADIO_OFFSET		0x145
+#define BT1_RADIO_OFFSET		0x149
+
+#define BUFFER_MODE_GROUP_LENGTH	5
+#define BT0_GROUP_ANT0_OFFSET		0x984
+#define BT0_GROUP_ANT1_OFFSET		0x9BE
+#define BT1_GROUP_ANT0_OFFSET		0x9A1
+#define BT1_GROUP_ANT1_OFFSET		0x9DB
+
+#define BUFFER_MODE_CAL_LENGTH	6
+#define BT0_CAL_ANT0_OFFSET		0x96C
+#define BT0_CAL_ANT1_OFFSET		0x9A6
+#define BT1_CAL_ANT0_OFFSET		0x989
+#define BT1_CAL_ANT1_OFFSET		0x9C3
+
+struct btmtk_buffer_mode_radio_struct {
+	u8 radio_0;	/* bit 0-5:edr_init_pwr, 6-7:edr_pwr_mode */
+	u8 radio_1;	/* bit 0-5:edr_max_pwr, 6-7:reserved */
+	u8 radio_2;	/* bit 0-5:ble_default_pwr, 6-7:reserved */
+	u8 radio_3;	/* reserved */
+};
+
+struct btmtk_buffer_mode_struct {
+	struct btmtk_dev *bdev;
+
+	unsigned char		file_name[MAX_BIN_FILE_NAME_LEN];
+	int			efuse_mode;
+
+	u8 bt0_mac[BUFFER_MODE_MAC_LENGTH];
+	u8 bt1_mac[BUFFER_MODE_MAC_LENGTH];
+	struct btmtk_buffer_mode_radio_struct bt0_radio;
+	struct btmtk_buffer_mode_radio_struct bt1_radio;
+	u8 bt0_ant0_grp_boundary[BUFFER_MODE_GROUP_LENGTH];
+	u8 bt0_ant1_grp_boundary[BUFFER_MODE_GROUP_LENGTH];
+	u8 bt1_ant0_grp_boundary[BUFFER_MODE_GROUP_LENGTH];
+	u8 bt1_ant1_grp_boundary[BUFFER_MODE_GROUP_LENGTH];
+	u8 bt0_ant0_pwr_offset[BUFFER_MODE_CAL_LENGTH];
+	u8 bt0_ant1_pwr_offset[BUFFER_MODE_CAL_LENGTH];
+	u8 bt1_ant0_pwr_offset[BUFFER_MODE_CAL_LENGTH];
+	u8 bt1_ant1_pwr_offset[BUFFER_MODE_CAL_LENGTH];
+};
+
+int btmtk_buffer_mode_send(struct btmtk_buffer_mode_struct *buffer_mode);
+void btmtk_buffer_mode_initialize(struct btmtk_dev *bdev,
+				  struct btmtk_buffer_mode_struct **buffer_mode);
+#endif /* __BTMTK_BUFFER_MODE_H__ */
+
diff --git a/drivers/bluetooth/include/btmtk_chip_if.h b/drivers/bluetooth/include/btmtk_chip_if.h
new file mode 100644
index 000000000000..9e377341250b
--- /dev/null
+++ b/drivers/bluetooth/include/btmtk_chip_if.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/**
+ *  Copyright (c) 2018 MediaTek Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *  See http://www.gnu.org/licenses/gpl-2.0.html for more details.
+ */
+#ifndef __BTMTK_CHIP_IF_H__
+#define __BTMTK_CHIP_IF_H__
+
+#ifdef CHIP_IF_USB
+#include "btmtk_usb.h"
+#elif defined(CHIP_IF_SDIO)
+#include "btmtk_sdio.h"
+#elif defined(CHIP_IF_UART)
+#include "btmtk_uart.h"
+#elif defined(CHIP_IF_BTIF)
+#include "btmtk_btif.h"
+#endif
+
+int btmtk_cif_register(void);
+int btmtk_cif_deregister(void);
+
+#endif /* __BTMTK_CHIP_IF_H__ */
diff --git a/drivers/bluetooth/include/btmtk_define.h b/drivers/bluetooth/include/btmtk_define.h
new file mode 100644
index 000000000000..9033fa286e10
--- /dev/null
+++ b/drivers/bluetooth/include/btmtk_define.h
@@ -0,0 +1,304 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *  Copyright (c) 2016,2017 MediaTek Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *  See http://www.gnu.org/licenses/gpl-2.0.html for more details.
+ */
+
+#ifndef __BTMTK_DEFINE_H__
+#define __BTMTK_DEFINE_H__
+
+#include <linux/version.h>
+#include <linux/firmware.h>
+#include <linux/slab.h>
+#include <linux/module.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#include <linux/cdev.h>
+#include <linux/spinlock.h>
+#include <linux/kallsyms.h>
+#include <linux/device.h>
+#include <asm/unaligned.h>
+
+/* Define for proce node */
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+
+/* Define for whole chip reset */
+#include <linux/of.h>
+#include <linux/of_gpio.h>
+
+#include <linux/kthread.h>
+#include <linux/freezer.h>
+
+/** Driver version */
+#define VERSION "7.0.2020110301"
+#define SUBVER ":turnkey"
+
+#define ENABLESTP FALSE
+#define BTMTKUART_TX_STATE_ACTIVE	1
+#define BTMTKUART_TX_STATE_WAKEUP	2
+#define BTMTK_TX_WAIT_VND_EVT		3
+#define BTMTKUART_REQUIRED_WAKEUP	4
+#define BTMTKUART_REQUIRED_DOWNLOAD	5
+#define BTMTK_TX_SKIP_VENDOR_EVT	6
+
+#define BTMTKUART_RX_STATE_ACTIVE	1
+#define BTMTKUART_RX_STATE_WAKEUP	2
+#define BTMTKUART_RX_STATE_RESET	3
+
+/**
+ * Maximum rom patch file name length
+ */
+#define MAX_BIN_FILE_NAME_LEN 64
+
+/**
+ * Type definition
+ */
+#ifndef TRUE
+	#define TRUE 1
+#endif
+#ifndef FALSE
+	#define FALSE 0
+#endif
+
+#ifndef UNUSED
+	#define UNUSED(x) ((void)(x))
+#endif
+
+#define MIN(a, b) (((a) < (b)) ? (a) : (b))
+#define MAX(a, b) (((a) > (b)) ? (a) : (b))
+
+
+/**
+ * Log and level definition
+ */
+#define BTMTK_LOG_LVL_ERR	1
+#define BTMTK_LOG_LVL_WARN	2
+#define BTMTK_LOG_LVL_INFO	3
+#define BTMTK_LOG_LVL_DBG	4
+#define BTMTK_LOG_LVL_MAX	BTMTK_LOG_LVL_DBG
+#define BTMTK_LOG_LVL_DEF	BTMTK_LOG_LVL_INFO	/* default setting */
+
+#define HCI_SNOOP_ENTRY_NUM	30
+#define HCI_SNOOP_BUF_SIZE	32
+#define HCI_SNOOP_MAX_BUF_SIZE	66
+#define WMT_OVER_HCI_HEADER_SIZE	3
+
+
+extern uint8_t btmtk_log_lvl;
+
+#define BTMTK_ERR(fmt, ...)	 \
+	do { \
+		if (btmtk_log_lvl >= BTMTK_LOG_LVL_ERR) \
+			pr_warn("[btmtk_err] ***"fmt"***\n", ##__VA_ARGS__); \
+	} while (0)
+#define BTMTK_WARN(fmt, ...)	\
+	do { \
+		if (btmtk_log_lvl >= BTMTK_LOG_LVL_WARN) \
+			pr_warn("[btmtk_warn] "fmt"\n", ##__VA_ARGS__); \
+	} while (0)
+#define BTMTK_INFO(fmt, ...)	\
+	do { \
+		if (btmtk_log_lvl >= BTMTK_LOG_LVL_INFO) \
+			pr_warn("[btmtk_info] "fmt"\n", ##__VA_ARGS__); \
+	} while (0)
+#define BTMTK_DBG(fmt, ...)	 \
+	do { \
+		if (btmtk_log_lvl >= BTMTK_LOG_LVL_DBG) \
+			pr_warn("[btmtk_dbg] "fmt"\n", ##__VA_ARGS__); \
+	} while (0)
+
+#define BTMTK_INFO_RAW(p, l, fmt, ...)						\
+	do {									\
+		if (btmtk_log_lvl >= BTMTK_LOG_LVL_INFO) {			\
+			int raw_count = 0;					\
+			char str[HCI_SNOOP_MAX_BUF_SIZE * 3 + 1];		\
+			char *p_str = str;					\
+			const unsigned char *ptr = p;				\
+			pr_warn("[btmtk_info] "fmt, ##__VA_ARGS__);		\
+			for (raw_count = 0;					\
+				raw_count < MIN(l, HCI_SNOOP_MAX_BUF_SIZE); ++raw_count)	\
+				p_str += sprintf(p_str, " %02X", ptr[raw_count]);		\
+			*p_str = '\0';								\
+			pr_warn("%s\n", str);						\
+		}								\
+	} while (0)
+
+#define BTMTK_DBG_RAW(p, l, fmt, ...)						\
+	do {									\
+		if (btmtk_log_lvl >= BTMTK_LOG_LVL_DBG) {			\
+			int raw_count = 0;					\
+			char str[HCI_SNOOP_MAX_BUF_SIZE * 3 + 1];		\
+			char *p_str = str;					\
+			const unsigned char *ptr = p;				\
+			pr_warn("[btmtk_debug] "fmt, ##__VA_ARGS__);		\
+			for (raw_count = 0;					\
+				raw_count < MIN(l, HCI_SNOOP_MAX_BUF_SIZE); ++raw_count)	\
+				p_str += sprintf(p_str, " %02X", ptr[raw_count]);		\
+			*p_str = '\0';								\
+			pr_warn("%s", str);						\
+		}								\
+	} while (0)
+
+#define BTMTK_CIF_IS_NULL(bdev, cif_event) \
+	(!bdev || !(&bdev->cif_state[cif_event]))
+
+/**
+ *
+ * HCI packet type
+ */
+#define MTK_HCI_COMMAND_PKT		0x01
+#define MTK_HCI_ACLDATA_PKT		0x02
+#define MTK_HCI_SCODATA_PKT		0x03
+#define MTK_HCI_EVENT_PKT		0x04
+#define HCI_ISO_PKT			0x05
+#define HCI_ISO_PKT_HEADER_SIZE	4
+#define HCI_ISO_PKT_WITH_ACL_HEADER_SIZE	5
+
+/**
+ * ROM patch related
+ */
+#define PATCH_HCI_HEADER_SIZE	4
+#define PATCH_WMT_HEADER_SIZE	5
+/*
+ * Enable STP
+ * HCI+WMT+STP = 4 + 5 + 1(phase) +(4=STP_HEADER + 2=CRC)
+#define PATCH_HEADER_SIZE	16
+ */
+/*#ifdef ENABLESTP
+ * #define PATCH_HEADER_SIZE	(PATCH_HCI_HEADER_SIZE + PATCH_WMT_HEADER_SIZE + 1 + 6)
+ * #define UPLOAD_PATCH_UNIT	916
+ * #define PATCH_INFO_SIZE		30
+ *#else
+ */
+#define PATCH_HEADER_SIZE	(PATCH_HCI_HEADER_SIZE + PATCH_WMT_HEADER_SIZE + 1)
+/* TODO, If usb use 901 patch unit size, download patch will timeout
+ * because the timeout has been set to 1s
+ */
+#define UPLOAD_PATCH_UNIT	2048
+#define PATCH_INFO_SIZE		30
+//#endif
+#define PATCH_PHASE1		1
+#define PATCH_PHASE2		2
+#define PATCH_PHASE3		3
+
+/* It is for mt7961 download rom patch*/
+#define FW_ROM_PATCH_HEADER_SIZE	32
+#define FW_ROM_PATCH_GD_SIZE	64
+#define FW_ROM_PATCH_SEC_MAP_SIZE	64
+#define SEC_MAP_NEED_SEND_SIZE	52
+#define PATCH_STATUS	7
+
+
+#define IO_BUF_SIZE		(HCI_MAX_EVENT_SIZE > 256 ? HCI_MAX_EVENT_SIZE : 256)
+#define EVENT_COMPARE_SIZE	64
+
+#define SECTION_SPEC_NUM	13
+
+/* Define for WoBLE */
+#define BD_ADDRESS_SIZE 6
+#define WOBLE_SETTING_COUNT 10
+#define PHASE1_WMT_CMD_COUNT 255
+#define VENDOR_CMD_COUNT 255
+#define WOBLE_SETTING_FILE_NAME_7663 "woble_setting_7663.bin"
+#define WOBLE_SETTING_FILE_NAME_7961 "woble_setting_7961.bin"
+#define WOBLE_EVENT_INTERVAL_TIMO	500
+#define WOBLE_COMP_EVENT_TIMO		5000
+
+#define BT_CFG_NAME "bt.cfg"
+#define BT_UNIFY_WOBLE "SUPPORT_UNIFY_WOBLE"
+#define BT_UNIFY_WOBLE_TYPE "UNIFY_WOBLE_TYPE"
+#define BT_WOBLE_BY_EINT "SUPPORT_WOBLE_BY_EINT"
+#define BT_DONGLE_RESET_PIN "BT_DONGLE_RESET_GPIO_PIN"
+#define BT_RESET_DONGLE "SUPPORT_DONGLE_RESET"
+#define BT_FULL_FW_DUMP "SUPPORT_FULL_FW_DUMP"
+#define BT_WOBLE_WAKELOCK "SUPPORT_WOBLE_WAKELOCK"
+#define BT_WOBLE_FOR_BT_DISABLE "SUPPORT_WOBLE_FOR_BT_DISABLE"
+#define BT_RESET_STACK_AFTER_WOBLE "RESET_STACK_AFTER_WOBLE"
+#define BT_AUTO_PICUS "SUPPORT_AUTO_PICUS"
+#define BT_AUTO_PICUS_FILTER "PICUS_FILTER_COMMAND"
+#define BT_AUTO_PICUS_ENABLE "PICUS_ENABLE_COMMAND"
+#define BT_PICUS_TO_HOST "SUPPORT_PICUS_TO_HOST"
+#define BT_PHASE1_WMT_CMD "PHASE1_WMT_CMD"
+#define BT_VENDOR_CMD "VENDOR_CMD"
+#define BT_SINGLE_SKU "SUPPORT_BT_SINGLE_SKU"
+
+
+#define PM_KEY_BTW (0x0015) /* Notify PM the unify woble type */
+
+/**
+ * Disable RESUME_RESUME
+ */
+#ifndef BT_DISABLE_RESET_RESUME
+#define BT_DISABLE_RESET_RESUME 0
+#endif
+
+enum fw_cfg_index_len {
+	FW_CFG_INX_LEN_NONE = 0,
+	FW_CFG_INX_LEN_2 = 2,
+	FW_CFG_INX_LEN_3 = 3,
+};
+
+struct fw_cfg_struct {
+	char	*content;	/* APCF content or radio off content */
+	int	length;		/* APCF content or radio off content of length */
+};
+
+struct bt_cfg_struct {
+	bool	support_unify_woble;	/* support unify woble or not */
+	bool	support_woble_by_eint;		/* support woble by eint or not */
+	bool	support_dongle_reset;		/* support chip reset or not */
+	bool	support_full_fw_dump;		/* dump full fw coredump or not */
+	bool	support_woble_wakelock;		/* support when woble error, do wakelock or not */
+	bool	support_woble_for_bt_disable;	/* when bt disable, support enter susend or not */
+	bool	reset_stack_after_woble; /* support reset stack to re-connect IOT after resume */
+	bool	support_auto_picus;		/* support enable PICUS automatically */
+	struct fw_cfg_struct picus_filter;	/* support on PICUS filter command customization */
+	struct fw_cfg_struct picus_enable;	/* support on PICUS enable command customization */
+	bool	support_picus_to_host;		/* support picus log to host (boots/bluedroid) */
+	int	dongle_reset_gpio_pin;		/* BT_DONGLE_RESET_GPIO_PIN number */
+	unsigned int	unify_woble_type;	/* 0: legacy. 1: waveform. 2: IR */
+	struct fw_cfg_struct phase1_wmt_cmd[PHASE1_WMT_CMD_COUNT];
+	struct fw_cfg_struct vendor_cmd[VENDOR_CMD_COUNT];
+	bool	support_bt_single_sku;
+};
+
+#define WIFI_DOWNLOAD	TRUE
+#define BT_DOWNLOAD	FALSE
+
+#define SWAP32(x) \
+	((u32) (\
+	(((u32) (x) & (u32) 0x000000ffUL) << 24) | \
+	(((u32) (x) & (u32) 0x0000ff00UL) << 8) | \
+	(((u32) (x) & (u32) 0x00ff0000UL) >> 8) | \
+	(((u32) (x) & (u32) 0xff000000UL) >> 24)))
+
+/* Endian byte swapping codes */
+#ifdef __LITTLE_ENDIAN
+#define cpu2le32(x) ((uint32_t)(x))
+#define le2cpu32(x) ((uint32_t)(x))
+#define cpu2be32(x) SWAP32((x))
+#define be2cpu32(x) SWAP32((x))
+#else
+#define cpu2le32(x) SWAP32((x))
+#define le2cpu32(x) SWAP32((x))
+#define cpu2be32(x) ((uint32_t)(x))
+#define be2cpu32(x) ((uint32_t)(x))
+#endif
+
+#define FW_VERSION	0x80021004
+#define CHIP_ID	0x70010200
+#define FLAVOR	0x70010020
+
+
+#endif /* __BTMTK_DEFINE_H__ */
diff --git a/drivers/bluetooth/include/btmtk_drv.h b/drivers/bluetooth/include/btmtk_drv.h
new file mode 100644
index 000000000000..005cca677730
--- /dev/null
+++ b/drivers/bluetooth/include/btmtk_drv.h
@@ -0,0 +1,157 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *  Copyright (c) 2016,2017 MediaTek Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *  See http://www.gnu.org/licenses/gpl-2.0.html for more details.
+ */
+
+#ifndef _BTMTK_DRV_H_
+#define _BTMTK_DRV_H_
+
+#include <linux/kthread.h>
+#include <linux/bitops.h>
+#include <linux/slab.h>
+#include <net/bluetooth/bluetooth.h>
+
+#define SAVE_FW_DUMP_IN_KERNEL	1
+
+#define SUPPORT_FW_DUMP		1
+#define BTM_HEADER_LEN                  5
+#define BTM_UPLD_SIZE                   2312
+
+#define MTK_TXDATA_SIZE 2000
+#define MTK_RXDATA_SIZE 2000
+
+/* Time to wait until Host Sleep state change in millisecond */
+#define WAIT_UNTIL_HS_STATE_CHANGED     msecs_to_jiffies(5000)
+/* Time to wait for command response in millisecond */
+#define WAIT_UNTIL_CMD_RESP             msecs_to_jiffies(5000)
+
+enum rdwr_status {
+	RDWR_STATUS_SUCCESS = 0,
+	RDWR_STATUS_FAILURE = 1,
+	RDWR_STATUS_DONE = 2
+};
+
+#define FW_DUMP_MAX_NAME_LEN    8
+#define FW_DUMP_HOST_READY      0xEE
+#define FW_DUMP_DONE            0xFF
+#define FW_DUMP_READ_DONE       0xFE
+
+struct memory_type_mapping {
+	u8 mem_name[FW_DUMP_MAX_NAME_LEN];
+	u8 *mem_ptr;
+	u32 mem_size;
+	u8 done_flag;
+};
+
+#define MTK_VENDOR_PKT                 0xFE
+
+/* Vendor specific Bluetooth commands */
+#define BT_CMD_PSCAN_WIN_REPORT_ENABLE  0xFC03
+#define BT_CMD_ROUTE_SCO_TO_HOST        0xFC1D
+#define BT_CMD_SET_BDADDR               0xFC22
+#define BT_CMD_AUTO_SLEEP_MODE          0xFC23
+#define BT_CMD_HOST_SLEEP_CONFIG        0xFC59
+#define BT_CMD_HOST_SLEEP_ENABLE        0xFC5A
+#define BT_CMD_MODULE_CFG_REQ           0xFC5B
+#define BT_CMD_LOAD_CONFIG_DATA         0xFC61
+
+/* Sub-commands: Module Bringup/Shutdown Request/Response */
+#define MODULE_BRINGUP_REQ              0xF1
+#define MODULE_BROUGHT_UP               0x00
+#define MODULE_ALREADY_UP               0x0C
+
+#define MODULE_SHUTDOWN_REQ             0xF2
+
+/* Vendor specific Bluetooth events */
+#define BT_EVENT_AUTO_SLEEP_MODE        0x23
+#define BT_EVENT_HOST_SLEEP_CONFIG      0x59
+#define BT_EVENT_HOST_SLEEP_ENABLE      0x5A
+#define BT_EVENT_MODULE_CFG_REQ         0x5B
+#define BT_EVENT_POWER_STATE            0x20
+
+/* Bluetooth Power States */
+#define BT_PS_ENABLE                    0x02
+#define BT_PS_DISABLE                   0x03
+#define BT_PS_SLEEP                     0x01
+
+/* Host Sleep states */
+#define HS_ACTIVATED                    0x01
+#define HS_DEACTIVATED                  0x00
+
+/* Power Save modes */
+#define PS_SLEEP                        0x01
+#define PS_AWAKE                        0x00
+
+#define BT_CAL_HDR_LEN                  4
+#define BT_CAL_DATA_SIZE                28
+
+#define FW_DUMP_BUF_SIZE (1024*512)
+
+#define FW_DUMP_FILE_NAME_SIZE     64
+
+
+/* #define SAVE_FW_DUMP_IN_KERNEL     1 */
+
+/* stpbt device node */
+#define BT_NODE "stpbt"
+#define BT_DRIVER_NAME "BT_chrdev"
+
+struct btmtk_event {
+	u8 ec;          /* event counter */
+	u8 length;
+	u8 data[4];
+} __packed;
+
+/* Prototype of global function */
+
+struct btmtk_private *btmtk_add_card(void *card);
+int btmtk_remove_card(struct btmtk_private *priv);
+
+void btmtk_interrupt(struct btmtk_private *priv);
+
+bool btmtk_check_evtpkt(struct btmtk_private *priv, struct sk_buff *skb);
+int btmtk_process_event(struct btmtk_private *priv, struct sk_buff *skb);
+
+int btmtk_send_module_cfg_cmd(struct btmtk_private *priv, u8 subcmd);
+int btmtk_pscan_window_reporting(struct btmtk_private *priv, u8 subcmd);
+int btmtk_send_hscfg_cmd(struct btmtk_private *priv);
+int btmtk_enable_ps(struct btmtk_private *priv);
+int btmtk_prepare_command(struct btmtk_private *priv);
+int btmtk_enable_hs(struct btmtk_private *priv);
+void btmtk_firmware_dump(struct btmtk_private *priv);
+
+#define META_BUFFER_SIZE (1024*50)
+
+struct _OSAL_UNSLEEPABLE_LOCK_ {
+	spinlock_t lock;
+	unsigned long flag;
+};
+
+struct ring_buffer {
+	struct _OSAL_UNSLEEPABLE_LOCK_ spin_lock;
+	u8 buffer[META_BUFFER_SIZE];	/* MTKSTP_BUFFER_SIZE:1024 */
+	u32 read_p;		/* indicate the current read index */
+	u32 write_p;		/* indicate the current write index */
+};
+
+#ifdef CONFIG_DEBUG_FS
+
+#define FIXED_STPBT_MAJOR_DEV_ID 111
+
+
+
+#define FW_DUMP_END_EVENT "coredump end"
+
+#endif
+
+#endif
+
diff --git a/drivers/bluetooth/include/btmtk_main.h b/drivers/bluetooth/include/btmtk_main.h
new file mode 100644
index 000000000000..21e4d71a75e2
--- /dev/null
+++ b/drivers/bluetooth/include/btmtk_main.h
@@ -0,0 +1,587 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/**
+ *  Copyright (c) 2018 MediaTek Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *  See http://www.gnu.org/licenses/gpl-2.0.html for more details.
+ */
+#ifndef __BTMTK_MAIN_H__
+#define __BTMTK_MAIN_H__
+#include "btmtk_define.h"
+#include "btmtk_chip_if.h"
+
+#define DEFAULT_COUNTRY_TABLE_NAME "btPowerTable.dat"
+
+
+//static inline struct sk_buff *mtk_add_stp(struct btmtk_dev *bdev, struct sk_buff *skb);
+
+#define hci_dev_test_and_clear_flag(hdev, nr)  test_and_clear_bit((nr), (hdev)->dev_flags)
+
+/* h4_recv */
+#define hci_skb_pkt_type(skb) bt_cb((skb))->pkt_type
+#define hci_skb_expect(skb) bt_cb((skb))->expect
+#define hci_skb_opcode(skb) bt_cb((skb))->hci.opcode
+
+/* HCI bus types */
+#define HCI_VIRTUAL	0
+#define HCI_USB		1
+#define HCI_PCCARD	2
+#define HCI_UART	3
+#define HCI_RS232	4
+#define HCI_PCI		5
+#define HCI_SDIO	6
+#define HCI_SPI		7
+#define HCI_I2C		8
+#define HCI_SMD		9
+
+#define HCI_TYPE_SIZE	1
+
+/* this for 7663 need download patch staus
+ * 0:
+ * patch download is not complete/BT get patch semaphore fail (WiFi get semaphore success)
+ * 1:
+ * patch download is complete
+ * 2:
+ * patch download is not complete/BT get patch semaphore success
+ */
+#define MT766X_PATCH_IS_DOWNLOAD_BY_OTHER 0
+#define MT766X_PATCH_READY 1
+#define MT766X_PATCH_NEED_DOWNLOAD 2
+
+/* this for 79XX need download patch staus
+ * 0:
+ * patch download is not complete, BT driver need to download patch
+ * 1:
+ * patch is downloading by Wifi,BT driver need to retry until status = PATCH_READY
+ * 2:
+ * patch download is complete, BT driver no need to download patch
+ */
+#define PATCH_ERR -1
+#define PATCH_NEED_DOWNLOAD 0
+#define PATCH_IS_DOWNLOAD_BY_OTHER 1
+#define PATCH_READY 2
+
+/* 0:
+ * using legacy wmt cmd/evt to download fw patch, usb/sdio just support 0 now
+ * 1:
+ * using DMA to download fw patch
+ */
+#define PATCH_DOWNLOAD_USING_WMT 0
+#define PATCH_DOWNLOAD_USING_DMA 1
+
+#define PATCH_DOWNLOAD_PHASE1_2_DELAY_TIME 1
+#define PATCH_DOWNLOAD_PHASE1_2_RETRY 5
+#define PATCH_DOWNLOAD_PHASE3_DELAY_TIME 20
+#define PATCH_DOWNLOAD_PHASE3_RETRY 20
+
+/* * delay and retrey for main_send_cmd */
+#define WMT_DELAY_TIMES 100
+#define DELAY_TIMES 20
+#define RETRY_TIMES 20
+
+/* Expected minimum supported interface */
+#define BT_MCU_MINIMUM_INTERFACE_NUM	4
+
+/* Bus event */
+#define HIF_EVENT_PROBE		0
+#define HIF_EVENT_DISCONNECT	1
+#define HIF_EVENT_SUSPEND	2
+#define HIF_EVENT_RESUME	3
+#define HIF_EVENT_STANDBY	4
+#define HIF_EVENT_SUBSYS_RESET	5
+#define HIF_EVENT_WHOLE_CHIP_RESET	6
+#define HIF_EVENT_FW_DUMP	7
+
+
+#define CHAR2HEX_SIZE	4
+
+/**
+ * For chip reset pin
+ */
+#define RESET_PIN_SET_LOW_TIME		100
+
+/* stpbtfwlog setting */
+#define FWLOG_QUEUE_COUNT			(400 * BT_MCU_MINIMUM_INTERFACE_NUM)
+#define FWLOG_ASSERT_QUEUE_COUNT		45000
+#define FWLOG_BLUETOOTH_KPI_QUEUE_COUNT		400
+#define HCI_MAX_COMMAND_SIZE			255
+#define HCI_MAX_COMMAND_BUF_SIZE		(HCI_MAX_COMMAND_SIZE * 3)
+#define HCI_MAX_ISO_SIZE	340
+
+/* fwlog information define */
+#define FWLOG_TYPE		0xF0
+#define FWLOG_LEN_SIZE		2
+#define FWLOG_TL_SIZE		(HCI_TYPE_SIZE + FWLOG_LEN_SIZE)
+#define FWLOG_ATTR_TYPE_LEN	1
+#define FWLOG_ATTR_LEN_LEN	1
+#define FWLOG_ATTR_RX_LEN_LEN	2
+#define FWLOG_ATTR_TL_SIZE	(FWLOG_ATTR_TYPE_LEN + FWLOG_ATTR_LEN_LEN)
+
+#define FWLOG_HCI_IDX		0x00
+#define FWLOG_DONGLE_IDX	0x01
+#define FWLOG_TX		0x10
+#define FWLOG_RX		0x11
+
+/* total fwlog info len */
+#define FWLOG_PRSV_LEN		32
+
+/* bluetooth kpi */
+#define KPI_WITHOUT_TYPE	0
+#define COUNTRY_CODE_LEN	2
+
+
+#define EDR_MIN		-32
+#define EDR_MAX		20
+#define EDR_MIN_LV9	13
+#define BLE_MIN		-29
+#define BLE_MAX		20
+#define EDR_MIN_R1	-64
+#define EDR_MAX_R1	40
+#define EDR_MIN_LV9_R1	26
+#define BLE_MIN_R1	-58
+#define BLE_MAX_R1	40
+#define EDR_MIN_R2	-128
+#define EDR_MAX_R2	80
+#define EDR_MIN_LV9_R2	52
+#define BLE_MIN_R2	-116
+#define BLE_MAX_R2	80
+
+#define ERR_PWR		-9999
+
+enum {
+	RES_1 = 0,
+	RES_DOT_5,
+	RES_DOT_25
+};
+
+enum {
+	CHECK_SINGLE_SKU_PWR_MODE	= 0,
+	CHECK_SINGLE_SKU_EDR_MAX,
+	CHECK_SINGLE_SKU_BLE,
+	CHECK_SINGLE_SKU_BLE_2M,
+	CHECK_SINGLE_SKU_BLE_LR_S2,
+	CHECK_SINGLE_SKU_BLE_LR_S8,
+	CHECK_SINGLE_SKU_ALL
+};
+
+enum {
+	DISABLE_LV9 = 0,
+	ENABLE_LV9
+};
+
+enum {
+	DIFF_MODE_3DB = 0,
+	DIFF_MODE_0DB
+};
+
+struct btmtk_cif_state {
+	unsigned char ops_enter;
+	unsigned char ops_end;
+	unsigned char ops_error;
+};
+
+enum TX_TYPE {
+	BTMTK_TX_CMD_FROM_DRV = 0,	/* send hci cmd and wmt cmd by driver */
+	BTMTK_TX_ACL_FROM_DRV,	/* send acl pkt with load rompatch by driver */
+	BTMTK_TX_PKT_FROM_HOST,	/* send pkt from host, include acl and hci */
+};
+
+/* Device node */
+#if CFG_SUPPORT_MULTI_DEV_NODE
+	#define BT_CHR_DEV	"BT_multi_chrdevfwlog"
+	#define BT_DEV_NODE	"stpbt_multi_fwlog"
+#else
+	#define BT_CHR_DEV	"BT_chrdevfwlog"
+	#define BT_DEV_NODE	"stpbtfwlog"
+#endif
+
+struct bt_power_setting {
+	int8_t EDR_Max;
+	int8_t LV9;
+	int8_t DM;
+	int8_t IR;
+	int8_t BLE_1M;
+	int8_t BLE_2M;
+	int8_t BLE_LR_S2;
+	int8_t BLE_LR_S8;
+	char country_code[3];
+};
+
+struct btmtk_fops_fwlog {
+	dev_t g_devIDfwlog;
+	struct cdev BT_cdevfwlog;
+	wait_queue_head_t fw_log_inq;
+	struct sk_buff_head fwlog_queue;
+	struct class *pBTClass;
+	struct device *pBTDevfwlog;
+	spinlock_t fwlog_lock;
+	u8 btmtk_bluetooth_kpi;
+};
+
+enum {
+	BTMTK_DONGLE_STATE_UNKNOWN,
+	BTMTK_DONGLE_STATE_POWER_ON,
+	BTMTK_DONGLE_STATE_POWER_OFF,
+	BTMTK_DONGLE_STATE_ERROR,
+};
+
+enum {
+	HW_ERR_NONE = 0x00,
+	HW_ERR_CODE_CHIP_RESET = 0xF0,
+	HW_ERR_CODE_USB_DISC = 0xF1,
+	HW_ERR_CODE_CORE_DUMP = 0xF2,
+	HW_ERR_CODE_POWER_ON = 0xF3,
+	HW_ERR_CODE_POWER_OFF = 0xF4,
+	HW_ERR_CODE_SET_SLEEP_CMD = 0xF5,
+	HW_ERR_CODE_RESET_STACK_AFTER_WOBLE = 0xF6,
+};
+
+/* Please keep sync with btmtk_set_state function */
+enum {
+	/* BTMTK_STATE_UNKNOWN = 0, */
+	BTMTK_STATE_INIT = 1,
+	BTMTK_STATE_DISCONNECT,
+	BTMTK_STATE_PROBE,
+	BTMTK_STATE_WORKING,
+	BTMTK_STATE_SUSPEND,
+	BTMTK_STATE_RESUME,
+	BTMTK_STATE_FW_DUMP,
+	BTMTK_STATE_STANDBY,
+	BTMTK_STATE_SUBSYS_RESET,
+};
+
+/* Please keep sync with btmtk_fops_set_state function */
+enum {
+	/* BTMTK_FOPS_STATE_UNKNOWN = 0, */
+	BTMTK_FOPS_STATE_INIT = 1,
+	BTMTK_FOPS_STATE_OPENING,	/* during opening */
+	BTMTK_FOPS_STATE_OPENED,	/* open in fops_open */
+	BTMTK_FOPS_STATE_CLOSING,	/* during closing */
+	BTMTK_FOPS_STATE_CLOSED,	/* closed */
+};
+
+enum {
+	BTMTK_EVENT_COMPARE_STATE_UNKNOWN,
+	BTMTK_EVENT_COMPARE_STATE_NOTHING_NEED_COMPARE,
+	BTMTK_EVENT_COMPARE_STATE_NEED_COMPARE,
+	BTMTK_EVENT_COMPARE_STATE_COMPARE_SUCCESS,
+};
+
+struct h4_recv_pkt {
+	u8  type;	/* Packet type */
+	u8  hlen;	/* Header length */
+	u8  loff;	/* Data length offset in header */
+	u8  lsize;	/* Data length field size */
+	u16 maxlen;	/* Max overall packet length */
+	int (*recv)(struct hci_dev *hdev, struct sk_buff *skb);
+};
+
+#pragma pack(1)
+struct _PATCH_HEADER {
+	u8 ucDateTime[16];
+	u8 ucPlatform[4];
+	u16 u2HwVer;
+	u16 u2SwVer;
+	u32 u4MagicNum;
+};
+
+struct _Global_Descr {
+	u32 u4PatchVer;
+	u32 u4SubSys;
+	u32 u4FeatureOpt;
+	u32 u4SectionNum;
+};
+
+struct _Section_Map {
+	u32 u4SecType;
+	u32 u4SecOffset;
+	u32 u4SecSize;
+	union {
+		u32 u4SecSpec[SECTION_SPEC_NUM];
+		struct {
+			u32 u4DLAddr;
+			u32 u4DLSize;
+			u32 u4SecKeyIdx;
+			u32 u4AlignLen;
+			u32 u4SecType;
+			u32 u4DLModeCrcType;
+			u32 u4Crc;
+			u32 reserved[6];
+		} bin_info_spec;
+	};
+};
+#pragma pack()
+
+#define H4_RECV_ACL \
+	.type = HCI_ACLDATA_PKT, \
+	.hlen = HCI_ACL_HDR_SIZE, \
+	.loff = 2, \
+	.lsize = 2, \
+	.maxlen = HCI_MAX_FRAME_SIZE \
+
+#define H4_RECV_SCO \
+	.type = HCI_SCODATA_PKT, \
+	.hlen = HCI_SCO_HDR_SIZE, \
+	.loff = 2, \
+	.lsize = 1, \
+	.maxlen = HCI_MAX_SCO_SIZE
+
+#define H4_RECV_EVENT \
+	.type = HCI_EVENT_PKT, \
+	.hlen = HCI_EVENT_HDR_SIZE, \
+	.loff = 1, \
+	.lsize = 1, \
+	.maxlen = HCI_MAX_EVENT_SIZE
+
+
+struct btmtk_dev {
+	struct hci_dev	*hdev;
+	unsigned long	hdev_flags;
+	unsigned long	flags;
+	void *intf_dev;
+	void *cif_dev;
+
+	struct work_struct	work;
+	struct work_struct	waker;
+	struct work_struct	reset_waker;
+
+	int	recv_evt_len;
+	int	tx_in_flight;
+	spinlock_t	txlock;
+	spinlock_t	rxlock;
+
+	struct sk_buff	*evt_skb;
+	struct sk_buff	*sco_skb;
+
+	/* For ble iso packet size */
+	int iso_threshold;
+
+	unsigned int	sco_num;
+	int	isoc_altsetting;
+
+	int	suspend_count;
+
+	/* For tx queue */
+	unsigned long	tx_state;
+
+	/* For rx queue */
+	struct workqueue_struct	*workqueue;
+	struct sk_buff_head	rx_q;
+	struct work_struct	rx_work;
+	struct sk_buff		*rx_skb;
+
+	wait_queue_head_t	p_wait_event_q;
+
+	unsigned int	subsys_reset;
+	unsigned int	chip_reset;
+	unsigned char	*rom_patch_bin_file_name;
+	unsigned int	chip_id;
+	unsigned int	flavor;
+	unsigned int	fw_version;
+	unsigned char	dongle_index;
+	unsigned char	power_state;
+	unsigned char	fops_state;
+	unsigned char	interface_state;
+	struct btmtk_cif_state *cif_state;
+
+	/* io buffer for usb control transfer */
+	unsigned char	*io_buf;
+
+	unsigned char	*setting_file;
+	unsigned char	*woble_setting_file_name;
+	unsigned int	woble_setting_len;
+
+	struct fw_cfg_struct	woble_setting_apcf[WOBLE_SETTING_COUNT];
+	struct fw_cfg_struct	woble_setting_apcf_fill_mac[WOBLE_SETTING_COUNT];
+	struct fw_cfg_struct	woble_setting_apcf_fill_mac_location[WOBLE_SETTING_COUNT];
+
+	struct fw_cfg_struct	woble_setting_radio_off;
+	struct fw_cfg_struct	woble_setting_wakeup_type;
+	struct fw_cfg_struct	woble_setting_radio_off_status_event;
+	/* complete event */
+	struct fw_cfg_struct	woble_setting_radio_off_comp_event;
+
+	struct fw_cfg_struct	woble_setting_radio_on;
+	struct fw_cfg_struct	woble_setting_radio_on_status_event;
+	struct fw_cfg_struct	woble_setting_radio_on_comp_event;
+
+	/* set apcf after resume(radio on) */
+	struct fw_cfg_struct	woble_setting_apcf_resume[WOBLE_SETTING_COUNT];
+	unsigned char	bdaddr[BD_ADDRESS_SIZE];
+	unsigned int	woble_need_trigger_coredump;
+	unsigned int	woble_need_set_radio_off_in_probe;
+
+	unsigned char		*bt_cfg_file_name;
+	struct bt_cfg_struct	bt_cfg;
+
+	/* Foe Woble eint */
+	unsigned int wobt_irq;
+	int wobt_irqlevel;
+	atomic_t irq_enable_count;
+	struct input_dev *WoBLEInputDev;
+
+	u8 opcode_usr[2];
+};
+
+typedef int (*cif_open_ptr)(struct hci_dev *hdev);
+typedef int (*cif_close_ptr)(struct hci_dev *hdev);
+typedef int (*cif_reg_read_ptr)(struct btmtk_dev *bdev, u32 reg, u32 *val);
+typedef int (*cif_reg_write_ptr)(struct btmtk_dev *bdev, u32 reg, u32 val);
+typedef int (*cif_send_cmd_ptr)(struct btmtk_dev *bdev, struct sk_buff *skb,
+		int delay, int retry, int pkt_type);
+typedef int (*cif_send_and_recv_ptr)(struct btmtk_dev *bdev,
+		struct sk_buff *skb,
+		const uint8_t *event, const int event_len,
+		int delay, int retry, int pkt_type);
+typedef int (*cif_event_filter_ptr)(struct btmtk_dev *bdev, struct sk_buff *skb);
+typedef int (*cif_subsys_reset_ptr)(struct btmtk_dev *bdev);
+typedef int (*cif_whole_reset_ptr)(struct btmtk_dev *bdev);
+typedef void (*cif_chip_reset_notify_ptr)(struct btmtk_dev *bdev);
+typedef void (*cif_mutex_lock_ptr)(struct btmtk_dev *bdev);
+typedef void (*cif_mutex_unlock_ptr)(struct btmtk_dev *bdev);
+typedef void (*cif_open_done_ptr)(struct btmtk_dev *bdev);
+typedef int (*cif_dl_dma_ptr)(struct btmtk_dev *bdev, u8 *image,
+		u8 *fwbuf, int section_dl_size, int section_offset);
+
+struct hif_hook_ptr {
+	cif_open_ptr			open;
+	cif_close_ptr			close;
+	cif_reg_read_ptr		reg_read;
+	cif_reg_write_ptr		reg_write;
+	cif_send_cmd_ptr		send_cmd;
+	cif_send_and_recv_ptr		send_and_recv;
+	cif_event_filter_ptr		event_filter;
+	cif_subsys_reset_ptr		subsys_reset;
+	cif_whole_reset_ptr		whole_reset;
+	cif_chip_reset_notify_ptr	chip_reset_notify;
+	cif_mutex_lock_ptr		cif_mutex_lock;
+	cif_mutex_unlock_ptr		cif_mutex_unlock;
+	cif_open_done_ptr		open_done;
+	cif_dl_dma_ptr			dl_dma;
+};
+
+struct btmtk_main_info {
+	u8 reset_stack_flag;
+	struct wakeup_source *fwdump_ws;
+	struct wakeup_source *woble_ws;
+	struct wakeup_source *eint_ws;
+	struct hif_hook_ptr hif_hook;
+	struct bt_power_setting PWS;
+};
+
+static inline int is_mt7922(u32 chip_id)
+{
+	chip_id &= 0xFFFF;
+	if (chip_id == 0x7922)
+		return 1;
+	return 0;
+}
+
+static inline int is_mt7961(u32 chip_id)
+{
+	chip_id &= 0xFFFF;
+	if (chip_id == 0x7961)
+		return 1;
+	return 0;
+}
+
+static inline int is_mt7663(u32 chip_id)
+{
+	chip_id &= 0xFFFF;
+	if (chip_id == 0x7663)
+		return 1;
+	return 0;
+}
+
+static inline int is_support_unify_woble(struct btmtk_dev *bdev)
+{
+	if (bdev->bt_cfg.support_unify_woble) {
+		if (is_mt7922(bdev->chip_id) ||
+		is_mt7961(bdev->chip_id) || is_mt7663(bdev->chip_id))
+			return 1;
+		else
+			return 0;
+	} else {
+		return 0;
+	}
+}
+
+int btmtk_get_chip_state(struct btmtk_dev *bdev);
+void btmtk_set_chip_state(struct btmtk_dev *bdev, int new_state);
+int btmtk_allocate_hci_device(struct btmtk_dev *bdev, int hci_bus_type);
+void btmtk_free_hci_device(struct btmtk_dev *bdev, int hci_bus_type);
+int btmtk_register_hci_device(struct btmtk_dev *bdev);
+int btmtk_deregister_hci_device(struct btmtk_dev *bdev);
+int btmtk_recv(struct hci_dev *hdev, const u8 *data, size_t count);
+int btmtk_recv_event(struct hci_dev *hdev, struct sk_buff *skb);
+int btmtk_recv_acl(struct hci_dev *hdev, struct sk_buff *skb);
+int btmtk_send_init_cmds(struct btmtk_dev *hdev);
+int btmtk_send_deinit_cmds(struct btmtk_dev *hdev);
+int btmtk_main_send_cmd(struct btmtk_dev *bdev, const uint8_t *cmd,
+		const int cmd_len, const uint8_t *event, const int event_len, int delay,
+		int retry, int pkt_type);
+int btmtk_send_wmt_reset(struct btmtk_dev *hdev);
+int btmtk_send_wmt_power_on_cmd(struct btmtk_dev *hdev);
+int btmtk_send_wmt_power_off_cmd(struct btmtk_dev *hdev);
+int btmtk_woble_suspend(struct btmtk_dev *bdev);
+int btmtk_woble_resume(struct btmtk_dev *bdev);
+int btmtk_handle_leaving_WoBLE_state(struct btmtk_dev *bdev);
+int btmtk_handle_entering_WoBLE_state(struct btmtk_dev *bdev);
+int btmtk_load_code_from_setting_files(char *setting_file_name,
+		struct device *dev, u32 *code_len, struct btmtk_dev *bdev);
+int btmtk_load_woble_setting(char *bin_name,
+		struct device *dev, u32 *code_len, struct btmtk_dev *bdev);
+int btmtk_load_rom_patch_766x(struct btmtk_dev *hdev);
+int btmtk_uart_send_wakeup_cmd(struct hci_dev *hdev);
+int btmtk_uart_send_set_uart_cmd(struct hci_dev *hdev);
+int btmtk_load_rom_patch(struct btmtk_dev *bdev);
+struct btmtk_dev *btmtk_get_dev(void);
+void btmtk_release_dev(struct btmtk_dev *bdev);
+struct btmtk_dev *btmtk_allocate_dev_memory(struct device *dev);
+void btmtk_free_dev_memory(struct device *dev, struct btmtk_dev *bdev);
+void btmtk_reset_waker(struct work_struct *work);
+void btmtk_initialize_cfg_items(struct btmtk_dev *bdev);
+bool btmtk_load_bt_cfg(char *cfg_name, struct device *dev, struct btmtk_dev *bdev);
+struct btmtk_main_info *btmtk_get_main_info(void);
+int btmtk_reset_power_on(struct btmtk_dev *bdev);
+void btmtk_send_hw_err_to_host(struct btmtk_dev *bdev);
+void btmtk_free_setting_file(struct btmtk_dev *bdev);
+/** file_operations: stpbtfwlog */
+int btmtk_fops_openfwlog(struct inode *inode, struct file *file);
+int btmtk_fops_closefwlog(struct inode *inode, struct file *file);
+ssize_t btmtk_fops_readfwlog(struct file *filp, char __user *buf, size_t count, loff_t *f_pos);
+ssize_t btmtk_fops_writefwlog(struct file *filp, const char __user *buf,
+			size_t count, loff_t *f_pos);
+unsigned int btmtk_fops_pollfwlog(struct file *filp, poll_table *wait);
+long btmtk_fops_unlocked_ioctlfwlog(struct file *filp, unsigned int cmd, unsigned long arg);
+
+/* Auto enable picus */
+int btmtk_picus_enable(struct btmtk_dev *bdev);
+int btmtk_picus_disable(struct btmtk_dev *bdev);
+
+void btmtk_hci_snoop_save_cmd(u32 len, u8 *buf);
+void btmtk_hci_snoop_save_event(u32 len, u8 *buf);
+void btmtk_hci_snoop_save_adv_event(u32 len, u8 *buf);
+void btmtk_hci_snoop_save_acl(u32 len, u8 *buf);
+void btmtk_hci_snoop_print(u32 len, const u8 *buf);
+unsigned long btmtk_kallsyms_lookup_name(const char *name);
+void btmtk_woble_wake_lock(struct btmtk_dev *bdev);
+void btmtk_woble_wake_unlock(struct btmtk_dev *bdev);
+void btmtk_reg_hif_hook(struct hif_hook_ptr *hook);
+int btmtk_main_cif_initialize(struct btmtk_dev *bdev, int hci_bus);
+void btmtk_main_cif_uninitialize(struct btmtk_dev *bdev, int hci_bus);
+int btmtk_main_woble_initialize(struct btmtk_dev *bdev);
+int btmtk_main_cif_disconnect_notify(struct btmtk_dev *bdev, int hci_bus);
+int btmtk_cif_send_calibration(struct btmtk_dev *bdev);
+int btmtk_send_assert_cmd(struct btmtk_dev *bdev);
+int btmtk_efuse_read(struct btmtk_dev *bdev, u16 addr, u8 *value);
+
+void btmtk_set_country_code_from_wifi(char *code);
+
+#endif /* __BTMTK_MAIN_H__ */
diff --git a/drivers/bluetooth/include/sdio/btmtk_sdio.h b/drivers/bluetooth/include/sdio/btmtk_sdio.h
new file mode 100644
index 000000000000..ae1067cea0e0
--- /dev/null
+++ b/drivers/bluetooth/include/sdio/btmtk_sdio.h
@@ -0,0 +1,147 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *  Copyright (c) 2016,2017 MediaTek Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *  See http://www.gnu.org/licenses/gpl-2.0.html for more details.
+ */
+
+#ifndef _BTMTK_SDIO_H_
+#define _BTMTK_SDIO_H_
+/* It's for reset procedure */
+#include <linux/mmc/sdio_ids.h>
+#include <linux/mmc/sdio_func.h>
+#include <linux/module.h>
+
+#include <linux/of_gpio.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/card.h>
+#include <linux/mmc/sdio.h>
+#include <linux/mmc/sdio_func.h>
+
+#include "btmtk_define.h"
+#include "btmtk_main.h"
+#include "btmtk_buffer_mode.h"
+
+#ifndef SDIO_DEBUG
+#define SDIO_DEBUG 0
+#endif
+
+/**
+ * Card-relate definition.
+ */
+#define SDIO_VENDOR_ID_MEDIATEK 0x037A
+
+#define HCI_HEADER_LEN	4
+
+#define MTK_STP_TLR_SIZE	2
+#define STP_HEADER_LEN	4
+#define STP_HEADER_CRC_LEN	2
+#define HCI_MAX_COMMAND_SIZE	255
+#define URB_MAX_BUFFER_SIZE	(4*1024)
+#define BTMTK_SDIO_FUNC 2
+
+
+/* common register address */
+#define CCIR		0x0000
+#define CHLPCR		0x0004
+#define CSDIOCSR	0x0008
+#define CHCR		0x000C
+#define CHISR		0x0010
+#define CHIER		0x0014
+#define CTDR		0x0018
+#define CRDR		0x001C
+#define CTFSR		0x0020
+#define CRPLR		0x0024
+#define PD2HRM0R	0x00DC
+#define SWPCDBGR	0x0154
+/* CHLPCR */
+#define C_FW_INT_EN_SET			0x00000001
+#define C_FW_INT_EN_CLEAR		0x00000002
+/* CHISR */
+#define RX_PKT_LEN				0xFFFF0000
+#define FIRMWARE_INT			0x0000FE00
+/* MCU notify host dirver for L0.5 reset */
+#define FIRMWARE_INT_BIT31		0x80000000
+/* MCU notify host driver for coredump */
+#define FIRMWARE_INT_BIT15		0x00008000
+#define TX_FIFO_OVERFLOW		0x00000100
+#define FW_INT_IND_INDICATOR	0x00000080
+#define TX_COMPLETE_COUNT		0x00000070
+#define TX_UNDER_THOLD			0x00000008
+#define TX_EMPTY				0x00000004
+#define RX_DONE					0x00000002
+#define FW_OWN_BACK_INT			0x00000001
+
+/* MCU address offset */
+#define MCU_ADDRESS_OFFSET_CMD 12
+#define MCU_ADDRESS_OFFSET_EVT 16
+
+/* wifi CR */
+#define CONDBGCR		0x0034
+#define CONDBGCR_SEL		0x0040
+#define SDIO_CTRL_EN		(1 << 31)
+#define WM_MONITER_SEL		(~(0x40000000))
+#define PC_MONITER_SEL		(~(0x20000000))
+#define PC_IDX_SWH(val, idx)	((val & (~(0x3F << 16))) | ((0x3F & idx) << 16))
+
+typedef int (*pdwnc_func) (u8 fgReset);
+typedef int (*reset_func_ptr2) (unsigned int gpio, int init_value);
+typedef int (*set_gpio_low)(u8 gpio);
+typedef int (*set_gpio_high)(u8 gpio);
+
+
+/**
+ * Send cmd dispatch evt
+ */
+#define HCI_EV_VENDOR			0xff
+#define SDIO_BLOCK_SIZE                 512
+#define SDIO_RW_RETRY_COUNT 500
+#define MTK_SDIO_PACKET_HEADER_SIZE 4
+
+/* Driver & FW own related */
+#define DRIVER_OWN 0
+#define FW_OWN 1
+#define SET_OWN_LOOP_COUNT 20
+
+struct btmtk_sdio_hdr {
+	/* For SDIO Header */
+	__le16	len;
+	__le16	reserved;
+	/* For hci type */
+	u8	bt_type;
+} __packed;
+
+struct btmtk_sdio_thread {
+	struct task_struct *task;
+	wait_queue_head_t wait_q;
+	void *priv;
+	u8 thread_status;
+};
+
+struct btmtk_sdio_dev {
+	struct sdio_func *func;
+
+	bool no_fw_own;
+	atomic_t int_count;
+	atomic_t tx_rdy;
+
+	/* TODO, need to confirm the max size of urb data, also need to confirm
+	 * whether intr_complete and bulk_complete and soc_complete can all share
+	 * this urb_transfer_buf
+	 */
+	unsigned char	*transfer_buf;
+	unsigned char	*sdio_packet;
+
+	struct sk_buff_head tx_queue;
+	struct btmtk_sdio_thread sdio_thread;
+
+	struct btmtk_buffer_mode_struct *buffer_mode;
+};
+#endif
diff --git a/drivers/bluetooth/include/uart/btmtk_uart.h b/drivers/bluetooth/include/uart/btmtk_uart.h
new file mode 100644
index 000000000000..e6f85778cee2
--- /dev/null
+++ b/drivers/bluetooth/include/uart/btmtk_uart.h
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *  Copyright (c) 2016,2017 MediaTek Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *  See http://www.gnu.org/licenses/gpl-2.0.html for more details.
+ */
+
+#ifndef _BTMTK_UART_H_
+#define _BTMTK_UART_H_
+#include "btmtk_define.h"
+
+
+#include <linux/tty.h>
+#include <linux/tty_driver.h>
+#include <linux/serial.h>
+
+#define HCI_HEADER_LEN	4
+
+struct mtk_stp_hdr {
+	u8	prefix;
+	__be16	dlen;
+	u8	cs;
+} __packed;
+#define MTK_STP_TLR_SIZE	2
+#define STP_HEADER_LEN	4
+#define STP_HEADER_CRC_LEN	2
+
+
+struct btmtk_uart_dev {
+	struct hci_dev	   *hdev;
+	struct tty_struct *tty;
+	unsigned long	hdev_flags;
+
+	/* For tx queue */
+	struct sk_buff		*tx_skb;
+	unsigned long		tx_state;
+
+	/* For rx queue */
+	struct sk_buff		*rx_skb;
+	unsigned long		rx_state;
+
+	struct sk_buff		*evt_skb;
+	wait_queue_head_t p_wait_event_q;
+
+	unsigned int		subsys_reset;
+
+	u8	stp_pad[6];
+	u8	stp_cursor;
+	u16	stp_dlen;
+};
+
+
+/**
+ * Maximum rom patch file name length
+ */
+#define MAX_BIN_FILE_NAME_LEN 32
+
+#define N_MTK        (15+1)
+/**
+ * Upper layeard IOCTL
+ */
+#define HCIUARTSETPROTO _IOW('U', 200, int)
+#define HCIUARTSETBAUD _IOW('U', 201, int)
+#define HCIUARTGETBAUD _IOW('U', 202, int)
+#define HCIUARTSETSTP _IOW('U', 203, int)
+#define HCIUARTLOADPATCH _IOW('U', 204, int)
+#define HCIUARTSETWAKEUP _IOW('U', 205, int)
+
+/**
+ * Send cmd dispatch evt
+ */
+#define RETRY_TIMES 10
+#define HCI_EV_VENDOR			0xff
+
+#define N_MTK        (15+1)
+
+int btmtk_cif_send_calibration(struct hci_dev *hdev);
+#endif
+
diff --git a/drivers/bluetooth/include/usb/btmtk_usb.h b/drivers/bluetooth/include/usb/btmtk_usb.h
new file mode 100644
index 000000000000..5c4b31783c25
--- /dev/null
+++ b/drivers/bluetooth/include/usb/btmtk_usb.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *  Copyright (c) 2016,2017 MediaTek Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *  See http://www.gnu.org/licenses/gpl-2.0.html for more details.
+ */
+
+#ifndef _BTMTK_USB_H_
+#define _BTMTK_USB_H_
+#include <linux/usb.h>
+#include "btmtk_define.h"
+#include "btmtk_main.h"
+
+#define HCI_MAX_COMMAND_SIZE	255
+#define URB_MAX_BUFFER_SIZE	(4*1024)
+
+#define BT0_MCU_INTERFACE_NUM 0
+#define BT1_MCU_INTERFACE_NUM 3
+#define BT_MCU_INTERFACE_NUM_MAX 4
+#define BT_MCU_NUM_MAX 2
+
+typedef int (*pdwnc_func) (u8 fgReset);
+typedef int (*reset_func_ptr2) (unsigned int gpio, int init_value);
+typedef int (*set_gpio_low)(u8 gpio);
+typedef int (*set_gpio_high)(u8 gpio);
+
+/**
+ * Send cmd dispatch evt
+ */
+#define HCI_EV_VENDOR			0xff
+#define HCI_USB_IO_BUF_SIZE		256
+
+
+/* UHW CR mapping */
+#define BT_MISC 0x70002510
+#define BT_SUBSYS_RST 0x70002610
+#define UDMA_INT_STA_BT 0x74000024
+#define UDMA_INT_STA_BT1 0x74000308
+#define BT_WDT_STATUS 0x740003A0
+#define EP_RST_OPT 0x74011890
+#define EP_RST_IN_OUT_OPT 0x00010001
+
+extern u8 wmt_over_hci_header[];
+
+struct btmtk_cif_chip_reset {
+	/* For Whole chip reset */
+	pdwnc_func pf_pdwndFunc;
+	reset_func_ptr2 pf_resetFunc2;
+	set_gpio_low pf_lowFunc;
+	set_gpio_high pf_highFunc;
+};
+
+struct btmtk_usb_dev {
+	struct usb_endpoint_descriptor	*intr_ep;
+	/* EP10 OUT */
+	struct usb_endpoint_descriptor	*intr_iso_tx_ep;
+	/* EP10 IN */
+	struct usb_endpoint_descriptor	*intr_iso_rx_ep;
+	/* BULK CMD EP1 OUT or EP 11 OUT */
+	struct usb_endpoint_descriptor	*bulk_cmd_tx_ep;
+	/* EP15 in for reset */
+	struct usb_endpoint_descriptor	*reset_intr_ep;
+	struct usb_endpoint_descriptor	*bulk_tx_ep;
+	struct usb_endpoint_descriptor	*bulk_rx_ep;
+	struct usb_endpoint_descriptor	*isoc_tx_ep;
+	struct usb_endpoint_descriptor	*isoc_rx_ep;
+
+	struct usb_device	*udev;
+	struct usb_interface	*intf;
+	struct usb_interface	*isoc;
+	struct usb_interface	*iso_channel;
+
+
+	struct usb_anchor	tx_anchor;
+	struct usb_anchor	intr_anchor;
+	struct usb_anchor	bulk_anchor;
+	struct usb_anchor	isoc_anchor;
+	struct usb_anchor	ctrl_anchor;
+	struct usb_anchor	ble_isoc_anchor;
+
+	__u8	cmdreq_type;
+	__u8	cmdreq;
+
+	int new_isoc_altsetting;
+	int new_isoc_altsetting_interface;
+
+	unsigned char	*o_usb_buf;
+
+	unsigned char	*urb_intr_buf;
+	unsigned char	*urb_bulk_buf;
+	unsigned char	*urb_ble_isoc_buf;
+};
+#endif
diff --git a/drivers/bluetooth/sdio/btmtksdio.c b/drivers/bluetooth/sdio/btmtksdio.c
new file mode 100644
index 000000000000..d686de310f4c
--- /dev/null
+++ b/drivers/bluetooth/sdio/btmtksdio.c
@@ -0,0 +1,2004 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/**
+ *  Copyright (c) 2018 MediaTek Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *  See http://www.gnu.org/licenses/gpl-2.0.html for more details.
+ */
+#include "btmtk_define.h"
+#include "btmtk_sdio.h"
+#include "btmtk_main.h"
+
+static char event_need_compare[EVENT_COMPARE_SIZE] = {0};
+static char event_need_compare_len;
+static char event_compare_status;
+const u8 READ_ADDRESS_EVENT[] = { 0x0E, 0x0A, 0x01, 0x09, 0x10, 0x00 };
+
+static DEFINE_MUTEX(btmtk_sdio_ops_mutex);
+#define SDIO_OPS_MUTEX_LOCK()	mutex_lock(&btmtk_sdio_ops_mutex)
+#define SDIO_OPS_MUTEX_UNLOCK()	mutex_unlock(&btmtk_sdio_ops_mutex)
+
+static DEFINE_MUTEX(btmtk_sdio_debug_mutex);
+#define SDIO_DEBUG_MUTEX_LOCK()	mutex_lock(&btmtk_sdio_debug_mutex)
+#define SDIO_DEBUG_MUTEX_UNLOCK()	mutex_unlock(&btmtk_sdio_debug_mutex)
+
+static int btmtk_sdio_readl(u32 offset,  u32 *val, struct sdio_func *func);
+static int btmtk_sdio_writel(u32 offset, u32 val, struct sdio_func *func);
+
+static int btmtk_sdio_read_bt_mcu_pc(u32 *val);
+static int btmtk_sdio_read_conn_infra_pc(u32 *val);
+
+#define DUMP_FW_PC(cif_dev)			\
+do {							\
+	u32 __value = 0;				\
+	btmtk_sdio_read_bt_mcu_pc(&__value);		\
+	BTMTK_INFO("%s, BT mcu pc: 0x%08X", __func__, __value);	\
+	btmtk_sdio_read_conn_infra_pc(&__value);	\
+	BTMTK_INFO("%s, conn infra pc: 0x%08X", __func__, __value);	\
+} while (0)
+
+static struct btmtk_sdio_dev g_sdio_dev;
+
+static const struct sdio_device_id btmtk_sdio_tabls[] = {
+	/* Mediatek SD8688 Bluetooth device */
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_MEDIATEK, 0x7663) },
+
+	/* Bring-up only */
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_MEDIATEK, 0x7668) },
+
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_MEDIATEK, 0x7961) },
+
+	{ }	/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(sdio, btmtk_sdio_tabls);
+
+#if SDIO_DEBUG
+#define RX_DEBUG_ENTRY_NUM 50
+enum {
+	CHISR_r_1 = 0,
+	CHISR_r_2,
+	CRPLR_r,
+	PD2HRM0R_r,
+	SDIO_DEBUG_CR_MAX,
+	RX_TIMESTAMP,
+	RX_BUF
+};
+
+struct rx_debug_struct {
+	unsigned int rx_intr_timestamp;
+	u32 cr[SDIO_DEBUG_CR_MAX];
+	u8 buf[16];
+};
+
+static struct rx_debug_struct rx_debug[RX_DEBUG_ENTRY_NUM];
+static int rx_debug_index;
+
+static int rx_done_cnt;
+static int tx_empty_cnt;
+static int intr_cnt;
+static int driver_own_cnt;
+static int fw_own_cnt;
+
+static unsigned int btmtk_sdio_hci_snoop_get_microseconds(void)
+{
+	struct timeval now;
+
+	do_gettimeofday(&now);
+	return now.tv_sec * 1000000 + now.tv_usec;
+}
+
+void rx_debug_print(void)
+{
+	int i;
+	int j = rx_debug_index;
+
+	BTMTK_ERR("%s: rx_done_cnt = %d, tx_empty_cnt = %d", __func__, rx_done_cnt, tx_empty_cnt);
+	BTMTK_ERR("intr_cnt = %d, driver_own_cnt = %d, fw_own_cnt = %d",
+		intr_cnt, driver_own_cnt, fw_own_cnt);
+	for (i = 0; i < RX_DEBUG_ENTRY_NUM; i++) {
+		BTMTK_ERR("%02d: timestamp = %u, CHISR_r_1 = 0x%08x, CHISR_r_2 = 0x%08x",
+			i, rx_debug[j].rx_intr_timestamp,
+			rx_debug[j].cr[CHISR_r_1], rx_debug[j].cr[CHISR_r_2]);
+		BTMTK_ERR("CRPLR = 0x%08x, PD2HRM0R = 0x%08x",
+			rx_debug[j].cr[CRPLR_r], rx_debug[j].cr[PD2HRM0R_r]);
+		BTMTK_ERR("buf = %02x %02x %02x %02x %02x %02x %02x",
+			rx_debug[j].buf[0], rx_debug[j].buf[1],
+			rx_debug[j].buf[2], rx_debug[j].buf[3],
+			rx_debug[j].buf[4], rx_debug[j].buf[5],
+			rx_debug[j].buf[6], rx_debug[j].buf[7]);
+		BTMTK_ERR("02x %02x %02x %02x %02x %02x %02x %02x %02x",
+			rx_debug[j].buf[8], rx_debug[j].buf[9],
+			rx_debug[j].buf[10], rx_debug[j].buf[11],
+			rx_debug[j].buf[12], rx_debug[j].buf[13],
+			rx_debug[j].buf[14], rx_debug[j].buf[15]);
+		if (j == 0)
+			j = RX_DEBUG_ENTRY_NUM;
+		j--;
+	}
+}
+
+void rx_debug_save(int type, u32 value, u8 *buf)
+{
+	switch (type) {
+	case CHISR_r_1:
+	case CHISR_r_2:
+	case CRPLR_r:
+	case PD2HRM0R_r:
+		rx_debug[rx_debug_index].cr[type] = value;
+		break;
+	case RX_TIMESTAMP:
+		rx_debug_index++;
+		if (rx_debug_index == RX_DEBUG_ENTRY_NUM)
+			rx_debug_index = 0;
+		rx_debug[rx_debug_index].rx_intr_timestamp =
+			btmtk_sdio_hci_snoop_get_microseconds();
+		break;
+	case RX_BUF:
+		memset(rx_debug[rx_debug_index].buf, 0, 16);
+		memcpy(rx_debug[rx_debug_index].buf, buf, 16);
+		break;
+	}
+}
+#endif
+
+static void btmtk_sdio_cif_mutex_lock(struct btmtk_dev *bdev)
+{
+	SDIO_OPS_MUTEX_LOCK();
+}
+
+static void btmtk_sdio_cif_mutex_unlock(struct btmtk_dev *bdev)
+{
+	SDIO_OPS_MUTEX_UNLOCK();
+}
+
+void btmtk_sdio_set_no_fwn_own(struct btmtk_sdio_dev *cif_dev, int flag)
+{
+	if (cif_dev->no_fw_own != flag)
+		BTMTK_INFO("%s set no_fw_own %d", __func__, flag);
+	cif_dev->no_fw_own = flag;
+}
+
+int btmtk_sdio_set_own_back(struct btmtk_sdio_dev *cif_dev, int owntype, int retry)
+{
+	/*Set driver own*/
+	int ret = 0;
+	u32 u32LoopCount = 0;
+	u32 u32PollNum = 0;
+	u32 u32ReadCRValue = 0;
+	u32 ownValue = 0;
+	int i = 0;
+
+	BTMTK_DBG("%s owntype %d", __func__, owntype);
+
+	if (owntype == FW_OWN) {
+		if (cif_dev->no_fw_own)
+			return ret;
+	}
+
+	ret = btmtk_sdio_readl(CHLPCR, &u32ReadCRValue, cif_dev->func);
+
+	BTMTK_DBG("%s CHLPCR = 0x%0x", __func__, u32ReadCRValue);
+
+	/* For CHLPCR, bit 8 could help us to check driver own or fw own
+	 * 0: COM driver doesn't have ownership
+	 * 1: COM driver has ownership
+	 */
+	if (owntype == DRIVER_OWN &&
+			(u32ReadCRValue & 0x100) == 0x100) {
+		goto set_own_end;
+	} else if (owntype == FW_OWN &&
+			(u32ReadCRValue & 0x100) == 0) {
+		goto set_own_end;
+	}
+
+	if (owntype == DRIVER_OWN)
+		ownValue = 0x00000200;
+	else
+		ownValue = 0x00000100;
+
+retry_own:
+	/* Write CR for Driver or FW own */
+	ret = btmtk_sdio_writel(CHLPCR, ownValue, cif_dev->func);
+	if (ret) {
+		ret = -EINVAL;
+		goto done;
+	}
+
+	u32LoopCount = SET_OWN_LOOP_COUNT;
+
+	if (owntype == DRIVER_OWN) {
+		do {
+			usleep_range(100, 200);
+			ret = btmtk_sdio_readl(CHLPCR, &u32ReadCRValue, cif_dev->func);
+			u32LoopCount--;
+			u32PollNum++;
+			BTMTK_DBG("%s DRIVER_OWN btmtk_sdio_readl(%d) CHLPCR 0x%x",
+				__func__, u32PollNum, u32ReadCRValue);
+		} while ((u32LoopCount > 0) &&
+			((u32ReadCRValue & 0x100) != 0x100));
+
+		if ((u32LoopCount == 0) && (0x100 != (u32ReadCRValue & 0x100))
+				&& (retry > 0)) {
+			BTMTK_WARN("%s retry set_check driver own(%d), CHLPCR 0x%x",
+				__func__, u32PollNum, u32ReadCRValue);
+			for (i = 0; i < 3; i++)
+				DUMP_FW_PC(cif_dev);
+
+			retry--;
+			mdelay(5);
+			goto retry_own;
+		}
+	} else {
+		/*
+		 * Can't check result for fw_own
+		 * Because it will wakeup sdio hw
+		 */
+		goto done;
+	}
+
+	BTMTK_DBG("%s CHLPCR(0x%x), is 0x%x",
+		__func__, CHLPCR, u32ReadCRValue);
+
+	if (owntype == DRIVER_OWN) {
+		if ((u32ReadCRValue & 0x100) == 0x100) {
+			BTMTK_DBG("%s check %04x, is 0x100 driver own success",
+				__func__, CHLPCR);
+		} else {
+			BTMTK_DBG("%s check %04x, is %x shuld be 0x100",
+				__func__, CHLPCR, u32ReadCRValue);
+			ret = -EINVAL;
+			goto done;
+		}
+	}
+
+done:
+	if (owntype == DRIVER_OWN) {
+#if SDIO_DEBUG
+		driver_own_cnt++;
+#endif
+		if (ret) {
+			BTMTK_ERR("%s set driver own fail", __func__);
+			for (i = 0; i < 8; i++) {
+				DUMP_FW_PC(cif_dev);
+				msleep(200);
+			}
+		} else
+			BTMTK_DBG("%s set driver own success", __func__);
+	} else if (owntype == FW_OWN) {
+#if SDIO_DEBUG
+		fw_own_cnt++;
+#endif
+		if (ret)
+			BTMTK_ERR("%s set FW own fail", __func__);
+		else
+			BTMTK_DBG("%s set FW own success", __func__);
+	} else
+		BTMTK_ERR("%s unknown type %d", __func__, owntype);
+
+set_own_end:
+	return ret;
+}
+
+static int btmtk_sdio_read_register(struct btmtk_dev *bdev, u32 reg, u32 *val)
+{
+	int ret;
+	u8 cmd[] = {0x01, 0x6F, 0xFC, 0x0C,
+				0x01, 0x08, 0x08, 0x00,
+				0x02, 0x01, 0x00, 0x01,
+				0x00, 0x00, 0x00, 0x00};
+
+	u8 event[] = {0x04, 0xE4, 0x10, 0x02,
+			0x08, 0x0C, 0x00, 0x00,
+			0x00, 0x00, 0x01};
+
+	BTMTK_INFO("%s: read cr %x", __func__, reg);
+
+	memcpy(&cmd[MCU_ADDRESS_OFFSET_CMD], &reg, sizeof(reg));
+
+	ret = btmtk_main_send_cmd(bdev, cmd, sizeof(cmd), event, sizeof(event), 20,
+			20, BTMTK_TX_CMD_FROM_DRV);
+
+	memcpy(val, bdev->io_buf + MCU_ADDRESS_OFFSET_EVT - HCI_TYPE_SIZE, sizeof(u32));
+	*val = le32_to_cpu(*val);
+
+	BTMTK_INFO("%s: reg=%x, value=0x%08x", __func__, reg, *val);
+
+	return 0;
+}
+
+static int btmtk_sdio_write_register(struct btmtk_dev *bdev, u32 reg, u32 val)
+{
+	BTMTK_INFO("%s: reg=%x, value=0x%08x, not support", __func__, reg, val);
+	return 0;
+}
+
+int btmtk_cif_send_calibration(struct btmtk_dev *bdev)
+{
+	return 0;
+}
+
+static int btmtk_cif_allocate_memory(struct btmtk_sdio_dev *cif_dev)
+{
+	if (cif_dev->transfer_buf == NULL) {
+		cif_dev->transfer_buf = kzalloc(URB_MAX_BUFFER_SIZE, GFP_KERNEL);
+		if (!cif_dev->transfer_buf) {
+			BTMTK_ERR("%s: alloc memory fail (bdev->transfer_buf)", __func__);
+			return -1;
+		}
+	}
+
+	if (cif_dev->sdio_packet == NULL) {
+		cif_dev->sdio_packet = kzalloc(URB_MAX_BUFFER_SIZE, GFP_KERNEL);
+		if (!cif_dev->sdio_packet) {
+			BTMTK_ERR("%s: alloc memory fail (bdev->transfer_buf)", __func__);
+			return -1;
+		}
+	}
+
+	BTMTK_INFO("%s: Done", __func__);
+	return 0;
+}
+
+static void btmtk_cif_free_memory(struct btmtk_sdio_dev *cif_dev)
+{
+	kfree(cif_dev->transfer_buf);
+	cif_dev->transfer_buf = NULL;
+
+	kfree(cif_dev->sdio_packet);
+	cif_dev->sdio_packet = NULL;
+
+	BTMTK_INFO("%s: Success", __func__);
+}
+
+int btmtk_sdio_read_wifi_mcu_pc(u8 PcLogSel, u32 *val)
+{
+	int ret = 0;
+	unsigned int value = 0;
+
+	if (!g_sdio_dev.func)
+		return -EINVAL;
+
+	SDIO_DEBUG_MUTEX_LOCK();
+
+	ret = btmtk_sdio_readl(CONDBGCR_SEL, &value, g_sdio_dev.func);
+	value |= SDIO_CTRL_EN;
+	value &= WM_MONITER_SEL;
+	value &= PC_MONITER_SEL;
+	value = PC_IDX_SWH(value, PcLogSel);
+
+	ret = btmtk_sdio_writel(CONDBGCR_SEL, value, g_sdio_dev.func);
+	ret = btmtk_sdio_readl(CONDBGCR, val, g_sdio_dev.func);
+
+	SDIO_DEBUG_MUTEX_UNLOCK();
+
+	return 0;
+}
+EXPORT_SYMBOL(btmtk_sdio_read_wifi_mcu_pc);
+
+int btmtk_sdio_read_bt_mcu_pc(u32 *val)
+{
+	if (!g_sdio_dev.func)
+		return -EINVAL;
+
+	SDIO_DEBUG_MUTEX_LOCK();
+
+	btmtk_sdio_writel(0x30, 0xFD, g_sdio_dev.func);
+	btmtk_sdio_readl(0x2c, val, g_sdio_dev.func);
+
+	SDIO_DEBUG_MUTEX_UNLOCK();
+
+	return 0;
+}
+EXPORT_SYMBOL(btmtk_sdio_read_bt_mcu_pc);
+
+int btmtk_sdio_read_conn_infra_pc(u32 *val)
+{
+	if (!g_sdio_dev.func)
+		return -EINVAL;
+
+	SDIO_DEBUG_MUTEX_LOCK();
+
+	btmtk_sdio_writel(0x3C, 0x9F1E0000, g_sdio_dev.func);
+	btmtk_sdio_readl(0x38, val, g_sdio_dev.func);
+
+	SDIO_DEBUG_MUTEX_UNLOCK();
+
+	return 0;
+}
+EXPORT_SYMBOL(btmtk_sdio_read_conn_infra_pc);
+
+static int btmtk_sdio_open(struct hci_dev *hdev)
+{
+	struct btmtk_dev *bdev = hci_get_drvdata(hdev);
+	struct btmtk_sdio_dev *cif_dev = (struct btmtk_sdio_dev *)bdev->cif_dev;
+
+	BTMTK_INFO("%s enter!", __func__);
+	skb_queue_purge(&cif_dev->tx_queue);
+
+#if SDIO_DEBUG
+	rx_done_cnt = 0;
+	tx_empty_cnt = 0;
+	intr_cnt = 0;
+	driver_own_cnt = 0;
+	fw_own_cnt = 0;
+#endif
+
+	return 0;
+}
+
+static int btmtk_sdio_close(struct hci_dev *hdev)
+{
+	struct btmtk_dev *bdev = hci_get_drvdata(hdev);
+
+	BTMTK_INFO("%s enter!", __func__);
+	cancel_work_sync(&bdev->reset_waker);
+	return 0;
+}
+
+static void btmtk_sdio_open_done(struct btmtk_dev *bdev)
+{
+	struct btmtk_sdio_dev *cif_dev = (struct btmtk_sdio_dev *)bdev->cif_dev;
+
+	BTMTK_INFO("%s enter!", __func__);
+	(void)btmtk_buffer_mode_send(cif_dev->buffer_mode);
+}
+
+static int btmtk_sdio_writesb(u32 offset, u8 *val, int len, struct sdio_func *func)
+{
+	u32 ret = 0;
+	u32 retry_count = 0;
+
+	if (!func) {
+		BTMTK_ERR("%s func is NULL", __func__);
+		return -EIO;
+	}
+
+	do {
+		sdio_claim_host(func);
+		ret = sdio_writesb(func, offset, val, len);
+		sdio_release_host(func);
+		retry_count++;
+		if (retry_count > SDIO_RW_RETRY_COUNT) {
+			BTMTK_ERR(" %s, ret:%d", __func__, ret);
+			break;
+		}
+	} while (ret);
+
+	return ret;
+}
+
+static int btmtk_sdio_readsb(u32 offset, u8 *val, int len, struct sdio_func *func)
+{
+	u32 ret = 0;
+	u32 retry_count = 0;
+
+	if (!func) {
+		BTMTK_ERR("%s func is NULL", __func__);
+		return -EIO;
+	}
+
+	do {
+		sdio_claim_host(func);
+		ret = sdio_readsb(func, val, offset, len);
+		sdio_release_host(func);
+		retry_count++;
+		if (retry_count > SDIO_RW_RETRY_COUNT) {
+			BTMTK_ERR(" %s, ret:%d", __func__, ret);
+			break;
+		}
+	} while (ret);
+
+	return ret;
+}
+
+int btmtk_sdio_writeb(u32 offset, u8 val, struct sdio_func *func)
+{
+	u32 ret = 0;
+	u32 retry_count = 0;
+
+	if (!func) {
+		BTMTK_ERR("%s func is NULL", __func__);
+		return -EIO;
+	}
+
+	do {
+		sdio_claim_host(func);
+		sdio_writeb(func, val, offset, &ret);
+		sdio_release_host(func);
+		retry_count++;
+		if (retry_count > SDIO_RW_RETRY_COUNT) {
+			BTMTK_ERR(" %s, ret:%d", __func__, ret);
+			break;
+		}
+	} while (ret);
+
+	return ret;
+}
+
+int btmtk_sdio_writel(u32 offset, u32 val, struct sdio_func *func)
+{
+	u32 ret = 0;
+	u32 retry_count = 0;
+
+	if (!func) {
+		BTMTK_ERR("%s func is NULL", __func__);
+		return -EIO;
+	}
+
+	do {
+		sdio_claim_host(func);
+		sdio_writel(func, val, offset, &ret);
+		sdio_release_host(func);
+		retry_count++;
+		if (retry_count > SDIO_RW_RETRY_COUNT) {
+			BTMTK_ERR(" %s, ret:%d", __func__, ret);
+			break;
+		}
+	} while (ret);
+
+	return ret;
+}
+
+int btmtk_sdio_readl(u32 offset,  u32 *val, struct sdio_func *func)
+{
+	u32 ret = 0;
+	u32 retry_count = 0;
+
+	if (!func) {
+		BTMTK_ERR("func is NULL");
+		return -EIO;
+	}
+
+	do {
+		sdio_claim_host(func);
+		*val = sdio_readl(func, offset, &ret);
+		sdio_release_host(func);
+		retry_count++;
+		if (retry_count > SDIO_RW_RETRY_COUNT) {
+			BTMTK_ERR(" %s, ret:%d", __func__, ret);
+			break;
+		}
+	} while (ret);
+
+	return ret;
+}
+
+static int btmtk_sdio_readb(u32 offset, u8 *val, struct sdio_func *func)
+{
+	u32 ret = 0;
+	u32 retry_count = 0;
+
+	if (!func) {
+		BTMTK_ERR("%s func is NULL", __func__);
+		return -EIO;
+	}
+
+	do {
+		sdio_claim_host(func);
+		*val = sdio_readb(func, offset, &ret);
+		sdio_release_host(func);
+		retry_count++;
+		if (retry_count > SDIO_RW_RETRY_COUNT) {
+			BTMTK_ERR(" %s, ret:%d", __func__, ret);
+			break;
+		}
+	} while (ret);
+
+	return ret;
+}
+
+static void btmtk_sdio_print_debug_sr(struct btmtk_sdio_dev *cif_dev)
+{
+	u32 ret = 0;
+	u32 CCIR_Value = 0;
+	u32 CHLPCR_Value = 0;
+	u32 CSDIOCSR_Value = 0;
+	u32 CHISR_Value = 0;
+	u32 CHIER_Value = 0;
+	u32 CTFSR_Value = 0;
+	u32 CRPLR_Value = 0;
+	u32 SWPCDBGR_Value = 0;
+	unsigned char X0_Value = 0;
+	unsigned char X4_Value = 0;
+	unsigned char X5_Value = 0;
+	unsigned char F8_Value = 0;
+	unsigned char F9_Value = 0;
+	unsigned char FA_Value = 0;
+	unsigned char FB_Value = 0;
+	unsigned char FC_Value = 0;
+	unsigned char FD_Value = 0;
+	unsigned char FE_Value = 0;
+	unsigned char FF_Value = 0;
+
+	ret = btmtk_sdio_readl(CCIR, &CCIR_Value, cif_dev->func);
+	ret = btmtk_sdio_readl(CHLPCR, &CHLPCR_Value, cif_dev->func);
+	ret = btmtk_sdio_readl(CSDIOCSR, &CSDIOCSR_Value, cif_dev->func);
+	ret = btmtk_sdio_readl(CHISR, &CHISR_Value, cif_dev->func);
+	ret = btmtk_sdio_readl(CHIER, &CHIER_Value, cif_dev->func);
+	ret = btmtk_sdio_readl(CTFSR, &CTFSR_Value, cif_dev->func);
+	ret = btmtk_sdio_readl(CRPLR, &CRPLR_Value, cif_dev->func);
+	ret = btmtk_sdio_readl(SWPCDBGR, &SWPCDBGR_Value, cif_dev->func);
+	sdio_claim_host(cif_dev->func);
+	X0_Value = sdio_f0_readb(cif_dev->func, 0x00, &ret);
+	X4_Value = sdio_f0_readb(cif_dev->func, 0x04, &ret);
+	X5_Value = sdio_f0_readb(cif_dev->func, 0x05, &ret);
+	F8_Value = sdio_f0_readb(cif_dev->func, 0xF8, &ret);
+	F9_Value = sdio_f0_readb(cif_dev->func, 0xF9, &ret);
+	FA_Value = sdio_f0_readb(cif_dev->func, 0xFA, &ret);
+	FB_Value = sdio_f0_readb(cif_dev->func, 0xFB, &ret);
+	FC_Value = sdio_f0_readb(cif_dev->func, 0xFC, &ret);
+	FD_Value = sdio_f0_readb(cif_dev->func, 0xFD, &ret);
+	FE_Value = sdio_f0_readb(cif_dev->func, 0xFE, &ret);
+	FF_Value = sdio_f0_readb(cif_dev->func, 0xFF, &ret);
+	sdio_release_host(cif_dev->func);
+	BTMTK_INFO("CCIR: 0x%x, CHLPCR: 0x%x, CSDIOCSR: 0x%x, CHISR: 0x%x",
+		CCIR_Value, CHLPCR_Value, CSDIOCSR_Value, CHISR_Value);
+	BTMTK_INFO("CHIER: 0x%x, CTFSR: 0x%x, CRPLR: 0x%x, SWPCDBGR: 0x%x",
+		CHIER_Value, CTFSR_Value, CRPLR_Value, SWPCDBGR_Value);
+	BTMTK_INFO("CCCR 00: 0x%x, 04: 0x%x, 05: 0x%x",
+		X0_Value, X4_Value, X5_Value);
+	BTMTK_INFO("F8: 0x%x, F9: 0x%x, FA: 0x%x, FB: 0x%x",
+		F8_Value, F9_Value, FA_Value, FB_Value);
+	BTMTK_INFO("FC: 0x%x, FD: 0x%x, FE: 0x%x, FF: 0x%x",
+		FC_Value, FD_Value, FE_Value, FF_Value);
+}
+
+static int btmtk_sdio_enable_interrupt(int enable, struct sdio_func *func)
+{
+	u32 ret = 0;
+	u32 cr_value = 0;
+
+	BTMTK_DBG("%s enable=%d", __func__, enable);
+	if (enable)
+		cr_value |= C_FW_INT_EN_SET;
+	else
+		cr_value |= C_FW_INT_EN_CLEAR;
+
+	ret = btmtk_sdio_writel(CHLPCR, cr_value, func);
+
+	return ret;
+}
+
+int btmtk_sdio_send_cmd(struct btmtk_dev *bdev, struct sk_buff *skb,
+		int delay, int retry, int pkt_type)
+{
+	int ret = 0;
+	u32 crAddr = 0, crValue = 0;
+	ulong flags;
+	struct btmtk_sdio_dev *cif_dev = NULL;
+
+	/* for fw assert */
+	u8 fw_assert_cmd[] = { 0x01, 0x5B, 0xFD, 0x00 };
+	u8 fw_assert_cmd1[] = { 0x01, 0x6F, 0xFC, 0x05, 0x01, 0x02, 0x01, 0x00, 0x08 };
+	/* for read/write CR */
+	u8 notify_alt_evt[] = {0x0E, 0x04, 0x01, 0x03, 0x0c, 0x00};
+	struct sk_buff *evt_skb;
+
+	if (bdev == NULL) {
+		BTMTK_ERR("bdev is NULL");
+		ret = -1;
+		kfree_skb(skb);
+		skb = NULL;
+		goto exit;
+	}
+	cif_dev = (struct btmtk_sdio_dev *)bdev->cif_dev;
+	if (cif_dev == NULL) {
+		BTMTK_ERR("cif_dev is NULL, bdev=%p", bdev);
+		ret = -1;
+		kfree_skb(skb);
+		skb = NULL;
+		goto exit;
+	}
+
+	/* For read write CR */
+	if (skb->len > 9) {
+		if (skb->data[0] == 0x01 && skb->data[1] == 0x6f && skb->data[2] == 0xfc &&
+				skb->data[3] == 0x0D && skb->data[4] == 0x01 &&
+				skb->data[5] == 0xff && skb->data[6] == 0x09 &&
+				skb->data[7] == 0x00 && skb->data[8] == 0x02) {
+			crAddr = ((skb->data[9] & 0xff) << 24) + ((skb->data[10] & 0xff) << 16)
+				+ ((skb->data[11] & 0xff) << 8) + (skb->data[12] & 0xff);
+			crValue = ((skb->data[13] & 0xff) << 24) + ((skb->data[14] & 0xff) << 16)
+				+ ((skb->data[15] & 0xff) << 8) + (skb->data[16] & 0xff);
+
+			BTMTK_INFO("%s crAddr=0x%08x crValue=0x%08x",
+				__func__, crAddr, crValue);
+
+			btmtk_sdio_writel(crAddr, crValue, cif_dev->func);
+			evt_skb = skb_copy(skb, GFP_KERNEL);
+			bt_cb(evt_skb)->pkt_type = HCI_EVENT_PKT;
+			notify_alt_evt[2] = (crValue & 0xFF000000) >> 24;
+			notify_alt_evt[3] = (crValue & 0x00FF0000) >> 16;
+			notify_alt_evt[4] = (crValue & 0x0000FF00) >> 8;
+			notify_alt_evt[5] = (crValue & 0x000000FF);
+			memcpy(evt_skb->data, &notify_alt_evt, sizeof(notify_alt_evt));
+			evt_skb->len = sizeof(notify_alt_evt);
+			hci_recv_frame(bdev->hdev, evt_skb);
+			kfree_skb(skb);
+			skb = NULL;
+			goto exit;
+		} else	if (skb->data[0] == 0x01 && skb->data[1] == 0x6f && skb->data[2] == 0xfc &&
+				skb->data[3] == 0x09 && skb->data[4] == 0x01 &&
+				skb->data[5] == 0xff && skb->data[6] == 0x05 &&
+				skb->data[7] == 0x00 && skb->data[8] == 0x01) {
+
+			crAddr = ((skb->data[9] & 0xff) << 24) + ((skb->data[10] & 0xff) << 16) +
+				((skb->data[11]&0xff) << 8) + (skb->data[12]&0xff);
+
+			btmtk_sdio_readl(crAddr, &crValue, cif_dev->func);
+			BTMTK_INFO("%s read crAddr=0x%08x crValue=0x%08x",
+					__func__, crAddr, crValue);
+			evt_skb = skb_copy(skb, GFP_KERNEL);
+			bt_cb(evt_skb)->pkt_type = HCI_EVENT_PKT;
+			//memcpy(&notify_alt_evt[2], &crValue, sizeof(crValue));
+			notify_alt_evt[2] = (crValue & 0xFF000000) >> 24;
+			notify_alt_evt[3] = (crValue & 0x00FF0000) >> 16;
+			notify_alt_evt[4] = (crValue & 0x0000FF00) >> 8;
+			notify_alt_evt[5] = (crValue & 0x000000FF);
+			memcpy(evt_skb->data, &notify_alt_evt, sizeof(notify_alt_evt));
+			evt_skb->len = sizeof(notify_alt_evt);
+			hci_recv_frame(bdev->hdev, evt_skb);
+			kfree_skb(skb);
+			skb = NULL;
+			goto exit;
+		}
+	}
+
+	if (skb->data[0] == 0x02 && skb->data[1] == 0x00 && skb->data[2] == 0x44) {
+		/* it's for ble iso, remove speicific header
+		 * 02 00 44 len_a len_b + payload to 05 + payload
+		 */
+		skb_pull(skb, 4);
+		skb->data[0] = HCI_ISO_PKT;
+	}
+
+	if ((skb->len == sizeof(fw_assert_cmd) &&
+		!memcmp(skb->data, fw_assert_cmd, sizeof(fw_assert_cmd)))
+		|| (skb->len == sizeof(fw_assert_cmd1) &&
+		!memcmp(skb->data, fw_assert_cmd1, sizeof(fw_assert_cmd1)))) {
+		BTMTK_INFO_RAW(skb->data, skb->len, "%s: Trigger FW assert, dump CR", __func__);
+#if SDIO_DEBUG
+		rx_debug_print();
+#endif
+		btmtk_sdio_set_own_back(cif_dev, DRIVER_OWN, 20);
+		btmtk_sdio_set_no_fwn_own(cif_dev, 1);
+		btmtk_sdio_print_debug_sr(cif_dev);
+	}
+
+	spin_lock_irqsave(&bdev->txlock, flags);
+	skb_queue_tail(&cif_dev->tx_queue, skb);
+	spin_unlock_irqrestore(&bdev->txlock, flags);
+	wake_up_interruptible(&cif_dev->sdio_thread.wait_q);
+
+exit:
+	return ret;
+}
+
+static int btmtk_cif_recv_evt(struct btmtk_dev *bdev)
+{
+	int ret = 0;
+	u32 u32ReadCRValue = 0;
+	u32 u32ReadCRLEN = 0;
+	u32 sdio_header_length = 0;
+	int rx_length = 0;
+	int payload = 0;
+	u16 hci_pkt_len = 0;
+	u8 hci_type = 0;
+	struct btmtk_sdio_dev *cif_dev = (struct btmtk_sdio_dev *)bdev->cif_dev;
+
+	memset(bdev->io_buf, 0, IO_BUF_SIZE);
+
+	/* keep polling method */
+	/* If interrupt method is working, we can remove it */
+	ret = btmtk_sdio_readl(CHISR, &u32ReadCRValue, cif_dev->func);
+	BTMTK_DBG("%s: loop Get CHISR 0x%08X",
+		__func__, u32ReadCRValue);
+#if SDIO_DEBUG
+	rx_debug_save(CHISR_r_2, u32ReadCRValue, NULL);
+#endif
+
+	ret = btmtk_sdio_readl(CRPLR, &u32ReadCRLEN, cif_dev->func);
+#if SDIO_DEBUG
+	rx_debug_save(CRPLR_r, u32ReadCRLEN, NULL);
+#endif
+
+	rx_length = (u32ReadCRLEN & RX_PKT_LEN) >> 16;
+	if (rx_length == 0xFFFF || rx_length == 0) {
+		BTMTK_WARN("%s: rx_length = %d, error return -EIO", __func__, rx_length);
+		return -EIO;
+	}
+
+	BTMTK_DBG("%s: u32ReadCRValue = %08X", __func__, u32ReadCRValue);
+	u32ReadCRValue &= 0xFFFB;
+	ret = btmtk_sdio_writel(CHISR, u32ReadCRValue, cif_dev->func);
+	BTMTK_DBG("%s: write = %08X", __func__, u32ReadCRValue);
+	ret = btmtk_sdio_readl(PD2HRM0R, &u32ReadCRValue, cif_dev->func);
+#if SDIO_DEBUG
+	rx_debug_save(PD2HRM0R_r, u32ReadCRValue, NULL);
+#endif
+
+	ret = btmtk_sdio_readsb(CRDR, cif_dev->transfer_buf, rx_length, cif_dev->func);
+#if SDIO_DEBUG
+	rx_debug_save(RX_BUF, 0, cif_dev->transfer_buf);
+#endif
+	sdio_header_length = (cif_dev->transfer_buf[1] << 8);
+	sdio_header_length |= cif_dev->transfer_buf[0];
+	if (sdio_header_length != rx_length) {
+		BTMTK_ERR("%s sdio header length %d, rx_length %d mismatch, trigger assert",
+			__func__, sdio_header_length, rx_length);
+		BTMTK_INFO_RAW(cif_dev->transfer_buf, rx_length, "%s: raw data is :", __func__);
+		btmtk_send_assert_cmd(bdev);
+		return -EIO;
+	}
+
+	BTMTK_DBG_RAW(cif_dev->transfer_buf, rx_length, "%s: raw data is :", __func__);
+
+	hci_type = cif_dev->transfer_buf[MTK_SDIO_PACKET_HEADER_SIZE];
+	switch (hci_type) {
+	/* Please reference hci header format
+	 * A = len
+	 * acl : 02 xx_a xx_b AA AA + payload
+	 * sco : 03 xx_c xx_d AA + payload
+	 * evt : 04 xx AA + payload
+	 * ISO : 05 xx_e xx_f AA_a AA_b + payload
+	 */
+	case HCI_ACLDATA_PKT:
+		hci_pkt_len = cif_dev->transfer_buf[MTK_SDIO_PACKET_HEADER_SIZE + 3] +
+				(cif_dev->transfer_buf[MTK_SDIO_PACKET_HEADER_SIZE + 4] << 8) + 5;
+		break;
+	case HCI_SCODATA_PKT:
+		hci_pkt_len = cif_dev->transfer_buf[MTK_SDIO_PACKET_HEADER_SIZE + 4] + 4;
+		break;
+	case HCI_EVENT_PKT:
+		hci_pkt_len = cif_dev->transfer_buf[MTK_SDIO_PACKET_HEADER_SIZE + 2] + 3;
+		break;
+	case HCI_ISO_PKT:
+		hci_pkt_len = cif_dev->transfer_buf[MTK_SDIO_PACKET_HEADER_SIZE + 3] +
+				(cif_dev->transfer_buf[MTK_SDIO_PACKET_HEADER_SIZE + 4] << 8) + 4;
+		bdev->io_buf[0] = HCI_ACLDATA_PKT;
+		bdev->io_buf[1] = 0x00;
+		bdev->io_buf[2] = 0x44;
+		bdev->io_buf[3] = (hci_pkt_len & 0x00ff);
+		bdev->io_buf[4] = ((hci_pkt_len & 0xff00) >> 8);
+		memcpy(bdev->io_buf + 5, cif_dev->transfer_buf +
+				MTK_SDIO_PACKET_HEADER_SIZE + 1, hci_pkt_len);
+		memset(cif_dev->transfer_buf, 0, URB_MAX_BUFFER_SIZE);
+		hci_pkt_len += 5;
+		memcpy(cif_dev->transfer_buf + MTK_SDIO_PACKET_HEADER_SIZE,
+				bdev->io_buf, hci_pkt_len);
+		BTMTK_DBG_RAW(cif_dev->transfer_buf, hci_pkt_len, "%s: raw data is :", __func__);
+		break;
+	}
+	ret = hci_pkt_len;
+	bdev->recv_evt_len = hci_pkt_len;
+
+	BTMTK_DBG("%s sdio header length %d, rx_length %d, hci_pkt_len = %d",
+			__func__, sdio_header_length, rx_length, hci_pkt_len);
+	ret = btmtk_recv(bdev->hdev, cif_dev->transfer_buf +
+			MTK_SDIO_PACKET_HEADER_SIZE, hci_pkt_len);
+	if (cif_dev->transfer_buf[4] == HCI_EVENT_PKT) {
+		payload = rx_length - cif_dev->transfer_buf[6] - 3;
+		ret = rx_length - MTK_SDIO_PACKET_HEADER_SIZE - payload;
+	}
+
+	BTMTK_DBG("%s: done", __func__);
+	return ret;
+}
+
+int btmtk_sdio_event_filter(struct btmtk_dev *bdev, struct sk_buff *skb)
+{
+	if (event_compare_status == BTMTK_EVENT_COMPARE_STATE_NEED_COMPARE &&
+		skb->len >= event_need_compare_len) {
+		if (memcmp(skb->data, READ_ADDRESS_EVENT,
+			sizeof(READ_ADDRESS_EVENT)) == 0 && (skb->len == 12)) {
+			memcpy(bdev->bdaddr, &skb->data[6], BD_ADDRESS_SIZE);
+			BTMTK_INFO("GET BDADDR = %02X:%02X:%02X:%02X:%02X:%02X",
+				bdev->bdaddr[0], bdev->bdaddr[1], bdev->bdaddr[2],
+				bdev->bdaddr[3], bdev->bdaddr[4], bdev->bdaddr[5]);
+
+			event_compare_status = BTMTK_EVENT_COMPARE_STATE_COMPARE_SUCCESS;
+		} else if (memcmp(skb->data, event_need_compare,
+					event_need_compare_len) == 0) {
+			/* if it is wobx debug event, just print in kernel log, drop it
+			 * by driver, don't send to stack
+			 */
+			if (skb->data[0] == 0xE8)
+				BTMTK_INFO_RAW(skb->data, skb->len,
+					"%s: wobx debug log:", __func__);
+
+			/* If driver need to check result from skb, it can get from io_buf */
+			/* Such as chip_id, fw_version, etc. */
+			memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
+			memcpy(bdev->io_buf, skb->data, skb->len);
+			event_compare_status = BTMTK_EVENT_COMPARE_STATE_COMPARE_SUCCESS;
+			BTMTK_DBG("%s, compare success", __func__);
+		} else {
+			BTMTK_INFO("%s compare fail", __func__);
+			BTMTK_INFO_RAW(event_need_compare, event_need_compare_len,
+				"%s: event_need_compare:", __func__);
+			BTMTK_INFO_RAW(skb->data, skb->len, "%s: skb->data:", __func__);
+			return 0;
+		}
+
+		return 1;
+	}
+
+	return 0;
+}
+
+int btmtk_sdio_send_and_recv(struct btmtk_dev *bdev,
+		struct sk_buff *skb,
+		const uint8_t *event, const int event_len,
+		int delay, int retry, int pkt_type)
+{
+	unsigned long comp_event_timo = 0, start_time = 0;
+	int ret = -1;
+
+	if (event) {
+		if (event_len > EVENT_COMPARE_SIZE) {
+			BTMTK_ERR("%s, event_len (%d) > EVENT_COMPARE_SIZE(%d), error",
+				__func__, event_len, EVENT_COMPARE_SIZE);
+			ret = -1;
+			goto exit;
+		}
+		event_compare_status = BTMTK_EVENT_COMPARE_STATE_NEED_COMPARE;
+		memcpy(event_need_compare, event + 1, event_len - 1);
+		event_need_compare_len = event_len - 1;
+
+		start_time = jiffies;
+		/* check hci event /wmt event for SDIO/UART interface, check hci
+		 * event for USB interface
+		 */
+		comp_event_timo = jiffies + msecs_to_jiffies(WOBLE_COMP_EVENT_TIMO);
+		BTMTK_DBG("event_need_compare_len %d, event_compare_status %d",
+			event_need_compare_len, event_compare_status);
+	} else {
+		event_compare_status = BTMTK_EVENT_COMPARE_STATE_COMPARE_SUCCESS;
+	}
+
+	BTMTK_DBG_RAW(skb->data, skb->len, "%s, send, len = %d", __func__, skb->len);
+
+	ret = btmtk_sdio_send_cmd(bdev, skb, delay, retry, pkt_type);
+	if (ret < 0) {
+		BTMTK_ERR("%s btmtk_sdio_send_cmd failed!!", __func__);
+		goto exit;
+	}
+
+	do {
+		/* check if event_compare_success */
+		if (event_compare_status == BTMTK_EVENT_COMPARE_STATE_COMPARE_SUCCESS) {
+			ret = 0;
+			break;
+		}
+		usleep_range(10, 100);
+	} while (time_before(jiffies, comp_event_timo));
+
+	event_compare_status = BTMTK_EVENT_COMPARE_STATE_NOTHING_NEED_COMPARE;
+exit:
+	return ret;
+}
+
+static void btmtk_sdio_interrupt(struct sdio_func *func)
+{
+	struct btmtk_dev *bdev;
+	struct btmtk_sdio_dev *cif_dev;
+
+#if SDIO_DEBUG
+	rx_debug_save(RX_TIMESTAMP, 0, NULL);
+	intr_cnt++;
+#endif
+
+	bdev = sdio_get_drvdata(func);
+	if (!bdev)
+		return;
+	cif_dev = (struct btmtk_sdio_dev *)bdev->cif_dev;
+
+	btmtk_sdio_enable_interrupt(0, cif_dev->func);
+	atomic_set(&cif_dev->int_count, 1);
+	wake_up_interruptible(&cif_dev->sdio_thread.wait_q);
+}
+
+static int btmtk_sdio_load_fw_patch_using_dma(struct btmtk_dev *bdev, u8 *image,
+		u8 *fwbuf, int section_dl_size, int section_offset)
+{
+	int cur_len = 0;
+	int ret = -1;
+	s32 sent_len = 0;
+	s32 sdio_len = 0;
+	u32 u32ReadCRValue = 0;
+	u32 block_count = 0;
+	u32 redundant = 0;
+	u32 delay_count = 0;
+	struct btmtk_sdio_dev *cif_dev = NULL;
+	u8 cmd[] = {0x02, 0x6F, 0xFC, 0x05, 0x00, 0x01, 0x01, 0x01, 0x00, PATCH_PHASE3};
+	u8 event[] = {0x04, 0xE4, 0x05, 0x02, 0x01, 0x01, 0x00, 0x00}; /* event[7] is status*/
+
+	cif_dev = (struct btmtk_sdio_dev *)bdev->cif_dev;
+
+	if (bdev == NULL || image == NULL || fwbuf == NULL) {
+		BTMTK_ERR("%s: invalid parameters!", __func__);
+		return -1;
+	}
+
+	BTMTK_INFO("%s: loading rom patch... start", __func__);
+	btmtk_sdio_enable_interrupt(0, cif_dev->func);
+	while (section_dl_size != cur_len) {
+		if (!atomic_read(&cif_dev->tx_rdy)) {
+			ret = btmtk_sdio_readl(CHISR, &u32ReadCRValue, cif_dev->func);
+			if ((TX_EMPTY & u32ReadCRValue) != 0) {
+				ret = btmtk_sdio_writel(CHISR,
+					(TX_EMPTY | TX_COMPLETE_COUNT), cif_dev->func);
+				if (ret != 0) {
+					BTMTK_ERR("%s: btmtk_sdio_writel fail", __func__);
+					goto enable_intr;
+				}
+				atomic_set(&cif_dev->tx_rdy, 1);
+			} else if (delay_count > 1000) {
+				BTMTK_ERR("%s: delay_count > 1000", __func__);
+				goto enable_intr;
+			} else {
+				udelay(200);
+				++delay_count;
+				continue;
+			}
+		}
+
+		sent_len = (section_dl_size - cur_len) >= UPLOAD_PATCH_UNIT ?
+			UPLOAD_PATCH_UNIT : (section_dl_size - cur_len);
+
+		BTMTK_DBG("%s: sent_len = %d, cur_len = %d, delay_count = %d",
+			  __func__, sent_len, cur_len, delay_count);
+
+		sdio_len = sent_len + MTK_SDIO_PACKET_HEADER_SIZE;
+		memset(image, 0, sdio_len);
+		image[0] = (sdio_len & 0x00FF);
+		image[1] = (sdio_len & 0xFF00) >> 8;
+		image[2] = 0;
+		image[3] = 0;
+
+		memcpy(image + MTK_SDIO_PACKET_HEADER_SIZE,
+			fwbuf + section_offset + cur_len,
+			sent_len);
+
+		block_count = sdio_len / SDIO_BLOCK_SIZE;
+		redundant = sdio_len % SDIO_BLOCK_SIZE;
+		if (redundant)
+			sdio_len = (block_count + 1) * SDIO_BLOCK_SIZE;
+
+		ret = btmtk_sdio_writesb(CTDR, image, sdio_len, cif_dev->func);
+		atomic_set(&cif_dev->tx_rdy, 0);
+		cur_len += sent_len;
+
+		if (ret < 0) {
+			BTMTK_ERR("%s: send patch failed, terminate", __func__);
+			goto enable_intr;
+		}
+	}
+	btmtk_sdio_enable_interrupt(1, cif_dev->func);
+
+	BTMTK_INFO("%s: send dl cmd", __func__);
+	ret = btmtk_main_send_cmd(bdev,
+			cmd, sizeof(cmd), event, sizeof(event),
+			PATCH_DOWNLOAD_PHASE3_DELAY_TIME,
+			PATCH_DOWNLOAD_PHASE3_RETRY,
+			BTMTK_TX_ACL_FROM_DRV);
+	if (ret < 0) {
+		BTMTK_ERR("%s: send wmd dl cmd failed, terminate!", __func__);
+		return ret;
+	}
+
+	BTMTK_INFO("%s: loading rom patch... Done", __func__);
+	return ret;
+
+enable_intr:
+	btmtk_sdio_enable_interrupt(1, cif_dev->func);
+	return ret;
+}
+
+static int btmtk_sdio_register_dev(struct btmtk_sdio_dev *bdev)
+{
+	struct sdio_func *func;
+	u8	u8ReadCRValue = 0;
+	int ret = 0;
+
+	if (!bdev || !bdev->func) {
+		BTMTK_ERR("Error: card or function is NULL!");
+		ret = -EINVAL;
+		goto failed;
+	}
+
+	func = bdev->func;
+
+	sdio_claim_host(func);
+	ret = sdio_enable_func(func);
+	sdio_release_host(func);
+	if (ret) {
+		BTMTK_ERR("sdio_enable_func() failed: ret=%d", ret);
+		ret = -EIO;
+		goto failed;
+	}
+
+	btmtk_sdio_readb(SDIO_CCCR_IENx, &u8ReadCRValue, func);
+	BTMTK_INFO("before claim irq read SDIO_CCCR_IENx %x, func num %d",
+		u8ReadCRValue, func->num);
+
+	sdio_claim_host(func);
+	ret = sdio_claim_irq(func, btmtk_sdio_interrupt);
+	sdio_release_host(func);
+	if (ret) {
+		BTMTK_ERR("sdio_claim_irq failed: ret=%d", ret);
+		ret = -EIO;
+		goto disable_func;
+	}
+
+	BTMTK_INFO("sdio_claim_irq success: ret=%d", ret);
+
+	btmtk_sdio_readb(SDIO_CCCR_IENx, &u8ReadCRValue, func);
+	BTMTK_INFO("after claim irq read SDIO_CCCR_IENx %x", u8ReadCRValue);
+
+	sdio_claim_host(func);
+	ret = sdio_set_block_size(func, SDIO_BLOCK_SIZE);
+	sdio_release_host(func);
+	if (ret) {
+		pr_err("cannot set SDIO block size");
+		ret = -EIO;
+		goto release_irq;
+	}
+
+
+	return 0;
+
+release_irq:
+	sdio_release_irq(func);
+
+disable_func:
+	sdio_disable_func(func);
+
+failed:
+	pr_info("%s fail", __func__);
+	return ret;
+}
+
+static int btmtk_sdio_enable_host_int(struct btmtk_sdio_dev *cif_dev)
+{
+	int ret;
+	u32 read_data = 0;
+
+	if (!cif_dev || !cif_dev->func)
+		return -EINVAL;
+
+	/* workaround for some platform no host clock sometimes */
+
+	btmtk_sdio_readl(CSDIOCSR, &read_data, cif_dev->func);
+	BTMTK_INFO("%s read CSDIOCSR is 0x%X", __func__, read_data);
+	read_data |= 0x4;
+	btmtk_sdio_writel(CSDIOCSR, read_data, cif_dev->func);
+	BTMTK_INFO("%s write CSDIOCSR is 0x%X", __func__, read_data);
+
+	return ret;
+}
+
+static int btmtk_sdio_unregister_dev(struct btmtk_sdio_dev *cif_dev)
+{
+	if (cif_dev && cif_dev->func) {
+		sdio_claim_host(cif_dev->func);
+		sdio_release_irq(cif_dev->func);
+		sdio_disable_func(cif_dev->func);
+		sdio_release_host(cif_dev->func);
+		sdio_set_drvdata(cif_dev->func, NULL);
+	}
+	return 0;
+}
+
+static int btmtk_sdio_set_write_clear(struct btmtk_sdio_dev *cif_dev)
+{
+	u32 u32ReadCRValue = 0;
+	u32 ret = 0;
+
+	ret = btmtk_sdio_readl(CHCR, &u32ReadCRValue, cif_dev->func);
+	if (ret) {
+		BTMTK_ERR("%s read CHCR error", __func__);
+		ret = EINVAL;
+		return ret;
+	}
+
+	u32ReadCRValue |= 0x00000002;
+	btmtk_sdio_writel(CHCR, u32ReadCRValue, cif_dev->func);
+	BTMTK_INFO("%s write CHCR 0x%08X", __func__, u32ReadCRValue);
+	ret = btmtk_sdio_readl(CHCR, &u32ReadCRValue, cif_dev->func);
+	BTMTK_INFO("%s read CHCR 0x%08X", __func__, u32ReadCRValue);
+	if (u32ReadCRValue&0x00000002)
+		BTMTK_INFO("%s write clear", __func__);
+	else
+		BTMTK_INFO("%s read clear", __func__);
+
+	return ret;
+}
+
+static int btmtk_sdio_poll_subsys_done(struct btmtk_sdio_dev *cif_dev)
+{
+	u32 u32ReadCRValue = 0;
+	int retry = 100;
+
+//	btmtk_sdio_writel(0x30, 0xFD, cif_dev->func);
+//	BTMTK_INFO("%s write 0x30 = 0xFD, retry = %d", __func__, retry);
+	while (retry-- > 0) {
+//		btmtk_sdio_readl(0x2c, &u32ReadCRValue, cif_dev->func);
+//		BTMTK_INFO("%s read 0x2c = 0x%08X, retry = %d", __func__, u32ReadCRValue, retry);
+//		btmtk_sdio_readl(CHLPCR, &u32ReadCRValue, cif_dev->func);
+//		BTMTK_INFO("%s read CHLPCR 0x%08X, retry = %d", __func__, u32ReadCRValue, retry);
+//		btmtk_sdio_readl(SWPCDBGR, &u32ReadCRValue, cif_dev->func);
+//		BTMTK_INFO("%s read SWPCDBGR 0x%08X, retry = %d", __func__, u32ReadCRValue, retry);
+		btmtk_sdio_readl(CHCR, &u32ReadCRValue, cif_dev->func);
+		BTMTK_INFO("%s read CHCR 0x%08X, retry = %d", __func__, u32ReadCRValue, retry);
+		if (u32ReadCRValue & (0x1 << 8))
+			return 0;
+		msleep(20);
+	}
+
+	return -1;
+}
+
+static int btmtk_sdio_subsys_reset(struct btmtk_dev *bdev)
+{
+	struct btmtk_sdio_dev *cif_dev = (struct btmtk_sdio_dev *)bdev->cif_dev;
+	u32 u32ReadCRValue = 0;
+	u32 ret = 0;
+
+	btmtk_sdio_set_no_fwn_own(cif_dev, 1);
+	btmtk_sdio_set_own_back(cif_dev, DRIVER_OWN, 20);
+
+	/* write CHCR[3] 0 */
+	ret = btmtk_sdio_readl(CHCR, &u32ReadCRValue, cif_dev->func);
+	BTMTK_INFO("%s read CHCR 0x%08X", __func__, u32ReadCRValue);
+	u32ReadCRValue &= 0xFFFFFFF7;
+	BTMTK_INFO("%s write CHCR 0x%08X", __func__, u32ReadCRValue);
+	btmtk_sdio_writel(CHCR, u32ReadCRValue, cif_dev->func);
+
+	/* write CHCR[3] to 1 */
+	ret = btmtk_sdio_readl(CHCR, &u32ReadCRValue, cif_dev->func);
+	BTMTK_INFO("%s read CHCR 0x%08X", __func__, u32ReadCRValue);
+	u32ReadCRValue |= 0x00000008;
+	BTMTK_INFO("%s write CHCR 0x%08X", __func__, u32ReadCRValue);
+	btmtk_sdio_writel(CHCR, u32ReadCRValue, cif_dev->func);
+
+	/* write CHCR[5] to 0 */
+	ret = btmtk_sdio_readl(CHCR, &u32ReadCRValue, cif_dev->func);
+	BTMTK_INFO("%s read CHCR 0x%08X", __func__, u32ReadCRValue);
+	u32ReadCRValue &= 0xFFFFFFDF;
+	BTMTK_INFO("%s write CHCR 0x%08X", __func__, u32ReadCRValue);
+	btmtk_sdio_writel(CHCR, u32ReadCRValue, cif_dev->func);
+
+	/* write CHCR[5] to 1 */
+	ret = btmtk_sdio_readl(CHCR, &u32ReadCRValue, cif_dev->func);
+	BTMTK_INFO("%s read CHCR 0x%08X", __func__, u32ReadCRValue);
+	u32ReadCRValue |= 0x00000020;
+	BTMTK_INFO("%s write CHCR 0x%08X", __func__, u32ReadCRValue);
+	btmtk_sdio_writel(CHCR, u32ReadCRValue, cif_dev->func);
+
+	/* Poll subsys reset done */
+	if (btmtk_sdio_poll_subsys_done(cif_dev))
+		return -EIO;
+
+	/* Do-init cr */
+	/* Disable the interrupts on the card */
+	btmtk_sdio_enable_host_int(cif_dev);
+	BTMTK_DBG("call btmtk_sdio_enable_host_int done");
+
+	/* Set interrupt output */
+	ret = btmtk_sdio_writel(CHIER, FIRMWARE_INT_BIT31 | FIRMWARE_INT|TX_FIFO_OVERFLOW |
+			FW_INT_IND_INDICATOR | TX_COMPLETE_COUNT |
+			TX_UNDER_THOLD | TX_EMPTY | RX_DONE, cif_dev->func);
+	if (ret) {
+		BTMTK_ERR("Set interrupt output fail(%d)", ret);
+		ret = -EIO;
+		return ret;
+	}
+
+	/* Enable interrupt output */
+	ret = btmtk_sdio_writel(CHLPCR, C_FW_INT_EN_SET, cif_dev->func);
+	if (ret) {
+		BTMTK_ERR("enable interrupt output fail(%d)", ret);
+		ret = -EIO;
+		return ret;
+	}
+
+	/* Adopt write clear method */
+	btmtk_sdio_set_write_clear(cif_dev);
+
+	ret = btmtk_sdio_readl(0, &u32ReadCRValue, cif_dev->func);
+	BTMTK_INFO("%s read chipid =  %x", __func__, u32ReadCRValue);
+
+	return ret;
+}
+
+static int btmtk_sdio_whole_reset(struct btmtk_dev *bdev)
+{
+	int ret = -1;
+	struct btmtk_sdio_dev *cif_dev = (struct btmtk_sdio_dev *)bdev->cif_dev;
+	struct mmc_card *card = cif_dev->func->card;
+	struct mmc_host *host = NULL;
+
+	if ((card == NULL) || (card->host  == NULL)) {
+		BTMTK_ERR("mmc structs are NULL");
+		return ret;
+	}
+
+	host = card->host;
+	if (host->rescan_entered != 0) {
+		host->rescan_entered = 0;
+		BTMTK_INFO("set mmc_host rescan to 0");
+	}
+
+	BTMTK_INFO("mmc_remove_host");
+	mmc_remove_host(host);
+
+	/* Replace hooked SDIO driver probe to new API;
+	 * 1. It will be new kthread(state) after mmc_add_host;
+	 * 2. Extend flexibility to notify us that HW reset was triggered,
+	 * more flexiable on reviving in exchanging old/new kthread(state).
+	 */
+	BTMTK_INFO("mmc_add_host");
+	ret = mmc_add_host(host);
+
+	BTMTK_INFO("mmc_add_host return %d", ret);
+	return ret;
+}
+
+/* bt_tx_wait_for_msg
+ *
+ *    Check needing action of current bt status to wake up bt thread
+ *
+ * Arguments:
+ *    [IN] bdev     - bt driver control strcuture
+ *
+ * Return Value:
+ *    return check  - 1 for waking up bt thread, 0 otherwise
+ *
+ */
+static bool btmtk_thread_wait_for_msg(struct btmtk_sdio_dev *cif_dev)
+{
+	if (!skb_queue_empty(&cif_dev->tx_queue)) {
+		BTMTK_DBG("tx queue is not empty");
+		return true;
+	}
+
+	if (atomic_read(&cif_dev->int_count)) {
+		BTMTK_DBG("cif_dev->int_count is %d", atomic_read(&cif_dev->int_count));
+		return true;
+	}
+
+	if (kthread_should_stop()) {
+		BTMTK_DBG("kthread_should_stop");
+		return true;
+	}
+
+	return false;
+}
+
+static int btmtk_tx_pkt(struct btmtk_sdio_dev *cif_dev, struct sk_buff *skb)
+{
+	u8 MultiBluckCount = 0;
+	u8 redundant = 0;
+	int len = 0;
+	int ret = 0;
+
+	BTMTK_DBG("btmtk_tx_pkt");
+
+	cif_dev->sdio_packet[0] = (4 + skb->len) & 0xFF;
+	cif_dev->sdio_packet[1] = ((4 + skb->len) & 0xFF00) >> 8;
+
+	memcpy(cif_dev->sdio_packet + MTK_SDIO_PACKET_HEADER_SIZE, skb->data,
+		skb->len);
+	len = skb->len + MTK_SDIO_PACKET_HEADER_SIZE;
+	BTMTK_DBG_RAW(cif_dev->sdio_packet, len,
+			"%s: sent, len =%d:", __func__, len);
+
+	MultiBluckCount = len / SDIO_BLOCK_SIZE;
+	redundant = len % SDIO_BLOCK_SIZE;
+	if (redundant)
+		len = (MultiBluckCount+1)*SDIO_BLOCK_SIZE;
+
+	atomic_set(&cif_dev->tx_rdy, 0);
+	ret = btmtk_sdio_writesb(CTDR, cif_dev->sdio_packet, len, cif_dev->func);
+	if (ret < 0)
+		BTMTK_ERR("ret = %d", ret);
+	kfree_skb(skb);
+	return ret;
+}
+
+static int btmtk_sdio_interrupt_process(struct btmtk_dev *bdev)
+{
+	struct btmtk_sdio_dev *cif_dev = (struct btmtk_sdio_dev *)bdev->cif_dev;
+	int ret = 0;
+	u32 u32ReadCRValue = 0;
+
+	ret = btmtk_sdio_readl(CHISR, &u32ReadCRValue, cif_dev->func);
+#if SDIO_DEBUG
+	rx_debug_save(CHISR_r_1, u32ReadCRValue, NULL);
+#endif
+	BTMTK_DBG("%s CHISR 0x%08x", __func__, u32ReadCRValue);
+
+	if (u32ReadCRValue & FIRMWARE_INT_BIT15)
+		btmtk_sdio_set_no_fwn_own(cif_dev, 1);
+
+	if (u32ReadCRValue & FIRMWARE_INT_BIT31) {
+		/* It's read-only bit (WDT interrupt)
+		 * Host can't modify it.
+		 */
+		ret = btmtk_sdio_readl(CHISR, &u32ReadCRValue, cif_dev->func);
+		BTMTK_INFO("%s CHISR 0x%08x", __func__, u32ReadCRValue);
+		/* FW can't send TX_EMPTY for 0xFD5B */
+		atomic_set(&cif_dev->tx_rdy, 1);
+		schedule_work(&bdev->reset_waker);
+		return ret;
+	}
+
+	if (TX_EMPTY & u32ReadCRValue) {
+		ret = btmtk_sdio_writel(CHISR, (TX_EMPTY | TX_COMPLETE_COUNT), cif_dev->func);
+		atomic_set(&cif_dev->tx_rdy, 1);
+		BTMTK_DBG("%s set tx_rdy true", __func__);
+#if SDIO_DEBUG
+		tx_empty_cnt++;
+#endif
+	}
+
+	if (RX_DONE & u32ReadCRValue)
+		ret = btmtk_cif_recv_evt(bdev);
+
+	ret = btmtk_sdio_enable_interrupt(1, cif_dev->func);
+	BTMTK_DBG("%s done, ret = %d", __func__, ret);
+	return ret;
+}
+
+
+/*
+ * This function handles the event generated by firmware, rx data
+ * received from firmware, and tx data sent from kernel.
+ */
+static int btmtk_sdio_main_thread(void *data)
+{
+	struct btmtk_dev *bdev = data;
+	struct btmtk_sdio_dev *cif_dev = NULL;
+	struct sk_buff *skb;
+	int ret = 0;
+	ulong flags;
+//	struct sched_param param = { .sched_priority = 90 };/*RR 90 is the same as audio*/
+
+	cif_dev = (struct btmtk_sdio_dev *)bdev->cif_dev;
+
+//	sched_setscheduler(current, SCHED_RR, &param);
+
+	BTMTK_INFO("%s start running...", __func__);
+	for (;;) {
+		wait_event_interruptible(cif_dev->sdio_thread.wait_q,
+				btmtk_thread_wait_for_msg(cif_dev));
+		if (kthread_should_stop()) {
+			BTMTK_WARN("sdio_thread: break from main thread");
+			break;
+		}
+		BTMTK_DBG("%s doing...", __func__);
+
+		ret = btmtk_sdio_set_own_back(cif_dev, DRIVER_OWN, 20);
+		if (ret) {
+			BTMTK_ERR("set driver own return fail");
+			schedule_work(&bdev->reset_waker);
+			continue;
+		}
+
+		/* Do interrupt */
+		if (atomic_read(&cif_dev->int_count)) {
+			BTMTK_DBG("go int");
+//			spin_lock_irqsave(&bdev->rxlock, flags);
+			atomic_set(&cif_dev->int_count, 0);
+//			spin_unlock_irqrestore(&bdev->rxlock, flags);
+			if (btmtk_sdio_interrupt_process(bdev)) {
+				schedule_work(&bdev->reset_waker);
+				continue;
+			}
+		} else {
+			BTMTK_DBG("go tx");
+		}
+
+		/* Do TX */
+		if (!atomic_read(&cif_dev->tx_rdy)) {
+			BTMTK_DBG("tx_rdy == 0, continue");
+			continue;
+		}
+
+		spin_lock_irqsave(&bdev->txlock, flags);
+		skb = skb_dequeue(&cif_dev->tx_queue);
+		spin_unlock_irqrestore(&bdev->txlock, flags);
+		if (skb) {
+			ret = btmtk_tx_pkt(cif_dev, skb);
+			if (ret) {
+				BTMTK_ERR("tx pkt return fail %d", ret);
+				schedule_work(&bdev->reset_waker);
+				continue;
+			}
+		}
+
+		/* Confirm with Travis later */
+		/* Travis Hsieh: */
+		/* It shall be fine to set FW_OWN if no more task to do in this thread */
+		if (skb_queue_empty(&cif_dev->tx_queue)) {
+			ret = btmtk_sdio_set_own_back(cif_dev, FW_OWN, 20);
+			if (ret) {
+				BTMTK_ERR("set fw own return fail");
+				schedule_work(&bdev->reset_waker);
+			}
+		}
+	}
+
+	BTMTK_WARN("end");
+	return 0;
+}
+
+static int btmtk_sdio_probe(struct sdio_func *func,
+					const struct sdio_device_id *id)
+{
+	int err = -1;
+	struct btmtk_dev *bdev = NULL;
+	struct btmtk_sdio_dev *cif_dev = NULL;
+
+	bdev = sdio_get_drvdata(func);
+	if (!bdev) {
+		BTMTK_ERR("[ERR] bdev is NULL");
+		return -ENOMEM;
+	}
+
+	cif_dev = (struct btmtk_sdio_dev *)bdev->cif_dev;
+
+	cif_dev->func = func;
+	BTMTK_INFO("%s func device %p", __func__, func);
+
+	/* it's for L0/L0.5 reset */
+	INIT_WORK(&bdev->reset_waker, btmtk_reset_waker);
+	spin_lock_init(&bdev->txlock);
+	spin_lock_init(&bdev->rxlock);
+
+	if (btmtk_sdio_register_dev(cif_dev) < 0) {
+		BTMTK_ERR("Failed to register BT device!");
+		return -ENODEV;
+	}
+
+	/* Disable the interrupts on the card */
+	btmtk_sdio_enable_host_int(cif_dev);
+	BTMTK_DBG("call btmtk_sdio_enable_host_int done");
+
+	sdio_set_drvdata(func, bdev);
+
+	btmtk_sdio_set_own_back(cif_dev, DRIVER_OWN, 20);
+	btmtk_sdio_set_no_fwn_own(cif_dev, 1);
+
+	/* create tx/rx thread */
+	init_waitqueue_head(&cif_dev->sdio_thread.wait_q);
+	skb_queue_head_init(&cif_dev->tx_queue);
+	atomic_set(&cif_dev->int_count, 0);
+	atomic_set(&cif_dev->tx_rdy, 1);
+	cif_dev->sdio_thread.task = kthread_run(btmtk_sdio_main_thread,
+				bdev, "btmtk_sdio_main_thread");
+	if (IS_ERR(cif_dev->sdio_thread.task)) {
+		BTMTK_DBG("btmtk_sdio_ps failed to start!");
+		err = PTR_ERR(cif_dev->sdio_thread.task);
+		goto unreg_sdio;
+
+	}
+
+	/* Set interrupt output */
+	err = btmtk_sdio_writel(CHIER, FIRMWARE_INT_BIT31 | FIRMWARE_INT_BIT15 |
+			FIRMWARE_INT|TX_FIFO_OVERFLOW |
+			FW_INT_IND_INDICATOR | TX_COMPLETE_COUNT |
+			TX_UNDER_THOLD | TX_EMPTY | RX_DONE, cif_dev->func);
+	if (err) {
+		BTMTK_ERR("Set interrupt output fail(%d)", err);
+		err = -EIO;
+		goto free_thread;
+	}
+
+	/* Enable interrupt output */
+	err = btmtk_sdio_writel(CHLPCR, C_FW_INT_EN_SET, cif_dev->func);
+	if (err) {
+		BTMTK_ERR("enable interrupt output fail(%d)", err);
+		err = -EIO;
+		goto free_thread;
+	}
+
+	/* write clear method */
+	btmtk_sdio_set_write_clear(cif_dev);
+
+	/* old method for chip id
+	 * btmtk_sdio_readl(0, &u32ReadCRValue, bdev->func);
+	 * BTMTK_INFO("%s read chipid =  %x", __func__, u32ReadCRValue);
+	 */
+
+	err = btmtk_cif_allocate_memory(cif_dev);
+	if (err < 0) {
+		BTMTK_ERR("[ERR] btmtk_cif_allocate_memory failed!");
+		goto free_thread;
+	}
+
+	err = btmtk_main_cif_initialize(bdev, HCI_SDIO);
+	if (err < 0) {
+		BTMTK_ERR("[ERR] btmtk_main_cif_initialize failed!");
+		goto free_mem;
+	}
+
+	err = btmtk_load_rom_patch(bdev);
+	if (err < 0) {
+		BT_ERR("btmtk load rom patch failed!");
+		goto deinit;
+	}
+
+	err = btmtk_main_woble_initialize(bdev);
+	if (err < 0) {
+		BT_ERR("btmtk_main_woble_initialize failed!");
+		goto free_setting;
+	}
+
+	btmtk_buffer_mode_initialize(bdev, &cif_dev->buffer_mode);
+
+	err = btmtk_register_hci_device(bdev);
+	if (err < 0) {
+		BT_ERR("btmtk_register_hci_device failed!");
+		goto free_setting;
+	}
+
+	btmtk_sdio_writel(0x40, 0x9F1E0000, cif_dev->func);
+
+	goto end;
+
+free_setting:
+	btmtk_free_setting_file(bdev);
+deinit:
+	btmtk_main_cif_uninitialize(bdev, HCI_USB);
+free_mem:
+	btmtk_cif_free_memory(cif_dev);
+free_thread:
+	kthread_stop(cif_dev->sdio_thread.task);
+	wake_up_interruptible(&cif_dev->sdio_thread.wait_q);
+	BTMTK_INFO("wake_up_interruptible main_thread done");
+unreg_sdio:
+	btmtk_sdio_unregister_dev(cif_dev);
+end:
+	BTMTK_INFO("%s normal end, ret = %d", __func__, err);
+	btmtk_sdio_set_no_fwn_own(cif_dev, 0);
+	btmtk_sdio_set_own_back(cif_dev, FW_OWN, 20);
+
+	return 0;
+}
+
+static void btmtk_sdio_disconnect(struct sdio_func *func)
+{
+	struct btmtk_dev *bdev = sdio_get_drvdata(func);
+
+	if (!bdev)
+		return;
+
+	btmtk_cif_free_memory(bdev->cif_dev);
+	btmtk_sdio_unregister_dev(bdev->cif_dev);
+
+	btmtk_main_cif_disconnect_notify(bdev, HCI_SDIO);
+}
+
+static int btmtk_cif_probe(struct sdio_func *func,
+					const struct sdio_device_id *id)
+{
+	int ret = -1;
+	int cif_event = 0;
+	struct btmtk_cif_state *cif_state = NULL;
+	struct btmtk_dev *bdev = NULL;
+
+	/* Mediatek Driver Version */
+	BTMTK_INFO("%s: MTK BT Driver Version : %s", __func__, VERSION);
+
+	BTMTK_DBG("vendor=0x%x, device=0x%x, class=%d, fn=%d",
+			id->vendor, id->device, id->class,
+			func->num);
+
+	/* sdio interface numbers  */
+	if (func->num != BTMTK_SDIO_FUNC) {
+		BTMTK_INFO("func num is not match, func_num = %d", func->num);
+		return -ENODEV;
+	}
+
+	/* Retrieve priv data and set to interface structure */
+	bdev = btmtk_get_dev();
+	bdev->intf_dev = &func->dev;
+	bdev->cif_dev = &g_sdio_dev;
+	sdio_set_drvdata(func, bdev);
+
+	/* Retrieve current HIF event state */
+	cif_event = HIF_EVENT_PROBE;
+	if (BTMTK_CIF_IS_NULL(bdev, cif_event)) {
+		/* Error */
+		BTMTK_WARN("%s priv setting is NULL", __func__);
+		return -ENODEV;
+	}
+
+	cif_state = &bdev->cif_state[cif_event];
+
+	/* Set Entering state */
+	btmtk_set_chip_state((void *)bdev, cif_state->ops_enter);
+
+	/* Do HIF events */
+	ret = btmtk_sdio_probe(func, id);
+
+	/* Set End/Error state */
+	if (ret == 0)
+		btmtk_set_chip_state((void *)bdev, cif_state->ops_end);
+	else
+		btmtk_set_chip_state((void *)bdev, cif_state->ops_error);
+
+	return ret;
+}
+
+static void btmtk_cif_disconnect(struct sdio_func *func)
+{
+	int cif_event = 0;
+	struct btmtk_cif_state *cif_state = NULL;
+	struct btmtk_dev *bdev = NULL;
+
+	bdev = sdio_get_drvdata(func);
+
+	/* Retrieve current HIF event state */
+	cif_event = HIF_EVENT_DISCONNECT;
+	if (BTMTK_CIF_IS_NULL(bdev, cif_event)) {
+		/* Error */
+		BTMTK_WARN("%s priv setting is NULL", __func__);
+		return;
+	}
+
+	cif_state = &bdev->cif_state[cif_event];
+
+	btmtk_sdio_cif_mutex_lock(bdev);
+	/* Set Entering state */
+	btmtk_set_chip_state((void *)bdev, cif_state->ops_enter);
+
+	/* Do HIF events */
+	btmtk_sdio_disconnect(func);
+
+	/* Set End/Error state */
+	btmtk_set_chip_state((void *)bdev, cif_state->ops_end);
+	btmtk_sdio_cif_mutex_unlock(bdev);
+}
+
+#ifdef CONFIG_PM
+static int btmtk_cif_suspend(struct device *dev)
+{
+	int ret = 0;
+	int cif_event = 0;
+	struct btmtk_cif_state *cif_state = NULL;
+	int state = BTMTK_STATE_INIT;
+	struct sdio_func *func = NULL;
+	struct btmtk_dev *bdev = NULL;
+	struct btmtk_sdio_dev *cif_dev = NULL;
+	mmc_pm_flag_t pm_flags;
+
+	BTMTK_INFO("%s, enter", __func__);
+
+	if (!dev)
+		return 0;
+	func = dev_to_sdio_func(dev);
+	if (!func)
+		return 0;
+	bdev = sdio_get_drvdata(func);
+	if (!bdev)
+		return 0;
+
+	cif_dev = (struct btmtk_sdio_dev *)bdev->cif_dev;
+
+	if (bdev->suspend_count++) {
+		BTMTK_WARN("Has suspended. suspend_count: %d, end", bdev->suspend_count);
+		return 0;
+	}
+
+	state = btmtk_get_chip_state(bdev);
+	/* Retrieve current HIF event state */
+	if (state == BTMTK_STATE_FW_DUMP) {
+		BTMTK_WARN("%s: FW dumping ongoing, don't dos suspend flow!!!", __func__);
+		cif_event = HIF_EVENT_FW_DUMP;
+	} else
+		cif_event = HIF_EVENT_SUSPEND;
+
+	cif_state = &bdev->cif_state[cif_event];
+
+	/* Set Entering state */
+	btmtk_set_chip_state((void *)bdev, cif_state->ops_enter);
+
+#if CFG_SUPPORT_DVT
+	BTMTK_INFO("%s: SKIP Driver woble_suspend flow", __func__);
+#else
+	ret = btmtk_woble_suspend(bdev);
+	if (ret < 0)
+		BTMTK_ERR("%s: btmtk_woble_suspend return fail %d", __func__, ret);
+#endif
+
+	if (bdev->bt_cfg.support_woble_by_eint) {
+		if (bdev->wobt_irq != 0 && atomic_read(&(bdev->irq_enable_count)) == 0) {
+			BTMTK_INFO("enable BT IRQ:%d", bdev->wobt_irq);
+			irq_set_irq_wake(bdev->wobt_irq, 1);
+			enable_irq(bdev->wobt_irq);
+			atomic_inc(&(bdev->irq_enable_count));
+		} else
+			BTMTK_INFO("irq_enable count:%d", atomic_read(&(bdev->irq_enable_count)));
+	}
+
+	pm_flags = sdio_get_host_pm_caps(func);
+	if (!(pm_flags & MMC_PM_KEEP_POWER)) {
+		BTMTK_ERR("%s cannot remain alive while suspended(0x%x)",
+			sdio_func_id(func), pm_flags);
+	}
+
+	pm_flags = MMC_PM_KEEP_POWER;
+	ret = sdio_set_host_pm_flags(func, pm_flags);
+	if (ret) {
+		BTMTK_ERR("set flag 0x%x err %d", pm_flags, (int)ret);
+		ret = -ENOTSUP;
+	}
+
+	/* Set End/Error state */
+	if (ret == 0)
+		btmtk_set_chip_state((void *)bdev, cif_state->ops_end);
+	else
+		btmtk_set_chip_state((void *)bdev, cif_state->ops_error);
+
+	BTMTK_INFO("%s, end. ret = %d", __func__, ret);
+	return ret;
+}
+
+static int btmtk_cif_resume(struct device *dev)
+{
+	u8 ret = 0;
+	struct sdio_func *func = NULL;
+	struct btmtk_dev *bdev = NULL;
+	struct btmtk_sdio_dev *cif_dev = NULL;
+	struct btmtk_cif_state *cif_state = NULL;
+
+	BTMTK_INFO("%s, enter", __func__);
+
+	if (!dev)
+		return 0;
+	func = dev_to_sdio_func(dev);
+	if (!func)
+		return 0;
+	bdev = sdio_get_drvdata(func);
+	if (!bdev)
+		return 0;
+
+	cif_dev = (struct btmtk_sdio_dev *)bdev->cif_dev;
+
+	bdev->suspend_count--;
+	if (bdev->suspend_count) {
+		BTMTK_INFO("data->suspend_count %d, return 0", bdev->suspend_count);
+		return 0;
+	}
+
+	if (bdev->bt_cfg.support_woble_by_eint) {
+		if (bdev->wobt_irq != 0 && atomic_read(&(bdev->irq_enable_count)) == 1) {
+			BTMTK_INFO("disable BT IRQ:%d", bdev->wobt_irq);
+			atomic_dec(&(bdev->irq_enable_count));
+			disable_irq_nosync(bdev->wobt_irq);
+		} else
+			BTMTK_INFO("irq_enable count:%d", atomic_read(&(bdev->irq_enable_count)));
+	}
+
+	cif_state = &bdev->cif_state[HIF_EVENT_RESUME];
+
+	/* Set Entering state */
+	btmtk_set_chip_state((void *)bdev, cif_state->ops_enter);
+
+#if CFG_SUPPORT_DVT
+	BTMTK_INFO("%s: SKIP Driver woble_resume flow", __func__);
+#else
+	ret = btmtk_woble_resume(bdev);
+	if (ret < 0)
+		BTMTK_ERR("%s: btmtk_woble_resume return fail %d", __func__, ret);
+#endif
+	/* Set End/Error state */
+	if (ret == 0)
+		btmtk_set_chip_state((void *)bdev, cif_state->ops_end);
+	else
+		btmtk_set_chip_state((void *)bdev, cif_state->ops_error);
+
+	BTMTK_INFO("end");
+	return 0;
+}
+#endif	// CONFIG_PM //
+
+
+#ifdef CONFIG_PM
+static const struct dev_pm_ops btmtk_sdio_pm_ops = {
+	.suspend = btmtk_cif_suspend,
+	.resume = btmtk_cif_resume,
+};
+#endif
+
+static struct sdio_driver btmtk_sdio_driver = {
+	.name = "btsdio",
+	.id_table = btmtk_sdio_tabls,
+	.probe = btmtk_cif_probe,
+	.remove = btmtk_cif_disconnect,
+	.drv = {
+		.owner = THIS_MODULE,
+		.pm = &btmtk_sdio_pm_ops,
+	}
+};
+
+static int sdio_register(void)
+{
+	BTMTK_INFO("%s", __func__);
+
+	if (sdio_register_driver(&btmtk_sdio_driver) != 0)
+		return -ENODEV;
+
+	return 0;
+}
+
+static int sdio_deregister(void)
+{
+	BTMTK_INFO("%s", __func__);
+	sdio_unregister_driver(&btmtk_sdio_driver);
+	return 0;
+}
+
+static void btmtk_sdio_chip_reset_notify(struct btmtk_dev *bdev)
+{
+	struct btmtk_sdio_dev *cif_dev = (struct btmtk_sdio_dev *)bdev->cif_dev;
+
+	if (!cif_dev) {
+		BTMTK_INFO("%s, cif_dev is NULL", __func__);
+		return;
+	}
+	btmtk_sdio_set_no_fwn_own(cif_dev, 0);
+	btmtk_sdio_set_own_back(cif_dev, FW_OWN, 20);
+	atomic_set(&cif_dev->tx_rdy, 1);
+}
+
+int btmtk_cif_register(void)
+{
+	int retval = 0;
+	struct hif_hook_ptr hook;
+
+	BTMTK_INFO("%s", __func__);
+
+	memset(&hook, 0, sizeof(hook));
+	hook.open = btmtk_sdio_open;
+	hook.close = btmtk_sdio_close;
+	hook.reg_read = btmtk_sdio_read_register;
+	hook.reg_write = btmtk_sdio_write_register;
+	hook.send_cmd = btmtk_sdio_send_cmd;
+	hook.send_and_recv = btmtk_sdio_send_and_recv;
+	hook.event_filter = btmtk_sdio_event_filter;
+	hook.subsys_reset = btmtk_sdio_subsys_reset;
+	hook.whole_reset = btmtk_sdio_whole_reset;
+	hook.chip_reset_notify = btmtk_sdio_chip_reset_notify;
+	hook.cif_mutex_lock = btmtk_sdio_cif_mutex_lock;
+	hook.cif_mutex_unlock = btmtk_sdio_cif_mutex_unlock;
+	hook.open_done = btmtk_sdio_open_done;
+	hook.dl_dma = btmtk_sdio_load_fw_patch_using_dma;
+	btmtk_reg_hif_hook(&hook);
+
+	retval = sdio_register();
+	if (retval)
+		BTMTK_ERR("*** SDIO registration fail(%d)! ***", retval);
+	else
+		BTMTK_INFO("%s, SDIO registration success!", __func__);
+	return retval;
+}
+
+int btmtk_cif_deregister(void)
+{
+	BT_INFO("%s", __func__);
+	sdio_deregister();
+	BT_INFO("%s: Done", __func__);
+	return 0;
+}
+
+
diff --git a/drivers/bluetooth/usb/btmtkusb.c b/drivers/bluetooth/usb/btmtkusb.c
new file mode 100644
index 000000000000..a927b419a7e0
--- /dev/null
+++ b/drivers/bluetooth/usb/btmtkusb.c
@@ -0,0 +1,3218 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/**
+ *  Copyright (c) 2018 MediaTek Inc.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *  See http://www.gnu.org/licenses/gpl-2.0.html for more details.
+ */
+#include <linux/module.h>
+#include <linux/usb.h>
+#include <linux/usb/quirks.h>
+#include <linux/firmware.h>
+#include <asm/unaligned.h>
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+#include "btmtk_define.h"
+#include "btmtk_usb.h"
+#include "btmtk_main.h"
+
+static struct usb_driver btusb_driver;
+static struct btmtk_cif_chip_reset reset_func;
+static int intf_to_idx[BT_MCU_INTERFACE_NUM_MAX] = {0, -1, -1, 1};
+static struct btmtk_usb_dev g_usb_dev[BT_MCU_MINIMUM_INTERFACE_NUM][BT_MCU_NUM_MAX];
+
+static const struct usb_device_id btusb_table[] = {
+	/* Mediatek MT7961 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0e8d, 0x7961, 0xe0, 0x01, 0x01) },
+	/* Mediatek MT7915 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0e8d, 0x7915, 0xe0, 0x01, 0x01) },
+	/* Mediatek MT7663 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0e8d, 0x7663, 0xe0, 0x01, 0x01) },
+	/* Mediatek MT7922 */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x0e8d, 0x7922, 0xe0, 0x01, 0x01) },
+
+	{ }	/* Terminating entry */
+};
+
+static char event_need_compare[EVENT_COMPARE_SIZE] = {0};
+static char event_need_compare_len;
+static char event_compare_status;
+const u8 READ_ADDRESS_EVENT[] = { 0x0E, 0x0A, 0x01, 0x09, 0x10, 0x00 };
+
+static DEFINE_MUTEX(btmtk_usb_ops_mutex);
+#define USB_OPS_MUTEX_LOCK()	mutex_lock(&btmtk_usb_ops_mutex)
+#define USB_OPS_MUTEX_UNLOCK()	mutex_unlock(&btmtk_usb_ops_mutex)
+
+MODULE_DEVICE_TABLE(usb, btusb_table);
+
+/* remove #define BTUSB_MAX_ISOC_FRAMES	10
+ * ISCO_FRAMES max is 24
+ */
+#define BTUSB_MAX_ISOC_FRAMES	24
+
+#define BTUSB_INTR_RUNNING	0
+#define BTUSB_BULK_RUNNING	1
+#define BTUSB_ISOC_RUNNING	2
+#define BTUSB_SUSPENDING	3
+#define BTUSB_DID_ISO_RESUME	4
+#define BTUSB_BLE_ISOC_RUNNING	5
+
+#define DEVICE_VENDOR_REQUEST_IN	0xc0
+#define DEVICE_CLASS_REQUEST_OUT	0x20
+#define USB_CTRL_IO_TIMO		100
+
+#define BTMTK_IS_BT_0_INTF(ifnum_base) \
+	(ifnum_base == BT0_MCU_INTERFACE_NUM)
+
+#define BTMTK_IS_BT_1_INTF(ifnum_base) \
+	(ifnum_base == BT1_MCU_INTERFACE_NUM)
+
+#define BTMTK_CIF_GET_DEV_PRIV(bdev, intf, ifnum_base) \
+	do { \
+		bdev = usb_get_intfdata(intf); \
+		ifnum_base = intf->cur_altsetting->desc.bInterfaceNumber; \
+	} while (0)
+
+static int btmtk_cif_allocate_memory(struct btmtk_usb_dev *cif_dev);
+static void btmtk_cif_free_memory(struct btmtk_usb_dev *cif_dev);
+static int btmtk_cif_write_uhw_register(struct btmtk_dev *bdev, u32 reg, u32 val);
+static int btmtk_cif_read_uhw_register(struct btmtk_dev *bdev, u32 reg, u32 *val);
+
+static int btmtk_usb_send_and_recv(struct btmtk_dev *bdev,
+		struct sk_buff *skb,
+		const uint8_t *event, const int event_len,
+		int delay, int retry, int pkt_type);
+static void btmtk_usb_chip_reset_notify(struct btmtk_dev *bdev);
+static int btmtk_usb_event_filter(struct btmtk_dev *bdev, struct sk_buff *skb);
+static int btmtk_usb_send_cmd(struct btmtk_dev *bdev, struct sk_buff *skb,
+		int delay, int retry, int pkt_type);
+static int btmtk_usb_read_register(struct btmtk_dev *bdev, u32 reg, u32 *val);
+static int btmtk_usb_write_register(struct btmtk_dev *bdev, u32 reg, u32 val);
+
+static void btmtk_usb_cif_mutex_lock(struct btmtk_dev *bdev)
+{
+	USB_OPS_MUTEX_LOCK();
+}
+
+static void btmtk_usb_cif_mutex_unlock(struct btmtk_dev *bdev)
+{
+	USB_OPS_MUTEX_UNLOCK();
+}
+
+static inline void btusb_free_frags(struct btmtk_dev *bdev)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&bdev->rxlock, flags);
+
+	kfree_skb(bdev->evt_skb);
+	bdev->evt_skb = NULL;
+
+	kfree_skb(bdev->sco_skb);
+	bdev->sco_skb = NULL;
+
+	spin_unlock_irqrestore(&bdev->rxlock, flags);
+}
+
+static int btusb_recv_isoc(struct btmtk_dev *bdev, void *buffer, int count)
+{
+	struct sk_buff *skb;
+	int err = 0;
+
+	spin_lock(&bdev->rxlock);
+	skb = bdev->sco_skb;
+
+	while (count) {
+		int len;
+
+		if (!skb) {
+			skb = bt_skb_alloc(HCI_MAX_SCO_SIZE, GFP_ATOMIC);
+			if (!skb) {
+				err = -ENOMEM;
+				break;
+			}
+
+			hci_skb_pkt_type(skb) = HCI_SCODATA_PKT;
+			hci_skb_expect(skb) = HCI_SCO_HDR_SIZE;
+		}
+
+		len = min_t(uint, hci_skb_expect(skb), count);
+		memcpy(skb_put(skb, len), buffer, len);
+
+		count -= len;
+		buffer += len;
+		hci_skb_expect(skb) -= len;
+
+		if (skb->len == HCI_SCO_HDR_SIZE) {
+			/* Complete SCO header */
+			hci_skb_expect(skb) = hci_sco_hdr(skb)->dlen;
+
+			if (skb_tailroom(skb) < hci_skb_expect(skb)) {
+				kfree_skb(skb);
+				skb = NULL;
+
+				err = -EILSEQ;
+				break;
+			}
+		}
+
+		if (!hci_skb_expect(skb)) {
+			/* Complete frame */
+			hci_recv_frame(bdev->hdev, skb);
+			skb = NULL;
+		}
+	}
+
+	bdev->sco_skb = skb;
+	spin_unlock(&bdev->rxlock);
+
+	return err;
+}
+
+static void btusb_intr_complete(struct urb *urb)
+{
+	struct hci_dev *hdev = NULL;
+	struct btmtk_dev *bdev = NULL;
+	struct btmtk_usb_dev *cif_dev = NULL;
+	int err;
+	u8 *buf;
+	static u8 intr_blocking_usb_warn;
+
+	if (urb == NULL) {
+		BTMTK_ERR("%s: ERROR, urb is NULL!", __func__);
+		return;
+	}
+
+	hdev = urb->context;
+	if (hdev == NULL) {
+		BTMTK_ERR("%s: ERROR, hdev is NULL!", __func__);
+		return;
+	}
+
+	bdev = hci_get_drvdata(hdev);
+	if (bdev == NULL) {
+		BTMTK_ERR("%s: ERROR, bdev is NULL!", __func__);
+		return;
+	}
+
+	cif_dev = (struct btmtk_usb_dev *)bdev->cif_dev;
+	if (cif_dev == NULL) {
+		BTMTK_ERR("%s: ERROR, cif_dev is NULL!", __func__);
+		return;
+	}
+
+	BTMTK_DBG("%s urb %p status %d count %d", hdev->name, urb, urb->status,
+	       urb->actual_length);
+
+	if (urb->status != 0 && intr_blocking_usb_warn < 10) {
+		intr_blocking_usb_warn++;
+		BTMTK_WARN("%s: urb %p urb->status %d count %d", __func__,
+			urb, urb->status, urb->actual_length);
+	} else if (urb->status == 0 && urb->actual_length != 0)
+		intr_blocking_usb_warn = 0;
+
+	if (urb->status == 0) {
+		hdev->stat.byte_rx += urb->actual_length;
+
+		if (!cif_dev->urb_intr_buf) {
+			BT_ERR("%s: bdev->urb_intr_buf is NULL!", __func__);
+			return;
+		}
+
+		buf = urb->transfer_buffer;
+		if (urb->actual_length >= URB_MAX_BUFFER_SIZE ||
+			(urb->actual_length != (buf[1] + 2) && urb->actual_length > 1)) {
+			BTMTK_ERR("%s: urb->actual_length is invalid, buf[1] = %d!",
+				__func__, buf[1]);
+			btmtk_hci_snoop_print(urb->actual_length, urb->transfer_buffer);
+			goto intr_resub;
+		}
+		memset(cif_dev->urb_intr_buf, 0, URB_MAX_BUFFER_SIZE);
+		cif_dev->urb_intr_buf[0] = HCI_EVENT_PKT;
+		memcpy(cif_dev->urb_intr_buf + 1, urb->transfer_buffer, urb->actual_length);
+
+		BTMTK_DBG("%s ,urb->actual_length = %d", __func__, urb->actual_length);
+		BTMTK_DBG_RAW(cif_dev->urb_intr_buf, urb->actual_length + 1,
+			"%s, recv evt", __func__);
+		BTMTK_DBG_RAW(urb->transfer_buffer, urb->actual_length, "%s, recv evt", __func__);
+		if (cif_dev->urb_intr_buf[1] == 0xFF && urb->actual_length == 1) {
+			/* We can't use usb_control_msg in interrupt.
+			 * If you use usb_control_msg , it will cause crash.
+			 * Receive a bytes 0xFF from controller, it's WDT interrupt to driver.
+			 * WDT interrupt is a mechanism to do L0.5 reset.
+			 */
+			schedule_work(&bdev->reset_waker);
+			goto intr_resub;
+		}
+
+		err = btmtk_recv(hdev, cif_dev->urb_intr_buf, urb->actual_length + 1);
+		if (err) {
+			BT_ERR("%s corrupted event packet, urb_intr_buf = %p, transfer_buffer = %p",
+				hdev->name, cif_dev->urb_intr_buf, urb->transfer_buffer);
+			btmtk_hci_snoop_print(urb->actual_length, urb->transfer_buffer);
+			btmtk_hci_snoop_print(urb->actual_length + 1, cif_dev->urb_intr_buf);
+			hdev->stat.err_rx++;
+		}
+	} else if (urb->status == -ENOENT) {
+		BTMTK_INFO("%s: urb->status is ENOENT!", __func__);
+		return;
+	}
+
+	if (!test_bit(BTUSB_INTR_RUNNING, &bdev->flags)) {
+		BTMTK_INFO("%s: test_bit is not running!", __func__);
+		return;
+	}
+
+intr_resub:
+	usb_mark_last_busy(cif_dev->udev);
+	usb_anchor_urb(urb, &cif_dev->intr_anchor);
+
+	err = usb_submit_urb(urb, GFP_ATOMIC);
+	if (err < 0) {
+		/* -EPERM: urb is being killed;
+		 * -ENODEV: device got disconnected
+		 */
+		if (err != -EPERM && err != -ENODEV)
+			BTMTK_ERR("%s urb %p failed to resubmit (%d)",
+			       hdev->name, urb, -err);
+		usb_unanchor_urb(urb);
+	}
+}
+
+static int btusb_submit_intr_reset_urb(struct hci_dev *hdev, gfp_t mem_flags)
+{
+	struct btmtk_dev *bdev = hci_get_drvdata(hdev);
+	struct urb *urb;
+	unsigned char *buf;
+	unsigned int pipe;
+	int err, size;
+	struct btmtk_usb_dev *cif_dev = NULL;
+
+	/* If WDT reset happened, fw will send a bytes (FF) to host */
+	BTMTK_DBG("%s", hdev->name);
+
+	cif_dev = (struct btmtk_usb_dev *)bdev->cif_dev;
+	if (!cif_dev->reset_intr_ep)
+		return -ENODEV;
+
+	urb = usb_alloc_urb(0, mem_flags);
+	if (!urb)
+		return -ENOMEM;
+	/* Default size is 16 */
+	/* size = le16_to_cpu(data->intr_ep->wMaxPacketSize); */
+	/* 7663 & 7668 & Buzzard Endpoint description.
+	 * bEndpointAddress     0x8f  EP 15 IN
+	 * wMaxPacketSize     0x0001  1x 1 bytes
+	 */
+	size = le16_to_cpu(HCI_MAX_EVENT_SIZE);
+
+	buf = kmalloc(size, mem_flags);
+	if (!buf) {
+		usb_free_urb(urb);
+		return -ENOMEM;
+	}
+
+	pipe = usb_rcvintpipe(cif_dev->udev, cif_dev->reset_intr_ep->bEndpointAddress);
+
+	/* fw issue, we need to submit urb with a byte
+	 * If driver set size = le16_to_cpu(HCI_MAX_EVENT_SIZE) to usb_fill_int_urb
+	 * We can't get interrupt callback from bus.
+	 */
+	usb_fill_int_urb(urb, cif_dev->udev, pipe, buf, 1,
+			 btusb_intr_complete, hdev, cif_dev->reset_intr_ep->bInterval);
+
+	urb->transfer_flags |= URB_FREE_BUFFER;
+
+	usb_anchor_urb(urb, &cif_dev->intr_anchor);
+
+	err = usb_submit_urb(urb, mem_flags);
+	if (err < 0) {
+		if (err != -EPERM && err != -ENODEV)
+			BTMTK_ERR("%s urb %p submission failed (%d)",
+				   hdev->name, urb, -err);
+		usb_unanchor_urb(urb);
+	}
+
+	usb_free_urb(urb);
+
+	return err;
+}
+
+static void btusb_mtk_wmt_recv(struct urb *urb)
+{
+	struct hci_dev *hdev = urb->context;
+	struct btmtk_dev *bdev = hci_get_drvdata(hdev);
+	struct btmtk_usb_dev *cif_dev = NULL;
+	struct sk_buff *skb;
+	int err;
+
+	cif_dev = (struct btmtk_usb_dev *)bdev->cif_dev;
+
+	BTMTK_DBG("%s : %s urb %p status %d count %d", __func__, hdev->name, urb, urb->status,
+	       urb->actual_length);
+
+	if (urb->status == 0 && urb->actual_length > 0) {
+		BTMTK_DBG_RAW(urb->transfer_buffer, urb->actual_length, "%s, recv evt", __func__);
+		hdev->stat.byte_rx += urb->actual_length;
+		skb = bt_skb_alloc(HCI_MAX_EVENT_SIZE, GFP_ATOMIC);
+		if (!skb) {
+			BTMTK_ERR("%s skb is null!", __func__);
+			hdev->stat.err_rx++;
+			goto exit;
+		}
+
+		if (urb->actual_length >= HCI_MAX_EVENT_SIZE) {
+			BTMTK_ERR("%s urb->actual_length is invalid!", __func__);
+			BTMTK_INFO_RAW(urb->transfer_buffer, urb->actual_length,
+				"urb->actual_length:%d, urb->transfer_buffer:%p",
+				urb->actual_length, urb->transfer_buffer);
+			kfree_skb(skb);
+			hdev->stat.err_rx++;
+			goto exit;
+		}
+		hci_skb_pkt_type(skb) = HCI_EVENT_PKT;
+		memcpy(skb_put(skb, urb->actual_length), urb->transfer_buffer, urb->actual_length);
+		BTMTK_DBG_RAW(skb->data, skb->len, "%s, skb recv evt", __func__);
+
+		hci_recv_frame(hdev, skb);
+		return;
+	} else if (urb->status == -ENOENT) {
+		/* Avoid suspend failed when usb_kill_urb */
+		goto exit;
+	}
+
+	usb_mark_last_busy(cif_dev->udev);
+
+	/* The URB complete handler is still called with urb->actual_length = 0
+	 * when the event is not available, so we should keep re-submitting
+	 * URB until WMT event returns, Also, It's necessary to wait some time
+	 * between the two consecutive control URBs to relax the target device
+	 * to generate the event. Otherwise, the WMT event cannot return from
+	 * the device successfully.
+	 */
+	udelay(100);
+
+	usb_anchor_urb(urb, &cif_dev->ctrl_anchor);
+	err = usb_submit_urb(urb, GFP_ATOMIC);
+	if (err < 0) {
+		kfree(urb->setup_packet);
+		/* -EPERM: urb is being killed;
+		 * -ENODEV: device got disconnected
+		 */
+		if (err != -EPERM && err != -ENODEV)
+			usb_unanchor_urb(urb);
+	}
+
+	return;
+
+exit:
+	kfree(urb->setup_packet);
+}
+
+static int btusb_submit_wmt_urb(struct hci_dev *hdev, gfp_t mem_flags)
+{
+	struct btmtk_dev *bdev = hci_get_drvdata(hdev);
+	struct btmtk_usb_dev *cif_dev = NULL;
+	struct usb_ctrlrequest *dr;
+	struct urb *urb;
+	unsigned char *buf;
+	unsigned int pipe;
+	int err, size;
+	unsigned int ifnum_base;
+
+	BTMTK_DBG("%s : %s", __func__, hdev->name);
+
+	urb = usb_alloc_urb(0, mem_flags);
+	if (!urb)
+		return -ENOMEM;
+
+	size = le16_to_cpu(HCI_MAX_EVENT_SIZE);
+
+	dr = kmalloc(sizeof(*dr), GFP_KERNEL);
+	if (!dr) {
+		usb_free_urb(urb);
+		return -ENOMEM;
+	}
+
+	cif_dev = (struct btmtk_usb_dev *)bdev->cif_dev;
+
+	ifnum_base = cif_dev->intf->cur_altsetting->desc.bInterfaceNumber;
+
+	if (BTMTK_IS_BT_0_INTF(ifnum_base)) {
+		dr->bRequestType = 0xC0;
+		dr->bRequest     = 0x01;
+		dr->wIndex       = 0;
+		dr->wValue       = 0x30;
+		dr->wLength      = __cpu_to_le16(size);
+	} else if (BTMTK_IS_BT_1_INTF(ifnum_base)) {
+		dr->bRequestType = 0xA1;
+		dr->bRequest     = 0x01;
+		dr->wIndex       = 0x03;
+		dr->wValue       = 0x30;
+		dr->wLength      = __cpu_to_le16(size);
+	}
+
+	pipe = usb_rcvctrlpipe(cif_dev->udev, 0);
+
+	buf = kmalloc(size, GFP_KERNEL);
+	if (!buf) {
+		kfree(dr);
+		usb_free_urb(urb);
+		return -ENOMEM;
+	}
+
+	usb_fill_control_urb(urb, cif_dev->udev, pipe, (void *)dr,
+			     buf, size, btusb_mtk_wmt_recv, hdev);
+
+	urb->transfer_flags |= URB_FREE_BUFFER;
+
+	usb_anchor_urb(urb, &cif_dev->ctrl_anchor);
+
+	err = usb_submit_urb(urb, mem_flags);
+	if (err < 0) {
+		if (err != -EPERM && err != -ENODEV)
+			BTMTK_ERR("%s urb %p submission failed (%d)",
+					hdev->name, urb, -err);
+		kfree(dr);
+		usb_unanchor_urb(urb);
+	}
+
+	usb_free_urb(urb);
+
+	return err;
+}
+
+static int btusb_submit_intr_urb(struct hci_dev *hdev, gfp_t mem_flags)
+{
+	struct btmtk_dev *bdev = hci_get_drvdata(hdev);
+	struct btmtk_usb_dev *cif_dev = NULL;
+	struct urb *urb;
+	unsigned char *buf;
+	unsigned int pipe;
+	int err, size;
+
+	BTMTK_DBG("%s", hdev->name);
+
+	cif_dev = (struct btmtk_usb_dev *)bdev->cif_dev;
+
+	if (!cif_dev->intr_ep)
+		return -ENODEV;
+
+	urb = usb_alloc_urb(0, mem_flags);
+	if (!urb)
+		return -ENOMEM;
+
+	/* size = le16_to_cpu(data->intr_ep->wMaxPacketSize); */
+	/* 7663 & 7668 & Buzzard Endpoint description.
+	 * bEndpointAddress     0x81  EP 1 IN
+	 * wMaxPacketSize     0x0010  1x 16 bytes
+	 */
+	size = le16_to_cpu(HCI_MAX_EVENT_SIZE);
+	BTMTK_INFO("%s: maximum packet size:%d", __func__, size);
+
+	buf = kmalloc(size, mem_flags);
+	if (!buf) {
+		usb_free_urb(urb);
+		return -ENOMEM;
+	}
+
+	pipe = usb_rcvintpipe(cif_dev->udev, cif_dev->intr_ep->bEndpointAddress);
+
+	usb_fill_int_urb(urb, cif_dev->udev, pipe, buf, size,
+			 btusb_intr_complete, hdev, cif_dev->intr_ep->bInterval);
+
+	urb->transfer_flags |= URB_FREE_BUFFER;
+
+	usb_anchor_urb(urb, &cif_dev->intr_anchor);
+
+	err = usb_submit_urb(urb, mem_flags);
+	if (err < 0) {
+		if (err != -EPERM && err != -ENODEV)
+			BTMTK_ERR("%s urb %p submission failed (%d)",
+			       hdev->name, urb, -err);
+		usb_unanchor_urb(urb);
+	}
+
+	usb_free_urb(urb);
+
+	return err;
+}
+
+static void btusb_bulk_complete(struct urb *urb)
+{
+	struct hci_dev *hdev = NULL;
+	struct btmtk_dev *bdev = NULL;
+	struct btmtk_usb_dev *cif_dev = NULL;
+	int err;
+	u8 *buf;
+	u16 len = 0;
+	static u8 block_bulkin_usb_warn;
+
+	if (urb == NULL) {
+		BTMTK_ERR("%s: ERROR, urb is NULL!", __func__);
+		return;
+	}
+
+	hdev = urb->context;
+	if (hdev == NULL) {
+		BTMTK_ERR("%s: ERROR, hdev is NULL!", __func__);
+		return;
+	}
+
+	bdev = hci_get_drvdata(hdev);
+	if (bdev == NULL) {
+		BTMTK_ERR("%s: ERROR, bdev is NULL!", __func__);
+		return;
+	}
+
+	cif_dev = (struct btmtk_usb_dev *)bdev->cif_dev;
+	if (cif_dev == NULL) {
+		BTMTK_ERR("%s: ERROR, cif_dev is NULL!", __func__);
+		return;
+	}
+
+	if (urb->status != 0 && block_bulkin_usb_warn < 10) {
+		block_bulkin_usb_warn++;
+		BTMTK_INFO("%s: urb %p urb->status %d count %d", __func__, urb,
+			urb->status, urb->actual_length);
+	} else if (urb->status == 0 && urb->actual_length != 0)
+		block_bulkin_usb_warn = 0;
+
+	/*
+	 * This flag didn't support in kernel 4.x
+	 * Driver will remove it
+	 * if (!test_bit(HCI_RUNNING, &hdev->flags))
+	 * return;
+	 */
+	if (urb->status == 0) {
+		hdev->stat.byte_rx += urb->actual_length;
+		if (!cif_dev->urb_bulk_buf) {
+			BT_ERR("%s: bdev->urb_bulk_buf is NULL!", __func__);
+			return;
+		}
+
+		buf = urb->transfer_buffer;
+		len = buf[2] + ((buf[3] << 8) & 0xff00);
+		if (urb->actual_length >= URB_MAX_BUFFER_SIZE ||
+			urb->actual_length != len + 4) {
+			BTMTK_ERR("%s urb->actual_length is invalid, len = %d!", __func__, len);
+			btmtk_hci_snoop_print(urb->actual_length, urb->transfer_buffer);
+			goto bulk_resub;
+		}
+		memset(cif_dev->urb_bulk_buf, 0, URB_MAX_BUFFER_SIZE);
+		cif_dev->urb_bulk_buf[0] = HCI_ACLDATA_PKT;
+		memcpy(cif_dev->urb_bulk_buf + 1, urb->transfer_buffer, urb->actual_length);
+
+		err = btmtk_recv(hdev, cif_dev->urb_bulk_buf, urb->actual_length + 1);
+		if (err) {
+			BT_ERR("%s corrupted ACL packet, urb_bulk_buf = %p, transfer_buffer = %p",
+				hdev->name, cif_dev->urb_bulk_buf, urb->transfer_buffer);
+			btmtk_hci_snoop_print(urb->actual_length, urb->transfer_buffer);
+			btmtk_hci_snoop_print(urb->actual_length + 1, cif_dev->urb_bulk_buf);
+			hdev->stat.err_rx++;
+		}
+	} else if (urb->status == -ENOENT) {
+		/* Avoid suspend failed when usb_kill_urb */
+		BTMTK_INFO("%s urb %p status %d count %d", hdev->name, urb, urb->status,
+			urb->actual_length);
+		return;
+	}
+
+	if (!test_bit(BTUSB_BULK_RUNNING, &bdev->flags)) {
+		BTMTK_INFO("%s test flag failed", __func__);
+		return;
+	}
+
+bulk_resub:
+	usb_anchor_urb(urb, &cif_dev->bulk_anchor);
+	usb_mark_last_busy(cif_dev->udev);
+
+	err = usb_submit_urb(urb, GFP_ATOMIC);
+	if (err < 0) {
+		/* -EPERM: urb is being killed;
+		 * -ENODEV: device got disconnected
+		 */
+		if (err != -EPERM && err != -ENODEV)
+			BTMTK_ERR("%s urb %p failed to resubmit (%d)",
+			       hdev->name, urb, -err);
+		usb_unanchor_urb(urb);
+	}
+}
+
+static int btusb_submit_bulk_urb(struct hci_dev *hdev, gfp_t mem_flags)
+{
+	struct btmtk_dev *bdev = hci_get_drvdata(hdev);
+	struct btmtk_usb_dev *cif_dev = NULL;
+	struct urb *urb;
+	unsigned char *buf;
+	unsigned int pipe;
+	int err, size = HCI_MAX_FRAME_SIZE;
+
+	BTMTK_DBG("%s", hdev->name);
+
+	cif_dev = (struct btmtk_usb_dev *)bdev->cif_dev;
+
+	if (!cif_dev->bulk_rx_ep)
+		return -ENODEV;
+
+	urb = usb_alloc_urb(0, mem_flags);
+	if (!urb)
+		return -ENOMEM;
+
+	buf = kmalloc(size, mem_flags);
+	if (!buf) {
+		usb_free_urb(urb);
+		return -ENOMEM;
+	}
+
+	pipe = usb_rcvbulkpipe(cif_dev->udev, cif_dev->bulk_rx_ep->bEndpointAddress);
+
+	usb_fill_bulk_urb(urb, cif_dev->udev, pipe, buf, size,
+			  btusb_bulk_complete, hdev);
+
+	urb->transfer_flags |= URB_FREE_BUFFER;
+
+	usb_mark_last_busy(cif_dev->udev);
+	usb_anchor_urb(urb, &cif_dev->bulk_anchor);
+
+	err = usb_submit_urb(urb, mem_flags);
+	if (err < 0) {
+		if (err != -EPERM && err != -ENODEV)
+			BTMTK_ERR("%s urb %p submission failed (%d)",
+			       hdev->name, urb, -err);
+		usb_unanchor_urb(urb);
+	}
+
+	usb_free_urb(urb);
+
+	return err;
+}
+
+static void btusb_ble_isoc_complete(struct urb *urb)
+{
+	struct hci_dev *hdev = NULL;
+	struct btmtk_dev *bdev = NULL;
+	struct btmtk_usb_dev *cif_dev = NULL;
+	int err;
+	u8 *isoc_buf;
+	int isoc_pkt_len;
+
+	/*
+	 * This flag didn't support in kernel 4.x
+	 * Driver will remove it
+	 * if (!test_bit(HCI_RUNNING, &hdev->flags))
+	 * return;
+	 */
+	if (urb == NULL) {
+		BTMTK_ERR("%s: ERROR, urb is NULL!", __func__);
+		return;
+	}
+
+	hdev = urb->context;
+	if (hdev == NULL) {
+		BTMTK_ERR("%s: ERROR, hdev is NULL!", __func__);
+		return;
+	}
+
+	bdev = hci_get_drvdata(hdev);
+	if (bdev == NULL) {
+		BTMTK_ERR("%s: ERROR, bdev is NULL!", __func__);
+		return;
+	}
+
+	cif_dev = (struct btmtk_usb_dev *)bdev->cif_dev;
+	if (cif_dev == NULL) {
+		BTMTK_ERR("%s: ERROR, cif_dev is NULL!", __func__);
+		return;
+	}
+
+	if (urb->status == 0) {
+		hdev->stat.byte_rx += urb->actual_length;
+		isoc_buf = urb->transfer_buffer;
+
+		if (!cif_dev->urb_ble_isoc_buf) {
+			BT_ERR("%s: bdev->urb_ble_isoc_buf is NULL!", __func__);
+			return;
+		}
+		isoc_pkt_len = isoc_buf[2] + (isoc_buf[3] << 8) + HCI_ISO_PKT_HEADER_SIZE;
+
+		/* Skip padding */
+		BTMTK_DBG("%s: isoc_pkt_len = %d, urb->actual_length = %d",
+			__func__, isoc_pkt_len, urb->actual_length);
+		if (isoc_pkt_len == HCI_ISO_PKT_HEADER_SIZE) {
+			BTMTK_DBG("%s: goto ble_iso_resub", __func__);
+			goto ble_iso_resub;
+		}
+
+		if (urb->actual_length + HCI_ISO_PKT_WITH_ACL_HEADER_SIZE > URB_MAX_BUFFER_SIZE) {
+			BTMTK_ERR("%s urb->actual_length is invalid!", __func__);
+			btmtk_hci_snoop_print(urb->actual_length, urb->transfer_buffer);
+			goto ble_iso_resub;
+		}
+		/* It's mtk specific heade for stack
+		 * hci layered didn't support 0x05 for ble iso,
+		 * it will drop the packet type with 0x05
+		 * Driver will replace 0x05 to 0x02
+		 * header format : 0x02 0x00 0x44 xx_a xx_2 + isoc packet header & payload
+		 */
+		memset(cif_dev->urb_ble_isoc_buf, 0, URB_MAX_BUFFER_SIZE);
+		cif_dev->urb_ble_isoc_buf[0] = HCI_ACLDATA_PKT;
+		cif_dev->urb_ble_isoc_buf[1] = 0x00;
+		cif_dev->urb_ble_isoc_buf[2] = 0x44;
+		cif_dev->urb_ble_isoc_buf[3] = (isoc_pkt_len & 0x00ff);
+		cif_dev->urb_ble_isoc_buf[4] = (isoc_pkt_len >> 8);
+		memcpy(cif_dev->urb_ble_isoc_buf + HCI_ISO_PKT_WITH_ACL_HEADER_SIZE,
+			urb->transfer_buffer, isoc_pkt_len + HCI_ISO_PKT_HEADER_SIZE);
+
+		BTMTK_DBG_RAW(cif_dev->urb_ble_isoc_buf,
+			isoc_pkt_len + HCI_ISO_PKT_WITH_ACL_HEADER_SIZE,
+			"%s: raw data is :", __func__);
+
+		err = btmtk_recv(hdev, cif_dev->urb_ble_isoc_buf,
+			isoc_pkt_len + HCI_ISO_PKT_WITH_ACL_HEADER_SIZE);
+		if (err) {
+			BTMTK_ERR("%s corrupted ACL packet", hdev->name);
+			hdev->stat.err_rx++;
+		}
+	} else if (urb->status == -ENOENT) {
+		BTMTK_INFO("%s: urb->status is ENOENT!", __func__);
+		return;
+	}
+
+	if (!test_bit(BTUSB_BLE_ISOC_RUNNING, &bdev->flags)) {
+		BTMTK_INFO("%s: bdev->flags is RUNNING!", __func__);
+		return;
+	}
+
+ble_iso_resub:
+	usb_anchor_urb(urb, &cif_dev->ble_isoc_anchor);
+	usb_mark_last_busy(cif_dev->udev);
+
+	err = usb_submit_urb(urb, GFP_ATOMIC);
+	if (err < 0) {
+		/* -EPERM: urb is being killed;
+		 * -ENODEV: device got disconnected
+		 */
+		if (err != -EPERM && err != -ENODEV)
+			BTMTK_ERR("%s urb %p failed to resubmit (%d)",
+			       hdev->name, urb, -err);
+		usb_unanchor_urb(urb);
+	}
+}
+
+static int btusb_submit_intr_ble_isoc_urb(struct hci_dev *hdev, gfp_t mem_flags)
+{
+	struct btmtk_dev *bdev = hci_get_drvdata(hdev);
+	struct btmtk_usb_dev *cif_dev = NULL;
+	struct urb *urb;
+	unsigned char *buf;
+	unsigned int pipe;
+	int err, size;
+
+	cif_dev = (struct btmtk_usb_dev *)bdev->cif_dev;
+
+	if (!cif_dev->intr_iso_rx_ep)
+		return -ENODEV;
+
+	urb = usb_alloc_urb(0, mem_flags);
+	if (!urb)
+		return -ENOMEM;
+	/* Default size is 16 */
+	/* size = le16_to_cpu(data->intr_ep->wMaxPacketSize); */
+	/* we need to consider the wMaxPacketSize in BLE ISO */
+	size = le16_to_cpu(2000);
+
+	buf = kmalloc(size, mem_flags);
+	if (!buf) {
+		usb_free_urb(urb);
+		return -ENOMEM;
+	}
+
+	pipe = usb_rcvintpipe(cif_dev->udev, cif_dev->intr_iso_rx_ep->bEndpointAddress);
+	BTMTK_INFO("btusb_submit_intr_iso_urb : polling  0x%02X",
+		cif_dev->intr_iso_rx_ep->bEndpointAddress);
+
+	usb_fill_int_urb(urb, cif_dev->udev, pipe, buf, size,
+			 btusb_ble_isoc_complete, hdev, cif_dev->intr_iso_rx_ep->bInterval);
+
+	urb->transfer_flags |= URB_FREE_BUFFER;
+
+	usb_anchor_urb(urb, &cif_dev->ble_isoc_anchor);
+
+	err = usb_submit_urb(urb, mem_flags);
+	if (err < 0) {
+		if (err != -EPERM && err != -ENODEV)
+			BTMTK_ERR("%s urb %p submission failed (%d)",
+				   hdev->name, urb, -err);
+		usb_unanchor_urb(urb);
+	}
+
+	usb_free_urb(urb);
+
+	return err;
+}
+
+static void btusb_isoc_complete(struct urb *urb)
+{
+	struct hci_dev *hdev = NULL;
+	struct btmtk_dev *bdev = NULL;
+	struct btmtk_usb_dev *cif_dev = NULL;
+	int i, err;
+
+	if (urb == NULL) {
+		BTMTK_ERR("%s: ERROR, urb is NULL!", __func__);
+		return;
+	}
+
+	hdev = urb->context;
+	if (hdev == NULL) {
+		BTMTK_ERR("%s: ERROR, hdev is NULL!", __func__);
+		return;
+	}
+
+	bdev = hci_get_drvdata(hdev);
+	if (bdev == NULL) {
+		BTMTK_ERR("%s: ERROR, bdev is NULL!", __func__);
+		return;
+	}
+
+	cif_dev = (struct btmtk_usb_dev *)bdev->cif_dev;
+	if (cif_dev == NULL) {
+		BTMTK_ERR("%s: ERROR, cif_dev is NULL!", __func__);
+		return;
+	}
+
+
+	BTMTK_DBG("%s urb %p status %d count %d", hdev->name, urb, urb->status,
+	       urb->actual_length);
+
+	if (!test_bit(HCI_RUNNING, &hdev->flags))
+		return;
+
+	if (urb->status == 0) {
+		for (i = 0; i < urb->number_of_packets; i++) {
+			unsigned int offset = urb->iso_frame_desc[i].offset;
+			unsigned int length = urb->iso_frame_desc[i].actual_length;
+
+			if (urb->iso_frame_desc[i].status)
+				continue;
+
+			hdev->stat.byte_rx += length;
+
+			if (btusb_recv_isoc(bdev, urb->transfer_buffer + offset,
+					    length) < 0) {
+				BTMTK_ERR("%s corrupted SCO packet", hdev->name);
+				hdev->stat.err_rx++;
+			}
+		}
+	} else if (urb->status == -ENOENT) {
+		BTMTK_INFO("%s: urb->status is ENOENT!", __func__);
+		return;
+	}
+
+	if (!test_bit(BTUSB_ISOC_RUNNING, &bdev->flags)) {
+		BTMTK_INFO("%s: bdev->flags is RUNNING!", __func__);
+		return;
+	}
+
+	usb_anchor_urb(urb, &cif_dev->isoc_anchor);
+
+	err = usb_submit_urb(urb, GFP_ATOMIC);
+	if (err < 0) {
+		/* -EPERM: urb is being killed;
+		 * -ENODEV: device got disconnected
+		 */
+		if (err != -EPERM && err != -ENODEV)
+			BTMTK_ERR("%s urb %p failed to resubmit (%d)",
+			       hdev->name, urb, -err);
+		usb_unanchor_urb(urb);
+	}
+}
+
+static inline void __fill_isoc_descriptor(struct urb *urb, int len, int mtu)
+{
+	int i, offset = 0;
+
+	BTMTK_DBG("len %d mtu %d", len, mtu);
+
+	for (i = 0; i < BTUSB_MAX_ISOC_FRAMES && len >= mtu;
+					i++, offset += mtu, len -= mtu) {
+		urb->iso_frame_desc[i].offset = offset;
+		urb->iso_frame_desc[i].length = mtu;
+	}
+
+	if (len && i < BTUSB_MAX_ISOC_FRAMES) {
+		urb->iso_frame_desc[i].offset = offset;
+		urb->iso_frame_desc[i].length = len;
+		i++;
+	}
+
+	urb->number_of_packets = i;
+}
+
+static int btusb_submit_isoc_urb(struct hci_dev *hdev, gfp_t mem_flags)
+{
+	struct btmtk_dev *bdev = hci_get_drvdata(hdev);
+	struct btmtk_usb_dev *cif_dev = NULL;
+	struct urb *urb;
+	unsigned char *buf;
+	unsigned int pipe;
+	int err, size;
+
+	BTMTK_DBG("%s", hdev->name);
+	cif_dev = (struct btmtk_usb_dev *)bdev->cif_dev;
+
+	if (!cif_dev->isoc_rx_ep)
+		return -ENODEV;
+
+	urb = usb_alloc_urb(BTUSB_MAX_ISOC_FRAMES, mem_flags);
+	if (!urb)
+		return -ENOMEM;
+
+	size = le16_to_cpu(cif_dev->isoc_rx_ep->wMaxPacketSize) *
+						BTUSB_MAX_ISOC_FRAMES;
+
+	buf = kmalloc(size, mem_flags);
+	if (!buf) {
+		usb_free_urb(urb);
+		return -ENOMEM;
+	}
+
+	pipe = usb_rcvisocpipe(cif_dev->udev, cif_dev->isoc_rx_ep->bEndpointAddress);
+
+	usb_fill_int_urb(urb, cif_dev->udev, pipe, buf, size, btusb_isoc_complete,
+			 hdev, cif_dev->isoc_rx_ep->bInterval);
+
+	urb->transfer_flags = URB_FREE_BUFFER | URB_ISO_ASAP;
+
+	__fill_isoc_descriptor(urb, size,
+			       le16_to_cpu(cif_dev->isoc_rx_ep->wMaxPacketSize));
+
+	usb_anchor_urb(urb, &cif_dev->isoc_anchor);
+
+	err = usb_submit_urb(urb, mem_flags);
+	if (err < 0) {
+		if (err != -EPERM && err != -ENODEV)
+			BTMTK_ERR("%s urb %p submission failed (%d)",
+			       hdev->name, urb, -err);
+		usb_unanchor_urb(urb);
+	}
+
+	usb_free_urb(urb);
+
+	return err;
+}
+
+static void btusb_tx_complete(struct urb *urb)
+{
+	struct sk_buff *skb = urb->context;
+	struct hci_dev *hdev = (struct hci_dev *)skb->dev;
+	struct btmtk_dev *bdev = hci_get_drvdata(hdev);
+	unsigned long flags;
+
+	BTMTK_DBG("%s urb %p status %d count %d", hdev->name, urb, urb->status,
+	       urb->actual_length);
+
+	if (!test_bit(HCI_RUNNING, &hdev->flags))
+		goto done;
+
+	if (!urb->status)
+		hdev->stat.byte_tx += urb->transfer_buffer_length;
+	else
+		hdev->stat.err_tx++;
+
+done:
+	spin_lock_irqsave(&bdev->txlock, flags);
+	bdev->tx_in_flight--;
+	spin_unlock_irqrestore(&bdev->txlock, flags);
+
+	kfree(urb->setup_packet);
+
+	kfree_skb(skb);
+}
+
+static void btusb_isoc_tx_complete(struct urb *urb)
+{
+	struct sk_buff *skb = urb->context;
+	struct hci_dev *hdev = (struct hci_dev *)skb->dev;
+
+	BTMTK_DBG("%s urb %p status %d count %d", hdev->name, urb, urb->status,
+	       urb->actual_length);
+
+	if (!test_bit(HCI_RUNNING, &hdev->flags))
+		goto done;
+
+	if (!urb->status)
+		hdev->stat.byte_tx += urb->transfer_buffer_length;
+	else
+		hdev->stat.err_tx++;
+
+done:
+	kfree(urb->setup_packet);
+
+	kfree_skb(skb);
+}
+
+static int btmtk_usb_open(struct hci_dev *hdev)
+{
+	struct btmtk_dev *bdev = hci_get_drvdata(hdev);
+	struct btmtk_usb_dev *cif_dev = (struct btmtk_usb_dev *)bdev->cif_dev;
+	int err;
+	unsigned int ifnum_base;
+
+	BTMTK_INFO("%s enter!", __func__);
+
+	BTMTK_DBG("%s", hdev->name);
+
+	err = usb_autopm_get_interface(cif_dev->intf);
+	if (err < 0)
+		return err;
+
+	cif_dev->intf->needs_remote_wakeup = 1;
+
+	if (test_and_set_bit(BTUSB_INTR_RUNNING, &bdev->flags))
+		goto done;
+
+	ifnum_base = cif_dev->intf->cur_altsetting->desc.bInterfaceNumber;
+
+	if (is_mt7922(bdev->chip_id) || is_mt7961(bdev->chip_id)) {
+		BTMTK_INFO("%s 7961 submit urb\n", __func__);
+		if (BTMTK_IS_BT_0_INTF(ifnum_base)) {
+			if (cif_dev->reset_intr_ep) {
+				err = btusb_submit_intr_reset_urb(hdev, GFP_KERNEL);
+				if (err < 0)
+					goto failed;
+			} else
+				BTMTK_INFO("%s, reset_intr_ep missing,", __func__);
+				BTMTK_INFO("don't submit_intr_reset_urb!");
+
+			if (cif_dev->intr_iso_rx_ep) {
+				err = btusb_submit_intr_ble_isoc_urb(hdev, GFP_KERNEL);
+				if (err < 0) {
+					usb_kill_anchored_urbs(&cif_dev->ble_isoc_anchor);
+					goto failed;
+				}
+			} else
+				BTMTK_INFO("%s, intr_iso_rx_ep missing," __func__);
+				BTMTK_INFO("don't submit_intr_ble_isoc_urb!");
+		} else if (BTMTK_IS_BT_1_INTF(ifnum_base)) {
+			/*need to do in bt_open in btmtk_main.c */
+			/* btmtk_usb_send_power_on_cmd_7668(hdev); */
+		}
+	}
+	err = btusb_submit_intr_urb(hdev, GFP_KERNEL);
+	if (err < 0)
+		goto failed;
+
+	err = btusb_submit_bulk_urb(hdev, GFP_KERNEL);
+	if (err < 0) {
+		usb_kill_anchored_urbs(&cif_dev->intr_anchor);
+		goto failed;
+	}
+
+
+	set_bit(BTUSB_BULK_RUNNING, &bdev->flags);
+
+done:
+	usb_autopm_put_interface(cif_dev->intf);
+	return 0;
+
+failed:
+	clear_bit(BTUSB_INTR_RUNNING, &bdev->flags);
+	usb_autopm_put_interface(cif_dev->intf);
+	return err;
+}
+
+static void btusb_stop_traffic(struct btmtk_usb_dev *cif_dev)
+{
+	usb_kill_anchored_urbs(&cif_dev->intr_anchor);
+	usb_kill_anchored_urbs(&cif_dev->bulk_anchor);
+	usb_kill_anchored_urbs(&cif_dev->isoc_anchor);
+	usb_kill_anchored_urbs(&cif_dev->ctrl_anchor);
+	usb_kill_anchored_urbs(&cif_dev->ble_isoc_anchor);
+}
+
+static int btmtk_usb_close(struct hci_dev *hdev)
+{
+	struct btmtk_dev *bdev = hci_get_drvdata(hdev);
+	struct btmtk_usb_dev *cif_dev = (struct btmtk_usb_dev *)bdev->cif_dev;
+	int err;
+
+	BTMTK_INFO("%s enter!", __func__);
+
+	BTMTK_DBG("%s", hdev->name);
+
+	cancel_work_sync(&bdev->work);
+	cancel_work_sync(&bdev->waker);
+	cancel_work_sync(&bdev->reset_waker);
+
+	clear_bit(BTUSB_BLE_ISOC_RUNNING, &bdev->flags);
+	clear_bit(BTUSB_ISOC_RUNNING, &bdev->flags);
+	clear_bit(BTUSB_BULK_RUNNING, &bdev->flags);
+	clear_bit(BTUSB_INTR_RUNNING, &bdev->flags);
+
+	btusb_stop_traffic(cif_dev);
+	btusb_free_frags(bdev);
+
+	err = usb_autopm_get_interface(cif_dev->intf);
+	if (err < 0)
+		goto failed;
+
+	cif_dev->intf->needs_remote_wakeup = 0;
+	usb_autopm_put_interface(cif_dev->intf);
+
+failed:
+	return 0;
+}
+
+static struct urb *alloc_intr_iso_urb(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct btmtk_dev *bdev = hci_get_drvdata(hdev);
+	struct btmtk_usb_dev *cif_dev = (struct btmtk_usb_dev *)bdev->cif_dev;
+	struct urb *urb;
+	unsigned int pipe;
+
+	if (!cif_dev->intr_iso_tx_ep)
+		return ERR_PTR(-ENODEV);
+
+	urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!urb)
+		return ERR_PTR(-ENOMEM);
+
+	pipe = usb_sndintpipe(cif_dev->udev, cif_dev->intr_iso_tx_ep->bEndpointAddress);
+
+	usb_fill_int_urb(urb, cif_dev->udev, pipe,
+			  skb->data, skb->len, btusb_tx_complete, skb, 1);
+
+	skb->dev = (void *)hdev;
+
+	return urb;
+}
+
+static struct urb *alloc_ctrl_bgf1_urb(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct btmtk_dev *bdev = hci_get_drvdata(hdev);
+	struct btmtk_usb_dev *cif_dev = (struct btmtk_usb_dev *)bdev->cif_dev;
+	struct usb_ctrlrequest *dr;
+	struct urb *urb;
+	unsigned int pipe;
+
+	urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!urb)
+		return ERR_PTR(-ENOMEM);
+
+	BTMTK_DBG("%s\n", __func__);
+	dr = kmalloc(sizeof(*dr), GFP_KERNEL);
+	if (!dr) {
+		usb_free_urb(urb);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	dr->bRequestType = 0x21;
+	dr->bRequest	 = 0x00;
+	dr->wIndex	   = 3;
+	dr->wValue	   = 0;
+	dr->wLength	  = __cpu_to_le16(skb->len);
+
+	pipe = usb_sndctrlpipe(cif_dev->udev, 0x00);
+
+	usb_fill_control_urb(urb, cif_dev->udev, pipe, (void *)dr,
+				 skb->data, skb->len, btusb_tx_complete, skb);
+
+	skb->dev = (void *)hdev;
+
+	return urb;
+}
+
+static struct urb *alloc_bulk_cmd_urb(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct btmtk_dev *bdev = hci_get_drvdata(hdev);
+	struct btmtk_usb_dev *cif_dev = (struct btmtk_usb_dev *)bdev->cif_dev;
+	struct urb *urb;
+	unsigned int pipe;
+
+	BTMTK_DBG("%s start\n", __func__);
+	if (!cif_dev->bulk_cmd_tx_ep)
+		return ERR_PTR(-ENODEV);
+
+	BTMTK_DBG("%s\n", __func__);
+	urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!urb)
+		return ERR_PTR(-ENOMEM);
+
+	pipe = usb_sndbulkpipe(cif_dev->udev, cif_dev->bulk_cmd_tx_ep->bEndpointAddress);
+
+	usb_fill_bulk_urb(urb, cif_dev->udev, pipe,
+			  skb->data, skb->len, btusb_tx_complete, skb);
+
+	skb->dev = (void *)hdev;
+
+	return urb;
+}
+
+static struct urb *alloc_ctrl_urb(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct btmtk_dev *bdev = hci_get_drvdata(hdev);
+	struct btmtk_usb_dev *cif_dev = (struct btmtk_usb_dev *)bdev->cif_dev;
+	struct usb_ctrlrequest *dr;
+	struct urb *urb;
+	unsigned int pipe;
+
+	urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!urb)
+		return ERR_PTR(-ENOMEM);
+
+	dr = kmalloc(sizeof(*dr), GFP_KERNEL);
+	if (!dr) {
+		usb_free_urb(urb);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	dr->bRequestType = cif_dev->cmdreq_type;
+	dr->bRequest     = cif_dev->cmdreq;
+	dr->wIndex       = 0;
+	dr->wValue       = 0;
+	dr->wLength      = __cpu_to_le16(skb->len);
+
+	pipe = usb_sndctrlpipe(cif_dev->udev, 0x00);
+
+	usb_fill_control_urb(urb, cif_dev->udev, pipe, (void *)dr,
+			     skb->data, skb->len, btusb_tx_complete, skb);
+
+	skb->dev = (void *)hdev;
+
+	return urb;
+}
+
+static struct urb *alloc_bulk_urb(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct btmtk_dev *bdev = hci_get_drvdata(hdev);
+	struct btmtk_usb_dev *cif_dev = (struct btmtk_usb_dev *)bdev->cif_dev;
+	struct urb *urb;
+	unsigned int pipe;
+
+	if (!cif_dev->bulk_tx_ep)
+		return ERR_PTR(-ENODEV);
+
+	urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!urb)
+		return ERR_PTR(-ENOMEM);
+
+	pipe = usb_sndbulkpipe(cif_dev->udev, cif_dev->bulk_tx_ep->bEndpointAddress);
+
+	usb_fill_bulk_urb(urb, cif_dev->udev, pipe,
+			  skb->data, skb->len, btusb_tx_complete, skb);
+
+	skb->dev = (void *)hdev;
+
+	return urb;
+}
+
+static struct urb *alloc_isoc_urb(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct btmtk_dev *bdev = hci_get_drvdata(hdev);
+	struct btmtk_usb_dev *cif_dev = (struct btmtk_usb_dev *)bdev->cif_dev;
+	struct urb *urb;
+	unsigned int pipe;
+
+	if (!cif_dev->isoc_tx_ep)
+		return ERR_PTR(-ENODEV);
+
+	urb = usb_alloc_urb(BTUSB_MAX_ISOC_FRAMES, GFP_KERNEL);
+	if (!urb)
+		return ERR_PTR(-ENOMEM);
+
+	pipe = usb_sndisocpipe(cif_dev->udev, cif_dev->isoc_tx_ep->bEndpointAddress);
+
+	usb_fill_int_urb(urb, cif_dev->udev, pipe,
+			 skb->data, skb->len, btusb_isoc_tx_complete,
+			 skb, cif_dev->isoc_tx_ep->bInterval);
+
+	urb->transfer_flags  = URB_ISO_ASAP;
+
+	__fill_isoc_descriptor(urb, skb->len,
+			       le16_to_cpu(cif_dev->isoc_tx_ep->wMaxPacketSize));
+
+	skb->dev = (void *)hdev;
+
+	return urb;
+}
+
+static int submit_tx_urb(struct hci_dev *hdev, struct urb *urb)
+{
+	struct btmtk_dev *bdev = hci_get_drvdata(hdev);
+	struct btmtk_usb_dev *cif_dev = (struct btmtk_usb_dev *)bdev->cif_dev;
+	int err;
+
+	usb_anchor_urb(urb, &cif_dev->tx_anchor);
+
+	err = usb_submit_urb(urb, GFP_KERNEL);
+	if (err < 0) {
+		if (err != -EPERM && err != -ENODEV)
+			BTMTK_ERR("%s urb %p submission failed (%d)",
+			       hdev->name, urb, -err);
+		kfree(urb->setup_packet);
+		usb_unanchor_urb(urb);
+	} else {
+		usb_mark_last_busy(cif_dev->udev);
+	}
+
+	usb_free_urb(urb);
+	return err;
+}
+
+static int submit_or_queue_tx_urb(struct hci_dev *hdev, struct urb *urb)
+{
+	struct btmtk_dev *bdev = hci_get_drvdata(hdev);
+	unsigned long flags;
+	bool suspending;
+
+	spin_lock_irqsave(&bdev->txlock, flags);
+	suspending = test_bit(BTUSB_SUSPENDING, &bdev->flags);
+	if (!suspending)
+		bdev->tx_in_flight++;
+	spin_unlock_irqrestore(&bdev->txlock, flags);
+
+	if (!suspending)
+		return submit_tx_urb(hdev, urb);
+
+	schedule_work(&bdev->waker);
+
+	usb_free_urb(urb);
+	return 0;
+}
+
+static int btusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	struct urb *urb = NULL;
+	struct btmtk_dev *bdev = hci_get_drvdata(hdev);
+	struct btmtk_usb_dev *cif_dev = (struct btmtk_usb_dev *)bdev->cif_dev;
+	unsigned int ifnum_base;
+	int ret = 0;
+	struct sk_buff *iso_skb = NULL;
+#ifdef CFG_SUPPORT_HW_DVT
+	struct sk_buff *evt_skb;
+	uint8_t notify_alt_evt[] = {0x0E, 0x04, 0x01, 0x03, 0x0c, 0x00};
+	u16 crBaseAddr = 0, crRegOffset = 0;
+#endif
+
+	if (skb->len <= 0) {
+		ret = -EFAULT;
+		BTMTK_ERR("%s: target packet length:%zu is not allowed",
+			__func__, (size_t)skb->len);
+	}
+
+	ifnum_base = cif_dev->intf->cur_altsetting->desc.bInterfaceNumber;
+
+	skb_pull(skb, 1);
+	BTMTK_DBG_RAW(skb->data, skb->len, "%s, send_frame, type = %d", __func__,
+		hci_skb_pkt_type(skb));
+	switch (hci_skb_pkt_type(skb)) {
+	case HCI_COMMAND_PKT:
+#ifdef CFG_SUPPORT_HW_DVT
+		if (skb->len > 7) {
+			if (skb->data[0] == 0x6f && skb->data[1] == 0xfc &&
+					skb->data[2] == 0x06 && skb->data[3] == 0x01 &&
+					skb->data[4] == 0xff && skb->data[5] == 0x03 &&
+					skb->data[6] == 0x00 && skb->data[7] == 0x00) {
+				/* return evt to upper layered */
+				evt_skb = skb_copy(skb, GFP_KERNEL);
+				bt_cb(evt_skb)->pkt_type = HCI_EVENT_PKT;
+				memcpy(evt_skb->data, &notify_alt_evt, sizeof(notify_alt_evt));
+				evt_skb->len = sizeof(notify_alt_evt);
+				/* After set alternate setting, we will return evt to boots */
+				hci_recv_frame(hdev, evt_skb);
+				hdev->conn_hash.sco_num++;
+				bdev->sco_num = hdev->conn_hash.sco_num;
+				cif_dev->new_isoc_altsetting = skb->data[8];
+				BTMTK_INFO("alt_setting = %d, new_isoc_altsetting_interface = %d\n",
+					cif_dev->new_isoc_altsetting,
+					cif_dev->new_isoc_altsetting_interface);
+				schedule_work(&bdev->work);
+				msleep(20);
+				kfree_skb(skb);
+				skb = NULL;
+				return 0;
+			} else if (skb->data[0] == 0x6f && skb->data[1] == 0xfc &&
+					skb->data[2] == 0x07 && skb->data[3] == 0x01 &&
+					skb->data[4] == 0xff && skb->data[5] == 0x03 &&
+					skb->data[6] == 0x00 && skb->data[7] == 0x00 &&
+					skb->data[9] == 0x00) {
+				evt_skb = skb_copy(skb, GFP_KERNEL);
+				bt_cb(evt_skb)->pkt_type = HCI_EVENT_PKT;
+				memcpy(evt_skb->data, &notify_alt_evt, sizeof(notify_alt_evt));
+				evt_skb->len = sizeof(notify_alt_evt);
+				/* After set alternate setting, we will return evt to boots */
+				hci_recv_frame(hdev, evt_skb);
+				/* if sco_num == 0, btusb_work will set alternate setting to zero */
+				hdev->conn_hash.sco_num--;
+				bdev->sco_num = hdev->conn_hash.sco_num;
+				cif_dev->new_isoc_altsetting_interface = skb->data[8];
+				BTMTK_INFO("alt_setting to = %d\n",
+					cif_dev->new_isoc_altsetting);
+				BTMTK_INFO("new_isoc_altsetting_interface = %d\n",
+					cif_dev->new_isoc_altsetting_interface);
+				schedule_work(&bdev->work);
+				/*
+				 * If we don't sleep 50ms,
+				 * it will failed to set alternate setting to zero
+				 */
+				msleep(50);
+				kfree_skb(skb);
+				skb = NULL;
+				return 0;
+			} else if (skb->data[0] == 0x6f && skb->data[1] == 0xfc &&
+					skb->data[2] == 0x09 && skb->data[3] == 0x01 &&
+					skb->data[4] == 0xff && skb->data[5] == 0x05 &&
+					skb->data[6] == 0x00 && skb->data[7] == 0x01) {
+				BTMTK_INFO("read CR skb->data = %02x %02x %02x %02x\n",
+					skb->data[8], skb->data[9], skb->data[10], skb->data[11]);
+				crBaseAddr = (skb->data[8]<<8) + skb->data[9];
+				crRegOffset = (skb->data[10]<<8) + skb->data[11];
+				BTMTK_INFO("base + offset = %04x %04x\n", crBaseAddr, crRegOffset);
+				memset(bdev->io_buf, 0, IO_BUF_SIZE);
+				ret = usb_control_msg(cif_dev->udev,
+						usb_rcvctrlpipe(cif_dev->udev, 0),
+						1, 0xDE, crBaseAddr, crRegOffset,
+						bdev->io_buf, 4, USB_CTRL_IO_TIMO);
+				if (ret < 0) {
+					BTMTK_ERR("read CR(%04X[%04X]) FAILED\n",
+						crBaseAddr, crRegOffset);
+				} else {
+					BTMTK_INFO("read CR(%04X[%04X])",
+						crBaseAddr, crRegOffset);
+					BTMTK_INFO("value = 0x%02x%02x%02x%02x\n",
+						bdev->io_buf[3], bdev->io_buf[2],
+						bdev->io_buf[1], bdev->io_buf[0]);
+				}
+				kfree_skb(skb);
+				skb = NULL;
+				return 0;
+			} else if (skb->data[0] == 0x6f && skb->data[1] == 0xfc &&
+					skb->data[2] == 0x0D && skb->data[3] == 0x01 &&
+					skb->data[4] == 0xff && skb->data[5] == 0x09 &&
+					skb->data[6] == 0x00 && skb->data[7] == 0x02) {
+				crBaseAddr = (skb->data[8] << 8) + skb->data[9];
+				crRegOffset = (skb->data[10] << 8) + skb->data[11];
+				BTMTK_INFO("base + offset = %04x %04x\n", crBaseAddr, crRegOffset);
+				memset(cif_dev->o_usb_buf, 0, HCI_MAX_COMMAND_SIZE);
+				cif_dev->o_usb_buf[0] = skb->data[12];
+				cif_dev->o_usb_buf[1] = skb->data[13];
+				cif_dev->o_usb_buf[2] = skb->data[14];
+				cif_dev->o_usb_buf[3] = skb->data[15];
+				ret = usb_control_msg(cif_dev->udev,
+						usb_sndctrlpipe(cif_dev->udev, 0),
+						2, 0x5E, crBaseAddr, crRegOffset,
+						cif_dev->o_usb_buf, 4, USB_CTRL_IO_TIMO);
+				if (ret < 0)
+					BTMTK_ERR("write CR(%04X[%04X]) FAILED\n",
+						crBaseAddr, crRegOffset);
+				else
+					BTMTK_INFO("write CR(%04X[%04X])",
+						crBaseAddr, crRegOffset);
+					BTMTK_INFO("value = 0x%02x%02x%02x%02x\n",
+						cif_dev->o_usb_buf[3], cif_dev->o_usb_buf[2],
+						cif_dev->o_usb_buf[1], cif_dev->o_usb_buf[0]);
+				kfree_skb(skb);
+				skb = NULL;
+				return 0;
+			}
+		}
+#endif
+
+		/* For wmt cmd/evt */
+		if (!memcmp(skb->data, &wmt_over_hci_header[1], WMT_OVER_HCI_HEADER_SIZE - 1)) {
+			skb_push(skb, 1);
+			skb->data[0] = 0x01;
+			BTMTK_DBG_RAW(skb->data, skb->len, "%s, 6ffc send_frame", __func__);
+			btmtk_usb_send_cmd(bdev, skb, 100, 20, BTMTK_TX_CMD_FROM_DRV);
+			btusb_submit_wmt_urb(hdev, GFP_KERNEL);
+			return 0;
+		}
+
+		if (BTMTK_IS_BT_0_INTF(ifnum_base)) {
+			if ((is_mt7922(bdev->chip_id) || is_mt7961(bdev->chip_id)) &&
+					cif_dev->bulk_cmd_tx_ep)
+				urb = alloc_bulk_cmd_urb(hdev, skb);
+			else
+				urb = alloc_ctrl_urb(hdev, skb);
+		} else if (BTMTK_IS_BT_1_INTF(ifnum_base)) {
+			if (is_mt7922(bdev->chip_id) || is_mt7961(bdev->chip_id)) {
+				if (cif_dev->bulk_cmd_tx_ep) {
+					UNUSED(alloc_ctrl_bgf1_urb);
+					urb = alloc_bulk_cmd_urb(hdev, skb);
+				} else
+					urb = alloc_ctrl_bgf1_urb(hdev, skb);
+			} else if (is_mt7663(bdev->chip_id)) {
+				urb = alloc_ctrl_urb(hdev, skb);
+			} else {
+				BTMTK_ERR("%s: chip_id(%d) is invalid", __func__, bdev->chip_id);
+				return -ENODEV;
+			}
+		} else {
+			BTMTK_ERR("%s: ifnum_base(%d) is invalid", __func__, ifnum_base);
+			return -ENODEV;
+		}
+
+		if (IS_ERR(urb)) {
+			kfree_skb(skb);
+			skb = NULL;
+			return PTR_ERR(urb);
+		}
+
+		hdev->stat.cmd_tx++;
+		return submit_or_queue_tx_urb(hdev, urb);
+
+	case HCI_ACLDATA_PKT:
+		if (skb->data[0] == 0x00 && skb->data[1] == 0x44) {
+			if (cif_dev->iso_channel && bdev->iso_threshold) {
+				int isoc_pkt_len = 0;
+				int isoc_pkt_padding = 0;
+
+				skb_pull(skb, 4);
+				isoc_pkt_len = skb->data[2] + (skb->data[3] << 8) +
+								HCI_ISO_PKT_HEADER_SIZE;
+				isoc_pkt_padding = bdev->iso_threshold - isoc_pkt_len;
+
+				if (skb_tailroom(skb) < isoc_pkt_padding) {
+					/*
+					 * hci driver allocate the size of skb that is to small,
+					 * need re-allocate
+					 */
+					iso_skb = alloc_skb(HCI_MAX_ISO_SIZE +
+							BT_SKB_RESERVE, GFP_ATOMIC);
+					if (!iso_skb) {
+						BTMTK_ERR("%s allocate skb failed!!", __func__);
+						kfree_skb(skb);
+						skb = NULL;
+						return -ENOMEM;
+					}
+					/* copy skb data into iso_skb */
+					skb_copy_bits(skb, 0,
+						skb_put(iso_skb, skb->len), skb->len);
+					memset(skb_put(iso_skb, isoc_pkt_padding),
+						0, isoc_pkt_padding);
+
+					/* After call back, bt drive will free iso_skb */
+					urb = alloc_intr_iso_urb(hdev, iso_skb);
+					BTMTK_DBG_RAW(iso_skb->data, iso_skb->len,
+						"%s, it's ble iso packet",
+						__func__);
+					/* It's alloc by hci drver, bt driver must be free it. */
+					kfree_skb(skb);
+					skb = NULL;
+					if (IS_ERR(urb)) {
+						kfree_skb(iso_skb);
+						iso_skb = NULL;
+						return PTR_ERR(urb);
+					}
+				} else {
+					memset(skb_put(skb, isoc_pkt_padding), 0, isoc_pkt_padding);
+					urb = alloc_intr_iso_urb(hdev, skb);
+					BTMTK_DBG_RAW(skb->data, skb->len,
+						"%s, it's ble iso packet",
+						__func__);
+					if (IS_ERR(urb)) {
+						kfree_skb(skb);
+						skb = NULL;
+						return PTR_ERR(urb);
+					}
+				}
+			} else {
+				BTMTK_WARN("%s send iso data, but iso channel not exit", __func__);
+				/*
+				 * if iso channel not exist,
+				 * we need to drop iso data then free the skb
+				 */
+				kfree_skb(skb);
+				skb = NULL;
+				return 0;
+			}
+		} else {
+			urb = alloc_bulk_urb(hdev, skb);
+			if (IS_ERR(urb)) {
+				kfree_skb(skb);
+				skb = NULL;
+				return PTR_ERR(urb);
+			}
+		}
+		hdev->stat.acl_tx++;
+		return submit_or_queue_tx_urb(hdev, urb);
+
+	case HCI_SCODATA_PKT:
+		if (hci_conn_num(hdev, SCO_LINK) < 1) {
+			BTMTK_INFO("%s hci_conn sco link = %d",
+				__func__, hci_conn_num(hdev, SCO_LINK));
+			/* We need to study how to solve this in hw_dvt case.*/
+#ifndef CFG_SUPPORT_HW_DVT
+			kfree_skb(skb);
+			skb = NULL;
+			return -ENODEV;
+#endif
+		}
+
+		urb = alloc_isoc_urb(hdev, skb);
+		if (IS_ERR(urb)) {
+			kfree_skb(skb);
+			skb = NULL;
+			return PTR_ERR(urb);
+		}
+
+		hdev->stat.sco_tx++;
+		return submit_tx_urb(hdev, urb);
+	}
+
+	kfree_skb(skb);
+	skb = NULL;
+	return -EILSEQ;
+}
+
+static int btmtk_usb_load_fw_patch_using_dma(struct btmtk_dev *bdev, u8 *image,
+		u8 *fwbuf, int section_dl_size, int section_offset)
+{
+	int cur_len = 0;
+	int ret = 0;
+	s32 sent_len;
+	u8 dl_done_cmd[] = {0x01, 0x6F, 0xFC, 0x05, 0x01, 0x01, 0x01, 0x00, PATCH_PHASE3};
+	u8 event[] = {0x04, 0xE4, 0x05, 0x02, 0x01, 0x01, 0x00, 0x00}; /* event[7] is status*/
+
+	if (bdev == NULL || image == NULL || fwbuf == NULL) {
+		BTMTK_ERR("%s: invalid parameters!", __func__);
+		ret = -1;
+		goto exit;
+	}
+
+	BTMTK_INFO("%s: loading rom patch... start", __func__);
+	while (1) {
+		sent_len = (section_dl_size - cur_len) >= (UPLOAD_PATCH_UNIT - HCI_TYPE_SIZE) ?
+				(UPLOAD_PATCH_UNIT - HCI_TYPE_SIZE) : (section_dl_size - cur_len);
+
+		if (sent_len > 0) {
+			/* btmtk_cif_send_bulk_out will send from image[1],
+			 * image[0] will be ingored
+			 */
+			image[0] = HCI_ACLDATA_PKT;
+			memcpy(&image[HCI_TYPE_SIZE], fwbuf + section_offset + cur_len, sent_len);
+			BTMTK_DBG("%s: sent_len = %d, cur_len = %d", __func__,
+					sent_len, cur_len);
+			ret = btmtk_main_send_cmd(bdev,
+					image, sent_len + HCI_TYPE_SIZE,
+					NULL, -1,
+					0, 0, BTMTK_TX_ACL_FROM_DRV);
+			if (ret < 0) {
+				BTMTK_ERR("%s: send patch failed, terminate", __func__);
+				goto exit;
+			}
+			cur_len += sent_len;
+		} else
+			break;
+	}
+
+	BTMTK_INFO_RAW(dl_done_cmd, sizeof(dl_done_cmd), "%s: send dl cmd - ", __func__);
+	ret = btmtk_main_send_cmd(bdev, dl_done_cmd, sizeof(dl_done_cmd),
+			event, sizeof(event),
+			DELAY_TIMES, RETRY_TIMES, BTMTK_TX_CMD_FROM_DRV);
+	if (ret < 0)
+		BTMTK_ERR("%s: send wmd dl cmd failed, terminate!", __func__);
+	BTMTK_INFO("%s: loading rom patch... Done", __func__);
+
+exit:
+	return ret;
+}
+
+
+static void btusb_notify(struct hci_dev *hdev, unsigned int evt)
+{
+	struct btmtk_dev *bdev = hci_get_drvdata(hdev);
+
+	BTMTK_DBG("%s evt %d", hdev->name, evt);
+
+	if (hci_conn_num(hdev, SCO_LINK) != bdev->sco_num) {
+		bdev->sco_num = hci_conn_num(hdev, SCO_LINK);
+		schedule_work(&bdev->work);
+	}
+}
+
+static inline int __set_isoc_interface(struct hci_dev *hdev, int altsetting)
+{
+	struct btmtk_dev *bdev = hci_get_drvdata(hdev);
+	struct btmtk_usb_dev *cif_dev = (struct btmtk_usb_dev *)bdev->cif_dev;
+	struct usb_interface *intf = cif_dev->isoc;
+	struct usb_endpoint_descriptor *ep_desc;
+	int i, err;
+	unsigned int ifnum_base;
+
+	if (!cif_dev->isoc)
+		return -ENODEV;
+
+	ifnum_base = cif_dev->intf->cur_altsetting->desc.bInterfaceNumber;
+	if (BTMTK_IS_BT_0_INTF(ifnum_base))
+		cif_dev->new_isoc_altsetting_interface = 1;
+	else if (BTMTK_IS_BT_1_INTF(ifnum_base))
+		cif_dev->new_isoc_altsetting_interface = 4;
+	err = usb_set_interface(cif_dev->udev, cif_dev->new_isoc_altsetting_interface, altsetting);
+	BTMTK_DBG("setting interface alt = %d, interface = %d",
+		altsetting, cif_dev->new_isoc_altsetting_interface);
+
+	if (err < 0) {
+		BTMTK_ERR("%s setting interface failed (%d)", hdev->name, -err);
+		return err;
+	}
+
+	bdev->isoc_altsetting = altsetting;
+
+	cif_dev->isoc_tx_ep = NULL;
+	cif_dev->isoc_rx_ep = NULL;
+
+	for (i = 0; i < intf->cur_altsetting->desc.bNumEndpoints; i++) {
+		ep_desc = &intf->cur_altsetting->endpoint[i].desc;
+
+		if (!cif_dev->isoc_tx_ep && usb_endpoint_is_isoc_out(ep_desc)) {
+			cif_dev->isoc_tx_ep = ep_desc;
+			continue;
+		}
+
+		if (!cif_dev->isoc_rx_ep && usb_endpoint_is_isoc_in(ep_desc)) {
+			cif_dev->isoc_rx_ep = ep_desc;
+			continue;
+		}
+	}
+
+	if (!cif_dev->isoc_tx_ep || !cif_dev->isoc_rx_ep) {
+		BTMTK_ERR("%s invalid SCO descriptors", hdev->name);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void btusb_work(struct work_struct *work)
+{
+	struct btmtk_dev *bdev = container_of(work, struct btmtk_dev, work);
+	struct btmtk_usb_dev *cif_dev = (struct btmtk_usb_dev *)bdev->cif_dev;
+	struct hci_dev *hdev = bdev->hdev;
+	int new_alts;
+	int err;
+	unsigned long flags;
+
+	if (bdev->sco_num > 0) {
+		if (!test_bit(BTUSB_DID_ISO_RESUME, &bdev->flags)) {
+			err = usb_autopm_get_interface(cif_dev->isoc ?
+				cif_dev->isoc : cif_dev->intf);
+			if (err < 0) {
+				clear_bit(BTUSB_ISOC_RUNNING, &bdev->flags);
+				usb_kill_anchored_urbs(&cif_dev->isoc_anchor);
+				return;
+			}
+
+			set_bit(BTUSB_DID_ISO_RESUME, &bdev->flags);
+		}
+
+#ifdef CFG_SUPPORT_HW_DVT
+		new_alts = cif_dev->new_isoc_altsetting;
+#else
+		if (hdev->voice_setting & 0x0020) {
+			static const int alts[3] = { 2, 4, 5 };
+
+			new_alts = alts[bdev->sco_num - 1];
+		} else {
+			new_alts = bdev->sco_num;
+		}
+#endif
+
+		clear_bit(BTUSB_ISOC_RUNNING, &bdev->flags);
+		usb_kill_anchored_urbs(&cif_dev->isoc_anchor);
+
+		/* When isochronous alternate setting needs to be
+		 * changed, because SCO connection has been added
+		 * or removed, a packet fragment may be left in the
+		 * reassembling state. This could lead to wrongly
+		 * assembled fragments.
+		 *
+		 * Clear outstanding fragment when selecting a new
+		 * alternate setting.
+		 */
+		spin_lock_irqsave(&bdev->rxlock, flags);
+		kfree_skb(bdev->sco_skb);
+		bdev->sco_skb = NULL;
+		spin_unlock_irqrestore(&bdev->rxlock, flags);
+
+		if (__set_isoc_interface(hdev, new_alts) < 0)
+			return;
+
+		if (!test_and_set_bit(BTUSB_ISOC_RUNNING, &bdev->flags)) {
+			if (btusb_submit_isoc_urb(hdev, GFP_KERNEL) < 0)
+				clear_bit(BTUSB_ISOC_RUNNING, &bdev->flags);
+			else
+				btusb_submit_isoc_urb(hdev, GFP_KERNEL);
+		}
+	} else {
+		clear_bit(BTUSB_ISOC_RUNNING, &bdev->flags);
+		usb_kill_anchored_urbs(&cif_dev->isoc_anchor);
+		BTMTK_INFO("%s set alt to zero", __func__);
+		__set_isoc_interface(hdev, 0);
+		if (test_and_clear_bit(BTUSB_DID_ISO_RESUME, &bdev->flags))
+			usb_autopm_put_interface(cif_dev->isoc ?
+					cif_dev->isoc : cif_dev->intf);
+	}
+}
+
+static void btusb_waker(struct work_struct *work)
+{
+	struct btmtk_dev *bdev = container_of(work, struct btmtk_dev, waker);
+	struct btmtk_usb_dev *cif_dev = (struct btmtk_usb_dev *)bdev->cif_dev;
+	int err;
+
+	err = usb_autopm_get_interface(cif_dev->intf);
+	if (err < 0)
+		return;
+
+	usb_autopm_put_interface(cif_dev->intf);
+}
+
+static int btmtk_usb_toggle_rst_pin(struct btmtk_dev *bdev)
+{
+	struct device_node *node;
+	int rst_pin_num = 0;
+
+	if (!bdev) {
+		BTMTK_WARN("%s: bdev is NULL!", __func__);
+		return -1;
+	}
+	if (bdev->bt_cfg.dongle_reset_gpio_pin == -1) {
+		BTMTK_WARN("%s: bt driver is not ready, please don't call chip reset!", __func__);
+		return -1;
+	}
+
+	BTMTK_INFO("%s: begin", __func__);
+
+	bdev->chip_reset = 1;
+	/* Initialize the interface specific function pointers */
+	reset_func.pf_pdwndFunc =
+		(pdwnc_func) btmtk_kallsyms_lookup_name("PDWNC_SetBTInResetState");
+	if (reset_func.pf_pdwndFunc)
+		BTMTK_INFO("%s: Found PDWNC_SetBTInResetState", __func__);
+	else
+		BTMTK_WARN("%s: No Exported Func Found PDWNC_SetBTInResetState", __func__);
+
+	reset_func.pf_resetFunc2 =
+		(reset_func_ptr2) btmtk_kallsyms_lookup_name("mtk_gpio_set_value");
+	if (!reset_func.pf_resetFunc2)
+		BTMTK_ERR("%s: No Exported Func Found mtk_gpio_set_value", __func__);
+	else
+		BTMTK_INFO("%s: Found mtk_gpio_set_value", __func__);
+
+	reset_func.pf_lowFunc = (set_gpio_low) btmtk_kallsyms_lookup_name("MDrv_GPIO_Set_Low");
+	reset_func.pf_highFunc = (set_gpio_high) btmtk_kallsyms_lookup_name("MDrv_GPIO_Set_High");
+	if (!reset_func.pf_lowFunc || !reset_func.pf_highFunc)
+		BTMTK_WARN("%s: No Exported Func Found MDrv_GPIO_Set_Low or High", __func__);
+	else
+		BTMTK_INFO("%s: Found MDrv_GPIO_Set_Low & MDrv_GPIO_Set_High", __func__);
+
+	if (reset_func.pf_pdwndFunc) {
+		BTMTK_INFO("%s: Invoke PDWNC_SetBTInResetState(%d)", __func__, 1);
+		reset_func.pf_pdwndFunc(1);
+	} else
+		BTMTK_INFO("%s: No Exported Func Found PDWNC_SetBTInResetState", __func__);
+
+	if (reset_func.pf_resetFunc2) {
+		rst_pin_num = bdev->bt_cfg.dongle_reset_gpio_pin;
+		BTMTK_INFO("%s: Invoke bdev->pf_resetFunc2(%d,%d)", __func__, rst_pin_num, 0);
+		reset_func.pf_resetFunc2(rst_pin_num, 0);
+		msleep(RESET_PIN_SET_LOW_TIME);
+		BTMTK_INFO("%s: Invoke bdev->pf_resetFunc2(%d,%d)", __func__, rst_pin_num, 1);
+		reset_func.pf_resetFunc2(rst_pin_num, 1);
+		goto exit;
+	}
+
+	node = of_find_compatible_node(NULL, NULL, "mstar,gpio-wifi-ctl");
+	if (node) {
+		if (of_property_read_u32(node, "wifi-ctl-gpio", &rst_pin_num) == 0) {
+			if (reset_func.pf_lowFunc && reset_func.pf_highFunc) {
+				BTMTK_INFO("%s: Invoke bdev->pf_lowFunc(%d)",
+					__func__, rst_pin_num);
+				reset_func.pf_lowFunc(rst_pin_num);
+				msleep(RESET_PIN_SET_LOW_TIME);
+				BTMTK_INFO("%s: Invoke bdev->pf_highFunc(%d)",
+					__func__, rst_pin_num);
+				reset_func.pf_highFunc(rst_pin_num);
+				goto exit;
+			}
+		} else
+			BTMTK_WARN("%s, failed to obtain wifi control gpio\n", __func__);
+	} else {
+		if (reset_func.pf_lowFunc && reset_func.pf_highFunc) {
+			rst_pin_num = bdev->bt_cfg.dongle_reset_gpio_pin;
+			BTMTK_INFO("%s: Invoke bdev->pf_lowFunc(%d)", __func__, rst_pin_num);
+			reset_func.pf_lowFunc(rst_pin_num);
+			msleep(RESET_PIN_SET_LOW_TIME);
+			BTMTK_INFO("%s: Invoke bdev->pf_highFunc(%d)", __func__, rst_pin_num);
+			reset_func.pf_highFunc(rst_pin_num);
+			goto exit;
+		}
+	}
+
+	/* use linux kernel common api */
+	do {
+		struct device_node *node;
+		int mt76xx_reset_gpio = bdev->bt_cfg.dongle_reset_gpio_pin;
+
+		node = of_find_compatible_node(NULL, NULL, "mediatek,connectivity-combo");
+		if (node) {
+			mt76xx_reset_gpio = of_get_named_gpio(node, "mt76xx-reset-gpio", 0);
+			if (gpio_is_valid(mt76xx_reset_gpio))
+				BTMTK_INFO("%s: Get chip reset gpio(%d)",
+					__func__, mt76xx_reset_gpio);
+			else
+				mt76xx_reset_gpio = bdev->bt_cfg.dongle_reset_gpio_pin;
+		}
+
+		BTMTK_INFO("%s: Invoke Low(%d)", __func__, mt76xx_reset_gpio);
+		gpio_direction_output(mt76xx_reset_gpio, 0);
+		msleep(RESET_PIN_SET_LOW_TIME);
+		BTMTK_INFO("%s: Invoke High(%d)", __func__, mt76xx_reset_gpio);
+		gpio_direction_output(mt76xx_reset_gpio, 1);
+		goto exit;
+	} while (0);
+
+exit:
+	BTMTK_INFO("%s: end", __func__);
+	return 0;
+}
+
+static int btmtk_usb_subsys_reset(struct btmtk_dev *bdev)
+{
+	int val, retry = 10;
+
+	cancel_work_sync(&bdev->work);
+	cancel_work_sync(&bdev->waker);
+
+	clear_bit(BTUSB_BLE_ISOC_RUNNING, &bdev->flags);
+	clear_bit(BTUSB_ISOC_RUNNING, &bdev->flags);
+	clear_bit(BTUSB_BULK_RUNNING, &bdev->flags);
+	clear_bit(BTUSB_INTR_RUNNING, &bdev->flags);
+	bdev->sco_num = 0;
+
+	btusb_stop_traffic((struct btmtk_usb_dev *)bdev->cif_dev);
+
+	/* For reset */
+	btmtk_cif_write_uhw_register(bdev, EP_RST_OPT, EP_RST_IN_OUT_OPT);
+
+	/* read interrupt EP15 CR */
+	btmtk_cif_read_uhw_register(bdev, BT_WDT_STATUS, &val);
+
+	/* Write Reset CR to 1 */
+	btmtk_cif_write_uhw_register(bdev, BT_SUBSYS_RST, 1);
+
+	btmtk_cif_write_uhw_register(bdev, UDMA_INT_STA_BT, 0x000000FF);
+	btmtk_cif_read_uhw_register(bdev, UDMA_INT_STA_BT, &val);
+	btmtk_cif_write_uhw_register(bdev, UDMA_INT_STA_BT1, 0x000000FF);
+	btmtk_cif_read_uhw_register(bdev, UDMA_INT_STA_BT1, &val);
+
+	/* Write Reset CR to 0 */
+	btmtk_cif_write_uhw_register(bdev, BT_SUBSYS_RST, 0);
+
+	/* Read reset CR */
+	btmtk_cif_read_uhw_register(bdev, BT_SUBSYS_RST, &val);
+
+	do {
+		/* polling re-init CR */
+		btmtk_cif_read_uhw_register(bdev, BT_MISC, &val);
+		BTMTK_INFO("%s: reg=%x, value=0x%08x", __func__, BT_MISC, val);
+		if ((val & 0x00000300) == 0x00000300) {
+			/* L0.5 reset done */
+			BTMTK_INFO("%s: Do L0.5 reset successfully.", __func__);
+			goto Finish;
+		} else {
+			BTMTK_INFO("%s: polling MCU-init done CR", __func__);
+		}
+		msleep(100);
+	} while (retry-- > 0);
+
+	/* L0.5 reset failed, do whole chip reset */
+	return -1;
+
+Finish:
+	return 0;
+}
+
+static int btusb_probe(struct usb_interface *intf,
+		       const struct usb_device_id *id)
+{
+	struct usb_endpoint_descriptor *ep_desc;
+	struct btmtk_dev *bdev = NULL;
+	struct btmtk_usb_dev *cif_dev = NULL;
+	unsigned int ifnum_base;
+	int i, err = 0;
+
+	ifnum_base = intf->cur_altsetting->desc.bInterfaceNumber;
+	BTMTK_DBG("intf %p id %p, interfacenum = %d", intf, id, ifnum_base);
+
+	bdev = usb_get_intfdata(intf);
+	if (!bdev) {
+		BTMTK_ERR("[ERR] bdev is NULL");
+		err = -ENOMEM;
+		goto end;
+	}
+	cif_dev = (struct btmtk_usb_dev *)bdev->cif_dev;
+
+	for (i = 0; i < intf->cur_altsetting->desc.bNumEndpoints; i++) {
+		ep_desc = &intf->cur_altsetting->endpoint[i].desc;
+
+		/* reset_intr_ep must be initialized before intr_ep,
+		 * otherwise its address may be the intr_ep address
+		 */
+		if (!cif_dev->reset_intr_ep && ep_desc->bEndpointAddress == 0x8f &&
+			usb_endpoint_is_int_in(ep_desc)) {
+			BTMTK_INFO("intr_reset_rx__ep i = %d Endpoints 0x%02X",
+				i, ep_desc->bEndpointAddress);
+			BTMTK_INFO("number_of_endpoints=%d",
+				intf->cur_altsetting->desc.bNumEndpoints);
+			cif_dev->reset_intr_ep = ep_desc;
+			continue;
+		}
+
+		/* bulk_cmd_tx_ep must be initialized before bulk_tx_ep,
+		 * otherwise its address will be the bulk_tx_ep address
+		 */
+		if (!cif_dev->bulk_cmd_tx_ep && usb_endpoint_is_bulk_out(ep_desc) &&
+			(ep_desc->bEndpointAddress == 0x01 || ep_desc->bEndpointAddress == 0x0b)) {
+			cif_dev->bulk_cmd_tx_ep = ep_desc;
+			BTMTK_INFO("bulk_cmd_tx_ep i = %d, Endpoints 0x%02X"
+				i, ep_desc->bEndpointAddress);
+			BTMTK_INFO("number_of_endpoints=%d",
+				intf->cur_altsetting->desc.bNumEndpoints);
+			continue;
+		}
+
+		if (!cif_dev->intr_ep && usb_endpoint_is_int_in(ep_desc)) {
+			cif_dev->intr_ep = ep_desc;
+			BTMTK_INFO("intr_rx_ep i = %d  Endpoints 0x%02X, number_of_endpoints=%d",
+				i, ep_desc->bEndpointAddress,
+				intf->cur_altsetting->desc.bNumEndpoints);
+			continue;
+		}
+
+		if (!cif_dev->bulk_tx_ep && usb_endpoint_is_bulk_out(ep_desc)) {
+			cif_dev->bulk_tx_ep = ep_desc;
+			BTMTK_INFO("bulk_tx_ep i = %d  Endpoints 0x%02X, number_of_endpoints=%d",
+				i, ep_desc->bEndpointAddress,
+				intf->cur_altsetting->desc.bNumEndpoints);
+			continue;
+		}
+
+		if (!cif_dev->bulk_rx_ep && usb_endpoint_is_bulk_in(ep_desc)) {
+			cif_dev->bulk_rx_ep = ep_desc;
+			BTMTK_INFO("bulk_rx_ep i = %d  Endpoints 0x%02X, number_of_endpoints=%d",
+				i, ep_desc->bEndpointAddress,
+				intf->cur_altsetting->desc.bNumEndpoints);
+			continue;
+		}
+	}
+
+	if (!cif_dev->intr_ep || !cif_dev->bulk_tx_ep || !cif_dev->bulk_rx_ep) {
+		BTMTK_ERR("[ERR] intr_ep or bulk_tx_ep or bulk_rx_ep is NULL");
+		err = -ENODEV;
+		goto end;
+	}
+
+	cif_dev->cmdreq_type = USB_TYPE_CLASS;
+	cif_dev->cmdreq = 0x00;
+
+
+	cif_dev->udev = interface_to_usbdev(intf);
+	cif_dev->intf = intf;
+	bdev->intf_dev = &cif_dev->udev->dev;
+
+	INIT_WORK(&bdev->work, btusb_work);
+	INIT_WORK(&bdev->waker, btusb_waker);
+	/* it's for L0/L0.5 reset */
+	INIT_WORK(&bdev->reset_waker, btmtk_reset_waker);
+	init_usb_anchor(&cif_dev->tx_anchor);
+	spin_lock_init(&bdev->txlock);
+
+	init_usb_anchor(&cif_dev->intr_anchor);
+	init_usb_anchor(&cif_dev->bulk_anchor);
+	init_usb_anchor(&cif_dev->isoc_anchor);
+	init_usb_anchor(&cif_dev->ctrl_anchor);
+	init_usb_anchor(&cif_dev->ble_isoc_anchor);
+	spin_lock_init(&bdev->rxlock);
+
+	err = btmtk_cif_allocate_memory(cif_dev);
+	if (err < 0) {
+		BTMTK_ERR("[ERR] btmtk_cif_allocate_memory failed!");
+		goto end;
+	}
+
+	err = btmtk_main_cif_initialize(bdev, HCI_USB);
+	if (err < 0) {
+		BTMTK_ERR("[ERR] btmtk_main_cif_initialize failed!");
+		goto free_mem;
+	}
+
+	/* only usb interface need this callback to allocate isoc trx endpoint
+	 * There is no need for other interface such as sdio to use this function
+	 */
+	bdev->hdev->notify = btusb_notify;
+
+	SET_HCIDEV_DEV(bdev->hdev, &cif_dev->intf->dev);
+
+	if (BTMTK_IS_BT_0_INTF(ifnum_base) && !(is_mt7922(bdev->chip_id)))
+		err = btmtk_load_rom_patch(bdev);
+	else
+		BTMTK_INFO("interface = %d, don't download patch", ifnum_base);
+
+	if (err < 0) {
+		BTMTK_ERR("btmtk load rom patch failed!");
+		goto deinit;
+	}
+
+	/* For reset */
+	btmtk_cif_write_uhw_register(bdev, EP_RST_OPT, 0x00010001);
+
+	/* Interface numbers are hardcoded in the specification */
+	if (BTMTK_IS_BT_0_INTF(ifnum_base)) {
+		cif_dev->isoc = usb_ifnum_to_if(cif_dev->udev, 1);
+
+		BTMTK_INFO("set interface number 2 for iso ");
+		cif_dev->iso_channel = usb_ifnum_to_if(cif_dev->udev, 2);
+		usb_set_interface(cif_dev->udev, 2, 1);
+		if (cif_dev->iso_channel) {
+			for (i = 0;
+				i < cif_dev->iso_channel->cur_altsetting->desc.bNumEndpoints;
+				i++) {
+				ep_desc = &cif_dev->iso_channel->cur_altsetting->endpoint[i].desc;
+
+				if (!cif_dev->intr_iso_tx_ep && usb_endpoint_is_int_out(ep_desc)) {
+					cif_dev->intr_iso_tx_ep = ep_desc;
+					BTMTK_INFO("intr_iso_tx_ep i = %d Endpoints 0x%02X",
+						i, ep_desc->bEndpointAddress);
+					BTMTK_INFO("number_of_endpoints=%d",
+						intf->cur_altsetting->desc.bNumEndpoints);
+					continue;
+				}
+
+				if (!cif_dev->intr_iso_rx_ep && usb_endpoint_is_int_in(ep_desc)) {
+					cif_dev->intr_iso_rx_ep = ep_desc;
+					BTMTK_INFO("intr_iso_rx_ep i = %d Endpoints 0x%02X",
+						i, ep_desc->bEndpointAddress);
+					BTMTK_INFO("number_of_endpoints=%d",
+						intf->cur_altsetting->desc.bNumEndpoints);
+					continue;
+				}
+			}
+
+			err = usb_driver_claim_interface(&btusb_driver,
+							 cif_dev->iso_channel, bdev);
+			if (err < 0)
+				goto deinit;
+		}
+	} else if (BTMTK_IS_BT_1_INTF(ifnum_base)) {
+		BTMTK_INFO("interface number = 3, set interface number 4");
+		cif_dev->isoc = usb_ifnum_to_if(cif_dev->udev, 4);
+	}
+
+	if (cif_dev->isoc) {
+		err = usb_driver_claim_interface(&btusb_driver,
+						 cif_dev->isoc, bdev);
+		if (err < 0)
+			goto deinit;
+	}
+
+	/* dongle_index - 1 since BT1 is in same interface */
+	if (BTMTK_IS_BT_1_INTF(ifnum_base))
+		bdev->dongle_index--;
+	BTMTK_DBG("%s: bdev->dongle_index = %d ", __func__, bdev->dongle_index);
+
+	usb_set_intfdata(intf, bdev);
+
+	err = btmtk_main_woble_initialize(bdev);
+	if (err < 0) {
+		BTMTK_ERR("btmtk_main_woble_initialize failed!");
+		goto free_setting;
+	}
+
+	btmtk_woble_wake_unlock(bdev);
+
+#if CFG_SUPPORT_BLUEZ
+	err = btmtk_send_init_cmds(bdev);
+	if (err < 0)
+		BTMTK_ERR("%s, btmtk_send_init_cmds failed, err = %d", __func__, err);
+#endif /* CFG_SUPPORT_BLUEZ */
+
+	err = btmtk_register_hci_device(bdev);
+	if (err < 0) {
+		BTMTK_ERR("btmtk_register_hci_device failed!");
+		goto free_setting;
+	}
+
+	return 0;
+
+free_setting:
+	btmtk_free_setting_file(bdev);
+deinit:
+	btmtk_main_cif_uninitialize(bdev, HCI_USB);
+free_mem:
+	btmtk_cif_free_memory(cif_dev);
+end:
+	return err;
+}
+
+static void btusb_disconnect(struct usb_interface *intf)
+{
+	struct btmtk_dev *bdev = NULL;
+	struct btmtk_usb_dev *cif_dev = NULL;
+	struct hci_dev *hdev;
+
+	BTMTK_DBG("intf %p", intf);
+	bdev = usb_get_intfdata(intf);
+	if (!bdev) {
+		BTMTK_WARN("%s: bdev is NULL!", __func__);
+		return;
+	}
+
+	cif_dev = (struct btmtk_usb_dev *)bdev->cif_dev;
+	if (!cif_dev) {
+		BTMTK_WARN("%s: cif_dev is NULL!", __func__);
+		return;
+	}
+
+	hdev = bdev->hdev;
+	usb_set_intfdata(cif_dev->intf, NULL);
+
+	if (cif_dev->isoc)
+		usb_set_intfdata(cif_dev->isoc, NULL);
+
+	if (cif_dev->iso_channel)
+		usb_set_intfdata(cif_dev->iso_channel, NULL);
+
+	if (intf == cif_dev->intf) {
+		if (cif_dev->isoc)
+			usb_driver_release_interface(&btusb_driver, cif_dev->isoc);
+		if (cif_dev->iso_channel)
+			usb_driver_release_interface(&btusb_driver, cif_dev->iso_channel);
+	} else if (intf == cif_dev->isoc) {
+		usb_driver_release_interface(&btusb_driver, cif_dev->intf);
+	} else if (intf == cif_dev->iso_channel) {
+		usb_driver_release_interface(&btusb_driver, cif_dev->intf);
+	}
+
+	btmtk_cif_free_memory(cif_dev);
+
+	btmtk_main_cif_disconnect_notify(bdev, HCI_USB);
+}
+
+#ifdef CONFIG_PM
+static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
+{
+	struct btmtk_dev *bdev = usb_get_intfdata(intf);
+	struct btmtk_usb_dev *cif_dev = (struct btmtk_usb_dev *)bdev->cif_dev;
+	int ret = 0;
+
+	BTMTK_DBG("intf %p", intf);
+
+	if (bdev->suspend_count++) {
+		BTMTK_WARN("%s: Has suspended. suspend_count: %d end",
+			__func__, bdev->suspend_count);
+		return 0;
+	}
+
+#if CFG_SUPPORT_DVT
+	BTMTK_INFO("%s: SKIP Driver woble_suspend flow", __func__);
+#else
+	ret = btmtk_woble_suspend(bdev);
+	if (ret < 0)
+		BTMTK_ERR("%s: btmtk_woble_suspend return fail %d", __func__, ret);
+#endif
+
+	spin_lock_irq(&bdev->txlock);
+	if (!(PMSG_IS_AUTO(message) && bdev->tx_in_flight)) {
+		set_bit(BTUSB_SUSPENDING, &bdev->flags);
+		spin_unlock_irq(&bdev->txlock);
+	} else {
+		spin_unlock_irq(&bdev->txlock);
+		bdev->suspend_count--;
+		return -EBUSY;
+	}
+
+	cancel_work_sync(&bdev->work);
+
+	btusb_stop_traffic(cif_dev);
+	usb_kill_anchored_urbs(&cif_dev->tx_anchor);
+
+	BTMTK_INFO("%s end, suspend_count = %d", __func__, bdev->suspend_count);
+
+	return ret;
+}
+
+static int btusb_resume(struct usb_interface *intf)
+{
+	struct btmtk_dev *bdev = usb_get_intfdata(intf);
+	struct btmtk_usb_dev *cif_dev = (struct btmtk_usb_dev *)bdev->cif_dev;
+	struct hci_dev *hdev = bdev->hdev;
+	int err = 0;
+	unsigned int ifnum_base = intf->cur_altsetting->desc.bInterfaceNumber;
+
+	BTMTK_INFO("%s begin", __func__);
+
+	if (--bdev->suspend_count) {
+		BTMTK_WARN("%s: bdev->suspend_count %d, return 0", __func__,
+				bdev->suspend_count);
+		return 0;
+	}
+
+	/* need to remove it when BT off, need support woble case*/
+	/* if (!test_bit(HCI_RUNNING, &hdev->flags)) {
+	 * BTMTK_WARN("%s: hdev flags is not hci running. return", __func__);
+	 * goto done;
+	 * }
+	 */
+
+	/* when BT off, BTUSB_INTR_RUNNING will be clear,
+	 * so we need to start traffic in btmtk_woble_resume when BT off
+	 */
+	if (test_bit(BTUSB_INTR_RUNNING, &bdev->flags)) {
+		err = btusb_submit_intr_urb(hdev, GFP_NOIO);
+		if (err < 0) {
+			clear_bit(BTUSB_INTR_RUNNING, &bdev->flags);
+			goto done;
+		}
+
+		if (is_mt7961(bdev->chip_id) && BTMTK_IS_BT_0_INTF(ifnum_base)) {
+			BTMTK_INFO("%s 7961 submit urb\n", __func__);
+			if (cif_dev->reset_intr_ep) {
+				err = btusb_submit_intr_reset_urb(hdev, GFP_KERNEL);
+				if (err < 0) {
+					clear_bit(BTUSB_INTR_RUNNING, &bdev->flags);
+					goto done;
+				}
+			} else
+				BTMTK_INFO("%s, reset_intr_ep missing, don't summit",
+					__func__);
+
+			if (cif_dev->intr_iso_rx_ep) {
+				err = btusb_submit_intr_ble_isoc_urb(hdev, GFP_KERNEL);
+				if (err < 0) {
+					usb_kill_anchored_urbs(&cif_dev->ble_isoc_anchor);
+					clear_bit(BTUSB_INTR_RUNNING, &bdev->flags);
+					goto done;
+				}
+			} else
+				BTMTK_INFO("%s, intr_iso_rx_ep missing, don't summit",
+					__func__);
+		}
+	}
+
+	if (test_bit(BTUSB_BULK_RUNNING, &bdev->flags)) {
+		err = btusb_submit_bulk_urb(hdev, GFP_NOIO);
+		if (err < 0) {
+			clear_bit(BTUSB_BULK_RUNNING, &bdev->flags);
+			goto done;
+		}
+
+		btusb_submit_bulk_urb(hdev, GFP_NOIO);
+	}
+
+	if (test_bit(BTUSB_ISOC_RUNNING, &bdev->flags)) {
+		if (btusb_submit_isoc_urb(hdev, GFP_NOIO) < 0)
+			clear_bit(BTUSB_ISOC_RUNNING, &bdev->flags);
+		else
+			btusb_submit_isoc_urb(hdev, GFP_NOIO);
+	}
+
+	if (test_bit(BTUSB_BLE_ISOC_RUNNING, &bdev->flags)) {
+		if (btusb_submit_intr_ble_isoc_urb(hdev, GFP_NOIO) < 0)
+			clear_bit(BTUSB_BLE_ISOC_RUNNING, &bdev->flags);
+		else
+			btusb_submit_intr_ble_isoc_urb(hdev, GFP_NOIO);
+	}
+
+	spin_lock_irq(&bdev->txlock);
+	clear_bit(BTUSB_SUSPENDING, &bdev->flags);
+	spin_unlock_irq(&bdev->txlock);
+	schedule_work(&bdev->work);
+
+#if CFG_SUPPORT_DVT
+	BTMTK_INFO("%s: SKIP Driver woble_resume flow", __func__);
+#else
+	err = btmtk_woble_resume(bdev);
+	if (err < 0) {
+		BTMTK_ERR("%s: btmtk_woble_resume return fail %d", __func__, err);
+		goto done;
+	}
+#endif
+
+	BTMTK_INFO("%s end", __func__);
+
+	return 0;
+
+done:
+	spin_lock_irq(&bdev->txlock);
+	clear_bit(BTUSB_SUSPENDING, &bdev->flags);
+	spin_unlock_irq(&bdev->txlock);
+
+	return err;
+}
+#endif
+
+static int btmtk_cif_probe(struct usb_interface *intf,
+		       const struct usb_device_id *id)
+{
+	int ret = -1;
+	int cif_event = 0;
+	unsigned int ifnum_base;
+	struct btmtk_cif_state *cif_state = NULL;
+	struct btmtk_dev *bdev = NULL;
+
+	/* Mediatek Driver Version */
+	BTMTK_INFO("%s: MTK BT Driver Version : %s", __func__, VERSION);
+
+	/* USB interface only.
+	 * USB will need to identify thru descriptor's interface numbering.
+	 */
+	ifnum_base = intf->cur_altsetting->desc.bInterfaceNumber;
+	BTMTK_DBG("intf %p id %p, interfacenum = %d", intf, id, ifnum_base);
+
+	/* interface numbers are hardcoded in the spec */
+	if (ifnum_base != BT0_MCU_INTERFACE_NUM &&
+		ifnum_base != BT1_MCU_INTERFACE_NUM)
+		return -ENODEV;
+
+	/* Retrieve priv data and set to interface structure */
+	bdev = btmtk_get_dev();
+	usb_set_intfdata(intf, bdev);
+	bdev->cif_dev = &g_usb_dev[bdev->dongle_index][intf_to_idx[ifnum_base]];
+
+	/* Retrieve current HIF event state */
+	cif_event = HIF_EVENT_PROBE;
+	if (BTMTK_CIF_IS_NULL(bdev, cif_event)) {
+		/* Error */
+		BTMTK_WARN("%s intf[%d] priv setting is NULL", __func__, ifnum_base);
+		return -ENODEV;
+	}
+
+	cif_state = &bdev->cif_state[cif_event];
+
+	/* Set Entering state */
+	btmtk_set_chip_state((void *)bdev, cif_state->ops_enter);
+
+	/* Do HIF events */
+	ret = btusb_probe(intf, id);
+
+	/* Set End/Error state */
+	if (ret == 0)
+		btmtk_set_chip_state((void *)bdev, cif_state->ops_end);
+	else
+		btmtk_set_chip_state((void *)bdev, cif_state->ops_error);
+
+	return ret;
+}
+
+static void btmtk_cif_disconnect(struct usb_interface *intf)
+{
+	int cif_event = 0;
+	unsigned int ifnum_base;
+	struct btmtk_cif_state *cif_state = NULL;
+	struct btmtk_dev *bdev = NULL;
+
+	BTMTK_CIF_GET_DEV_PRIV(bdev, intf, ifnum_base);
+
+	/* Retrieve current HIF event state */
+	cif_event = HIF_EVENT_DISCONNECT;
+	if (BTMTK_CIF_IS_NULL(bdev, cif_event)) {
+		/* Error */
+		BTMTK_WARN("%s intf[%d] priv setting is NULL", __func__, ifnum_base);
+		return;
+	}
+
+	cif_state = &bdev->cif_state[cif_event];
+
+	btmtk_usb_cif_mutex_lock(bdev);
+	/* Set Entering state */
+	btmtk_set_chip_state((void *)bdev, cif_state->ops_enter);
+
+	/* Do HIF events */
+	btusb_disconnect(intf);
+
+	/* Set End/Error state */
+	btmtk_set_chip_state((void *)bdev, cif_state->ops_end);
+	btmtk_usb_cif_mutex_unlock(bdev);
+}
+
+#ifdef CONFIG_PM
+static int btmtk_cif_suspend(struct usb_interface *intf, pm_message_t message)
+{
+	int ret = 0;
+	unsigned int ifnum_base;
+	int cif_event = 0;
+	struct btmtk_cif_state *cif_state = NULL;
+	struct btmtk_dev *bdev = NULL;
+	int state = BTMTK_STATE_INIT;
+
+	BTMTK_INFO("%s, enter", __func__);
+	BTMTK_CIF_GET_DEV_PRIV(bdev, intf, ifnum_base);
+
+	state = btmtk_get_chip_state(bdev);
+	/* Retrieve current HIF event state */
+	if (state == BTMTK_STATE_FW_DUMP) {
+		BTMTK_WARN("%s: FW dumping ongoing, don't dos suspend flow!!!", __func__);
+		cif_event = HIF_EVENT_FW_DUMP;
+	} else
+		cif_event = HIF_EVENT_SUSPEND;
+
+	if (BTMTK_IS_BT_0_INTF(ifnum_base) || BTMTK_IS_BT_1_INTF(ifnum_base)) {
+		if (BTMTK_CIF_IS_NULL(bdev, cif_event)) {
+			/* Error */
+			BTMTK_WARN("%s intf[%d] priv setting is NULL", __func__, ifnum_base);
+			return -ENODEV;
+		}
+
+		cif_state = &bdev->cif_state[cif_event];
+
+		/* Set Entering state */
+		btmtk_set_chip_state((void *)bdev, cif_state->ops_enter);
+
+		/* Do HIF events */
+		ret = btusb_suspend(intf, message);
+
+		/* Set End/Error state */
+		if (ret == 0)
+			btmtk_set_chip_state((void *)bdev, cif_state->ops_end);
+		else
+			btmtk_set_chip_state((void *)bdev, cif_state->ops_error);
+	} else
+		BTMTK_INFO("%s, interface num is for isoc interface, do't do suspend!", __func__);
+
+	BTMTK_INFO("%s, end. ret = %d", __func__, ret);
+	return ret;
+}
+
+static int btmtk_cif_resume(struct usb_interface *intf)
+{
+	int ret = 0;
+	unsigned int ifnum_base;
+	int cif_event = 0;
+	struct btmtk_cif_state *cif_state = NULL;
+	struct btmtk_dev *bdev = NULL;
+
+	BTMTK_INFO("%s, enter", __func__);
+	BTMTK_CIF_GET_DEV_PRIV(bdev, intf, ifnum_base);
+
+	if (BTMTK_IS_BT_0_INTF(ifnum_base) || BTMTK_IS_BT_1_INTF(ifnum_base)) {
+		/* Retrieve current HIF event state */
+		cif_event = HIF_EVENT_RESUME;
+		if (BTMTK_CIF_IS_NULL(bdev, cif_event)) {
+			/* Error */
+			BTMTK_WARN("%s intf[%d] priv setting is NULL", __func__, ifnum_base);
+			return -ENODEV;
+		}
+
+		cif_state = &bdev->cif_state[cif_event];
+
+		/* Set Entering state */
+		btmtk_set_chip_state((void *)bdev, cif_state->ops_enter);
+
+		/* Do HIF events */
+		ret = btusb_resume(intf);
+
+		/* Set End/Error state */
+		if (ret == 0)
+			btmtk_set_chip_state((void *)bdev, cif_state->ops_end);
+		else
+			btmtk_set_chip_state((void *)bdev, cif_state->ops_error);
+	} else
+		BTMTK_INFO("%s, interface num is for isoc interface, do't do resume!", __func__);
+
+	BTMTK_INFO("%s, end. ret = %d", __func__, ret);
+	return ret;
+}
+#endif	// CONFIG_PM //
+
+#if !BT_DISABLE_RESET_RESUME
+static int btmtk_cif_reset_resume(struct usb_interface *intf)
+{
+	BTMTK_INFO("%s: Call resume directly", __func__);
+	return btmtk_cif_resume(intf);
+}
+#endif
+
+static struct usb_driver btusb_driver = {
+	.name		= "btusb",
+	.probe		= btmtk_cif_probe,
+	.disconnect	= btmtk_cif_disconnect,
+#ifdef CONFIG_PM
+	.suspend	= btmtk_cif_suspend,
+	.resume		= btmtk_cif_resume,
+#endif
+#if !BT_DISABLE_RESET_RESUME
+	.reset_resume = btmtk_cif_reset_resume,
+#endif
+	.id_table	= btusb_table,
+	.supports_autosuspend = 1,
+	.disable_hub_initiated_lpm = 1,
+};
+
+int btmtk_cif_register(void)
+{
+	int retval = 0;
+	struct hif_hook_ptr hook;
+
+	BTMTK_INFO("%s", __func__);
+
+	memset(&hook, 0, sizeof(hook));
+	hook.open = btmtk_usb_open;
+	hook.close = btmtk_usb_close;
+	hook.reg_read = btmtk_usb_read_register;
+	hook.reg_write = btmtk_usb_write_register;
+	hook.send_cmd = btmtk_usb_send_cmd;
+	hook.send_and_recv = btmtk_usb_send_and_recv;
+	hook.event_filter = btmtk_usb_event_filter;
+	hook.subsys_reset = btmtk_usb_subsys_reset;
+	hook.whole_reset = btmtk_usb_toggle_rst_pin;
+	hook.chip_reset_notify = btmtk_usb_chip_reset_notify;
+	hook.cif_mutex_lock = btmtk_usb_cif_mutex_lock;
+	hook.cif_mutex_unlock = btmtk_usb_cif_mutex_unlock;
+	hook.dl_dma = btmtk_usb_load_fw_patch_using_dma;
+	btmtk_reg_hif_hook(&hook);
+
+	retval = usb_register(&btusb_driver);
+	if (retval)
+		BTMTK_ERR("*** USB registration fail(%d)! ***", retval);
+	else
+		BTMTK_INFO("%s, usb registration success!", __func__);
+	return retval;
+}
+
+int btmtk_cif_deregister(void)
+{
+	BTMTK_INFO("%s", __func__);
+	usb_deregister(&btusb_driver);
+	BTMTK_INFO("%s: Done", __func__);
+	return 0;
+}
+
+static int btmtk_cif_allocate_memory(struct btmtk_usb_dev *cif_dev)
+{
+	BTMTK_INFO("%s", __func__);
+
+	if (cif_dev->o_usb_buf == NULL) {
+		cif_dev->o_usb_buf = kzalloc(HCI_MAX_COMMAND_SIZE, GFP_KERNEL);
+		if (!cif_dev->o_usb_buf) {
+			BTMTK_ERR("%s: alloc memory fail (bdev->o_usb_buf)", __func__);
+			return -1;
+		}
+	}
+
+	if (cif_dev->urb_intr_buf == NULL) {
+		cif_dev->urb_intr_buf = kzalloc(URB_MAX_BUFFER_SIZE, GFP_KERNEL);
+		if (!cif_dev->urb_intr_buf) {
+			BTMTK_ERR("%s: alloc memory fail (bdev->urb_intr_buf)", __func__);
+			return -1;
+		}
+	}
+	if (cif_dev->urb_bulk_buf == NULL) {
+		cif_dev->urb_bulk_buf = kzalloc(URB_MAX_BUFFER_SIZE, GFP_KERNEL);
+		if (!cif_dev->urb_bulk_buf) {
+			BTMTK_ERR("%s: alloc memory fail (bdev->urb_bulk_buf)", __func__);
+			return -1;
+		}
+	}
+	if (cif_dev->urb_ble_isoc_buf == NULL) {
+		cif_dev->urb_ble_isoc_buf = kzalloc(URB_MAX_BUFFER_SIZE, GFP_KERNEL);
+		if (!cif_dev->urb_ble_isoc_buf) {
+			BTMTK_ERR("%s: alloc memory fail (bdev->urb_ble_isoc_buf)", __func__);
+			return -1;
+		}
+	}
+
+	BTMTK_INFO("%s: Done", __func__);
+	return 0;
+}
+
+static void btmtk_cif_free_memory(struct btmtk_usb_dev *cif_dev)
+{
+	if (!cif_dev) {
+		BTMTK_ERR("%s: bdev is NULL!", __func__);
+		return;
+	}
+
+	kfree(cif_dev->o_usb_buf);
+	cif_dev->o_usb_buf = NULL;
+
+	kfree(cif_dev->urb_intr_buf);
+	cif_dev->urb_intr_buf = NULL;
+
+	kfree(cif_dev->urb_bulk_buf);
+	cif_dev->urb_bulk_buf = NULL;
+
+	kfree(cif_dev->urb_ble_isoc_buf);
+	cif_dev->urb_ble_isoc_buf = NULL;
+
+	memset(cif_dev, 0, sizeof(struct btmtk_usb_dev));
+
+	BTMTK_INFO("%s: Success", __func__);
+}
+
+static int btmtk_cif_write_uhw_register(struct btmtk_dev *bdev, u32 reg, u32 val)
+{
+	struct btmtk_usb_dev *cif_dev = (struct btmtk_usb_dev *)bdev->cif_dev;
+	int ret = -1;
+	__le16 reg_high;
+	__le16 reg_low;
+	u8 reset_buf[4];
+
+	reg_high = ((reg >> 16) & 0xffff);
+	reg_low = (reg & 0xffff);
+
+	reset_buf[0] = (val & 0x00ff);
+	reset_buf[1] = ((val >> 8) & 0x00ff);
+	reset_buf[2] = ((val >> 16) & 0x00ff);
+	reset_buf[3] = ((val >> 24) & 0x00ff);
+
+	memcpy(cif_dev->o_usb_buf, reset_buf, sizeof(reset_buf));
+	ret = usb_control_msg(cif_dev->udev, usb_sndctrlpipe(cif_dev->udev, 0),
+			0x02,						/* bRequest */
+			0x5E,						/* bRequestType */
+			reg_high,					/* wValue */
+			reg_low,					/* wIndex */
+			cif_dev->o_usb_buf,
+			sizeof(reset_buf), USB_CTRL_IO_TIMO);
+
+	BTMTK_DBG("%s: high=%x, reg_low=%x, val=%x", __func__, reg_high, reg_low, val);
+	BTMTK_DBG("%s: reset_buf = %x %x %x %x",
+		__func__, reset_buf[3], reset_buf[2], reset_buf[1], reset_buf[0]);
+
+	if (ret < 0) {
+		val = 0xffffffff;
+		BTMTK_ERR("%s: error(%d), reg=%x, value=%x", __func__, ret, reg, val);
+		return ret;
+	}
+	return 0;
+}
+
+static int btmtk_cif_read_uhw_register(struct btmtk_dev *bdev, u32 reg, u32 *val)
+{
+	struct btmtk_usb_dev *cif_dev = (struct btmtk_usb_dev *)bdev->cif_dev;
+	int ret = -1;
+	__le16 reg_high;
+	__le16 reg_low;
+
+	reg_high = ((reg >> 16) & 0xffff);
+	reg_low = (reg & 0xffff);
+
+	memset(bdev->io_buf, 0, IO_BUF_SIZE);
+	ret = usb_control_msg(cif_dev->udev, usb_rcvctrlpipe(cif_dev->udev, 0),
+			0x01,						/* bRequest */
+			0xDE,						/* bRequestType */
+			reg_high,					/* wValue */
+			reg_low,					/* wIndex */
+			bdev->io_buf,
+			4, USB_CTRL_IO_TIMO);
+
+	if (ret < 0) {
+		*val = 0xffffffff;
+		BTMTK_ERR("%s: error(%d), reg=%x, value=0x%08x", __func__, ret, reg, *val);
+		return ret;
+	}
+
+	memmove(val, bdev->io_buf, sizeof(u32));
+	*val = le32_to_cpu(*val);
+
+	BTMTK_DBG("%s: reg=%x, value=0x%08x", __func__, reg, *val);
+
+	return 0;
+}
+
+static int btmtk_usb_read_register(struct btmtk_dev *bdev, u32 reg, u32 *val)
+{
+	struct btmtk_usb_dev *cif_dev = (struct btmtk_usb_dev *)bdev->cif_dev;
+	int ret = -1;
+	__le16 reg_high;
+	__le16 reg_low;
+
+	reg_high = ((reg >> 16) & 0xffff);
+	reg_low = (reg & 0xffff);
+
+	memset(bdev->io_buf, 0, IO_BUF_SIZE);
+	ret = usb_control_msg(cif_dev->udev, usb_rcvctrlpipe(cif_dev->udev, 0),
+			0x63,						/* bRequest */
+			DEVICE_VENDOR_REQUEST_IN,	/* bRequestType */
+			reg_high,					/* wValue */
+			reg_low,					/* wIndex */
+			bdev->io_buf,
+			sizeof(u32), USB_CTRL_IO_TIMO);
+
+	if (ret < 0) {
+		*val = 0xffffffff;
+		BTMTK_ERR("%s: error(%d), reg=%x, value=%x", __func__, ret, reg, *val);
+		return ret;
+	}
+
+	memmove(val, bdev->io_buf, sizeof(u32));
+	*val = le32_to_cpu(*val);
+
+	return 0;
+}
+
+static int btmtk_usb_write_register(struct btmtk_dev *bdev, u32 reg, u32 val)
+{
+	struct btmtk_usb_dev *cif_dev = (struct btmtk_usb_dev *)bdev->cif_dev;
+	int ret = -1;
+	__le16 reg_high;
+	__le16 reg_low;
+	u8 buf[4];
+
+	reg_high = ((reg >> 16) & 0xffff);
+	reg_low = (reg & 0xffff);
+
+	buf[0] = 0;
+	buf[1] = 0;
+	buf[2] = (val & 0x00ff);
+	buf[3] = ((val >> 8) & 0x00ff);
+
+	memcpy(cif_dev->o_usb_buf, buf, sizeof(buf));
+	ret = usb_control_msg(cif_dev->udev, usb_sndctrlpipe(cif_dev->udev, 0),
+			0x66,						/* bRequest */
+			0x40,	/* bRequestType */
+			reg_high,					/* wValue */
+			reg_low,					/* wIndex */
+			cif_dev->o_usb_buf,
+			sizeof(buf), USB_CTRL_IO_TIMO);
+
+	BTMTK_DBG("%s: buf = %x %x %x %x", __func__, buf[3], buf[2], buf[1], buf[0]);
+
+	if (ret < 0) {
+		val = 0xffffffff;
+		BTMTK_ERR("%s: error(%d), reg=%x, value=%x", __func__, ret, reg, val);
+		return ret;
+	}
+
+	return 0;
+}
+
+
+int btmtk_cif_send_calibration(struct btmtk_dev *bdev)
+{
+	return 0;
+}
+
+static void btmtk_cif_load_rom_patch_complete(struct urb *urb)
+{
+	struct completion *sent_to_mcu_done = (struct completion *)urb->context;
+
+	complete(sent_to_mcu_done);
+}
+
+int btmtk_cif_send_control_out(struct btmtk_dev *bdev, struct sk_buff *skb, int delay, int retry)
+{
+	struct btmtk_usb_dev *cif_dev = NULL;
+	int ret = 0;
+	unsigned int ifnum_base;
+
+	if (bdev == NULL || bdev->hdev == NULL || bdev->io_buf == NULL || skb == NULL ||
+		skb->len > HCI_MAX_COMMAND_SIZE || skb->len <= 0) {
+		BTMTK_ERR("%s: incorrect parameter", __func__);
+		ret = -1;
+		goto exit;
+	}
+
+	cif_dev = (struct btmtk_usb_dev *)bdev->cif_dev;
+	if (cif_dev->udev == NULL || cif_dev->o_usb_buf == NULL) {
+		BTMTK_ERR("%s: cif_dev is invalid", __func__);
+		ret = -1;
+		goto exit;
+	}
+
+	ifnum_base = cif_dev->intf->cur_altsetting->desc.bInterfaceNumber;
+
+	/* send wmt command */
+	memcpy(cif_dev->o_usb_buf, skb->data + 1, skb->len - 1);
+	BTMTK_INFO_RAW(skb->data + 1, skb->len - 1, "%s: cmd:", __func__);
+	if (BTMTK_IS_BT_0_INTF(ifnum_base))
+		ret = usb_control_msg(cif_dev->udev, usb_sndctrlpipe(cif_dev->udev, 0),
+				0x01, DEVICE_CLASS_REQUEST_OUT,
+				0x30, 0x00, (void *)cif_dev->o_usb_buf,
+				skb->len - 1, USB_CTRL_IO_TIMO);
+	else if (BTMTK_IS_BT_1_INTF(ifnum_base))
+		ret = usb_control_msg(cif_dev->udev, usb_sndctrlpipe(cif_dev->udev, 0),
+				0x00, 0x21, 0x00, 0x03,
+				(void *)cif_dev->o_usb_buf, skb->len - 1, USB_CTRL_IO_TIMO);
+
+	if (ret < 0) {
+		BTMTK_ERR("%s: command send failed(%d)", __func__, ret);
+		goto exit;
+	}
+exit:
+	kfree_skb(skb);
+	skb = NULL;
+	return ret;
+}
+
+static int btmtk_cif_send_bulk_out(struct btmtk_dev *bdev, struct sk_buff *skb)
+{
+	int ret = 0;
+	struct urb *urb;
+	unsigned int pipe;
+	struct completion sent_to_mcu_done;
+	void *buf;
+	struct btmtk_usb_dev *cif_dev = (struct btmtk_usb_dev *)bdev->cif_dev;
+
+	urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!urb) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+
+	/* why need to alloc dma buffer??*/
+	buf = usb_alloc_coherent(cif_dev->udev, UPLOAD_PATCH_UNIT, GFP_KERNEL, &urb->transfer_dma);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto exit;
+	}
+	init_completion(&sent_to_mcu_done);
+
+	pipe = usb_sndbulkpipe(cif_dev->udev, cif_dev->bulk_tx_ep->bEndpointAddress);
+
+	memcpy(buf, skb->data + 1, skb->len - 1);
+	usb_fill_bulk_urb(urb,
+			cif_dev->udev,
+			pipe,
+			buf,
+			skb->len - 1,
+			(usb_complete_t)btmtk_cif_load_rom_patch_complete,
+			&sent_to_mcu_done);
+
+	urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+
+	ret = usb_submit_urb(urb, GFP_KERNEL);
+	if (ret < 0) {
+		BTMTK_ERR("%s: submit urb failed (%d)", __func__, ret);
+		goto error;
+	}
+
+	if (!wait_for_completion_timeout
+			(&sent_to_mcu_done, msecs_to_jiffies(1000))) {
+		usb_kill_urb(urb);
+		BTMTK_ERR("%s: upload rom_patch timeout", __func__);
+		ret = -ETIME;
+		goto error;
+	}
+
+error:
+	usb_free_coherent(cif_dev->udev, UPLOAD_PATCH_UNIT, buf, urb->transfer_dma);
+exit:
+	usb_free_urb(urb);
+	kfree_skb(skb);
+	skb = NULL;
+	return ret;
+}
+
+int btmtk_usb_send_cmd(struct btmtk_dev *bdev, struct sk_buff *skb,
+		int delay, int retry, int pkt_type)
+{
+	int ret = -1;
+
+	if (pkt_type == BTMTK_TX_CMD_FROM_DRV) {
+		/* handle wmt cmd from driver */
+		ret = btmtk_cif_send_control_out(bdev, skb, delay, retry);
+	} else if (pkt_type == BTMTK_TX_ACL_FROM_DRV) {
+		/* bulk out for load rom patch*/
+		ret = btmtk_cif_send_bulk_out(bdev, skb);
+	} else if (pkt_type == BTMTK_TX_PKT_FROM_HOST) {
+		/* handle hci cmd and acl pkt from host, handle hci cmd from driver */
+		ret = btusb_send_frame(bdev->hdev, skb);
+	}
+
+	return ret;
+}
+
+static int btmtk_cif_recv_evt(struct btmtk_dev *bdev, int delay, int retry)
+{
+	struct btmtk_usb_dev *cif_dev = NULL;
+	int ret = -1;	/* if successful, 0 */
+	unsigned int ifnum_base;
+
+	if (bdev == NULL) {
+		BTMTK_ERR("%s: bdev == NULL!\n", __func__);
+		return ret;
+	}
+
+	cif_dev = (struct btmtk_usb_dev *)bdev->cif_dev;
+	if (!cif_dev->udev || !bdev->hdev) {
+		BTMTK_ERR("%s: invalid parameters!\n", __func__);
+		return ret;
+	}
+
+	ifnum_base = cif_dev->intf->cur_altsetting->desc.bInterfaceNumber;
+get_response_again:
+	/* ms delay */
+	mdelay(delay);
+
+	/* check WMT event */
+	memset(bdev->io_buf, 0, IO_BUF_SIZE);
+	bdev->io_buf[0] = HCI_EVENT_PKT;
+	if (BTMTK_IS_BT_0_INTF(ifnum_base))
+		ret = usb_control_msg(cif_dev->udev, usb_rcvctrlpipe(cif_dev->udev, 0),
+				0x01, DEVICE_VENDOR_REQUEST_IN, 0x30, 0x00, bdev->io_buf + 1,
+				HCI_USB_IO_BUF_SIZE, USB_CTRL_IO_TIMO);
+	else if (BTMTK_IS_BT_1_INTF(ifnum_base))
+		ret = usb_control_msg(cif_dev->udev, usb_rcvctrlpipe(cif_dev->udev, 0),
+				0x01, 0xA1, 0x30, 0x03, bdev->io_buf + 1, HCI_USB_IO_BUF_SIZE,
+				USB_CTRL_IO_TIMO);
+
+	if (ret < 0) {
+		BTMTK_ERR("%s: event get failed(%d)", __func__, ret);
+		return ret;
+	}
+
+	if (ret > 0) {
+		BTMTK_DBG_RAW(bdev->io_buf, ret + 1, "%s OK: EVT:", __func__);
+		return ret + 1; /* return read length */
+	} else if (retry > 0) {
+		BTMTK_WARN("%s: Trying to get response... (%d)", __func__, ret);
+		retry--;
+		goto get_response_again;
+	} else
+		BTMTK_ERR("%s NG: do not got response:(%d)", __func__, ret);
+
+	return -1;
+}
+
+int btmtk_usb_send_and_recv(struct btmtk_dev *bdev,
+		struct sk_buff *skb,
+		const uint8_t *event, const int event_len,
+		int delay, int retry, int pkt_type)
+{
+	unsigned long comp_event_timo = 0, start_time = 0;
+	int ret = 0;
+
+	if (bdev == NULL) {
+		BTMTK_ERR("%s: bdev == NULL!\n", __func__);
+		return ret;
+	}
+
+	if ((pkt_type == BTMTK_TX_CMD_FROM_DRV || pkt_type == BTMTK_TX_ACL_FROM_DRV)) {
+		BTMTK_DBG_RAW(skb->data, skb->len, "%s, send, len = %d", __func__, skb->len);
+
+		ret = btmtk_usb_send_cmd(bdev, skb, delay, retry, pkt_type);
+		if (ret < 0) {
+			BTMTK_ERR("%s btmtk_usb_send_cmd failed!!", __func__);
+			goto exit;
+		}
+
+		if (event && event_len > 0) {
+			bdev->recv_evt_len = btmtk_cif_recv_evt(bdev, delay, retry);
+			if (bdev->recv_evt_len < 0) {
+				BTMTK_ERR("%s btmtk_cif_recv_evt failed!!", __func__);
+				ret = -1;
+				goto exit;
+			}
+
+			if (bdev->io_buf && bdev->recv_evt_len >= event_len) {
+				if (memcmp(bdev->io_buf, event, event_len) == 0) {
+					ret = 0;
+					goto exit;
+				}
+			}
+			BTMTK_INFO("%s compare fail\n", __func__);
+			BTMTK_INFO_RAW(event, event_len, "%s: event_need_compare:", __func__);
+			BTMTK_INFO_RAW(bdev->io_buf, bdev->recv_evt_len, "%s: RCV:", __func__);
+			ret = -1;
+		} else {
+			ret = 0;
+		}
+	} else {
+		if (event) {
+			if (event_len > EVENT_COMPARE_SIZE) {
+				BTMTK_ERR("%s, event_len (%d) > EVENT_COMPARE_SIZE(%d), error",
+					__func__, event_len, EVENT_COMPARE_SIZE);
+				ret = -1;
+				goto exit;
+			}
+			event_compare_status = BTMTK_EVENT_COMPARE_STATE_NEED_COMPARE;
+			memcpy(event_need_compare, event + 1, event_len - 1);
+			event_need_compare_len = event_len - 1;
+
+			start_time = jiffies;
+			/* check hci event /wmt event for SDIO/UART interface, check hci
+			 * event for USB interface
+			 */
+			comp_event_timo = jiffies + msecs_to_jiffies(WOBLE_COMP_EVENT_TIMO);
+			BTMTK_INFO("event_need_compare_len %d, event_compare_status %d",
+				event_need_compare_len, event_compare_status);
+		} else {
+			event_compare_status = BTMTK_EVENT_COMPARE_STATE_COMPARE_SUCCESS;
+		}
+
+		BTMTK_DBG_RAW(skb->data, skb->len, "%s, send, len = %d", __func__, skb->len);
+
+		ret = btmtk_usb_send_cmd(bdev, skb, delay, retry, pkt_type);
+		if (ret < 0) {
+			BTMTK_ERR("%s btmtk_sdio_send_cmd failed!!", __func__);
+			goto exit;
+		}
+
+		do {
+			/* check if event_compare_success */
+			if (event_compare_status == BTMTK_EVENT_COMPARE_STATE_COMPARE_SUCCESS) {
+				ret = 0;
+				break;
+			}
+			usleep_range(10, 100);
+		} while (time_before(jiffies, comp_event_timo));
+
+		event_compare_status = BTMTK_EVENT_COMPARE_STATE_NOTHING_NEED_COMPARE;
+	}
+
+exit:
+	return ret;
+}
+
+void btmtk_usb_chip_reset_notify(struct btmtk_dev *bdev)
+{
+	cancel_work_sync(&bdev->work);
+	cancel_work_sync(&bdev->waker);
+}
+
+int btmtk_usb_event_filter(struct btmtk_dev *bdev, struct sk_buff *skb)
+{
+	if (event_compare_status == BTMTK_EVENT_COMPARE_STATE_NEED_COMPARE &&
+		skb->len >= event_need_compare_len) {
+		if (memcmp(skb->data, READ_ADDRESS_EVENT,
+			sizeof(READ_ADDRESS_EVENT)) == 0 && (skb->len == 12)) {
+			memcpy(bdev->bdaddr, &skb->data[6], BD_ADDRESS_SIZE);
+			BTMTK_INFO("GET BDADDR = %02X:%02X:%02X:%02X:%02X:%02X",
+				bdev->bdaddr[0], bdev->bdaddr[1], bdev->bdaddr[2],
+				bdev->bdaddr[3], bdev->bdaddr[4], bdev->bdaddr[5]);
+
+			event_compare_status = BTMTK_EVENT_COMPARE_STATE_COMPARE_SUCCESS;
+		} else if (memcmp(skb->data, event_need_compare,
+					event_need_compare_len) == 0) {
+			/* if it is wobx debug event, just print in kernel log, drop it
+			 * by driver, don't send to stack
+			 */
+			if (skb->data[0] == 0xE8)
+				BTMTK_INFO_RAW(skb->data, skb->len,
+					"%s: wobx debug log:", __func__);
+
+			event_compare_status = BTMTK_EVENT_COMPARE_STATE_COMPARE_SUCCESS;
+			BTMTK_INFO("%s, compare success", __func__);
+		} else {
+			BTMTK_INFO("%s compare fail", __func__);
+			BTMTK_INFO_RAW(event_need_compare, event_need_compare_len,
+				"%s: event_need_compare:", __func__);
+			BTMTK_INFO_RAW(skb->data, skb->len, "%s: skb->data:", __func__);
+			return 0;
+		}
+
+		return 1;
+	}
+
+	return 0;
+}
-- 
2.18.0

