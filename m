Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/7] Bluetooth: Introduce hci_dev_change_flag helper macro
Date: Fri, 13 Mar 2015 02:11:03 -0700
Message-Id: <1426237866-8329-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of manually coding change_bit on hdev->dev_flags all the time,
use hci_dev_change_flag helper macro.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/mgmt.c             | 10 +++++-----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 535b23c73c92..92b2148702e6 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -504,6 +504,7 @@ extern struct mutex hci_cb_list_lock;
 
 #define hci_dev_set_flag(hdev, nr)    set_bit((nr), &(hdev)->dev_flags)
 #define hci_dev_clear_flag(hdev, nr)  clear_bit((nr), &(hdev)->dev_flags)
+#define hci_dev_change_flag(hdev, nr) change_bit((nr), &(hdev)->dev_flags)
 #define hci_dev_test_flag(hdev, nr)   test_bit((nr), &(hdev)->dev_flags)
 
 /* ----- HCI interface to upper protocols ----- */
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index aa233e37fc93..c3af3b87dbb5 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1674,7 +1674,7 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 		 * and so no need to check HCI_LIMITED_DISCOVERABLE.
 		 */
 		if (!!cp->val != hci_dev_test_flag(hdev, HCI_DISCOVERABLE)) {
-			change_bit(HCI_DISCOVERABLE, &hdev->dev_flags);
+			hci_dev_change_flag(hdev, HCI_DISCOVERABLE);
 			changed = true;
 		}
 
@@ -2046,7 +2046,7 @@ static int set_link_security(struct sock *sk, struct hci_dev *hdev, void *data,
 		bool changed = false;
 
 		if (!!cp->val != hci_dev_test_flag(hdev, HCI_LINK_SECURITY)) {
-			change_bit(HCI_LINK_SECURITY, &hdev->dev_flags);
+			hci_dev_change_flag(hdev, HCI_LINK_SECURITY);
 			changed = true;
 		}
 
@@ -2301,7 +2301,7 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		bool changed = false;
 
 		if (val != hci_dev_test_flag(hdev, HCI_LE_ENABLED)) {
-			change_bit(HCI_LE_ENABLED, &hdev->dev_flags);
+			hci_dev_change_flag(hdev, HCI_LE_ENABLED);
 			changed = true;
 		}
 
@@ -4689,7 +4689,7 @@ static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
 	}
 
 	if (!hdev_is_powered(hdev)) {
-		change_bit(HCI_FAST_CONNECTABLE, &hdev->dev_flags);
+		hci_dev_change_flag(hdev, HCI_FAST_CONNECTABLE);
 		err = send_settings_rsp(sk, MGMT_OP_SET_FAST_CONNECTABLE,
 					hdev);
 		new_settings(hdev, sk);
@@ -4789,7 +4789,7 @@ static int set_bredr(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 			hci_dev_clear_flag(hdev, HCI_HS_ENABLED);
 		}
 
-		change_bit(HCI_BREDR_ENABLED, &hdev->dev_flags);
+		hci_dev_change_flag(hdev, HCI_BREDR_ENABLED);
 
 		err = send_settings_rsp(sk, MGMT_OP_SET_BREDR, hdev);
 		if (err < 0)
-- 
2.1.0

