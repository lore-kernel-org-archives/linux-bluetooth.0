Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Move hci_pend_le_conn_* functions to different location
Date: Sun, 29 Jun 2014 13:41:49 +0200
Message-Id: <1404042111-60574-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The hci_pend_le_conn_* function should be placed before their actual
users. So move them before hci_conn_params_* functions.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 144 +++++++++++++++++++++++------------------------
 1 file changed, 72 insertions(+), 72 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3ee2885dd9bc..ffee5f547506 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3415,6 +3415,78 @@ static bool is_identity_address(bdaddr_t *addr, u8 addr_type)
 }
 
 /* This function requires the caller holds hdev->lock */
+struct bdaddr_list *hci_pend_le_conn_lookup(struct hci_dev *hdev,
+					    bdaddr_t *addr, u8 addr_type)
+{
+	struct bdaddr_list *entry;
+
+	list_for_each_entry(entry, &hdev->pend_le_conns, list) {
+		if (bacmp(&entry->bdaddr, addr) == 0 &&
+		    entry->bdaddr_type == addr_type)
+			return entry;
+	}
+
+	return NULL;
+}
+
+/* This function requires the caller holds hdev->lock */
+void hci_pend_le_conn_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type)
+{
+	struct bdaddr_list *entry;
+
+	entry = hci_pend_le_conn_lookup(hdev, addr, addr_type);
+	if (entry)
+		goto done;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry) {
+		BT_ERR("Out of memory");
+		return;
+	}
+
+	bacpy(&entry->bdaddr, addr);
+	entry->bdaddr_type = addr_type;
+
+	list_add(&entry->list, &hdev->pend_le_conns);
+
+	BT_DBG("addr %pMR (type %u)", addr, addr_type);
+
+done:
+	hci_update_background_scan(hdev);
+}
+
+/* This function requires the caller holds hdev->lock */
+void hci_pend_le_conn_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type)
+{
+	struct bdaddr_list *entry;
+
+	entry = hci_pend_le_conn_lookup(hdev, addr, addr_type);
+	if (!entry)
+		goto done;
+
+	list_del(&entry->list);
+	kfree(entry);
+
+	BT_DBG("addr %pMR (type %u)", addr, addr_type);
+
+done:
+	hci_update_background_scan(hdev);
+}
+
+/* This function requires the caller holds hdev->lock */
+void hci_pend_le_conns_clear(struct hci_dev *hdev)
+{
+	struct bdaddr_list *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, &hdev->pend_le_conns, list) {
+		list_del(&entry->list);
+		kfree(entry);
+	}
+
+	BT_DBG("All LE pending connections cleared");
+}
+
+/* This function requires the caller holds hdev->lock */
 int hci_conn_params_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 			u8 auto_connect, u16 conn_min_interval,
 			u16 conn_max_interval)
@@ -3492,78 +3564,6 @@ void hci_conn_params_clear(struct hci_dev *hdev)
 	BT_DBG("All LE connection parameters were removed");
 }
 
-/* This function requires the caller holds hdev->lock */
-struct bdaddr_list *hci_pend_le_conn_lookup(struct hci_dev *hdev,
-					    bdaddr_t *addr, u8 addr_type)
-{
-	struct bdaddr_list *entry;
-
-	list_for_each_entry(entry, &hdev->pend_le_conns, list) {
-		if (bacmp(&entry->bdaddr, addr) == 0 &&
-		    entry->bdaddr_type == addr_type)
-			return entry;
-	}
-
-	return NULL;
-}
-
-/* This function requires the caller holds hdev->lock */
-void hci_pend_le_conn_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type)
-{
-	struct bdaddr_list *entry;
-
-	entry = hci_pend_le_conn_lookup(hdev, addr, addr_type);
-	if (entry)
-		goto done;
-
-	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
-	if (!entry) {
-		BT_ERR("Out of memory");
-		return;
-	}
-
-	bacpy(&entry->bdaddr, addr);
-	entry->bdaddr_type = addr_type;
-
-	list_add(&entry->list, &hdev->pend_le_conns);
-
-	BT_DBG("addr %pMR (type %u)", addr, addr_type);
-
-done:
-	hci_update_background_scan(hdev);
-}
-
-/* This function requires the caller holds hdev->lock */
-void hci_pend_le_conn_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type)
-{
-	struct bdaddr_list *entry;
-
-	entry = hci_pend_le_conn_lookup(hdev, addr, addr_type);
-	if (!entry)
-		goto done;
-
-	list_del(&entry->list);
-	kfree(entry);
-
-	BT_DBG("addr %pMR (type %u)", addr, addr_type);
-
-done:
-	hci_update_background_scan(hdev);
-}
-
-/* This function requires the caller holds hdev->lock */
-void hci_pend_le_conns_clear(struct hci_dev *hdev)
-{
-	struct bdaddr_list *entry, *tmp;
-
-	list_for_each_entry_safe(entry, tmp, &hdev->pend_le_conns, list) {
-		list_del(&entry->list);
-		kfree(entry);
-	}
-
-	BT_DBG("All LE pending connections cleared");
-}
-
 static void inquiry_complete(struct hci_dev *hdev, u8 status)
 {
 	if (status) {
-- 
1.9.3

