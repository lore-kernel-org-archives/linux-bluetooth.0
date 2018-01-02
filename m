Return-Path: <lukas@wunner.de>
Message-Id: <b35b7b87a6a1c5acabab3a4814476a1ca79cdd1f.1514916630.git.lukas@wunner.de>
In-Reply-To: <cover.1514916630.git.lukas@wunner.de>
References: <cover.1514916630.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 2 Jan 2018 20:08:40 +0100
Subject: [PATCH v2 07/10] Bluetooth: hci_bcm: Clean up unnecessary #ifdef
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Frederic Danis <frederic.danis.oss@gmail.com>, Loic Poulain <loic.poulain@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Max Shavrick <mxms@me.com>, Leif Liddy <leif.liddy@gmail.com>, Daniel Roschka <danielroschka@phoenitydawn.de>, Ronald Tschalaer <ronald@innovation.ch>, "Peter Y. Chuang" <peteryuchuang@gmail.com>, linux-bluetooth@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

pm_runtime_disable() and pm_runtime_set_suspended() are replaced with
empty inlines if CONFIG_PM is disabled, so there's no need to #ifdef
them.

device_init_wakeup() is likewise replaced with an inline, though it's
not empty, but it and devm_free_irq() can be made conditional on
IS_ENABLED(CONFIG_PM), which is preferable to #ifdef as per section 20
of Documentation/process/coding-style.rst.

Cc: Frédéric Danis <frederic.danis.oss@gmail.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/bluetooth/hci_bcm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 632939d413df..dbf9d10dadf1 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -379,15 +379,13 @@ static int bcm_close(struct hci_uart *hu)
 
 	if (bdev) {
 		bcm_gpio_set_power(bdev, false);
-#ifdef CONFIG_PM
 		pm_runtime_disable(bdev->dev);
 		pm_runtime_set_suspended(bdev->dev);
 
-		if (bdev->irq > 0) {
+		if (IS_ENABLED(CONFIG_PM) && bdev->irq > 0) {
 			devm_free_irq(bdev->dev, bdev->irq, bdev);
 			device_init_wakeup(bdev->dev, false);
 		}
-#endif
 	}
 	mutex_unlock(&bcm_device_lock);
 
-- 
2.15.1
