Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Make mgmt power down notification for BR/EDR explicit
Date: Mon,  7 Oct 2013 00:26:06 -0700
Message-Id: <1381130767-42488-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The management interface only operates on BR/EDR controllers. The check
for the power down notification is a bit intermixed with the check if
controller auto power off is active. Since there are more than just
BR/EDR controllers supported, make this check explicit since the auto
power off check also applies to AMP controllers and it has to happen
in this exact order. Otherwise the bit will not be cleared.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2ee5a8e..3572611 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1393,11 +1393,12 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	hdev->flags = 0;
 	hdev->dev_flags &= ~HCI_PERSISTENT_MASK;
 
-	if (!test_and_clear_bit(HCI_AUTO_OFF, &hdev->dev_flags) &&
-	    hdev->dev_type == HCI_BREDR) {
-		hci_dev_lock(hdev);
-		mgmt_powered(hdev, 0);
-		hci_dev_unlock(hdev);
+	if (!test_and_clear_bit(HCI_AUTO_OFF, &hdev->dev_flags)) {
+		if (hdev->dev_type == HCI_BREDR) {
+			hci_dev_lock(hdev);
+			mgmt_powered(hdev, 0);
+			hci_dev_unlock(hdev);
+		}
 	}
 
 	/* Controller radio is available but is currently powered down */
-- 
1.8.3.1

