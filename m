Return-Path: <lukas@wunner.de>
Message-Id: <4cf1ba614b554d096448d3705e95140fac346193.1515348092.git.lukas@wunner.de>
In-Reply-To: <cover.1515348092.git.lukas@wunner.de>
References: <cover.1515348092.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Sun, 7 Jan 2018 20:16:32 +0100
Subject: [PATCH v3 09/13] Bluetooth: hci_bcm: Handle errors properly
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Frederic Danis <frederic.danis.oss@gmail.com>, Loic Poulain <loic.poulain@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Max Shavrick <mxms@me.com>, Leif Liddy <leif.liddy@gmail.com>, Daniel Roschka <danielroschka@phoenitydawn.de>, Ronald Tschalaer <ronald@innovation.ch>, "Peter Y. Chuang" <peteryuchuang@gmail.com>, linux-bluetooth@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

A significant portion of this driver lacks error handling.  As a first
step, add error paths to bcm_gpio_set_power(), bcm_open(), bcm_close(),
bcm_suspend_device(), bcm_resume_device(), bcm_resume(), bcm_probe() and
bcm_serdev_probe().  (I've also scrutinized bcm_suspend() but think it's
fine as is.)

Those are all the functions accessing the device wake and shutdown GPIO.
On Apple Macs the pins are accessed through ACPI methods, which may fail
for various reasons, hence proper error handling is necessary.  Non-Macs
access the pins directly, which may fail as well but the GPIO core does
not yet pass back errors to consumers.

Cc: Frédéric Danis <frederic.danis.oss@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/bluetooth/hci_bcm.c | 90 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 74 insertions(+), 16 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 81eb6ac80de6..a8d12a53ea1c 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -197,11 +197,21 @@ static bool bcm_device_exists(struct bcm_device *device)
 
 static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 {
-	if (powered && !IS_ERR(dev->clk) && !dev->clk_enabled)
-		clk_prepare_enable(dev->clk);
+	int err;
 
-	dev->set_shutdown(dev, powered);
-	dev->set_device_wakeup(dev, powered);
+	if (powered && !IS_ERR(dev->clk) && !dev->clk_enabled) {
+		err = clk_prepare_enable(dev->clk);
+		if (err)
+			return err;
+	}
+
+	err = dev->set_shutdown(dev, powered);
+	if (err)
+		goto err_clk_disable;
+
+	err = dev->set_device_wakeup(dev, powered);
+	if (err)
+		goto err_revert_shutdown;
 
 	if (!powered && !IS_ERR(dev->clk) && dev->clk_enabled)
 		clk_disable_unprepare(dev->clk);
@@ -209,6 +219,13 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 	dev->clk_enabled = powered;
 
 	return 0;
+
+err_revert_shutdown:
+	dev->set_shutdown(dev, !powered);
+err_clk_disable:
+	if (powered && !IS_ERR(dev->clk) && !dev->clk_enabled)
+		clk_disable_unprepare(dev->clk);
+	return err;
 }
 
 #ifdef CONFIG_PM
@@ -331,6 +348,7 @@ static int bcm_open(struct hci_uart *hu)
 {
 	struct bcm_data *bcm;
 	struct list_head *p;
+	int err;
 
 	bt_dev_dbg(hu->hdev, "hu %p", hu);
 
@@ -345,7 +363,10 @@ static int bcm_open(struct hci_uart *hu)
 	mutex_lock(&bcm_device_lock);
 
 	if (hu->serdev) {
-		serdev_device_open(hu->serdev);
+		err = serdev_device_open(hu->serdev);
+		if (err)
+			goto err_free;
+
 		bcm->dev = serdev_device_get_drvdata(hu->serdev);
 		goto out;
 	}
@@ -373,17 +394,30 @@ static int bcm_open(struct hci_uart *hu)
 	if (bcm->dev) {
 		hu->init_speed = bcm->dev->init_speed;
 		hu->oper_speed = bcm->dev->oper_speed;
-		bcm_gpio_set_power(bcm->dev, true);
+		err = bcm_gpio_set_power(bcm->dev, true);
+		if (err)
+			goto err_unset_hu;
 	}
 
 	mutex_unlock(&bcm_device_lock);
 	return 0;
+
+err_unset_hu:
+#ifdef CONFIG_PM
+	bcm->dev->hu = NULL;
+#endif
+err_free:
+	mutex_unlock(&bcm_device_lock);
+	hu->priv = NULL;
+	kfree(bcm);
+	return err;
 }
 
 static int bcm_close(struct hci_uart *hu)
 {
 	struct bcm_data *bcm = hu->priv;
 	struct bcm_device *bdev = NULL;
+	int err;
 
 	bt_dev_dbg(hu->hdev, "hu %p", hu);
 
@@ -406,8 +440,10 @@ static int bcm_close(struct hci_uart *hu)
 			device_init_wakeup(bdev->dev, false);
 		}
 
-		bcm_gpio_set_power(bdev, false);
-		if (bdev->irq > 0) {
+		err = bcm_gpio_set_power(bdev, false);
+		if (err) {
+			bt_dev_err(hu->hdev, "Failed to power down");
+		} else if (bdev->irq > 0) {
 			pm_runtime_disable(bdev->dev);
 			pm_runtime_set_suspended(bdev->dev);
 		}
@@ -590,6 +626,7 @@ static struct sk_buff *bcm_dequeue(struct hci_uart *hu)
 static int bcm_suspend_device(struct device *dev)
 {
 	struct bcm_device *bdev = dev_get_drvdata(dev);
+	int err;
 
 	bt_dev_dbg(bdev, "");
 
@@ -601,7 +638,15 @@ static int bcm_suspend_device(struct device *dev)
 	}
 
 	/* Suspend the device */
-	bdev->set_device_wakeup(bdev, false);
+	err = bdev->set_device_wakeup(bdev, false);
+	if (err) {
+		if (bdev->is_suspended && bdev->hu) {
+			bdev->is_suspended = false;
+			hci_uart_set_flow_control(bdev->hu, false);
+		}
+		return -EBUSY;
+	}
+
 	bt_dev_dbg(bdev, "suspend, delaying 15 ms");
 	mdelay(15);
 
@@ -611,10 +656,16 @@ static int bcm_suspend_device(struct device *dev)
 static int bcm_resume_device(struct device *dev)
 {
 	struct bcm_device *bdev = dev_get_drvdata(dev);
+	int err;
 
 	bt_dev_dbg(bdev, "");
 
-	bdev->set_device_wakeup(bdev, true);
+	err = bdev->set_device_wakeup(bdev, true);
+	if (err) {
+		dev_err(dev, "Failed to power up\n");
+		return err;
+	}
+
 	bt_dev_dbg(bdev, "resume, delaying 15 ms");
 	mdelay(15);
 
@@ -668,6 +719,7 @@ static int bcm_suspend(struct device *dev)
 static int bcm_resume(struct device *dev)
 {
 	struct bcm_device *bdev = dev_get_drvdata(dev);
+	int err = 0;
 
 	bt_dev_dbg(bdev, "resume: is_suspended %d", bdev->is_suspended);
 
@@ -687,14 +739,16 @@ static int bcm_resume(struct device *dev)
 		bt_dev_dbg(bdev, "BCM irq: disabled");
 	}
 
-	bcm_resume_device(dev);
+	err = bcm_resume_device(dev);
 
 unlock:
 	mutex_unlock(&bcm_device_lock);
 
-	pm_runtime_disable(dev);
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
+	if (!err) {
+		pm_runtime_disable(dev);
+		pm_runtime_set_active(dev);
+		pm_runtime_enable(dev);
+	}
 
 	return 0;
 }
@@ -925,7 +979,9 @@ static int bcm_probe(struct platform_device *pdev)
 	list_add_tail(&dev->list, &bcm_device_list);
 	mutex_unlock(&bcm_device_lock);
 
-	bcm_gpio_set_power(dev, false);
+	ret = bcm_gpio_set_power(dev, false);
+	if (ret)
+		dev_err(&pdev->dev, "Failed to power down\n");
 
 	return 0;
 }
@@ -1027,7 +1083,9 @@ static int bcm_serdev_probe(struct serdev_device *serdev)
 	if (err)
 		return err;
 
-	bcm_gpio_set_power(bcmdev, false);
+	err = bcm_gpio_set_power(bcmdev, false);
+	if (err)
+		dev_err(&serdev->dev, "Failed to power down\n");
 
 	return hci_uart_register_device(&bcmdev->serdev_hu, &bcm_proto);
 }
-- 
2.15.1
