Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 6/6] core: Move functions to avoid forward declaration
Date: Sat,  6 Oct 2012 04:10:48 -0300
Message-Id: <1349507448-9595-6-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1349507448-9595-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1349507448-9595-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

---
 src/device.c | 186 +++++++++++++++++++++++++++++------------------------------
 1 file changed, 90 insertions(+), 96 deletions(-)

diff --git a/src/device.c b/src/device.c
index d78b294..419c16d 100644
--- a/src/device.c
+++ b/src/device.c
@@ -359,7 +359,40 @@ static gboolean dev_property_get_alias(const GDBusPropertyTable *property,
 }
 
 static void set_alias(GDBusPendingPropertySet id, const char *alias,
-								void *data);
+								void *data)
+{
+	struct btd_device *device = data;
+	struct btd_adapter *adapter = device->adapter;
+	char srcaddr[18], dstaddr[18];
+	int err;
+
+	/* No change */
+	if ((device->alias == NULL && g_str_equal(alias, "")) ||
+					g_strcmp0(device->alias, alias) == 0) {
+		g_dbus_pending_property_success(btd_get_dbus_connection(), id);
+		return;
+	}
+
+	ba2str(adapter_get_address(adapter), srcaddr);
+	ba2str(&device->bdaddr, dstaddr);
+
+	/* Remove alias if empty string */
+	err = write_device_alias(srcaddr, dstaddr, device->bdaddr_type,
+					g_str_equal(alias, "") ? NULL : alias);
+	if (err < 0) {
+		g_dbus_pending_property_error(btd_get_dbus_connection(),
+				id, ERROR_INTERFACE ".Failed", strerror(-err));
+		return;
+	}
+
+	g_free(device->alias);
+	device->alias = g_str_equal(alias, "") ? NULL : g_strdup(alias);
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+				device->path, DEVICE_INTERFACE, "Alias");
+
+	g_dbus_pending_property_success(btd_get_dbus_connection(), id);
+}
 
 static void dev_property_set_alias(const GDBusPropertyTable *property,
 					DBusMessageIter *value,
@@ -587,7 +620,35 @@ static gboolean dev_property_get_trusted(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static void set_trust(GDBusPendingPropertySet id, gboolean value, void *data);
+static void set_trust(GDBusPendingPropertySet id, gboolean value, void *data)
+{
+	struct btd_device *device = data;
+	struct btd_adapter *adapter = device->adapter;
+	char srcaddr[18], dstaddr[18];
+	int err;
+
+	if (device->trusted == value) {
+		g_dbus_pending_property_success(btd_get_dbus_connection(), id);
+		return;
+	}
+
+	ba2str(adapter_get_address(adapter), srcaddr);
+	ba2str(&device->bdaddr, dstaddr);
+
+	err = write_trust(srcaddr, dstaddr, device->bdaddr_type, value);
+	if (err < 0) {
+		g_dbus_pending_property_error(btd_get_dbus_connection(),
+				id, ERROR_INTERFACE ".Failed", strerror(-err));
+		return;
+	}
+
+	device->trusted = value;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+				device->path, DEVICE_INTERFACE, "Trusted");
+
+	g_dbus_pending_property_success(btd_get_dbus_connection(), id);
+}
 
 static void dev_property_set_trusted(const GDBusPropertyTable *property,
 					DBusMessageIter *value,
@@ -618,7 +679,33 @@ static gboolean dev_property_get_blocked(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static void set_blocked(GDBusPendingPropertySet id, gboolean value, void *data);
+static void set_blocked(GDBusPendingPropertySet id, gboolean value, void *data)
+{
+	struct btd_device *device = data;
+	int err;
+
+	if (value)
+		err = device_block(device, FALSE);
+	else
+		err = device_unblock(device, FALSE, FALSE);
+
+	switch (-err) {
+	case 0:
+		g_dbus_pending_property_success(btd_get_dbus_connection(), id);
+		break;
+	case EINVAL:
+		g_dbus_pending_property_error(btd_get_dbus_connection(), id,
+					ERROR_INTERFACE ".Failed",
+					"Kernel lacks blacklist support");
+		break;
+	default:
+		g_dbus_pending_property_error(btd_get_dbus_connection(), id,
+					ERROR_INTERFACE ".Failed",
+					strerror(-err));
+		break;
+	}
+}
+
 
 static void dev_property_set_blocked(const GDBusPropertyTable *property,
 					DBusMessageIter *value,
@@ -699,72 +786,6 @@ static gboolean dev_property_get_adapter(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static void set_alias(GDBusPendingPropertySet id, const char *alias,
-								void *data)
-{
-	struct btd_device *device = data;
-	struct btd_adapter *adapter = device->adapter;
-	char srcaddr[18], dstaddr[18];
-	int err;
-
-	/* No change */
-	if ((device->alias == NULL && g_str_equal(alias, "")) ||
-					g_strcmp0(device->alias, alias) == 0) {
-		g_dbus_pending_property_success(btd_get_dbus_connection(), id);
-		return;
-	}
-
-	ba2str(adapter_get_address(adapter), srcaddr);
-	ba2str(&device->bdaddr, dstaddr);
-
-	/* Remove alias if empty string */
-	err = write_device_alias(srcaddr, dstaddr, device->bdaddr_type,
-					g_str_equal(alias, "") ? NULL : alias);
-	if (err < 0) {
-		g_dbus_pending_property_error(btd_get_dbus_connection(),
-				id, ERROR_INTERFACE ".Failed", strerror(-err));
-		return;
-	}
-
-	g_free(device->alias);
-	device->alias = g_str_equal(alias, "") ? NULL : g_strdup(alias);
-
-	g_dbus_emit_property_changed(btd_get_dbus_connection(),
-				device->path, DEVICE_INTERFACE, "Alias");
-
-	g_dbus_pending_property_success(btd_get_dbus_connection(), id);
-}
-
-static void set_trust(GDBusPendingPropertySet id, gboolean value, void *data)
-{
-	struct btd_device *device = data;
-	struct btd_adapter *adapter = device->adapter;
-	char srcaddr[18], dstaddr[18];
-	int err;
-
-	if (device->trusted == value) {
-		g_dbus_pending_property_success(btd_get_dbus_connection(), id);
-		return;
-	}
-
-	ba2str(adapter_get_address(adapter), srcaddr);
-	ba2str(&device->bdaddr, dstaddr);
-
-	err = write_trust(srcaddr, dstaddr, device->bdaddr_type, value);
-	if (err < 0) {
-		g_dbus_pending_property_error(btd_get_dbus_connection(),
-				id, ERROR_INTERFACE ".Failed", strerror(-err));
-		return;
-	}
-
-	device->trusted = value;
-
-	g_dbus_emit_property_changed(btd_get_dbus_connection(),
-				device->path, DEVICE_INTERFACE, "Trusted");
-
-	g_dbus_pending_property_success(btd_get_dbus_connection(), id);
-}
-
 static void profile_remove(struct btd_profile *profile,
 						struct btd_device *device)
 {
@@ -851,33 +872,6 @@ int device_unblock(struct btd_device *device, gboolean silent,
 	return 0;
 }
 
-static void set_blocked(GDBusPendingPropertySet id, gboolean value, void *data)
-{
-	struct btd_device *device = data;
-	int err;
-
-	if (value)
-		err = device_block(device, FALSE);
-	else
-		err = device_unblock(device, FALSE, FALSE);
-
-	switch (-err) {
-	case 0:
-		g_dbus_pending_property_success(btd_get_dbus_connection(), id);
-		break;
-	case EINVAL:
-		g_dbus_pending_property_error(btd_get_dbus_connection(), id,
-					ERROR_INTERFACE ".Failed",
-					"Kernel lacks blacklist support");
-		break;
-	default:
-		g_dbus_pending_property_error(btd_get_dbus_connection(), id,
-					ERROR_INTERFACE ".Failed",
-					strerror(-err));
-		break;
-	}
-}
-
 static void discover_services_req_exit(DBusConnection *conn, void *user_data)
 {
 	struct browse_req *req = user_data;
-- 
1.7.12.2

