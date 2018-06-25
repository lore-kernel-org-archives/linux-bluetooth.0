Return-Path: <bgodavar@codeaurora.org>
From: Balakrishna Godavarthi <bgodavar@codeaurora.org>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	mka@chromium.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	rtatiya@codeaurora.org,
	hemantg@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v8 3/7] Bluetooth: btqca: Redefine qca_uart_setup() to generic function.
Date: Mon, 25 Jun 2018 19:10:09 +0530
Message-Id: <20180625134013.19684-4-bgodavar@codeaurora.org>
In-Reply-To: <20180625134013.19684-1-bgodavar@codeaurora.org>
References: <20180625134013.19684-1-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Redefinition of qca_uart_setup will help future Qualcomm Bluetooth
SoC, to use the same function instead of duplicating the function.
Added new arguments soc_type and soc_ver to the functions.

These arguments will help to decide type of firmware files
to be loaded into Bluetooth chip.
soc_type holds the Bluetooth chip connected to APPS processor.
soc_ver holds the Bluetooth chip version.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
Changes in v8:
    * updated soc_type with enum.

Changes in v7:
    * initial patch
    * redefined qca_uart_setup function to generic.
---
 drivers/bluetooth/btqca.c   | 23 ++++++++++++-----------
 drivers/bluetooth/btqca.h   | 13 +++++++++++--
 drivers/bluetooth/hci_qca.c |  3 ++-
 3 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index c5cf9cab438a..3b25be1be19c 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -327,9 +327,9 @@ int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 }
 EXPORT_SYMBOL_GPL(qca_set_bdaddr_rome);
 
-int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate)
+int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
+		   enum qca_btsoc_type soc_type, u32 soc_ver)
 {
-	u32 rome_ver = 0;
 	struct rome_config config;
 	int err;
 
@@ -337,19 +337,20 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate)
 
 	config.user_baud_rate = baudrate;
 
-	/* Get QCA version information */
-	err = qca_read_soc_version(hdev, &rome_ver);
-	if (err < 0 || rome_ver == 0) {
-		bt_dev_err(hdev, "QCA Failed to get version %d", err);
-		return err;
+	if (!soc_ver) {
+		/* Get QCA version information */
+		err = qca_read_soc_version(hdev, &soc_ver);
+		if (err < 0 || soc_ver == 0) {
+			bt_dev_err(hdev, "QCA Failed to get version (%d)", err);
+			return err;
+		}
+		bt_dev_info(hdev, "QCA controller version 0x%08x", soc_ver);
 	}
 
-	bt_dev_info(hdev, "QCA controller version 0x%08x", rome_ver);
-
 	/* Download rampatch file */
 	config.type = TLV_TYPE_PATCH;
 	snprintf(config.fwname, sizeof(config.fwname), "qca/rampatch_%08x.bin",
-		 rome_ver);
+		 soc_ver);
 	err = qca_download_firmware(hdev, &config);
 	if (err < 0) {
 		bt_dev_err(hdev, "QCA Failed to download patch (%d)", err);
@@ -359,7 +360,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate)
 	/* Download NVM configuration */
 	config.type = TLV_TYPE_NVM;
 	snprintf(config.fwname, sizeof(config.fwname), "qca/nvm_%08x.bin",
-		 rome_ver);
+		 soc_ver);
 	err = qca_download_firmware(hdev, &config);
 	if (err < 0) {
 		bt_dev_err(hdev, "QCA Failed to download NVM (%d)", err);
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index 5c9851b11838..24d6667eecf1 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -124,10 +124,18 @@ struct tlv_type_hdr {
 	__u8   data[0];
 } __packed;
 
+enum qca_btsoc_type {
+	QCA_INVALID = -1,
+	QCA_AR3002,
+	QCA_ROME,
+	QCA_WCN3990
+};
+
 #if IS_ENABLED(CONFIG_BT_QCA)
 
 int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr);
-int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate);
+int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
+		   enum qca_btsoc_type soc_type, u32 soc_ver);
 int qca_read_soc_version(struct hci_dev *hdev, u32 *soc_version);
 
 #else
@@ -137,7 +145,8 @@ static inline int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdad
 	return -EOPNOTSUPP;
 }
 
-static inline int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate)
+static inline int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
+				 enum qca_btsoc_type soc_type, u32 soc_ver);
 {
 	return -EOPNOTSUPP;
 }
diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index d7b60669b656..fe62420ef838 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -929,6 +929,7 @@ static int qca_setup(struct hci_uart *hu)
 	struct qca_data *qca = hu->priv;
 	unsigned int speed, qca_baudrate = QCA_BAUDRATE_115200;
 	int ret;
+	int soc_ver = 0;
 
 	bt_dev_info(hdev, "ROME setup");
 
@@ -966,7 +967,7 @@ static int qca_setup(struct hci_uart *hu)
 	}
 
 	/* Setup patch / NVM configurations */
-	ret = qca_uart_setup(hdev, qca_baudrate);
+	ret = qca_uart_setup(hdev, qca_baudrate, QCA_ROME, soc_ver);
 	if (!ret) {
 		set_bit(STATE_IN_BAND_SLEEP_ENABLED, &qca->flags);
 		qca_debugfs_init(hdev);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
