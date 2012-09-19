Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 16/17] service: Simplify DBusConnection object handling
Date: Wed, 19 Sep 2012 12:22:18 +0200
Message-ID: <1348050139-27883-17-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1348050139-27883-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348050139-27883-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes redundant references and function parameters for
DBusConnection object and uses btd_get_dbus_connection() call wherever
such object is needed instead.

Pointer returned by this call is guaranteed to be valid for entire
bluetoothd lifetime and thus do not need to be refcounted.
---
 plugins/service.c | 74 ++++++++++++++++++++++---------------------------------
 1 file changed, 29 insertions(+), 45 deletions(-)

diff --git a/plugins/service.c b/plugins/service.c
index f16abe7..9bb8882 100644
--- a/plugins/service.c
+++ b/plugins/service.c
@@ -36,6 +36,7 @@
 
 #include <gdbus.h>
 
+#include "dbus-common.h"
 #include "sdpd.h"
 #include "sdp-xml.h"
 #include "plugin.h"
@@ -45,8 +46,6 @@
 
 #define SERVICE_INTERFACE "org.bluez.Service"
 
-static DBusConnection *connection;
-
 struct record_data {
 	uint32_t handle;
 	char *sender;
@@ -62,7 +61,6 @@ struct context_data {
 };
 
 struct pending_auth {
-	DBusConnection *conn;
 	DBusMessage *msg;
 	char *sender;
 	bdaddr_t dst;
@@ -338,7 +336,7 @@ static void exit_callback(DBusConnection *conn, void *user_data)
 	g_free(user_record);
 }
 
-static int add_xml_record(DBusConnection *conn, const char *sender,
+static int add_xml_record(const char *sender,
 			struct service_adapter *serv_adapter,
 			const char *record, dbus_uint32_t *handle)
 {
@@ -367,7 +365,8 @@ static int add_xml_record(DBusConnection *conn, const char *sender,
 	user_record->handle = sdp_record->handle;
 	user_record->sender = g_strdup(sender);
 	user_record->serv_adapter = serv_adapter;
-	user_record->listener_id = g_dbus_add_disconnect_watch(conn, sender,
+	user_record->listener_id =
+		g_dbus_add_disconnect_watch(btd_get_dbus_connection(), sender,
 					exit_callback, user_record, NULL);
 
 	serv_adapter->records = g_slist_append(serv_adapter->records,
@@ -380,9 +379,9 @@ static int add_xml_record(DBusConnection *conn, const char *sender,
 	return 0;
 }
 
-static DBusMessage *update_record(DBusConnection *conn, DBusMessage *msg,
-		struct service_adapter *serv_adapter,
-		dbus_uint32_t handle, sdp_record_t *sdp_record)
+static DBusMessage *update_record(DBusMessage *msg,
+				struct service_adapter *serv_adapter,
+				dbus_uint32_t handle, sdp_record_t *sdp_record)
 {
 	bdaddr_t src;
 	int err;
@@ -408,9 +407,8 @@ static DBusMessage *update_record(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
-static DBusMessage *update_xml_record(DBusConnection *conn,
-				DBusMessage *msg,
-				struct service_adapter *serv_adapter)
+static DBusMessage *update_xml_record(DBusMessage *msg,
+					struct service_adapter *serv_adapter)
 {
 	struct record_data *user_record;
 	sdp_record_t *sdp_record;
@@ -440,13 +438,14 @@ static DBusMessage *update_xml_record(DBusConnection *conn,
 					"Parsing of XML service record failed");
 	}
 
-	return update_record(conn, msg, serv_adapter, handle, sdp_record);
+	return update_record(msg, serv_adapter, handle, sdp_record);
 }
 
-static int remove_record(DBusConnection *conn, const char *sender,
-			struct service_adapter *serv_adapter,
-			dbus_uint32_t handle)
+static int remove_record(const char *sender,
+				struct service_adapter *serv_adapter,
+				dbus_uint32_t handle)
 {
+	DBusConnection *conn = btd_get_dbus_connection();
 	struct record_data *user_record;
 
 	DBG("remove record 0x%x", handle);
@@ -478,7 +477,7 @@ static DBusMessage *add_service_record(DBusConnection *conn,
 		return btd_error_invalid_args(msg);
 
 	sender = dbus_message_get_sender(msg);
-	err = add_xml_record(conn, sender, serv_adapter, record, &handle);
+	err = add_xml_record(sender, serv_adapter, record, &handle);
 	if (err < 0)
 		return btd_error_failed(msg, strerror(-err));
 
@@ -497,7 +496,7 @@ static DBusMessage *update_service_record(DBusConnection *conn,
 {
 	struct service_adapter *serv_adapter = data;
 
-	return update_xml_record(conn, msg, serv_adapter);
+	return update_xml_record(msg, serv_adapter);
 }
 
 static DBusMessage *remove_service_record(DBusConnection *conn,
@@ -513,7 +512,7 @@ static DBusMessage *remove_service_record(DBusConnection *conn,
 
 	sender = dbus_message_get_sender(msg);
 
-	if (remove_record(conn, sender, serv_adapter, handle) < 0)
+	if (remove_record(sender, serv_adapter, handle) < 0)
 		return btd_error_not_available(msg);
 
 	return dbus_message_new_method_return(msg);
@@ -521,6 +520,7 @@ static DBusMessage *remove_service_record(DBusConnection *conn,
 
 static void auth_cb(DBusError *derr, void *user_data)
 {
+	DBusConnection *conn = btd_get_dbus_connection();
 	struct service_adapter *serv_adapter = user_data;
 	DBusMessage *reply;
 	struct pending_auth *auth;
@@ -537,16 +537,14 @@ static void auth_cb(DBusError *derr, void *user_data)
 
 		reply = btd_error_not_authorized(auth->msg);
 		dbus_message_unref(auth->msg);
-		g_dbus_send_message(auth->conn, reply);
+		g_dbus_send_message(conn, reply);
 		goto done;
 	}
 
-	g_dbus_send_reply(auth->conn, auth->msg,
+	g_dbus_send_reply(conn, auth->msg,
 			DBUS_TYPE_INVALID);
 
 done:
-	dbus_connection_unref(auth->conn);
-
 	serv_adapter->pending_list = g_slist_remove(serv_adapter->pending_list,
 									auth);
 	g_free(auth);
@@ -620,7 +618,6 @@ static DBusMessage *request_authorization(DBusConnection *conn,
 
 	auth = g_new0(struct pending_auth, 1);
 	auth->msg = dbus_message_ref(msg);
-	auth->conn = dbus_connection_ref(connection);
 	auth->sender = user_record->sender;
 	memcpy(auth->uuid, uuid_str, MAX_LEN_UUID_STR);
 	str2ba(address, &auth->dst);
@@ -672,9 +669,7 @@ static DBusMessage *cancel_authorization(DBusConnection *conn,
 
 	reply = btd_error_not_authorized(auth->msg);
 	dbus_message_unref(auth->msg);
-	g_dbus_send_message(auth->conn, reply);
-
-	dbus_connection_unref(auth->conn);
+	g_dbus_send_message(btd_get_dbus_connection(), reply);
 
 	serv_adapter->pending_list = g_slist_remove(serv_adapter->pending_list,
 									auth);
@@ -717,6 +712,7 @@ static const GDBusMethodTable service_methods[] = {
 
 static void path_unregister(void *data)
 {
+	DBusConnection *conn = btd_get_dbus_connection();
 	struct service_adapter *serv_adapter = data;
 	GSList *l, *next = NULL;
 
@@ -725,8 +721,8 @@ static void path_unregister(void *data)
 
 		next = l->next;
 
-		g_dbus_remove_watch(connection, user_record->listener_id);
-		exit_callback(connection, user_record);
+		g_dbus_remove_watch(conn, user_record->listener_id);
+		exit_callback(conn, user_record);
 	}
 
 	if (serv_adapter->adapter != NULL)
@@ -750,7 +746,8 @@ static int register_interface(const char *path, struct btd_adapter *adapter)
 
 	serv_adapter->pending_list = NULL;
 
-	if (g_dbus_register_interface(connection, path, SERVICE_INTERFACE,
+	if (g_dbus_register_interface(btd_get_dbus_connection(),
+				path, SERVICE_INTERFACE,
 				service_methods, NULL, NULL, serv_adapter,
 						path_unregister) == FALSE) {
 		error("D-Bus failed to register %s interface",
@@ -771,7 +768,8 @@ static void unregister_interface(const char *path)
 {
 	DBG("path %s", path);
 
-	g_dbus_unregister_interface(connection, path, SERVICE_INTERFACE);
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+						path, SERVICE_INTERFACE);
 }
 
 static int service_probe(struct btd_adapter *adapter)
@@ -796,12 +794,6 @@ static const char *any_path;
 
 static int service_init(void)
 {
-	int err;
-
-	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
-	if (connection == NULL)
-		return -EIO;
-
 	any_path = btd_adapter_any_request_path();
 	if (any_path != NULL) {
 		if (register_interface(any_path, NULL) < 0) {
@@ -810,13 +802,7 @@ static int service_init(void)
 		}
 	}
 
-	err = btd_register_adapter_driver(&service_driver);
-	if (err < 0) {
-		dbus_connection_unref(connection);
-		return err;
-	}
-
-	return 0;
+	return btd_register_adapter_driver(&service_driver);
 }
 
 static void service_exit(void)
@@ -829,8 +815,6 @@ static void service_exit(void)
 		btd_adapter_any_release_path();
 		any_path = NULL;
 	}
-
-	dbus_connection_unref(connection);
 }
 
 BLUETOOTH_PLUGIN_DEFINE(service, VERSION,
-- 
1.7.11.3

