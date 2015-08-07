Return-Path: <cyrus@holtmann.org>
To: <linux-bluetooth@vger.kernel.org>,
	"Kim, Ben Young Tae" <ytkim@qca.qualcomm.com>
From: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
Subject: [PATCH v3 1/2] Bluetooth: btqca: Introduce generic QCA ROME support
Message-ID: <55C40A10.4060807@qca.qualcomm.com>
Date: Thu, 6 Aug 2015 18:29:52 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is for supporting BT for QCA ROME with specific vendor
specific HCI commands and initialization. This will have USB/UART
implementation both, but for now, adding UART vendor specific
commands to patch downloading and set BDaddress using VS command.

Signed-off-by: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
---
 drivers/bluetooth/Kconfig  |   4 +
 drivers/bluetooth/Makefile |   1 +
 drivers/bluetooth/btqca.c  | 395 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btqca.h  | 136 ++++++++++++++++
 4 files changed, 536 insertions(+)
 create mode 100644 drivers/bluetooth/btqca.c
 create mode 100644 drivers/bluetooth/btqca.h

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 79e8234..f580334 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -13,6 +13,10 @@ config BT_RTL
 	tristate
 	select FW_LOADER
 
+config BT_QCA
+	tristate
+	select FW_LOADER
+
 config BT_HCIBTUSB
 	tristate "HCI USB driver"
 	depends on USB
diff --git a/drivers/bluetooth/Makefile b/drivers/bluetooth/Makefile
index f40e194..15a0d1d 100644
--- a/drivers/bluetooth/Makefile
+++ b/drivers/bluetooth/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_BT_MRVL_SDIO)	+= btmrvl_sdio.o
 obj-$(CONFIG_BT_WILINK)		+= btwilink.o
 obj-$(CONFIG_BT_BCM)		+= btbcm.o
 obj-$(CONFIG_BT_RTL)		+= btrtl.o
+obj-$(CONFIG_BT_QCA)		+= btqca.o
 
 btmrvl-y			:= btmrvl_main.o
 btmrvl-$(CONFIG_DEBUG_FS)	+= btmrvl_debugfs.o
diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
new file mode 100644
index 0000000..863cceb
--- /dev/null
+++ b/drivers/bluetooth/btqca.c
@@ -0,0 +1,395 @@
+/*
+ *  Bluetooth supports for Qualcomm Atheros chips
+ *
+ *  Copyright (c) 2015 The Linux Foundation. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+#include <linux/module.h>
+#include <linux/firmware.h>
+#include <linux/tty.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#include "btqca.h"
+
+#define VERSION "0.1"
+
+static int rome_patch_ver_req(struct hci_dev *hdev, u32 *rome_version)
+{
+	struct sk_buff *skb;
+	struct edl_event_hdr *edl;
+	struct rome_version *ver;
+	char cmd;
+	int err, ret = 0;
+
+	BT_DBG("%s: ROME Patch Version Request", hdev->name);
+
+	cmd = EDL_PATCH_VER_REQ_CMD;
+	skb = __hci_cmd_sync_ev(hdev, EDL_PATCH_CMD_OPCODE, EDL_PATCH_CMD_LEN,
+				&cmd, HCI_VENDOR_PKT, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		BT_ERR("%s: Failed to read version of ROME (%d)", hdev->name,
+		       err);
+		return err;
+	}
+
+	if (skb->len != sizeof(*edl) + sizeof(*ver)) {
+		BT_ERR("%s: version size mismatch len %d", hdev->name,
+		       skb->len);
+		ret = -EILSEQ;
+		goto out;
+	}
+
+	edl = (struct edl_event_hdr *)(skb->data);
+	if (!edl || edl->data == NULL) {
+		BT_ERR("%s: tlv no hdr or no data", hdev->name);
+		ret = -EILSEQ;
+		goto out;
+	}
+
+	if (edl->cresp != EDL_CMD_REQ_RES_EVT ||
+	    edl->rtype != EDL_APP_VER_RES_EVT) {
+		BT_ERR("%s: wrong packet received %d %d", hdev->name,
+		       edl->cresp, edl->rtype);
+		ret = -EIO;
+		goto out;
+	}
+
+	ver = (struct rome_version *)(edl->data);
+
+	BT_DBG("%s:Product:0x%08x", hdev->name, le32_to_cpu(ver->product_id));
+	BT_DBG("%s:Patch  :0x%08x", hdev->name, le16_to_cpu(ver->patch_ver));
+	BT_DBG("%s:ROM    :0x%08x", hdev->name, le16_to_cpu(ver->rome_ver));
+	BT_DBG("%s:SOC    :0x%08x", hdev->name, le32_to_cpu(ver->soc_id));
+
+	/* ROME chipset Version can be decided by patch and SOC
+	 * Version, combination with upper 2 bytes from soc
+	 * and lower 2 bytes from patch will be used
+	 */
+	*rome_version = (le32_to_cpu(ver->soc_id) << 16) |
+		        (le16_to_cpu(ver->rome_ver) & 0x0000ffff);
+
+out:
+	kfree_skb(skb);
+
+	return ret;
+}
+
+static int rome_reset(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+	int err;
+
+	BT_DBG("%s: ROME HCI_RESET", hdev->name);
+
+	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		BT_ERR("%s: BCM: Reset failed (%d)", hdev->name, err);
+		return err;
+	}
+
+	kfree_skb(skb);
+
+	return 0;
+}
+
+static void rome_tlv_check_data(struct rome_config *config,
+				const struct firmware *fw)
+{
+	const u8 *data;
+	u32 type_len;
+	u16 tag_id, tag_len;
+	int idx, length;
+	struct tlv_type_hdr *tlv;
+	struct tlv_type_patch *tlv_patch;
+	struct tlv_type_nvm *tlv_nvm;
+
+	tlv = (struct tlv_type_hdr*)fw->data;
+
+	type_len = le32_to_cpu(tlv->type_len);
+
+	BT_INFO("TLV Type\t\t : 0x%x", type_len & 0x000000ff);
+	length = (type_len >> 8) & 0x00ffffff;
+	BT_INFO("Length\t\t : %d bytes", length);
+
+	switch (config->type) {
+	case TLV_TYPE_PATCH:
+		tlv_patch = (struct tlv_type_patch *)tlv->data;
+		BT_INFO("Total Length\t\t : %d bytes",
+			le32_to_cpu(tlv_patch->total_size));
+		BT_INFO("Patch Data Length\t : %d bytes",
+			le32_to_cpu(tlv_patch->data_length));
+		BT_INFO("Signing Format Version : 0x%x",
+			tlv_patch->format_version);
+		BT_INFO("Signature Algorithm\t : 0x%x",
+			tlv_patch->signature);
+		BT_INFO("Reserved\t\t : 0x%x",
+			le16_to_cpu(tlv_patch->reserved1));
+		BT_INFO("Product ID\t\t : 0x%04x",
+			le16_to_cpu(tlv_patch->product_id));
+		BT_INFO("Rom Build Version\t : 0x%04x",
+			le16_to_cpu(tlv_patch->rom_build));
+		BT_INFO("Patch Version\t\t : 0x%04x",
+			le16_to_cpu(tlv_patch->patch_version));
+		BT_INFO("Reserved\t\t : 0x%x",
+			le16_to_cpu(tlv_patch->reserved2));
+		BT_INFO("Patch Entry Address\t : 0x%x",
+			le32_to_cpu(tlv_patch->entry));
+		break;
+
+	case TLV_TYPE_NVM:
+		idx = 0;
+		data = tlv->data;
+		do {
+			tlv_nvm = (struct tlv_type_nvm *)(data + idx);
+
+			tag_id = le16_to_cpu(tlv_nvm->tag_id);
+			tag_len = le16_to_cpu(tlv_nvm->tag_len);
+
+			/* Update NVM tags as needed */
+			switch (tag_id) {
+			case 17:
+			#ifndef QCA_FEATURE_UART_IN_BAND_SLEEP
+				/* HCI transport layer parameters
+				 * disabling software inband sleep
+				 * until hci driver supports IBS
+				 */
+				tlv_nvm->data[0] &= ~0x80;
+			#endif
+				/* UART Baud Rate */
+				tlv_nvm->data[2] = config->user_baud_rate;
+				break;
+
+			#ifndef QCA_FEATURE_DEEP_SLEEP
+			case 27:
+				/* Sleep enable mask
+				 * disabling deep_sleep until IBS driver is up
+				 */
+				tlv_nvm->data[0] &= ~0x01;
+			#endif
+
+				break;
+			}
+
+			idx += (sizeof(u16) + sizeof(u16) + 8 + tag_len);
+		} while (idx < length);
+		break;
+
+	default:
+		BT_ERR("unknown TLV type %d", config->type);
+		break;
+	}
+}
+
+static int rome_tlv_send_segment(struct hci_dev *hdev, int idx, int seg_size,
+				 const u8 *data)
+{
+	struct sk_buff *skb;
+	struct edl_event_hdr *edl;
+	struct tlv_seg_resp *tlv_resp;
+	u8 cmd[MAX_SIZE_PER_TLV_SEGMENT + 2];
+	int err, ret = 0;
+
+	BT_DBG("%s: Download segment #%d size %d", hdev->name, idx, seg_size);
+
+	cmd[0] = EDL_PATCH_TLV_REQ_CMD;
+	cmd[1] = seg_size;
+	memcpy(cmd + 2, data, seg_size);
+
+	skb = __hci_cmd_sync_ev(hdev, EDL_PATCH_CMD_OPCODE, seg_size + 2, cmd,
+				HCI_VENDOR_PKT, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		BT_ERR("%s: Failed to send TLV segment(%d)", hdev->name, err);
+		return err;
+	}
+
+	if (skb->len != sizeof(*edl) + sizeof(*tlv_resp)) {
+		BT_ERR("%s: tlv response size mismatch", hdev->name);
+		ret = -EILSEQ;
+		goto out;
+	}
+
+	edl = (struct edl_event_hdr *)(skb->data);
+	if (!edl || edl->data == NULL) {
+		BT_ERR("%s: tlv no hdr or no data", hdev->name);
+		ret = -EILSEQ;
+		goto out;
+	}
+
+	tlv_resp = (struct tlv_seg_resp *)(edl->data);
+
+	if (edl->cresp != EDL_CMD_REQ_RES_EVT ||
+	    edl->rtype != EDL_TVL_DNLD_RES_EVT || tlv_resp->result != 0x00) {
+		BT_ERR("%s: tlv error stat 0x%x rtype 0x%x (0x%x)", hdev->name,
+		       edl->cresp, edl->rtype, tlv_resp->result);
+		ret = -EIO;
+	}
+
+out:
+	kfree_skb(skb);
+
+	return ret;
+}
+
+static int rome_tlv_download_request(struct hci_dev *hdev,
+				     const struct firmware *fw)
+{
+	const u8 *buffer, *data;
+	int total_segment, remain_size;
+	int ret, i;
+
+	if (!fw || !fw->data)
+		return -EINVAL;
+
+	total_segment = fw->size / MAX_SIZE_PER_TLV_SEGMENT;
+	remain_size = fw->size % MAX_SIZE_PER_TLV_SEGMENT;
+
+	BT_DBG("%s: total segment num %d remain size %d total size %zu",
+	       hdev->name, total_segment, remain_size, fw->size);
+
+	data = fw->data;
+	for (i = 0; i < total_segment; i++) {
+		buffer = data + i * MAX_SIZE_PER_TLV_SEGMENT;
+		ret = rome_tlv_send_segment(hdev, i, MAX_SIZE_PER_TLV_SEGMENT,
+					    buffer);
+		if (ret < 0)
+			return -EIO;
+	}
+
+	if (remain_size) {
+		buffer = data + total_segment * MAX_SIZE_PER_TLV_SEGMENT;
+		ret = rome_tlv_send_segment(hdev, total_segment, remain_size,
+					    buffer);
+		if (ret < 0)
+			return -EIO;
+	}
+
+	return 0;
+}
+
+static int rome_download_firmware(struct hci_dev *hdev,
+				  struct rome_config *config)
+{
+	const struct firmware *fw;
+	int ret;
+
+	BT_INFO("%s: ROME Downloading %s", hdev->name, config->fwname);
+
+	ret = request_firmware(&fw, config->fwname, &hdev->dev);
+	if (ret) {
+		BT_ERR("%s: failed to request file: %s (%d)", hdev->name,
+		       config->fwname, ret);
+		return ret;
+	}
+
+	rome_tlv_check_data(config, fw);
+
+	ret = rome_tlv_download_request(hdev, fw);
+	if (ret) {
+		BT_ERR("%s: fail to download file: %s (%d)", hdev->name,
+		       config->fwname, ret);
+	}
+
+	release_firmware(fw);
+
+	return ret;
+}
+
+int rome_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
+{
+	struct sk_buff *skb;
+	u8 cmd[9];
+	int err;
+
+	cmd[0] = EDL_NVM_ACCESS_SET_REQ_CMD;
+	cmd[1] = 0x02; 			/* TAG ID */
+	cmd[2] = sizeof(bdaddr_t);	/* size */
+	memcpy(cmd + 3, bdaddr, sizeof(bdaddr_t));
+	skb = __hci_cmd_sync_ev(hdev, EDL_NVM_ACCESS_OPCODE, sizeof(cmd), cmd,
+				HCI_VENDOR_PKT, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		BT_ERR("%s: Change address command failed (%d)",
+		       hdev->name, err);
+		return err;
+	}
+
+	kfree_skb(skb);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rome_set_bdaddr);
+
+int rome_uart_setup(struct hci_dev *hdev, uint8_t baudrate)
+{
+	u32 rome_ver = 0;
+	struct rome_config config;
+	int err;
+
+	BT_DBG("%s: rome_uart_setup", hdev->name);
+
+	config.user_baud_rate = baudrate;
+
+	/* get ROME version information */
+	err = rome_patch_ver_req(hdev, &rome_ver);
+	if (err < 0 || rome_ver == 0) {
+		BT_ERR("%s: Fail to get ROME version 0x%x",hdev->name, err);
+		return err;
+	}
+
+	BT_INFO("%s: ROME controller version 0x%08x", hdev->name, rome_ver);
+
+	/* download rampatch file */
+	config.type = TLV_TYPE_PATCH;
+	snprintf(config.fwname, sizeof(config.fwname), "qca/rampatch_%08x.bin",
+		 rome_ver);
+	err = rome_download_firmware(hdev, &config);
+	if (err < 0) {
+		BT_ERR("%s: can't download rampatch (%d)", hdev->name, err);
+		return err;
+	}
+
+	/* download NVM configuration */
+	config.type = TLV_TYPE_NVM;
+	snprintf(config.fwname, sizeof(config.fwname), "qca/nvm_%08x.bin",
+		 rome_ver);
+	err = rome_download_firmware(hdev, &config);
+	if (err < 0) {
+		BT_ERR("%s: can't download NVM file (%d)", hdev->name, err);
+		return err;
+	}
+
+	/* perform HCI reset */
+	err = rome_reset(hdev);
+	if (err < 0) {
+		BT_ERR("%s: can't run HCI_RESET (%d)", hdev->name, err);
+		return err;
+	}
+
+	BT_INFO("%s: ROME uart setup is completed", hdev->name);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(rome_uart_setup);
+
+MODULE_AUTHOR("Ben Young Tae Kim <ytkim@qca.qualcomm.com>");
+MODULE_DESCRIPTION("Bluetooth support for Qualcomm Atheros family ver " VERSION);
+MODULE_VERSION(VERSION);
+MODULE_LICENSE("GPL");
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
new file mode 100644
index 0000000..e243aea
--- /dev/null
+++ b/drivers/bluetooth/btqca.h
@@ -0,0 +1,136 @@
+/*
+ *  Bluetooth supports for Qualcomm Atheros ROME chips
+ *
+ *  Copyright (c) 2015 The Linux Foundation. All rights reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ */
+
+#define QCA_FEATURE_UART_IN_BAND_SLEEP
+#define QCA_FEATURE_DEEP_SLEEP
+
+#define QCA_ROME_BAUDRATE_3M		(0x0E)
+#define EDL_PATCH_CMD_OPCODE		(0xFC00)
+#define EDL_NVM_ACCESS_OPCODE		(0xFC0B)
+#define EDL_PATCH_CMD_LEN		(1)
+#define EDL_PATCH_VER_REQ_CMD		(0x19)
+#define EDL_PATCH_TLV_REQ_CMD		(0x1E)
+#define EDL_NVM_ACCESS_SET_REQ_CMD	(0x01)
+#define MAX_SIZE_PER_TLV_SEGMENT	(243)
+
+#define EDL_CMD_REQ_RES_EVT		(0x00)
+#define EDL_PATCH_VER_RES_EVT		(0x19)
+#define EDL_APP_VER_RES_EVT		(0x02)
+#define EDL_TVL_DNLD_RES_EVT		(0x04)
+#define EDL_CMD_EXE_STATUS_EVT		(0x00)
+#define EDL_SET_BAUDRATE_RSP_EVT	(0x92)
+#define EDL_NVM_ACCESS_CODE_EVT		(0x0B)
+
+enum qca_bardrate_type {
+	QCA_BAUDRATE_115200 	= 0,
+	QCA_BAUDRATE_57600,
+	QCA_BAUDRATE_38400,
+	QCA_BAUDRATE_19200,
+	QCA_BAUDRATE_9600,
+	QCA_BAUDRATE_230400,
+	QCA_BAUDRATE_250000,
+	QCA_BAUDRATE_460800,
+	QCA_BAUDRATE_500000,
+	QCA_BAUDRATE_720000,
+	QCA_BAUDRATE_921600,
+	QCA_BAUDRATE_1000000,
+	QCA_BAUDRATE_1250000,
+	QCA_BAUDRATE_2000000,
+	QCA_BAUDRATE_3000000,
+	QCA_BAUDRATE_4000000,
+	QCA_BAUDRATE_1600000,
+	QCA_BAUDRATE_3200000,
+	QCA_BAUDRATE_3500000,
+	QCA_BAUDRATE_AUTO 	= 0xFE,
+	QCA_BAUDRATE_RESERVED
+};
+
+enum rome_tlv_type {
+	TLV_TYPE_PATCH = 1,
+	TLV_TYPE_NVM
+};
+
+struct rome_config {
+	u8 type;
+	char fwname[64];
+	uint8_t user_baud_rate;
+};
+
+struct edl_event_hdr {
+	__u8	cresp;
+	__u8	rtype;
+	__u8	data[0];
+} __packed;
+
+struct rome_version {
+	__le32 product_id;
+	__le16 patch_ver;
+	__le16 rome_ver;
+	__le32 soc_id;
+} __packed;
+
+struct tlv_seg_resp {
+	__u8 result;
+} __packed;
+
+struct tlv_type_patch {
+	__le32 total_size;
+	__le32 data_length;
+	__u8 format_version;
+	__u8 signature;
+	__le16 reserved1;
+	__le16 product_id;
+	__le16 rom_build;
+	__le16 patch_version;
+	__le16 reserved2;
+	__le32 entry;
+} __packed;
+
+struct tlv_type_nvm {
+	__le16 tag_id;
+	__le16 tag_len;
+	__le32 reserve1;
+	__le32 reserve2;
+	__u8 data[0];
+} __packed;
+
+struct tlv_type_hdr {
+	__le32 type_len;
+	__u8 data[0];
+} __packed;
+
+#if IS_ENABLED(CONFIG_BT_QCA)
+
+int rome_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
+int rome_uart_setup(struct hci_dev *hdev, uint8_t baudrate);
+
+#else
+
+static inline int rome_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int rome_uart_setup(struct hci_dev *hdev, int speed)
+{
+	return -EOPNOTSUPP;
+}
+
+#endif
-- 
2.0.5


