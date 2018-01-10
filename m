Return-Path: <lukas@wunner.de>
Message-Id: <ed921ccd9c29de011669c68c9edc5a53e803e344.1515593773.git.lukas@wunner.de>
In-Reply-To: <cover.1515593773.git.lukas@wunner.de>
References: <cover.1515593773.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 10 Jan 2018 16:32:10 +0100
Subject: [PATCH v4 04/13] Bluetooth: hci_bcm: Fix race on close
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Frederic Danis <frederic.danis.oss@gmail.com>, Loic Poulain <loic.poulain@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Max Shavrick <mxms@me.com>, Leif Liddy <leif.liddy@gmail.com>, Daniel Roschka <danielroschka@phoenitydawn.de>, Ronald Tschalaer <ronald@innovation.ch>, "Peter Y. Chuang" <peteryuchuang@gmail.com>, linux-bluetooth@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Upon ->close, the driver powers the Bluetooth controller down, deasserts
the device wake pin, updates the runtime PM status to "suspended" and
finally frees the IRQ.

Because the IRQ is freed last, a runtime resume can take place after
the controller was powered down.  The impact is not grave, the worst
thing that can happen is that the device wake pin is reasserted (should
have no effect while the regulator is off) and that setting the runtime
PM status to "suspended" does not reflect reality.

Still, it's wrong, so free the IRQ first.

Cc: Frédéric Danis <frederic.danis.oss@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/bluetooth/hci_bcm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index c551ef4c350f..6144a3f9c37a 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -372,14 +372,14 @@ static int bcm_close(struct hci_uart *hu)
 	}
 
 	if (bdev) {
-		bcm_gpio_set_power(bdev, false);
-		pm_runtime_disable(bdev->dev);
-		pm_runtime_set_suspended(bdev->dev);
-
 		if (IS_ENABLED(CONFIG_PM) && bdev->irq > 0) {
 			devm_free_irq(bdev->dev, bdev->irq, bdev);
 			device_init_wakeup(bdev->dev, false);
 		}
+
+		bcm_gpio_set_power(bdev, false);
+		pm_runtime_disable(bdev->dev);
+		pm_runtime_set_suspended(bdev->dev);
 	}
 	mutex_unlock(&bcm_device_lock);
 
-- 
2.15.1
