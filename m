Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 2/2] Bluetooth: Fix rfkill functionality during the HCI setup stage
Date: Fri, 13 Sep 2013 08:58:18 +0300
Message-Id: <1379051898-2630-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1379051898-2630-1-git-send-email-johan.hedberg@gmail.com>
References: <1379051898-2630-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We need to let the setup stage complete cleanly even when the HCI device
is rfkilled. Otherwise the HCI device will stay in an undefined state
and never get notified to user space through mgmt (even when it gets
unblocked through rfkill).

This patch makes sure that hci_dev_open() can be called in the HCI_SETUP
stage, that blocking the device doesn't abort the setup stage, and that
the device gets proper powered down as soon as the setup stage completes
in case it was blocked meanwhile.

The bug that this patch fixed can be very easily reproduced using e.g.
the rfkill command line too. By running "rfkill block all" before
inserting a Bluetooth dongle the resulting HCI device goes into a state
where it is never announced over mgmt, not even when "rfkill unblock all"
is run.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Cc: stable@vger.kernel.org
---
v3: Use "else if" instead of separate if-statement

 net/bluetooth/hci_core.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d0d6cf8..12b017d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1148,7 +1148,11 @@ int hci_dev_open(__u16 dev)
 		goto done;
 	}
 
-	if (test_bit(HCI_RFKILLED, &hdev->dev_flags)) {
+	/* Check for rfkill but allow the HCI setup stage to proceed
+	 * (which in itself doesn't cause any RF activity).
+	 */
+	if (test_bit(HCI_RFKILLED, &hdev->dev_flags) &&
+	    !test_bit(HCI_SETUP, &hdev->dev_flags)) {
 		ret = -ERFKILL;
 		goto done;
 	}
@@ -1599,7 +1603,8 @@ static int hci_rfkill_set_block(void *data, bool blocked)
 
 	if (blocked) {
 		set_bit(HCI_RFKILLED, &hdev->dev_flags);
-		hci_dev_do_close(hdev);
+		if (!test_bit(HCI_SETUP, &hdev->dev_flags))
+			hci_dev_do_close(hdev);
 	} else {
 		clear_bit(HCI_RFKILLED, &hdev->dev_flags);
 	}
@@ -1624,9 +1629,13 @@ static void hci_power_on(struct work_struct *work)
 		return;
 	}
 
-	if (test_bit(HCI_AUTO_OFF, &hdev->dev_flags))
+	if (test_bit(HCI_RFKILLED, &hdev->dev_flags)) {
+		clear_bit(HCI_AUTO_OFF, &hdev->dev_flags);
+		hci_dev_do_close(hdev);
+	} else if (test_bit(HCI_AUTO_OFF, &hdev->dev_flags)) {
 		queue_delayed_work(hdev->req_workqueue, &hdev->power_off,
 				   HCI_AUTO_OFF_TIMEOUT);
+	}
 
 	if (test_and_clear_bit(HCI_SETUP, &hdev->dev_flags))
 		mgmt_index_added(hdev);
-- 
1.8.4.rc3

