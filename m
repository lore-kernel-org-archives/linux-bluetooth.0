Return-Path: <loic.poulain@linaro.org>
From: Loic Poulain <loic.poulain@linaro.org>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	stefan.wahren@i2se.com,
	Loic Poulain <loic.poulain@linaro.org>
Subject: [PATCH] Bluetooth: hci_bcm: use gpiod cansleep version
Date: Mon,  5 Mar 2018 19:02:35 +0100
Message-Id: <1520272955-5023-1-git-send-email-loic.poulain@linaro.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Some GPIO controller drivers request sleepable context and so can't
be accessed from IRQ context. Using gpiod_set/get_value accessors
with such controller leads to a kernel warning since they are
reserved for atomic context (according to the documentation).

Use the postfixed _cansleep version instead, indicating that context
is safe for sleeping if necessary. Note that this is the case here
since we never toggle the gpio neither from IRQ nor from a spinlocked
section.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/bluetooth/hci_bcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 0438a64..bb5b006 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -903,13 +903,13 @@ static inline int bcm_apple_get_resources(struct bcm_device *dev)
 
 static int bcm_gpio_set_device_wakeup(struct bcm_device *dev, bool awake)
 {
-	gpiod_set_value(dev->device_wakeup, awake);
+	gpiod_set_value_cansleep(dev->device_wakeup, awake);
 	return 0;
 }
 
 static int bcm_gpio_set_shutdown(struct bcm_device *dev, bool powered)
 {
-	gpiod_set_value(dev->shutdown, powered);
+	gpiod_set_value_cansleep(dev->shutdown, powered);
 	return 0;
 }
 
-- 
2.7.4
