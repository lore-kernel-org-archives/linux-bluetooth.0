Return-Path: <bgodavar@qualcomm.com>
From: Balakrishna Godavarthi <bgodavar@bgodavar-linux.qualcomm.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	mka@chromium.org
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	thierry.escande@linaro.org,
	rtatiya@codeaurora.org,
	hemantg@codeaurora.org,
	linux-arm-msm@vger.kernel.org,
	Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v11 6/7] Bluetooth: btqca: Add wcn3990 firmware download support.
Date: Fri, 27 Jul 2018 19:43:19 +0530
Message-Id: <20180727141320.25218-7-bgodavar@bgodavar-linux.qualcomm.com>
In-Reply-To: <20180727141320.25218-1-bgodavar@bgodavar-linux.qualcomm.com>
References: <20180727141320.25218-1-bgodavar@bgodavar-linux.qualcomm.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Balakrishna Godavarthi <bgodavar@codeaurora.org>

This patch enables the RAM and NV patch download for wcn3990.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 drivers/bluetooth/btqca.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index b2163bf75b95..211318671775 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -338,6 +338,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 {
 	struct rome_config config;
 	int err;
+	u8 rom_ver;
 
 	bt_dev_dbg(hdev, "QCA setup on UART");
 
@@ -345,8 +346,19 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 
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
@@ -355,8 +367,13 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 
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
2.17.1
