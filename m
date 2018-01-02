Return-Path: <lukas@wunner.de>
Message-Id: <326876dfe41874a7346339a3f6d0c54f25dceee5.1514916630.git.lukas@wunner.de>
In-Reply-To: <cover.1514916630.git.lukas@wunner.de>
References: <cover.1514916630.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 2 Jan 2018 20:08:40 +0100
Subject: [PATCH v2 02/10] Bluetooth: hci_bcm: Mandate presence of shutdown and
 device wake GPIO
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Frederic Danis <frederic.danis.oss@gmail.com>, Loic Poulain <loic.poulain@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Max Shavrick <mxms@me.com>, Leif Liddy <leif.liddy@gmail.com>, Daniel Roschka <danielroschka@phoenitydawn.de>, Ronald Tschalaer <ronald@innovation.ch>, "Peter Y. Chuang" <peteryuchuang@gmail.com>, linux-bluetooth@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
List-ID: <linux-bluetooth.vger.kernel.org>

Commit 0395ffc1ee05 ("Bluetooth: hci_bcm: Add PM for BCM devices")
amended this driver to request a shutdown and device wake GPIO on probe,
but mandated that only one of them need to be present:

	/* Make sure at-least one of the GPIO is defined and that
	 * a name is specified for this instance
	 */
	if ((!dev->device_wakeup && !dev->shutdown) || !dev->name) {
		dev_err(&pdev->dev, "invalid platform data\n");
		return -EINVAL;
	}

However the same commit added a call to bcm_gpio_set_power() to the
->probe hook, which unconditionally accesses *both* GPIOs.  Luckily,
the resulting NULL pointer deref was never reported, suggesting there's
no machine where either GPIO is missing.

Commit 8a92056837fd ("Bluetooth: hci_bcm: Add (runtime)pm support to the
serdev driver") removed the check whether at least one of the GPIOs is
present without specifying a reason.

Because commit 62aaefa7d038 ("Bluetooth: hci_bcm: improve use of gpios
API") refactored the driver to use devm_gpiod_get_optional() instead of
devm_gpiod_get(), one is now tempted to believe that the driver doesn't
require *any* of the two GPIOs.

Which is wrong, the driver still requires both GPIOs to avoid a NULL
pointer deref.  To this end, establish the status quo ante and request
the GPIOs with devm_gpiod_get() again.  Bail out of ->probe if either
of them is missing.

Oddly enough, whereas bcm_gpio_set_power() accesses the device wake pin
unconditionally, bcm_suspend_device() and bcm_resume_device() do check
for its presence before accessing it.  Those checks are superfluous,
so remove them.

Cc: Frédéric Danis <frederic.danis.oss@gmail.com>
Cc: Loic Poulain <loic.poulain@linaro.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/bluetooth/hci_bcm.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 1fc604a0d870..4294d9df1d4d 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -572,11 +572,9 @@ static int bcm_suspend_device(struct device *dev)
 	}
 
 	/* Suspend the device */
-	if (bdev->device_wakeup) {
-		gpiod_set_value(bdev->device_wakeup, false);
-		bt_dev_dbg(bdev, "suspend, delaying 15 ms");
-		mdelay(15);
-	}
+	gpiod_set_value(bdev->device_wakeup, false);
+	bt_dev_dbg(bdev, "suspend, delaying 15 ms");
+	mdelay(15);
 
 	return 0;
 }
@@ -587,11 +585,9 @@ static int bcm_resume_device(struct device *dev)
 
 	bt_dev_dbg(bdev, "");
 
-	if (bdev->device_wakeup) {
-		gpiod_set_value(bdev->device_wakeup, true);
-		bt_dev_dbg(bdev, "resume, delaying 15 ms");
-		mdelay(15);
-	}
+	gpiod_set_value(bdev->device_wakeup, true);
+	bt_dev_dbg(bdev, "resume, delaying 15 ms");
+	mdelay(15);
 
 	/* When this executes, the device has woken up already */
 	if (bdev->is_suspended && bdev->hu) {
@@ -774,14 +770,12 @@ static int bcm_get_resources(struct bcm_device *dev)
 
 	dev->clk = devm_clk_get(dev->dev, NULL);
 
-	dev->device_wakeup = devm_gpiod_get_optional(dev->dev,
-						     "device-wakeup",
-						     GPIOD_OUT_LOW);
+	dev->device_wakeup = devm_gpiod_get(dev->dev, "device-wakeup",
+							     GPIOD_OUT_LOW);
 	if (IS_ERR(dev->device_wakeup))
 		return PTR_ERR(dev->device_wakeup);
 
-	dev->shutdown = devm_gpiod_get_optional(dev->dev, "shutdown",
-						GPIOD_OUT_LOW);
+	dev->shutdown = devm_gpiod_get(dev->dev, "shutdown", GPIOD_OUT_LOW);
 	if (IS_ERR(dev->shutdown))
 		return PTR_ERR(dev->shutdown);
 
-- 
2.15.1
