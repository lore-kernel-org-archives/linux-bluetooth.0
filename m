Return-Path: <cyrus@holtmann.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, <marcel@holtmann.org>,
        Amitkumar Karwar <akarwar@marvell.com>
Subject: [PATCH 1/2] Bluetooth: btmrvl: remove extra newline character
Date: Mon, 24 Nov 2014 02:40:52 -0800
Message-ID: <1416825653-32530-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

BT_INFO/BT_DBG etc. already takes care of adding a newline
An extra newline character inside message is removed in this
patch.

Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
---
 drivers/bluetooth/btmrvl_main.c | 14 +++++++-------
 drivers/bluetooth/btmrvl_sdio.c |  4 ++--
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index bb0d2c2..10973ac 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -42,7 +42,7 @@ void btmrvl_interrupt(struct btmrvl_private *priv)
 	priv->adapter->int_count++;
 
 	if (priv->adapter->hs_state == HS_ACTIVATED) {
-		BT_DBG("BT: HS DEACTIVATED in ISR!\n");
+		BT_DBG("BT: HS DEACTIVATED in ISR!");
 		priv->adapter->hs_state = HS_DEACTIVATED;
 	}
 
@@ -214,7 +214,7 @@ int btmrvl_send_module_cfg_cmd(struct btmrvl_private *priv, u8 subcmd)
 
 	ret = btmrvl_send_sync_cmd(priv, BT_CMD_MODULE_CFG_REQ, &subcmd, 1);
 	if (ret)
-		BT_ERR("module_cfg_cmd(%x) failed\n", subcmd);
+		BT_ERR("module_cfg_cmd(%x) failed", subcmd);
 
 	return ret;
 }
@@ -250,7 +250,7 @@ int btmrvl_send_hscfg_cmd(struct btmrvl_private *priv)
 
 	ret = btmrvl_send_sync_cmd(priv, BT_CMD_HOST_SLEEP_CONFIG, param, 2);
 	if (ret)
-		BT_ERR("HSCFG command failed\n");
+		BT_ERR("HSCFG command failed");
 
 	return ret;
 }
@@ -268,7 +268,7 @@ int btmrvl_enable_ps(struct btmrvl_private *priv)
 
 	ret = btmrvl_send_sync_cmd(priv, BT_CMD_AUTO_SLEEP_MODE, &param, 1);
 	if (ret)
-		BT_ERR("PSMODE command failed\n");
+		BT_ERR("PSMODE command failed");
 
 	return 0;
 }
@@ -281,7 +281,7 @@ int btmrvl_enable_hs(struct btmrvl_private *priv)
 
 	ret = btmrvl_send_sync_cmd(priv, BT_CMD_HOST_SLEEP_ENABLE, NULL, 0);
 	if (ret) {
-		BT_ERR("Host sleep enable command failed\n");
+		BT_ERR("Host sleep enable command failed");
 		return ret;
 	}
 
@@ -328,7 +328,7 @@ int btmrvl_prepare_command(struct btmrvl_private *priv)
 		} else {
 			ret = priv->hw_wakeup_firmware(priv);
 			priv->adapter->hs_state = HS_DEACTIVATED;
-			BT_DBG("BT: HS DEACTIVATED due to host activity!\n");
+			BT_DBG("BT: HS DEACTIVATED due to host activity!");
 		}
 	}
 
@@ -493,7 +493,7 @@ static int btmrvl_download_cal_data(struct btmrvl_private *priv,
 	ret = btmrvl_send_sync_cmd(priv, BT_CMD_LOAD_CONFIG_DATA, data,
 				   BT_CAL_HDR_LEN + len);
 	if (ret)
-		BT_ERR("Failed to download caibration data\n");
+		BT_ERR("Failed to download caibration data");
 
 	return 0;
 }
diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 550bce0..416d792 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -764,8 +764,8 @@ static void btmrvl_sdio_interrupt(struct sdio_func *func)
 
 	card = sdio_get_drvdata(func);
 	if (!card || !card->priv) {
-		BT_ERR("sbi_interrupt(%p) card or priv is "
-				"NULL, card=%p\n", func, card);
+		BT_ERR("sbi_interrupt(%p) card or priv is NULL, card=%p",
+		       func, card);
 		return;
 	}
 
-- 
1.8.1.4
