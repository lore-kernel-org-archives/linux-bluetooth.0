Return-Path: <RHowell@uwyo.edu>
Date: Thu, 15 Mar 2018 00:46:38 -0600
From: ""Robert R. Howell"" <rhowell@uwyo.edu>
To: Johan Hedberg <johann.hedberg@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>
Cc: Lukas Wunner <lukas@wunner.de>, linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_bcm: Keep runtime resumed on packet
 reception
Message-ID: <5aaa16ce.CK8bS3NwS1NCw4vD%rhowell@uwyo.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

From: Robert R. Howell <rhowell@uwyo.edu>

Commit 43fff7683468 ("Bluetooth: hci_bcm: Streamline runtime PM code")
broke runtime PM on Baytrail machines such as the ASUS T100 and perhaps
other devices because the call to pm_request_resume() became a no-op
if the device was already runtime resumed.  The purpose of the code it
replaced appears to have been to keep the device awake for another
5 seconds on receipt of a full packet.  Reinstate that behavior.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=198953
Fixes: 43fff7683468 ("Bluetooth: hci_bcm: Streamline runtime PM code")
Signed-off-by: Robert R. Howell <rhowell@uwyo.edu>
---
 drivers/bluetooth/hci_bcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 6314dfb02969..3633710080b1 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -587,7 +587,7 @@ static int bcm_recv(struct hci_uart *hu, const void *data, int count)
 		/* Delay auto-suspend when receiving completed packet */
 		mutex_lock(&bcm_device_lock);
 		if (bcm->dev && bcm_device_exists(bcm->dev))
-			pm_request_resume(bcm->dev->dev);
+			pm_runtime_mark_last_busy(bcm->dev->dev);
 		mutex_unlock(&bcm_device_lock);
 	}
 
-- 
2.13.6
