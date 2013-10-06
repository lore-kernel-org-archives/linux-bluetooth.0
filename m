Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Reject enabling controllers without valid addresses
Date: Sun,  6 Oct 2013 01:08:57 -0700
Message-Id: <1381046938-34970-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case of a single mode LE-only controller it is possible that no
public address is used. These type of controllers require a random
address to be configured.

Without a configured static random address, such a controller is
not functional. So reject powering on the controller in this case
until it gets configured with a random address.

The controller setup stage is still run since it is the only way
to determinate if a public address is available or not. So it is
similar on how RFKILL gets handled during initial setup of the
controller.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 43 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a8bb9fd..86c022c 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1196,13 +1196,29 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 		goto done;
 	}
 
-	/* Check for rfkill but allow the HCI setup stage to proceed
-	 * (which in itself doesn't cause any RF activity).
-	 */
-	if (test_bit(HCI_RFKILLED, &hdev->dev_flags) &&
-	    !test_bit(HCI_SETUP, &hdev->dev_flags)) {
-		ret = -ERFKILL;
-		goto done;
+	if (!test_bit(HCI_SETUP, &hdev->dev_flags)) {
+		/* Check for rfkill but allow the HCI setup stage to
+		 * proceed (which in itself doesn't cause any RF activity).
+		 */
+		if (test_bit(HCI_RFKILLED, &hdev->dev_flags)) {
+			ret = -ERFKILL;
+			goto done;
+		}
+
+		/* Check for valid public address or a configured static
+		 * random adddress, but let the HCI setup proceed to
+		 * be able to determine if there is a public address
+		 * or not.
+		 *
+		 * This check is only valid for BR/EDR controllers
+		 * since AMP controllers do not have an address.
+		 */
+		if (hdev->dev_type == HCI_BREDR &&
+		    !bacmp(&hdev->bdaddr, BDADDR_ANY) &&
+		    !bacmp(&hdev->static_addr, BDADDR_ANY)) {
+			ret = -EADDRNOTAVAIL;
+			goto done;
+		}
 	}
 
 	if (test_bit(HCI_UP, &hdev->flags)) {
@@ -1288,6 +1304,10 @@ int hci_dev_open(__u16 dev)
 	if (test_and_clear_bit(HCI_AUTO_OFF, &hdev->dev_flags))
 		cancel_delayed_work(&hdev->power_off);
 
+	/* After this call it is guaranteed that the setup procedure
+	 * has finished. This means that error conditions like RFKILL
+	 * or no valid public or static random address apply.
+	 */
 	flush_workqueue(hdev->req_workqueue);
 
 	err = hci_dev_do_open(hdev);
@@ -1703,7 +1723,14 @@ static void hci_power_on(struct work_struct *work)
 		return;
 	}
 
-	if (test_bit(HCI_RFKILLED, &hdev->dev_flags)) {
+	/* During the HCI setup phase, a few error conditions are
+	 * ignored and they need to be checked now. If they are still
+	 * valid, it is important to turn the device back off.
+	 */
+	if (test_bit(HCI_RFKILLED, &hdev->dev_flags) ||
+	    (hdev->dev_type == HCI_BREDR &&
+	     !bacmp(&hdev->bdaddr, BDADDR_ANY) &&
+	     !bacmp(&hdev->static_addr, BDADDR_ANY))) {
 		clear_bit(HCI_AUTO_OFF, &hdev->dev_flags);
 		hci_dev_do_close(hdev);
 	} else if (test_bit(HCI_AUTO_OFF, &hdev->dev_flags)) {
-- 
1.8.3.1

