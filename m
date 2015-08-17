Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org, johan.hedberg@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH] Bluetooth: hci_bcm: Use non-sleep version of gpio_set_value
Date: Mon, 17 Aug 2015 16:00:21 +0200
Message-Id: <1439820021-24802-1-git-send-email-loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We should not sleep while holding a spinlock.
bcm_gpio_set_power is called while holding the bcm_device_list lock.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 drivers/bluetooth/hci_bcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 322302b..33ec097 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -138,8 +138,8 @@ static int bcm_gpio_set_power(struct bcm_device *dev, bool powered)
 	if (powered && !IS_ERR(dev->clk) && !dev->clk_enabled)
 		clk_enable(dev->clk);
 
-	gpiod_set_value_cansleep(dev->shutdown, powered);
-	gpiod_set_value_cansleep(dev->device_wakeup, powered);
+	gpiod_set_value(dev->shutdown, powered);
+	gpiod_set_value(dev->device_wakeup, powered);
 
 	if (!powered && !IS_ERR(dev->clk) && dev->clk_enabled)
 		clk_disable(dev->clk);
-- 
1.9.1

