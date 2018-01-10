Return-Path: <lukas@wunner.de>
Message-Id: <7b95858f1faf3af9c6f4c02a86bb1f1eec1c6024.1515593773.git.lukas@wunner.de>
In-Reply-To: <cover.1515593773.git.lukas@wunner.de>
References: <cover.1515593773.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 10 Jan 2018 16:32:10 +0100
Subject: [PATCH v4 06/13] Bluetooth: hci_bcm: Invalidate IRQ on request
 failure
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Frederic Danis <frederic.danis.oss@gmail.com>, Loic Poulain <loic.poulain@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Max Shavrick <mxms@me.com>, Leif Liddy <leif.liddy@gmail.com>, Daniel Roschka <danielroschka@phoenitydawn.de>, Ronald Tschalaer <ronald@innovation.ch>, "Peter Y. Chuang" <peteryuchuang@gmail.com>, linux-bluetooth@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If devm_request_irq() fails, the driver bails out of bcm_request_irq()
but continues to ->setup the device (because the IRQ is optional).

The driver subsequently calls devm_free_irq(), enable_irq_wake() and
disable_irq_wake() on the IRQ even though requesting it failed.

Avoid by invalidating the IRQ on request failure.

Cc: Frédéric Danis <frederic.danis.oss@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/bluetooth/hci_bcm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 140c7e5bf812..c893c597fead 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -216,8 +216,10 @@ static int bcm_request_irq(struct bcm_data *bcm)
 			       bdev->irq_active_low ? IRQF_TRIGGER_FALLING :
 						      IRQF_TRIGGER_RISING,
 			       "host_wake", bdev);
-	if (err)
+	if (err) {
+		bdev->irq = err;
 		goto unlock;
+	}
 
 	device_init_wakeup(bdev->dev, true);
 
-- 
2.15.1
