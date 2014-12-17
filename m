Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 03/19] android/bluetooth: Add possibility to register for bonded event
Date: Wed, 17 Dec 2014 16:49:01 +0100
Message-Id: <1418831357-23100-4-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418831357-23100-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418831357-23100-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some modules might be interested in fact that device has been bonded.
This patch allows to register for that event

Note that callback is called only on success bonding.
---
 android/bluetooth.c | 37 +++++++++++++++++++++++++++++++++++++
 android/bluetooth.h |  4 ++++
 2 files changed, 41 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 3d60a49..096085d 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -234,6 +234,7 @@ static struct ipc *hal_ipc = NULL;
 static bool kernel_conn_control = false;
 
 static struct queue *unpaired_cb_list = NULL;
+static struct queue *paired_cb_list = NULL;
 
 static void get_device_android_addr(struct device *dev, uint8_t *addr)
 {
@@ -909,7 +910,14 @@ static void update_bond_state(struct device *dev, uint8_t status,
 						HAL_BOND_STATE_BONDING);
 
 	send_bond_state_change(dev, status, new_bond);
+}
+
+static void send_paired_notification(void *data, void *user_data)
+{
+	bt_paired_device_cb cb = data;
+	struct device *dev = user_data;
 
+	cb(&dev->bdaddr, dev->bdaddr_type);
 }
 
 static void update_device_state(struct device *dev, uint8_t addr_type,
@@ -1757,6 +1765,19 @@ void bt_unpaired_unregister(bt_unpaired_device_cb cb)
 	queue_remove(unpaired_cb_list, cb);
 }
 
+bool bt_paired_register(bt_paired_device_cb cb)
+{
+	if (queue_find(paired_cb_list, match_by_value, cb))
+		return false;
+
+	return queue_push_head(paired_cb_list, cb);
+}
+
+void bt_paired_unregister(bt_paired_device_cb cb)
+{
+	queue_remove(paired_cb_list, cb);
+}
+
 static bool rssi_above_threshold(int old, int new)
 {
 	/* only 8 dBm or more */
@@ -4327,6 +4348,9 @@ static void pair_device_complete(uint8_t status, uint16_t length,
 	 */
 	update_device_state(dev, rp->addr.type, status_mgmt2hal(status), false,
 								!status, false);
+
+	if (status == MGMT_STATUS_SUCCESS)
+		queue_foreach(paired_cb_list, send_paired_notification, dev);
 }
 
 static uint8_t select_device_bearer(struct device *dev)
@@ -5282,6 +5306,14 @@ bool bt_bluetooth_register(struct ipc *ipc, uint8_t mode)
 		return false;
 	}
 
+	paired_cb_list = queue_new();
+	if (!paired_cb_list) {
+		error("Cannot allocate queue for paired callbacks");
+		queue_destroy(unpaired_cb_list, NULL);
+		unpaired_cb_list = NULL;
+		return false;
+	}
+
 	missing_settings = adapter.current_settings ^
 						adapter.supported_settings;
 
@@ -5349,6 +5381,8 @@ bool bt_bluetooth_register(struct ipc *ipc, uint8_t mode)
 failed:
 	queue_destroy(unpaired_cb_list, NULL);
 	unpaired_cb_list = NULL;
+	queue_destroy(paired_cb_list, NULL);
+	paired_cb_list = NULL;
 
 	return false;
 }
@@ -5368,4 +5402,7 @@ void bt_bluetooth_unregister(void)
 
 	queue_destroy(unpaired_cb_list, NULL);
 	unpaired_cb_list = NULL;
+
+	queue_destroy(paired_cb_list, NULL);
+	paired_cb_list = NULL;
 }
diff --git a/android/bluetooth.h b/android/bluetooth.h
index 8970559..8e0e6e2 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -90,3 +90,7 @@ void bt_auto_connect_remove(const bdaddr_t *addr);
 typedef void (*bt_unpaired_device_cb)(const bdaddr_t *addr, uint8_t type);
 bool bt_unpaired_register(bt_unpaired_device_cb cb);
 void bt_unpaired_unregister(bt_unpaired_device_cb cb);
+
+typedef void (*bt_paired_device_cb)(const bdaddr_t *addr, uint8_t type);
+bool bt_paired_register(bt_paired_device_cb cb);
+void bt_paired_unregister(bt_paired_device_cb cb);
-- 
1.8.4

