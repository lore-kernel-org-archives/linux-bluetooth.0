Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 01/15] Bluetooth: Introduce connection parameters list
Date: Wed, 16 Oct 2013 20:17:51 -0300
Message-Id: <1381965485-9159-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1381965485-9159-1-git-send-email-andre.guedes@openbossa.org>
References: <1381965485-9159-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds to hdev the connection parameters list (hdev->
conn_param). The elements from this list (struct hci_conn_param)
contains the connection parameters (for now, minimum and maximum
connection interval) that should be used for establishing
connection.

The struct hci_conn_param also defines the 'auto_connect' field
which will be used to implement the auto connection mechanism.

Moreover, this patch adds helper functions to manipulate hdev->conn_
param list. Some of these functions are also declared in hci_core.h
since they will be used outside hci_core.c in upcoming patches.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h | 23 +++++++++++
 net/bluetooth/hci_core.c         | 88 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 111 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 07c2da4..5052bf0 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -266,6 +266,8 @@ struct hci_dev {
 
 	struct list_head	remote_oob_data;
 
+	struct list_head	conn_param;
+
 	struct hci_dev_stats	stat;
 
 	atomic_t		promisc;
@@ -368,6 +370,22 @@ struct hci_chan {
 	__u8		state;
 };
 
+struct hci_conn_param {
+	struct list_head list;
+
+	bdaddr_t addr;
+	u8 addr_type;
+
+	enum {
+		HCI_AUTO_CONN_DISABLED,
+		HCI_AUTO_CONN_ALWAYS,
+		HCI_AUTO_CONN_LINK_LOSS,
+	} auto_connect;
+
+	u16 min_conn_interval;
+	u16 max_conn_interval;
+};
+
 extern struct list_head hci_dev_list;
 extern struct list_head hci_cb_list;
 extern rwlock_t hci_dev_list_lock;
@@ -737,6 +755,11 @@ int hci_blacklist_clear(struct hci_dev *hdev);
 int hci_blacklist_add(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 
+int hci_add_conn_param(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
+		       u8 auto_connect, u16 min_conn_interval,
+		       u16 max_conn_interval);
+void hci_remove_conn_param(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type);
+
 int hci_uuids_clear(struct hci_dev *hdev);
 
 int hci_link_keys_clear(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 73c8def..a4242ac 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2151,6 +2151,92 @@ int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 	return mgmt_device_unblocked(hdev, bdaddr, type);
 }
 
+struct hci_conn_param *find_conn_param(struct hci_dev *hdev,
+				       bdaddr_t *addr, u8 addr_type)
+{
+	struct hci_conn_param *param;
+
+	rcu_read_lock();
+
+	list_for_each_entry(param, &hdev->conn_param, list) {
+		if (bacmp(&param->addr, addr))
+			continue;
+		if (param->addr_type != addr_type)
+			continue;
+
+		rcu_read_unlock();
+		return param;
+	}
+
+	rcu_read_unlock();
+	return NULL;
+}
+
+int hci_add_conn_param(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
+		       u8 auto_connect, u16 min_conn_interval,
+		       u16 max_conn_interval)
+{
+	struct hci_conn_param *param;
+
+	param = find_conn_param(hdev, addr, addr_type);
+	if (param)
+		return -EEXIST;
+
+	param = kmalloc(sizeof(*param), GFP_KERNEL);
+	if (!param)
+		return -ENOMEM;
+
+	bacpy(&param->addr, addr);
+	param->addr_type = addr_type;
+	param->auto_connect = auto_connect;
+	param->min_conn_interval = min_conn_interval;
+	param->max_conn_interval = max_conn_interval;
+
+	hci_dev_lock(hdev);
+	list_add_rcu(&param->list, &hdev->conn_param);
+	hci_dev_unlock(hdev);
+	return 0;
+}
+
+/*
+ * Remove from hdev->conn_param and free hci_conn_param.
+ *
+ * This function requires the caller holds hdev->lock.
+ */
+static void __remove_conn_param(struct hci_conn_param *param)
+{
+	list_del_rcu(&param->list);
+	synchronize_rcu();
+
+	kfree(param);
+}
+
+void hci_remove_conn_param(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type)
+{
+	struct hci_conn_param *param;
+
+	param = find_conn_param(hdev, addr, addr_type);
+	if (!param)
+		return;
+
+	hci_dev_lock(hdev);
+	__remove_conn_param(param);
+	hci_dev_unlock(hdev);
+}
+
+/*
+ * Remove all elements from hdev->conn_param list.
+ *
+ * This function requires the caller holds hdev->lock.
+ */
+static void __clear_conn_param(struct hci_dev *hdev)
+{
+	struct hci_conn_param *param, *tmp;
+
+	list_for_each_entry_safe(param, tmp, &hdev->conn_param, list)
+		__remove_conn_param(param);
+}
+
 static void inquiry_complete(struct hci_dev *hdev, u8 status)
 {
 	if (status) {
@@ -2259,6 +2345,7 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_LIST_HEAD(&hdev->link_keys);
 	INIT_LIST_HEAD(&hdev->long_term_keys);
 	INIT_LIST_HEAD(&hdev->remote_oob_data);
+	INIT_LIST_HEAD(&hdev->conn_param);
 	INIT_LIST_HEAD(&hdev->conn_hash.list);
 
 	INIT_WORK(&hdev->rx_work, hci_rx_work);
@@ -2437,6 +2524,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	hci_link_keys_clear(hdev);
 	hci_smp_ltks_clear(hdev);
 	hci_remote_oob_data_clear(hdev);
+	__clear_conn_param(hdev);
 	hci_dev_unlock(hdev);
 
 	hci_dev_put(hdev);
-- 
1.8.4

