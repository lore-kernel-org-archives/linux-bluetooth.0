Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 08/15] Bluetooth: Add support for BT_AUTO_CONN_ALWAYS
Date: Wed, 16 Oct 2013 20:17:58 -0300
Message-Id: <1381965485-9159-9-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1381965485-9159-1-git-send-email-andre.guedes@openbossa.org>
References: <1381965485-9159-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for the BT_AUTO_CONN_ALWAYS option which
configures the kernel to autonomously establish a connection to
certain device. This option configures the kernel to always
establish the connection, no matter the reason the connection was
terminated.

This feature is required by some LE profiles such as HID over GATT,
Health Termomether and Blood Pressure. These profiles require the
host autonomously connect to the device as soon as it enters in
connectable mode (start advertising) so the device is able to
delivery a notification or indication.

The auto connection procedure the BT_AUTO_CONN_ALWAYS option implements
is summarized as follows: when a new device configured with BT_AUTO_
CONN_ALWAYS is added to the connection parameter list, the background
scan is triggered. Once the target device is found in range, the kernel
creates a connection to the device. If the connection is established
successfully, the background scan is untriggered. If the target device
disconnects, the background scan is triggered again and the whole auto
connect procedure starts again.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |  4 ++
 net/bluetooth/hci_core.c         | 92 ++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_event.c        | 36 ++++++++++++++++
 3 files changed, 132 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index cb6458a..db39eca 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -383,6 +383,7 @@ struct hci_conn_param {
 	u8 addr_type;
 
 	u8 auto_connect;
+	bool bg_scan_triggered;
 
 	u16 min_conn_interval;
 	u16 max_conn_interval;
@@ -765,6 +766,9 @@ int hci_add_conn_param(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 		       u16 max_conn_interval);
 void hci_remove_conn_param(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type);
 
+void hci_auto_connect_check(struct hci_dev *hdev, bdaddr_t *addr,
+			    u8 addr_type);
+
 int hci_uuids_clear(struct hci_dev *hdev);
 
 int hci_link_keys_clear(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c3e47e9..f232965 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2200,6 +2200,24 @@ struct hci_conn_param *hci_find_conn_param(struct hci_dev *hdev,
 	return NULL;
 }
 
+static bool is_connected(struct hci_dev *hdev, bdaddr_t *addr, u8 type)
+{
+	struct hci_conn *conn;
+
+	conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, addr);
+
+	if (!conn)
+		return false;
+
+	if (conn->dst_type != type)
+		return false;
+
+	if (conn->state != BT_CONNECTED)
+		return false;
+
+	return true;
+}
+
 int hci_add_conn_param(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 		       u8 auto_connect, u16 min_conn_interval,
 		       u16 max_conn_interval)
@@ -2221,12 +2239,29 @@ int hci_add_conn_param(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 	bacpy(&param->addr, addr);
 	param->addr_type = addr_type;
 	param->auto_connect = auto_connect;
+	param->bg_scan_triggered = false;
 	param->min_conn_interval = min_conn_interval;
 	param->max_conn_interval = max_conn_interval;
 
 	hci_dev_lock(hdev);
 	list_add_rcu(&param->list, &hdev->conn_param);
 	hci_dev_unlock(hdev);
+
+	/* If it is configured to always automatically connect and we are not
+	 * connected to the given device, we trigger the background scan so
+	 * the connection is established as soon as the device gets in range.
+	 */
+	if (auto_connect == BT_AUTO_CONN_ALWAYS &&
+	    !is_connected(hdev, addr, addr_type)) {
+		int err;
+
+		err = hci_trigger_background_scan(hdev);
+		if (err)
+			return err;
+
+		param->bg_scan_triggered = true;
+	}
+
 	return 0;
 }
 
@@ -2251,6 +2286,17 @@ void hci_remove_conn_param(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type)
 	if (!param)
 		return;
 
+	if (param->bg_scan_triggered) {
+		int err;
+
+		err = hci_untrigger_background_scan(hdev);
+		if (err)
+			BT_ERR("Failed to untrigger background scanning: %d",
+			       err);
+
+		param->bg_scan_triggered = false;
+	}
+
 	hci_dev_lock(hdev);
 	__remove_conn_param(param);
 	hci_dev_unlock(hdev);
@@ -2271,6 +2317,52 @@ static void __clear_conn_param(struct hci_dev *hdev)
 		__remove_conn_param(param);
 }
 
+void hci_auto_connect_check(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type)
+{
+	struct hci_conn_param *param;
+	struct hci_conn *conn;
+	u8 bdaddr_type;
+
+	/* If there is no background scan trigger, it means the auto connection
+	 * procedure is not runninng.
+	 */
+	if (atomic_read(&hdev->background_scan_cnt) == 0)
+		return;
+
+	param = hci_find_conn_param(hdev, addr, addr_type);
+	if (!param)
+		return;
+
+	if (!param->bg_scan_triggered)
+		goto done;
+
+	if (addr_type == ADDR_LE_DEV_PUBLIC)
+		bdaddr_type = BDADDR_LE_PUBLIC;
+	else
+		bdaddr_type = BDADDR_LE_RANDOM;
+
+	conn = hci_connect(hdev, LE_LINK, addr, bdaddr_type, BT_SECURITY_LOW,
+			   HCI_AT_NO_BONDING);
+	if (IS_ERR(conn)) {
+		switch(PTR_ERR(conn)) {
+		case -EBUSY:
+			/* When hci_connect() returns EBUSY it means there is
+			 * already an LE connection attempt going on. Since the
+			 * controller supports only one connection attempt at
+			 * the time, we simply return.
+			 */
+			goto done;
+		default:
+			BT_ERR("Failed to auto connect: err %ld",
+			       PTR_ERR(conn));
+			goto done;
+		}
+	}
+
+done:
+	hci_conn_param_put(param);
+}
+
 static void inquiry_complete(struct hci_dev *hdev, u8 status)
 {
 	if (status) {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index edb2342..b34ff1d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1782,6 +1782,7 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	struct hci_ev_disconn_complete *ev = (void *) skb->data;
 	struct hci_conn *conn;
 	u8 type;
+	struct hci_conn_param *param;
 	bool send_mgmt_event = false;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
@@ -1815,6 +1816,22 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	if (conn->type == ACL_LINK && conn->flush_key)
 		hci_remove_link_key(hdev, &conn->dst);
 
+	/* Trigger the background scan if auto connection is required for this
+	 * device.
+	 */
+	param = hci_find_conn_param(hdev, &conn->dst, conn->dst_type);
+	if (param && param->auto_connect == BT_AUTO_CONN_ALWAYS) {
+		int err;
+
+		err = hci_trigger_background_scan(hdev);
+		if (err)
+			BT_ERR("Failed to trigger background "
+					"scanning: %d", err);
+
+		param->bg_scan_triggered = true;
+		hci_conn_param_put(param);
+	}
+
 	type = conn->type;
 	hci_proto_disconn_cfm(conn, ev->reason);
 	hci_conn_del(conn);
@@ -3493,6 +3510,7 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_le_conn_complete *ev = (void *) skb->data;
 	struct hci_conn *conn;
+	struct hci_conn_param *param;
 
 	BT_DBG("%s status 0x%2.2x", hdev->name, ev->status);
 
@@ -3546,6 +3564,22 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	hci_proto_connect_cfm(conn, ev->status);
 
+	/* Since the connection has been established successfully, we should
+	 * untrigger the background scan if this is an auto connect device.
+	 */
+	param = hci_find_conn_param(hdev, &ev->bdaddr, ev->bdaddr_type);
+	if (param && param->bg_scan_triggered) {
+		int err;
+
+		err = hci_untrigger_background_scan(hdev);
+		if (err)
+			BT_ERR("Failed to untrigger background "
+					"scanning: %d", err);
+
+		param->bg_scan_triggered = false;
+		hci_conn_param_put(param);
+	}
+
 unlock:
 	hci_dev_unlock(hdev);
 }
@@ -3559,6 +3593,8 @@ static void hci_le_adv_report_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	while (num_reports--) {
 		struct hci_ev_le_advertising_info *ev = ptr;
 
+		hci_auto_connect_check(hdev, &ev->bdaddr, ev->bdaddr_type);
+
 		rssi = ev->data[ev->length];
 		mgmt_device_found(hdev, &ev->bdaddr, LE_LINK, ev->bdaddr_type,
 				  NULL, rssi, 0, 1, ev->data, ev->length);
-- 
1.8.4

