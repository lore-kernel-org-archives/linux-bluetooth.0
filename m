Return-Path: <cyrus@holtmann.org>
From: Loic Poulain <loic.poulain@intel.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, gaetan.prin@intel.com,
	Loic Poulain <loic.poulain@intel.com>
Subject: [PATCH 2/5] Bluetooth: hci_intel: Add intel_device_get function
Date: Thu, 27 Aug 2015 17:39:03 +0200
Message-Id: <1440689946-13576-2-git-send-email-loic.poulain@intel.com>
In-Reply-To: <1440689946-13576-1-git-send-email-loic.poulain@intel.com>
References: <1440689946-13576-1-git-send-email-loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Move intel_device searching procedure in a standalone function since it
will be used from different places in the driver.

Signed-off-by: Loic Poulain <loic.poulain@intel.com>
---
 drivers/bluetooth/hci_intel.c | 49 +++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 18 deletions(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index 934b5a7..26a1314 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -93,6 +93,24 @@ static u8 intel_convert_speed(unsigned int speed)
 	}
 }
 
+static struct intel_device *intel_device_get(struct hci_uart *hu)
+{
+	struct list_head *p;
+
+	list_for_each(p, &intel_device_list) {
+		struct intel_device *idev = list_entry(p, struct intel_device,
+						       list);
+
+		/* tty device and pdev device should share the same parent
+		 * which is the UART port.
+		 */
+		if (hu->tty->dev->parent == idev->pdev->dev.parent)
+			return idev;
+	}
+
+	return NULL;
+}
+
 static int intel_wait_booting(struct hci_uart *hu)
 {
 	struct intel_data *intel = hu->priv;
@@ -117,32 +135,27 @@ static int intel_wait_booting(struct hci_uart *hu)
 
 static int intel_set_power(struct hci_uart *hu, bool powered)
 {
-	struct list_head *p;
-	int err = -ENODEV;
+	struct intel_device *idev;
+	int err = 0;
 
 	spin_lock(&intel_device_list_lock);
 
-	list_for_each(p, &intel_device_list) {
-		struct intel_device *idev = list_entry(p, struct intel_device,
-						       list);
-
-		/* tty device and pdev device should share the same parent
-		 * which is the UART port.
-		 */
-		if (hu->tty->dev->parent != idev->pdev->dev.parent)
-			continue;
+	idev = intel_device_get(hu);
+	if (!idev)
+		err = -ENODEV;
+		goto done;
 
-		if (!idev->reset) {
-			err = -ENOTSUPP;
-			break;
-		}
+	if (!idev->reset) {
+		err = -ENOTSUPP;
+		goto done;
+	}
 
-		BT_INFO("hu %p, Switching compatible pm device (%s) to %u",
+	BT_INFO("hu %p, Switching compatible pm device (%s) to %u",
 			hu, dev_name(&idev->pdev->dev), powered);
 
-		gpiod_set_value(idev->reset, powered);
-	}
+	gpiod_set_value(idev->reset, powered);
 
+done:
 	spin_unlock(&intel_device_list_lock);
 
 	return err;
-- 
1.9.1

