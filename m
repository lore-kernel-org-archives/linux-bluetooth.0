Return-Path: <lukas@wunner.de>
Message-Id: <8c3c2c93ffac1b0f499ef418dca1c705aeac75b8.1515593773.git.lukas@wunner.de>
In-Reply-To: <cover.1515593773.git.lukas@wunner.de>
References: <cover.1515593773.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 10 Jan 2018 16:32:10 +0100
Subject: [PATCH v4 05/13] Bluetooth: hci_bcm: Fix unbalanced
 pm_runtime_disable()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Frederic Danis <frederic.danis.oss@gmail.com>, Loic Poulain <loic.poulain@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Max Shavrick <mxms@me.com>, Leif Liddy <leif.liddy@gmail.com>, Daniel Roschka <danielroschka@phoenitydawn.de>, Ronald Tschalaer <ronald@innovation.ch>, "Peter Y. Chuang" <peteryuchuang@gmail.com>, linux-bluetooth@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On ->setup, pm_runtime_enable() is only called if a valid IRQ was found,
but on ->close(), pm_runtime_disable() is called unconditionally.
Disablement of runtime PM is recorded in a counter, so every
pm_runtime_disable() needs to be balanced.  Fix it.

Cc: Frédéric Danis <frederic.danis.oss@gmail.com>
Reported-and-reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/bluetooth/hci_bcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 6144a3f9c37a..140c7e5bf812 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -375,10 +375,10 @@ static int bcm_close(struct hci_uart *hu)
 		if (IS_ENABLED(CONFIG_PM) && bdev->irq > 0) {
 			devm_free_irq(bdev->dev, bdev->irq, bdev);
 			device_init_wakeup(bdev->dev, false);
+			pm_runtime_disable(bdev->dev);
 		}
 
 		bcm_gpio_set_power(bdev, false);
-		pm_runtime_disable(bdev->dev);
 		pm_runtime_set_suspended(bdev->dev);
 	}
 	mutex_unlock(&bcm_device_lock);
-- 
2.15.1
