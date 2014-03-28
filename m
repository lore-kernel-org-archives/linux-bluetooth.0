Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcel Holtmann <marcel@holtmann.org>,
        Gustavo Padovan
	<gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Amitkumar
 Karwar <akarwar@marvell.com>, Bing Zhao <bzhao@marvell.com>
Subject: [PATCH 2/2] Bluetooth: btmrvl: implement read-to-clear for SD8897 interrupts
Date: Thu, 27 Mar 2014 21:30:43 -0700
Message-ID: <1395981043-2541-2-git-send-email-bzhao@marvell.com>
In-Reply-To: <1395981043-2541-1-git-send-email-bzhao@marvell.com>
References: <1395981043-2541-1-git-send-email-bzhao@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

For SD8897, CMD52 write_to_clear may have missing interrupts
under certain corner case condition. Use CMD53 read-to-clear
to fix the problem.

Signed-off-by: Bing Zhao <bzhao@marvell.com>
---
 drivers/bluetooth/btmrvl_drv.h  |  2 ++
 drivers/bluetooth/btmrvl_main.c | 17 ++++++++++++++
 drivers/bluetooth/btmrvl_sdio.c | 52 ++++++++++++++++++++++++++++++++++++++++-
 drivers/bluetooth/btmrvl_sdio.h |  3 +++
 4 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmrvl_drv.h b/drivers/bluetooth/btmrvl_drv.h
index 7399303..199ff49 100644
--- a/drivers/bluetooth/btmrvl_drv.h
+++ b/drivers/bluetooth/btmrvl_drv.h
@@ -59,6 +59,8 @@ struct btmrvl_device {
 };
 
 struct btmrvl_adapter {
+	void *hw_regs_buf;
+	u8 *hw_regs;
 	u32 int_count;
 	struct sk_buff_head tx_queue;
 	u8 psmode;
diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index 2c4997c..5c0b944 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -24,6 +24,7 @@
 #include <net/bluetooth/hci_core.h>
 
 #include "btmrvl_drv.h"
+#include "btmrvl_sdio.h"
 
 #define VERSION "1.0"
 
@@ -337,10 +338,25 @@ static int btmrvl_tx_pkt(struct btmrvl_private *priv, struct sk_buff *skb)
 
 static void btmrvl_init_adapter(struct btmrvl_private *priv)
 {
+	int buf_size;
+
 	skb_queue_head_init(&priv->adapter->tx_queue);
 
 	priv->adapter->ps_state = PS_AWAKE;
 
+	buf_size = ALIGN_SZ(SDIO_BLOCK_SIZE, BTSDIO_DMA_ALIGN);
+	priv->adapter->hw_regs_buf = kzalloc(buf_size, GFP_KERNEL);
+	if (!priv->adapter->hw_regs_buf) {
+		priv->adapter->hw_regs = NULL;
+		BT_ERR("Unable to allocate buffer for hw_regs.");
+	} else {
+		priv->adapter->hw_regs =
+			(u8 *)ALIGN_ADDR(priv->adapter->hw_regs_buf,
+					 BTSDIO_DMA_ALIGN);
+		BT_DBG("hw_regs_buf=%p hw_regs=%p",
+		       priv->adapter->hw_regs_buf, priv->adapter->hw_regs);
+	}
+
 	init_waitqueue_head(&priv->adapter->cmd_wait_q);
 }
 
@@ -348,6 +364,7 @@ static void btmrvl_free_adapter(struct btmrvl_private *priv)
 {
 	skb_queue_purge(&priv->adapter->tx_queue);
 
+	kfree(priv->adapter->hw_regs_buf);
 	kfree(priv->adapter);
 
 	priv->adapter = NULL;
diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 7883793..9dedca5 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -64,6 +64,7 @@ static const struct btmrvl_sdio_card_reg btmrvl_reg_8688 = {
 	.io_port_0 = 0x00,
 	.io_port_1 = 0x01,
 	.io_port_2 = 0x02,
+	.int_read_to_clear = false,
 };
 static const struct btmrvl_sdio_card_reg btmrvl_reg_87xx = {
 	.cfg = 0x00,
@@ -80,6 +81,7 @@ static const struct btmrvl_sdio_card_reg btmrvl_reg_87xx = {
 	.io_port_0 = 0x78,
 	.io_port_1 = 0x79,
 	.io_port_2 = 0x7a,
+	.int_read_to_clear = false,
 };
 
 static const struct btmrvl_sdio_card_reg btmrvl_reg_88xx = {
@@ -97,6 +99,9 @@ static const struct btmrvl_sdio_card_reg btmrvl_reg_88xx = {
 	.io_port_0 = 0xd8,
 	.io_port_1 = 0xd9,
 	.io_port_2 = 0xda,
+	.int_read_to_clear = true,
+	.host_int_rsr = 0x01,
+	.card_misc_cfg = 0xcc,
 };
 
 static const struct btmrvl_sdio_device btmrvl_sdio_sd8688 = {
@@ -667,6 +672,23 @@ static int btmrvl_sdio_process_int_status(struct btmrvl_private *priv)
 	return 0;
 }
 
+static int btmrvl_sdio_read_to_clear(struct btmrvl_sdio_card *card, u8 *ireg)
+{
+	struct btmrvl_adapter *adapter = card->priv->adapter;
+	int ret;
+
+	ret = sdio_readsb(card->func, adapter->hw_regs, 0, SDIO_BLOCK_SIZE);
+	if (ret) {
+		BT_ERR("sdio_readsb: read int hw_regs failed: %d", ret);
+		return ret;
+	}
+
+	*ireg = adapter->hw_regs[card->reg->host_intstatus];
+	BT_DBG("hw_regs[%#x]=%#x", card->reg->host_intstatus, *ireg);
+
+	return 0;
+}
+
 static int btmrvl_sdio_write_to_clear(struct btmrvl_sdio_card *card, u8 *ireg)
 {
 	int ret;
@@ -714,7 +736,11 @@ static void btmrvl_sdio_interrupt(struct sdio_func *func)
 
 	priv = card->priv;
 
-	ret = btmrvl_sdio_write_to_clear(card, &ireg);
+	if (card->reg->int_read_to_clear)
+		ret = btmrvl_sdio_read_to_clear(card, &ireg);
+	else
+		ret = btmrvl_sdio_write_to_clear(card, &ireg);
+
 	if (ret)
 		return;
 
@@ -788,6 +814,30 @@ static int btmrvl_sdio_register_dev(struct btmrvl_sdio_card *card)
 
 	BT_DBG("SDIO FUNC%d IO port: 0x%x", func->num, card->ioport);
 
+	if (card->reg->int_read_to_clear) {
+		reg = sdio_readb(func, card->reg->host_int_rsr, &ret);
+		if (ret < 0) {
+			ret = -EIO;
+			goto release_irq;
+		}
+		sdio_writeb(func, reg | 0x3f, card->reg->host_int_rsr, &ret);
+		if (ret < 0) {
+			ret = -EIO;
+			goto release_irq;
+		}
+
+		reg = sdio_readb(func, card->reg->card_misc_cfg, &ret);
+		if (ret < 0) {
+			ret = -EIO;
+			goto release_irq;
+		}
+		sdio_writeb(func, reg | 0x10, card->reg->card_misc_cfg, &ret);
+		if (ret < 0) {
+			ret = -EIO;
+			goto release_irq;
+		}
+	}
+
 	sdio_set_drvdata(func, card);
 
 	sdio_release_host(func);
diff --git a/drivers/bluetooth/btmrvl_sdio.h b/drivers/bluetooth/btmrvl_sdio.h
index 43d35a6..d4dd3b0 100644
--- a/drivers/bluetooth/btmrvl_sdio.h
+++ b/drivers/bluetooth/btmrvl_sdio.h
@@ -78,6 +78,9 @@ struct btmrvl_sdio_card_reg {
 	u8 io_port_0;
 	u8 io_port_1;
 	u8 io_port_2;
+	bool int_read_to_clear;
+	u8 host_int_rsr;
+	u8 card_misc_cfg;
 };
 
 struct btmrvl_sdio_card {
-- 
1.8.0
