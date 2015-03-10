Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Make Fast Connectable available while powered off
Date: Tue, 10 Mar 2015 20:14:27 +0200
Message-Id: <1426011267-6986-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

To maximize the usability of the Fast Connectable feature we should make
it possible to set (or unset) it at any given moment. This means
removing the dependency on the 'connectable' setting as well as the
'powered' setting. The former makes also sense since page scan may get
enabled through add_device even if 'connectable' is false. To keep the
setting available over power cycles its flag also needs to be removed
from the flags that are cleared upon HCI_Reset.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
v2: After discussion with Marcel, we agreed that it makes sense to allow
this setting in an even wider scope, i.e. also when powered off.

 include/net/bluetooth/hci.h |  2 +-
 net/bluetooth/mgmt.c        | 30 ++++++++++++------------------
 2 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 8e54f825153c..f76f45ae76c3 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -231,7 +231,7 @@ enum {
  * or the HCI device is closed.
  */
 #define HCI_PERSISTENT_MASK (BIT(HCI_LE_SCAN) | BIT(HCI_PERIODIC_INQ) | \
-			      BIT(HCI_FAST_CONNECTABLE) | BIT(HCI_LE_ADV))
+			     BIT(HCI_LE_ADV))
 
 /* HCI timeouts */
 #define HCI_DISCONN_TIMEOUT	msecs_to_jiffies(2000)	/* 2 seconds */
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d769b428b630..49b8e09ffe67 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1968,15 +1968,6 @@ static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
 	}
 
 no_scan_update:
-	/* If we're going from non-connectable to connectable or
-	 * vice-versa when fast connectable is enabled ensure that fast
-	 * connectable gets disabled. write_fast_connectable won't do
-	 * anything if the page scan parameters are already what they
-	 * should be.
-	 */
-	if (cp->val || test_bit(HCI_FAST_CONNECTABLE, &hdev->dev_flags))
-		write_fast_connectable(&req, false);
-
 	/* Update the advertising parameters if necessary */
 	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags))
 		enable_advertising(&req);
@@ -4660,14 +4651,6 @@ static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
 				       MGMT_STATUS_INVALID_PARAMS);
 
-	if (!hdev_is_powered(hdev))
-		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
-				       MGMT_STATUS_NOT_POWERED);
-
-	if (!test_bit(HCI_CONNECTABLE, &hdev->dev_flags))
-		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
-				       MGMT_STATUS_REJECTED);
-
 	hci_dev_lock(hdev);
 
 	if (mgmt_pending_find(MGMT_OP_SET_FAST_CONNECTABLE, hdev)) {
@@ -4682,6 +4665,14 @@ static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
+	if (!hdev_is_powered(hdev)) {
+		change_bit(HCI_FAST_CONNECTABLE, &hdev->dev_flags);
+		err = send_settings_rsp(sk, MGMT_OP_SET_FAST_CONNECTABLE,
+					hdev);
+		new_settings(hdev, sk);
+		goto unlock;
+	}
+
 	cmd = mgmt_pending_add(sk, MGMT_OP_SET_FAST_CONNECTABLE, hdev,
 			       data, len);
 	if (!cmd) {
@@ -6481,7 +6472,10 @@ static int powered_update_hci(struct hci_dev *hdev)
 			    sizeof(link_sec), &link_sec);
 
 	if (lmp_bredr_capable(hdev)) {
-		write_fast_connectable(&req, false);
+		if (test_bit(HCI_FAST_CONNECTABLE, &hdev->dev_flags))
+			write_fast_connectable(&req, true);
+		else
+			write_fast_connectable(&req, false);
 		__hci_update_page_scan(&req);
 		update_class(&req);
 		update_name(&req);
-- 
2.1.0

