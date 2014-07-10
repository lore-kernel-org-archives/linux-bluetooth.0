Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: Remove unneeded mgmt_connectable function
Date: Thu, 10 Jul 2014 12:09:06 +0300
Message-Id: <1404983349-6105-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The mgmt_connectable function has been used to ensure that the right
actions to HCI_CONNECTABLE are taken when the HCI_Write_Scan_Enable
command is triggered by something else than mgmt. The only other user
that we really care about is the HCISETSCAN ioctl code, so we can
actually more simply perform the needed changes there instead.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_core.c         |  6 +++---
 net/bluetooth/hci_event.c        |  6 +-----
 net/bluetooth/mgmt.c             | 32 --------------------------------
 4 files changed, 4 insertions(+), 41 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e69c2b08c0c6..76675c55be15 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1288,7 +1288,6 @@ void mgmt_set_powered_failed(struct hci_dev *hdev, int err);
 int mgmt_powered(struct hci_dev *hdev, u8 powered);
 void mgmt_discoverable_timeout(struct hci_dev *hdev);
 void mgmt_discoverable(struct hci_dev *hdev, u8 discoverable);
-void mgmt_connectable(struct hci_dev *hdev, u8 connectable);
 void mgmt_write_scan_failed(struct hci_dev *hdev, u8 scan, u8 status);
 void mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 		       bool persistent);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8f9df768f250..3844eeb85453 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2717,9 +2717,9 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 				   HCI_INIT_TIMEOUT);
 
 		/* Ensure that the connectable state gets correctly
-		 * notified if the whitelist is in use.
+		 * modified as this was a non-mgmt change.
 		 */
-		if (!err && !list_empty(&hdev->whitelist)) {
+		if (!err) {
 			bool changed;
 
 			if ((dr.dev_opt & SCAN_PAGE))
@@ -2729,7 +2729,7 @@ int hci_dev_cmd(unsigned int cmd, void __user *arg)
 				changed = test_and_clear_bit(HCI_CONNECTABLE,
 							     &hdev->dev_flags);
 
-			if (changed)
+			if (changed && test_bit(HCI_MGMT, &hdev->dev_flags))
 				mgmt_new_settings(hdev);
 		}
 		break;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c8ae9ee3cb12..38a0e457eaf9 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -330,12 +330,8 @@ static void hci_cc_write_scan_enable(struct hci_dev *hdev, struct sk_buff *skb)
 	} else if (old_iscan)
 		mgmt_discoverable(hdev, 0);
 
-	if (param & SCAN_PAGE) {
+	if (param & SCAN_PAGE)
 		set_bit(HCI_PSCAN, &hdev->flags);
-		if (!old_pscan)
-			mgmt_connectable(hdev, 1);
-	} else if (old_pscan)
-		mgmt_connectable(hdev, 0);
 
 done:
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 38f05386bc0c..9f9f11c8488b 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6068,38 +6068,6 @@ void mgmt_discoverable(struct hci_dev *hdev, u8 discoverable)
 	}
 }
 
-void mgmt_connectable(struct hci_dev *hdev, u8 connectable)
-{
-	bool changed;
-
-	/* Nothing needed here if there's a pending command since that
-	 * commands request completion callback takes care of everything
-	 * necessary.
-	 */
-	if (mgmt_pending_find(MGMT_OP_SET_CONNECTABLE, hdev))
-		return;
-
-	/* Powering off may clear the scan mode - don't let that interfere */
-	if (!connectable && mgmt_pending_find(MGMT_OP_SET_POWERED, hdev))
-		return;
-
-	/* If something else than mgmt changed the page scan state we
-	 * can't differentiate this from a change triggered by adding
-	 * the first element to the whitelist. Therefore, avoid
-	 * incorrectly setting HCI_CONNECTABLE.
-	 */
-	if (connectable && !list_empty(&hdev->whitelist))
-		return;
-
-	if (connectable)
-		changed = !test_and_set_bit(HCI_CONNECTABLE, &hdev->dev_flags);
-	else
-		changed = test_and_clear_bit(HCI_CONNECTABLE, &hdev->dev_flags);
-
-	if (changed)
-		new_settings(hdev, NULL);
-}
-
 void mgmt_write_scan_failed(struct hci_dev *hdev, u8 scan, u8 status)
 {
 	u8 mgmt_err = mgmt_status(status);
-- 
1.9.3

