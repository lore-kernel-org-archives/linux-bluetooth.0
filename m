Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 2/2] core: Update gdbus function calls
Date: Wed, 17 Oct 2012 12:14:29 -0300
Message-Id: <1350486869-5020-2-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1350486869-5020-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1350486869-5020-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Done by the following semantic patch, with manual tweaks afterwards due
to changes in 80-chars line breaks:

// <smpl>
@r1 @
expression E1;
@@
 g_dbus_pending_property_success(
-  E1,
   ...)

@r2 @
expression E1;
@@
 g_dbus_pending_property_error(
-  E1,
   ...)

@r3 @
expression E1;
@@
 g_dbus_pending_property_error_valist(
-  E1,
   ...)
// </smpl>
---
 src/adapter.c | 91 +++++++++++++++++++++++++++--------------------------------
 src/device.c  | 72 ++++++++++++++++++----------------------------
 2 files changed, 69 insertions(+), 94 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 7c2aec0..e5d4cf7 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -346,7 +346,6 @@ static void set_session_pending_mode(struct btd_adapter *adapter,
 static void set_discoverable(struct btd_adapter *adapter,
 			gboolean discoverable, GDBusPendingPropertySet id)
 {
-	DBusConnection *conn = btd_get_dbus_connection();
 	uint8_t mode;
 	int err;
 
@@ -354,12 +353,12 @@ static void set_discoverable(struct btd_adapter *adapter,
 
 	if (mode == adapter->mode) {
 		adapter->global_mode = mode;
-		return g_dbus_pending_property_success(conn, id);
+		return g_dbus_pending_property_success(id);
 	}
 
 	err = set_mode(adapter, mode);
 	if (err < 0)
-		return g_dbus_pending_property_error(conn, id,
+		return g_dbus_pending_property_error(id,
 						ERROR_INTERFACE ".Failed",
 						strerror(-err));
 
@@ -371,7 +370,6 @@ static void set_discoverable(struct btd_adapter *adapter,
 static void set_powered(struct btd_adapter *adapter, gboolean powered,
 						GDBusPendingPropertySet id)
 {
-	DBusConnection *conn = btd_get_dbus_connection();
 	uint8_t mode;
 	int err;
 
@@ -385,12 +383,12 @@ static void set_powered(struct btd_adapter *adapter, gboolean powered,
 
 	if (mode == adapter->mode) {
 		adapter->global_mode = mode;
-		return g_dbus_pending_property_success(conn, id);
+		return g_dbus_pending_property_success(id);
 	}
 
 	err = set_mode(adapter, mode);
 	if (err < 0)
-		return g_dbus_pending_property_error(conn, id,
+		return g_dbus_pending_property_error(id,
 						ERROR_INTERFACE ".Failed",
 						strerror(-err));
 
@@ -402,11 +400,10 @@ static void set_powered(struct btd_adapter *adapter, gboolean powered,
 static void set_pairable(struct btd_adapter *adapter, gboolean pairable,
 				bool reply, GDBusPendingPropertySet id)
 {
-	DBusConnection *conn = btd_get_dbus_connection();
 	int err;
 
 	if (adapter->scan_mode == SCAN_DISABLED)
-		return g_dbus_pending_property_error(conn, id,
+		return g_dbus_pending_property_error(id,
 						ERROR_INTERFACE ".NotReady",
 						"Resource Not Ready");
 
@@ -419,7 +416,7 @@ static void set_pairable(struct btd_adapter *adapter, gboolean pairable,
 	err = set_mode(adapter, MODE_DISCOVERABLE);
 	if (err < 0) {
 		if (reply)
-			g_dbus_pending_property_error(conn, id,
+			g_dbus_pending_property_error(id,
 						ERROR_INTERFACE ".Failed",
 						strerror(-err));
 		return;
@@ -430,7 +427,7 @@ store:
 
 done:
 	if (reply)
-		g_dbus_pending_property_success(conn, id);
+		g_dbus_pending_property_success(id);
 }
 
 static gboolean pairable_timeout_handler(void *data)
@@ -716,7 +713,7 @@ static void set_discoverable_timeout(struct btd_adapter *adapter,
 	DBusConnection *conn = btd_get_dbus_connection();
 
 	if (adapter->discov_timeout == timeout && timeout == 0)
-		return g_dbus_pending_property_success(conn, id);
+		return g_dbus_pending_property_success(id);
 
 	if (adapter->scan_mode & SCAN_INQUIRY)
 		mgmt_set_discoverable(adapter->dev_id, TRUE, timeout);
@@ -727,7 +724,7 @@ static void set_discoverable_timeout(struct btd_adapter *adapter,
 
 	g_dbus_emit_property_changed(conn, adapter->path, ADAPTER_INTERFACE,
 						"DiscoverableTimeout");
-	g_dbus_pending_property_success(conn, id);
+	g_dbus_pending_property_success(id);
 }
 
 static void set_pairable_timeout(struct btd_adapter *adapter,
@@ -736,7 +733,7 @@ static void set_pairable_timeout(struct btd_adapter *adapter,
 	DBusConnection *conn = btd_get_dbus_connection();
 
 	if (adapter->pairable_timeout == timeout && timeout == 0)
-		return g_dbus_pending_property_success(conn, id);
+		return g_dbus_pending_property_success(id);
 
 	if (adapter->pairable)
 		adapter_set_pairable_timeout(adapter, timeout);
@@ -747,7 +744,7 @@ static void set_pairable_timeout(struct btd_adapter *adapter,
 
 	g_dbus_emit_property_changed(conn, adapter->path, ADAPTER_INTERFACE,
 							"PairableTimeout");
-	g_dbus_pending_property_success(conn, id);
+	g_dbus_pending_property_success(id);
 }
 
 void btd_adapter_class_changed(struct btd_adapter *adapter, uint8_t *new_class)
@@ -827,24 +824,21 @@ static void set_name(struct btd_adapter *adapter, const char *name,
 	int ret;
 
 	if (adapter->allow_name_changes == FALSE)
-		return g_dbus_pending_property_error(btd_get_dbus_connection(),
-						id, ERROR_INTERFACE ".Failed",
+		return g_dbus_pending_property_error(id,
+						ERROR_INTERFACE ".Failed",
 						strerror(EPERM));
 
 	ret = adapter_set_name(adapter, name);
-	if (ret >= 0) {
-		g_dbus_pending_property_success(btd_get_dbus_connection(), id);
-		return;
-	}
+	if (ret >= 0)
+		return g_dbus_pending_property_success(id);
 
 	if (ret == -EINVAL)
-		g_dbus_pending_property_error(btd_get_dbus_connection(),
-				id, ERROR_INTERFACE ".InvalidArguments",
-				"Invalid arguments in method call");
+		g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
 	else
-		g_dbus_pending_property_error(btd_get_dbus_connection(),
-						id, ERROR_INTERFACE ".Failed",
-						strerror(-ret));
+		g_dbus_pending_property_error(id, ERROR_INTERFACE ".Failed",
+							strerror(-ret));
 }
 
 struct btd_device *adapter_find_device(struct btd_adapter *adapter,
@@ -1173,12 +1167,10 @@ static void adapter_property_set_name(const GDBusPropertyTable *property,
 {
 	const char *name;
 
-	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_STRING) {
-		g_dbus_pending_property_error(btd_get_dbus_connection(),
-				id, ERROR_INTERFACE ".InvalidArguments",
-				"Invalid arguments in method call");
-		return;
-	}
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_STRING)
+		return g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
 
 	dbus_message_iter_get_basic(value, &name);
 
@@ -1217,9 +1209,9 @@ static void adapter_property_set_powered(
 	dbus_bool_t powered;
 
 	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_BOOLEAN)
-		return g_dbus_pending_property_error(btd_get_dbus_connection(),
-				id, ERROR_INTERFACE ".InvalidArguments",
-				"Invalid arguments in method call");
+		return g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
 
 	dbus_message_iter_get_basic(value, &powered);
 
@@ -1247,9 +1239,9 @@ static void adapter_property_set_discoverable(
 	dbus_bool_t discoverable;
 
 	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_BOOLEAN)
-		return g_dbus_pending_property_error(btd_get_dbus_connection(),
-				id, ERROR_INTERFACE ".InvalidArguments",
-				"Invalid arguments in method call");
+		return g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
 
 	dbus_message_iter_get_basic(value, &discoverable);
 
@@ -1274,9 +1266,9 @@ static void adapter_property_set_pairable(const GDBusPropertyTable *property,
 	dbus_bool_t pairable;
 
 	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_BOOLEAN)
-		return g_dbus_pending_property_error(btd_get_dbus_connection(),
-				id, ERROR_INTERFACE ".InvalidArguments",
-				"Invalid arguments in method call");
+		return g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
 
 	dbus_message_iter_get_basic(value, &pairable);
 
@@ -1303,9 +1295,9 @@ static void adapter_property_set_discoverable_timeout(
 	uint32_t timeout;
 
 	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_UINT32)
-		return g_dbus_pending_property_error(btd_get_dbus_connection(),
-				id, ERROR_INTERFACE ".InvalidArguments",
-				"Invalid arguments in method call");
+		return g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
 
 	dbus_message_iter_get_basic(value, &timeout);
 	set_discoverable_timeout(data, timeout, id);
@@ -1330,9 +1322,9 @@ static void adapter_property_set_pairable_timeout(
 	uint32_t timeout;
 
 	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_UINT32)
-		return g_dbus_pending_property_error(btd_get_dbus_connection(),
-				id, ERROR_INTERFACE ".InvalidArguments",
-				"Invalid arguments in method call");
+		return g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
 
 	dbus_message_iter_get_basic(value, &timeout);
 	set_pairable_timeout(data, timeout, id);
@@ -2361,13 +2353,12 @@ static void set_mode_complete(struct btd_adapter *adapter)
 
 	if (pending->type == SESSION_TYPE_MODE_GLOBAL) {
 		if (err < 0)
-			g_dbus_pending_property_error(conn, pending->prop_id,
+			g_dbus_pending_property_error(pending->prop_id,
 						ERROR_INTERFACE ".Failed",
 						strerror(-err));
 		else {
 			adapter->global_mode = adapter->mode;
-			g_dbus_pending_property_success(conn,
-							pending->prop_id);
+			g_dbus_pending_property_success(pending->prop_id);
 		}
 	} else if (pending->msg != NULL) {
 		DBusMessage *msg = pending->msg;
diff --git a/src/device.c b/src/device.c
index bb0f890..bc7f8dd 100644
--- a/src/device.c
+++ b/src/device.c
@@ -394,10 +394,8 @@ static void set_alias(GDBusPendingPropertySet id, const char *alias,
 
 	/* No change */
 	if ((device->alias == NULL && g_str_equal(alias, "")) ||
-					g_strcmp0(device->alias, alias) == 0) {
-		g_dbus_pending_property_success(btd_get_dbus_connection(), id);
-		return;
-	}
+					g_strcmp0(device->alias, alias) == 0)
+		return g_dbus_pending_property_success(id);
 
 	ba2str(adapter_get_address(adapter), srcaddr);
 	ba2str(&device->bdaddr, dstaddr);
@@ -405,11 +403,9 @@ static void set_alias(GDBusPendingPropertySet id, const char *alias,
 	/* Remove alias if empty string */
 	err = write_device_alias(srcaddr, dstaddr, device->bdaddr_type,
 					g_str_equal(alias, "") ? NULL : alias);
-	if (err < 0) {
-		g_dbus_pending_property_error(btd_get_dbus_connection(),
-				id, ERROR_INTERFACE ".Failed", strerror(-err));
-		return;
-	}
+	if (err < 0)
+		return g_dbus_pending_property_error(id,
+				ERROR_INTERFACE ".Failed", strerror(-err));
 
 	g_free(device->alias);
 	device->alias = g_str_equal(alias, "") ? NULL : g_strdup(alias);
@@ -417,7 +413,7 @@ static void set_alias(GDBusPendingPropertySet id, const char *alias,
 	g_dbus_emit_property_changed(btd_get_dbus_connection(),
 				device->path, DEVICE_INTERFACE, "Alias");
 
-	g_dbus_pending_property_success(btd_get_dbus_connection(), id);
+	g_dbus_pending_property_success(id);
 }
 
 static void dev_property_set_alias(const GDBusPropertyTable *property,
@@ -426,12 +422,10 @@ static void dev_property_set_alias(const GDBusPropertyTable *property,
 {
 	const char *alias;
 
-	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_STRING) {
-		g_dbus_pending_property_error(btd_get_dbus_connection(),
-				id, ERROR_INTERFACE ".InvalidArguments",
-				"Invalid arguments in method call");
-		return;
-	}
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_STRING)
+		return g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
 
 	dbus_message_iter_get_basic(value, &alias);
 
@@ -686,27 +680,23 @@ static void set_trust(GDBusPendingPropertySet id, gboolean value, void *data)
 	char srcaddr[18], dstaddr[18];
 	int err;
 
-	if (device->trusted == value) {
-		g_dbus_pending_property_success(btd_get_dbus_connection(), id);
-		return;
-	}
+	if (device->trusted == value)
+		return g_dbus_pending_property_success(id);
 
 	ba2str(adapter_get_address(adapter), srcaddr);
 	ba2str(&device->bdaddr, dstaddr);
 
 	err = write_trust(srcaddr, dstaddr, device->bdaddr_type, value);
-	if (err < 0) {
-		g_dbus_pending_property_error(btd_get_dbus_connection(),
-				id, ERROR_INTERFACE ".Failed", strerror(-err));
-		return;
-	}
+	if (err < 0)
+		return g_dbus_pending_property_error(id,
+				ERROR_INTERFACE ".Failed", strerror(-err));
 
 	device->trusted = value;
 
 	g_dbus_emit_property_changed(btd_get_dbus_connection(),
 				device->path, DEVICE_INTERFACE, "Trusted");
 
-	g_dbus_pending_property_success(btd_get_dbus_connection(), id);
+	g_dbus_pending_property_success(id);
 }
 
 static void dev_property_set_trusted(const GDBusPropertyTable *property,
@@ -715,12 +705,10 @@ static void dev_property_set_trusted(const GDBusPropertyTable *property,
 {
 	dbus_bool_t b;
 
-	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_BOOLEAN) {
-		g_dbus_pending_property_error(btd_get_dbus_connection(),
-				id, ERROR_INTERFACE ".InvalidArguments",
-				"Invalid arguments in method call");
-		return;
-	}
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_BOOLEAN)
+		return g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
 
 	dbus_message_iter_get_basic(value, &b);
 
@@ -750,17 +738,15 @@ static void set_blocked(GDBusPendingPropertySet id, gboolean value, void *data)
 
 	switch (-err) {
 	case 0:
-		g_dbus_pending_property_success(btd_get_dbus_connection(), id);
+		g_dbus_pending_property_success(id);
 		break;
 	case EINVAL:
-		g_dbus_pending_property_error(btd_get_dbus_connection(), id,
-					ERROR_INTERFACE ".Failed",
+		g_dbus_pending_property_error(id, ERROR_INTERFACE ".Failed",
 					"Kernel lacks blacklist support");
 		break;
 	default:
-		g_dbus_pending_property_error(btd_get_dbus_connection(), id,
-					ERROR_INTERFACE ".Failed",
-					strerror(-err));
+		g_dbus_pending_property_error(id, ERROR_INTERFACE ".Failed",
+							strerror(-err));
 		break;
 	}
 }
@@ -772,12 +758,10 @@ static void dev_property_set_blocked(const GDBusPropertyTable *property,
 {
 	dbus_bool_t b;
 
-	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_BOOLEAN) {
-		g_dbus_pending_property_error(btd_get_dbus_connection(),
-				id, ERROR_INTERFACE ".InvalidArguments",
-				"Invalid arguments in method call");
-		return;
-	}
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_BOOLEAN)
+		return g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
 
 	dbus_message_iter_get_basic(value, &b);
 
-- 
1.7.12.3

