Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bing Zhao <bzhao@marvell.com>
Subject: [PATCH 2/3] Bluetooth: separate btmrvl_register_hdev() from btmrvl_add_card()
Date: Wed,  3 Mar 2010 14:37:36 -0800
Message-Id: <1267655857-10171-2-git-send-email-bzhao@marvell.com>
In-Reply-To: <1267655857-10171-1-git-send-email-bzhao@marvell.com>
References: <1267655857-10171-1-git-send-email-bzhao@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Move btmrvl hdev registration code out of btmrvl_add_card().
New function btmrvl_register_hdev() is added.

Signed-off-by: Bing Zhao <bzhao@marvell.com>
---
 drivers/bluetooth/btmrvl_drv.h  |    1 +
 drivers/bluetooth/btmrvl_main.c |   75 ++++++++++++++++++++++----------------
 drivers/bluetooth/btmrvl_sdio.c |    7 +++-
 3 files changed, 50 insertions(+), 33 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_drv.h b/drivers/bluetooth/btmrvl_drv.h
index bdf5187..ec8ac5e 100644
--- a/drivers/bluetooth/btmrvl_drv.h
+++ b/drivers/bluetooth/btmrvl_drv.h
@@ -125,6 +125,7 @@ struct btmrvl_event {
 
 /* Prototype of global function */
 
+int btmrvl_register_hdev(struct btmrvl_private *priv);
 struct btmrvl_private *btmrvl_add_card(void *card);
 int btmrvl_remove_card(struct btmrvl_private *priv);
 
diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index 31e7412..277cb10 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -524,47 +524,20 @@ static int btmrvl_service_main_thread(void *data)
 	return 0;
 }
 
-struct btmrvl_private *btmrvl_add_card(void *card)
+int btmrvl_register_hdev(struct btmrvl_private *priv)
 {
 	struct hci_dev *hdev = NULL;
-	struct btmrvl_private *priv;
 	int ret;
 
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		BT_ERR("Can not allocate priv");
-		goto err_priv;
-	}
-
-	priv->adapter = kzalloc(sizeof(*priv->adapter), GFP_KERNEL);
-	if (!priv->adapter) {
-		BT_ERR("Allocate buffer for btmrvl_adapter failed!");
-		goto err_adapter;
-	}
-
-	btmrvl_init_adapter(priv);
-
 	hdev = hci_alloc_dev();
 	if (!hdev) {
 		BT_ERR("Can not allocate HCI device");
 		goto err_hdev;
 	}
 
-	BT_DBG("Starting kthread...");
-	priv->main_thread.priv = priv;
-	spin_lock_init(&priv->driver_lock);
-
-	init_waitqueue_head(&priv->main_thread.wait_q);
-	priv->main_thread.task = kthread_run(btmrvl_service_main_thread,
-				&priv->main_thread, "btmrvl_main_service");
-
 	priv->btmrvl_dev.hcidev = hdev;
-	priv->btmrvl_dev.card = card;
-
 	hdev->driver_data = priv;
 
-	priv->btmrvl_dev.tx_dnld_rdy = true;
-
 	hdev->bus = HCI_SDIO;
 	hdev->open = btmrvl_open;
 	hdev->close = btmrvl_close;
@@ -574,6 +547,8 @@ struct btmrvl_private *btmrvl_add_card(void *card)
 	hdev->ioctl = btmrvl_ioctl;
 	hdev->owner = THIS_MODULE;
 
+	btmrvl_send_module_cfg_cmd(priv, MODULE_BRINGUP_REQ);
+
 	ret = hci_register_dev(hdev);
 	if (ret < 0) {
 		BT_ERR("Can not register HCI device");
@@ -584,16 +559,52 @@ struct btmrvl_private *btmrvl_add_card(void *card)
 	btmrvl_debugfs_init(hdev);
 #endif
 
-	return priv;
+	return 0;
 
 err_hci_register_dev:
-	/* Stop the thread servicing the interrupts */
-	kthread_stop(priv->main_thread.task);
-
 	hci_free_dev(hdev);
 
 err_hdev:
+	/* Stop the thread servicing the interrupts */
+	kthread_stop(priv->main_thread.task);
+
 	btmrvl_free_adapter(priv);
+	kfree(priv);
+
+	return -ENOMEM;
+}
+EXPORT_SYMBOL_GPL(btmrvl_register_hdev);
+
+struct btmrvl_private *btmrvl_add_card(void *card)
+{
+	struct btmrvl_private *priv;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		BT_ERR("Can not allocate priv");
+		goto err_priv;
+	}
+
+	priv->adapter = kzalloc(sizeof(*priv->adapter), GFP_KERNEL);
+	if (!priv->adapter) {
+		BT_ERR("Allocate buffer for btmrvl_adapter failed!");
+		goto err_adapter;
+	}
+
+	btmrvl_init_adapter(priv);
+
+	BT_DBG("Starting kthread...");
+	priv->main_thread.priv = priv;
+	spin_lock_init(&priv->driver_lock);
+
+	init_waitqueue_head(&priv->main_thread.wait_q);
+	priv->main_thread.task = kthread_run(btmrvl_service_main_thread,
+				&priv->main_thread, "btmrvl_main_service");
+
+	priv->btmrvl_dev.card = card;
+	priv->btmrvl_dev.tx_dnld_rdy = true;
+
+	return priv;
 
 err_adapter:
 	kfree(priv);
diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 94f1f55..874a5e8 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -930,7 +930,12 @@ static int btmrvl_sdio_probe(struct sdio_func *func,
 	priv->hw_host_to_card = btmrvl_sdio_host_to_card;
 	priv->hw_wakeup_firmware = btmrvl_sdio_wakeup_fw;
 
-	btmrvl_send_module_cfg_cmd(priv, MODULE_BRINGUP_REQ);
+	if (btmrvl_register_hdev(priv)) {
+		BT_ERR("Register hdev failed!");
+		ret = -ENODEV;
+		goto disable_host_int;
+	}
+
 	priv->btmrvl_dev.psmode = 1;
 	btmrvl_enable_ps(priv);
 
-- 
1.5.3.6

