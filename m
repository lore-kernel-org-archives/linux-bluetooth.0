Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/8] Bluetooth: Create callbacks for hci device creation and deletion
Date: Fri, 23 May 2014 12:27:22 +0300
Message-Id: <1400837248-12179-3-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1400837248-12179-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1400837248-12179-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 include/net/bluetooth/hci_core.h | 27 +++++++++++++++++++++++++++
 net/bluetooth/hci_core.c         | 17 +++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b386bf1..16a07a1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1050,6 +1050,9 @@ struct hci_cb {
 								__u8 encrypt);
 	void (*key_change_cfm)	(struct hci_conn *conn, __u8 status);
 	void (*role_switch_cfm)	(struct hci_conn *conn, __u8 status, __u8 role);
+
+	void (*create_cfm)	(struct hci_dev *hdev);
+	void (*destroy_cfm)	(struct hci_dev *hdev);
 };
 
 static inline void hci_auth_cfm(struct hci_conn *conn, __u8 status)
@@ -1118,6 +1121,30 @@ static inline void hci_role_switch_cfm(struct hci_conn *conn, __u8 status,
 	read_unlock(&hci_cb_list_lock);
 }
 
+static inline void hci_created_cfm(struct hci_dev *hdev)
+{
+	struct hci_cb *cb;
+
+	read_lock(&hci_cb_list_lock);
+	list_for_each_entry(cb, &hci_cb_list, list) {
+		if (cb->create_cfm)
+			cb->create_cfm(hdev);
+	}
+	read_unlock(&hci_cb_list_lock);
+}
+
+static inline void hci_destroyed_cfm(struct hci_dev *hdev)
+{
+	struct hci_cb *cb;
+
+	read_lock(&hci_cb_list_lock);
+	list_for_each_entry(cb, &hci_cb_list, list) {
+		if (cb->destroy_cfm)
+			cb->destroy_cfm(hdev);
+	}
+	read_unlock(&hci_cb_list_lock);
+}
+
 static inline bool eir_has_data_type(u8 *data, size_t data_len, u8 type)
 {
 	size_t parsed = 0;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 0a43cce..a5d6698 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3996,6 +3996,8 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	queue_work(hdev->req_workqueue, &hdev->power_on);
 
+	hci_created_cfm(hdev);
+
 	return id;
 
 err_tfm:
@@ -4017,6 +4019,8 @@ void hci_unregister_dev(struct hci_dev *hdev)
 
 	BT_DBG("%p name %s bus %d", hdev, hdev->name, hdev->bus);
 
+	hci_destroyed_cfm(hdev);
+
 	set_bit(HCI_UNREGISTER, &hdev->dev_flags);
 
 	id = hdev->id;
@@ -4289,6 +4293,19 @@ int hci_register_cb(struct hci_cb *cb)
 	list_add(&cb->list, &hci_cb_list);
 	write_unlock(&hci_cb_list_lock);
 
+	/* Call created callback so that possible module will get
+	 * information about the hci devices.
+	 */
+	if (cb->create_cfm) {
+		struct hci_dev *hdev;
+
+		read_lock(&hci_dev_list_lock);
+		list_for_each_entry(hdev, &hci_dev_list, list) {
+			cb->create_cfm(hdev);
+		}
+		read_unlock(&hci_dev_list_lock);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL(hci_register_cb);
-- 
1.8.3.1

