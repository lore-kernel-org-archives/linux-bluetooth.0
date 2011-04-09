Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: linux-bluetooth@vger.kernel.org
Cc: Kevin Gan <ganhy@marvell.com>, Tristan Xu <xurf@marvell.com>,
	"Gustavo F. Padovan" <padovan@profusion.mobi>,
	Marcel Holtmann <marcel@holtmann.org>,
	"Stefan A. Popa" <stefan.a.popa@intel.com>,
	Bing Zhao <bzhao@marvell.com>
Subject: [PATCH] Bluetooth: btmrvl: support Marvell Bluetooth device SD8787
Date: Fri,  8 Apr 2011 18:19:33 -0700
Message-Id: <1302311973-10715-1-git-send-email-bzhao@marvell.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Kevin Gan <ganhy@marvell.com>

The SD8787 firmware image is shared with mwifiex driver.
Whoever gets loaded first will be responsible for firmware
downloading.

Signed-off-by: Kevin Gan <ganhy@marvell.com>
Signed-off-by: Tristan Xu <xurf@marvell.com>
Signed-off-by: Bing Zhao <bzhao@marvell.com>
---
 drivers/bluetooth/Kconfig       |    4 +-
 drivers/bluetooth/btmrvl_sdio.c |  124 +++++++++++++++++++++++++++++---------
 drivers/bluetooth/btmrvl_sdio.h |   68 +++++++++++----------
 3 files changed, 132 insertions(+), 64 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 8e0de9a..11b41fd 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -188,7 +188,7 @@ config BT_MRVL
 	  The core driver to support Marvell Bluetooth devices.
 
 	  This driver is required if you want to support
-	  Marvell Bluetooth devices, such as 8688.
+	  Marvell Bluetooth devices, such as 8688/8787.
 
 	  Say Y here to compile Marvell Bluetooth driver
 	  into the kernel or say M to compile it as module.
@@ -201,7 +201,7 @@ config BT_MRVL_SDIO
 	  The driver for Marvell Bluetooth chipsets with SDIO interface.
 
 	  This driver is required if you want to use Marvell Bluetooth
-	  devices with SDIO interface. Currently only SD8688 chipset is
+	  devices with SDIO interface. Currently SD8688/SD8787 chipsets are
 	  supported.
 
 	  Say Y here to compile support for Marvell BT-over-SDIO driver
diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index dcc2a6e..7f521d4 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -49,15 +49,59 @@
 static u8 user_rmmod;
 static u8 sdio_ireg;
 
+static const struct btmrvl_sdio_card_reg btmrvl_reg_8688 = {
+	.cfg = 0x03,
+	.host_int_mask = 0x04,
+	.host_intstatus = 0x05,
+	.card_status = 0x20,
+	.sq_read_base_addr_a0 = 0x10,
+	.sq_read_base_addr_a1 = 0x11,
+	.card_fw_status0 = 0x40,
+	.card_fw_status1 = 0x41,
+	.card_rx_len = 0x42,
+	.card_rx_unit = 0x43,
+	.io_port_0 = 0x00,
+	.io_port_1 = 0x01,
+	.io_port_2 = 0x02,
+};
+static const struct btmrvl_sdio_card_reg btmrvl_reg_8787 = {
+	.cfg = 0x00,
+	.host_int_mask = 0x02,
+	.host_intstatus = 0x03,
+	.card_status = 0x30,
+	.sq_read_base_addr_a0 = 0x40,
+	.sq_read_base_addr_a1 = 0x41,
+	.card_revision = 0x5c,
+	.card_fw_status0 = 0x60,
+	.card_fw_status1 = 0x61,
+	.card_rx_len = 0x62,
+	.card_rx_unit = 0x63,
+	.io_port_0 = 0x78,
+	.io_port_1 = 0x79,
+	.io_port_2 = 0x7a,
+};
+
 static const struct btmrvl_sdio_device btmrvl_sdio_sd6888 = {
 	.helper		= "sd8688_helper.bin",
 	.firmware	= "sd8688.bin",
+	.reg		= &btmrvl_reg_8688,
+	.sd_blksz_fw_dl	= 64,
+};
+
+static const struct btmrvl_sdio_device btmrvl_sdio_sd8787 = {
+	.helper		= NULL,
+	.firmware	= "mrvl/sd8787_uapsta.bin",
+	.reg		= &btmrvl_reg_8787,
+	.sd_blksz_fw_dl	= 256,
 };
 
 static const struct sdio_device_id btmrvl_sdio_ids[] = {
 	/* Marvell SD8688 Bluetooth device */
 	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, 0x9105),
 			.driver_data = (unsigned long) &btmrvl_sdio_sd6888 },
+	/* Marvell SD8787 Bluetooth device */
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, 0x911A),
+			.driver_data = (unsigned long) &btmrvl_sdio_sd8787 },
 
 	{ }	/* Terminating entry */
 };
@@ -69,7 +113,7 @@ static int btmrvl_sdio_get_rx_unit(struct btmrvl_sdio_card *card)
 	u8 reg;
 	int ret;
 
-	reg = sdio_readb(card->func, CARD_RX_UNIT_REG, &ret);
+	reg = sdio_readb(card->func, card->reg->card_rx_unit, &ret);
 	if (!ret)
 		card->rx_unit = reg;
 
@@ -83,11 +127,11 @@ static int btmrvl_sdio_read_fw_status(struct btmrvl_sdio_card *card, u16 *dat)
 
 	*dat = 0;
 
-	fws0 = sdio_readb(card->func, CARD_FW_STATUS0_REG, &ret);
+	fws0 = sdio_readb(card->func, card->reg->card_fw_status0, &ret);
 	if (ret)
 		return -EIO;
 
-	fws1 = sdio_readb(card->func, CARD_FW_STATUS1_REG, &ret);
+	fws1 = sdio_readb(card->func, card->reg->card_fw_status1, &ret);
 	if (ret)
 		return -EIO;
 
@@ -101,7 +145,7 @@ static int btmrvl_sdio_read_rx_len(struct btmrvl_sdio_card *card, u16 *dat)
 	u8 reg;
 	int ret;
 
-	reg = sdio_readb(card->func, CARD_RX_LEN_REG, &ret);
+	reg = sdio_readb(card->func, card->reg->card_rx_len, &ret);
 	if (!ret)
 		*dat = (u16) reg << card->rx_unit;
 
@@ -113,7 +157,7 @@ static int btmrvl_sdio_enable_host_int_mask(struct btmrvl_sdio_card *card,
 {
 	int ret;
 
-	sdio_writeb(card->func, mask, HOST_INT_MASK_REG, &ret);
+	sdio_writeb(card->func, mask, card->reg->host_int_mask, &ret);
 	if (ret) {
 		BT_ERR("Unable to enable the host interrupt!");
 		ret = -EIO;
@@ -128,13 +172,13 @@ static int btmrvl_sdio_disable_host_int_mask(struct btmrvl_sdio_card *card,
 	u8 host_int_mask;
 	int ret;
 
-	host_int_mask = sdio_readb(card->func, HOST_INT_MASK_REG, &ret);
+	host_int_mask = sdio_readb(card->func, card->reg->host_int_mask, &ret);
 	if (ret)
 		return -EIO;
 
 	host_int_mask &= ~mask;
 
-	sdio_writeb(card->func, host_int_mask, HOST_INT_MASK_REG, &ret);
+	sdio_writeb(card->func, host_int_mask, card->reg->host_int_mask, &ret);
 	if (ret < 0) {
 		BT_ERR("Unable to disable the host interrupt!");
 		return -EIO;
@@ -150,7 +194,7 @@ static int btmrvl_sdio_poll_card_status(struct btmrvl_sdio_card *card, u8 bits)
 	int ret;
 
 	for (tries = 0; tries < MAX_POLL_TRIES * 1000; tries++) {
-		status = sdio_readb(card->func, CARD_STATUS_REG, &ret);
+		status = sdio_readb(card->func, card->reg->card_status,	&ret);
 		if (ret)
 			goto failed;
 		if ((status & bits) == bits)
@@ -299,7 +343,7 @@ static int btmrvl_sdio_download_fw_w_helper(struct btmrvl_sdio_card *card)
 	u8 base0, base1;
 	void *tmpfwbuf = NULL;
 	u8 *fwbuf;
-	u16 len;
+	u16 len, blksz_dl = card->sd_blksz_fw_dl;
 	int txlen = 0, tx_blocks = 0, count = 0;
 
 	ret = request_firmware(&fw_firmware, card->firmware,
@@ -345,7 +389,7 @@ static int btmrvl_sdio_download_fw_w_helper(struct btmrvl_sdio_card *card)
 
 		for (tries = 0; tries < MAX_POLL_TRIES; tries++) {
 			base0 = sdio_readb(card->func,
-					SQ_READ_BASE_ADDRESS_A0_REG, &ret);
+					card->reg->sq_read_base_addr_a0, &ret);
 			if (ret) {
 				BT_ERR("BASE0 register read failed:"
 					" base0 = 0x%04X(%d)."
@@ -355,7 +399,7 @@ static int btmrvl_sdio_download_fw_w_helper(struct btmrvl_sdio_card *card)
 				goto done;
 			}
 			base1 = sdio_readb(card->func,
-					SQ_READ_BASE_ADDRESS_A1_REG, &ret);
+					card->reg->sq_read_base_addr_a1, &ret);
 			if (ret) {
 				BT_ERR("BASE1 register read failed:"
 					" base1 = 0x%04X(%d)."
@@ -403,20 +447,19 @@ static int btmrvl_sdio_download_fw_w_helper(struct btmrvl_sdio_card *card)
 			if (firmwarelen - offset < txlen)
 				txlen = firmwarelen - offset;
 
-			tx_blocks =
-			    (txlen + SDIO_BLOCK_SIZE - 1) / SDIO_BLOCK_SIZE;
+			tx_blocks = (txlen + blksz_dl - 1) / blksz_dl;
 
 			memcpy(fwbuf, &firmware[offset], txlen);
 		}
 
 		ret = sdio_writesb(card->func, card->ioport, fwbuf,
-					tx_blocks * SDIO_BLOCK_SIZE);
+						tx_blocks * blksz_dl);
 
 		if (ret < 0) {
 			BT_ERR("FW download, writesb(%d) failed @%d",
 							count, offset);
-			sdio_writeb(card->func, HOST_CMD53_FIN, CONFIG_REG,
-									&ret);
+			sdio_writeb(card->func, HOST_CMD53_FIN,
+						card->reg->cfg, &ret);
 			if (ret)
 				BT_ERR("writeb failed (CFG)");
 		}
@@ -597,7 +640,7 @@ static void btmrvl_sdio_interrupt(struct sdio_func *func)
 
 	priv = card->priv;
 
-	ireg = sdio_readb(card->func, HOST_INTSTATUS_REG, &ret);
+	ireg = sdio_readb(card->func, card->reg->host_intstatus, &ret);
 	if (ret) {
 		BT_ERR("sdio_readb: read int status register failed");
 		return;
@@ -613,7 +656,7 @@ static void btmrvl_sdio_interrupt(struct sdio_func *func)
 
 		sdio_writeb(card->func, ~(ireg) & (DN_LD_HOST_INT_STATUS |
 					UP_LD_HOST_INT_STATUS),
-				HOST_INTSTATUS_REG, &ret);
+				card->reg->host_intstatus, &ret);
 		if (ret) {
 			BT_ERR("sdio_writeb: clear int status register failed");
 			return;
@@ -664,7 +707,7 @@ static int btmrvl_sdio_register_dev(struct btmrvl_sdio_card *card)
 		goto release_irq;
 	}
 
-	reg = sdio_readb(func, IO_PORT_0_REG, &ret);
+	reg = sdio_readb(func, card->reg->io_port_0, &ret);
 	if (ret < 0) {
 		ret = -EIO;
 		goto release_irq;
@@ -672,7 +715,7 @@ static int btmrvl_sdio_register_dev(struct btmrvl_sdio_card *card)
 
 	card->ioport = reg;
 
-	reg = sdio_readb(func, IO_PORT_1_REG, &ret);
+	reg = sdio_readb(func, card->reg->io_port_1, &ret);
 	if (ret < 0) {
 		ret = -EIO;
 		goto release_irq;
@@ -680,7 +723,7 @@ static int btmrvl_sdio_register_dev(struct btmrvl_sdio_card *card)
 
 	card->ioport |= (reg << 8);
 
-	reg = sdio_readb(func, IO_PORT_2_REG, &ret);
+	reg = sdio_readb(func, card->reg->io_port_2, &ret);
 	if (ret < 0) {
 		ret = -EIO;
 		goto release_irq;
@@ -815,6 +858,8 @@ exit:
 static int btmrvl_sdio_download_fw(struct btmrvl_sdio_card *card)
 {
 	int ret = 0;
+	u8 fws0;
+	int pollnum = MAX_POLL_TRIES;
 
 	if (!card || !card->func) {
 		BT_ERR("card or function is NULL!");
@@ -827,20 +872,36 @@ static int btmrvl_sdio_download_fw(struct btmrvl_sdio_card *card)
 		goto done;
 	}
 
-	ret = btmrvl_sdio_download_helper(card);
+	/* Check if other function driver is downloading the firmware */
+	fws0 = sdio_readb(card->func, card->reg->card_fw_status0, &ret);
 	if (ret) {
-		BT_ERR("Failed to download helper!");
+		BT_ERR("Failed to read FW downloading status!");
 		ret = -EIO;
 		goto done;
 	}
+	if (fws0) {
+		BT_DBG("BT not the winner (%#x). Skip FW downloading", fws0);
+
+		/* Give other function more time to download the firmware */
+		pollnum *= 10;
+	} else {
+		if (card->helper) {
+			ret = btmrvl_sdio_download_helper(card);
+			if (ret) {
+				BT_ERR("Failed to download helper!");
+				ret = -EIO;
+				goto done;
+			}
+		}
 
-	if (btmrvl_sdio_download_fw_w_helper(card)) {
-		BT_ERR("Failed to download firmware!");
-		ret = -EIO;
-		goto done;
+		if (btmrvl_sdio_download_fw_w_helper(card)) {
+			BT_ERR("Failed to download firmware!");
+			ret = -EIO;
+			goto done;
+		}
 	}
 
-	if (btmrvl_sdio_verify_fw_download(card, MAX_POLL_TRIES)) {
+	if (btmrvl_sdio_verify_fw_download(card, pollnum)) {
 		BT_ERR("FW failed to be active in time!");
 		ret = -ETIMEDOUT;
 		goto done;
@@ -864,7 +925,7 @@ static int btmrvl_sdio_wakeup_fw(struct btmrvl_private *priv)
 
 	sdio_claim_host(card->func);
 
-	sdio_writeb(card->func, HOST_POWER_UP, CONFIG_REG, &ret);
+	sdio_writeb(card->func, HOST_POWER_UP, card->reg->cfg, &ret);
 
 	sdio_release_host(card->func);
 
@@ -893,8 +954,10 @@ static int btmrvl_sdio_probe(struct sdio_func *func,
 
 	if (id->driver_data) {
 		struct btmrvl_sdio_device *data = (void *) id->driver_data;
-		card->helper   = data->helper;
+		card->helper = data->helper;
 		card->firmware = data->firmware;
+		card->reg = data->reg;
+		card->sd_blksz_fw_dl = data->sd_blksz_fw_dl;
 	}
 
 	if (btmrvl_sdio_register_dev(card) < 0) {
@@ -1011,3 +1074,4 @@ MODULE_VERSION(VERSION);
 MODULE_LICENSE("GPL v2");
 MODULE_FIRMWARE("sd8688_helper.bin");
 MODULE_FIRMWARE("sd8688.bin");
+MODULE_FIRMWARE("mrvl/sd8787_uapsta.bin");
diff --git a/drivers/bluetooth/btmrvl_sdio.h b/drivers/bluetooth/btmrvl_sdio.h
index 27329f1..43d35a6 100644
--- a/drivers/bluetooth/btmrvl_sdio.h
+++ b/drivers/bluetooth/btmrvl_sdio.h
@@ -47,44 +47,46 @@
 /* Max retry number of CMD53 write */
 #define MAX_WRITE_IOMEM_RETRY		2
 
-/* Host Control Registers */
-#define IO_PORT_0_REG			0x00
-#define IO_PORT_1_REG			0x01
-#define IO_PORT_2_REG			0x02
-
-#define CONFIG_REG			0x03
-#define HOST_POWER_UP			BIT(1)
-#define HOST_CMD53_FIN			BIT(2)
-
-#define HOST_INT_MASK_REG		0x04
-#define HIM_DISABLE			0xff
-#define HIM_ENABLE			(BIT(0) | BIT(1))
-
-#define HOST_INTSTATUS_REG		0x05
-#define UP_LD_HOST_INT_STATUS		BIT(0)
-#define DN_LD_HOST_INT_STATUS		BIT(1)
-
-/* Card Control Registers */
-#define SQ_READ_BASE_ADDRESS_A0_REG  	0x10
-#define SQ_READ_BASE_ADDRESS_A1_REG  	0x11
-
-#define CARD_STATUS_REG              	0x20
-#define DN_LD_CARD_RDY               	BIT(0)
-#define CARD_IO_READY              	BIT(3)
-
-#define CARD_FW_STATUS0_REG		0x40
-#define CARD_FW_STATUS1_REG		0x41
-#define FIRMWARE_READY			0xfedc
-
-#define CARD_RX_LEN_REG			0x42
-#define CARD_RX_UNIT_REG		0x43
-
+/* register bitmasks */
+#define HOST_POWER_UP				BIT(1)
+#define HOST_CMD53_FIN				BIT(2)
+
+#define HIM_DISABLE				0xff
+#define HIM_ENABLE				(BIT(0) | BIT(1))
+
+#define UP_LD_HOST_INT_STATUS			BIT(0)
+#define DN_LD_HOST_INT_STATUS			BIT(1)
+
+#define DN_LD_CARD_RDY				BIT(0)
+#define CARD_IO_READY				BIT(3)
+
+#define FIRMWARE_READY				0xfedc
+
+
+struct btmrvl_sdio_card_reg {
+	u8 cfg;
+	u8 host_int_mask;
+	u8 host_intstatus;
+	u8 card_status;
+	u8 sq_read_base_addr_a0;
+	u8 sq_read_base_addr_a1;
+	u8 card_revision;
+	u8 card_fw_status0;
+	u8 card_fw_status1;
+	u8 card_rx_len;
+	u8 card_rx_unit;
+	u8 io_port_0;
+	u8 io_port_1;
+	u8 io_port_2;
+};
 
 struct btmrvl_sdio_card {
 	struct sdio_func *func;
 	u32 ioport;
 	const char *helper;
 	const char *firmware;
+	const struct btmrvl_sdio_card_reg *reg;
+	u16 sd_blksz_fw_dl;
 	u8 rx_unit;
 	struct btmrvl_private *priv;
 };
@@ -92,6 +94,8 @@ struct btmrvl_sdio_card {
 struct btmrvl_sdio_device {
 	const char *helper;
 	const char *firmware;
+	const struct btmrvl_sdio_card_reg *reg;
+	u16 sd_blksz_fw_dl;
 };
 
 
-- 
1.6.2.5
