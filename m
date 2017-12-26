Return-Path: <lukas@wunner.de>
Message-Id: <5e3106d673c3c41bf92c91f1f43bf30682511366.1514143015.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 26 Dec 2017 17:07:34 +0200
Subject: [PATCH 1/3] Bluetooth: hci_bcm: Support Apple GPIO handling
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Frederic Danis <frederic.danis.oss@gmail.com>, Loic Poulain <loic.poulain@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Max Shavrick <mxms@me.com>, Leif Liddy <leif.liddy@gmail.com>, Daniel Roschka <danielroschka@phoenitydawn.de>, Ronald Tschalaer <ronald@innovation.ch>, "Peter Y. Chuang" <peteryuchuang@gmail.com>, linux-bluetooth@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Enable Bluetooth on the following Macs which provide custom ACPI methods
to toggle the GPIOs for device wakeup and shutdown instead of accessing
the pins directly:

    MacBook8,1     2015  12"
    MacBook9,1     2016  12"
    MacBook10,1    2017  12"
    MacBookPro13,1 2016  13"
    MacBookPro13,2 2016  13" with Touch Bar
    MacBookPro13,3 2016  15" with Touch Bar
    MacBookPro14,1 2017  13"
    MacBookPro14,2 2017  13" with Touch Bar
    MacBookPro14,3 2017  15" with Touch Bar

On the MacBook8,1 Bluetooth is muxed with a second device (a debug port
on the SSD) under the control of PCH GPIO 36.  Because serdev cannot
deal with multiple slaves yet, it is currently necessary to patch the
DSDT and remove the SSDC device.

The custom ACPI methods are called:

    BTLP (Low Power) takes one argument, toggles device wakeup GPIO
    BTPU (Power Up) tells SMC to drive shutdown GPIO high
    BTPD (Power Down) tells SMC to drive shutdown GPIO low
    BTRS (Reset) calls BTPD followed by BTPU
    BTRB unknown, not present on all MacBooks

Search for the BTLP, BTPU and BTPD methods on ->probe and cache them in
struct bcm_device if the machine is a Mac.

Additionally, set the init_speed based on a custom device property
provided by Apple in lieu of _CRS resources.  The Broadcom UART's speed
is fixed on Apple Macs:  Any attempt to change it results in Bluetooth
status code 0x0c and bcm_set_baudrate() thus always returns -EBUSY.
By setting only the init_speed and leaving oper_speed at zero, we can
achieve that the host UART's speed is adjusted but the Broadcom UART's
speed is left as is.

The host wakeup pin goes into the SMC which handles it independently
from the OS, so there's no IRQ for it.  The ->close, ->suspend and
->resume hooks assume presence of a valid IRQ if the device is wakeup
capable.  That's a problem on Macs where the ACPI core marks the device
wakeup capable due to presence of a _PRW method.  (It specifies the
SMC's GPE as wake event.)  Amend the three hooks to not fiddle with the
IRQ if it's invalid, i.e. <= 0.

Runtime PM is currently set up in bcm_request_irq() even though it's
independent of host wake.  Move the function calls related to runtime PM
to bcm_setup() so that they get executed even if setup of the IRQ is
skipped.

The existing code is a bit fishy as it ignores the return value of
bcm_gpio_set_power(), even though portions of it may fail (such as
enabling the clock).  The present commit returns an error if calling
the ACPI methods fails and the code needs to be fixed up in a separate
commit to evaluate the return value of bcm_gpio_set_power() and
bcm_gpio_set_device_wake(), as well as check for failure of clock
enablement and so on.

Thanks to Ronald Tschalär who did extensive debugging and testing of
this patch and contributed fixes.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=110901
Reported-by: Leif Liddy <leif.liddy@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Frédéric Danis <frederic.danis.oss@gmail.com>
Cc: Loic Poulain <loic.poulain@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Tested-by: Max Shavrick <mxms@me.com>                     [MacBook8,1]
Tested-by: Leif Liddy <leif.liddy@gmail.com>              [MacBook9,1]
Tested-by: Daniel Roschka <danielroschka@phoenitydawn.de> [MacBookPro13,2]
Tested-by: Ronald Tschalär <ronald@innovation.ch>        [MacBookPro13,3]
Tested-by: Peter Y. Chuang <peteryuchuang@gmail.com>      [MacBookPro14,1]
Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/bluetooth/hci_bcm.c | 101 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 82 insertions(+), 19 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 47fc58c9eb49..a1e59fc4acbc 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -29,6 +29,7 @@
 #include <linux/acpi.h>
 #include <linux/of.h>
 #include <linux/property.h>
+#include <linux/platform_data/x86/apple.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/gpio/consumer.h>
@@ -76,6 +77,9 @@ struct bcm_device {
 	struct hci_uart		*hu;
 	bool			is_suspended; /* suspend/resume flag */
 #endif
+#ifdef CONFIG_ACPI
+	acpi_handle		btlp, btpu, btpd;
+#endif
 };
 
 /* generic bcm uart resources */
@@ -168,8 +172,47 @@ static bool bcm_device_exists(struct bcm_device *device)
 	return false;
 }
 
+#ifdef CONFIG_ACPI
+static int bcm_apple_probe(struct bcm_device *dev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(dev->dev);
+	acpi_handle dev_handle = adev->handle;
+	const union acpi_object *obj;
+
+	if (!acpi_dev_get_property(adev, "baud", ACPI_TYPE_BUFFER, &obj) &&
+	    obj->buffer.length == 8)
+		dev->init_speed = *(u64 *)obj->buffer.pointer;
+
+	return ACPI_SUCCESS(acpi_get_handle(dev_handle, "BTLP", &dev->btlp)) &&
+	       ACPI_SUCCESS(acpi_get_handle(dev_handle, "BTPU", &dev->btpu)) &&
+	       ACPI_SUCCESS(acpi_get_handle(dev_handle, "BTPD", &dev->btpd))
+								 ? 0 : -ENODEV;
+}
+
+static int bcm_apple_set_power(struct bcm_device *dev, bool enable)
+{
+	return ACPI_SUCCESS(acpi_evaluate_object(enable ? dev->btpu : dev->btpd,
+						 NULL, NULL, NULL))
+								 ? 0 : -EFAULT;
+}
+
+static int bcm_apple_set_low_power(struct bcm_device *dev, bool enable)
+{
+	return ACPI_SUCCESS(acpi_execute_simple_method(dev->btlp, NULL, enable))
+								 ? 0 : -EFAULT;
+}
+#else
+static inline int bcm_apple_set_power(struct bcm_device *dev, bool powered)
+{ return -EINVAL; }
+static inline int bcm_apple_set_low_power(struct bcm_device *dev, bool enable)
+{ return -EINVAL; }
+#endif
+
 static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 {
+	if (x86_apple_machine)
+		return bcm_apple_set_power(dev, powered);
+
 	if (powered && !IS_ERR(dev->clk) && !dev->clk_enabled)
 		clk_prepare_enable(dev->clk);
 
@@ -184,6 +227,23 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 	return 0;
 }
 
+static int bcm_gpio_set_device_wake(struct bcm_device *dev, bool awake)
+{
+	int err = 0;
+
+	if (x86_apple_machine)
+		err = bcm_apple_set_low_power(dev, !awake);
+	else if (dev->device_wakeup)
+		gpiod_set_value(dev->device_wakeup, awake);
+	else
+		return 0;
+
+	bt_dev_dbg(dev, "%s, delaying 15 ms", awake ? "resume" : "suspend");
+	mdelay(15);
+
+	return err;
+}
+
 #ifdef CONFIG_PM
 static irqreturn_t bcm_host_wake(int irq, void *data)
 {
@@ -209,6 +269,15 @@ static int bcm_request_irq(struct bcm_data *bcm)
 		goto unlock;
 	}
 
+	/*
+	 * Macs wire the host wake pin to the System Management Controller,
+	 * which handles wakeup independently from the operating system.
+	 */
+	if (x86_apple_machine) {
+		err = 0;
+		goto unlock;
+	}
+
 	if (bdev->irq <= 0) {
 		err = -EOPNOTSUPP;
 		goto unlock;
@@ -223,12 +292,6 @@ static int bcm_request_irq(struct bcm_data *bcm)
 
 	device_init_wakeup(bdev->dev, true);
 
-	pm_runtime_set_autosuspend_delay(bdev->dev,
-					 BCM_AUTOSUSPEND_DELAY);
-	pm_runtime_use_autosuspend(bdev->dev);
-	pm_runtime_set_active(bdev->dev);
-	pm_runtime_enable(bdev->dev);
-
 unlock:
 	mutex_unlock(&bcm_device_lock);
 
@@ -379,7 +442,7 @@ static int bcm_close(struct hci_uart *hu)
 		pm_runtime_disable(bdev->dev);
 		pm_runtime_set_suspended(bdev->dev);
 
-		if (device_can_wakeup(bdev->dev)) {
+		if (bdev->irq > 0) {
 			devm_free_irq(bdev->dev, bdev->irq, bdev);
 			device_init_wakeup(bdev->dev, false);
 		}
@@ -470,6 +533,11 @@ static int bcm_setup(struct hci_uart *hu)
 	if (!bcm_request_irq(bcm))
 		err = bcm_setup_sleep(hu);
 
+	pm_runtime_set_autosuspend_delay(bcm->dev->dev, BCM_AUTOSUSPEND_DELAY);
+	pm_runtime_use_autosuspend(bcm->dev->dev);
+	pm_runtime_set_active(bcm->dev->dev);
+	pm_runtime_enable(bcm->dev->dev);
+
 	return err;
 }
 
@@ -577,11 +645,7 @@ static int bcm_suspend_device(struct device *dev)
 	}
 
 	/* Suspend the device */
-	if (bdev->device_wakeup) {
-		gpiod_set_value(bdev->device_wakeup, false);
-		bt_dev_dbg(bdev, "suspend, delaying 15 ms");
-		mdelay(15);
-	}
+	bcm_gpio_set_device_wake(bdev, false);
 
 	return 0;
 }
@@ -592,11 +656,7 @@ static int bcm_resume_device(struct device *dev)
 
 	bt_dev_dbg(bdev, "");
 
-	if (bdev->device_wakeup) {
-		gpiod_set_value(bdev->device_wakeup, true);
-		bt_dev_dbg(bdev, "resume, delaying 15 ms");
-		mdelay(15);
-	}
+	bcm_gpio_set_device_wake(bdev, true);
 
 	/* When this executes, the device has woken up already */
 	if (bdev->is_suspended && bdev->hu) {
@@ -632,7 +692,7 @@ static int bcm_suspend(struct device *dev)
 	if (pm_runtime_active(dev))
 		bcm_suspend_device(dev);
 
-	if (device_may_wakeup(dev)) {
+	if (device_may_wakeup(dev) && bdev->irq > 0) {
 		error = enable_irq_wake(bdev->irq);
 		if (!error)
 			bt_dev_dbg(bdev, "BCM irq: enabled");
@@ -662,7 +722,7 @@ static int bcm_resume(struct device *dev)
 	if (!bdev->hu)
 		goto unlock;
 
-	if (device_may_wakeup(dev)) {
+	if (device_may_wakeup(dev) && bdev->irq > 0) {
 		disable_irq_wake(bdev->irq);
 		bt_dev_dbg(bdev, "BCM irq: disabled");
 	}
@@ -816,6 +876,9 @@ static int bcm_acpi_probe(struct bcm_device *dev)
 	struct resource_entry *entry;
 	int ret;
 
+	if (x86_apple_machine)
+		return bcm_apple_probe(dev);
+
 	/* Retrieve GPIO data */
 	id = acpi_match_device(dev->dev->driver->acpi_match_table, dev->dev);
 	if (id)
-- 
2.15.1
