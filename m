Return-Path: <cyrus@holtmann.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Cathy Luo <cluo@marvell.com>, Zhaoyang Liu <liuzy@marvell.com>,
	Amitkumar Karwar <akarwar@marvell.com>
Subject: [PATCH 2/2] Bluetooth: btmrvl: add sd8997 chipset support
Date: Fri, 18 Sep 2015 06:40:41 -0700
Message-ID: <1442583641-3182-2-git-send-email-akarwar@marvell.com>
In-Reply-To: <1442583641-3182-1-git-send-email-akarwar@marvell.com>
References: <1442583641-3182-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Zhaoyang Liu <liuzy@marvell.com>

This patch adds support for Marvell's new chipset SD8997.
Register offsets and supported feature flags are updated.

Signed-off-by: Zhaoyang Liu <liuzy@marvell.com>
Signed-off-by: Cathy Luo <cluo@marvell.com>
Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
 drivers/bluetooth/Kconfig       |  4 ++--
 drivers/bluetooth/btmrvl_sdio.c | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 0bd88c9..3d480d8 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -275,7 +275,7 @@ config BT_MRVL
 	  The core driver to support Marvell Bluetooth devices.
 
 	  This driver is required if you want to support
-	  Marvell Bluetooth devices, such as 8688/8787/8797/8887/8897.
+	  Marvell Bluetooth devices, such as 8688/8787/8797/8887/8897/8997.
 
 	  Say Y here to compile Marvell Bluetooth driver
 	  into the kernel or say M to compile it as module.
@@ -289,7 +289,7 @@ config BT_MRVL_SDIO
 	  The driver for Marvell Bluetooth chipsets with SDIO interface.
 
 	  This driver is required if you want to use Marvell Bluetooth
-	  devices with SDIO interface. Currently SD8688/SD8787/SD8797/SD8887/SD8897
+	  devices with SDIO interface. Currently SD8688/SD8787/SD8797/SD8887/SD8897/SD8997
 	  chipsets are supported.
 
 	  Say Y here to compile support for Marvell BT-over-SDIO driver
diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 5f7c9be..6e2c6d5 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -146,6 +146,29 @@ static const struct btmrvl_sdio_card_reg btmrvl_reg_8897 = {
 	.fw_dump_end = 0xea,
 };
 
+static const struct btmrvl_sdio_card_reg btmrvl_reg_8997 = {
+	.cfg = 0x00,
+	.host_int_mask = 0x08,
+	.host_intstatus = 0x0c,
+	.card_status = 0x5c,
+	.sq_read_base_addr_a0 = 0xf8,
+	.sq_read_base_addr_a1 = 0xf9,
+	.card_revision = 0xc8,
+	.card_fw_status0 = 0xe8,
+	.card_fw_status1 = 0xe9,
+	.card_rx_len = 0xea,
+	.card_rx_unit = 0xeb,
+	.io_port_0 = 0xe4,
+	.io_port_1 = 0xe5,
+	.io_port_2 = 0xe6,
+	.int_read_to_clear = true,
+	.host_int_rsr = 0x04,
+	.card_misc_cfg = 0xD8,
+	.fw_dump_ctrl = 0xf0,
+	.fw_dump_start = 0xf1,
+	.fw_dump_end = 0xf8,
+};
+
 static const struct btmrvl_sdio_device btmrvl_sdio_sd8688 = {
 	.helper		= "mrvl/sd8688_helper.bin",
 	.firmware	= "mrvl/sd8688.bin",
@@ -191,6 +214,15 @@ static const struct btmrvl_sdio_device btmrvl_sdio_sd8897 = {
 	.supports_fw_dump = true,
 };
 
+static const struct btmrvl_sdio_device btmrvl_sdio_sd8997 = {
+	.helper         = NULL,
+	.firmware       = "mrvl/sdsd8997_combo.bin",
+	.reg            = &btmrvl_reg_8997,
+	.support_pscan_win_report = true,
+	.sd_blksz_fw_dl = 256,
+	.supports_fw_dump = true,
+};
+
 static const struct sdio_device_id btmrvl_sdio_ids[] = {
 	/* Marvell SD8688 Bluetooth device */
 	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, 0x9105),
@@ -210,6 +242,9 @@ static const struct sdio_device_id btmrvl_sdio_ids[] = {
 	/* Marvell SD8897 Bluetooth device */
 	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, 0x912E),
 			.driver_data = (unsigned long) &btmrvl_sdio_sd8897 },
+	/* Marvell SD8997 Bluetooth device */
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, 0x9142),
+			.driver_data = (unsigned long)&btmrvl_sdio_sd8997 },
 
 	{ }	/* Terminating entry */
 };
@@ -1622,3 +1657,4 @@ MODULE_FIRMWARE("mrvl/sd8787_uapsta.bin");
 MODULE_FIRMWARE("mrvl/sd8797_uapsta.bin");
 MODULE_FIRMWARE("mrvl/sd8887_uapsta.bin");
 MODULE_FIRMWARE("mrvl/sd8897_uapsta.bin");
+MODULE_FIRMWARE("mrvl/sdsd8997_combo.bin");
-- 
1.8.1.4

