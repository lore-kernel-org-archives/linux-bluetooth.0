Return-Path: <cyrus@holtmann.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, <gustavo@padovan.org>, <johan.hedberg@gmail.com>,
        <patila@marvell.com>, <huxm@marvell.com>,
        Kevin Gan <ganhy@marvell.com>, Cathy Luo <cluo@marvell.com>,
        Amitkumar Karwar <akarwar@marvell.com>
Subject: [PATCH 2/2] Bluetooth: btmrvl: support Marvell Bluetooth device SD8887
Date: Tue, 30 Sep 2014 06:45:33 -0400
Message-ID: <1412073933-7760-2-git-send-email-akarwar@marvell.com>
In-Reply-To: <1412073933-7760-1-git-send-email-akarwar@marvell.com>
References: <1412073933-7760-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

From: Xinming Hu <huxm@marvell.com>

This patch adds driver support for marvell SD8887 chip.

Signed-off-by: Xinming Hu <huxm@marvell.com>
Signed-off-by: Kevin Gan <ganhy@marvell.com>
Signed-off-by: Cathy Luo <cluo@marvell.com>
Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
 drivers/bluetooth/Kconfig       |  4 ++--
 drivers/bluetooth/btmrvl_sdio.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index fa7fd62..4547dc2 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -201,7 +201,7 @@ config BT_MRVL
 	  The core driver to support Marvell Bluetooth devices.
 
 	  This driver is required if you want to support
-	  Marvell Bluetooth devices, such as 8688/8787/8797/8897.
+	  Marvell Bluetooth devices, such as 8688/8787/8797/8887/8897.
 
 	  Say Y here to compile Marvell Bluetooth driver
 	  into the kernel or say M to compile it as module.
@@ -214,7 +214,7 @@ config BT_MRVL_SDIO
 	  The driver for Marvell Bluetooth chipsets with SDIO interface.
 
 	  This driver is required if you want to use Marvell Bluetooth
-	  devices with SDIO interface. Currently SD8688/SD8787/SD8797/SD8897
+	  devices with SDIO interface. Currently SD8688/SD8787/SD8797/SD8887/SD8897
 	  chipsets are supported.
 
 	  Say Y here to compile support for Marvell BT-over-SDIO driver
diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index b549fb5..550bce0 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -84,6 +84,26 @@ static const struct btmrvl_sdio_card_reg btmrvl_reg_87xx = {
 	.int_read_to_clear = false,
 };
 
+static const struct btmrvl_sdio_card_reg btmrvl_reg_8887 = {
+	.cfg = 0x00,
+	.host_int_mask = 0x08,
+	.host_intstatus = 0x0C,
+	.card_status = 0x5C,
+	.sq_read_base_addr_a0 = 0x6C,
+	.sq_read_base_addr_a1 = 0x6D,
+	.card_revision = 0xC8,
+	.card_fw_status0 = 0x88,
+	.card_fw_status1 = 0x89,
+	.card_rx_len = 0x8A,
+	.card_rx_unit = 0x8B,
+	.io_port_0 = 0xE4,
+	.io_port_1 = 0xE5,
+	.io_port_2 = 0xE6,
+	.int_read_to_clear = true,
+	.host_int_rsr = 0x04,
+	.card_misc_cfg = 0xD8,
+};
+
 static const struct btmrvl_sdio_card_reg btmrvl_reg_8897 = {
 	.cfg = 0x00,
 	.host_int_mask = 0x02,
@@ -128,6 +148,14 @@ static const struct btmrvl_sdio_device btmrvl_sdio_sd8797 = {
 	.sd_blksz_fw_dl	= 256,
 };
 
+static const struct btmrvl_sdio_device btmrvl_sdio_sd8887 = {
+	.helper		= NULL,
+	.firmware	= "mrvl/sd8887_uapsta.bin",
+	.reg		= &btmrvl_reg_8887,
+	.support_pscan_win_report = true,
+	.sd_blksz_fw_dl	= 256,
+};
+
 static const struct btmrvl_sdio_device btmrvl_sdio_sd8897 = {
 	.helper		= NULL,
 	.firmware	= "mrvl/sd8897_uapsta.bin",
@@ -149,6 +177,9 @@ static const struct sdio_device_id btmrvl_sdio_ids[] = {
 	/* Marvell SD8797 Bluetooth device */
 	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, 0x912A),
 			.driver_data = (unsigned long) &btmrvl_sdio_sd8797 },
+	/* Marvell SD8887 Bluetooth device */
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, 0x9136),
+			.driver_data = (unsigned long)&btmrvl_sdio_sd8887 },
 	/* Marvell SD8897 Bluetooth device */
 	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, 0x912E),
 			.driver_data = (unsigned long) &btmrvl_sdio_sd8897 },
@@ -1280,4 +1311,5 @@ MODULE_FIRMWARE("mrvl/sd8688_helper.bin");
 MODULE_FIRMWARE("mrvl/sd8688.bin");
 MODULE_FIRMWARE("mrvl/sd8787_uapsta.bin");
 MODULE_FIRMWARE("mrvl/sd8797_uapsta.bin");
+MODULE_FIRMWARE("mrvl/sd8887_uapsta.bin");
 MODULE_FIRMWARE("mrvl/sd8897_uapsta.bin");
-- 
1.8.1.4
