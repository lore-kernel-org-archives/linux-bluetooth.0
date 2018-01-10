Return-Path: <lukas@wunner.de>
Message-Id: <b73e3f200d841e21110d9cfc8ddde8037d3c416e.1515593773.git.lukas@wunner.de>
In-Reply-To: <cover.1515593773.git.lukas@wunner.de>
References: <cover.1515593773.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 10 Jan 2018 16:32:10 +0100
Subject: [PATCH v4 08/13] Bluetooth: hci_bcm: Add callbacks to toggle GPIOs
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Frederic Danis <frederic.danis.oss@gmail.com>, Loic Poulain <loic.poulain@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Max Shavrick <mxms@me.com>, Leif Liddy <leif.liddy@gmail.com>, Daniel Roschka <danielroschka@phoenitydawn.de>, Ronald Tschalaer <ronald@innovation.ch>, "Peter Y. Chuang" <peteryuchuang@gmail.com>, linux-bluetooth@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

MacBooks provides custom ACPI methods to toggle the GPIOs for device
wake and shutdown instead of accessing the pins directly.  Prepare for
their support by adding callbacks to toggle the GPIOs, which on non-Macs
do nothing more but call gpiod_set_value().

No functional change intended.

Suggested-and-reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
Changes since v2:
  Replaces patch "Add helper to toggle device wake GPIO" in v2.
  This makes the subsequent addition of Mac support less intrusive. (Andy)

 drivers/bluetooth/hci_bcm.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 3c1282a9fcd4..8741e302e6fd 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -63,6 +63,8 @@
  *	deassert = Bluetooth device may sleep when sleep criteria are met
  * @shutdown: BT_REG_ON pin,
  *	power up or power down Bluetooth device internal regulators
+ * @set_device_wakeup: callback to toggle BT_WAKE pin
+ * @set_shutdown: callback to toggle BT_REG_ON pin
  * @clk: clock used by Bluetooth device
  * @clk_enabled: whether @clk is prepared and enabled
  * @init_speed: default baudrate of Bluetooth device;
@@ -86,6 +88,8 @@ struct bcm_device {
 	const char		*name;
 	struct gpio_desc	*device_wakeup;
 	struct gpio_desc	*shutdown;
+	int			(*set_device_wakeup)(struct bcm_device *, bool);
+	int			(*set_shutdown)(struct bcm_device *, bool);
 
 	struct clk		*clk;
 	bool			clk_enabled;
@@ -196,8 +200,8 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 	if (powered && !IS_ERR(dev->clk) && !dev->clk_enabled)
 		clk_prepare_enable(dev->clk);
 
-	gpiod_set_value(dev->shutdown, powered);
-	gpiod_set_value(dev->device_wakeup, powered);
+	dev->set_shutdown(dev, powered);
+	dev->set_device_wakeup(dev, powered);
 
 	if (!powered && !IS_ERR(dev->clk) && dev->clk_enabled)
 		clk_disable_unprepare(dev->clk);
@@ -595,7 +599,7 @@ static int bcm_suspend_device(struct device *dev)
 	}
 
 	/* Suspend the device */
-	gpiod_set_value(bdev->device_wakeup, false);
+	bdev->set_device_wakeup(bdev, false);
 	bt_dev_dbg(bdev, "suspend, delaying 15 ms");
 	mdelay(15);
 
@@ -608,7 +612,7 @@ static int bcm_resume_device(struct device *dev)
 
 	bt_dev_dbg(bdev, "");
 
-	gpiod_set_value(bdev->device_wakeup, true);
+	bdev->set_device_wakeup(bdev, true);
 	bt_dev_dbg(bdev, "resume, delaying 15 ms");
 	mdelay(15);
 
@@ -787,6 +791,18 @@ static int bcm_resource(struct acpi_resource *ares, void *data)
 }
 #endif /* CONFIG_ACPI */
 
+static int bcm_gpio_set_device_wakeup(struct bcm_device *dev, bool awake)
+{
+	gpiod_set_value(dev->device_wakeup, awake);
+	return 0;
+}
+
+static int bcm_gpio_set_shutdown(struct bcm_device *dev, bool powered)
+{
+	gpiod_set_value(dev->shutdown, powered);
+	return 0;
+}
+
 static int bcm_get_resources(struct bcm_device *dev)
 {
 	dev->name = dev_name(dev->dev);
@@ -802,6 +818,9 @@ static int bcm_get_resources(struct bcm_device *dev)
 	if (IS_ERR(dev->shutdown))
 		return PTR_ERR(dev->shutdown);
 
+	dev->set_device_wakeup = bcm_gpio_set_device_wakeup;
+	dev->set_shutdown = bcm_gpio_set_shutdown;
+
 	/* IRQ can be declared in ACPI table as Interrupt or GpioInt */
 	if (dev->irq <= 0) {
 		struct gpio_desc *gpio;
-- 
2.15.1
