Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bing Zhao <bzhao@marvell.com>
Subject: [PATCH 1/3] Bluetooth: decode btmrvl MODULE_BRINGUP_REG response correctly
Date: Wed,  3 Mar 2010 14:37:35 -0800
Message-Id: <1267655857-10171-1-git-send-email-bzhao@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

btmrvl MODULE_BRINGUP_REQ command response returns success with
either 0x00 or 0x0c.

Signed-off-by: Bing Zhao <bzhao@marvell.com>
---
 drivers/bluetooth/btmrvl_drv.h  |    5 ++++-
 drivers/bluetooth/btmrvl_main.c |    6 ++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_drv.h b/drivers/bluetooth/btmrvl_drv.h
index 523d197..bdf5187 100644
--- a/drivers/bluetooth/btmrvl_drv.h
+++ b/drivers/bluetooth/btmrvl_drv.h
@@ -87,8 +87,11 @@ struct btmrvl_private {
 #define BT_CMD_HOST_SLEEP_ENABLE	0x5A
 #define BT_CMD_MODULE_CFG_REQ		0x5B
 
-/* Sub-commands: Module Bringup/Shutdown Request */
+/* Sub-commands: Module Bringup/Shutdown Request/Response */
 #define MODULE_BRINGUP_REQ		0xF1
+#define MODULE_BROUGHT_UP		0x00
+#define MODULE_ALREADY_UP		0x0C
+
 #define MODULE_SHUTDOWN_REQ		0xF2
 
 #define BT_EVENT_POWER_STATE		0x20
diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index 53a43ad..31e7412 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -112,8 +112,10 @@ int btmrvl_process_event(struct btmrvl_private *priv, struct sk_buff *skb)
 	case BT_CMD_MODULE_CFG_REQ:
 		if (priv->btmrvl_dev.sendcmdflag &&
 				event->data[1] == MODULE_BRINGUP_REQ) {
-			BT_DBG("EVENT:%s", (event->data[2]) ?
-				"Bring-up failed" : "Bring-up succeed");
+			BT_DBG("EVENT:%s",
+				((event->data[2] == MODULE_BROUGHT_UP) ||
+				(event->data[2] == MODULE_ALREADY_UP)) ?
+				"Bring-up succeed" : "Bring-up failed");
 		} else if (priv->btmrvl_dev.sendcmdflag &&
 				event->data[1] == MODULE_SHUTDOWN_REQ) {
 			BT_DBG("EVENT:%s", (event->data[2]) ?
-- 
1.5.3.6

