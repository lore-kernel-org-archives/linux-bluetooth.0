Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bing Zhao <bzhao@marvell.com>
Subject: [PATCH 3/3] Bluetooth: set hdev->dev_type based on Marvell device type
Date: Wed,  3 Mar 2010 14:37:37 -0800
Message-Id: <1267655857-10171-3-git-send-email-bzhao@marvell.com>
In-Reply-To: <1267655857-10171-1-git-send-email-bzhao@marvell.com>
References: <1267655857-10171-1-git-send-email-bzhao@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Get the device type from MODULE_BRINGUP_REQ command response.

Signed-off-by: Bing Zhao <bzhao@marvell.com>
---
 drivers/bluetooth/btmrvl_drv.h  |    2 ++
 drivers/bluetooth/btmrvl_main.c |    9 +++++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_drv.h b/drivers/bluetooth/btmrvl_drv.h
index ec8ac5e..bd91652 100644
--- a/drivers/bluetooth/btmrvl_drv.h
+++ b/drivers/bluetooth/btmrvl_drv.h
@@ -41,6 +41,8 @@ struct btmrvl_device {
 	void *card;
 	struct hci_dev *hcidev;
 
+	u8 dev_type;
+
 	u8 tx_dnld_rdy;
 
 	u8 psmode;
diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index 277cb10..956f40c 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -116,6 +116,13 @@ int btmrvl_process_event(struct btmrvl_private *priv, struct sk_buff *skb)
 				((event->data[2] == MODULE_BROUGHT_UP) ||
 				(event->data[2] == MODULE_ALREADY_UP)) ?
 				"Bring-up succeed" : "Bring-up failed");
+
+			if (event->length > 3)
+				priv->btmrvl_dev.dev_type = event->data[3];
+			else
+				priv->btmrvl_dev.dev_type = HCI_BREDR;
+
+			BT_DBG("dev_type: %d", priv->btmrvl_dev.dev_type);
 		} else if (priv->btmrvl_dev.sendcmdflag &&
 				event->data[1] == MODULE_SHUTDOWN_REQ) {
 			BT_DBG("EVENT:%s", (event->data[2]) ?
@@ -549,6 +556,8 @@ int btmrvl_register_hdev(struct btmrvl_private *priv)
 
 	btmrvl_send_module_cfg_cmd(priv, MODULE_BRINGUP_REQ);
 
+	hdev->dev_type = priv->btmrvl_dev.dev_type;
+
 	ret = hci_register_dev(hdev);
 	if (ret < 0) {
 		BT_ERR("Can not register HCI device");
-- 
1.5.3.6

