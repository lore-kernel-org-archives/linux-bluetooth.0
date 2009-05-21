Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bing Zhao <bzhao@marvell.com>
Subject: [PATCH 2/4] bluetooth: bt_mrvl_sdio: Marvell BT-over-SDIO driver
Date: Wed, 20 May 2009 17:35:39 -0700
Message-Id: <1242866141-22325-2-git-send-email-bzhao@marvell.com>
In-Reply-To: <1242866141-22325-1-git-send-email-bzhao@marvell.com>
References: <1242866141-22325-1-git-send-email-bzhao@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This driver, bt_mrvl_sdio, supports Marvell Bluetooth enabled devices
with SDIO interface, Currently only SD8688 is supported. New chipsets
can be added in future.

The helper/firmware images of SD8688 can be downloaded from this tree:
git://git.infradead.org/users/dwmw2/linux-firmware.git

This patch incorporates a lot of comments given by
Nicolas Pitre <nico@marvell.com>. Many thanks to Nicolas Pitre.

Signed-off-by: Rahul Tank <rahult@marvell.com>
Signed-off-by: Bing Zhao <bzhao@marvell.com>
---
 drivers/bluetooth/bt_mrvl/Kconfig    |   13 +
 drivers/bluetooth/bt_mrvl/Makefile   |    2 +
 drivers/bluetooth/bt_mrvl/btm_sdio.c | 1124 ++++++++++++++++++++++++++++++++++
 drivers/bluetooth/bt_mrvl/btm_sdio.h |  113 ++++
 4 files changed, 1252 insertions(+), 0 deletions(-)
 create mode 100644 drivers/bluetooth/bt_mrvl/btm_sdio.c
 create mode 100644 drivers/bluetooth/bt_mrvl/btm_sdio.h

diff --git a/drivers/bluetooth/bt_mrvl/Kconfig b/drivers/bluetooth/bt_mrvl/Kconfig
index 9b6202b..9f7a24a 100644
--- a/drivers/bluetooth/bt_mrvl/Kconfig
+++ b/drivers/bluetooth/bt_mrvl/Kconfig
@@ -10,3 +10,16 @@ config BT_MRVL
 
 	  Say Y here to compile Marvell Bluetooth driver
 	  into the kernel or say M to compile it as module.
+
+config BT_MRVL_SDIO
+	tristate "Marvell BT-over-SDIO driver"
+	depends on BT_MRVL && MMC
+	help
+	  The driver for Marvell Bluetooth chipsets with SDIO interface.
+
+	  This driver is required if you want to use Marvell Bluetooth
+	  devices with SDIO interface. Currently only SD8688 chipset is
+	  supported.
+
+	  Say Y here to compile support for Marvell BT-over-SDIO driver
+	  into the kernel or say M to compile it as module.
diff --git a/drivers/bluetooth/bt_mrvl/Makefile b/drivers/bluetooth/bt_mrvl/Makefile
index 88b457b..8c8cb94 100644
--- a/drivers/bluetooth/bt_mrvl/Makefile
+++ b/drivers/bluetooth/bt_mrvl/Makefile
@@ -3,5 +3,7 @@
 #
 
 bt_mrvl-objs := btm_main.o
+bt_mrvl_sdio-objs := btm_sdio.o
 
 obj-$(CONFIG_BT_MRVL) += bt_mrvl.o
+obj-$(CONFIG_BT_MRVL_SDIO) += bt_mrvl_sdio.o
diff --git a/drivers/bluetooth/bt_mrvl/btm_sdio.c b/drivers/bluetooth/bt_mrvl/btm_sdio.c
new file mode 100644
index 0000000..e4def9f
--- /dev/null
+++ b/drivers/bluetooth/bt_mrvl/btm_sdio.c
@@ -0,0 +1,1124 @@
+/**
+ * Marvell BT-over-SDIO driver: SDIO interface related functions.
+ *
+ * Copyright (C) 2009, Marvell International Ltd.
+ *
+ * This software file (the "File") is distributed by Marvell International
+ * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * (the "License").  You may use, redistribute and/or modify this File in
+ * accordance with the terms and conditions of the License, a copy of which
+ * is available by writing to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA or on the
+ * worldwide web at http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.
+ *
+ *
+ * THE FILE IS DISTRIBUTED AS-IS, WITHOUT WARRANTY OF ANY KIND, AND THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE
+ * ARE EXPRESSLY DISCLAIMED.  The License provides additional details about
+ * this warranty disclaimer.
+ **/
+
+#include <linux/firmware.h>
+
+#include <linux/mmc/sdio_ids.h>
+#include <linux/mmc/sdio_func.h>
+
+#include <net/bluetooth/bluetooth.h>
+#include <net/bluetooth/hci_core.h>
+
+#include "btm_drv.h"
+#include "btm_sdio.h"
+
+#define VERSION "1.0"
+
+#ifndef SDIO_DEVICE_ID_MARVELL_8688BT
+#define SDIO_DEVICE_ID_MARVELL_8688BT		0x9105
+#endif
+
+static const struct sdio_device_id btsdio_ids[] = {
+	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8688BT)},
+	{0, 0, 0, 0}
+};
+
+MODULE_DEVICE_TABLE(sdio, btsdio_ids);
+
+static struct btsdio_device btsdio_devices[] = {
+	{
+		.dev_id = SDIO_DEVICE_ID_MARVELL_8688BT,
+		.helper = "sd8688_helper.bin",
+		.firmware = "sd8688.bin",
+		.card = NULL,
+	},
+};
+
+static int btsdio_get_rx_unit(struct btsdio_card *card)
+{
+	u8 reg;
+	int ret;
+
+	ENTER();
+
+	reg = sdio_readb(card->func, CARD_RX_UNIT_REG, &ret);
+	if (!ret)
+		card->rx_unit = reg;
+
+	LEAVE();
+
+	return ret;
+}
+
+static int btsdio_read_firmware_status(struct btsdio_card *card, u16 *dat)
+{
+	int ret;
+	u8 fws0, fws1;
+
+	ENTER();
+
+	*dat = 0;
+
+	fws0 = sdio_readb(card->func, CARD_FW_STATUS0_REG, &ret);
+
+	if (!ret)
+		fws1 = sdio_readb(card->func, CARD_FW_STATUS1_REG, &ret);
+
+	if (ret) {
+		LEAVE();
+		return -EIO;
+	}
+
+	*dat = (((u16) fws1) << 8) | fws0;
+
+	LEAVE();
+
+	return 0;
+}
+
+static int btsdio_read_rx_len(struct btsdio_card *card, u16 *dat)
+{
+	int ret;
+	u8 reg;
+
+	ENTER();
+
+	reg = sdio_readb(card->func, CARD_RX_LEN_REG, &ret);
+	if (!ret)
+		*dat = (u16) reg << card->rx_unit;
+
+	LEAVE();
+
+	return ret;
+}
+
+static int btsdio_enable_host_int_mask(struct btsdio_card *card, u8 mask)
+{
+	int ret;
+
+	ENTER();
+
+	sdio_writeb(card->func, mask, HOST_INT_MASK_REG, &ret);
+	if (ret) {
+		PRINTM(WARN, "Unable to enable the host interrupt!\n");
+		ret = -EIO;
+	}
+
+	LEAVE();
+
+	return ret;
+}
+
+static int btsdio_disable_host_int_mask(struct btsdio_card *card, u8 mask)
+{
+	int ret;
+	u8 host_int_mask;
+
+	ENTER();
+
+	host_int_mask = sdio_readb(card->func, HOST_INT_MASK_REG, &ret);
+	if (ret) {
+		ret = -EIO;
+		goto done;
+	}
+
+	host_int_mask &= ~mask;
+
+	sdio_writeb(card->func, host_int_mask, HOST_INT_MASK_REG, &ret);
+	if (ret < 0) {
+		PRINTM(WARN, "Unable to disable the host interrupt!\n");
+		ret = -EIO;
+		goto done;
+	}
+
+	ret = 0;
+
+done:
+	LEAVE();
+
+	return ret;
+}
+
+static int btsdio_poll_card_status(struct btsdio_card *card, u8 bits)
+{
+	unsigned int tries;
+	int ret;
+	u8 status;
+
+	ENTER();
+
+	for (tries = 0; tries < MAX_POLL_TRIES * 1000; tries++) {
+		status = sdio_readb(card->func, CARD_STATUS_REG, &ret);
+		if (ret)
+			goto failed;
+		if ((status & bits) == bits)
+			goto done;
+
+		udelay(1);
+	}
+
+	ret = -ETIMEDOUT;
+
+failed:
+	PRINTM(WARN, "%s: FAILED! ret=%d\n", __func__, ret);
+
+done:
+	LEAVE();
+
+	return ret;
+}
+
+static int btsdio_verify_fw_download(struct btsdio_card *card, int pollnum)
+{
+	int ret = -ETIMEDOUT;
+	u16 firmwarestat;
+	unsigned int tries;
+
+	ENTER();
+
+	 /* Wait for firmware to become ready */
+	for (tries = 0; tries < pollnum; tries++) {
+		if (btsdio_read_firmware_status(card, &firmwarestat) < 0)
+			continue;
+
+		if (firmwarestat == FIRMWARE_READY) {
+			ret = 0;
+			break;
+		} else {
+			msleep(10);
+		}
+	}
+
+	LEAVE();
+
+	return ret;
+}
+
+static int btsdio_download_helper(struct btsdio_card *card)
+{
+	const struct firmware *fw_helper = NULL;
+	const u8 *helper = NULL;
+	int ret;
+	void *tmphlprbuf = NULL;
+	int tmphlprbufsz, hlprblknow, helperlen;
+	u8 *helperbuf;
+	u32 tx_len;
+
+	ENTER();
+
+	ret = request_firmware(&fw_helper, card->helper,
+				&card->func->dev);
+	if ((ret < 0) || !fw_helper) {
+		PRINTM(FATAL, "request_firmware(helper) failed, "
+			"error code = %d\n", ret);
+		ret = -ENOENT;
+		goto done;
+	}
+
+	helper = fw_helper->data;
+	helperlen = fw_helper->size;
+
+	PRINTM(INFO, "Downloading helper image (%d bytes), block size"
+			" %d bytes\n", helperlen, SDIO_BLOCK_SIZE);
+
+	tmphlprbufsz = ALIGN_SZ(BT_UPLD_SIZE, BTSDIO_DMA_ALIGN);
+
+	tmphlprbuf = kmalloc(tmphlprbufsz, GFP_KERNEL);
+	if (!tmphlprbuf) {
+		PRINTM(ERROR, "Unable to allocate buffer for helper."
+		       " Terminating download\n");
+		ret = -ENOMEM;
+		goto done;
+	}
+
+	memset(tmphlprbuf, 0, tmphlprbufsz);
+
+	helperbuf = (u8 *) ALIGN_ADDR(tmphlprbuf, BTSDIO_DMA_ALIGN);
+
+	/* Perform helper data transfer */
+	tx_len = (FIRMWARE_TRANSFER_NBLOCK * SDIO_BLOCK_SIZE)
+			- SDIO_HEADER_LEN;
+	hlprblknow = 0;
+
+	do {
+		ret = btsdio_poll_card_status(card,
+					    CARD_IO_READY | DN_LD_CARD_RDY);
+		if (ret < 0) {
+			PRINTM(FATAL, "Helper download poll status "
+			       "timeout @ %d\n", hlprblknow);
+			goto done;
+		}
+
+		/* Check if there is more data? */
+		if (hlprblknow >= helperlen)
+			break;
+
+		if (helperlen - hlprblknow < tx_len)
+			tx_len = helperlen - hlprblknow;
+
+		/* Little-endian */
+		helperbuf[0] = ((tx_len & 0x000000ff) >> 0);
+		helperbuf[1] = ((tx_len & 0x0000ff00) >> 8);
+		helperbuf[2] = ((tx_len & 0x00ff0000) >> 16);
+		helperbuf[3] = ((tx_len & 0xff000000) >> 24);
+
+		memcpy(&helperbuf[SDIO_HEADER_LEN], &helper[hlprblknow],
+				tx_len);
+
+		PRINTM(INFO, ".");
+
+		/* Now send the data */
+		ret = sdio_writesb(card->func, card->ioport,
+				   helperbuf,
+				   FIRMWARE_TRANSFER_NBLOCK *
+				   SDIO_BLOCK_SIZE);
+		if (ret < 0) {
+			PRINTM(FATAL, "IO error during helper download @ %d\n",
+			       hlprblknow);
+			goto done;
+		}
+
+		hlprblknow += tx_len;
+	} while (true);
+
+	PRINTM(INFO, "\nTransferring helper image EOF block\n");
+
+	memset(helperbuf, 0x0, SDIO_BLOCK_SIZE);
+
+	ret = sdio_writesb(card->func, card->ioport, helperbuf,
+			 SDIO_BLOCK_SIZE);
+	if (ret < 0) {
+		PRINTM(FATAL, "IO error in writing helper image EOF block\n");
+		goto done;
+	}
+
+	ret = 0;
+
+done:
+	kfree(tmphlprbuf);
+	if (fw_helper)
+		release_firmware(fw_helper);
+
+	LEAVE();
+
+	return ret;
+}
+
+static int btsdio_download_firmware_w_helper(struct btsdio_card *card)
+{
+	const struct firmware *fw_firmware = NULL;
+	const u8 *firmware = NULL;
+	int firmwarelen, tmpfwbufsz, ret;
+	unsigned int tries, offset;
+	u8 base0, base1;
+	void *tmpfwbuf = NULL;
+	u8 *fwbuf;
+	u16 len;
+	int txlen = 0, tx_blocks = 0, count = 0;
+
+	ENTER();
+
+	ret = request_firmware(&fw_firmware, card->firmware,
+				&card->func->dev);
+	if ((ret < 0) || !fw_firmware) {
+		PRINTM(FATAL, "request_firmware(firmware) failed, "
+			"error code = %d\n", ret);
+		ret = -ENOENT;
+		goto done;
+	}
+
+	firmware = fw_firmware->data;
+	firmwarelen = fw_firmware->size;
+
+	PRINTM(INFO, "Downloading FW image (%d bytes)\n", firmwarelen);
+
+	tmpfwbufsz = ALIGN_SZ(BT_UPLD_SIZE, BTSDIO_DMA_ALIGN);
+	tmpfwbuf = kmalloc(tmpfwbufsz, GFP_KERNEL);
+	if (!tmpfwbuf) {
+		PRINTM(ERROR, "Unable to allocate buffer for firmware."
+		       " Terminating download\n");
+		ret = -ENOMEM;
+		goto done;
+	}
+
+	memset(tmpfwbuf, 0, tmpfwbufsz);
+
+	/* Ensure aligned firmware buffer */
+	fwbuf = (u8 *) ALIGN_ADDR(tmpfwbuf, BTSDIO_DMA_ALIGN);
+
+	/* Perform firmware data transfer */
+	offset = 0;
+	do {
+		ret = btsdio_poll_card_status(card,
+					    CARD_IO_READY | DN_LD_CARD_RDY);
+		if (ret < 0) {
+			PRINTM(FATAL,
+			       "FW download with helper poll status"
+			       " timeout @ %d\n", offset);
+			goto done;
+		}
+
+		/* Check if there is more data ? */
+		if (offset >= firmwarelen)
+			break;
+
+		for (tries = 0; tries < MAX_POLL_TRIES; tries++) {
+			base0 = sdio_readb(card->func,
+					SQ_READ_BASE_ADDRESS_A0_REG, &ret);
+			if (ret) {
+				PRINTM(WARN, "BASE0 register read failed:"
+				       " base0 = 0x%04X(%d)."
+				       " Terminating download\n",
+				       base0, base0);
+				ret = -EIO;
+				goto done;
+			}
+			base1 = sdio_readb(card->func,
+					SQ_READ_BASE_ADDRESS_A1_REG, &ret);
+			if (ret) {
+				PRINTM(WARN, "BASE1 register read failed:"
+				       " base1 = 0x%04X(%d)."
+				       " Terminating download\n",
+				       base1, base1);
+				ret = -EIO;
+				goto done;
+			}
+
+			len = (((u16) base1) << 8) | base0;
+			if (len)
+				break;
+
+			udelay(10);
+		}
+
+		if (!len)
+			break;
+		else if (len > BT_UPLD_SIZE) {
+			PRINTM(FATAL, "FW download failure @ %d,"
+			       "invalid length %d\n", offset, len);
+			ret = -EINVAL;
+			goto done;
+		}
+
+		txlen = len;
+
+		if (len & BIT(0)) {
+			count++;
+			if (count > MAX_WRITE_IOMEM_RETRY) {
+				PRINTM(FATAL, "FW download failure @ %d,"
+				       "over max retry count\n", offset);
+				ret = -EIO;
+				goto done;
+			}
+			PRINTM(ERROR, "FW CRC error indicated by the helper:"
+			       " len = 0x%04X, txlen = %d\n", len, txlen);
+			len &= ~BIT(0);
+			/* Set txlen to 0 so as to resend from same offset */
+			txlen = 0;
+		} else {
+			count = 0;
+
+			/* Last block ? */
+			if (firmwarelen - offset < txlen)
+				txlen = firmwarelen - offset;
+
+			PRINTM(INFO, ".");
+
+			tx_blocks =
+			    (txlen + SDIO_BLOCK_SIZE - 1) / SDIO_BLOCK_SIZE;
+
+			memcpy(fwbuf, &firmware[offset], txlen);
+		}
+
+		ret = sdio_writesb(card->func, card->ioport, fwbuf,
+					tx_blocks * SDIO_BLOCK_SIZE);
+
+		if (ret < 0) {
+			PRINTM(ERROR, "FW download, writesb(%d) failed"
+					" @%d\n", count, offset);
+			sdio_writeb(card->func, 0x04, CONFIGURATION_REG, &ret);
+			if (ret)
+				PRINTM(ERROR, "writeb failed (CFG)\n");
+		}
+
+		offset += txlen;
+	} while (true);
+
+	PRINTM(INFO, "\nFW download over, size %d bytes\n", offset);
+
+	ret = 0;
+
+done:
+	kfree(tmpfwbuf);
+
+	if (fw_firmware)
+		release_firmware(fw_firmware);
+
+	LEAVE();
+
+	return ret;
+}
+
+static int btsdio_card_to_host(struct btm_private *priv)
+{
+	u16 buf_len = 0;
+	int ret, buf_block_len, blksz;
+	struct sk_buff *skb = NULL;
+	u32 type;
+	u8 *payload = NULL;
+	struct hci_dev *hdev = priv->btm_dev.hcidev;
+	struct btsdio_card *card = priv->btm_dev.card;
+
+	ENTER();
+
+	if (!card || !card->func) {
+		PRINTM(ERROR, "%s: card or function is NULL!\n", __func__);
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	/* Read the length of data to be transferred */
+	ret = btsdio_read_rx_len(card, &buf_len);
+	if (ret < 0) {
+		PRINTM(ERROR, "%s: read rx_len failed\n", __func__);
+		ret = -EIO;
+		goto exit;
+	}
+
+	blksz = SDIO_BLOCK_SIZE;
+	buf_block_len = (buf_len + blksz - 1) / blksz;
+
+	if (buf_len <= SDIO_HEADER_LEN
+	    || (buf_block_len * blksz) > ALLOC_BUF_SIZE) {
+		PRINTM(ERROR, "%s: invalid packet length: %d\n", __func__,
+		       buf_len);
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	/* Allocate buffer */
+	skb = bt_skb_alloc(buf_block_len * blksz + BTSDIO_DMA_ALIGN,
+				GFP_ATOMIC);
+	if (skb == NULL) {
+		PRINTM(WARN, "%s: No free skb\n", __func__);
+		goto exit;
+	}
+
+	if ((u32) skb->data & (BTSDIO_DMA_ALIGN - 1)) {
+		skb_put(skb, (u32) skb->data & (BTSDIO_DMA_ALIGN - 1));
+		skb_pull(skb, (u32) skb->data & (BTSDIO_DMA_ALIGN - 1));
+	}
+
+	payload = skb->tail;
+
+	ret = sdio_readsb(card->func, payload, card->ioport,
+			  buf_block_len * blksz);
+	if (ret < 0) {
+		PRINTM(ERROR, "%s: readsb failed: %d\n", __func__, ret);
+		ret = -EIO;
+		goto exit;
+	}
+
+	DBG_HEXDUMP(DBG_DATA, "SDIO Blk Rd", payload, blksz * buf_block_len);
+
+	/* This is SDIO specific header length: byte[2][1][0], type: byte[3]
+	 * (HCI_COMMAND = 1, ACL_DATA = 2, SCO_DATA = 3, 0xFE = Vendor)
+	 */
+
+	buf_len = payload[0];
+	buf_len |= (u16) payload[1] << 8;
+	type = payload[3];
+
+	switch (type) {
+	case HCI_ACLDATA_PKT:
+	case HCI_SCODATA_PKT:
+	case HCI_EVENT_PKT:
+		bt_cb(skb)->pkt_type = type;
+		skb->dev = (void *)hdev;
+		skb_put(skb, buf_len);
+		skb_pull(skb, SDIO_HEADER_LEN);
+
+		if (type == HCI_EVENT_PKT)
+			btm_check_evtpkt(priv, skb);
+
+		hci_recv_frame(skb);
+		hdev->stat.byte_rx += buf_len;
+		break;
+
+	case MRVL_VENDOR_PKT:
+		bt_cb(skb)->pkt_type = HCI_VENDOR_PKT;
+		skb->dev = (void *)hdev;
+		skb_put(skb, buf_len);
+		skb_pull(skb, SDIO_HEADER_LEN);
+
+		if (btm_process_event(priv, skb))
+			hci_recv_frame(skb);
+
+		hdev->stat.byte_rx += buf_len;
+		break;
+
+	default:
+		PRINTM(INFO, "%s: Unknow packet type:%d\n", __func__, type);
+		kfree_skb(skb);
+		skb = NULL;
+		break;
+	}
+
+exit:
+	if (ret) {
+		hdev->stat.err_rx++;
+		if (skb)
+			kfree_skb(skb);
+	}
+
+	LEAVE();
+
+	return ret;
+}
+
+static int btsdio_get_int_status(struct btm_private *priv, u8 * ireg)
+{
+	int ret;
+	u8 sdio_ireg = 0;
+	struct btsdio_card *card = priv->btm_dev.card;
+
+	ENTER();
+
+	*ireg = 0;
+
+	sdio_ireg = sdio_readb(card->func, HOST_INTSTATUS_REG, &ret);
+	if (ret) {
+		PRINTM(WARN, "sdio_readb: read int status "
+		       "register failed\n");
+		ret = -EIO;
+		goto done;
+	}
+
+	if (sdio_ireg != 0) {
+		/*
+		 * DN_LD_HOST_INT_STATUS and/or UP_LD_HOST_INT_STATUS
+		 * Clear the interrupt status register and re-enable the
+		 * interrupt.
+		 */
+		PRINTM(INFO, "sdio_ireg = 0x%x\n", sdio_ireg);
+
+		sdio_writeb(card->func, ~(sdio_ireg) & (DN_LD_HOST_INT_STATUS |
+							UP_LD_HOST_INT_STATUS),
+			    HOST_INTSTATUS_REG, &ret);
+		if (ret) {
+			PRINTM(WARN, "sdio_writeb: clear int status "
+			       "register failed\n");
+			ret = -EIO;
+			goto done;
+		}
+	}
+
+	if (sdio_ireg & DN_LD_HOST_INT_STATUS) {
+		if (priv->btm_dev.tx_dnld_rdy)
+			PRINTM(WARN, "tx_done already received: "
+			       " int_status=0x%x\n", sdio_ireg);
+		else
+			priv->btm_dev.tx_dnld_rdy = true;
+	}
+
+	if (sdio_ireg & UP_LD_HOST_INT_STATUS)
+		btsdio_card_to_host(priv);
+
+	*ireg = sdio_ireg;
+
+	ret = 0;
+
+done:
+	LEAVE();
+
+	return ret;
+}
+
+static void btsdio_interrupt(struct sdio_func *func)
+{
+	struct btm_private *priv;
+	struct hci_dev *hcidev;
+	struct btsdio_card *card;
+	u8 ireg = 0;
+
+	ENTER();
+
+	card = sdio_get_drvdata(func);
+	if (card && card->priv) {
+		priv = card->priv;
+		hcidev = priv->btm_dev.hcidev;
+
+		if (btsdio_get_int_status(priv, &ireg))
+			PRINTM(ERROR, "%s:reading HOST_INT_STATUS_REG failed\n",
+			       __func__);
+		else
+			PRINTM(INFO, "%s: HOST_INT_STATUS_REG %#x\n",
+			       __func__, ireg);
+
+		btm_interrupt(priv);
+	}
+
+	LEAVE();
+}
+
+static int btsdio_register_dev(struct btsdio_card *card)
+{
+	int ret = 0, i;
+	u8 reg;
+	struct sdio_func *func;
+
+	ENTER();
+
+	if (!card || !card->func) {
+		PRINTM(ERROR, "Error: card or function is NULL!\n");
+		ret = -EINVAL;
+		goto failed;
+	}
+
+	func = card->func;
+
+	for (i = 0; i < ARRAY_SIZE(btsdio_devices); i++) {
+		if (func->device == btsdio_devices[i].dev_id)
+			break;
+	}
+
+	if (i == ARRAY_SIZE(btsdio_devices)) {
+		PRINTM(ERROR, "Error: unknown device id 0x%x\n",
+			func->device);
+		ret = -EINVAL;
+		goto failed;
+	}
+
+	btsdio_devices[i].card = card;
+
+	card->helper = btsdio_devices[i].helper;
+	card->firmware = btsdio_devices[i].firmware;
+
+	sdio_claim_host(func);
+
+	ret = sdio_enable_func(func);
+	if (ret) {
+		PRINTM(FATAL, "sdio_enable_func() failed: ret=%d\n", ret);
+		ret = -EIO;
+		goto release_host;
+	}
+
+	ret = sdio_claim_irq(func, btsdio_interrupt);
+	if (ret) {
+		PRINTM(FATAL, "sdio_claim_irq failed: ret=%d\n", ret);
+		ret = -EIO;
+		goto disable_func;
+	}
+
+	ret = sdio_set_block_size(card->func, SDIO_BLOCK_SIZE);
+	if (ret) {
+		PRINTM(FATAL, "%s: cannot set SDIO block size\n", __func__);
+		ret = -EIO;
+		goto release_irq;
+	}
+
+	reg = sdio_readb(func, IO_PORT_0_REG, &ret);
+	if (ret < 0) {
+		ret = -EIO;
+		goto release_irq;
+	}
+
+	card->ioport = reg;
+
+	reg = sdio_readb(func, IO_PORT_1_REG, &ret);
+	if (ret < 0) {
+		ret = -EIO;
+		goto release_irq;
+	}
+
+	card->ioport |= (reg << 8);
+
+	reg = sdio_readb(func, IO_PORT_2_REG, &ret);
+	if (ret < 0) {
+		ret = -EIO;
+		goto release_irq;
+	}
+
+	card->ioport |= (reg << 16);
+
+	PRINTM(INFO, "SDIO FUNC%d IO port: 0x%x\n", func->num, card->ioport);
+
+	sdio_set_drvdata(func, card);
+
+	sdio_release_host(func);
+
+	LEAVE();
+	return 0;
+
+release_irq:
+	sdio_release_irq(func);
+
+disable_func:
+	sdio_disable_func(func);
+
+release_host:
+	sdio_release_host(func);
+
+failed:
+	LEAVE();
+	return ret;
+}
+
+static int btsdio_unregister_dev(struct btsdio_card *card)
+{
+	int i;
+
+	ENTER();
+
+	if (card && card->func) {
+		sdio_claim_host(card->func);
+		sdio_release_irq(card->func);
+		sdio_disable_func(card->func);
+		sdio_release_host(card->func);
+		sdio_set_drvdata(card->func, NULL);
+		for (i = 0; i < ARRAY_SIZE(btsdio_devices); i++) {
+			if (card->func->device == btsdio_devices[i].dev_id) {
+				btsdio_devices[i].card = NULL;
+				break;
+			}
+		}
+	}
+
+	LEAVE();
+	return 0;
+}
+
+static int btsdio_enable_host_int(struct btsdio_card *card)
+{
+	int ret;
+
+	ENTER();
+
+	if (!card || !card->func) {
+		LEAVE();
+		return -EINVAL;
+	}
+
+	sdio_claim_host(card->func);
+
+	ret = btsdio_enable_host_int_mask(card, HIM_ENABLE);
+
+	btsdio_get_rx_unit(card);
+
+	sdio_release_host(card->func);
+
+	LEAVE();
+
+	return ret;
+}
+
+static int btsdio_disable_host_int(struct btsdio_card *card)
+{
+	int ret;
+
+	ENTER();
+
+	if (!card || !card->func) {
+		LEAVE();
+		return -EINVAL;
+	}
+
+	sdio_claim_host(card->func);
+
+	ret = btsdio_disable_host_int_mask(card, HIM_DISABLE);
+
+	sdio_release_host(card->func);
+
+	LEAVE();
+
+	return ret;
+}
+
+static int btsdio_host_to_card(struct btm_private *priv, u8 *payload, u16 nb)
+{
+	struct btsdio_card *card = priv->btm_dev.card;
+	int ret = 0;
+	int buf_block_len;
+	int blksz;
+	int i = 0;
+	u8 *buf = NULL;
+	void *tmpbuf = NULL;
+	int tmpbufsz;
+
+	ENTER();
+
+	if (!card || !card->func) {
+		PRINTM(ERROR, "card or function is NULL!\n");
+		LEAVE();
+		return -EINVAL;
+	}
+
+	buf = payload;
+	if ((u32) payload & (BTSDIO_DMA_ALIGN - 1)) {
+		tmpbufsz = ALIGN_SZ(nb, BTSDIO_DMA_ALIGN);
+		tmpbuf = kmalloc(tmpbufsz, GFP_KERNEL);
+		memset(tmpbuf, 0, tmpbufsz);
+		buf = (u8 *) ALIGN_ADDR(tmpbuf, BTSDIO_DMA_ALIGN);
+		memcpy(buf, payload, nb);
+	}
+
+	blksz = SDIO_BLOCK_SIZE;
+	buf_block_len = (nb + blksz - 1) / blksz;
+
+	sdio_claim_host(card->func);
+
+	do {
+		/* Transfer data to card */
+		ret = sdio_writesb(card->func, card->ioport, buf,
+				   buf_block_len * blksz);
+		if (ret < 0) {
+			i++;
+			PRINTM(ERROR, "%s: i=%d writesb failed: %d\n",
+					__func__, i, ret);
+			ret = -EIO;
+			if (i > MAX_WRITE_IOMEM_RETRY)
+				goto exit;
+		} else {
+			DBG_HEXDUMP(DBG_DATA, "SDIO Blk Wr", payload, nb);
+		}
+	} while (ret);
+
+	priv->btm_dev.tx_dnld_rdy = false;
+
+exit:
+	sdio_release_host(card->func);
+
+	LEAVE();
+
+	return ret;
+}
+
+static int btsdio_download_fw(struct btsdio_card *card)
+{
+	int ret = 0;
+
+	ENTER();
+
+	if (!card || !card->func) {
+		PRINTM(ERROR, "card or function is NULL!\n");
+		LEAVE();
+		return -EINVAL;
+	}
+	sdio_claim_host(card->func);
+
+	if (!btsdio_verify_fw_download(card, 1)) {
+		PRINTM(INFO, "Firmware already downloaded!\n");
+		goto done;
+	}
+
+	ret = btsdio_download_helper(card);
+	if (ret) {
+		PRINTM(ERROR, "Failed to download helper!\n");
+		ret = -EIO;
+		goto done;
+	}
+
+	if (btsdio_download_firmware_w_helper(card)) {
+		PRINTM(ERROR, "Failed to download firmware!\n");
+		ret = -EIO;
+		goto done;
+	}
+
+	if (btsdio_verify_fw_download(card, MAX_POLL_TRIES)) {
+		PRINTM(ERROR, "FW failed to be active in time!\n");
+		ret = -ETIMEDOUT;
+		goto done;
+	}
+
+done:
+	sdio_release_host(card->func);
+
+	LEAVE();
+
+	return ret;
+}
+
+static int btsdio_wakeup_firmware(struct btm_private *priv)
+{
+	struct btsdio_card *card = priv->btm_dev.card;
+	int ret = 0;
+
+	ENTER();
+
+	if (!card || !card->func) {
+		PRINTM(ERROR, "card or function is NULL!\n");
+		LEAVE();
+		return -EINVAL;
+	}
+
+	sdio_claim_host(card->func);
+
+	sdio_writeb(card->func, HOST_POWER_UP, CONFIGURATION_REG, &ret);
+
+	sdio_release_host(card->func);
+
+	PRINTM(CMD, "wake up firmware\n");
+
+	LEAVE();
+
+	return ret;
+}
+
+static int btsdio_probe_card(struct sdio_func *func,
+			     const struct sdio_device_id *id)
+{
+	int ret = 0;
+	struct btm_private *priv = NULL;
+	struct btsdio_card *card = NULL;
+
+	ENTER();
+
+	PRINTM(INFO, "vendor=0x%x, device=0x%x, class=%d, fn=%d\n",
+			id->vendor, id->device, id->class, func->num);
+
+	card = kzalloc(sizeof(*card), GFP_KERNEL);
+	if (!card) {
+		ret = -ENOMEM;
+		goto done;
+	}
+
+	card->func = func;
+
+	if (btsdio_register_dev(card) < 0) {
+		PRINTM(FATAL, "Failed to register BT device!\n");
+		ret = -ENODEV;
+		goto free_card;
+	}
+
+	/* Disable the interrupts on the card */
+	btsdio_disable_host_int(card);
+
+	if (btsdio_download_fw(card)) {
+		PRINTM(FATAL, "Downloading firmware failed!\n");
+		ret = -ENODEV;
+		goto unreg_dev;
+	}
+
+	msleep(100);
+
+	btsdio_enable_host_int(card);
+
+	priv = btm_add_card(card);
+	if (!priv) {
+		PRINTM(FATAL, "Initializing card failed!\n");
+		ret = -ENODEV;
+		goto disable_host_int;
+	}
+
+	card->priv = priv;
+
+	/* Initialize the interface specific function pointers */
+	priv->hw_host_to_card = btsdio_host_to_card;
+	priv->hw_wakeup_firmware = btsdio_wakeup_firmware;
+
+	strncpy(priv->btm_dev.name, "bt_mrvl_sdio0",
+			sizeof(priv->btm_dev.name));
+
+	btm_send_module_cfg_cmd(priv, MODULE_BRINGUP_REQ);
+
+	LEAVE();
+
+	return 0;
+
+disable_host_int:
+	btsdio_disable_host_int(card);
+unreg_dev:
+	btsdio_unregister_dev(card);
+free_card:
+	kfree(card);
+done:
+	LEAVE();
+
+	return ret;
+}
+
+static void btsdio_remove_card(struct sdio_func *func)
+{
+	struct btsdio_card *card;
+
+	ENTER();
+
+	if (func) {
+		card = sdio_get_drvdata(func);
+		if (card) {
+			btsdio_disable_host_int(card);
+			PRINTM(INFO, "unregester dev\n");
+			btsdio_unregister_dev(card);
+			btm_remove_card(card->priv);
+			kfree(card);
+		}
+	}
+
+	LEAVE();
+}
+
+static struct sdio_driver bt_mrvl_sdio = {
+	.name		= "bt_mrvl_sdio",
+	.id_table	= btsdio_ids,
+	.probe		= btsdio_probe_card,
+	.remove		= btsdio_remove_card,
+};
+
+static int btsdio_init_module(void)
+{
+	ENTER();
+
+	if (sdio_register_driver(&bt_mrvl_sdio) != 0) {
+		PRINTM(FATAL, "SDIO Driver Registration Failed\n");
+		LEAVE();
+		return -ENODEV;
+	}
+
+	LEAVE();
+
+	return 0;
+}
+
+static void btsdio_exit_module(void)
+{
+	int i;
+	struct btsdio_card *card;
+
+	ENTER();
+
+	for (i = 0; i < ARRAY_SIZE(btsdio_devices); i++) {
+		card = btsdio_devices[i].card;
+		if (card && card->priv)
+			btm_send_module_cfg_cmd(card->priv,
+						MODULE_SHUTDOWN_REQ);
+	}
+
+	sdio_unregister_driver(&bt_mrvl_sdio);
+
+	LEAVE();
+}
+
+module_init(btsdio_init_module);
+module_exit(btsdio_exit_module);
+
+MODULE_AUTHOR("Marvell International Ltd.");
+MODULE_DESCRIPTION("Marvell BT-over-SDIO Driver v" VERSION);
+MODULE_VERSION(VERSION);
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/bluetooth/bt_mrvl/btm_sdio.h b/drivers/bluetooth/bt_mrvl/btm_sdio.h
new file mode 100644
index 0000000..c4e6863
--- /dev/null
+++ b/drivers/bluetooth/bt_mrvl/btm_sdio.h
@@ -0,0 +1,113 @@
+/**
+ * Marvell BT-over-SDIO driver: SDIO interface related definitions
+ *
+ * Copyright (C) 2009, Marvell International Ltd.
+ *
+ * This software file (the "File") is distributed by Marvell International
+ * Ltd. under the terms of the GNU General Public License Version 2, June 1991
+ * (the "License").  You may use, redistribute and/or modify this File in
+ * accordance with the terms and conditions of the License, a copy of which
+ * is available by writing to the Free Software Foundation, Inc.,
+ * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA or on the
+ * worldwide web at http://www.gnu.org/licenses/old-licenses/gpl-2.0.txt.
+ *
+ *
+ * THE FILE IS DISTRIBUTED AS-IS, WITHOUT WARRANTY OF ANY KIND, AND THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE
+ * ARE EXPRESSLY DISCLAIMED.  The License provides additional details about
+ * this warranty disclaimer.
+ *
+ **/
+
+#ifndef _BTM_SDIO_H_
+#define _BTM_SDIO_H_
+
+#define SDIO_HEADER_LEN			4
+
+/* SD block size can not bigger than 64 due to buf size limit in firmware */
+/* define SD block size for data Tx/Rx */
+#define SDIO_BLOCK_SIZE			64
+
+/* Number of blocks for firmware transfer */
+#define FIRMWARE_TRANSFER_NBLOCK	2
+
+/* This is for firmware specific length */
+#define FW_EXTRA_LEN			36
+
+#define MRVDRV_SIZE_OF_CMD_BUFFER       (2 * 1024)
+
+#define MRVDRV_BT_RX_PACKET_BUFFER_SIZE \
+	(HCI_MAX_FRAME_SIZE + FW_EXTRA_LEN)
+
+#define ALLOC_BUF_SIZE	(((max_t (int, MRVDRV_BT_RX_PACKET_BUFFER_SIZE, \
+			MRVDRV_SIZE_OF_CMD_BUFFER) + SDIO_HEADER_LEN \
+			+ SDIO_BLOCK_SIZE - 1) / SDIO_BLOCK_SIZE) \
+			* SDIO_BLOCK_SIZE)
+
+/* The number of times to try when polling for status */
+#define MAX_POLL_TRIES			100
+
+/* Max retry number of CMD53 write */
+#define MAX_WRITE_IOMEM_RETRY		2
+
+/* Host Control Registers */
+#define IO_PORT_0_REG			0x00
+#define IO_PORT_1_REG			0x01
+#define IO_PORT_2_REG			0x02
+
+#define CONFIGURATION_REG		0x03
+#define HOST_POWER_UP			BIT(1)
+
+#define HOST_INT_MASK_REG		0x04
+#define HIM_DISABLE			0xff
+#define HIM_ENABLE			(BIT(0) | BIT(1))
+
+#define HOST_INTSTATUS_REG		0x05
+#define UP_LD_HOST_INT_STATUS		BIT(0)
+#define DN_LD_HOST_INT_STATUS		BIT(1)
+
+/* Card Control Registers */
+#define SQ_READ_BASE_ADDRESS_A0_REG  	0x10
+#define SQ_READ_BASE_ADDRESS_A1_REG  	0x11
+
+#define CARD_STATUS_REG              	0x20
+#define DN_LD_CARD_RDY               	BIT(0)
+#define CARD_IO_READY              	BIT(3)
+
+#define CARD_FW_STATUS0_REG		0x40
+#define CARD_FW_STATUS1_REG		0x41
+#define FIRMWARE_READY			0xfedc
+
+#define CARD_RX_LEN_REG			0x42
+#define CARD_RX_UNIT_REG		0x43
+
+
+struct btsdio_card {
+	struct sdio_func *func;
+	u32 ioport;
+	const char *helper;
+	const char *firmware;
+	u8 rx_unit;
+	struct btm_private *priv;
+};
+
+struct btsdio_device {
+	unsigned short dev_id;
+	const char *helper;
+	const char *firmware;
+	struct btsdio_card *card;
+};
+
+
+/* Platform specific DMA alignment */
+#define BTSDIO_DMA_ALIGN		8
+
+/* Macros for Data Alignment : size */
+#define ALIGN_SZ(p, a)	\
+	(((p) + ((a) - 1)) & ~((a) - 1))
+
+/* Macros for Data Alignment : address */
+#define ALIGN_ADDR(p, a)	\
+	((((u32)(p)) + (((u32)(a)) - 1)) & ~(((u32)(a)) - 1))
+
+#endif /* _BTM_SDIO_H_ */
-- 
1.5.3.6

