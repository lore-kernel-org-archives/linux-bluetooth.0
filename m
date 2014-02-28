Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: Add support for storing LE white list entries
Date: Thu, 27 Feb 2014 20:37:30 -0800
Message-Id: <1393562251-7555-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The current LE white list entries require storing in the HCI controller
structure. So provide a storage and access functions for it. In addition
export the current list via debugfs.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  7 ++++
 net/bluetooth/hci_core.c         | 90 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 55ee2a5ca503..0c63a7e12d90 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -284,6 +284,7 @@ struct hci_dev {
 	struct list_head	long_term_keys;
 	struct list_head	identity_resolving_keys;
 	struct list_head	remote_oob_data;
+	struct list_head	le_white_list;
 	struct list_head	le_conn_params;
 	struct list_head	pend_le_conns;
 
@@ -799,6 +800,12 @@ struct bdaddr_list *hci_blacklist_lookup(struct hci_dev *hdev,
 int hci_blacklist_add(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 
+struct bdaddr_list *hci_white_list_lookup(struct hci_dev *hdev,
+					  bdaddr_t *bdaddr, u8 type);
+void hci_white_list_clear(struct hci_dev *hdev);
+int hci_white_list_add(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
+int hci_white_list_del(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
+
 struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
 					       bdaddr_t *addr, u8 addr_type);
 int hci_conn_params_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c6cbe78e685f..32c0c2c58f66 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -702,6 +702,31 @@ static const struct file_operations force_static_address_fops = {
 	.llseek		= default_llseek,
 };
 
+static int white_list_show(struct seq_file *f, void *ptr)
+{
+	struct hci_dev *hdev = f->private;
+	struct bdaddr_list *b;
+
+	hci_dev_lock(hdev);
+	list_for_each_entry(b, &hdev->le_white_list, list)
+		seq_printf(f, "%pMR (type %u)\n", &b->bdaddr, b->bdaddr_type);
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int white_list_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, white_list_show, inode->i_private);
+}
+
+static const struct file_operations white_list_fops = {
+	.open		= white_list_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static int identity_resolving_keys_show(struct seq_file *f, void *ptr)
 {
 	struct hci_dev *hdev = f->private;
@@ -1786,6 +1811,8 @@ static int __hci_init(struct hci_dev *hdev)
 
 		debugfs_create_u8("white_list_size", 0444, hdev->debugfs,
 				  &hdev->le_white_list_size);
+		debugfs_create_file("white_list", 0444, hdev->debugfs, hdev,
+				    &white_list_fops);
 		debugfs_create_file("identity_resolving_keys", 0400,
 				    hdev->debugfs, hdev,
 				    &identity_resolving_keys_fops);
@@ -3293,6 +3320,67 @@ int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 	return mgmt_device_unblocked(hdev, bdaddr, type);
 }
 
+struct bdaddr_list *hci_white_list_lookup(struct hci_dev *hdev,
+					  bdaddr_t *bdaddr, u8 type)
+{
+	struct bdaddr_list *b;
+
+	list_for_each_entry(b, &hdev->le_white_list, list) {
+		if (!bacmp(&b->bdaddr, bdaddr) && b->bdaddr_type == type)
+			return b;
+	}
+
+	return NULL;
+}
+
+void hci_white_list_clear(struct hci_dev *hdev)
+{
+	struct list_head *p, *n;
+
+	list_for_each_safe(p, n, &hdev->le_white_list) {
+		struct bdaddr_list *b = list_entry(p, struct bdaddr_list, list);
+
+		list_del(p);
+		kfree(b);
+	}
+}
+
+int hci_white_list_add(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
+{
+	struct bdaddr_list *entry;
+
+	if (!bacmp(bdaddr, BDADDR_ANY))
+		return -EBADF;
+
+	entry = kzalloc(sizeof(struct bdaddr_list), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	bacpy(&entry->bdaddr, bdaddr);
+	entry->bdaddr_type = type;
+
+	list_add(&entry->list, &hdev->le_white_list);
+
+	return 0;
+}
+
+int hci_white_list_del(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
+{
+	struct bdaddr_list *entry;
+
+	if (!bacmp(bdaddr, BDADDR_ANY))
+		return -EBADF;
+
+	entry = hci_white_list_lookup(hdev, bdaddr, type);
+	if (!entry)
+		return -ENOENT;
+
+	list_del(&entry->list);
+	kfree(entry);
+
+	return 0;
+}
+
 /* This function requires the caller holds hdev->lock */
 struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
 					       bdaddr_t *addr, u8 addr_type)
@@ -3691,6 +3779,7 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_LIST_HEAD(&hdev->long_term_keys);
 	INIT_LIST_HEAD(&hdev->identity_resolving_keys);
 	INIT_LIST_HEAD(&hdev->remote_oob_data);
+	INIT_LIST_HEAD(&hdev->le_white_list);
 	INIT_LIST_HEAD(&hdev->le_conn_params);
 	INIT_LIST_HEAD(&hdev->pend_le_conns);
 	INIT_LIST_HEAD(&hdev->conn_hash.list);
@@ -3893,6 +3982,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	hci_smp_ltks_clear(hdev);
 	hci_smp_irks_clear(hdev);
 	hci_remote_oob_data_clear(hdev);
+	hci_white_list_clear(hdev);
 	hci_conn_params_clear(hdev);
 	hci_pend_le_conns_clear(hdev);
 	hci_dev_unlock(hdev);
-- 
1.8.5.3

