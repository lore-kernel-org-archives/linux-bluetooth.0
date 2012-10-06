Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 5/6] core: Add setters and signals to Device interface
Date: Sat,  6 Oct 2012 04:02:39 -0300
Message-Id: <1349506960-9398-5-git-send-email-lucas.de.marchi@gmail.com>
In-Reply-To: <1349506960-9398-1-git-send-email-lucas.de.marchi@gmail.com>
References: <1349506960-9398-1-git-send-email-lucas.de.marchi@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c | 257 +++++++++++++++++++++++++++++++----------------------------
 1 file changed, 133 insertions(+), 124 deletions(-)

diff --git a/src/device.c b/src/device.c
index 95543cb..d78b294 100644
--- a/src/device.c
+++ b/src/device.c
@@ -358,6 +358,27 @@ static gboolean dev_property_get_alias(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static void set_alias(GDBusPendingPropertySet id, const char *alias,
+								void *data);
+
+static void dev_property_set_alias(const GDBusPropertyTable *property,
+					DBusMessageIter *value,
+					GDBusPendingPropertySet id, void *data)
+{
+	const char *alias;
+
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_STRING) {
+		g_dbus_pending_property_error(btd_get_dbus_connection(),
+				id, ERROR_INTERFACE ".InvalidArguments",
+				"Invalid arguments in method call");
+		return;
+	}
+
+	dbus_message_iter_get_basic(value, &alias);
+
+	set_alias(id, alias, data);
+}
+
 static gboolean get_class(const GDBusPropertyTable *property, void *data,
 							uint32_t *class)
 {
@@ -566,6 +587,26 @@ static gboolean dev_property_get_trusted(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static void set_trust(GDBusPendingPropertySet id, gboolean value, void *data);
+
+static void dev_property_set_trusted(const GDBusPropertyTable *property,
+					DBusMessageIter *value,
+					GDBusPendingPropertySet id, void *data)
+{
+	dbus_bool_t b;
+
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_BOOLEAN) {
+		g_dbus_pending_property_error(btd_get_dbus_connection(),
+				id, ERROR_INTERFACE ".InvalidArguments",
+				"Invalid arguments in method call");
+		return;
+	}
+
+	dbus_message_iter_get_basic(value, &b);
+
+	set_trust(id, b, data);
+}
+
 static gboolean dev_property_get_blocked(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -577,6 +618,26 @@ static gboolean dev_property_get_blocked(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static void set_blocked(GDBusPendingPropertySet id, gboolean value, void *data);
+
+static void dev_property_set_blocked(const GDBusPropertyTable *property,
+					DBusMessageIter *value,
+					GDBusPendingPropertySet id, void *data)
+{
+	dbus_bool_t b;
+
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_BOOLEAN) {
+		g_dbus_pending_property_error(btd_get_dbus_connection(),
+				id, ERROR_INTERFACE ".InvalidArguments",
+				"Invalid arguments in method call");
+		return;
+	}
+
+	dbus_message_iter_get_basic(value, &b);
+
+	set_blocked(id, b, data);
+}
+
 static gboolean dev_property_get_connected(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -638,7 +699,8 @@ static gboolean dev_property_get_adapter(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static DBusMessage *set_alias(DBusMessage *msg, const char *alias, void *data)
+static void set_alias(GDBusPendingPropertySet id, const char *alias,
+								void *data)
 {
 	struct btd_device *device = data;
 	struct btd_adapter *adapter = device->adapter;
@@ -647,8 +709,10 @@ static DBusMessage *set_alias(DBusMessage *msg, const char *alias, void *data)
 
 	/* No change */
 	if ((device->alias == NULL && g_str_equal(alias, "")) ||
-			g_strcmp0(device->alias, alias) == 0)
-		return dbus_message_new_method_return(msg);
+					g_strcmp0(device->alias, alias) == 0) {
+		g_dbus_pending_property_success(btd_get_dbus_connection(), id);
+		return;
+	}
 
 	ba2str(adapter_get_address(adapter), srcaddr);
 	ba2str(&device->bdaddr, dstaddr);
@@ -656,43 +720,49 @@ static DBusMessage *set_alias(DBusMessage *msg, const char *alias, void *data)
 	/* Remove alias if empty string */
 	err = write_device_alias(srcaddr, dstaddr, device->bdaddr_type,
 					g_str_equal(alias, "") ? NULL : alias);
-	if (err < 0)
-		return btd_error_failed(msg, strerror(-err));
+	if (err < 0) {
+		g_dbus_pending_property_error(btd_get_dbus_connection(),
+				id, ERROR_INTERFACE ".Failed", strerror(-err));
+		return;
+	}
 
 	g_free(device->alias);
 	device->alias = g_str_equal(alias, "") ? NULL : g_strdup(alias);
 
-	emit_property_changed(dbus_message_get_path(msg),
-				DEVICE_INTERFACE, "Alias",
-				DBUS_TYPE_STRING, &alias);
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+				device->path, DEVICE_INTERFACE, "Alias");
 
-	return dbus_message_new_method_return(msg);
+	g_dbus_pending_property_success(btd_get_dbus_connection(), id);
 }
 
-static DBusMessage *set_trust(DBusMessage *msg, gboolean value, void *data)
+static void set_trust(GDBusPendingPropertySet id, gboolean value, void *data)
 {
 	struct btd_device *device = data;
 	struct btd_adapter *adapter = device->adapter;
 	char srcaddr[18], dstaddr[18];
 	int err;
 
-	if (device->trusted == value)
-		return dbus_message_new_method_return(msg);
+	if (device->trusted == value) {
+		g_dbus_pending_property_success(btd_get_dbus_connection(), id);
+		return;
+	}
 
 	ba2str(adapter_get_address(adapter), srcaddr);
 	ba2str(&device->bdaddr, dstaddr);
 
 	err = write_trust(srcaddr, dstaddr, device->bdaddr_type, value);
-	if (err < 0)
-		return btd_error_failed(msg, strerror(-err));
+	if (err < 0) {
+		g_dbus_pending_property_error(btd_get_dbus_connection(),
+				id, ERROR_INTERFACE ".Failed", strerror(-err));
+		return;
+	}
 
 	device->trusted = value;
 
-	emit_property_changed(dbus_message_get_path(msg),
-				DEVICE_INTERFACE, "Trusted",
-				DBUS_TYPE_BOOLEAN, &value);
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+				device->path, DEVICE_INTERFACE, "Trusted");
 
-	return dbus_message_new_method_return(msg);
+	g_dbus_pending_property_success(btd_get_dbus_connection(), id);
 }
 
 static void profile_remove(struct btd_profile *profile,
@@ -743,9 +813,8 @@ int device_block(struct btd_device *device, gboolean update_only)
 
 	device_set_temporary(device, FALSE);
 
-	emit_property_changed(device->path,
-				DEVICE_INTERFACE, "Blocked",
-				DBUS_TYPE_BOOLEAN, &device->blocked);
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), device->path,
+						DEVICE_INTERFACE, "Blocked");
 
 	return 0;
 }
@@ -773,16 +842,16 @@ int device_unblock(struct btd_device *device, gboolean silent,
 		error("write_blocked(): %s (%d)", strerror(-err), -err);
 
 	if (!silent) {
-		emit_property_changed(device->path,
-					DEVICE_INTERFACE, "Blocked",
-					DBUS_TYPE_BOOLEAN, &device->blocked);
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+						device->path, DEVICE_INTERFACE,
+						"Blocked");
 		device_probe_profiles(device, device->uuids);
 	}
 
 	return 0;
 }
 
-static DBusMessage *set_blocked(DBusMessage *msg, gboolean value, void *data)
+static void set_blocked(GDBusPendingPropertySet id, gboolean value, void *data)
 {
 	struct btd_device *device = data;
 	int err;
@@ -794,61 +863,19 @@ static DBusMessage *set_blocked(DBusMessage *msg, gboolean value, void *data)
 
 	switch (-err) {
 	case 0:
-		return dbus_message_new_method_return(msg);
+		g_dbus_pending_property_success(btd_get_dbus_connection(), id);
+		break;
 	case EINVAL:
-		return btd_error_failed(msg, "Kernel lacks blacklist support");
+		g_dbus_pending_property_error(btd_get_dbus_connection(), id,
+					ERROR_INTERFACE ".Failed",
+					"Kernel lacks blacklist support");
+		break;
 	default:
-		return btd_error_failed(msg, strerror(-err));
-	}
-}
-
-static DBusMessage *set_property(DBusConnection *conn,
-				DBusMessage *msg, void *data)
-{
-	DBusMessageIter iter;
-	DBusMessageIter sub;
-	const char *property;
-
-	if (!dbus_message_iter_init(msg, &iter))
-		return btd_error_invalid_args(msg);
-
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
-		return btd_error_invalid_args(msg);
-
-	dbus_message_iter_get_basic(&iter, &property);
-	dbus_message_iter_next(&iter);
-
-	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_VARIANT)
-		return btd_error_invalid_args(msg);
-	dbus_message_iter_recurse(&iter, &sub);
-
-	if (g_str_equal("Trusted", property)) {
-		dbus_bool_t value;
-		if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_BOOLEAN)
-			return btd_error_invalid_args(msg);
-		dbus_message_iter_get_basic(&sub, &value);
-
-		return set_trust(msg, value, data);
-	} else if (g_str_equal("Alias", property)) {
-		const char *alias;
-
-		if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_STRING)
-			return btd_error_invalid_args(msg);
-		dbus_message_iter_get_basic(&sub, &alias);
-
-		return set_alias(msg, alias, data);
-	} else if (g_str_equal("Blocked", property)) {
-		dbus_bool_t value;
-
-		if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_BOOLEAN)
-			return btd_error_invalid_args(msg);
-
-		dbus_message_iter_get_basic(&sub, &value);
-
-		return set_blocked(msg, value, data);
+		g_dbus_pending_property_error(btd_get_dbus_connection(), id,
+					ERROR_INTERFACE ".Failed",
+					strerror(-err));
+		break;
 	}
-
-	return btd_error_invalid_args(msg);
 }
 
 static void discover_services_req_exit(DBusConnection *conn, void *user_data)
@@ -1158,9 +1185,6 @@ static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable device_methods[] = {
-	{ GDBUS_METHOD("SetProperty",
-			GDBUS_ARGS({ "name", "s" }, { "value", "v" }), NULL,
-			set_property) },
 	{ GDBUS_ASYNC_METHOD("DiscoverServices",
 			GDBUS_ARGS({ "pattern", "s" }),
 			GDBUS_ARGS({ "services", "a{us}" }),
@@ -1172,8 +1196,6 @@ static const GDBusMethodTable device_methods[] = {
 };
 
 static const GDBusSignalTable device_signals[] = {
-	{ GDBUS_SIGNAL("PropertyChanged",
-			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
 	{ GDBUS_SIGNAL("DisconnectRequested", NULL) },
 	{ }
 };
@@ -1182,7 +1204,7 @@ static const GDBusSignalTable device_signals[] = {
 static const GDBusPropertyTable device_properties[] = {
 	{ "Address", "s", dev_property_get_address },
 	{ "Name", "s", dev_property_get_name },
-	{ "Alias", "s", dev_property_get_alias },
+	{ "Alias", "s", dev_property_get_alias, dev_property_set_alias },
 	{ "Class", "u", dev_property_get_class, NULL,
 					dev_property_exists_class },
 	{ "Appearance", "q", dev_property_get_appearance, NULL,
@@ -1198,8 +1220,8 @@ static const GDBusPropertyTable device_properties[] = {
 	{ "Version", "q", dev_property_get_version, NULL,
 					dev_property_exists_version },
 	{ "Paired", "b", dev_property_get_paired },
-	{ "Trusted", "b", dev_property_get_trusted },
-	{ "Blocked", "b", dev_property_get_blocked },
+	{ "Trusted", "b", dev_property_get_trusted, dev_property_set_trusted },
+	{ "Blocked", "b", dev_property_get_blocked, dev_property_set_blocked },
 	{ "Connected", "b", dev_property_get_connected },
 	{ "UUIDs", "as", dev_property_get_uuids },
 	{ "Services", "ao", dev_property_get_services },
@@ -1223,9 +1245,8 @@ void device_add_connection(struct btd_device *device)
 
 	device->connected = TRUE;
 
-	emit_property_changed(device->path,
-					DEVICE_INTERFACE, "Connected",
-					DBUS_TYPE_BOOLEAN, &device->connected);
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), device->path,
+						DEVICE_INTERFACE, "Connected");
 }
 
 void device_remove_connection(struct btd_device *device)
@@ -1257,9 +1278,8 @@ void device_remove_connection(struct btd_device *device)
 	if (device_is_paired(device) && !device_is_bonded(device))
 		device_set_paired(device, FALSE);
 
-	emit_property_changed(device->path,
-				DEVICE_INTERFACE, "Connected",
-				DBUS_TYPE_BOOLEAN, &device->connected);
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), device->path,
+						DEVICE_INTERFACE, "Connected");
 }
 
 guint device_add_disconnect_watch(struct btd_device *device,
@@ -1305,9 +1325,8 @@ static void device_set_vendor(struct btd_device *device, uint16_t value)
 
 	device->vendor = value;
 
-	emit_property_changed(device->path,
-				DEVICE_INTERFACE, "Vendor",
-				DBUS_TYPE_UINT16, &value);
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), device->path,
+						DEVICE_INTERFACE, "Vendor");
 }
 
 static void device_set_vendor_src(struct btd_device *device, uint16_t value)
@@ -1317,9 +1336,8 @@ static void device_set_vendor_src(struct btd_device *device, uint16_t value)
 
 	device->vendor_src = value;
 
-	emit_property_changed(device->path,
-				DEVICE_INTERFACE, "VendorSource",
-				DBUS_TYPE_UINT16, &value);
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), device->path,
+					DEVICE_INTERFACE, "VendorSource");
 }
 
 static void device_set_product(struct btd_device *device, uint16_t value)
@@ -1329,9 +1347,8 @@ static void device_set_product(struct btd_device *device, uint16_t value)
 
 	device->product = value;
 
-	emit_property_changed(device->path,
-				DEVICE_INTERFACE, "Product",
-				DBUS_TYPE_UINT16, &value);
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), device->path,
+						DEVICE_INTERFACE, "Product");
 }
 
 static void device_set_version(struct btd_device *device, uint16_t value)
@@ -1341,9 +1358,8 @@ static void device_set_version(struct btd_device *device, uint16_t value)
 
 	device->version = value;
 
-	emit_property_changed(device->path,
-				DEVICE_INTERFACE, "Version",
-				DBUS_TYPE_UINT16, &value);
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), device->path,
+						DEVICE_INTERFACE, "Version");
 }
 
 struct btd_device *device_create(struct btd_adapter *adapter,
@@ -1420,16 +1436,14 @@ void device_set_name(struct btd_device *device, const char *name)
 
 	strncpy(device->name, name, MAX_NAME_LENGTH);
 
-	emit_property_changed(device->path,
-				DEVICE_INTERFACE, "Name",
-				DBUS_TYPE_STRING, &name);
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), device->path,
+						DEVICE_INTERFACE, "Name");
 
 	if (device->alias != NULL)
 		return;
 
-	emit_property_changed(device->path,
-				DEVICE_INTERFACE, "Alias",
-				DBUS_TYPE_STRING, &name);
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), device->path,
+						DEVICE_INTERFACE, "Alias");
 }
 
 void device_get_name(struct btd_device *device, char *name, size_t len)
@@ -2703,9 +2717,8 @@ void device_set_paired(struct btd_device *device, gboolean value)
 
 	device->paired = value;
 
-	emit_property_changed(device->path,
-				DEVICE_INTERFACE, "Paired",
-				DBUS_TYPE_BOOLEAN, &value);
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), device->path,
+						DEVICE_INTERFACE, "Paired");
 }
 
 static void device_agent_removed(struct agent *agent, void *user_data)
@@ -3379,14 +3392,12 @@ void device_set_class(struct btd_device *device, uint32_t value)
 {
 	const char *icon = class_to_icon(value);
 
-	emit_property_changed(device->path,
-				DEVICE_INTERFACE, "Class",
-				DBUS_TYPE_UINT32, &value);
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), device->path,
+						DEVICE_INTERFACE, "Class");
 
 	if (icon)
-		emit_property_changed(device->path,
-					DEVICE_INTERFACE, "Icon",
-					DBUS_TYPE_STRING, &icon);
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+				device->path, DEVICE_INTERFACE, "Icon");
 }
 
 int device_get_appearance(struct btd_device *device, uint16_t *value)
@@ -3410,14 +3421,12 @@ void device_set_appearance(struct btd_device *device, uint16_t value)
 {
 	const char *icon = gap_appearance_to_icon(value);
 
-	emit_property_changed(device->path,
-				DEVICE_INTERFACE, "Appearance",
-				DBUS_TYPE_UINT16, &value);
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), device->path,
+					DEVICE_INTERFACE, "Appearance");
 
 	if (icon)
-		emit_property_changed(device->path,
-					DEVICE_INTERFACE, "Icon",
-					DBUS_TYPE_STRING, &icon);
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+				device->path, DEVICE_INTERFACE, "Icon");
 
 	write_remote_appearance(adapter_get_address(device->adapter),
 				&device->bdaddr, device->bdaddr_type, value);
-- 
1.7.12.2

