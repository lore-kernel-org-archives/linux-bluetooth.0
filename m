Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	robh@kernel.org,
	Jeremy Cline <jeremy@jcline.org>,
	linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 08/13] Bluetooth: hci_serdev: Move serdev_device_close/open into common hci_serdev code
Date: Sun, 27 May 2018 21:04:52 +0200
Message-Id: <20180527190457.2632-9-hdegoede@redhat.com>
In-Reply-To: <20180527190457.2632-1-hdegoede@redhat.com>
References: <20180527190457.2632-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Make hci_uart_register_device() and hci_uart_unregister_device() call
serdev_device_close()/open() themselves instead of relying on the various
hci_uart drivers to do this for them.

Besides reducing code complexity, this also ensures correct error checking
of serdev_device_open(), which was missing in a few drivers.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_bcm.c    | 10 +---------
 drivers/bluetooth/hci_ll.c     |  3 ---
 drivers/bluetooth/hci_nokia.c  |  3 ---
 drivers/bluetooth/hci_serdev.c |  9 ++++++++-
 4 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index f06f0f1132fb..ddbd8c6a0ceb 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -380,10 +380,6 @@ static int bcm_open(struct hci_uart *hu)
 	mutex_lock(&bcm_device_lock);
 
 	if (hu->serdev) {
-		err = serdev_device_open(hu->serdev);
-		if (err)
-			goto err_free;
-
 		bcm->dev = serdev_device_get_drvdata(hu->serdev);
 		goto out;
 	}
@@ -420,13 +416,10 @@ static int bcm_open(struct hci_uart *hu)
 	return 0;
 
 err_unset_hu:
-	if (hu->serdev)
-		serdev_device_close(hu->serdev);
 #ifdef CONFIG_PM
-	else
+	if (!hu->serdev)
 		bcm->dev->hu = NULL;
 #endif
-err_free:
 	mutex_unlock(&bcm_device_lock);
 	hu->priv = NULL;
 	kfree(bcm);
@@ -445,7 +438,6 @@ static int bcm_close(struct hci_uart *hu)
 	mutex_lock(&bcm_device_lock);
 
 	if (hu->serdev) {
-		serdev_device_close(hu->serdev);
 		bdev = serdev_device_get_drvdata(hu->serdev);
 	} else if (bcm_device_exists(bcm->dev)) {
 		bdev = bcm->dev;
diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
index 27e414b4e3a2..3e767f245ed5 100644
--- a/drivers/bluetooth/hci_ll.c
+++ b/drivers/bluetooth/hci_ll.c
@@ -141,7 +141,6 @@ static int ll_open(struct hci_uart *hu)
 
 	if (hu->serdev) {
 		struct ll_device *lldev = serdev_device_get_drvdata(hu->serdev);
-		serdev_device_open(hu->serdev);
 		if (!IS_ERR(lldev->ext_clk))
 			clk_prepare_enable(lldev->ext_clk);
 	}
@@ -179,8 +178,6 @@ static int ll_close(struct hci_uart *hu)
 		gpiod_set_value_cansleep(lldev->enable_gpio, 0);
 
 		clk_disable_unprepare(lldev->ext_clk);
-
-		serdev_device_close(hu->serdev);
 	}
 
 	hu->priv = NULL;
diff --git a/drivers/bluetooth/hci_nokia.c b/drivers/bluetooth/hci_nokia.c
index 3539fd03f47e..14d159e2042d 100644
--- a/drivers/bluetooth/hci_nokia.c
+++ b/drivers/bluetooth/hci_nokia.c
@@ -477,8 +477,6 @@ static int nokia_open(struct hci_uart *hu)
 
 	dev_dbg(dev, "protocol open");
 
-	serdev_device_open(hu->serdev);
-
 	pm_runtime_enable(dev);
 
 	return 0;
@@ -513,7 +511,6 @@ static int nokia_close(struct hci_uart *hu)
 	gpiod_set_value(btdev->wakeup_bt, 0);
 
 	pm_runtime_disable(&btdev->serdev->dev);
-	serdev_device_close(btdev->serdev);
 
 	return 0;
 }
diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
index da6eb5bcfa6f..ce024142f5d3 100644
--- a/drivers/bluetooth/hci_serdev.c
+++ b/drivers/bluetooth/hci_serdev.c
@@ -285,10 +285,14 @@ int hci_uart_register_device(struct hci_uart *hu,
 
 	serdev_device_set_client_ops(hu->serdev, &hci_serdev_client_ops);
 
-	err = p->open(hu);
+	err = serdev_device_open(hu->serdev);
 	if (err)
 		return err;
 
+	err = p->open(hu);
+	if (err)
+		goto err_open;
+
 	hu->proto = p;
 	set_bit(HCI_UART_PROTO_READY, &hu->flags);
 
@@ -354,6 +358,8 @@ int hci_uart_register_device(struct hci_uart *hu,
 err_alloc:
 	clear_bit(HCI_UART_PROTO_READY, &hu->flags);
 	p->close(hu);
+err_open:
+	serdev_device_close(hu->serdev);
 	return err;
 }
 EXPORT_SYMBOL_GPL(hci_uart_register_device);
@@ -368,5 +374,6 @@ void hci_uart_unregister_device(struct hci_uart *hu)
 	cancel_work_sync(&hu->write_work);
 
 	hu->proto->close(hu);
+	serdev_device_close(hu->serdev);
 }
 EXPORT_SYMBOL_GPL(hci_uart_unregister_device);
-- 
2.17.0
