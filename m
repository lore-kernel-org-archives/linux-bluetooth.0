Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/7] android: Remove bt_adapter structure
Date: Tue, 12 Nov 2013 00:24:11 +0000
Message-Id: <1384215857-19679-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1384215857-19679-1-git-send-email-szymon.janc@tieto.com>
References: <1384215857-19679-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Only one controller is used so there is no need to keep extra
abstraction for it.
---
 android/adapter.c | 271 +++++++++++++++++++++++++-----------------------------
 1 file changed, 123 insertions(+), 148 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index 65b3170..e161f9d 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -58,23 +58,17 @@ static int notification_sk = -1;
 /* This list contains addresses which are asked for records */
 static GSList *browse_reqs;
 
-struct bt_adapter {
-	uint16_t index;
-	struct mgmt *mgmt;
+static uint16_t adapter_index = MGMT_INDEX_NONE;
+static struct mgmt *mgmt_if = NULL;
+static bt_adapter_ready adapter_ready = NULL;
+static bdaddr_t adapter_bdaddr;
+static uint32_t adapter_dev_class = 0;
+static char *adapter_name = NULL;
+static uint32_t current_settings = 0;
 
-	bt_adapter_ready ready;
+static bool adapter_discovering = false;
 
-	bdaddr_t bdaddr;
-	uint32_t dev_class;
-
-	char *name;
-
-	uint32_t supported_settings;
-	uint32_t current_settings;
-
-	bool discovering;
-	uint32_t discoverable_timeout;
-};
+uint32_t adapter_discoverable_timeout = DEFAULT_DISCOVERABLE_TIMEOUT;
 
 struct browse_req {
 	bdaddr_t bdaddr;
@@ -90,7 +84,6 @@ static const uint16_t uuid_list[] = {
 	0
 };
 
-static struct bt_adapter *adapter;
 static GSList *found_devices = NULL;
 
 static void adapter_name_changed(const uint8_t *name)
@@ -115,13 +108,13 @@ static void adapter_name_changed(const uint8_t *name)
 
 static void adapter_set_name(const uint8_t *name)
 {
-	if (!g_strcmp0(adapter->name, (const char *) name))
+	if (!g_strcmp0(adapter_name, (const char *) name))
 		return;
 
 	DBG("%s", name);
 
-	g_free(adapter->name);
-	adapter->name = g_strdup((const char *) name);
+	g_free(adapter_name);
+	adapter_name = g_strdup((const char *) name);
 
 	adapter_name_changed(name);
 }
@@ -145,7 +138,7 @@ static void powered_changed(void)
 {
 	struct hal_ev_adapter_state_changed ev;
 
-	ev.state = (adapter->current_settings & MGMT_SETTING_POWERED) ?
+	ev.state = (current_settings & MGMT_SETTING_POWERED) ?
 						HAL_POWER_ON : HAL_POWER_OFF;
 
 	DBG("%u", ev.state);
@@ -158,8 +151,8 @@ static uint8_t settings2scan_mode(void)
 {
 	bool connectable, discoverable;
 
-	connectable = adapter->current_settings & MGMT_SETTING_CONNECTABLE;
-	discoverable = adapter->current_settings & MGMT_SETTING_DISCOVERABLE;
+	connectable = current_settings & MGMT_SETTING_CONNECTABLE;
+	discoverable = current_settings & MGMT_SETTING_DISCOVERABLE;
 
 	if (connectable && discoverable)
 		return HAL_ADAPTER_SCAN_MODE_CONN_DISC;
@@ -201,7 +194,7 @@ static void adapter_class_changed(void)
 
 	ev->props[0].type = HAL_PROP_ADAPTER_CLASS;
 	ev->props[0].len = sizeof(uint32_t);
-	memcpy(ev->props->val, &adapter->dev_class, sizeof(uint32_t));
+	memcpy(ev->props->val, &adapter_dev_class, sizeof(uint32_t));
 
 	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH,
 			HAL_EV_ADAPTER_PROPS_CHANGED, sizeof(buf), buf, -1);
@@ -212,9 +205,9 @@ static void settings_changed(uint32_t settings)
 	uint32_t changed_mask;
 	uint32_t scan_mode_mask;
 
-	changed_mask = adapter->current_settings ^ settings;
+	changed_mask = current_settings ^ settings;
 
-	adapter->current_settings = settings;
+	current_settings = settings;
 
 	DBG("0x%08x", changed_mask);
 
@@ -229,7 +222,7 @@ static void settings_changed(uint32_t settings)
 	 * Only when powered, the connectable and discoverable
 	 * state changes should be communicated.
 	 */
-	if (adapter->current_settings & MGMT_SETTING_POWERED)
+	if (current_settings & MGMT_SETTING_POWERED)
 		if (changed_mask & scan_mode_mask)
 			scan_mode_changed();
 }
@@ -246,10 +239,9 @@ static void new_settings_callback(uint16_t index, uint16_t length,
 
 	settings = bt_get_le32(param);
 
-	DBG("settings: 0x%8.8x -> 0x%8.8x", adapter->current_settings,
-								settings);
+	DBG("settings: 0x%8.8x -> 0x%8.8x", current_settings, settings);
 
-	if (settings == adapter->current_settings)
+	if (settings == current_settings)
 		return;
 
 	settings_changed(settings);
@@ -268,12 +260,12 @@ static void mgmt_dev_class_changed_event(uint16_t index, uint16_t length,
 
 	dev_class = rp->val[0] | (rp->val[1] << 8) | (rp->val[2] << 16);
 
-	if (dev_class == adapter->dev_class)
+	if (dev_class == adapter_dev_class)
 		return;
 
 	DBG("Class: 0x%06x", dev_class);
 
-	adapter->dev_class = dev_class;
+	adapter_dev_class = dev_class;
 
 	adapter_class_changed();
 
@@ -410,7 +402,7 @@ static void browse_cb(sdp_list_t *recs, int err, gpointer user_data)
 	/* Search for mandatory uuids */
 	if (uuid_list[req->search_uuid]) {
 		sdp_uuid16_create(&uuid, uuid_list[req->search_uuid++]);
-		bt_search_service(&adapter->bdaddr, &req->bdaddr, &uuid,
+		bt_search_service(&adapter_bdaddr, &req->bdaddr, &uuid,
 						browse_cb, user_data, NULL);
 		return;
 	}
@@ -442,7 +434,7 @@ static uint8_t browse_remote_sdp(const bdaddr_t *addr)
 	bacpy(&req->bdaddr, addr);
 	sdp_uuid16_create(&uuid, uuid_list[req->search_uuid++]);
 
-	if (bt_search_service(&adapter->bdaddr,
+	if (bt_search_service(&adapter_bdaddr,
 			&req->bdaddr, &uuid, browse_cb, req, NULL) < 0) {
 		browse_req_free(req);
 		return false;
@@ -597,17 +589,17 @@ static void mgmt_discovering_event(uint16_t index, uint16_t length,
 		return;
 	}
 
-	DBG("hci%u type %u discovering %u", adapter->index, ev->type,
+	DBG("hci%u type %u discovering %u", adapter_index, ev->type,
 							ev->discovering);
 
-	if (adapter->discovering == !!ev->discovering)
+	if (adapter_discovering == !!ev->discovering)
 		return;
 
-	adapter->discovering = !!ev->discovering;
+	adapter_discovering = !!ev->discovering;
 
 	DBG("new discovering state %u", ev->discovering);
 
-	if (adapter->discovering) {
+	if (adapter_discovering) {
 		cp.state = HAL_DISCOVERY_STATE_STARTED;
 	} else {
 		g_slist_free_full(found_devices, g_free);
@@ -628,7 +620,7 @@ static void confirm_device_name(const bdaddr_t *addr, uint8_t addr_type)
 	bacpy(&cp.addr.bdaddr, addr);
 	cp.addr.type = addr_type;
 
-	if (mgmt_reply(adapter->mgmt, MGMT_OP_CONFIRM_NAME, adapter->index,
+	if (mgmt_reply(mgmt_if, MGMT_OP_CONFIRM_NAME, adapter_index,
 					sizeof(cp), &cp, NULL, NULL, NULL) == 0)
 		error("Failed to send confirm name request");
 }
@@ -876,56 +868,49 @@ static void mgmt_device_unpaired_event(uint16_t index, uint16_t length,
 
 static void register_mgmt_handlers(void)
 {
-	mgmt_register(adapter->mgmt, MGMT_EV_NEW_SETTINGS, adapter->index,
+	mgmt_register(mgmt_if, MGMT_EV_NEW_SETTINGS, adapter_index,
 					new_settings_callback, NULL, NULL);
 
-	mgmt_register(adapter->mgmt, MGMT_EV_CLASS_OF_DEV_CHANGED,
-				adapter->index, mgmt_dev_class_changed_event,
-				NULL, NULL);
+	mgmt_register(mgmt_if, MGMT_EV_CLASS_OF_DEV_CHANGED, adapter_index,
+				mgmt_dev_class_changed_event, NULL, NULL);
 
-	mgmt_register(adapter->mgmt, MGMT_EV_LOCAL_NAME_CHANGED,
-				adapter->index, mgmt_local_name_changed_event,
-				NULL, NULL);
+	mgmt_register(mgmt_if, MGMT_EV_LOCAL_NAME_CHANGED, adapter_index,
+				mgmt_local_name_changed_event, NULL, NULL);
 
-	mgmt_register(adapter->mgmt, MGMT_EV_NEW_LINK_KEY, adapter->index,
+	mgmt_register(mgmt_if, MGMT_EV_NEW_LINK_KEY, adapter_index,
 					new_link_key_callback, NULL, NULL);
 
-	mgmt_register(adapter->mgmt, MGMT_EV_PIN_CODE_REQUEST, adapter->index,
+	mgmt_register(mgmt_if, MGMT_EV_PIN_CODE_REQUEST, adapter_index,
 					pin_code_request_callback, NULL, NULL);
 
-	mgmt_register(adapter->mgmt, MGMT_EV_USER_CONFIRM_REQUEST,
-				adapter->index, user_confirm_request_callback,
-				NULL, NULL);
+	mgmt_register(mgmt_if, MGMT_EV_USER_CONFIRM_REQUEST, adapter_index,
+				user_confirm_request_callback, NULL, NULL);
 
-	mgmt_register(adapter->mgmt, MGMT_EV_USER_PASSKEY_REQUEST,
-				adapter->index, user_passkey_request_callback,
-				NULL, NULL);
+	mgmt_register(mgmt_if, MGMT_EV_USER_PASSKEY_REQUEST, adapter_index,
+				user_passkey_request_callback, NULL, NULL);
 
-	mgmt_register(adapter->mgmt, MGMT_EV_PASSKEY_NOTIFY, adapter->index,
+	mgmt_register(mgmt_if, MGMT_EV_PASSKEY_NOTIFY, adapter_index,
 				user_passkey_notify_callback, NULL, NULL);
 
-	mgmt_register(adapter->mgmt, MGMT_EV_DISCOVERING, adapter->index,
-							mgmt_discovering_event,
-							NULL, NULL);
+	mgmt_register(mgmt_if, MGMT_EV_DISCOVERING, adapter_index,
+					mgmt_discovering_event, NULL, NULL);
 
-	mgmt_register(adapter->mgmt, MGMT_EV_DEVICE_FOUND,
-					adapter->index, mgmt_device_found_event,
-					NULL, NULL);
+	mgmt_register(mgmt_if, MGMT_EV_DEVICE_FOUND, adapter_index,
+					mgmt_device_found_event, NULL, NULL);
 
-	mgmt_register(adapter->mgmt, MGMT_EV_DEVICE_CONNECTED, adapter->index,
+	mgmt_register(mgmt_if, MGMT_EV_DEVICE_CONNECTED, adapter_index,
 				mgmt_device_connected_event, NULL, NULL);
 
-	mgmt_register(adapter->mgmt, MGMT_EV_DEVICE_DISCONNECTED,
-				adapter->index, mgmt_device_disconnected_event,
-				NULL, NULL);
+	mgmt_register(mgmt_if, MGMT_EV_DEVICE_DISCONNECTED, adapter_index,
+				mgmt_device_disconnected_event, NULL, NULL);
 
-	mgmt_register(adapter->mgmt, MGMT_EV_CONNECT_FAILED, adapter->index,
+	mgmt_register(mgmt_if, MGMT_EV_CONNECT_FAILED, adapter_index,
 				mgmt_connect_failed_event, NULL, NULL);
 
-	mgmt_register(adapter->mgmt, MGMT_EV_AUTH_FAILED, adapter->index,
+	mgmt_register(mgmt_if, MGMT_EV_AUTH_FAILED, adapter_index,
 				mgmt_auth_failed_event, NULL, NULL);
 
-	mgmt_register(adapter->mgmt, MGMT_EV_DEVICE_UNPAIRED, adapter->index,
+	mgmt_register(mgmt_if, MGMT_EV_DEVICE_UNPAIRED, adapter_index,
 				mgmt_device_unpaired_event, NULL, NULL);
 }
 
@@ -936,18 +921,18 @@ static void load_link_keys_complete(uint8_t status, uint16_t length,
 
 	if (status) {
 		error("Failed to load link keys for index %u: %s (0x%02x)",
-			adapter->index, mgmt_errstr(status), status);
+				adapter_index, mgmt_errstr(status), status);
 		err = -EIO;
 		goto failed;
 	}
 
 	DBG("status %u", status);
 
-	adapter->ready(0);
+	adapter_ready(0);
 	return;
 
 failed:
-	adapter->ready(err);
+	adapter_ready(err);
 }
 
 static void load_link_keys(GSList *keys)
@@ -975,14 +960,14 @@ static void load_link_keys(GSList *keys)
 	for (key = cp->keys; keys != NULL; keys = g_slist_next(keys), key++)
 		memcpy(key, keys->data, sizeof(*key));
 
-	id = mgmt_send(adapter->mgmt, MGMT_OP_LOAD_LINK_KEYS, adapter->index,
+	id = mgmt_send(mgmt_if, MGMT_OP_LOAD_LINK_KEYS, adapter_index,
 			cp_size, cp, load_link_keys_complete, NULL, NULL);
 
 	g_free(cp);
 
 	if (id == 0) {
 		error("Failed to load link keys");
-		adapter->ready(-EIO);
+		adapter_ready(-EIO);
 	}
 }
 
@@ -1000,7 +985,7 @@ static void set_mode_complete(uint8_t status, uint16_t length,
 	 * required in both cases. So it is safe to just call the
 	 * event handling functions here.
 	 */
-	new_settings_callback(adapter->index, length, param, NULL);
+	new_settings_callback(adapter_index, length, param, NULL);
 }
 
 static bool set_mode(uint16_t opcode, uint8_t mode)
@@ -1012,7 +997,7 @@ static bool set_mode(uint16_t opcode, uint8_t mode)
 
 	DBG("opcode=0x%x mode=0x%x", opcode, mode);
 
-	if (mgmt_send(adapter->mgmt, opcode, adapter->index, sizeof(cp), &cp,
+	if (mgmt_send(mgmt_if, opcode, adapter_index, sizeof(cp), &cp,
 					set_mode_complete, NULL, NULL) > 0)
 		return true;
 
@@ -1028,9 +1013,8 @@ static void set_io_capability(void)
 	memset(&cp, 0, sizeof(cp));
 	cp.io_capability = DEFAULT_IO_CAPABILITY;
 
-	if (mgmt_send(adapter->mgmt, MGMT_OP_SET_IO_CAPABILITY,
-				adapter->index, sizeof(cp), &cp,
-				NULL, NULL, NULL) == 0)
+	if (mgmt_send(mgmt_if, MGMT_OP_SET_IO_CAPABILITY, adapter_index,
+				sizeof(cp), &cp, NULL, NULL, NULL) == 0)
 		error("Failed to set IO capability");
 }
 
@@ -1048,9 +1032,8 @@ static void set_device_id(void)
 	cp.product = htobs(0x0247);		/* BlueZ for Android */
 	cp.version = htobs(major << 8 | minor);
 
-	if (mgmt_send(adapter->mgmt, MGMT_OP_SET_DEVICE_ID,
-				adapter->index, sizeof(cp), &cp,
-				NULL, NULL, NULL) == 0)
+	if (mgmt_send(mgmt_if, MGMT_OP_SET_DEVICE_ID, adapter_index,
+				sizeof(cp), &cp, NULL, NULL, NULL) == 0)
 		error("Failed to set device id");
 }
 
@@ -1075,9 +1058,9 @@ static uint8_t set_adapter_name(uint8_t *name, uint16_t len)
 	memset(&cp, 0, sizeof(cp));
 	memcpy(cp.name, name, len);
 
-	if (mgmt_send(adapter->mgmt, MGMT_OP_SET_LOCAL_NAME, adapter->index,
-			sizeof(cp), &cp, set_adapter_name_complete, NULL,
-								NULL) > 0)
+	if (mgmt_send(mgmt_if, MGMT_OP_SET_LOCAL_NAME, adapter_index,
+				sizeof(cp), &cp, set_adapter_name_complete,
+				NULL, NULL) > 0)
 		return HAL_STATUS_SUCCESS;
 
 	error("Failed to set name");
@@ -1092,7 +1075,7 @@ static uint8_t set_discoverable_timeout(uint8_t *timeout)
 	 * Just need to store this value here */
 
 	/* TODO: This should be in some storage */
-	memcpy(&adapter->discoverable_timeout, timeout, sizeof(uint32_t));
+	memcpy(&adapter_discoverable_timeout, timeout, sizeof(uint32_t));
 
 	return HAL_STATUS_SUCCESS;
 }
@@ -1100,14 +1083,14 @@ static void read_info_complete(uint8_t status, uint16_t length, const void *para
 							void *user_data)
 {
 	const struct mgmt_rp_read_info *rp = param;
-	uint32_t missing_settings;
+	uint32_t missing_settings, supported_settings;
 	int err;
 
 	DBG("");
 
 	if (status) {
 		error("Failed to read info for index %u: %s (0x%02x)",
-				adapter->index, mgmt_errstr(status), status);
+				adapter_index, mgmt_errstr(status), status);
 		err = -EIO;
 		goto failed;
 	}
@@ -1125,13 +1108,15 @@ static void read_info_complete(uint8_t status, uint16_t length, const void *para
 	}
 
 	/* Store adapter information */
-	bacpy(&adapter->bdaddr, &rp->bdaddr);
-	adapter->dev_class = rp->dev_class[0] | (rp->dev_class[1] << 8) |
+	bacpy(&adapter_bdaddr, &rp->bdaddr);
+	adapter_dev_class = rp->dev_class[0] | (rp->dev_class[1] << 8) |
 						(rp->dev_class[2] << 16);
-	adapter->name = g_strdup((const char *) rp->name);
+	adapter_name = g_strdup((const char *) rp->name);
 
-	adapter->supported_settings = btohs(rp->supported_settings);
-	adapter->current_settings = btohs(rp->current_settings);
+	supported_settings = btohs(rp->supported_settings);
+	current_settings = btohs(rp->current_settings);
+
+	/* TODO: Read discoverable timeout from storage here */
 
 	/* TODO: Register all event notification handlers */
 	register_mgmt_handlers();
@@ -1141,8 +1126,7 @@ static void read_info_complete(uint8_t status, uint16_t length, const void *para
 	set_io_capability();
 	set_device_id();
 
-	missing_settings = adapter->current_settings ^
-						adapter->supported_settings;
+	missing_settings = current_settings ^ supported_settings;
 
 	if (missing_settings & MGMT_SETTING_SSP)
 		set_mode(MGMT_OP_SET_SSP, 0x01);
@@ -1153,26 +1137,21 @@ static void read_info_complete(uint8_t status, uint16_t length, const void *para
 	return;
 
 failed:
-	adapter->ready(err);
+	adapter_ready(err);
 }
 
 void bt_adapter_init(uint16_t index, struct mgmt *mgmt, bt_adapter_ready cb)
 {
-	adapter = g_new0(struct bt_adapter, 1);
-
-	adapter->mgmt = mgmt_ref(mgmt);
-	adapter->index = index;
-	adapter->discovering = false;
-	adapter->ready = cb;
-	/* TODO: Read it from some storage */
-	adapter->discoverable_timeout = DEFAULT_DISCOVERABLE_TIMEOUT;
+	mgmt_if = mgmt_ref(mgmt);
+	adapter_index = index;
+	adapter_ready = cb;
 
 	if (mgmt_send(mgmt, MGMT_OP_READ_INFO, index, 0, NULL,
 					read_info_complete, NULL, NULL) > 0)
 		return;
 
-	mgmt_unref(adapter->mgmt);
-	adapter->ready(-EIO);
+	mgmt_unref(mgmt_if);
+	adapter_ready(-EIO);
 }
 
 static bool set_discoverable(uint8_t mode, uint16_t timeout)
@@ -1185,9 +1164,8 @@ static bool set_discoverable(uint8_t mode, uint16_t timeout)
 
 	DBG("mode %u timeout %u", mode, timeout);
 
-	if (mgmt_send(adapter->mgmt, MGMT_OP_SET_DISCOVERABLE,
-				adapter->index, sizeof(cp), &cp,
-				set_mode_complete, adapter, NULL) > 0)
+	if (mgmt_send(mgmt_if, MGMT_OP_SET_DISCOVERABLE, adapter_index,
+			sizeof(cp), &cp, set_mode_complete, NULL, NULL) > 0)
 		return true;
 
 	error("Failed to set mode discoverable");
@@ -1205,7 +1183,7 @@ static void get_address(void)
 
 	ev->props[0].type = HAL_PROP_ADAPTER_ADDR;
 	ev->props[0].len = sizeof(bdaddr_t);
-	bdaddr2android(&adapter->bdaddr, ev->props[0].val);
+	bdaddr2android(&adapter_bdaddr, ev->props[0].val);
 
 	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH,
 			HAL_EV_ADAPTER_PROPS_CHANGED, sizeof(buf), buf, -1);
@@ -1213,10 +1191,10 @@ static void get_address(void)
 
 static bool get_name(void)
 {
-	if (!adapter->name)
+	if (!adapter_name)
 		return false;
 
-	adapter_name_changed((uint8_t *) adapter->name);
+	adapter_name_changed((uint8_t *) adapter_name);
 
 	return true;
 }
@@ -1288,7 +1266,7 @@ static bool get_discoverable_timeout(void)
 
 	ev->props[0].type = HAL_PROP_ADAPTER_DISC_TIMEOUT;
 	ev->props[0].len = sizeof(uint32_t);
-	memcpy(&ev->props[0].val, &adapter->discoverable_timeout,
+	memcpy(&ev->props[0].val, &adapter_discoverable_timeout,
 							sizeof(uint32_t));
 
 	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH,
@@ -1344,15 +1322,15 @@ static bool start_discovery(void)
 	struct mgmt_cp_start_discovery cp;
 	uint8_t type = 1 << BDADDR_BREDR;
 
-	if (adapter->current_settings & type)
+	if (current_settings & type)
 		cp.type = type;
 	else
 		cp.type = 0;
 
 	DBG("type=0x%x", type);
 
-	if (mgmt_send(adapter->mgmt, MGMT_OP_START_DISCOVERY, adapter->index,
-			sizeof(cp), &cp, NULL, NULL, NULL) > 0)
+	if (mgmt_send(mgmt_if, MGMT_OP_START_DISCOVERY, adapter_index,
+					sizeof(cp), &cp, NULL, NULL, NULL) > 0)
 		return true;
 
 	error("Failed to start discovery");
@@ -1364,15 +1342,15 @@ static bool stop_discovery(void)
 	struct mgmt_cp_stop_discovery cp;
 	uint8_t type = 1 << BDADDR_BREDR;
 
-	if (adapter->current_settings & type)
+	if (current_settings & type)
 		cp.type = type;
 	else
 		cp.type = 0;
 
 	DBG("type=0x%x", type);
 
-	if (mgmt_send(adapter->mgmt, MGMT_OP_STOP_DISCOVERY, adapter->index,
-			sizeof(cp), &cp, NULL, NULL, NULL) > 0)
+	if (mgmt_send(mgmt_if, MGMT_OP_STOP_DISCOVERY, adapter_index,
+					sizeof(cp), &cp, NULL, NULL, NULL) > 0)
 		return true;
 
 	error("Failed to start discovery");
@@ -1384,8 +1362,8 @@ static uint8_t set_scan_mode(void *buf, uint16_t len)
 	uint8_t *mode = buf;
 	bool conn, disc, cur_conn, cur_disc;
 
-	cur_conn = adapter->current_settings & MGMT_SETTING_CONNECTABLE;
-	cur_disc = adapter->current_settings & MGMT_SETTING_DISCOVERABLE;
+	cur_conn = current_settings & MGMT_SETTING_CONNECTABLE;
+	cur_disc = current_settings & MGMT_SETTING_DISCOVERABLE;
 
 	DBG("connectable %u discoverable %d mode %u", cur_conn, cur_disc,
 								*mode);
@@ -1499,9 +1477,8 @@ static bool create_bond(void *buf, uint16_t len)
 	cp.addr.type = BDADDR_BREDR;
 	android2bdaddr(cmd->bdaddr, &cp.addr.bdaddr);
 
-	if (mgmt_send(adapter->mgmt, MGMT_OP_PAIR_DEVICE, adapter->index,
-				sizeof(cp), &cp, pair_device_complete, NULL,
-				NULL) == 0)
+	if (mgmt_send(mgmt_if, MGMT_OP_PAIR_DEVICE, adapter_index, sizeof(cp),
+				&cp, pair_device_complete, NULL, NULL) == 0)
 		return false;
 
 	send_bond_state_change(&cp.addr.bdaddr, HAL_STATUS_SUCCESS,
@@ -1518,9 +1495,8 @@ static bool cancel_bond(void *buf, uint16_t len)
 	cp.type = BDADDR_BREDR;
 	android2bdaddr(cmd->bdaddr, &cp.bdaddr);
 
-	return mgmt_reply(adapter->mgmt, MGMT_OP_CANCEL_PAIR_DEVICE,
-				adapter->index, sizeof(cp), &cp, NULL, NULL,
-				NULL) > 0;
+	return mgmt_reply(mgmt_if, MGMT_OP_CANCEL_PAIR_DEVICE, adapter_index,
+					sizeof(cp), &cp, NULL, NULL, NULL) > 0;
 }
 
 static void unpair_device_complete(uint8_t status, uint16_t length,
@@ -1546,9 +1522,9 @@ static bool remove_bond(void *buf, uint16_t len)
 	cp.addr.type = BDADDR_BREDR;
 	android2bdaddr(cmd->bdaddr, &cp.addr.bdaddr);
 
-	return mgmt_send(adapter->mgmt, MGMT_OP_UNPAIR_DEVICE,
-				adapter->index, sizeof(cp), &cp,
-				unpair_device_complete, NULL, NULL) > 0;
+	return mgmt_send(mgmt_if, MGMT_OP_UNPAIR_DEVICE, adapter_index,
+				sizeof(cp), &cp, unpair_device_complete,
+				NULL, NULL) > 0;
 }
 
 static uint8_t pin_reply(void *buf, uint16_t len)
@@ -1575,9 +1551,8 @@ static uint8_t pin_reply(void *buf, uint16_t len)
 		rp.pin_len = cmd->pin_len;
 		memcpy(rp.pin_code, cmd->pin_code, rp.pin_len);
 
-		if (mgmt_reply(adapter->mgmt, MGMT_OP_PIN_CODE_REPLY,
-					adapter->index, sizeof(rp), &rp,
-					NULL, NULL, NULL) == 0)
+		if (mgmt_reply(mgmt_if, MGMT_OP_PIN_CODE_REPLY, adapter_index,
+				sizeof(rp), &rp, NULL, NULL, NULL) == 0)
 			return HAL_STATUS_FAILED;
 	} else {
 		struct mgmt_cp_pin_code_neg_reply rp;
@@ -1585,9 +1560,9 @@ static uint8_t pin_reply(void *buf, uint16_t len)
 		bacpy(&rp.addr.bdaddr, &bdaddr);
 		rp.addr.type = BDADDR_BREDR;
 
-		if (mgmt_reply(adapter->mgmt, MGMT_OP_PIN_CODE_NEG_REPLY,
-					adapter->index, sizeof(rp), &rp,
-					NULL, NULL, NULL) == 0)
+		if (mgmt_reply(mgmt_if, MGMT_OP_PIN_CODE_NEG_REPLY,
+						adapter_index, sizeof(rp), &rp,
+						NULL, NULL, NULL) == 0)
 			return HAL_STATUS_FAILED;
 	}
 
@@ -1607,7 +1582,7 @@ static uint8_t user_confirm_reply(const bdaddr_t *bdaddr, bool accept)
 	bacpy(&cp.bdaddr, bdaddr);
 	cp.type = BDADDR_BREDR;
 
-	if (mgmt_reply(adapter->mgmt, opcode, adapter->index, sizeof(cp), &cp,
+	if (mgmt_reply(mgmt_if, opcode, adapter_index, sizeof(cp), &cp,
 							NULL, NULL, NULL) > 0)
 		return HAL_STATUS_SUCCESS;
 
@@ -1627,9 +1602,9 @@ static uint8_t user_passkey_reply(const bdaddr_t *bdaddr, bool accept,
 		cp.addr.type = BDADDR_BREDR;
 		cp.passkey = htobl(passkey);
 
-		id = mgmt_reply(adapter->mgmt, MGMT_OP_USER_PASSKEY_REPLY,
-					adapter->index, sizeof(cp), &cp,
-					NULL, NULL, NULL);
+		id = mgmt_reply(mgmt_if, MGMT_OP_USER_PASSKEY_REPLY,
+						adapter_index, sizeof(cp), &cp,
+						NULL, NULL, NULL);
 	} else {
 		struct mgmt_cp_user_passkey_neg_reply cp;
 
@@ -1637,9 +1612,9 @@ static uint8_t user_passkey_reply(const bdaddr_t *bdaddr, bool accept,
 		bacpy(&cp.addr.bdaddr, bdaddr);
 		cp.addr.type = BDADDR_BREDR;
 
-		id = mgmt_reply(adapter->mgmt, MGMT_OP_USER_PASSKEY_NEG_REPLY,
-					adapter->index, sizeof(cp), &cp,
-					NULL, NULL, NULL);
+		id = mgmt_reply(mgmt_if, MGMT_OP_USER_PASSKEY_NEG_REPLY,
+						adapter_index, sizeof(cp), &cp,
+						NULL, NULL, NULL);
 	}
 
 	if (id == 0)
@@ -1702,7 +1677,7 @@ void bt_adapter_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 		 * enabling adapter */
 		get_properties();
 
-		if (adapter->current_settings & MGMT_SETTING_POWERED) {
+		if (current_settings & MGMT_SETTING_POWERED) {
 			status = HAL_STATUS_DONE;
 			goto error;
 		}
@@ -1712,7 +1687,7 @@ void bt_adapter_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 
 		break;
 	case HAL_OP_DISABLE:
-		if (!(adapter->current_settings & MGMT_SETTING_POWERED)) {
+		if (!(current_settings & MGMT_SETTING_POWERED)) {
 			status = HAL_STATUS_DONE;
 			goto error;
 		}
@@ -1763,12 +1738,12 @@ void bt_adapter_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 			goto error;
 		break;
 	case HAL_OP_START_DISCOVERY:
-		if (adapter->discovering) {
+		if (adapter_discovering) {
 			status = HAL_STATUS_DONE;
 			goto error;
 		}
 
-		if (!(adapter->current_settings & MGMT_SETTING_POWERED)) {
+		if (!(current_settings & MGMT_SETTING_POWERED)) {
 			status = HAL_STATUS_NOT_READY;
 			goto error;
 		}
@@ -1778,12 +1753,12 @@ void bt_adapter_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 
 		break;
 	case HAL_OP_CANCEL_DISCOVERY:
-		if (!adapter->discovering) {
+		if (!adapter_discovering) {
 			status = HAL_STATUS_DONE;
 			goto error;
 		}
 
-		if (!(adapter->current_settings & MGMT_SETTING_POWERED)) {
+		if (!(current_settings & MGMT_SETTING_POWERED)) {
 			status = HAL_STATUS_NOT_READY;
 			goto error;
 		}
@@ -1813,7 +1788,7 @@ error:
 
 const bdaddr_t *bt_adapter_get_address(void)
 {
-	return &adapter->bdaddr;
+	return &adapter_bdaddr;
 }
 
 bool bt_adapter_register(int sk)
-- 
1.8.4.2

