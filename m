Return-Path: <bgodavar@codeaurora.org>
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	rtatiya@codeaurora.org,
	hemantg@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v4 3/3] Bluetooth: btqca: Add wcn3990 firmware download support.
Date: Fri,  4 May 2018 21:05:06 +0530
Message-Id: <1525448106-18616-4-git-send-email-bgodavar@codeaurora.org>
In-Reply-To: <1525448106-18616-1-git-send-email-bgodavar@codeaurora.org>
References: <1525448106-18616-1-git-send-email-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch enables the RAM and NV patch download for wcn3990.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
 drivers/bluetooth/btqca.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btqca.h | 19 +++++++++++++++++++
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 8219816..12b4dd3 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -27,7 +27,7 @@
 
 #define VERSION "0.1"
 
-static int rome_patch_ver_req(struct hci_dev *hdev, u32 *rome_version)
+int rome_patch_ver_req(struct hci_dev *hdev, u32 *rome_version)
 {
 	struct sk_buff *skb;
 	struct edl_event_hdr *edl;
@@ -380,6 +380,49 @@ int qca_uart_setup_rome(struct hci_dev *hdev, uint8_t baudrate)
 }
 EXPORT_SYMBOL_GPL(qca_uart_setup_rome);
 
+int qca_uart_setup_cherokee(struct hci_dev *hdev, uint8_t baudrate,
+			    u32 *soc_ver)
+{
+	struct rome_config config;
+	int err;
+
+	/* we are using the existing funciton of ROME,
+	 * instead of duplicating the function for wcn3990.
+	 */
+	config.user_baud_rate = baudrate;
+	/* Download rampatch file */
+	config.type = TLV_TYPE_PATCH;
+	snprintf(config.fwname, sizeof(config.fwname), "qca/rampatch_%08x.tlv",
+		 *soc_ver);
+	err = rome_download_firmware(hdev, &config);
+	if (err < 0) {
+		BT_ERR("%s: Failed to download patch (%d)", hdev->name, err);
+		return err;
+	}
+
+	/* Download NVM configuration */
+	config.type = TLV_TYPE_NVM;
+	snprintf(config.fwname, sizeof(config.fwname), "qca/nvm_%08x.bin",
+		 *soc_ver);
+	err = rome_download_firmware(hdev, &config);
+	if (err < 0) {
+		BT_ERR("%s: Failed to download NVM (%d)", hdev->name, err);
+		return err;
+	}
+
+	/* Perform HCI reset */
+	err = rome_reset(hdev);
+	if (err < 0) {
+		BT_ERR("%s: Failed to run HCI_RESET (%d)", hdev->name, err);
+		return err;
+	}
+
+	bt_dev_info(hdev, "wcn3990 setup on UART is completed");
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qca_uart_setup_cherokee);
+
 MODULE_AUTHOR("Ben Young Tae Kim <ytkim@qca.qualcomm.com>");
 MODULE_DESCRIPTION("Bluetooth support for Qualcomm Atheros family ver " VERSION);
 MODULE_VERSION(VERSION);
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index 13d77fd..2b41987 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -37,6 +37,9 @@
 #define EDL_TAG_ID_HCI			(17)
 #define EDL_TAG_ID_DEEP_SLEEP		(27)
 
+#define CHEROKEE_POWERON_PULSE		(0xFC)
+#define CHEROKEE_POWEROFF_PULSE		(0xC0)
+
 enum qca_bardrate {
 	QCA_BAUDRATE_115200 	= 0,
 	QCA_BAUDRATE_57600,
@@ -124,10 +127,16 @@ struct tlv_type_hdr {
 	__u8   data[0];
 } __packed;
 
+int qca_btsoc_cleanup(struct hci_dev *hdev);
+int btqca_power_setup(bool on);
+
 #if IS_ENABLED(CONFIG_BT_QCA)
 
 int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 int qca_uart_setup_rome(struct hci_dev *hdev, uint8_t baudrate);
+int qca_uart_setup_cherokee(struct hci_dev *hdev, uint8_t baudrate,
+			    u32 *soc_ver);
+int rome_patch_ver_req(struct hci_dev *hdev, u32 *rome_version);
 
 #else
 
@@ -141,4 +150,14 @@ static inline int qca_uart_setup_rome(struct hci_dev *hdev, int speed)
 	return -EOPNOTSUPP;
 }
 
+static int qca_uart_setup_cherokee(struct hci_dev *hdev, uint8_t baudrate,
+				   u32 *soc_ver)
+{
+	return -EOPNOTSUPP;
+}
+
+static int rome_patch_ver_req(struct hci_dev *hdev, u32 *rome_version)
+{
+	return -EOPNOTSUPP;
+}
 #endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
