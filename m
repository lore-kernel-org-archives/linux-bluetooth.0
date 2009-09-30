Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bing Zhao <bzhao@marvell.com>,
	Amitkumar Karwar <akarwar@marvell.com>
Subject: [PATCH v2] Bluetooth: Enable auto sleep mode for btmrvl driver
Date: Wed, 30 Sep 2009 11:18:30 -0700
Message-Id: <1254334710-1811-1-git-send-email-bzhao@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Amitkumar Karwar <akarwar@marvell.com>

The auto sleep mode for btmrvl driver is not enabled by default.
This patch enables auto sleep mode when card is probed.

Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
Signed-off-by: Bing Zhao <bzhao@marvell.com>
---
 drivers/bluetooth/btmrvl_drv.h  |    1 +
 drivers/bluetooth/btmrvl_main.c |   55 +++++++++++++++++++++++---------------
 drivers/bluetooth/btmrvl_sdio.c |    2 +
 3 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_drv.h b/drivers/bluetooth/btmrvl_drv.h
index 411c7a7..523d197 100644
--- a/drivers/bluetooth/btmrvl_drv.h
+++ b/drivers/bluetooth/btmrvl_drv.h
@@ -131,6 +131,7 @@ void btmrvl_check_evtpkt(struct btmrvl_private *priv, struct sk_buff *skb);
 int btmrvl_process_event(struct btmrvl_private *priv, struct sk_buff *skb);
 
 int btmrvl_send_module_cfg_cmd(struct btmrvl_private *priv, int subcmd);
+int btmrvl_enable_ps(struct btmrvl_private *priv);
 int btmrvl_prepare_command(struct btmrvl_private *priv);
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index e605563..f97771c 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -189,6 +189,38 @@ int btmrvl_send_module_cfg_cmd(struct btmrvl_private *priv, int subcmd)
 }
 EXPORT_SYMBOL_GPL(btmrvl_send_module_cfg_cmd);
 
+int btmrvl_enable_ps(struct btmrvl_private *priv)
+{
+	struct sk_buff *skb;
+	struct btmrvl_cmd *cmd;
+
+	skb = bt_skb_alloc(sizeof(*cmd), GFP_ATOMIC);
+	if (skb == NULL) {
+		BT_ERR("No free skb");
+		return -ENOMEM;
+	}
+
+	cmd = (struct btmrvl_cmd *) skb_put(skb, sizeof(*cmd));
+	cmd->ocf_ogf = cpu_to_le16(hci_opcode_pack(OGF,
+					BT_CMD_AUTO_SLEEP_MODE));
+	cmd->length = 1;
+
+	if (priv->btmrvl_dev.psmode)
+		cmd->data[0] = BT_PS_ENABLE;
+	else
+		cmd->data[0] = BT_PS_DISABLE;
+
+	bt_cb(skb)->pkt_type = MRVL_VENDOR_PKT;
+
+	skb->dev = (void *) priv->btmrvl_dev.hcidev;
+	skb_queue_head(&priv->adapter->tx_queue, skb);
+
+	BT_DBG("Queue PSMODE Command:%d", cmd->data[0]);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(btmrvl_enable_ps);
+
 static int btmrvl_enable_hs(struct btmrvl_private *priv)
 {
 	struct sk_buff *skb;
@@ -258,28 +290,7 @@ int btmrvl_prepare_command(struct btmrvl_private *priv)
 
 	if (priv->btmrvl_dev.pscmd) {
 		priv->btmrvl_dev.pscmd = 0;
-
-		skb = bt_skb_alloc(sizeof(*cmd), GFP_ATOMIC);
-		if (skb == NULL) {
-			BT_ERR("No free skb");
-			return -ENOMEM;
-		}
-
-		cmd = (struct btmrvl_cmd *) skb_put(skb, sizeof(*cmd));
-		cmd->ocf_ogf = cpu_to_le16(hci_opcode_pack(OGF, BT_CMD_AUTO_SLEEP_MODE));
-		cmd->length = 1;
-
-		if (priv->btmrvl_dev.psmode)
-			cmd->data[0] = BT_PS_ENABLE;
-		else
-			cmd->data[0] = BT_PS_DISABLE;
-
-		bt_cb(skb)->pkt_type = MRVL_VENDOR_PKT;
-
-		skb->dev = (void *) priv->btmrvl_dev.hcidev;
-		skb_queue_head(&priv->adapter->tx_queue, skb);
-
-		BT_DBG("Queue PSMODE Command:%d", cmd->data[0]);
+		btmrvl_enable_ps(priv);
 	}
 
 	if (priv->btmrvl_dev.hscmd) {
diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 5b33b85..d6aaf51 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -930,6 +930,8 @@ static int btmrvl_sdio_probe(struct sdio_func *func,
 	priv->hw_wakeup_firmware = btmrvl_sdio_wakeup_fw;
 
 	btmrvl_send_module_cfg_cmd(priv, MODULE_BRINGUP_REQ);
+	priv->btmrvl_dev.psmode = 1;
+	btmrvl_enable_ps(priv);
 
 	return 0;
 
-- 
1.5.4.3

