Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Add opcode parameter to hci_req_complete_t callback
Date: Sun, 11 Jan 2015 13:50:44 -0800
Message-Id: <1421013044-8613-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When hci_req_run() calls its provided complete function and one of the
HCI commands in the sequence fails, then provide the opcode of failing
command. In case of success HCI_OP_NOP is provided since all commands
completed.

This patch fixes the prototype of hci_req_complete_t and all its users.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/bluetooth.h |  2 +-
 net/bluetooth/hci_conn.c          |  2 +-
 net/bluetooth/hci_core.c          |  9 ++++----
 net/bluetooth/hci_request.c       |  3 ++-
 net/bluetooth/mgmt.c              | 44 ++++++++++++++++++++++-----------------
 5 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 58695ffeb138..e00455aab18c 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -273,7 +273,7 @@ struct l2cap_ctrl {
 
 struct hci_dev;
 
-typedef void (*hci_req_complete_t)(struct hci_dev *hdev, u8 status);
+typedef void (*hci_req_complete_t)(struct hci_dev *hdev, u8 status, u16 opcode);
 
 struct hci_req_ctrl {
 	bool			start;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 75240aaca101..2e724e0b75b9 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -633,7 +633,7 @@ void hci_le_conn_failed(struct hci_conn *conn, u8 status)
 	mgmt_reenable_advertising(hdev);
 }
 
-static void create_le_conn_complete(struct hci_dev *hdev, u8 status)
+static void create_le_conn_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 {
 	struct hci_conn *conn;
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a3d3cafe6588..96572a48948e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -141,7 +141,7 @@ static const struct file_operations dut_mode_fops = {
 
 /* ---- HCI requests ---- */
 
-static void hci_req_sync_complete(struct hci_dev *hdev, u8 result)
+static void hci_req_sync_complete(struct hci_dev *hdev, u8 result, u16 opcode)
 {
 	BT_DBG("%s result 0x%2.2x", hdev->name, result);
 
@@ -2762,7 +2762,7 @@ void hci_conn_params_clear_all(struct hci_dev *hdev)
 	BT_DBG("All LE connection parameters were removed");
 }
 
-static void inquiry_complete(struct hci_dev *hdev, u8 status)
+static void inquiry_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 {
 	if (status) {
 		BT_ERR("Failed to start inquiry: status %d", status);
@@ -2774,7 +2774,8 @@ static void inquiry_complete(struct hci_dev *hdev, u8 status)
 	}
 }
 
-static void le_scan_disable_work_complete(struct hci_dev *hdev, u8 status)
+static void le_scan_disable_work_complete(struct hci_dev *hdev, u8 status,
+					  u16 opcode)
 {
 	/* General inquiry access code (GIAC) */
 	u8 lap[3] = { 0x33, 0x8b, 0x9e };
@@ -4167,7 +4168,7 @@ void hci_req_cmd_complete(struct hci_dev *hdev, u16 opcode, u8 status)
 
 call_complete:
 	if (req_complete)
-		req_complete(hdev, status);
+		req_complete(hdev, status, status ? opcode : HCI_OP_NOP);
 }
 
 static void hci_rx_work(struct work_struct *work)
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 324c6418b17c..b59f92c6df0c 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -533,7 +533,8 @@ void __hci_update_background_scan(struct hci_request *req)
 	}
 }
 
-static void update_background_scan_complete(struct hci_dev *hdev, u8 status)
+static void update_background_scan_complete(struct hci_dev *hdev, u8 status,
+					    u16 opcode)
 {
 	if (status)
 		BT_DBG("HCI request failed to update background scanning: "
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6b3f5537e441..e531da805923 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1251,7 +1251,7 @@ static int send_settings_rsp(struct sock *sk, u16 opcode, struct hci_dev *hdev)
 			    sizeof(settings));
 }
 
-static void clean_up_hci_complete(struct hci_dev *hdev, u8 status)
+static void clean_up_hci_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 {
 	BT_DBG("%s status 0x%02x", hdev->name, status);
 
@@ -1518,7 +1518,8 @@ static u8 mgmt_le_support(struct hci_dev *hdev)
 		return MGMT_STATUS_SUCCESS;
 }
 
-static void set_discoverable_complete(struct hci_dev *hdev, u8 status)
+static void set_discoverable_complete(struct hci_dev *hdev, u8 status,
+				      u16 opcode)
 {
 	struct pending_cmd *cmd;
 	struct mgmt_mode *cp;
@@ -1777,7 +1778,8 @@ static void write_fast_connectable(struct hci_request *req, bool enable)
 		hci_req_add(req, HCI_OP_WRITE_PAGE_SCAN_TYPE, 1, &type);
 }
 
-static void set_connectable_complete(struct hci_dev *hdev, u8 status)
+static void set_connectable_complete(struct hci_dev *hdev, u8 status,
+				     u16 opcode)
 {
 	struct pending_cmd *cmd;
 	struct mgmt_mode *cp;
@@ -2195,7 +2197,7 @@ unlock:
 	return err;
 }
 
-static void le_enable_complete(struct hci_dev *hdev, u8 status)
+static void le_enable_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 {
 	struct cmd_lookup match = { NULL, hdev };
 
@@ -2385,7 +2387,7 @@ unlock:
 	hci_dev_unlock(hdev);
 }
 
-static void add_uuid_complete(struct hci_dev *hdev, u8 status)
+static void add_uuid_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 {
 	BT_DBG("status 0x%02x", status);
 
@@ -2464,7 +2466,7 @@ static bool enable_service_cache(struct hci_dev *hdev)
 	return false;
 }
 
-static void remove_uuid_complete(struct hci_dev *hdev, u8 status)
+static void remove_uuid_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 {
 	BT_DBG("status 0x%02x", status);
 
@@ -2549,7 +2551,7 @@ unlock:
 	return err;
 }
 
-static void set_class_complete(struct hci_dev *hdev, u8 status)
+static void set_class_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 {
 	BT_DBG("status 0x%02x", status);
 
@@ -3483,7 +3485,7 @@ static void update_name(struct hci_request *req)
 	hci_req_add(req, HCI_OP_WRITE_LOCAL_NAME, sizeof(cp), &cp);
 }
 
-static void set_name_complete(struct hci_dev *hdev, u8 status)
+static void set_name_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 {
 	struct mgmt_cp_set_local_name *cp;
 	struct pending_cmd *cmd;
@@ -3834,7 +3836,8 @@ static bool trigger_discovery(struct hci_request *req, u8 *status)
 	return true;
 }
 
-static void start_discovery_complete(struct hci_dev *hdev, u8 status)
+static void start_discovery_complete(struct hci_dev *hdev, u8 status,
+				     u16 opcode)
 {
 	struct pending_cmd *cmd;
 	unsigned long timeout;
@@ -4063,7 +4066,7 @@ failed:
 	return err;
 }
 
-static void stop_discovery_complete(struct hci_dev *hdev, u8 status)
+static void stop_discovery_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 {
 	struct pending_cmd *cmd;
 
@@ -4289,7 +4292,8 @@ static int set_device_id(struct sock *sk, struct hci_dev *hdev, void *data,
 	return err;
 }
 
-static void set_advertising_complete(struct hci_dev *hdev, u8 status)
+static void set_advertising_complete(struct hci_dev *hdev, u8 status,
+				     u16 opcode)
 {
 	struct cmd_lookup match = { NULL, hdev };
 
@@ -4496,7 +4500,8 @@ static int set_scan_params(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
-static void fast_connectable_complete(struct hci_dev *hdev, u8 status)
+static void fast_connectable_complete(struct hci_dev *hdev, u8 status,
+				      u16 opcode)
 {
 	struct pending_cmd *cmd;
 
@@ -4594,7 +4599,7 @@ unlock:
 	return err;
 }
 
-static void set_bredr_complete(struct hci_dev *hdev, u8 status)
+static void set_bredr_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 {
 	struct pending_cmd *cmd;
 
@@ -5119,7 +5124,8 @@ static int conn_info_cmd_complete(struct pending_cmd *cmd, u8 status)
 	return err;
 }
 
-static void conn_info_refresh_complete(struct hci_dev *hdev, u8 hci_status)
+static void conn_info_refresh_complete(struct hci_dev *hdev, u8 hci_status,
+				       u16 opcode)
 {
 	struct hci_cp_read_rssi *cp;
 	struct pending_cmd *cmd;
@@ -5326,7 +5332,7 @@ complete:
 	return err;
 }
 
-static void get_clock_info_complete(struct hci_dev *hdev, u8 status)
+static void get_clock_info_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 {
 	struct hci_cp_read_clock *hci_cp;
 	struct pending_cmd *cmd;
@@ -5504,7 +5510,7 @@ static void device_added(struct sock *sk, struct hci_dev *hdev,
 	mgmt_event(MGMT_EV_DEVICE_ADDED, hdev, &ev, sizeof(ev), sk);
 }
 
-static void add_device_complete(struct hci_dev *hdev, u8 status)
+static void add_device_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 {
 	struct pending_cmd *cmd;
 
@@ -5627,7 +5633,7 @@ static void device_removed(struct sock *sk, struct hci_dev *hdev,
 	mgmt_event(MGMT_EV_DEVICE_REMOVED, hdev, &ev, sizeof(ev), sk);
 }
 
-static void remove_device_complete(struct hci_dev *hdev, u8 status)
+static void remove_device_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 {
 	struct pending_cmd *cmd;
 
@@ -6205,7 +6211,7 @@ static void restart_le_actions(struct hci_request *req)
 	__hci_update_background_scan(req);
 }
 
-static void powered_complete(struct hci_dev *hdev, u8 status)
+static void powered_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 {
 	struct cmd_lookup match = { NULL, hdev };
 
@@ -7316,7 +7322,7 @@ void mgmt_discovering(struct hci_dev *hdev, u8 discovering)
 	mgmt_event(MGMT_EV_DISCOVERING, hdev, &ev, sizeof(ev), NULL);
 }
 
-static void adv_enable_complete(struct hci_dev *hdev, u8 status)
+static void adv_enable_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 {
 	BT_DBG("%s status %u", hdev->name, status);
 }
-- 
2.1.0

