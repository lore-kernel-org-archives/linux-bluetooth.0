Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 07/17] device: Simplify DBusConnection object handling
Date: Wed, 19 Sep 2012 12:22:09 +0200
Message-ID: <1348050139-27883-8-git-send-email-andrzej.kaczmarek@tieto.com>
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
 src/adapter.c |  26 +++++-----
 src/device.c  | 149 +++++++++++++++++++++++++---------------------------------
 src/device.h  |  29 +++++-------
 src/event.c   |   8 +---
 4 files changed, 93 insertions(+), 119 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index fb6a2e5..33ac246 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -940,7 +940,7 @@ static struct btd_device *adapter_create_device(DBusConnection *conn,
 
 	DBG("%s", address);
 
-	device = device_create(conn, adapter, address, bdaddr_type);
+	device = device_create(adapter, address, bdaddr_type);
 	if (!device)
 		return NULL;
 
@@ -1396,9 +1396,9 @@ static DBusMessage *create_device(DBusConnection *conn,
 		goto failed;
 
 	if (device_is_bredr(device))
-		err = device_browse_sdp(device, conn, msg, NULL, FALSE);
+		err = device_browse_sdp(device, msg, NULL, FALSE);
 	else
-		err = device_browse_primary(device, conn, msg, FALSE);
+		err = device_browse_primary(device, msg, FALSE);
 
 	if (err < 0) {
 		adapter_remove_device(conn, adapter, device, TRUE);
@@ -1479,7 +1479,7 @@ static DBusMessage *create_paired_device(DBusConnection *conn,
 			return btd_error_failed(msg, strerror(-err));
 	}
 
-	return device_create_bonding(device, conn, msg, agent_path, cap);
+	return device_create_bonding(device, msg, agent_path, cap);
 }
 
 static gint device_path_cmp(struct btd_device *device, const gchar *path)
@@ -1692,7 +1692,7 @@ static void create_stored_device_from_profiles(char *key, char *value,
 				address, (GCompareFunc) device_address_cmp))
 		return;
 
-	device = device_create(connection, adapter, address, bdaddr_type);
+	device = device_create(adapter, address, bdaddr_type);
 	if (!device)
 		return;
 
@@ -1701,7 +1701,7 @@ static void create_stored_device_from_profiles(char *key, char *value,
 
 	list = device_services_from_record(device, uuids);
 	if (list)
-		device_register_services(connection, device, list, ATT_PSM);
+		device_register_services(device, list, ATT_PSM);
 
 	device_probe_profiles(device, uuids);
 
@@ -1816,7 +1816,7 @@ static void create_stored_device_from_linkkeys(char *key, char *value,
 					(GCompareFunc) device_address_cmp))
 		return;
 
-	device = device_create(connection, adapter, address, bdaddr_type);
+	device = device_create(adapter, address, bdaddr_type);
 	if (device) {
 		device_set_temporary(device, FALSE);
 		adapter->devices = g_slist_append(adapter->devices, device);
@@ -1853,7 +1853,7 @@ static void create_stored_device_from_ltks(char *key, char *value,
 	if (g_strcmp0(srcaddr, address) == 0)
 		return;
 
-	device = device_create(connection, adapter, address, bdaddr_type);
+	device = device_create(adapter, address, bdaddr_type);
 	if (device) {
 		device_set_temporary(device, FALSE);
 		adapter->devices = g_slist_append(adapter->devices, device);
@@ -1870,7 +1870,7 @@ static void create_stored_device_from_blocked(char *key, char *value,
 				key, (GCompareFunc) device_address_cmp))
 		return;
 
-	device = device_create(connection, adapter, key, BDADDR_BREDR);
+	device = device_create(adapter, key, BDADDR_BREDR);
 	if (device) {
 		device_set_temporary(device, FALSE);
 		adapter->devices = g_slist_append(adapter->devices, device);
@@ -1928,7 +1928,7 @@ static void create_stored_device_from_primaries(char *key, char *value,
 			address, (GCompareFunc) device_address_cmp))
 		return;
 
-	device = device_create(connection, adapter, address, bdaddr_type);
+	device = device_create(adapter, address, bdaddr_type);
 	if (!device)
 		return;
 
@@ -1944,7 +1944,7 @@ static void create_stored_device_from_primaries(char *key, char *value,
 		uuids = g_slist_append(uuids, prim->uuid);
 	}
 
-	device_register_services(connection, device, services, -1);
+	device_register_services(device, services, -1);
 
 	device_probe_profiles(device, uuids);
 
@@ -3083,7 +3083,7 @@ void adapter_add_connection(struct btd_adapter *adapter,
 		return;
 	}
 
-	device_add_connection(device, connection);
+	device_add_connection(device);
 
 	adapter->connections = g_slist_append(adapter->connections, device);
 }
@@ -3098,7 +3098,7 @@ void adapter_remove_connection(struct btd_adapter *adapter,
 		return;
 	}
 
-	device_remove_connection(device, connection);
+	device_remove_connection(device);
 
 	adapter->connections = g_slist_remove(adapter->connections, device);
 
diff --git a/src/device.c b/src/device.c
index 3e28608..1b2c741 100644
--- a/src/device.c
+++ b/src/device.c
@@ -79,7 +79,6 @@ struct btd_disconnect_data {
 };
 
 struct bonding_req {
-	DBusConnection *conn;
 	DBusMessage *msg;
 	guint listener_id;
 	struct btd_device *device;
@@ -96,7 +95,6 @@ struct authentication_req {
 };
 
 struct browse_req {
-	DBusConnection *conn;
 	DBusMessage *msg;
 	struct btd_device *device;
 	GSList *match_uuids;
@@ -182,11 +180,10 @@ static uint16_t uuid_list[] = {
 static void browse_request_free(struct browse_req *req)
 {
 	if (req->listener_id)
-		g_dbus_remove_watch(req->conn, req->listener_id);
+		g_dbus_remove_watch(btd_get_dbus_connection(),
+							req->listener_id);
 	if (req->msg)
 		dbus_message_unref(req->msg);
-	if (req->conn)
-		dbus_connection_unref(req->conn);
 	if (req->device)
 		btd_device_unref(req->device);
 	g_slist_free_full(req->profiles_added, g_free);
@@ -436,8 +433,7 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	return reply;
 }
 
-static DBusMessage *set_alias(DBusConnection *conn, DBusMessage *msg,
-					const char *alias, void *data)
+static DBusMessage *set_alias(DBusMessage *msg, const char *alias, void *data)
 {
 	struct btd_device *device = data;
 	struct btd_adapter *adapter = device->adapter;
@@ -470,8 +466,7 @@ static DBusMessage *set_alias(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
-static DBusMessage *set_trust(DBusConnection *conn, DBusMessage *msg,
-					gboolean value, void *data)
+static DBusMessage *set_trust(DBusMessage *msg, gboolean value, void *data)
 {
 	struct btd_device *device = data;
 	struct btd_adapter *adapter = device->adapter;
@@ -519,8 +514,7 @@ static gboolean do_disconnect(gpointer user_data)
 	return FALSE;
 }
 
-int device_block(DBusConnection *conn, struct btd_device *device,
-						gboolean update_only)
+int device_block(struct btd_device *device, gboolean update_only)
 {
 	int err = 0;
 	bdaddr_t src;
@@ -557,8 +551,8 @@ int device_block(DBusConnection *conn, struct btd_device *device,
 	return 0;
 }
 
-int device_unblock(DBusConnection *conn, struct btd_device *device,
-				gboolean silent, gboolean update_only)
+int device_unblock(struct btd_device *device, gboolean silent,
+							gboolean update_only)
 {
 	int err = 0;
 	bdaddr_t src;
@@ -591,16 +585,15 @@ int device_unblock(DBusConnection *conn, struct btd_device *device,
 	return 0;
 }
 
-static DBusMessage *set_blocked(DBusConnection *conn, DBusMessage *msg,
-						gboolean value, void *data)
+static DBusMessage *set_blocked(DBusMessage *msg, gboolean value, void *data)
 {
 	struct btd_device *device = data;
 	int err;
 
 	if (value)
-		err = device_block(conn, device, FALSE);
+		err = device_block(device, FALSE);
 	else
-		err = device_unblock(conn, device, FALSE, FALSE);
+		err = device_unblock(device, FALSE, FALSE);
 
 	switch (-err) {
 	case 0:
@@ -638,7 +631,7 @@ static DBusMessage *set_property(DBusConnection *conn,
 			return btd_error_invalid_args(msg);
 		dbus_message_iter_get_basic(&sub, &value);
 
-		return set_trust(conn, msg, value, data);
+		return set_trust(msg, value, data);
 	} else if (g_str_equal("Alias", property)) {
 		const char *alias;
 
@@ -646,7 +639,7 @@ static DBusMessage *set_property(DBusConnection *conn,
 			return btd_error_invalid_args(msg);
 		dbus_message_iter_get_basic(&sub, &alias);
 
-		return set_alias(conn, msg, alias, data);
+		return set_alias(msg, alias, data);
 	} else if (g_str_equal("Blocked", property)) {
 		dbus_bool_t value;
 
@@ -655,7 +648,7 @@ static DBusMessage *set_property(DBusConnection *conn,
 
 		dbus_message_iter_get_basic(&sub, &value);
 
-		return set_blocked(conn, msg, value, data);
+		return set_blocked(msg, value, data);
 	}
 
 	return btd_error_invalid_args(msg);
@@ -685,7 +678,7 @@ static DBusMessage *discover_services(DBusConnection *conn,
 		return btd_error_invalid_args(msg);
 
 	if (strlen(pattern) == 0) {
-		err = device_browse_sdp(device, conn, msg, NULL, FALSE);
+		err = device_browse_sdp(device, msg, NULL, FALSE);
 		if (err < 0)
 			goto fail;
 	} else {
@@ -696,7 +689,7 @@ static DBusMessage *discover_services(DBusConnection *conn,
 
 		sdp_uuid128_to_uuid(&uuid);
 
-		err = device_browse_sdp(device, conn, msg, &uuid, FALSE);
+		err = device_browse_sdp(device, msg, &uuid, FALSE);
 		if (err < 0)
 			goto fail;
 	}
@@ -733,6 +726,7 @@ static void iter_append_record(DBusMessageIter *dict, uint32_t handle,
 static void discover_services_reply(struct browse_req *req, int err,
 							sdp_list_t *recs)
 {
+	DBusConnection *conn = btd_get_dbus_connection();
 	DBusMessage *reply;
 	DBusMessageIter iter, dict;
 	sdp_list_t *seq;
@@ -747,7 +741,7 @@ static void discover_services_reply(struct browse_req *req, int err,
 
 		reply = dbus_message_new_error(req->msg, err_if,
 							strerror(-err));
-		g_dbus_send_message(req->conn, reply);
+		g_dbus_send_message(conn, reply);
 		return;
 	}
 
@@ -782,7 +776,7 @@ static void discover_services_reply(struct browse_req *req, int err,
 
 	dbus_message_iter_close_container(&iter, &dict);
 
-	g_dbus_send_message(req->conn, reply);
+	g_dbus_send_message(conn, reply);
 }
 
 static DBusMessage *cancel_discover(DBusConnection *conn,
@@ -822,8 +816,6 @@ static void bonding_request_cancel(struct bonding_req *bonding)
 
 void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
 {
-	DBusConnection *conn = btd_get_dbus_connection();
-
 	if (device->bonding)
 		bonding_request_cancel(device->bonding);
 
@@ -858,9 +850,10 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
 	device->disconn_timer = g_timeout_add_seconds(DISCONNECT_TIMER,
 						do_disconnect, device);
 
-	g_dbus_emit_signal(conn, device->path,
-			DEVICE_INTERFACE, "DisconnectRequested",
-			DBUS_TYPE_INVALID);
+	g_dbus_emit_signal(btd_get_dbus_connection(),
+				device->path,
+				DEVICE_INTERFACE, "DisconnectRequested",
+				DBUS_TYPE_INVALID);
 }
 
 static DBusMessage *disconnect(DBusConnection *conn, DBusMessage *msg,
@@ -904,7 +897,7 @@ gboolean device_is_connected(struct btd_device *device)
 	return device->connected;
 }
 
-void device_add_connection(struct btd_device *device, DBusConnection *conn)
+void device_add_connection(struct btd_device *device)
 {
 	if (device->connected) {
 		char addr[18];
@@ -920,7 +913,7 @@ void device_add_connection(struct btd_device *device, DBusConnection *conn)
 					DBUS_TYPE_BOOLEAN, &device->connected);
 }
 
-void device_remove_connection(struct btd_device *device, DBusConnection *conn)
+void device_remove_connection(struct btd_device *device)
 {
 	if (!device->connected) {
 		char addr[18];
@@ -939,7 +932,8 @@ void device_remove_connection(struct btd_device *device, DBusConnection *conn)
 	while (device->disconnects) {
 		DBusMessage *msg = device->disconnects->data;
 
-		g_dbus_send_reply(conn, msg, DBUS_TYPE_INVALID);
+		g_dbus_send_reply(btd_get_dbus_connection(),
+							msg, DBUS_TYPE_INVALID);
 		device->disconnects = g_slist_remove(device->disconnects, msg);
 	}
 
@@ -1035,8 +1029,7 @@ static void device_set_version(struct btd_device *device, uint16_t value)
 				DBUS_TYPE_UINT16, &value);
 }
 
-struct btd_device *device_create(DBusConnection *conn,
-				struct btd_adapter *adapter,
+struct btd_device *device_create(struct btd_adapter *adapter,
 				const gchar *address, uint8_t bdaddr_type)
 {
 	gchar *address_up;
@@ -1057,9 +1050,10 @@ struct btd_device *device_create(DBusConnection *conn,
 
 	DBG("Creating device %s", device->path);
 
-	if (g_dbus_register_interface(conn, device->path, DEVICE_INTERFACE,
-				device_methods, device_signals, NULL,
-				device, device_free) == FALSE) {
+	if (g_dbus_register_interface(btd_get_dbus_connection(),
+					device->path, DEVICE_INTERFACE,
+					device_methods, device_signals, NULL,
+					device, device_free) == FALSE) {
 		device_free(device);
 		return NULL;
 	}
@@ -1077,7 +1071,7 @@ struct btd_device *device_create(DBusConnection *conn,
 	device->trusted = read_trust(&src, address, device->bdaddr_type);
 
 	if (read_blocked(&src, &device->bdaddr, device->bdaddr_type))
-		device_block(conn, device, FALSE);
+		device_block(device, FALSE);
 
 	if (read_link_key(&src, &device->bdaddr, device->bdaddr_type, NULL,
 								NULL) == 0) {
@@ -1149,7 +1143,6 @@ static void device_remove_stored(struct btd_device *device)
 {
 	bdaddr_t src, dst;
 	uint8_t dst_type;
-	DBusConnection *conn = btd_get_dbus_connection();
 
 	adapter_get_address(device->adapter, &src);
 	device_get_address(device, &dst, &dst_type);
@@ -1171,7 +1164,7 @@ static void device_remove_stored(struct btd_device *device)
 	delete_device_service(&src, &dst, dst_type);
 
 	if (device->blocked)
-		device_unblock(conn, device, TRUE, FALSE);
+		device_unblock(device, TRUE, FALSE);
 }
 
 void device_remove(struct btd_device *device, gboolean remove_stored)
@@ -1568,7 +1561,7 @@ static void create_device_reply(struct btd_device *device, struct browse_req *re
 	dbus_message_append_args(reply, DBUS_TYPE_OBJECT_PATH, &device->path,
 					DBUS_TYPE_INVALID);
 
-	g_dbus_send_message(req->conn, reply);
+	g_dbus_send_message(btd_get_dbus_connection(), reply);
 }
 
 GSList *device_services_from_record(struct btd_device *device, GSList *profiles)
@@ -1644,8 +1637,7 @@ static void search_cb(sdp_list_t *recs, int err, gpointer user_data)
 
 		list = device_services_from_record(device, req->profiles_added);
 		if (list)
-			device_register_services(req->conn, device, list,
-								ATT_PSM);
+			device_register_services(device, list, ATT_PSM);
 
 		device_probe_profiles(device, req->profiles_added);
 	}
@@ -1672,7 +1664,7 @@ send_reply:
 		if (err < 0) {
 			DBusMessage *reply;
 			reply = btd_error_failed(req->msg, strerror(-err));
-			g_dbus_send_message(req->conn, reply);
+			g_dbus_send_message(btd_get_dbus_connection(), reply);
 			goto cleanup;
 		}
 
@@ -1853,7 +1845,7 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 			DBusMessage *reply;
 			reply = btd_error_failed(req->msg,
 							att_ecode2str(status));
-			g_dbus_send_message(req->conn, reply);
+			g_dbus_send_message(btd_get_dbus_connection(), reply);
 		}
 		goto done;
 	}
@@ -1867,7 +1859,7 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 	g_slist_free_full(device->primaries, g_free);
 	device->primaries = NULL;
 
-	device_register_services(req->conn, device, g_slist_copy(services), -1);
+	device_register_services(device, g_slist_copy(services), -1);
 	if (req->profiles_removed)
 		device_remove_profiles(device, req->profiles_removed);
 
@@ -2008,7 +2000,7 @@ static void att_browse_error_cb(const GError *gerr, gpointer user_data)
 		DBusMessage *reply;
 
 		reply = btd_error_failed(req->msg, gerr->message);
-		g_dbus_send_message(req->conn, reply);
+		g_dbus_send_message(btd_get_dbus_connection(), reply);
 	}
 
 	device->browse = NULL;
@@ -2024,8 +2016,8 @@ static void att_browse_cb(gpointer user_data)
 							device->browse);
 }
 
-int device_browse_primary(struct btd_device *device, DBusConnection *conn,
-				DBusMessage *msg, gboolean secure)
+int device_browse_primary(struct btd_device *device, DBusMessage *msg,
+								gboolean secure)
 {
 	struct btd_adapter *adapter = device->adapter;
 	struct att_callbacks *attcb;
@@ -2071,10 +2063,6 @@ int device_browse_primary(struct btd_device *device, DBusConnection *conn,
 	}
 
 done:
-	if (conn == NULL)
-		conn = btd_get_dbus_connection();
-
-	req->conn = dbus_connection_ref(conn);
 
 	if (msg) {
 		const char *sender = dbus_message_get_sender(msg);
@@ -2082,7 +2070,8 @@ done:
 		req->msg = dbus_message_ref(msg);
 		/* Track the request owner to cancel it
 		 * automatically if the owner exits */
-		req->listener_id = g_dbus_add_disconnect_watch(conn,
+		req->listener_id = g_dbus_add_disconnect_watch(
+						btd_get_dbus_connection(),
 						sender,
 						discover_services_req_exit,
 						req, NULL);
@@ -2091,8 +2080,8 @@ done:
 	return 0;
 }
 
-int device_browse_sdp(struct btd_device *device, DBusConnection *conn,
-			DBusMessage *msg, uuid_t *search, gboolean reverse)
+int device_browse_sdp(struct btd_device *device, DBusMessage *msg,
+					uuid_t *search, gboolean reverse)
 {
 	struct btd_adapter *adapter = device->adapter;
 	struct browse_req *req;
@@ -2123,10 +2112,6 @@ int device_browse_sdp(struct btd_device *device, DBusConnection *conn,
 		return err;
 	}
 
-	if (conn == NULL)
-		conn = btd_get_dbus_connection();
-
-	req->conn = dbus_connection_ref(conn);
 	device->browse = req;
 
 	if (msg) {
@@ -2135,7 +2120,8 @@ int device_browse_sdp(struct btd_device *device, DBusConnection *conn,
 		req->msg = dbus_message_ref(msg);
 		/* Track the request owner to cancel it
 		 * automatically if the owner exits */
-		req->listener_id = g_dbus_add_disconnect_watch(conn,
+		req->listener_id = g_dbus_add_disconnect_watch(
+						btd_get_dbus_connection(),
 						sender,
 						discover_services_req_exit,
 						req, NULL);
@@ -2264,9 +2250,9 @@ static gboolean start_discovery(gpointer user_data)
 	struct btd_device *device = user_data;
 
 	if (device_is_bredr(device))
-		device_browse_sdp(device, NULL, NULL, NULL, TRUE);
+		device_browse_sdp(device, NULL, NULL, TRUE);
 	else
-		device_browse_primary(device, NULL, NULL, FALSE);
+		device_browse_primary(device, NULL, FALSE);
 
 	device->discov_timer = 0;
 
@@ -2313,14 +2299,12 @@ static void bonding_request_free(struct bonding_req *bonding)
 		return;
 
 	if (bonding->listener_id)
-		g_dbus_remove_watch(bonding->conn, bonding->listener_id);
+		g_dbus_remove_watch(btd_get_dbus_connection(),
+							bonding->listener_id);
 
 	if (bonding->msg)
 		dbus_message_unref(bonding->msg);
 
-	if (bonding->conn)
-		dbus_connection_unref(bonding->conn);
-
 	device = bonding->device;
 	g_free(bonding);
 
@@ -2363,8 +2347,7 @@ static void device_agent_removed(struct agent *agent, void *user_data)
 		device->authr->agent = NULL;
 }
 
-static struct bonding_req *bonding_request_new(DBusConnection *conn,
-						DBusMessage *msg,
+static struct bonding_req *bonding_request_new(DBusMessage *msg,
 						struct btd_device *device,
 						const char *agent_path,
 						uint8_t capability)
@@ -2390,7 +2373,6 @@ static struct bonding_req *bonding_request_new(DBusConnection *conn,
 proceed:
 	bonding = g_new0(struct bonding_req, 1);
 
-	bonding->conn = dbus_connection_ref(conn);
 	bonding->msg = dbus_message_ref(msg);
 
 	return bonding;
@@ -2414,7 +2396,6 @@ static void create_bond_req_exit(DBusConnection *conn, void *user_data)
 }
 
 DBusMessage *device_create_bonding(struct btd_device *device,
-					DBusConnection *conn,
 					DBusMessage *msg,
 					const char *agent_path,
 					uint8_t capability)
@@ -2464,10 +2445,11 @@ DBusMessage *device_create_bonding(struct btd_device *device,
 	if (err < 0)
 		return btd_error_failed(msg, strerror(-err));
 
-	bonding = bonding_request_new(conn, msg, device, agent_path,
+	bonding = bonding_request_new(msg, device, agent_path,
 					capability);
 
-	bonding->listener_id = g_dbus_add_disconnect_watch(conn,
+	bonding->listener_id = g_dbus_add_disconnect_watch(
+						btd_get_dbus_connection(),
 						dbus_message_get_sender(msg),
 						create_bond_req_exit, device,
 						NULL);
@@ -2534,11 +2516,9 @@ void device_bonding_complete(struct btd_device *device, uint8_t status)
 		}
 
 		if (device_is_bredr(device))
-			device_browse_sdp(device, bonding->conn, bonding->msg,
-								NULL, FALSE);
+			device_browse_sdp(device, bonding->msg, NULL, FALSE);
 		else
-			device_browse_primary(device, bonding->conn,
-							bonding->msg, FALSE);
+			device_browse_primary(device, bonding->msg, FALSE);
 
 		bonding_request_free(bonding);
 	} else {
@@ -2608,7 +2588,7 @@ void device_cancel_bonding(struct btd_device *device, uint8_t status)
 		device_cancel_authentication(device, FALSE);
 
 	reply = new_authentication_return(bonding->msg, status);
-	g_dbus_send_message(bonding->conn, reply);
+	g_dbus_send_message(btd_get_dbus_connection(), reply);
 
 	bonding_request_cancel(bonding);
 	bonding_request_free(bonding);
@@ -2965,12 +2945,13 @@ void device_set_authorizing(struct btd_device *device, gboolean auth)
 	device->authorizing = auth;
 }
 
-void device_register_services(DBusConnection *conn, struct btd_device *device,
+void device_register_services(struct btd_device *device,
 						GSList *prim_list, int psm)
 {
 	device->primaries = g_slist_concat(device->primaries, prim_list);
-	device->services = attrib_client_register(conn, device, psm, NULL,
-								prim_list);
+	device->services = attrib_client_register(btd_get_dbus_connection(),
+							device, psm, NULL,
+							prim_list);
 }
 
 GSList *btd_device_get_primaries(struct btd_device *device)
@@ -2990,7 +2971,7 @@ void btd_device_gatt_set_service_changed(struct btd_device *device,
 			prim->changed = TRUE;
 	}
 
-	device_browse_primary(device, NULL, NULL, FALSE);
+	device_browse_primary(device, NULL, FALSE);
 }
 
 void btd_device_add_uuid(struct btd_device *device, const char *uuid)
@@ -3050,7 +3031,6 @@ struct btd_device *btd_device_ref(struct btd_device *device)
 
 void btd_device_unref(struct btd_device *device)
 {
-	DBusConnection *conn = btd_get_dbus_connection();
 	gchar *path;
 
 	device->ref--;
@@ -3062,7 +3042,8 @@ void btd_device_unref(struct btd_device *device)
 
 	path = g_strdup(device->path);
 
-	g_dbus_unregister_interface(conn, path, DEVICE_INTERFACE);
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+							path, DEVICE_INTERFACE);
 
 	g_free(path);
 }
diff --git a/src/device.h b/src/device.h
index 9426ef8..44cb615 100644
--- a/src/device.h
+++ b/src/device.h
@@ -34,9 +34,8 @@ typedef enum {
 	AUTH_TYPE_NOTIFY_PINCODE,
 } auth_type_t;
 
-struct btd_device *device_create(DBusConnection *conn,
-					struct btd_adapter *adapter,
-					const char *address, uint8_t bdaddr_type);
+struct btd_device *device_create(struct btd_adapter *adapter,
+				const char *address, uint8_t bdaddr_type);
 
 void device_set_name(struct btd_device *device, const char *name);
 void device_get_name(struct btd_device *device, char *name, size_t len);
@@ -47,17 +46,17 @@ uint16_t btd_device_get_version(struct btd_device *device);
 void device_remove(struct btd_device *device, gboolean remove_stored);
 gint device_address_cmp(struct btd_device *device, const gchar *address);
 gint device_bdaddr_cmp(struct btd_device *device, bdaddr_t *bdaddr);
-int device_browse_primary(struct btd_device *device, DBusConnection *conn,
-				DBusMessage *msg, gboolean secure);
-int device_browse_sdp(struct btd_device *device, DBusConnection *conn,
-			DBusMessage *msg, uuid_t *search, gboolean reverse);
+int device_browse_primary(struct btd_device *device, DBusMessage *msg,
+							gboolean secure);
+int device_browse_sdp(struct btd_device *device, DBusMessage *msg,
+					uuid_t *search, gboolean reverse);
 void device_probe_profiles(struct btd_device *device, GSList *profiles);
 const sdp_record_t *btd_device_get_record(struct btd_device *device,
 						const char *uuid);
 GSList *btd_device_get_primaries(struct btd_device *device);
 void btd_device_gatt_set_service_changed(struct btd_device *device,
 						uint16_t start, uint16_t end);
-void device_register_services(DBusConnection *conn, struct btd_device *device,
+void device_register_services(struct btd_device *device,
 						GSList *prim_list, int psm);
 GSList *device_services_from_record(struct btd_device *device,
 							GSList *profiles);
@@ -81,8 +80,7 @@ void device_set_temporary(struct btd_device *device, gboolean temporary);
 void device_set_bonded(struct btd_device *device, gboolean bonded);
 void device_set_auto_connect(struct btd_device *device, gboolean enable);
 gboolean device_is_connected(struct btd_device *device);
-DBusMessage *device_create_bonding(struct btd_device *device,
-				DBusConnection *conn, DBusMessage *msg,
+DBusMessage *device_create_bonding(struct btd_device *device, DBusMessage *msg,
 				const char *agent_path, uint8_t capability);
 void device_bonding_complete(struct btd_device *device, uint8_t status);
 void device_simple_pairing_complete(struct btd_device *device, uint8_t status);
@@ -102,8 +100,8 @@ void device_cancel_authentication(struct btd_device *device, gboolean aborted);
 gboolean device_is_authenticating(struct btd_device *device);
 gboolean device_is_authorizing(struct btd_device *device);
 void device_set_authorizing(struct btd_device *device, gboolean auth);
-void device_add_connection(struct btd_device *device, DBusConnection *conn);
-void device_remove_connection(struct btd_device *device, DBusConnection *conn);
+void device_add_connection(struct btd_device *device);
+void device_remove_connection(struct btd_device *device);
 void device_request_disconnect(struct btd_device *device, DBusMessage *msg);
 
 typedef void (*disconnect_watch) (struct btd_device *device, gboolean removal,
@@ -120,10 +118,9 @@ void device_set_appearance(struct btd_device *device, uint16_t value);
 struct btd_device *btd_device_ref(struct btd_device *device);
 void btd_device_unref(struct btd_device *device);
 
-int device_block(DBusConnection *conn, struct btd_device *device,
-						gboolean update_only);
-int device_unblock(DBusConnection *conn, struct btd_device *device,
-					gboolean silent, gboolean update_only);
+int device_block(struct btd_device *device, gboolean update_only);
+int device_unblock(struct btd_device *device, gboolean silent,
+							gboolean update_only);
 void device_set_pnpid(struct btd_device *device, uint8_t vendor_id_src,
 			uint16_t vendor_id, uint16_t product_id,
 			uint16_t product_ver);
diff --git a/src/event.c b/src/event.c
index e720b26..f1f5aaf 100644
--- a/src/event.c
+++ b/src/event.c
@@ -521,13 +521,11 @@ void btd_event_device_blocked(bdaddr_t *local, bdaddr_t *peer)
 	struct btd_adapter *adapter;
 	struct btd_device *device;
 
-	DBusConnection *conn = btd_get_dbus_connection();
-
 	if (!get_adapter_and_device(local, peer, &adapter, &device, FALSE))
 		return;
 
 	if (device)
-		device_block(conn, device, TRUE);
+		device_block(device, TRUE);
 }
 
 void btd_event_device_unblocked(bdaddr_t *local, bdaddr_t *peer)
@@ -535,13 +533,11 @@ void btd_event_device_unblocked(bdaddr_t *local, bdaddr_t *peer)
 	struct btd_adapter *adapter;
 	struct btd_device *device;
 
-	DBusConnection *conn = btd_get_dbus_connection();
-
 	if (!get_adapter_and_device(local, peer, &adapter, &device, FALSE))
 		return;
 
 	if (device)
-		device_unblock(conn, device, FALSE, TRUE);
+		device_unblock(device, FALSE, TRUE);
 }
 
 void btd_event_device_unpaired(bdaddr_t *local, bdaddr_t *peer)
-- 
1.7.11.3

