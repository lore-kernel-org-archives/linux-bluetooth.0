Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v6 03/14] Bluetooth: Introduce connection parameters list
Date: Thu, 30 Jan 2014 18:22:06 -0300
Message-Id: <1391116937-28217-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1391116937-28217-1-git-send-email-andre.guedes@openbossa.org>
References: <1391116937-28217-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds to hdev the connection parameters list (hdev->le_
conn_params). The elements from this list (struct hci_conn_params)
contains the connection parameters (for now, minimum and maximum
connection interval) that should be used during the connection
establishment.

The struct hci_conn_params also defines the 'auto_connect' field
which will be used to implement the auto connection mechanism.

Moreover, this patch adds helper functions to manipulate hdev->le_
conn_params list. Some of these functions are also declared in
hci_core.h since they will be used outside hci_core.c in upcoming
patches.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h | 25 +++++++++++++
 net/bluetooth/hci_core.c         | 80 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 105 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 197413b..f757b3f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -269,6 +269,7 @@ struct hci_dev {
 	struct list_head	link_keys;
 	struct list_head	long_term_keys;
 	struct list_head	remote_oob_data;
+	struct list_head	le_conn_params;
 
 	struct hci_dev_stats	stat;
 
@@ -373,6 +374,22 @@ struct hci_chan {
 	__u8		state;
 };
 
+struct hci_conn_params {
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
+	u16 conn_min_interval;
+	u16 conn_max_interval;
+};
+
 extern struct list_head hci_dev_list;
 extern struct list_head hci_cb_list;
 extern rwlock_t hci_dev_list_lock;
@@ -750,6 +767,14 @@ int hci_blacklist_clear(struct hci_dev *hdev);
 int hci_blacklist_add(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 
+struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
+					       bdaddr_t *addr, u8 addr_type);
+void hci_conn_params_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
+			 u8 auto_connect, u16 conn_min_interval,
+			 u16 conn_max_interval);
+void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type);
+void hci_conn_params_clear(struct hci_dev *hdev);
+
 int hci_uuids_clear(struct hci_dev *hdev);
 
 int hci_link_keys_clear(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 369d307..672486f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2933,6 +2933,84 @@ int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 	return mgmt_device_unblocked(hdev, bdaddr, type);
 }
 
+/* This function requires the caller holds hdev->lock */
+struct hci_conn_params *hci_conn_params_lookup(struct hci_dev *hdev,
+					       bdaddr_t *addr, u8 addr_type)
+{
+	struct hci_conn_params *params;
+
+	list_for_each_entry(params, &hdev->le_conn_params, list) {
+		if (bacmp(&params->addr, addr) == 0 &&
+		    params->addr_type == addr_type) {
+			return params;
+		}
+	}
+
+	return NULL;
+}
+
+/* This function requires the caller holds hdev->lock */
+void hci_conn_params_add(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
+			 u8 auto_connect, u16 conn_min_interval,
+			 u16 conn_max_interval)
+{
+	struct hci_conn_params *params;
+
+	params = hci_conn_params_lookup(hdev, addr, addr_type);
+	if (params) {
+		params->auto_connect = auto_connect;
+		params->conn_min_interval = conn_min_interval;
+		params->conn_max_interval = conn_max_interval;
+		return;
+	}
+
+	params = kzalloc(sizeof(*params), GFP_KERNEL);
+	if (!params) {
+		BT_ERR("Out of memory");
+		return;
+	}
+
+	bacpy(&params->addr, addr);
+	params->addr_type = addr_type;
+	params->auto_connect = auto_connect;
+	params->conn_min_interval = conn_min_interval;
+	params->conn_max_interval = conn_max_interval;
+
+	list_add(&params->list, &hdev->le_conn_params);
+
+	BT_DBG("addr %pMR (type %u) auto_connect %u conn_min_interval 0x%.4x "
+	       "conn_max_interval 0x%.4x", addr, addr_type, auto_connect,
+	       conn_min_interval, conn_max_interval);
+}
+
+/* This function requires the caller holds hdev->lock */
+void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type)
+{
+	struct hci_conn_params *params;
+
+	params = hci_conn_params_lookup(hdev, addr, addr_type);
+	if (!params)
+		return;
+
+	list_del(&params->list);
+	kfree(params);
+
+	BT_DBG("addr %pMR (type %u)", addr, addr_type);
+}
+
+/* This function requires the caller holds hdev->lock */
+void hci_conn_params_clear(struct hci_dev *hdev)
+{
+	struct hci_conn_params *params, *tmp;
+
+	list_for_each_entry_safe(params, tmp, &hdev->le_conn_params, list) {
+		list_del(&params->list);
+		kfree(params);
+	}
+
+	BT_DBG("All LE connection parameters were removed");
+}
+
 static void inquiry_complete(struct hci_dev *hdev, u8 status)
 {
 	if (status) {
@@ -3043,6 +3121,7 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_LIST_HEAD(&hdev->link_keys);
 	INIT_LIST_HEAD(&hdev->long_term_keys);
 	INIT_LIST_HEAD(&hdev->remote_oob_data);
+	INIT_LIST_HEAD(&hdev->le_conn_params);
 	INIT_LIST_HEAD(&hdev->conn_hash.list);
 
 	INIT_WORK(&hdev->rx_work, hci_rx_work);
@@ -3228,6 +3307,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 	hci_link_keys_clear(hdev);
 	hci_smp_ltks_clear(hdev);
 	hci_remote_oob_data_clear(hdev);
+	hci_conn_params_clear(hdev);
 	hci_dev_unlock(hdev);
 
 	hci_dev_put(hdev);
-- 
1.8.5.3

