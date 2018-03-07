Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_bcm: Use default baud rate if missing shutdown GPIO
Date: Wed,  7 Mar 2018 22:39:03 +0100
Message-Id: <20180307213903.47583-1-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case the shutdown GPIO is not wired up, it is impossible to reset the
Bluetooth controller to its original state. This include the initial
default baud rate which leads to issues when reloading the module or
when something unexpected happens. To avoid any kind of runtime
deadlocks, stick with the initial default baud rate.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_bcm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 6035d68d8167..1b9bef24b7a2 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -1141,6 +1141,11 @@ static int bcm_serdev_probe(struct serdev_device *serdev)
 	if (err)
 		return err;
 
+	if (!bcmdev->shutdown) {
+		dev_warn(&serdev->dev, "No reset resource, using default baud rate\n");
+		bcmdev->oper_speed = bcmdev->init_speed;
+	}
+
 	err = bcm_gpio_set_power(bcmdev, false);
 	if (err)
 		dev_err(&serdev->dev, "Failed to power down\n");
-- 
2.14.3

