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
Subject: [PATCH v7 7/8] Bluetooth: btqca: Add wcn3990 firmware download support.
Date: Sat, 16 Jun 2018 11:57:17 +0530
Message-Id: <20180616062718.29844-8-bgodavar@codeaurora.org>
In-Reply-To: <20180616062718.29844-1-bgodavar@codeaurora.org>
References: <20180616062718.29844-1-bgodavar@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch enables the RAM and NV patch download for wcn3990.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
Changes in v7:
	* used redefined function qca_uart_setup for firmware download.

Changes in v6:
	* add code to derive the firmware files based on ROM Version.
	* created new patch for common function of ROME and wcn3990.

Changes in v5:
	* moved changes related to hci_qca.
	* addressed review comments.
 
Changes in v4:
	* initial patch.
---
 drivers/bluetooth/btqca.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index f748730039cf..f0a4205068b8 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -332,6 +332,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate, uint8_t soc_type,
 {
 	struct rome_config config;
 	int err;
+	u8 rom_ver;
 
 	bt_dev_dbg(hdev, "QCA setup on UART");
 
@@ -346,11 +347,21 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate, uint8_t soc_type,
 		}
 		bt_dev_info(hdev, "QCA controller version 0x%08x", soc_ver);
 	}
-
 	/* Download rampatch file */
 	config.type = TLV_TYPE_PATCH;
-	snprintf(config.fwname, sizeof(config.fwname), "qca/rampatch_%08x.bin",
-		 soc_ver);
+	if (soc_type == QCA_WCN3990) {
+		/* Firmware files to download are based on ROM version.
+		 * ROM version is derived from last two bytes of soc_ver.
+		 */
+		rom_ver = ((soc_ver & 0x00000f00) >> 0x04) |
+			    (soc_ver & 0x0000000f);
+		snprintf(config.fwname, sizeof(config.fwname),
+			 "qca/crbtfw%02x.tlv", rom_ver);
+	} else {
+		snprintf(config.fwname, sizeof(config.fwname),
+			 "qca/rampatch_%08x.bin", soc_ver);
+	}
+
 	err = qca_download_firmware(hdev, &config);
 	if (err < 0) {
 		bt_dev_err(hdev, "QCA Failed to download patch (%d)", err);
@@ -359,8 +370,13 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate, uint8_t soc_type,
 
 	/* Download NVM configuration */
 	config.type = TLV_TYPE_NVM;
-	snprintf(config.fwname, sizeof(config.fwname), "qca/nvm_%08x.bin",
-		 soc_ver);
+	if (soc_type == QCA_WCN3990)
+		snprintf(config.fwname, sizeof(config.fwname),
+			 "qca/crnv%02x.bin", rom_ver);
+	else
+		snprintf(config.fwname, sizeof(config.fwname),
+			 "qca/nvm_%08x.bin", soc_ver);
+
 	err = qca_download_firmware(hdev, &config);
 	if (err < 0) {
 		bt_dev_err(hdev, "QCA Failed to download NVM (%d)", err);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
