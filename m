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
Subject: [PATCH v7 3/8] Bluetooth: btqca: Rename ROME related functions to Generic functions
Date: Sat, 16 Jun 2018 11:57:13 +0530
Message-Id: <20180616062718.29844-4-bgodavar@codeaurora.org>
In-Reply-To: <20180616062718.29844-1-bgodavar@codeaurora.org>
References: <20180616062718.29844-1-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Some of the QCA BTSoC ROME functions, are used for different versions
or different make of BTSoC's. Instead of duplicating the same functions
for new chip, updating names of the functions that are used for both
chip's to keep this generic and would help in future when we would have
new BT SoC.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---

Changes in v7:
	* updated the all the functions of ROME to generic.

Changes in v6:
	* initial patch
	* updated names of functions that are used for both the chips to 
	  keep this generic and would help in future when we would have 
	  new BT SoC.

---
 drivers/bluetooth/btqca.c   | 29 +++++++++++++++--------------
 drivers/bluetooth/btqca.h   | 12 +++++++++---
 drivers/bluetooth/hci_qca.c |  2 +-
 3 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index a36fae1f3c2c..c5cf9cab438a 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -27,7 +27,7 @@
 
 #define VERSION "0.1"
 
-static int rome_patch_ver_req(struct hci_dev *hdev, u32 *rome_version)
+int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version)
 {
 	struct sk_buff *skb;
 	struct edl_event_hdr *edl;
@@ -79,7 +79,7 @@ static int rome_patch_ver_req(struct hci_dev *hdev, u32 *rome_version)
 	 * version, combination with upper 2 bytes from SoC
 	 * and lower 2 bytes from patch will be used.
 	 */
-	*rome_version = (le32_to_cpu(ver->soc_id) << 16) |
+	*soc_version = (le32_to_cpu(ver->soc_id) << 16) |
 			(le16_to_cpu(ver->rome_ver) & 0x0000ffff);
 
 out:
@@ -87,8 +87,9 @@ static int rome_patch_ver_req(struct hci_dev *hdev, u32 *rome_version)
 
 	return err;
 }
+EXPORT_SYMBOL_GPL(qca_read_soc_version);
 
-static int rome_reset(struct hci_dev *hdev)
+static int qca_send_reset(struct hci_dev *hdev)
 {
 	struct sk_buff *skb;
 	int err;
@@ -107,7 +108,7 @@ static int rome_reset(struct hci_dev *hdev)
 	return 0;
 }
 
-static void rome_tlv_check_data(struct rome_config *config,
+static void qca_tlv_check_data(struct rome_config *config,
 				const struct firmware *fw)
 {
 	const u8 *data;
@@ -206,7 +207,7 @@ static void rome_tlv_check_data(struct rome_config *config,
 	}
 }
 
-static int rome_tlv_send_segment(struct hci_dev *hdev, int seg_size,
+static int qca_tlv_send_segment(struct hci_dev *hdev, int seg_size,
 				 const u8 *data, enum rome_tlv_dnld_mode mode)
 {
 	struct sk_buff *skb;
@@ -259,7 +260,7 @@ static int rome_tlv_send_segment(struct hci_dev *hdev, int seg_size,
 	return err;
 }
 
-static int rome_download_firmware(struct hci_dev *hdev,
+static int qca_download_firmware(struct hci_dev *hdev,
 				  struct rome_config *config)
 {
 	const struct firmware *fw;
@@ -275,7 +276,7 @@ static int rome_download_firmware(struct hci_dev *hdev,
 		return ret;
 	}
 
-	rome_tlv_check_data(config, fw);
+	qca_tlv_check_data(config, fw);
 
 	segment = fw->data;
 	remain = fw->size;
@@ -289,7 +290,7 @@ static int rome_download_firmware(struct hci_dev *hdev,
 		if (!remain || segsize < MAX_SIZE_PER_TLV_SEGMENT)
 			config->dnld_mode = ROME_SKIP_EVT_NONE;
 
-		ret = rome_tlv_send_segment(hdev, segsize, segment,
+		ret = qca_tlv_send_segment(hdev, segsize, segment,
 					    config->dnld_mode);
 		if (ret)
 			break;
@@ -326,7 +327,7 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 }
 EXPORT_SYMBOL_GPL(qca_set_bdaddr_rome);
 
-int qca_uart_setup_rome(struct hci_dev *hdev, uint8_t baudrate)
+int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate)
 {
 	u32 rome_ver = 0;
 	struct rome_config config;
@@ -337,7 +338,7 @@ int qca_uart_setup_rome(struct hci_dev *hdev, uint8_t baudrate)
 	config.user_baud_rate = baudrate;
 
 	/* Get QCA version information */
-	err = rome_patch_ver_req(hdev, &rome_ver);
+	err = qca_read_soc_version(hdev, &rome_ver);
 	if (err < 0 || rome_ver == 0) {
 		bt_dev_err(hdev, "QCA Failed to get version %d", err);
 		return err;
@@ -349,7 +350,7 @@ int qca_uart_setup_rome(struct hci_dev *hdev, uint8_t baudrate)
 	config.type = TLV_TYPE_PATCH;
 	snprintf(config.fwname, sizeof(config.fwname), "qca/rampatch_%08x.bin",
 		 rome_ver);
-	err = rome_download_firmware(hdev, &config);
+	err = qca_download_firmware(hdev, &config);
 	if (err < 0) {
 		bt_dev_err(hdev, "QCA Failed to download patch (%d)", err);
 		return err;
@@ -359,14 +360,14 @@ int qca_uart_setup_rome(struct hci_dev *hdev, uint8_t baudrate)
 	config.type = TLV_TYPE_NVM;
 	snprintf(config.fwname, sizeof(config.fwname), "qca/nvm_%08x.bin",
 		 rome_ver);
-	err = rome_download_firmware(hdev, &config);
+	err = qca_download_firmware(hdev, &config);
 	if (err < 0) {
 		bt_dev_err(hdev, "QCA Failed to download NVM (%d)", err);
 		return err;
 	}
 
 	/* Perform HCI reset */
-	err = rome_reset(hdev);
+	err = qca_send_reset(hdev);
 	if (err < 0) {
 		bt_dev_err(hdev, "QCA Failed to run HCI_RESET (%d)", err);
 		return err;
@@ -376,7 +377,7 @@ int qca_uart_setup_rome(struct hci_dev *hdev, uint8_t baudrate)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(qca_uart_setup_rome);
+EXPORT_SYMBOL_GPL(qca_uart_setup);
 
 MODULE_AUTHOR("Ben Young Tae Kim <ytkim@qca.qualcomm.com>");
 MODULE_DESCRIPTION("Bluetooth support for Qualcomm Atheros family ver " VERSION);
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index 13d77fd873b6..d0ee96540636 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -37,7 +37,7 @@
 #define EDL_TAG_ID_HCI			(17)
 #define EDL_TAG_ID_DEEP_SLEEP		(27)
 
-enum qca_bardrate {
+enum qca_baudrate {
 	QCA_BAUDRATE_115200 	= 0,
 	QCA_BAUDRATE_57600,
 	QCA_BAUDRATE_38400,
@@ -127,7 +127,8 @@ struct tlv_type_hdr {
 #if IS_ENABLED(CONFIG_BT_QCA)
 
 int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr);
-int qca_uart_setup_rome(struct hci_dev *hdev, uint8_t baudrate);
+int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate);
+int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version);
 
 #else
 
@@ -136,7 +137,12 @@ static inline int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdad
 	return -EOPNOTSUPP;
 }
 
-static inline int qca_uart_setup_rome(struct hci_dev *hdev, int speed)
+static inline int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 51790dd02afb..d7b60669b656 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -966,7 +966,7 @@ static int qca_setup(struct hci_uart *hu)
 	}
 
 	/* Setup patch / NVM configurations */
-	ret = qca_uart_setup_rome(hdev, qca_baudrate);
+	ret = qca_uart_setup(hdev, qca_baudrate);
 	if (!ret) {
 		set_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
 		qca_debugfs_init(hdev);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
