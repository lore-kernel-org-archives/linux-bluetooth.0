Return-Path: <bgodavar@codeaurora.org>
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	mka@chromium.org
Cc: linux-bluetooth@vger.kernel.org,
	rtatiya@codeaurora.org,
	hemantg@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v6 2/5] Bluetooth: btqca: Rename ROME related functions to Generic functions
Date: Thu, 24 May 2018 21:30:48 +0530
Message-Id: <20180524160051.29966-3-bgodavar@codeaurora.org>
In-Reply-To: <20180524160051.29966-1-bgodavar@codeaurora.org>
References: <20180524160051.29966-1-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Some of the QCA BTSoC ROME functions, are used for different versions
or different make of BTSoC's. Instead of duplicating the same functions
for new chip, updating names of the functions that are used for both
chip's to keep this generic and would help in future when we would have
new BT SoC.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---

Changes in v6:
	* initial patch
	* updated names of functions that are used for both the chips to 
	  keep this generic and would help in future when we would have 
	  new BT SoC.

---
 drivers/bluetooth/btqca.c | 14 +++++++-------
 drivers/bluetooth/btqca.h |  6 ++++++
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 8219816c54a0..5c3551239b12 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -27,7 +27,7 @@
 
 #define VERSION "0.1"
 
-static int rome_patch_ver_req(struct hci_dev *hdev, u32 *rome_version)
+int qca_patch_ver_req(struct hci_dev *hdev, u32 *rome_version)
 {
 	struct sk_buff *skb;
 	struct edl_event_hdr *edl;
@@ -35,15 +35,14 @@ static int rome_patch_ver_req(struct hci_dev *hdev, u32 *rome_version)
 	char cmd;
 	int err = 0;
 
-	BT_DBG("%s: ROME Patch Version Request", hdev->name);
+	bt_dev_dbg(hdev, "QCA BTSoC Patch Version Request");
 
 	cmd = EDL_PATCH_VER_REQ_CMD;
 	skb = __hci_cmd_sync_ev(hdev, EDL_PATCH_CMD_OPCODE, EDL_PATCH_CMD_LEN,
 				&cmd, HCI_VENDOR_PKT, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		err = PTR_ERR(skb);
-		BT_ERR("%s: Failed to read version of ROME (%d)", hdev->name,
-		       err);
+		bt_dev_err(hdev, "Failed to read version of BTSoC (%d)", err);
 		return err;
 	}
 
@@ -88,13 +87,14 @@ static int rome_patch_ver_req(struct hci_dev *hdev, u32 *rome_version)
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(qca_patch_ver_req);
 
 static int rome_reset(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
 	int err;
 
-	BT_DBG("%s: ROME HCI_RESET", hdev->name);
+	bt_dev_dbg(hdev, "QCA BTSoC HCI_RESET");
 
 	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
@@ -267,7 +267,7 @@ static int rome_download_firmware(struct hci_dev *hdev,
 	const u8 *segment;
 	int ret, remain, i = 0;
 
-	bt_dev_info(hdev, "ROME Downloading %s", config->fwname);
+	bt_dev_info(hdev, "QCA BTSoC Downloading %s", config->fwname);
 
 	ret = request_firmware(&fw, config->fwname, &hdev->dev);
 	if (ret) {
@@ -339,7 +339,7 @@ int qca_uart_setup_rome(struct hci_dev *hdev, uint8_t baudrate)
 	config.user_baud_rate = baudrate;
 
 	/* Get ROME version information */
-	err = rome_patch_ver_req(hdev, &rome_ver);
+	err = qca_patch_ver_req(hdev, &rome_ver);
 	if (err < 0 || rome_ver == 0) {
 		BT_ERR("%s: Failed to get version 0x%x", hdev->name, err);
 		return err;
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index 13d77fd873b6..c1504a49fd79 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -128,6 +128,7 @@ struct tlv_type_hdr {
 
 int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 int qca_uart_setup_rome(struct hci_dev *hdev, uint8_t baudrate);
+int qca_patch_ver_req(struct hci_dev *hdev, u32 *rome_version);
 
 #else
 
@@ -141,4 +142,9 @@ static inline int qca_uart_setup_rome(struct hci_dev *hdev, int speed)
 	return -EOPNOTSUPP;
 }
 
+static inline int qca_patch_ver_req(struct hci_dev *hdev, u32 *rome_version)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
