Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <aguedespe@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: andre.guedes@openbossa.org
Subject: [PATCH 1/3] Bluetooth: Add prefix "__" to advertising cache functions
Date: Tue,  7 Feb 2012 01:29:55 -0300
Message-Id: <1328588997-25029-2-git-send-email-aguedespe@gmail.com>
In-Reply-To: <1328588997-25029-1-git-send-email-aguedespe@gmail.com>
References: <1328588997-25029-1-git-send-email-aguedespe@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch does a code refactoring in advertising cache functions.
It adds the prefix "__" to these functions and adds a comment to
explicitly indicate they must be called with hdev->lock held.

Signed-off-by: Andre Guedes <aguedespe@gmail.com>
---
 include/net/bluetooth/hci_core.h |    6 +++---
 net/bluetooth/hci_conn.c         |    2 +-
 net/bluetooth/hci_core.c         |   15 +++++++++------
 net/bluetooth/hci_event.c        |    4 ++--
 4 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 7107790..a6fccca 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -673,9 +673,9 @@ int hci_add_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 *hash,
 int hci_remove_remote_oob_data(struct hci_dev *hdev, bdaddr_t *bdaddr);
 
 #define ADV_CLEAR_TIMEOUT (3*60*HZ) /* Three minutes */
-int hci_adv_entries_clear(struct hci_dev *hdev);
-struct adv_entry *hci_find_adv_entry(struct hci_dev *hdev, bdaddr_t *bdaddr);
-int hci_add_adv_entry(struct hci_dev *hdev,
+int __hci_adv_entries_clear(struct hci_dev *hdev);
+struct adv_entry *__hci_find_adv_entry(struct hci_dev *hdev, bdaddr_t *bdaddr);
+int __hci_add_adv_entry(struct hci_dev *hdev,
 					struct hci_ev_le_advertising_info *ev);
 
 void hci_del_off_timer(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b4ecdde..2f6ca8e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -530,7 +530,7 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 		if (le)
 			return ERR_PTR(-EBUSY);
 
-		entry = hci_find_adv_entry(hdev, dst);
+		entry = __hci_find_adv_entry(hdev, dst);
 		if (!entry)
 			return ERR_PTR(-EHOSTUNREACH);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3d09f4b4..362b1ab 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1534,12 +1534,13 @@ static void hci_clear_adv_cache(struct work_struct *work)
 
 	hci_dev_lock(hdev);
 
-	hci_adv_entries_clear(hdev);
+	__hci_adv_entries_clear(hdev);
 
 	hci_dev_unlock(hdev);
 }
 
-int hci_adv_entries_clear(struct hci_dev *hdev)
+/* Must be holding hdev->lock */
+int __hci_adv_entries_clear(struct hci_dev *hdev)
 {
 	struct adv_entry *entry, *tmp;
 
@@ -1553,7 +1554,8 @@ int hci_adv_entries_clear(struct hci_dev *hdev)
 	return 0;
 }
 
-struct adv_entry *hci_find_adv_entry(struct hci_dev *hdev, bdaddr_t *bdaddr)
+/* Must be holding hdev->lock */
+struct adv_entry *__hci_find_adv_entry(struct hci_dev *hdev, bdaddr_t *bdaddr)
 {
 	struct adv_entry *entry;
 
@@ -1572,7 +1574,8 @@ static inline int is_connectable_adv(u8 evt_type)
 	return 0;
 }
 
-int hci_add_adv_entry(struct hci_dev *hdev,
+/* Must be holding hdev->lock */
+int __hci_add_adv_entry(struct hci_dev *hdev,
 					struct hci_ev_le_advertising_info *ev)
 {
 	struct adv_entry *entry;
@@ -1582,7 +1585,7 @@ int hci_add_adv_entry(struct hci_dev *hdev,
 
 	/* Only new entries should be added to adv_entries. So, if
 	 * bdaddr was found, don't add it. */
-	if (hci_find_adv_entry(hdev, &ev->bdaddr))
+	if (__hci_find_adv_entry(hdev, &ev->bdaddr))
 		return 0;
 
 	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
@@ -1879,7 +1882,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	hci_link_keys_clear(hdev);
 	hci_smp_ltks_clear(hdev);
 	hci_remote_oob_data_clear(hdev);
-	hci_adv_entries_clear(hdev);
+	__hci_adv_entries_clear(hdev);
 	hci_dev_unlock(hdev);
 
 	hci_dev_put(hdev);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ad5f37b..6808069 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1070,7 +1070,7 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 		cancel_delayed_work_sync(&hdev->adv_work);
 
 		hci_dev_lock(hdev);
-		hci_adv_entries_clear(hdev);
+		__hci_adv_entries_clear(hdev);
 		hci_discovery_set_state(hdev, DISCOVERY_LE_SCAN);
 		hci_dev_unlock(hdev);
 		break;
@@ -3260,7 +3260,7 @@ static inline void hci_le_adv_report_evt(struct hci_dev *hdev,
 	while (num_reports--) {
 		struct hci_ev_le_advertising_info *ev = ptr;
 
-		hci_add_adv_entry(hdev, ev);
+		__hci_add_adv_entry(hdev, ev);
 
 		rssi = ev->data[ev->length];
 		mgmt_device_found(hdev, &ev->bdaddr, LE_LINK, ev->bdaddr_type,
-- 
1.7.9

