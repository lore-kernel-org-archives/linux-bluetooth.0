Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bing Zhao <bzhao@marvell.com>,
	Amitkumar Karwar <akarwar@marvell.com>
Subject: [PATCH] Bluetooth: btmrvl: Fix issue when btmrvl driver and firmware are cross-sending
Date: Mon, 16 Nov 2009 20:20:00 -0800
Message-Id: <1258431600-3826-1-git-send-email-bzhao@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Amitkumar Karwar <akarwar@marvell.com>

When driver is sending a command or data and the firmware is also
sending a sleep event, sometimes it is observed that driver will
continue to send the command/data to firmware after processing sleep
event. Once sleep event is processed driver is not supposed to send
anything because firmware is in sleep state after that.
Previously RX processing was done in interrupt callback handler called
from MMC core. Now it is done in btmrvl driver main thread to solve the
issue.

Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
Signed-off-by: Bing Zhao <bzhao@marvell.com>
---
 drivers/bluetooth/btmrvl_drv.h  |    1 +
 drivers/bluetooth/btmrvl_main.c |    7 ++-
 drivers/bluetooth/btmrvl_sdio.c |   90 ++++++++++++++++++++------------------
 3 files changed, 53 insertions(+), 45 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_drv.h b/drivers/bluetooth/btmrvl_drv.h
index 411c7a7..2756de9 100644
--- a/drivers/bluetooth/btmrvl_drv.h
+++ b/drivers/bluetooth/btmrvl_drv.h
@@ -73,6 +73,7 @@ struct btmrvl_private {
 	int (*hw_host_to_card) (struct btmrvl_private *priv,
 				u8 *payload, u16 nb);
 	int (*hw_wakeup_firmware) (struct btmrvl_private *priv);
+	int (*hw_get_int_status) (struct btmrvl_private *priv, u8 *ireg);
 	spinlock_t driver_lock;		/* spinlock used by driver */
 #ifdef CONFIG_DEBUG_FS
 	void *debugfs_data;
diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index e605563..1fdc627 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -448,6 +448,7 @@ static int btmrvl_service_main_thread(void *data)
 	struct btmrvl_private *priv = thread->priv;
 	struct btmrvl_adapter *adapter = priv->adapter;
 	wait_queue_t wait;
+	u8 ireg = 0;
 	struct sk_buff *skb;
 	ulong flags;
 
@@ -482,14 +483,16 @@ static int btmrvl_service_main_thread(void *data)
 		spin_lock_irqsave(&priv->driver_lock, flags);
 		if (adapter->int_count) {
 			adapter->int_count = 0;
+			spin_unlock_irqrestore(&priv->driver_lock, flags);
+			priv->hw_get_int_status(priv, &ireg);
 		} else if (adapter->ps_state == PS_SLEEP &&
 					!skb_queue_empty(&adapter->tx_queue)) {
 			spin_unlock_irqrestore(&priv->driver_lock, flags);
 			adapter->wakeup_tries++;
 			priv->hw_wakeup_firmware(priv);
 			continue;
-		}
-		spin_unlock_irqrestore(&priv->driver_lock, flags);
+		} else
+			spin_unlock_irqrestore(&priv->driver_lock, flags);
 
 		if (adapter->ps_state == PS_SLEEP)
 			continue;
diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 5b33b85..d0393a8 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -46,6 +46,7 @@
  * module_exit function is called.
  */
 static u8 user_rmmod;
+static u8 sdio_ireg;
 
 static const struct btmrvl_sdio_device btmrvl_sdio_sd6888 = {
 	.helper		= "sd8688_helper.bin",
@@ -557,75 +558,77 @@ exit:
 static int btmrvl_sdio_get_int_status(struct btmrvl_private *priv, u8 * ireg)
 {
 	int ret;
-	u8 sdio_ireg = 0;
+	ulong flags;
 	struct btmrvl_sdio_card *card = priv->btmrvl_dev.card;
 
-	*ireg = 0;
-
-	sdio_ireg = sdio_readb(card->func, HOST_INTSTATUS_REG, &ret);
-	if (ret) {
-		BT_ERR("sdio_readb: read int status register failed");
-		ret = -EIO;
-		goto done;
-	}
-
-	if (sdio_ireg != 0) {
-		/*
-		 * DN_LD_HOST_INT_STATUS and/or UP_LD_HOST_INT_STATUS
-		 * Clear the interrupt status register and re-enable the
-		 * interrupt.
-		 */
-		BT_DBG("sdio_ireg = 0x%x", sdio_ireg);
-
-		sdio_writeb(card->func, ~(sdio_ireg) & (DN_LD_HOST_INT_STATUS |
-							UP_LD_HOST_INT_STATUS),
-			    HOST_INTSTATUS_REG, &ret);
-		if (ret) {
-			BT_ERR("sdio_writeb: clear int status register "
-				"failed");
-			ret = -EIO;
-			goto done;
-		}
-	}
+	spin_lock_irqsave(&priv->driver_lock, flags);
+	*ireg = sdio_ireg;
+	sdio_ireg = 0;
+	spin_unlock_irqrestore(&priv->driver_lock, flags);
 
-	if (sdio_ireg & DN_LD_HOST_INT_STATUS) {
+	sdio_claim_host(card->func);
+	if (*ireg & DN_LD_HOST_INT_STATUS) {
 		if (priv->btmrvl_dev.tx_dnld_rdy)
 			BT_DBG("tx_done already received: "
-				" int_status=0x%x", sdio_ireg);
+				" int_status=0x%x", *ireg);
 		else
 			priv->btmrvl_dev.tx_dnld_rdy = true;
 	}
 
-	if (sdio_ireg & UP_LD_HOST_INT_STATUS)
+	if (*ireg & UP_LD_HOST_INT_STATUS)
 		btmrvl_sdio_card_to_host(priv);
 
-	*ireg = sdio_ireg;
-
 	ret = 0;
+	sdio_release_host(card->func);
 
-done:
 	return ret;
 }
 
 static void btmrvl_sdio_interrupt(struct sdio_func *func)
 {
 	struct btmrvl_private *priv;
-	struct hci_dev *hcidev;
 	struct btmrvl_sdio_card *card;
+	ulong flags;
 	u8 ireg = 0;
+	int ret;
 
 	card = sdio_get_drvdata(func);
-	if (card && card->priv) {
-		priv = card->priv;
-		hcidev = priv->btmrvl_dev.hcidev;
+	if (!card || !card->priv) {
+		BT_ERR("sbi_interrupt(%p) card or priv is "
+				"NULL, card=%p\n", func, card);
+		return;
+	}
 
-		if (btmrvl_sdio_get_int_status(priv, &ireg))
-			BT_ERR("reading HOST_INT_STATUS_REG failed");
-		else
-			BT_DBG("HOST_INT_STATUS_REG %#x", ireg);
+	priv = card->priv;
 
-		btmrvl_interrupt(priv);
+	ireg = sdio_readb(card->func, HOST_INTSTATUS_REG, &ret);
+	if (ret) {
+		BT_ERR("sdio_readb: read int status register failed");
+		return;
 	}
+
+	if (ireg != 0) {
+		/*
+		 * DN_LD_HOST_INT_STATUS and/or UP_LD_HOST_INT_STATUS
+		 * Clear the interrupt status register and re-enable the
+		 * interrupt.
+		 */
+		BT_DBG("ireg = 0x%x", ireg);
+
+		sdio_writeb(card->func, ~(ireg) & (DN_LD_HOST_INT_STATUS |
+					UP_LD_HOST_INT_STATUS),
+				HOST_INTSTATUS_REG, &ret);
+		if (ret) {
+			BT_ERR("sdio_writeb: clear int status register "
+					"failed");
+			return;
+		}
+	}
+
+	spin_lock_irqsave(&priv->driver_lock, flags);
+	sdio_ireg |= ireg;
+	spin_unlock_irqrestore(&priv->driver_lock, flags);
+	btmrvl_interrupt(priv);
 }
 
 static int btmrvl_sdio_register_dev(struct btmrvl_sdio_card *card)
@@ -928,6 +931,7 @@ static int btmrvl_sdio_probe(struct sdio_func *func,
 	/* Initialize the interface specific function pointers */
 	priv->hw_host_to_card = btmrvl_sdio_host_to_card;
 	priv->hw_wakeup_firmware = btmrvl_sdio_wakeup_fw;
+	priv->hw_get_int_status = btmrvl_sdio_get_int_status;
 
 	btmrvl_send_module_cfg_cmd(priv, MODULE_BRINGUP_REQ);
 
-- 
1.5.4.3

