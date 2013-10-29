Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 07/15] Bluetooth: Introduce hdev->pending_auto_conn list
Date: Tue, 29 Oct 2013 10:25:52 -0300
Message-Id: <1383053160-10175-8-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1383053160-10175-1-git-send-email-andre.guedes@openbossa.org>
References: <1383053160-10175-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces the hdev->pending_auto_conn list which holds
the device addresses the kernel should autonomously connect. It also
introduces some helper functions to manipulate the list.

The list and helper functions will be used by the next patch which
implements the LE auto connection infrastructure.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |  9 +++++
 net/bluetooth/hci_core.c         | 84 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 64911aa..e85b37e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -273,6 +273,8 @@ struct hci_dev {
 
 	struct list_head	conn_params;
 
+	struct list_head	pending_auto_conn;
+
 	struct hci_dev_stats	stat;
 
 	atomic_t		promisc;
@@ -773,6 +775,13 @@ struct hci_conn_params *hci_find_conn_params(struct hci_dev *hdev,
 					   bdaddr_t *addr, u8 addr_type);
 void hci_conn_params_put(struct hci_conn_params *params);
 
+bool hci_has_pending_auto_conn(struct hci_dev *hdev, bdaddr_t *addr,
+			       u8 addr_type);
+int __hci_add_pending_auto_conn(struct hci_dev *hdev, bdaddr_t *addr,
+				u8 addr_type);
+void __hci_remove_pending_auto_conn(struct hci_dev *hdev, bdaddr_t *addr,
+				    u8 addr_type);
+
 int hci_uuids_clear(struct hci_dev *hdev);
 
 int hci_link_keys_clear(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 0a278da..94c390b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2888,6 +2888,88 @@ static void __clear_conn_params(struct hci_dev *hdev)
 		__remove_conn_params(params);
 }
 
+static struct bdaddr_list *__find_pending_auto_conn(struct hci_dev *hdev,
+						    bdaddr_t *addr,
+						    u8 addr_type)
+{
+	struct bdaddr_list *entry;
+
+	list_for_each_entry(entry, &hdev->pending_auto_conn, list) {
+		if (bacmp(&entry->bdaddr, addr))
+			continue;
+		if (entry->bdaddr_type != addr_type)
+			continue;
+
+		return entry;
+	}
+
+	return NULL;
+}
+
+bool hci_has_pending_auto_conn(struct hci_dev *hdev, bdaddr_t *addr,
+			       u8 addr_type)
+{
+	bool res;
+
+	hci_dev_lock(hdev);
+
+	if (__find_pending_auto_conn(hdev, addr, addr_type))
+		res = true;
+	else
+		res = false;
+
+	hci_dev_unlock(hdev);
+
+	return res;
+}
+
+/* This function requires the caller holds hdev->lock */
+int __hci_add_pending_auto_conn(struct hci_dev *hdev, bdaddr_t *addr,
+				u8 addr_type)
+{
+	struct bdaddr_list *entry;
+
+	entry = __find_pending_auto_conn(hdev, addr, addr_type);
+	if (entry)
+		return 0;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	bacpy(&entry->bdaddr, addr);
+	entry->bdaddr_type = addr_type;
+
+	list_add(&entry->list, &hdev->pending_auto_conn);
+
+	return 0;
+}
+
+/* This function requires the caller holds hdev->lock */
+void __hci_remove_pending_auto_conn(struct hci_dev *hdev, bdaddr_t *addr,
+				    u8 addr_type)
+{
+	struct bdaddr_list *entry;
+
+	entry = __find_pending_auto_conn(hdev, addr, addr_type);
+	if (!entry)
+		return;
+
+	list_del(&entry->list);
+	kfree(entry);
+}
+
+/* This function requires the caller holds hdev->lock */
+static void __clear_pending_auto_conn(struct hci_dev *hdev)
+{
+	struct bdaddr_list *entry, *tmp;
+
+	list_for_each_entry_safe(entry, tmp, &hdev->pending_auto_conn, list) {
+		list_del(&entry->list);
+		kfree(entry);
+	}
+}
+
 static void inquiry_complete(struct hci_dev *hdev, u8 status)
 {
 	if (status) {
@@ -2999,6 +3081,7 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_LIST_HEAD(&hdev->long_term_keys);
 	INIT_LIST_HEAD(&hdev->remote_oob_data);
 	INIT_LIST_HEAD(&hdev->conn_params);
+	INIT_LIST_HEAD(&hdev->pending_auto_conn);
 	INIT_LIST_HEAD(&hdev->conn_hash.list);
 
 	INIT_WORK(&hdev->rx_work, hci_rx_work);
@@ -3185,6 +3268,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	hci_smp_ltks_clear(hdev);
 	hci_remote_oob_data_clear(hdev);
 	__clear_conn_params(hdev);
+	__clear_pending_auto_conn(hdev);
 	hci_dev_unlock(hdev);
 
 	hci_dev_put(hdev);
-- 
1.8.4

