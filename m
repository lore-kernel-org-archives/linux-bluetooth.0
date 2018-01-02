Return-Path: <lukas@wunner.de>
Message-Id: <5f656f915ada50079fd5606ee591e59239ab6a2b.1514916630.git.lukas@wunner.de>
In-Reply-To: <cover.1514916630.git.lukas@wunner.de>
References: <cover.1514916630.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 2 Jan 2018 20:08:40 +0100
Subject: [PATCH v2 05/10] Bluetooth: hci_bcm: Add helper to toggle device wake
 GPIO
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Frederic Danis <frederic.danis.oss@gmail.com>, Loic Poulain <loic.poulain@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Max Shavrick <mxms@me.com>, Leif Liddy <leif.liddy@gmail.com>, Daniel Roschka <danielroschka@phoenitydawn.de>, Ronald Tschalaer <ronald@innovation.ch>, "Peter Y. Chuang" <peteryuchuang@gmail.com>, linux-bluetooth@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is already a bcm_gpio_set_power() helper to toggle the power
enable pin.  Add a corresponding helper to toggle the device wake pin.
This will allow us to more easily integrate support for MacBooks which
use custom ACPI methods to access both pins.

The only functional change here is an additional 15 ms delay when
toggling the device wake pin in bcm_gpio_set_power().  It is unclear why
this delay is observed in bcm_suspend_device() and bcm_resume_device(),
but not in bcm_gpio_set_power() so far.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
Changes since v1:
  I had previously forgotten to toggle the device wake
  GPIO in bcm_gpio_set_power() on Macs, this is now fixed.

 drivers/bluetooth/hci_bcm.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index dbba08fd05a3..01d0943b7bbb 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -168,13 +168,25 @@ static bool bcm_device_exists(struct bcm_device *device)
 	return false;
 }
 
+static int bcm_gpio_set_device_wakeup(struct bcm_device *dev, bool awake)
+{
+	int err = 0;
+
+	gpiod_set_value(dev->device_wakeup, awake);
+	bt_dev_dbg(dev, "%s, delaying 15 ms", awake ? "resume" : "suspend");
+	mdelay(15);
+
+	return err;
+}
+
 static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 {
 	if (powered && !IS_ERR(dev->clk) && !dev->clk_enabled)
 		clk_prepare_enable(dev->clk);
 
 	gpiod_set_value(dev->shutdown, powered);
-	gpiod_set_value(dev->device_wakeup, powered);
+
+	bcm_gpio_set_device_wakeup(dev, powered);
 
 	if (!powered && !IS_ERR(dev->clk) && dev->clk_enabled)
 		clk_disable_unprepare(dev->clk);
@@ -571,9 +583,7 @@ static int bcm_suspend_device(struct device *dev)
 	}
 
 	/* Suspend the device */
-	gpiod_set_value(bdev->device_wakeup, false);
-	bt_dev_dbg(bdev, "suspend, delaying 15 ms");
-	mdelay(15);
+	bcm_gpio_set_device_wakeup(bdev, false);
 
 	return 0;
 }
@@ -584,9 +594,7 @@ static int bcm_resume_device(struct device *dev)
 
 	bt_dev_dbg(bdev, "");
 
-	gpiod_set_value(bdev->device_wakeup, true);
-	bt_dev_dbg(bdev, "resume, delaying 15 ms");
-	mdelay(15);
+	bcm_gpio_set_device_wakeup(bdev, true);
 
 	/* When this executes, the device has woken up already */
 	if (bdev->is_suspended && bdev->hu) {
-- 
2.15.1
