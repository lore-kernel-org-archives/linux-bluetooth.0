Return-Path: <loic.poulain@linaro.org>
From: Loic Poulain <loic.poulain@linaro.org>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	bgodavar@codeaurora.org,
	Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH v3 2/2] Bluetooth: btqca: Add AR3002 rampatch support
Date: Thu, 26 Apr 2018 13:13:27 +0200
Message-Id: <1524741207-19753-2-git-send-email-loic.poulain@linaro.org>
In-Reply-To: <1524741207-19753-1-git-send-email-loic.poulain@linaro.org>
References: <1524741207-19753-1-git-send-email-loic.poulain@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds rampatch download compatibility for ROME >= 3.2.
Starting with ROME 3.2, the 'download mode' field of the rampatch
header indicates if the controller acknowledges (or not) the received
rampatch segments. If not, we need to send all the segments without
expecting any event from the controller (except for the last segment).
Goal is (I assume) to speed-up rampatch download.

This fixes BT on Dragonboard-600c P2 which includes the following BT
controller:

hci0: ROME Patch Version Request
hci0: Product:0x00000008
hci0: Patch  :0x00000111
hci0: ROM    :0x00000302
hci0: SOC    :0x00000023

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 v2: Do not check rome version, byte is reserved or dedicated to dnld mode
 v3: coding-style, one line if statement

 drivers/bluetooth/btqca.c | 104 ++++++++++++++++++++++------------------------
 drivers/bluetooth/btqca.h |  11 ++++-
 2 files changed, 59 insertions(+), 56 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 2793d41..8219816 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -127,28 +127,41 @@ static void rome_tlv_check_data(struct rome_config *config,
 	BT_DBG("TLV Type\t\t : 0x%x", type_len & 0x000000ff);
 	BT_DBG("Length\t\t : %d bytes", length);
 
+	config->dnld_mode = ROME_SKIP_EVT_NONE;
+
 	switch (config->type) {
 	case TLV_TYPE_PATCH:
 		tlv_patch = (struct tlv_type_patch *)tlv->data;
-		BT_DBG("Total Length\t\t : %d bytes",
+
+		/* For Rome version 1.1 to 3.1, all segment commands
+		 * are acked by a vendor specific event (VSE).
+		 * For Rome >= 3.2, the download mode field indicates
+		 * if VSE is skipped by the controller.
+		 * In case VSE is skipped, only the last segment is acked.
+		 */
+		config->dnld_mode = tlv_patch->download_mode;
+
+		BT_DBG("Total Length           : %d bytes",
 		       le32_to_cpu(tlv_patch->total_size));
-		BT_DBG("Patch Data Length\t : %d bytes",
+		BT_DBG("Patch Data Length      : %d bytes",
 		       le32_to_cpu(tlv_patch->data_length));
 		BT_DBG("Signing Format Version : 0x%x",
 		       tlv_patch->format_version);
-		BT_DBG("Signature Algorithm\t : 0x%x",
+		BT_DBG("Signature Algorithm    : 0x%x",
 		       tlv_patch->signature);
-		BT_DBG("Reserved\t\t : 0x%x",
-		       le16_to_cpu(tlv_patch->reserved1));
-		BT_DBG("Product ID\t\t : 0x%04x",
+		BT_DBG("Download mode          : 0x%x",
+		       tlv_patch->download_mode);
+		BT_DBG("Reserved               : 0x%x",
+		       tlv_patch->reserved1);
+		BT_DBG("Product ID             : 0x%04x",
 		       le16_to_cpu(tlv_patch->product_id));
-		BT_DBG("Rom Build Version\t : 0x%04x",
+		BT_DBG("Rom Build Version      : 0x%04x",
 		       le16_to_cpu(tlv_patch->rom_build));
-		BT_DBG("Patch Version\t\t : 0x%04x",
+		BT_DBG("Patch Version          : 0x%04x",
 		       le16_to_cpu(tlv_patch->patch_version));
-		BT_DBG("Reserved\t\t : 0x%x",
+		BT_DBG("Reserved               : 0x%x",
 		       le16_to_cpu(tlv_patch->reserved2));
-		BT_DBG("Patch Entry Address\t : 0x%x",
+		BT_DBG("Patch Entry Address    : 0x%x",
 		       le32_to_cpu(tlv_patch->entry));
 		break;
 
@@ -194,8 +207,8 @@ static void rome_tlv_check_data(struct rome_config *config,
 	}
 }
 
-static int rome_tlv_send_segment(struct hci_dev *hdev, int idx, int seg_size,
-				 const u8 *data)
+static int rome_tlv_send_segment(struct hci_dev *hdev, int seg_size,
+				 const u8 *data, enum rome_tlv_dnld_mode mode)
 {
 	struct sk_buff *skb;
 	struct edl_event_hdr *edl;
@@ -203,12 +216,14 @@ static int rome_tlv_send_segment(struct hci_dev *hdev, int idx, int seg_size,
 	u8 cmd[MAX_SIZE_PER_TLV_SEGMENT + 2];
 	int err = 0;
 
-	BT_DBG("%s: Download segment #%d size %d", hdev->name, idx, seg_size);
-
 	cmd[0] = EDL_PATCH_TLV_REQ_CMD;
 	cmd[1] = seg_size;
 	memcpy(cmd + 2, data, seg_size);
 
+	if (mode == ROME_SKIP_EVT_VSE_CC || mode == ROME_SKIP_EVT_VSE)
+		return __hci_cmd_send(hdev, EDL_PATCH_CMD_OPCODE, seg_size + 2,
+				      cmd);
+
 	skb = __hci_cmd_sync_ev(hdev, EDL_PATCH_CMD_OPCODE, seg_size + 2, cmd,
 				HCI_VENDOR_PKT, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
@@ -245,47 +260,12 @@ static int rome_tlv_send_segment(struct hci_dev *hdev, int idx, int seg_size,
 	return err;
 }
 
-static int rome_tlv_download_request(struct hci_dev *hdev,
-				     const struct firmware *fw)
-{
-	const u8 *buffer, *data;
-	int total_segment, remain_size;
-	int ret, i;
-
-	if (!fw || !fw->data)
-		return -EINVAL;
-
-	total_segment = fw->size / MAX_SIZE_PER_TLV_SEGMENT;
-	remain_size = fw->size % MAX_SIZE_PER_TLV_SEGMENT;
-
-	BT_DBG("%s: Total segment num %d remain size %d total size %zu",
-	       hdev->name, total_segment, remain_size, fw->size);
-
-	data = fw->data;
-	for (i = 0; i < total_segment; i++) {
-		buffer = data + i * MAX_SIZE_PER_TLV_SEGMENT;
-		ret = rome_tlv_send_segment(hdev, i, MAX_SIZE_PER_TLV_SEGMENT,
-					    buffer);
-		if (ret < 0)
-			return -EIO;
-	}
-
-	if (remain_size) {
-		buffer = data + total_segment * MAX_SIZE_PER_TLV_SEGMENT;
-		ret = rome_tlv_send_segment(hdev, total_segment, remain_size,
-					    buffer);
-		if (ret < 0)
-			return -EIO;
-	}
-
-	return 0;
-}
-
 static int rome_download_firmware(struct hci_dev *hdev,
 				  struct rome_config *config)
 {
 	const struct firmware *fw;
-	int ret;
+	const u8 *segment;
+	int ret, remain, i = 0;
 
 	bt_dev_info(hdev, "ROME Downloading %s", config->fwname);
 
@@ -298,10 +278,24 @@ static int rome_download_firmware(struct hci_dev *hdev,
 
 	rome_tlv_check_data(config, fw);
 
-	ret = rome_tlv_download_request(hdev, fw);
-	if (ret) {
-		BT_ERR("%s: Failed to download file: %s (%d)", hdev->name,
-		       config->fwname, ret);
+	segment = fw->data;
+	remain = fw->size;
+	while (remain > 0) {
+		int segsize = min(MAX_SIZE_PER_TLV_SEGMENT, remain);
+
+		bt_dev_dbg(hdev, "Send segment %d, size %d", i++, segsize);
+
+		remain -= segsize;
+		/* The last segment is always acked regardless download mode */
+		if (!remain || segsize < MAX_SIZE_PER_TLV_SEGMENT)
+			config->dnld_mode = ROME_SKIP_EVT_NONE;
+
+		ret = rome_tlv_send_segment(hdev, segsize, segment,
+					    config->dnld_mode);
+		if (ret)
+			break;
+
+		segment += segsize;
 	}
 
 	release_firmware(fw);
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index 65e994b..13d77fd 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -61,6 +61,13 @@ enum qca_bardrate {
 	QCA_BAUDRATE_RESERVED
 };
 
+enum rome_tlv_dnld_mode {
+	ROME_SKIP_EVT_NONE,
+	ROME_SKIP_EVT_VSE,
+	ROME_SKIP_EVT_CC,
+	ROME_SKIP_EVT_VSE_CC
+};
+
 enum rome_tlv_type {
 	TLV_TYPE_PATCH = 1,
 	TLV_TYPE_NVM
@@ -70,6 +77,7 @@ struct rome_config {
 	u8 type;
 	char fwname[64];
 	uint8_t user_baud_rate;
+	enum rome_tlv_dnld_mode dnld_mode;
 };
 
 struct edl_event_hdr {
@@ -94,7 +102,8 @@ struct tlv_type_patch {
 	__le32 data_length;
 	__u8   format_version;
 	__u8   signature;
-	__le16 reserved1;
+	__u8   download_mode;
+	__u8   reserved1;
 	__le16 product_id;
 	__le16 rom_build;
 	__le16 patch_version;
-- 
2.7.4
