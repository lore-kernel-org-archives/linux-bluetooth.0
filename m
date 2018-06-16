Return-Path: <bgodavar@codeaurora.org>
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	robh@kernel.org,
	mka@chromium.org,
	thierry.escande@linaro.org
Cc: linux-bluetooth@vger.kernel.org,
	rtatiya@codeaurora.org,
	hemantg@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v7 2/8] Bluetooth: btqca: Rename string ROME to QCA in logs.
Date: Sat, 16 Jun 2018 11:57:12 +0530
Message-Id: <20180616062718.29844-3-bgodavar@codeaurora.org>
In-Reply-To: <20180616062718.29844-1-bgodavar@codeaurora.org>
References: <20180616062718.29844-1-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

To have generic text in bt_dev_info, bt_dev_err and bt_dev_dbg
updated from ROME to QCA where ever possible. This avoids
confusion to user, when using the future Qualcomm Bluetooth SoC's.
Updated BT_DBG, BT_ERR and BT_INFO with bt_dev_dbg, bt_dev_err and
bt_dev_info where ever applicable.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
Changes in v7:
	* initial patch.
	* Updated the logs to generic.

---
 drivers/bluetooth/btqca.c | 56 +++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 29 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 8219816c54a0..a36fae1f3c2c 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -35,36 +35,35 @@ static int rome_patch_ver_req(struct hci_dev *hdev, u32 *rome_version)
 	char cmd;
 	int err = 0;
 
-	BT_DBG("%s: ROME Patch Version Request", hdev->name);
+	bt_dev_dbg(hdev, "QCA Version Request");
 
 	cmd = EDL_PATCH_VER_REQ_CMD;
 	skb = __hci_cmd_sync_ev(hdev, EDL_PATCH_CMD_OPCODE, EDL_PATCH_CMD_LEN,
 				&cmd, HCI_VENDOR_PKT, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		err = PTR_ERR(skb);
-		BT_ERR("%s: Failed to read version of ROME (%d)", hdev->name,
-		       err);
+		bt_dev_err(hdev, "Reading QCA version information failed (%d)",
+			   err);
 		return err;
 	}
 
 	if (skb->len != sizeof(*edl) + sizeof(*ver)) {
-		BT_ERR("%s: Version size mismatch len %d", hdev->name,
-		       skb->len);
+		bt_dev_err(hdev, "QCA Version size mismatch len %d", skb->len);
 		err = -EILSEQ;
 		goto out;
 	}
 
 	edl = (struct edl_event_hdr *)(skb->data);
 	if (!edl) {
-		BT_ERR("%s: TLV with no header", hdev->name);
+		bt_dev_err(hdev, "QCA TLV with no header");
 		err = -EILSEQ;
 		goto out;
 	}
 
 	if (edl->cresp != EDL_CMD_REQ_RES_EVT ||
 	    edl->rtype != EDL_APP_VER_RES_EVT) {
-		BT_ERR("%s: Wrong packet received %d %d", hdev->name,
-		       edl->cresp, edl->rtype);
+		bt_dev_err(hdev, "QCA Wrong packet received %d %d", edl->cresp,
+			   edl->rtype);
 		err = -EIO;
 		goto out;
 	}
@@ -76,7 +75,7 @@ static int rome_patch_ver_req(struct hci_dev *hdev, u32 *rome_version)
 	BT_DBG("%s: ROM    :0x%08x", hdev->name, le16_to_cpu(ver->rome_ver));
 	BT_DBG("%s: SOC    :0x%08x", hdev->name, le32_to_cpu(ver->soc_id));
 
-	/* ROME chipset version can be decided by patch and SoC
+	/* QCA chipset version can be decided by patch and SoC
 	 * version, combination with upper 2 bytes from SoC
 	 * and lower 2 bytes from patch will be used.
 	 */
@@ -94,12 +93,12 @@ static int rome_reset(struct hci_dev *hdev)
 	struct sk_buff *skb;
 	int err;
 
-	BT_DBG("%s: ROME HCI_RESET", hdev->name);
+	bt_dev_dbg(hdev, "QCA HCI_RESET");
 
 	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		err = PTR_ERR(skb);
-		BT_ERR("%s: Reset failed (%d)", hdev->name, err);
+		bt_dev_err(hdev, "QCA Reset failed (%d)", err);
 		return err;
 	}
 
@@ -228,19 +227,19 @@ static int rome_tlv_send_segment(struct hci_dev *hdev, int seg_size,
 				HCI_VENDOR_PKT, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		err = PTR_ERR(skb);
-		BT_ERR("%s: Failed to send TLV segment (%d)", hdev->name, err);
+		bt_dev_err(hdev, "QCA Failed to send TLV segment (%d)", err);
 		return err;
 	}
 
 	if (skb->len != sizeof(*edl) + sizeof(*tlv_resp)) {
-		BT_ERR("%s: TLV response size mismatch", hdev->name);
+		bt_dev_err(hdev, "QCA TLV response size mismatch");
 		err = -EILSEQ;
 		goto out;
 	}
 
 	edl = (struct edl_event_hdr *)(skb->data);
 	if (!edl) {
-		BT_ERR("%s: TLV with no header", hdev->name);
+		bt_dev_err(hdev, "TLV with no header");
 		err = -EILSEQ;
 		goto out;
 	}
@@ -249,8 +248,8 @@ static int rome_tlv_send_segment(struct hci_dev *hdev, int seg_size,
 
 	if (edl->cresp != EDL_CMD_REQ_RES_EVT ||
 	    edl->rtype != EDL_TVL_DNLD_RES_EVT || tlv_resp->result != 0x00) {
-		BT_ERR("%s: TLV with error stat 0x%x rtype 0x%x (0x%x)",
-		       hdev->name, edl->cresp, edl->rtype, tlv_resp->result);
+		bt_dev_err(hdev, "QCA TLV with error stat 0x%x rtype 0x%x (0x%x)",
+			   edl->cresp, edl->rtype, tlv_resp->result);
 		err = -EIO;
 	}
 
@@ -267,12 +266,12 @@ static int rome_download_firmware(struct hci_dev *hdev,
 	const u8 *segment;
 	int ret, remain, i = 0;
 
-	bt_dev_info(hdev, "ROME Downloading %s", config->fwname);
+	bt_dev_info(hdev, "QCA Downloading %s", config->fwname);
 
 	ret = request_firmware(&fw, config->fwname, &hdev->dev);
 	if (ret) {
-		BT_ERR("%s: Failed to request file: %s (%d)", hdev->name,
-		       config->fwname, ret);
+		bt_dev_err(hdev, "QCA Failed to request file: %s (%d)",
+			   config->fwname, ret);
 		return ret;
 	}
 
@@ -317,8 +316,7 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 				HCI_VENDOR_PKT, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		err = PTR_ERR(skb);
-		BT_ERR("%s: Change address command failed (%d)",
-		       hdev->name, err);
+		bt_dev_err(hdev, "QCA Change address command failed (%d)", err);
 		return err;
 	}
 
@@ -334,18 +332,18 @@ int qca_uart_setup_rome(struct hci_dev *hdev, uint8_t baudrate)
 	struct rome_config config;
 	int err;
 
-	BT_DBG("%s: ROME setup on UART", hdev->name);
+	bt_dev_dbg(hdev, "QCA setup on UART");
 
 	config.user_baud_rate = baudrate;
 
-	/* Get ROME version information */
+	/* Get QCA version information */
 	err = rome_patch_ver_req(hdev, &rome_ver);
 	if (err < 0 || rome_ver == 0) {
-		BT_ERR("%s: Failed to get version 0x%x", hdev->name, err);
+		bt_dev_err(hdev, "QCA Failed to get version %d", err);
 		return err;
 	}
 
-	bt_dev_info(hdev, "ROME controller version 0x%08x", rome_ver);
+	bt_dev_info(hdev, "QCA controller version 0x%08x", rome_ver);
 
 	/* Download rampatch file */
 	config.type = TLV_TYPE_PATCH;
@@ -353,7 +351,7 @@ int qca_uart_setup_rome(struct hci_dev *hdev, uint8_t baudrate)
 		 rome_ver);
 	err = rome_download_firmware(hdev, &config);
 	if (err < 0) {
-		BT_ERR("%s: Failed to download patch (%d)", hdev->name, err);
+		bt_dev_err(hdev, "QCA Failed to download patch (%d)", err);
 		return err;
 	}
 
@@ -363,18 +361,18 @@ int qca_uart_setup_rome(struct hci_dev *hdev, uint8_t baudrate)
 		 rome_ver);
 	err = rome_download_firmware(hdev, &config);
 	if (err < 0) {
-		BT_ERR("%s: Failed to download NVM (%d)", hdev->name, err);
+		bt_dev_err(hdev, "QCA Failed to download NVM (%d)", err);
 		return err;
 	}
 
 	/* Perform HCI reset */
 	err = rome_reset(hdev);
 	if (err < 0) {
-		BT_ERR("%s: Failed to run HCI_RESET (%d)", hdev->name, err);
+		bt_dev_err(hdev, "QCA Failed to run HCI_RESET (%d)", err);
 		return err;
 	}
 
-	bt_dev_info(hdev, "ROME setup on UART is completed");
+	bt_dev_info(hdev, "QCA setup on UART is completed");
 
 	return 0;
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
