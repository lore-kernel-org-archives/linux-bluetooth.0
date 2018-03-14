Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis.oss@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH 4.16 REGRESSION fix 1/2] Revert "Bluetooth: hci_bcm: Streamline runtime PM code"
Date: Wed, 14 Mar 2018 23:06:02 +0100
Message-Id: <20180314220603.7559-2-hdegoede@redhat.com>
In-Reply-To: <20180314220603.7559-1-hdegoede@redhat.com>
References: <20180314220603.7559-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This reverts commit 43fff7683468 ("Bluetooth: hci_bcm: Streamline runtime
PM code"). The commit msg for this commit states "No functional change
intended.", but replacing:

 pm_runtime_get();
 pm_runtime_mark_last_busy();
 pm_runtime_put_autosuspend();

with:

 pm_request_resume();

Does result in a functional change, pm_request_resume() only calls
pm_runtime_mark_last_busy() if the device was suspended before the call.

This results in the following happening:

1) Device is runtime suspended
2) Device drives host_wake IRQ logically high as it starts receiving data
3) bcm_host_wake() gets called, causes the device to runtime-resume,
   current time gets marked as last_busy time
4) After 5 seconds the autosuspend timer expires and the dev autosuspends
   as no one has been calling pm_runtime_mark_last_busy(), the device was
   resumed during those 5 seconds, so all the pm_request_resume() calls
   while receiving data and/or bcm_host_wake() calls were nops
5) If 4) happens while the device has (just received) data in its buffer to
   be read by the host the IRQ line is *already* / still logically high
   when we autosuspend and since we use an edge triggered IRQ, the IRQ
   will never trigger, causing the device to get stuck in suspend

Therefor this commit has to be reverted, so that we avoid the device
getting stuck in suspend.

Cc: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/hci_bcm.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 59804a35488c..b089012a49f9 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -248,7 +248,9 @@ static irqreturn_t bcm_host_wake(int irq, void *data)
 
 	bt_dev_dbg(bdev, "Host wake IRQ");
 
-	pm_request_resume(bdev->dev);
+	pm_runtime_get(bdev->dev);
+	pm_runtime_mark_last_busy(bdev->dev);
+	pm_runtime_put_autosuspend(bdev->dev);
 
 	return IRQ_HANDLED;
 }
@@ -590,8 +592,11 @@ static int bcm_recv(struct hci_uart *hu, const void *data, int count)
 	} else if (!bcm->rx_skb) {
 		/* Delay auto-suspend when receiving completed packet */
 		mutex_lock(&bcm_device_lock);
-		if (bcm->dev && bcm_device_exists(bcm->dev))
-			pm_request_resume(bcm->dev->dev);
+		if (bcm->dev && bcm_device_exists(bcm->dev)) {
+			pm_runtime_get(bcm->dev->dev);
+			pm_runtime_mark_last_busy(bcm->dev->dev);
+			pm_runtime_put_autosuspend(bcm->dev->dev);
+		}
 		mutex_unlock(&bcm_device_lock);
 	}
 
-- 
2.14.3
