Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 8/8] adapter: Emit signals through DBus.Properties
Date: Tue,  9 Oct 2012 04:59:56 -0300
Message-Id: <1349769596-6050-8-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1349769596-6050-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1349769596-6050-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

---
 src/adapter.c | 142 +++++++++++++++++++---------------------------------------
 1 file changed, 47 insertions(+), 95 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 18689c6..6b28651 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -470,9 +470,8 @@ void btd_adapter_pairable_changed(struct btd_adapter *adapter,
 
 	write_device_pairable(&adapter->bdaddr, pairable);
 
-	emit_property_changed(adapter->path,
-				ADAPTER_INTERFACE, "Pairable",
-				DBUS_TYPE_BOOLEAN, &pairable);
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), adapter->path,
+					ADAPTER_INTERFACE, "Pairable");
 
 	if (pairable && adapter->pairable_timeout)
 		adapter_set_pairable_timeout(adapter,
@@ -736,9 +735,8 @@ void btd_adapter_class_changed(struct btd_adapter *adapter, uint8_t *new_class)
 		attrib_gap_set(adapter, GATT_CHARAC_APPEARANCE, cls, 2);
 	}
 
-	emit_property_changed(adapter->path,
-				ADAPTER_INTERFACE, "Class",
-				DBUS_TYPE_UINT32, &class);
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), adapter->path,
+						ADAPTER_INTERFACE, "Class");
 }
 
 void adapter_name_changed(struct btd_adapter *adapter, const char *name)
@@ -830,52 +828,6 @@ struct btd_device *adapter_find_device(struct btd_adapter *adapter,
 	return device;
 }
 
-static void adapter_update_devices(struct btd_adapter *adapter)
-{
-	char **devices;
-	int i;
-	GSList *l;
-
-	/* Devices */
-	devices = g_new0(char *, g_slist_length(adapter->devices) + 1);
-	for (i = 0, l = adapter->devices; l; l = l->next, i++) {
-		struct btd_device *dev = l->data;
-		devices[i] = (char *) device_get_path(dev);
-	}
-
-	emit_array_property_changed(adapter->path,
-					ADAPTER_INTERFACE, "Devices",
-					DBUS_TYPE_OBJECT_PATH, &devices, i);
-	g_free(devices);
-}
-
-static void adapter_emit_uuids_updated(struct btd_adapter *adapter)
-{
-	char **uuids;
-	int i;
-	sdp_list_t *list;
-
-	if (!adapter->initialized)
-		return;
-
-	uuids = g_new0(char *, sdp_list_len(adapter->services) + 1);
-
-	for (i = 0, list = adapter->services; list; list = list->next) {
-		char *uuid;
-		sdp_record_t *rec = list->data;
-
-		uuid = bt_uuid2string(&rec->svclass);
-		if (uuid)
-			uuids[i++] = uuid;
-	}
-
-	emit_array_property_changed(adapter->path,
-					ADAPTER_INTERFACE, "UUIDs",
-					DBUS_TYPE_STRING, &uuids, i);
-
-	g_strfreev(uuids);
-}
-
 static uint8_t get_uuid_mask(uuid_t *uuid)
 {
 	if (uuid->type != SDP_UUID16)
@@ -947,7 +899,9 @@ void adapter_service_insert(struct btd_adapter *adapter, void *r)
 		mgmt_add_uuid(adapter->dev_id, &rec->svclass, svc_hint);
 	}
 
-	adapter_emit_uuids_updated(adapter);
+	if (adapter->initialized)
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+				adapter->path, ADAPTER_INTERFACE, "UUIDs");
 }
 
 void adapter_service_remove(struct btd_adapter *adapter, void *r)
@@ -959,7 +913,9 @@ void adapter_service_remove(struct btd_adapter *adapter, void *r)
 	if (sdp_list_find(adapter->services, &rec->svclass, uuid_cmp) == NULL)
 		mgmt_remove_uuid(adapter->dev_id, &rec->svclass);
 
-	adapter_emit_uuids_updated(adapter);
+	if (adapter->initialized)
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+				adapter->path, ADAPTER_INTERFACE, "UUIDs");
 }
 
 static struct btd_device *adapter_create_device(struct btd_adapter *adapter,
@@ -985,7 +941,8 @@ static struct btd_device *adapter_create_device(struct btd_adapter *adapter,
 			DBUS_TYPE_OBJECT_PATH, &path,
 			DBUS_TYPE_INVALID);
 
-	adapter_update_devices(adapter);
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+				adapter->path, ADAPTER_INTERFACE, "Devices");
 
 	return device;
 }
@@ -1033,7 +990,8 @@ void adapter_remove_device(struct btd_adapter *adapter,
 		service_auth_cancel(auth);
 	}
 
-	adapter_update_devices(adapter);
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+				adapter->path, ADAPTER_INTERFACE, "Devices");
 
 	g_dbus_emit_signal(btd_get_dbus_connection(), adapter->path,
 			ADAPTER_INTERFACE, "DeviceRemoved",
@@ -1807,8 +1765,6 @@ static const GDBusMethodTable adapter_methods[] = {
 };
 
 static const GDBusSignalTable adapter_signals[] = {
-	{ GDBUS_SIGNAL("PropertyChanged",
-			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ GDBUS_SIGNAL("DeviceCreated",
 			GDBUS_ARGS({ "device", "o" })) },
 	{ GDBUS_SIGNAL("DeviceRemoved",
@@ -2449,7 +2405,6 @@ void btd_adapter_start(struct btd_adapter *adapter)
 {
 	struct session_req *req;
 	char address[18];
-	gboolean powered;
 
 	ba2str(&adapter->bdaddr, address);
 
@@ -2465,10 +2420,8 @@ void btd_adapter_start(struct btd_adapter *adapter)
 	else
 		adapter->mode = MODE_CONNECTABLE;
 
-	powered = TRUE;
-	emit_property_changed(adapter->path,
-				ADAPTER_INTERFACE, "Powered",
-				DBUS_TYPE_BOOLEAN, &powered);
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), adapter->path,
+						ADAPTER_INTERFACE, "Powered");
 
 	call_adapter_powered_callbacks(adapter, TRUE);
 
@@ -2586,7 +2539,9 @@ static void set_mode_complete(struct btd_adapter *adapter)
 
 int btd_adapter_stop(struct btd_adapter *adapter)
 {
-	gboolean prop_false = FALSE;
+	DBusConnection *conn = btd_get_dbus_connection();
+	bool emit_discoverable = false, emit_pairable = false;
+	bool emit_discovering = false;
 
 	/* check pending requests */
 	reply_pending_requests(adapter);
@@ -2606,29 +2561,33 @@ int btd_adapter_stop(struct btd_adapter *adapter)
 	}
 
 	if (adapter->scan_mode == (SCAN_PAGE | SCAN_INQUIRY))
-		emit_property_changed(adapter->path,
-					ADAPTER_INTERFACE, "Discoverable",
-					DBUS_TYPE_BOOLEAN, &prop_false);
+		emit_discoverable = true;
 
 	if ((adapter->scan_mode & SCAN_PAGE) && adapter->pairable == TRUE)
-		emit_property_changed(adapter->path,
-					ADAPTER_INTERFACE, "Pairable",
-					DBUS_TYPE_BOOLEAN, &prop_false);
+		emit_pairable = true;
 
 	if (adapter->discovering)
-		emit_property_changed(adapter->path,
-					ADAPTER_INTERFACE, "Discovering",
-					DBUS_TYPE_BOOLEAN, &prop_false);
-
-	emit_property_changed(adapter->path,
-				ADAPTER_INTERFACE, "Powered",
-				DBUS_TYPE_BOOLEAN, &prop_false);
+		emit_discovering = true;
 
 	adapter->discovering = FALSE;
 	adapter->scan_mode = SCAN_DISABLED;
 	adapter->mode = MODE_OFF;
 	adapter->off_requested = FALSE;
 
+	if (emit_discoverable)
+		g_dbus_emit_property_changed(conn, adapter->path,
+					ADAPTER_INTERFACE, "Discoverable");
+	if (emit_pairable)
+		g_dbus_emit_property_changed(conn, adapter->path,
+					ADAPTER_INTERFACE, "Pairable");
+
+	if (emit_discovering)
+		g_dbus_emit_property_changed(conn, adapter->path,
+					ADAPTER_INTERFACE, "Discovering");
+
+	g_dbus_emit_property_changed(conn, adapter->path, ADAPTER_INTERFACE,
+								"Powered");
+
 	call_adapter_powered_callbacks(adapter, FALSE);
 
 	info("Adapter %s has been disabled", adapter->path);
@@ -2818,14 +2777,12 @@ void adapter_set_allow_name_changes(struct btd_adapter *adapter,
 void adapter_set_discovering(struct btd_adapter *adapter,
 						gboolean discovering)
 {
-	const char *path = adapter->path;
 	guint connect_list_len;
 
 	adapter->discovering = discovering;
 
-	emit_property_changed(path,
-				ADAPTER_INTERFACE, "Discovering",
-				DBUS_TYPE_BOOLEAN, &discovering);
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), adapter->path,
+					ADAPTER_INTERFACE, "Discovering");
 
 	if (discovering)
 		return;
@@ -3319,7 +3276,7 @@ done:
 
 void adapter_mode_changed(struct btd_adapter *adapter, uint8_t scan_mode)
 {
-	gboolean discoverable, pairable;
+	bool emit_pairable = false;
 
 	DBG("old 0x%02x new 0x%02x", adapter->scan_mode, scan_mode);
 
@@ -3329,18 +3286,12 @@ void adapter_mode_changed(struct btd_adapter *adapter, uint8_t scan_mode)
 	switch (scan_mode) {
 	case SCAN_DISABLED:
 		adapter->mode = MODE_OFF;
-		discoverable = FALSE;
-		pairable = FALSE;
 		break;
 	case SCAN_PAGE:
 		adapter->mode = MODE_CONNECTABLE;
-		discoverable = FALSE;
-		pairable = adapter->pairable;
 		break;
 	case (SCAN_PAGE | SCAN_INQUIRY):
 		adapter->mode = MODE_DISCOVERABLE;
-		discoverable = TRUE;
-		pairable = adapter->pairable;
 		break;
 	default:
 		/* ignore, reserved */
@@ -3349,16 +3300,17 @@ void adapter_mode_changed(struct btd_adapter *adapter, uint8_t scan_mode)
 
 	/* If page scanning gets toggled emit the Pairable property */
 	if ((adapter->scan_mode & SCAN_PAGE) != (scan_mode & SCAN_PAGE))
-		emit_property_changed(adapter->path,
-					ADAPTER_INTERFACE, "Pairable",
-					DBUS_TYPE_BOOLEAN, &pairable);
-
-	emit_property_changed(adapter->path,
-				ADAPTER_INTERFACE, "Discoverable",
-				DBUS_TYPE_BOOLEAN, &discoverable);
+		emit_pairable = true;
 
 	adapter->scan_mode = scan_mode;
 
+	if (emit_pairable)
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+				adapter->path, ADAPTER_INTERFACE, "Pairable");
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), adapter->path,
+					ADAPTER_INTERFACE, "Discoverable");
+
 	set_mode_complete(adapter);
 }
 
-- 
1.7.12.2

