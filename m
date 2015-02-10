Return-Path: <cyrus@holtmann.org>
From: Amitkumar Karwar <akarwar@marvell.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <marcel@holtmann.org>, Cathy Luo <cluo@marvell.com>,
        Amitkumar Karwar
	<akarwar@marvell.com>
Subject: [PATCH] Bluetooth: btmrvl: support SCO routing to host interface
Date: Tue, 10 Feb 2015 05:49:41 -0800
Message-ID: <1423576181-17055-1-git-send-email-akarwar@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

A vendor specific command is sent to firmware during
initialization to enable this feature.

Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
Signed-off-by: Cathy Luo <cluo@marvell.com>
---
 drivers/bluetooth/btmrvl_drv.h  |  1 +
 drivers/bluetooth/btmrvl_main.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/bluetooth/btmrvl_drv.h b/drivers/bluetooth/btmrvl_drv.h
index e75f8ee..086f0ec 100644
--- a/drivers/bluetooth/btmrvl_drv.h
+++ b/drivers/bluetooth/btmrvl_drv.h
@@ -111,6 +111,7 @@ struct btmrvl_private {
 
 /* Vendor specific Bluetooth commands */
 #define BT_CMD_PSCAN_WIN_REPORT_ENABLE	0xFC03
+#define BT_CMD_ROUTE_SCO_TO_HOST	0xFC1D
 #define BT_CMD_SET_BDADDR		0xFC22
 #define BT_CMD_AUTO_SLEEP_MODE		0xFC23
 #define BT_CMD_HOST_SLEEP_CONFIG	0xFC59
diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index 4135977..de05deb 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -230,6 +230,18 @@ int btmrvl_send_module_cfg_cmd(struct btmrvl_private *priv, u8 subcmd)
 }
 EXPORT_SYMBOL_GPL(btmrvl_send_module_cfg_cmd);
 
+static int btmrvl_enable_sco_routing_to_host(struct btmrvl_private *priv)
+{
+	int ret;
+	u8 subcmd = 0;
+
+	ret = btmrvl_send_sync_cmd(priv, BT_CMD_ROUTE_SCO_TO_HOST, &subcmd, 1);
+	if (ret)
+		BT_ERR("BT_CMD_ROUTE_SCO_TO_HOST command failed: %#x", ret);
+
+	return ret;
+}
+
 int btmrvl_pscan_window_reporting(struct btmrvl_private *priv, u8 subcmd)
 {
 	struct btmrvl_sdio_card *card = priv->btmrvl_dev.card;
@@ -558,6 +570,8 @@ static int btmrvl_setup(struct hci_dev *hdev)
 
 	btmrvl_check_device_tree(priv);
 
+	btmrvl_enable_sco_routing_to_host(priv);
+
 	btmrvl_pscan_window_reporting(priv, 0x01);
 
 	priv->btmrvl_dev.psmode = 1;
-- 
1.8.1.4
