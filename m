Return-Path: <lukas@wunner.de>
Message-Id: <36e7c22493235863c2ab9dd9d7aa382a3fc15675.1514916630.git.lukas@wunner.de>
In-Reply-To: <cover.1514916630.git.lukas@wunner.de>
References: <cover.1514916630.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 2 Jan 2018 20:08:40 +0100
Subject: [PATCH v2 03/10] Bluetooth: hci_bcm: Enable runtime PM despite
 absence of IRQ
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Frederic Danis <frederic.danis.oss@gmail.com>, Loic Poulain <loic.poulain@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Max Shavrick <mxms@me.com>, Leif Liddy <leif.liddy@gmail.com>, Daniel Roschka <danielroschka@phoenitydawn.de>, Ronald Tschalaer <ronald@innovation.ch>, "Peter Y. Chuang" <peteryuchuang@gmail.com>, linux-bluetooth@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently runtime PM is only enabled if a valid host wake IRQ was found.

However it is used in ways which seem unrelated to host wake:
E.g., runtime PM is used to force the Bluetooth device on for 5 sec
after a complete packet has been received.

Afford this functionality to devices which lack an IRQ by moving the
code to enable runtime PM from bcm_request_irq() to bcm_setup().

Cc: Frédéric Danis <frederic.danis.oss@gmail.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/bluetooth/hci_bcm.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 4294d9df1d4d..d9ca27d3209a 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -221,12 +221,6 @@ static int bcm_request_irq(struct bcm_data *bcm)
 
 	device_init_wakeup(bdev->dev, true);
 
-	pm_runtime_set_autosuspend_delay(bdev->dev,
-					 BCM_AUTOSUSPEND_DELAY);
-	pm_runtime_use_autosuspend(bdev->dev);
-	pm_runtime_set_active(bdev->dev);
-	pm_runtime_enable(bdev->dev);
-
 unlock:
 	mutex_unlock(&bcm_device_lock);
 
@@ -468,6 +462,11 @@ static int bcm_setup(struct hci_uart *hu)
 	if (!bcm_request_irq(bcm))
 		err = bcm_setup_sleep(hu);
 
+	pm_runtime_set_autosuspend_delay(bcm->dev->dev, BCM_AUTOSUSPEND_DELAY);
+	pm_runtime_use_autosuspend(bcm->dev->dev);
+	pm_runtime_set_active(bcm->dev->dev);
+	pm_runtime_enable(bcm->dev->dev);
+
 	return err;
 }
 
-- 
2.15.1
