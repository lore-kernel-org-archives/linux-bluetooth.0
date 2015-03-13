Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: Use DECLARE_BITMAP for hdev->dev_flags field
Date: Fri, 13 Mar 2015 02:15:22 -0700
Message-Id: <1426238122-13481-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The hdev->dev_flags field has outgrown itself on 32-bit systems. So
instead of hacking around it, switch to using DECLARE_BITMAP.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h      |  1 +
 include/net/bluetooth/hci_core.h | 17 ++++++++---------
 net/bluetooth/hci_core.c         |  2 +-
 net/bluetooth/hci_event.c        |  2 +-
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 0f3413b285a5..1545853b257e 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -226,6 +226,7 @@ enum {
 	HCI_FAST_CONNECTABLE,
 	HCI_BREDR_ENABLED,
 	HCI_LE_SCAN_INTERRUPTED,
+	__HCI_NUM_FLAGS,
 };
 
 /* A mask for the flags that are supposed to remain when a reset happens
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6db1333a114f..dbc6f4ba8ed6 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -354,7 +354,7 @@ struct hci_dev {
 	struct rfkill		*rfkill;
 
 	unsigned long		dbg_flags;
-	unsigned long		dev_flags;
+	DECLARE_BITMAP(dev_flags, __HCI_NUM_FLAGS);
 
 	struct delayed_work	le_scan_disable;
 	struct delayed_work	le_scan_restart;
@@ -502,14 +502,13 @@ extern struct list_head hci_cb_list;
 extern rwlock_t hci_dev_list_lock;
 extern struct mutex hci_cb_list_lock;
 
-#define hci_dev_set_flag(hdev, nr)    set_bit((nr), &(hdev)->dev_flags)
-#define hci_dev_clear_flag(hdev, nr)  clear_bit((nr), &(hdev)->dev_flags)
-#define hci_dev_change_flag(hdev, nr) change_bit((nr), &(hdev)->dev_flags)
-#define hci_dev_test_flag(hdev, nr)   test_bit((nr), &(hdev)->dev_flags)
-
-#define hci_dev_test_and_set_flag(hdev, nr)    test_and_set_bit((nr), &(hdev)->dev_flags)
-#define hci_dev_test_and_clear_flag(hdev, nr)  test_and_clear_bit((nr), &(hdev)->dev_flags)
-#define hci_dev_test_and_change_flag(hdev, nr) test_and_change_bit((nr), &(hdev)->dev_flags)
+#define hci_dev_set_flag(hdev, nr)             set_bit((nr), (hdev)->dev_flags)
+#define hci_dev_clear_flag(hdev, nr)           clear_bit((nr), (hdev)->dev_flags)
+#define hci_dev_change_flag(hdev, nr)          change_bit((nr), (hdev)->dev_flags)
+#define hci_dev_test_flag(hdev, nr)            test_bit((nr), (hdev)->dev_flags)
+#define hci_dev_test_and_set_flag(hdev, nr)    test_and_set_bit((nr), (hdev)->dev_flags)
+#define hci_dev_test_and_clear_flag(hdev, nr)  test_and_clear_bit((nr), (hdev)->dev_flags)
+#define hci_dev_test_and_change_flag(hdev, nr) test_and_change_bit((nr), (hdev)->dev_flags)
 
 /* ----- HCI interface to upper protocols ----- */
 int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c6ed46c4f45a..89d0cabe481b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1699,7 +1699,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 
 	/* Clear flags */
 	hdev->flags &= BIT(HCI_RAW);
-	hdev->dev_flags &= ~HCI_PERSISTENT_MASK;
+	hdev->dev_flags[0] &= ~HCI_PERSISTENT_MASK;
 
 	/* Controller radio is available but is currently powered down */
 	hdev->amp_status = AMP_STATUS_POWERED_DOWN;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 4958b24ae5c7..f7e58b98bcff 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -198,7 +198,7 @@ static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
 		return;
 
 	/* Reset all non-persistent flags */
-	hdev->dev_flags &= ~HCI_PERSISTENT_MASK;
+	hdev->dev_flags[0] &= ~HCI_PERSISTENT_MASK;
 
 	hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 
-- 
2.1.0

