Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 4/5] android: Use default adapter in adapter functions
Date: Thu, 24 Oct 2013 10:36:52 +0200
Message-ID: <1382603813-9157-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382603813-9157-1-git-send-email-szymon.janc@tieto.com>
References: <1382603813-9157-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@gmail.com>

There is no need to pass pointer to adapter between function as there
is only one adapter in android daemon. Also default_adapter is renamed
to adapter.

There is no need to pass adapter pointer as user data since there is
only one adapter present.
---
 android/adapter.c | 63 +++++++++++++++++++++++--------------------------------
 1 file changed, 26 insertions(+), 37 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index 0a53021..0305ccb 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -50,12 +50,11 @@ struct bt_adapter {
 	uint32_t current_settings;
 };
 
-static struct bt_adapter *default_adapter;
+static struct bt_adapter *adapter;
 
 static void mgmt_local_name_changed_event(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
-	struct bt_adapter *adapter = user_data;
 	const struct mgmt_cp_set_local_name *rp = param;
 
 	if (length < sizeof(*rp)) {
@@ -74,7 +73,7 @@ static void mgmt_local_name_changed_event(uint16_t index, uint16_t length,
 	/* TODO Update services if needed */
 }
 
-static void settings_changed_powered(struct bt_adapter *adapter)
+static void settings_changed_powered(void)
 {
 	struct hal_ev_adapter_state_changed ev;
 
@@ -87,17 +86,17 @@ static void settings_changed_powered(struct bt_adapter *adapter)
 			HAL_EV_ADAPTER_STATE_CHANGED, sizeof(ev), &ev, -1);
 }
 
-static void settings_changed_connectable(struct bt_adapter *adapter)
+static void settings_changed_connectable(void)
 {
 	/* TODO */
 }
 
-static void settings_changed_discoverable(struct bt_adapter *adapter)
+static void settings_changed_discoverable(void)
 {
 	/* TODO */
 }
 
-static void settings_changed(struct bt_adapter *adapter, uint32_t settings)
+static void settings_changed(uint32_t settings)
 {
 	uint32_t changed_mask;
 
@@ -108,25 +107,24 @@ static void settings_changed(struct bt_adapter *adapter, uint32_t settings)
 	DBG("0x%08x", changed_mask);
 
 	if (changed_mask & MGMT_SETTING_POWERED)
-		settings_changed_powered(adapter);
+		settings_changed_powered();
 
 	if (changed_mask & MGMT_SETTING_CONNECTABLE) {
 		DBG("Connectable");
 
-		settings_changed_connectable(adapter);
+		settings_changed_connectable();
 	}
 
 	if (changed_mask & MGMT_SETTING_DISCOVERABLE) {
 		DBG("Discoverable");
 
-		settings_changed_discoverable(adapter);
+		settings_changed_discoverable();
 	}
 }
 
 static void new_settings_callback(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
-	struct bt_adapter *adapter = user_data;
 	uint32_t settings;
 
 	if (length < sizeof(settings)) {
@@ -142,13 +140,12 @@ static void new_settings_callback(uint16_t index, uint16_t length,
 	if (settings == adapter->current_settings)
 		return;
 
-	settings_changed(adapter, settings);
+	settings_changed(settings);
 }
 
 static void mgmt_dev_class_changed_event(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
-	struct bt_adapter *adapter = user_data;
 	const struct mgmt_cod *rp = param;
 	uint32_t dev_class;
 
@@ -171,24 +168,21 @@ static void mgmt_dev_class_changed_event(uint16_t index, uint16_t length,
 	/* TODO: Gatt attrib set*/
 }
 
-static void register_mgmt_handlers(struct bt_adapter *adapter)
+static void register_mgmt_handlers(void)
 {
 	mgmt_register(adapter->mgmt, MGMT_EV_NEW_SETTINGS, 0,
-			new_settings_callback, adapter, NULL);
+					new_settings_callback, NULL, NULL);
 
 	mgmt_register(adapter->mgmt, MGMT_EV_CLASS_OF_DEV_CHANGED,
-			0, mgmt_dev_class_changed_event,
-			adapter, NULL);
+			0, mgmt_dev_class_changed_event, NULL, NULL);
 
 	mgmt_register(adapter->mgmt, MGMT_EV_LOCAL_NAME_CHANGED,
-			0, mgmt_local_name_changed_event,
-			adapter, NULL);
+			0, mgmt_local_name_changed_event, NULL, NULL);
 }
 
 static void load_link_keys_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
-	struct bt_adapter *adapter = user_data;
 	int err;
 
 	if (status) {
@@ -200,7 +194,6 @@ static void load_link_keys_complete(uint8_t status, uint16_t length,
 
 	DBG("status %u", status);
 
-	default_adapter = adapter;
 	adapter->ready(0);
 	return;
 
@@ -208,7 +201,7 @@ failed:
 	adapter->ready(err);
 }
 
-static void load_link_keys(struct bt_adapter *adapter, GSList *keys)
+static void load_link_keys(GSList *keys)
 {
 	struct mgmt_cp_load_link_keys *cp;
 	size_t key_len = g_slist_length(keys);
@@ -224,7 +217,7 @@ static void load_link_keys(struct bt_adapter *adapter, GSList *keys)
 	cp->key_count = htobs(key_len);
 
 	mgmt_send(adapter->mgmt, MGMT_OP_LOAD_LINK_KEYS, 0, len,
-				cp, load_link_keys_complete, adapter, NULL);
+				cp, load_link_keys_complete, NULL, NULL);
 
 	g_free(cp);
 }
@@ -232,7 +225,6 @@ static void load_link_keys(struct bt_adapter *adapter, GSList *keys)
 static void read_info_complete(uint8_t status, uint16_t length, const void *param,
 							void *user_data)
 {
-	struct bt_adapter *adapter = user_data;
 	const struct mgmt_rp_read_info *rp = param;
 	int err;
 
@@ -240,7 +232,7 @@ static void read_info_complete(uint8_t status, uint16_t length, const void *para
 
 	if (status) {
 		error("Failed to read info for index %u: %s (0x%02x)",
-			adapter->index, mgmt_errstr(status), status);
+				adapter->index, mgmt_errstr(status), status);
 		err = -EIO;
 		goto failed;
 	}
@@ -267,9 +259,9 @@ static void read_info_complete(uint8_t status, uint16_t length, const void *para
 	adapter->current_settings = btohs(rp->current_settings);
 
 	/* TODO: Register all event notification handlers */
-	register_mgmt_handlers(adapter);
+	register_mgmt_handlers();
 
-	load_link_keys(adapter, NULL);
+	load_link_keys(NULL);
 
 	return;
 
@@ -280,8 +272,6 @@ failed:
 void bt_adapter_init(uint16_t index, struct mgmt *mgmt_if,
 						bt_adapter_ready ready)
 {
-	struct bt_adapter *adapter;
-
 	adapter = g_new0(struct bt_adapter, 1);
 
 	adapter->mgmt = mgmt_ref(mgmt_if);
@@ -289,11 +279,11 @@ void bt_adapter_init(uint16_t index, struct mgmt *mgmt_if,
 	adapter->ready = ready;
 
 	if (mgmt_send(mgmt_if, MGMT_OP_READ_INFO, index, 0, NULL,
-				read_info_complete, adapter, NULL) > 0)
+					read_info_complete, NULL, NULL) > 0)
 		return;
 
+	mgmt_unref(adapter->mgmt);
 	ready(-EIO);
-	mgmt_unref(mgmt_if);
 }
 
 static void set_mode_complete(uint8_t status, uint16_t length,
@@ -310,8 +300,7 @@ static void set_mode_complete(uint8_t status, uint16_t length,
 	 * required in both cases. So it is safe to just call the
 	 * event handling functions here.
 	 */
-	new_settings_callback(default_adapter->index, length, param,
-							default_adapter);
+	new_settings_callback(adapter->index, length, param, NULL);
 }
 
 static bool set_mode(uint16_t opcode, uint8_t mode)
@@ -323,8 +312,8 @@ static bool set_mode(uint16_t opcode, uint8_t mode)
 
 	DBG("opcode=0x%x mode=0x%x", opcode, mode);
 
-	if (mgmt_send(default_adapter->mgmt, opcode, default_adapter->index,
-			sizeof(cp), &cp, set_mode_complete, NULL, NULL) > 0)
+	if (mgmt_send(adapter->mgmt, opcode, adapter->index, sizeof(cp), &cp,
+					set_mode_complete, NULL, NULL) > 0)
 		return true;
 
 	error("Failed to set mode");
@@ -339,7 +328,7 @@ void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 
 	switch (opcode) {
 	case HAL_OP_ENABLE:
-		if (default_adapter->current_settings & MGMT_SETTING_POWERED) {
+		if (adapter->current_settings & MGMT_SETTING_POWERED) {
 			status = HAL_ERROR_DONE;
 			break;
 		}
@@ -351,7 +340,7 @@ void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 		}
 		break;
 	case HAL_OP_DISABLE:
-		if (!(default_adapter->current_settings & MGMT_SETTING_POWERED)) {
+		if (!(adapter->current_settings & MGMT_SETTING_POWERED)) {
 			status = HAL_ERROR_DONE;
 			break;
 		}
@@ -372,7 +361,7 @@ void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 
 const bdaddr_t *bt_adapter_get_address(void)
 {
-	return &default_adapter->bdaddr;
+	return &adapter->bdaddr;
 }
 
 bool bt_adapter_register(GIOChannel *io)
-- 
1.8.4

