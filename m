Return-Path: <loic.poulain@gmail.com>
From: Loic Poulain <loic.poulain@gmail.com>
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	Loic Poulain <loic.poulain@gmail.com>
Subject: [PATCH] Bluetooth: hci_intel: Remove LPM enabling from setup procedure
Date: Mon, 11 Jul 2016 21:55:36 +0200
Message-Id: <1468266936-28418-1-git-send-email-loic.poulain@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

LPM can be enabled via a DDC write command at specific DDC ID.
As any other DDC value, this is up to the DDC config file to
include (or not) the low power mode configuration.

Signed-off-by: Loic Poulain <loic.poulain@gmail.com>
---
 drivers/bluetooth/hci_intel.c | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
index f6f2b01..ed0a420 100644
--- a/drivers/bluetooth/hci_intel.c
+++ b/drivers/bluetooth/hci_intel.c
@@ -537,9 +537,7 @@ static int intel_setup(struct hci_uart *hu)
 {
 	static const u8 reset_param[] = { 0x00, 0x01, 0x00, 0x01,
 					  0x00, 0x08, 0x04, 0x00 };
-	static const u8 lpm_param[] = { 0x03, 0x07, 0x01, 0x0b };
 	struct intel_data *intel = hu->priv;
-	struct intel_device *idev = NULL;
 	struct hci_dev *hdev = hu->hdev;
 	struct sk_buff *skb;
 	struct intel_version ver;
@@ -884,35 +882,23 @@ done:
 
 	bt_dev_info(hdev, "Device booted in %llu usecs", duration);
 
-	/* Enable LPM if matching pdev with wakeup enabled */
+	/* Enable LPM if matching pdev with wakeup enabled, set TX active
+	 * until further LPM TX notification.
+	 */
 	mutex_lock(&intel_device_list_lock);
 	list_for_each(p, &intel_device_list) {
 		struct intel_device *dev = list_entry(p, struct intel_device,
 						      list);
 		if (hu->tty->dev->parent == dev->pdev->dev.parent) {
-			if (device_may_wakeup(&dev->pdev->dev))
-				idev = dev;
+			if (device_may_wakeup(&dev->pdev->dev)) {
+				set_bit(STATE_LPM_ENABLED, &intel->flags);
+				set_bit(STATE_TX_ACTIVE, &intel->flags);
+			}
 			break;
 		}
 	}
 	mutex_unlock(&intel_device_list_lock);
 
-	if (!idev)
-		goto no_lpm;
-
-	bt_dev_info(hdev, "Enabling LPM");
-
-	skb = __hci_cmd_sync(hdev, 0xfc8b, sizeof(lpm_param), lpm_param,
-			     HCI_CMD_TIMEOUT);
-	if (IS_ERR(skb)) {
-		bt_dev_err(hdev, "Failed to enable LPM");
-		goto no_lpm;
-	}
-	kfree_skb(skb);
-
-	set_bit(STATE_LPM_ENABLED, &intel->flags);
-
-no_lpm:
 	/* Ignore errors, device can work without DDC parameters */
 	btintel_load_ddc_config(hdev, fwname);
 
-- 
1.9.1
