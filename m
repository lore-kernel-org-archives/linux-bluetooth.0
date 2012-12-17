Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 01/11] adapter: Rename btd_adapter *up members to *powered
Date: Mon, 17 Dec 2012 15:44:48 +0100
Message-ID: <1355755498-2700-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This better describes those members purpose.
---
 src/adapter.c | 36 ++++++++++++++++++------------------
 src/adapter.h |  2 +-
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index d9b841d..f56b000 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -120,8 +120,8 @@ struct discovery {
 
 struct btd_adapter {
 	uint16_t dev_id;
-	gboolean up;
-	gboolean already_up;
+	gboolean powered;
+	gboolean already_powered;
 	char *path;			/* adapter object path */
 	bdaddr_t bdaddr;		/* adapter Bluetooth Address */
 	uint32_t dev_class;		/* Class of Device */
@@ -322,7 +322,7 @@ static int set_mode(struct btd_adapter *adapter, uint8_t new_mode)
 	if (adapter->pending_mode != NULL)
 		return -EALREADY;
 
-	if (!adapter->up && new_mode != MODE_OFF) {
+	if (!adapter->powered && new_mode != MODE_OFF) {
 		err = mgmt_set_powered(adapter->dev_id, TRUE);
 		if (err < 0)
 			return err;
@@ -330,7 +330,7 @@ static int set_mode(struct btd_adapter *adapter, uint8_t new_mode)
 		goto done;
 	}
 
-	if (adapter->up && new_mode == MODE_OFF) {
+	if (adapter->powered && new_mode == MODE_OFF) {
 		err = mgmt_set_powered(adapter->dev_id, FALSE);
 		if (err < 0)
 			return err;
@@ -597,7 +597,7 @@ static void stop_discovery(struct btd_adapter *adapter)
 		return;
 	}
 
-	if (adapter->up)
+	if (adapter->powered)
 		mgmt_stop_discovery(adapter->dev_id);
 	else
 		discovery_cleanup(adapter);
@@ -1022,7 +1022,7 @@ static DBusMessage *adapter_start_discovery(DBusConnection *conn,
 	const char *sender = dbus_message_get_sender(msg);
 	int err;
 
-	if (!adapter->up)
+	if (!adapter->powered)
 		return btd_error_not_ready(msg);
 
 	req = find_session(adapter->disc_sessions, sender);
@@ -1057,7 +1057,7 @@ static DBusMessage *adapter_stop_discovery(DBusConnection *conn,
 	struct session_req *req;
 	const char *sender = dbus_message_get_sender(msg);
 
-	if (!adapter->up)
+	if (!adapter->powered)
 		return btd_error_not_ready(msg);
 
 	req = find_session(adapter->disc_sessions, sender);
@@ -1132,7 +1132,7 @@ static gboolean adapter_property_get_powered(
 	struct btd_adapter *adapter = data;
 	dbus_bool_t value;
 
-	value = (adapter->up && !adapter->off_requested) ? TRUE : FALSE;
+	value = (adapter->powered && !adapter->off_requested) ? TRUE : FALSE;
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &value);
 
 	return TRUE;
@@ -1740,7 +1740,7 @@ void adapter_connect_list_add(struct btd_adapter *adapter,
 	DBG("%s added to %s's connect_list", device_get_path(device),
 								adapter->name);
 
-	if (!adapter->up)
+	if (!adapter->powered)
 		return;
 
 	if (adapter->off_requested)
@@ -1778,7 +1778,7 @@ void btd_adapter_start(struct btd_adapter *adapter)
 	struct session_req *req;
 
 	adapter->off_requested = FALSE;
-	adapter->up = TRUE;
+	adapter->powered = TRUE;
 
 	if (adapter->scan_mode & SCAN_INQUIRY) {
 		adapter->mode = MODE_DISCOVERABLE;
@@ -1911,7 +1911,7 @@ int btd_adapter_stop(struct btd_adapter *adapter)
 	/* check pending requests */
 	reply_pending_requests(adapter);
 
-	adapter->up = FALSE;
+	adapter->powered = FALSE;
 
 	if (adapter->discovery) {
 		emit_discovering = true;
@@ -2781,12 +2781,12 @@ static void load_config(struct btd_adapter *adapter)
 	g_key_file_free(key_file);
 }
 
-gboolean adapter_init(struct btd_adapter *adapter, gboolean up)
+gboolean adapter_init(struct btd_adapter *adapter, gboolean powered)
 {
 	struct agent *agent;
 
-	adapter->up = up;
-	adapter->already_up = up;
+	adapter->powered = powered;
+	adapter->already_powered = powered;
 
 	adapter->allow_name_changes = TRUE;
 
@@ -2877,7 +2877,7 @@ void adapter_remove(struct btd_adapter *adapter)
 	g_slist_free(adapter->pin_callbacks);
 
 	/* Return adapter to down state if it was not up on init */
-	if (!adapter->already_up && adapter->up)
+	if (!adapter->already_powered && adapter->powered)
 		mgmt_set_powered(adapter->dev_id, FALSE);
 }
 
@@ -3445,7 +3445,7 @@ int btd_cancel_authorization(guint id)
 
 int btd_adapter_restore_powered(struct btd_adapter *adapter)
 {
-	if (adapter->up)
+	if (adapter->powered)
 		return 0;
 
 	if (adapter->mode == MODE_OFF)
@@ -3487,7 +3487,7 @@ ssize_t btd_adapter_get_pin(struct btd_adapter *adapter, struct btd_device *dev,
 int btd_adapter_set_fast_connectable(struct btd_adapter *adapter,
 							gboolean enable)
 {
-	if (!adapter->up)
+	if (!adapter->powered)
 		return -EINVAL;
 
 	return mgmt_set_fast_connectable(adapter->dev_id, enable);
@@ -3497,7 +3497,7 @@ int btd_adapter_read_clock(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
 				int which, int timeout, uint32_t *clock,
 				uint16_t *accuracy)
 {
-	if (!adapter->up)
+	if (!adapter->powered)
 		return -EINVAL;
 
 	return mgmt_read_clock(adapter->dev_id, bdaddr, which,
diff --git a/src/adapter.h b/src/adapter.h
index 5030cb0..3b2d14f 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -100,7 +100,7 @@ void adapter_remove_device(struct btd_adapter *adapter,
 						gboolean remove_storage);
 
 struct btd_adapter *adapter_create(int id);
-gboolean adapter_init(struct btd_adapter *adapter, gboolean up);
+gboolean adapter_init(struct btd_adapter *adapter, gboolean powered);
 void adapter_remove(struct btd_adapter *adapter);
 void adapter_set_allow_name_changes(struct btd_adapter *adapter,
 						gboolean allow_name_changes);
-- 
1.8.0

