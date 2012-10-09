Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 7/8] adapter: Port remaining properties to DBus.Properties
Date: Tue,  9 Oct 2012 04:59:55 -0300
Message-Id: <1349769596-6050-7-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1349769596-6050-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1349769596-6050-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

Remaining properties ported to DBus.Properties:
	- Pairable
	- Discoverable
	- Powered
---
 src/adapter.c | 197 +++++++++++++++++++++++++++++++---------------------------
 1 file changed, 107 insertions(+), 90 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index a6593b2..18689c6 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -95,6 +95,7 @@ struct session_req {
 	struct btd_adapter	*adapter;
 	enum session_req_type	type;
 	DBusMessage		*msg;		/* Unreplied message ref */
+	GDBusPendingPropertySet prop_id;	/* Pending Properties.Set() */
 	char			*owner;		/* Bus name of the owner */
 	guint			id;		/* Listener id */
 	uint8_t			mode;		/* Requested mode */
@@ -347,10 +348,10 @@ static void set_session_pending_mode(struct btd_adapter *adapter,
 					SESSION_REQ_TYPE_SESSION, NULL);
 }
 
-static DBusMessage *set_discoverable(DBusMessage *msg,
-					gboolean discoverable, void *data)
+static void set_discoverable(struct btd_adapter *adapter,
+			gboolean discoverable, GDBusPendingPropertySet id)
 {
-	struct btd_adapter *adapter = data;
+	DBusConnection *conn = btd_get_dbus_connection();
 	uint8_t mode;
 	int err;
 
@@ -358,55 +359,61 @@ static DBusMessage *set_discoverable(DBusMessage *msg,
 
 	if (mode == adapter->mode) {
 		adapter->global_mode = mode;
-		return dbus_message_new_method_return(msg);
+		return g_dbus_pending_property_success(conn, id);
 	}
 
 	err = set_mode(adapter, mode);
 	if (err < 0)
-		return btd_error_failed(msg, strerror(-err));
+		return g_dbus_pending_property_error(conn, id,
+						ERROR_INTERFACE ".Failed",
+						strerror(-err));
 
-	adapter->pending_mode = create_session(adapter, msg, mode,
+	adapter->pending_mode = create_session(adapter, NULL, mode,
 						SESSION_REQ_TYPE_GLOBAL, NULL);
-
-	return NULL;
+	adapter->pending_mode->prop_id = id;
 }
 
-static DBusMessage *set_powered(DBusMessage *msg, gboolean powered, void *data)
+static void set_powered(struct btd_adapter *adapter, gboolean powered,
+						GDBusPendingPropertySet id)
 {
-	struct btd_adapter *adapter = data;
+	DBusConnection *conn = btd_get_dbus_connection();
 	uint8_t mode;
 	int err;
 
 	if (powered) {
 		mode = get_mode(&adapter->bdaddr, "on");
-		return set_discoverable(msg, mode == MODE_DISCOVERABLE, data);
+		return set_discoverable(adapter, mode == MODE_DISCOVERABLE,
+									id);
 	}
 
 	mode = MODE_OFF;
 
 	if (mode == adapter->mode) {
 		adapter->global_mode = mode;
-		return dbus_message_new_method_return(msg);
+		return g_dbus_pending_property_success(conn, id);
 	}
 
 	err = set_mode(adapter, mode);
 	if (err < 0)
-		return btd_error_failed(msg, strerror(-err));
+		return g_dbus_pending_property_error(conn, id,
+						ERROR_INTERFACE ".Failed",
+						strerror(-err));
 
-	adapter->pending_mode = create_session(adapter, msg, mode,
+	adapter->pending_mode = create_session(adapter, NULL, mode,
 						SESSION_REQ_TYPE_GLOBAL, NULL);
-
-	return NULL;
+	adapter->pending_mode->prop_id = id;
 }
 
-static DBusMessage *set_pairable(DBusMessage *msg,
-						gboolean pairable, void *data)
+static void set_pairable(struct btd_adapter *adapter, gboolean pairable,
+				bool reply, GDBusPendingPropertySet id)
 {
-	struct btd_adapter *adapter = data;
+	DBusConnection *conn = btd_get_dbus_connection();
 	int err;
 
 	if (adapter->scan_mode == SCAN_DISABLED)
-		return btd_error_not_ready(msg);
+		return g_dbus_pending_property_error(conn, id,
+						ERROR_INTERFACE ".NotReady",
+						"Resource Not Ready");
 
 	if (pairable == adapter->pairable)
 		goto done;
@@ -416,22 +423,26 @@ static DBusMessage *set_pairable(DBusMessage *msg,
 
 	err = set_mode(adapter, MODE_DISCOVERABLE);
 	if (err < 0) {
-		if (msg != NULL)
-			return btd_error_failed(msg, strerror(-err));
-
-		return NULL;
+		if (reply)
+			g_dbus_pending_property_error(conn, id,
+						ERROR_INTERFACE ".Failed",
+						strerror(-err));
+		return;
 	}
 
 store:
 	mgmt_set_pairable(adapter->dev_id, pairable);
 
 done:
-	return msg ? dbus_message_new_method_return(msg) : NULL;
+	if (reply)
+		g_dbus_pending_property_success(conn, id);
 }
 
+
+
 static gboolean pairable_timeout_handler(void *data)
 {
-	set_pairable(NULL, FALSE, data);
+	set_pairable(data, FALSE, false, 0);
 
 	return FALSE;
 }
@@ -1201,6 +1212,23 @@ static gboolean adapter_property_get_powered(
 	return TRUE;
 }
 
+static void adapter_property_set_powered(
+				const GDBusPropertyTable *property,
+				DBusMessageIter *value,
+				GDBusPendingPropertySet id, void *data)
+{
+	dbus_bool_t powered;
+
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_BOOLEAN)
+		return g_dbus_pending_property_error(btd_get_dbus_connection(),
+				id, ERROR_INTERFACE ".InvalidArguments",
+				"Invalid arguments in method call");
+
+	dbus_message_iter_get_basic(value, &powered);
+
+	set_powered(data, powered, id);
+}
+
 static gboolean adapter_property_get_discoverable(
 					const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
@@ -1214,6 +1242,23 @@ static gboolean adapter_property_get_discoverable(
 	return TRUE;
 }
 
+static void adapter_property_set_discoverable(
+				const GDBusPropertyTable *property,
+				DBusMessageIter *value,
+				GDBusPendingPropertySet id, void *data)
+{
+	dbus_bool_t discoverable;
+
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_BOOLEAN)
+		return g_dbus_pending_property_error(btd_get_dbus_connection(),
+				id, ERROR_INTERFACE ".InvalidArguments",
+				"Invalid arguments in method call");
+
+	dbus_message_iter_get_basic(value, &discoverable);
+
+	set_discoverable(data, discoverable, id);
+}
+
 static gboolean adapter_property_get_pairable(
 					const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
@@ -1225,6 +1270,22 @@ static gboolean adapter_property_get_pairable(
 	return TRUE;
 }
 
+static void adapter_property_set_pairable(const GDBusPropertyTable *property,
+		DBusMessageIter *value,
+		GDBusPendingPropertySet id, void *data)
+{
+	dbus_bool_t pairable;
+
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_BOOLEAN)
+		return g_dbus_pending_property_error(btd_get_dbus_connection(),
+				id, ERROR_INTERFACE ".InvalidArguments",
+				"Invalid arguments in method call");
+
+	dbus_message_iter_get_basic(value, &pairable);
+
+	set_pairable(data, pairable, true, id);
+}
+
 static gboolean adapter_property_get_discoverable_timeout(
 					const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
@@ -1342,58 +1403,6 @@ static gboolean adapter_property_get_uuids(const GDBusPropertyTable *property,
 
 	return TRUE;
 }
-static DBusMessage *set_property(DBusConnection *conn,
-					DBusMessage *msg, void *data)
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
-
-	if (g_str_equal("Powered", property)) {
-		gboolean powered;
-
-		if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_BOOLEAN)
-			return btd_error_invalid_args(msg);
-
-		dbus_message_iter_get_basic(&sub, &powered);
-
-		return set_powered(msg, powered, data);
-	} else if (g_str_equal("Discoverable", property)) {
-		gboolean discoverable;
-
-		if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_BOOLEAN)
-			return btd_error_invalid_args(msg);
-
-		dbus_message_iter_get_basic(&sub, &discoverable);
-
-		return set_discoverable(msg, discoverable, data);
-	} else if (g_str_equal("Pairable", property)) {
-		gboolean pairable;
-
-		if (dbus_message_iter_get_arg_type(&sub) != DBUS_TYPE_BOOLEAN)
-			return btd_error_invalid_args(msg);
-
-		dbus_message_iter_get_basic(&sub, &pairable);
-
-		return set_pairable(msg, pairable, data);
-	}
-
-	return btd_error_invalid_args(msg);
-}
 
 static DBusMessage *request_session(DBusConnection *conn,
 					DBusMessage *msg, void *data)
@@ -1760,9 +1769,6 @@ static DBusMessage *unregister_agent(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable adapter_methods[] = {
-	{ GDBUS_ASYNC_METHOD("SetProperty",
-			GDBUS_ARGS({ "name", "s" }, { "value", "v" }), NULL,
-			set_property) },
 	{ GDBUS_ASYNC_METHOD("RequestSession", NULL, NULL,
 			request_session) },
 	{ GDBUS_METHOD("ReleaseSession", NULL, NULL,
@@ -1819,9 +1825,12 @@ static const GDBusPropertyTable adapter_properties[] = {
 	{ "Address", "s", adapter_property_get_address },
 	{ "Name", "s", adapter_property_get_name, adapter_property_set_name },
 	{ "Class", "u", adapter_property_get_class },
-	{ "Powered", "b", adapter_property_get_powered },
-	{ "Discoverable", "b", adapter_property_get_discoverable },
-	{ "Pairable", "b", adapter_property_get_pairable },
+	{ "Powered", "b", adapter_property_get_powered,
+					adapter_property_set_powered },
+	{ "Discoverable", "b", adapter_property_get_discoverable,
+					adapter_property_set_discoverable },
+	{ "Pairable", "b", adapter_property_get_pairable,
+					adapter_property_set_pairable },
 	{ "DiscoverableTimeout", "u",
 			adapter_property_get_discoverable_timeout,
 			adapter_property_set_discoverable_timeout },
@@ -2524,6 +2533,7 @@ static void unload_drivers(struct btd_adapter *adapter)
 
 static void set_mode_complete(struct btd_adapter *adapter)
 {
+	DBusConnection *conn = btd_get_dbus_connection();
 	struct session_req *pending;
 	const char *modestr;
 	int err;
@@ -2546,19 +2556,26 @@ static void set_mode_complete(struct btd_adapter *adapter)
 
 	err = (pending->mode != adapter->mode) ? -EINVAL : 0;
 
-	if (pending->msg != NULL) {
+	if (pending->type == SESSION_REQ_TYPE_GLOBAL) {
+		if (err < 0)
+			g_dbus_pending_property_error(conn, pending->prop_id,
+						ERROR_INTERFACE ".Failed",
+						strerror(-err));
+		else {
+			adapter->global_mode = adapter->mode;
+			g_dbus_pending_property_success(conn,
+							pending->prop_id);
+		}
+	} else if (pending->msg != NULL) {
 		DBusMessage *msg = pending->msg;
 		DBusMessage *reply;
 
 		if (err < 0)
 			reply = btd_error_failed(msg, strerror(-err));
-		else {
-			if (pending->type == SESSION_REQ_TYPE_GLOBAL)
-				adapter->global_mode = adapter->mode;
+		else
 			reply = g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
-		}
 
-		g_dbus_send_message(btd_get_dbus_connection(), reply);
+		g_dbus_send_message(conn, reply);
 	}
 
 	if (err != 0)
-- 
1.7.12.2

