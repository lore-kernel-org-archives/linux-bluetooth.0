Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 07/17] Bluetooth: Introduce hdev->pend_le_conn list
Date: Tue, 25 Feb 2014 18:01:34 -0300
Message-Id: <1393362104-12175-8-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1393362104-12175-1-git-send-email-andre.guedes@openbossa.org>
References: <1393362104-12175-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces the hdev->pend_le_conn list which holds the
device addresses the kernel should autonomously connect. It also
introduces some helper functions to manipulate the list.

The list and helper functions will be used by the next patch which
implements the LE auto connection infrastructure.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |  7 +++++
 net/bluetooth/hci_core.c         | 68 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 20bdb2e..e08405d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -284,6 +284,7 @@ struct hci_dev {
 	struct list_head	identity_resolving_keys;
 	struct list_head	remote_oob_data;
 	struct list_head	le_conn_params;
+	struct list_head	pend_le_conns;
 
 	struct hci_dev_stats	stat;
 
@@ -799,6 +800,12 @@ void hci_conn_params_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type);
 void hci_conn_params_clear(struct hci_dev *hdev);
 
+struct bdaddr_list *hci_pend_le_conn_lookup(struct hci_dev *hdev,
+					    bdaddr_t *addr, u8 addr_type);
+void hci_pend_le_conn_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type);
+void hci_pend_le_conn_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type);
+void hci_pend_le_conns_clear(struct hci_dev *hdev);
+
 void hci_uuids_clear(struct hci_dev *hdev);
 
 void hci_link_keys_clear(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9a078cf..142ecd8 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3259,6 +3259,72 @@ void hci_conn_params_clear(struct hci_dev *hdev)
 	BT_DBG("All LE connection parameters were removed");
 }
 
+/* This function requires the caller holds hdev->lock */
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
+		return;
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
+}
+
+/* This function requires the caller holds hdev->lock */
+void hci_pend_le_conn_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type)
+{
+	struct bdaddr_list *entry;
+
+	entry = hci_pend_le_conn_lookup(hdev, addr, addr_type);
+	if (!entry)
+		return;
+
+	list_del(&entry->list);
+	kfree(entry);
+
+	BT_DBG("addr %pMR (type %u)", addr, addr_type);
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
 static void inquiry_complete(struct hci_dev *hdev, u8 status)
 {
 	if (status) {
@@ -3441,6 +3507,7 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_LIST_HEAD(&hdev->identity_resolving_keys);
 	INIT_LIST_HEAD(&hdev->remote_oob_data);
 	INIT_LIST_HEAD(&hdev->le_conn_params);
+	INIT_LIST_HEAD(&hdev->pend_le_conns);
 	INIT_LIST_HEAD(&hdev->conn_hash.list);
 
 	INIT_WORK(&hdev->rx_work, hci_rx_work);
@@ -3642,6 +3709,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	hci_smp_irks_clear(hdev);
 	hci_remote_oob_data_clear(hdev);
 	hci_conn_params_clear(hdev);
+	hci_pend_le_conns_clear(hdev);
 	hci_dev_unlock(hdev);
 
 	hci_dev_put(hdev);
-- 
1.8.5.4

