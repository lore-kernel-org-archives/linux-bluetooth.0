Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: hci_bcm: Don't change runtime-status when not using runtime-pm
Date: Mon, 19 Mar 2018 22:02:36 +0100
Message-Id: <20180319210237.26205-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The pm_runtime_set_suspended() call in bcm_close() is intended as a
counterpart to the pm_runtime_set_active() call from bcm_request_irq()
(which gets called from bcm_setup()).

The pm_runtime_set_active() call only happens if our pre-requisites for
doing runtime-pm are met. This commit adds the same check to the
pm_runtime_set_suspended() call to avoid the runtime-pm state getting
stuck in suspended after after a bcm_close().

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_bcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index eee33b0e4d67..06e2434c9b3d 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -464,7 +464,7 @@ static int bcm_close(struct hci_uart *hu)
 		err = bcm_gpio_set_power(bdev, false);
 		if (err)
 			bt_dev_err(hu->hdev, "Failed to power down");
-		else
+		else if (IS_ENABLED(CONFIG_PM) && bdev->irq > 0)
 			pm_runtime_set_suspended(bdev->dev);
 	}
 	mutex_unlock(&bcm_device_lock);
-- 
2.14.3
