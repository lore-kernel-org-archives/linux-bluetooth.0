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
Subject: [PATCH v6 4/5] Bluetooth: btqca: Add wcn3990 firmware download support.
Date: Thu, 24 May 2018 21:30:50 +0530
Message-Id: <20180524160051.29966-5-bgodavar@codeaurora.org>
In-Reply-To: <20180524160051.29966-1-bgodavar@codeaurora.org>
References: <20180524160051.29966-1-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch enables the RAM and NV patch download for wcn3990.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
Changes in v6:
	* add code to derive the firmware files based on ROM Version.
	* created new patch for common function of ROME and wcn3990.

Changes in v5:
	* moved changes related to hci_qca.
	* addressed review comments.
 
Changes in v4:
	* initial patch.

---
 drivers/bluetooth/btqca.c | 45 +++++++++++++++++++++++++++++++++++++++
 drivers/bluetooth/btqca.h |  8 +++++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index 5c3551239b12..cef3daf3285b 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -380,6 +380,51 @@ int qca_uart_setup_rome(struct hci_dev *hdev, uint8_t baudrate)
 }
 EXPORT_SYMBOL_GPL(qca_uart_setup_rome);
 
+int qca_uart_setup_cherokee(struct hci_dev *hdev, uint8_t baudrate,
+			    u32 *soc_ver)
+{
+	struct rome_config config;
+	int err;
+	u8 rom_ver;
+
+	/* Which firmware files to download are based on ROM version.
+	 * ROM version is derived from last two bytes of soc_ver.
+	 */
+	rom_ver = ((*soc_ver & 0x00000f00) >> 0x04) | (*soc_ver & 0x0000000f);
+	config.user_baud_rate = baudrate;
+	/* Download rampatch file */
+	config.type = TLV_TYPE_PATCH;
+	snprintf(config.fwname, sizeof(config.fwname), "qca/crbtfw%02x.tlv",
+		 rom_ver);
+	err = rome_download_firmware(hdev, &config);
+	if (err < 0) {
+		BT_ERR("%s: Failed to download patch (%d)", hdev->name, err);
+		return err;
+	}
+
+	/* Download NVM configuration */
+	config.type = TLV_TYPE_NVM;
+	snprintf(config.fwname, sizeof(config.fwname), "qca/crnv%02x.bin",
+		 rom_ver);
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
index c1504a49fd79..e93e0660cf6c 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -129,6 +129,8 @@ struct tlv_type_hdr {
 int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 int qca_uart_setup_rome(struct hci_dev *hdev, uint8_t baudrate);
 int qca_patch_ver_req(struct hci_dev *hdev, u32 *rome_version);
+int qca_uart_setup_cherokee(struct hci_dev *hdev, uint8_t baudrate,
+			    u32 *soc_ver);
 
 #else
 
@@ -147,4 +149,10 @@ static inline int qca_patch_ver_req(struct hci_dev *hdev, u32 *rome_version)
 	return -EOPNOTSUPP;
 }
 
+static int qca_uart_setup_cherokee(struct hci_dev *hdev, uint8_t baudrate,
+				   u32 *soc_ver)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
