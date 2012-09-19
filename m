Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 08/17] adapter: Simplify DBusConnection object handling
Date: Wed, 19 Sep 2012 12:22:10 +0200
Message-ID: <1348050139-27883-9-git-send-email-andrzej.kaczmarek@tieto.com>
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
 audio/manager.c       |   2 +-
 profiles/health/hdp.c |   3 +-
 src/adapter.c         | 132 ++++++++++++++++++++++----------------------------
 src/adapter.h         |   8 +--
 src/event.c           |   9 ++--
 src/manager.c         |   2 +-
 6 files changed, 68 insertions(+), 88 deletions(-)

diff --git a/audio/manager.c b/audio/manager.c
index 99fcaf8..3b105ed 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -1329,7 +1329,7 @@ struct audio_device *manager_get_device(const bdaddr_t *src,
 
 	ba2str(dst, addr);
 
-	device = adapter_get_device(connection, adapter, addr);
+	device = adapter_get_device(adapter, addr);
 	if (!device) {
 		error("Unable to get btd_device object for %s", addr);
 		return NULL;
diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index 351fe1e..489e1eb 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -1209,8 +1209,7 @@ static void mcl_connected(struct mcap_mcl *mcl, gpointer data)
 		char str[18];
 
 		ba2str(&addr, str);
-		device = adapter_get_device(connection,
-					hdp_adapter->btd_adapter, str);
+		device = adapter_get_device(hdp_adapter->btd_adapter, str);
 		if (!device)
 			return;
 		hdp_device = create_health_device(connection, device);
diff --git a/src/adapter.c b/src/adapter.c
index 33ac246..d804472 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -84,12 +84,10 @@
 
 #define OFF_TIMER 3
 
-static DBusConnection *connection = NULL;
 static GSList *adapter_drivers = NULL;
 
 struct session_req {
 	struct btd_adapter	*adapter;
-	DBusConnection		*conn;		/* Connection reference */
 	DBusMessage		*msg;		/* Unreplied message ref */
 	char			*owner;		/* Bus name of the owner */
 	guint			id;		/* Listener id */
@@ -218,15 +216,14 @@ static struct session_req *session_ref(struct session_req *req)
 }
 
 static struct session_req *create_session(struct btd_adapter *adapter,
-					DBusConnection *conn, DBusMessage *msg,
-					uint8_t mode, GDBusWatchFunction cb)
+					DBusMessage *msg, uint8_t mode,
+					GDBusWatchFunction cb)
 {
 	const char *sender = dbus_message_get_sender(msg);
 	struct session_req *req;
 
 	req = g_new0(struct session_req, 1);
 	req->adapter = adapter;
-	req->conn = dbus_connection_ref(conn);
 	req->msg = dbus_message_ref(msg);
 	req->mode = mode;
 
@@ -234,7 +231,8 @@ static struct session_req *create_session(struct btd_adapter *adapter,
 		return session_ref(req);
 
 	req->owner = g_strdup(sender);
-	req->id = g_dbus_add_disconnect_watch(conn, sender, cb, req, NULL);
+	req->id = g_dbus_add_disconnect_watch(btd_get_dbus_connection(),
+							sender, cb, req, NULL);
 
 	info("%s session %p with %s activated",
 		req->mode ? "Mode" : "Discovery", req, sender);
@@ -317,8 +315,8 @@ done:
 			session_ref(req);
 		} else
 			/* Wait for mode change to reply */
-			adapter->pending_mode = create_session(adapter,
-					connection, msg, new_mode, NULL);
+			adapter->pending_mode = create_session(adapter, msg,
+								new_mode, NULL);
 	} else
 		/* Nothing to reply just write the new mode */
 		adapter->mode = new_mode;
@@ -326,8 +324,8 @@ done:
 	return 0;
 }
 
-static DBusMessage *set_discoverable(DBusConnection *conn, DBusMessage *msg,
-				gboolean discoverable, void *data)
+static DBusMessage *set_discoverable(DBusMessage *msg,
+					gboolean discoverable, void *data)
 {
 	struct btd_adapter *adapter = data;
 	uint8_t mode;
@@ -347,8 +345,7 @@ static DBusMessage *set_discoverable(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
-static DBusMessage *set_powered(DBusConnection *conn, DBusMessage *msg,
-				gboolean powered, void *data)
+static DBusMessage *set_powered(DBusMessage *msg, gboolean powered, void *data)
 {
 	struct btd_adapter *adapter = data;
 	uint8_t mode;
@@ -356,8 +353,7 @@ static DBusMessage *set_powered(DBusConnection *conn, DBusMessage *msg,
 
 	if (powered) {
 		mode = get_mode(&adapter->bdaddr, "on");
-		return set_discoverable(conn, msg, mode == MODE_DISCOVERABLE,
-									data);
+		return set_discoverable(msg, mode == MODE_DISCOVERABLE, data);
 	}
 
 	mode = MODE_OFF;
@@ -374,8 +370,8 @@ static DBusMessage *set_powered(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
-static DBusMessage *set_pairable(DBusConnection *conn, DBusMessage *msg,
-				gboolean pairable, void *data)
+static DBusMessage *set_pairable(DBusMessage *msg,
+						gboolean pairable, void *data)
 {
 	struct btd_adapter *adapter = data;
 	int err;
@@ -402,7 +398,7 @@ done:
 
 static gboolean pairable_timeout_handler(void *data)
 {
-	set_pairable(NULL, NULL, FALSE, data);
+	set_pairable(NULL, FALSE, data);
 
 	return FALSE;
 }
@@ -557,7 +553,7 @@ static void session_free(void *data)
 	struct session_req *req = data;
 
 	if (req->id)
-		g_dbus_remove_watch(req->conn, req->id);
+		g_dbus_remove_watch(btd_get_dbus_connection(), req->id);
 
 	if (req->msg) {
 		dbus_message_unref(req->msg);
@@ -565,8 +561,6 @@ static void session_free(void *data)
 			agent_cancel(req->adapter->agent);
 	}
 
-	if (req->conn)
-		dbus_connection_unref(req->conn);
 	g_free(req->owner);
 	g_free(req);
 }
@@ -596,6 +590,7 @@ static void session_unref(struct session_req *req)
 
 static void confirm_mode_cb(struct agent *agent, DBusError *derr, void *data)
 {
+	DBusConnection *conn = btd_get_dbus_connection();
 	struct session_req *req = data;
 	int err;
 	DBusMessage *reply;
@@ -605,7 +600,7 @@ static void confirm_mode_cb(struct agent *agent, DBusError *derr, void *data)
 	if (derr && dbus_error_is_set(derr)) {
 		reply = dbus_message_new_error(req->msg, derr->name,
 						derr->message);
-		g_dbus_send_message(req->conn, reply);
+		g_dbus_send_message(conn, reply);
 		session_unref(req);
 		return;
 	}
@@ -624,7 +619,7 @@ static void confirm_mode_cb(struct agent *agent, DBusError *derr, void *data)
 		 * mode, or change is not needed. Otherwise, reply is sent in
 		 * set_mode_complete.
 		 */
-		g_dbus_send_message(req->conn, reply);
+		g_dbus_send_message(conn, reply);
 
 		dbus_message_unref(req->msg);
 		req->msg = NULL;
@@ -634,10 +629,8 @@ static void confirm_mode_cb(struct agent *agent, DBusError *derr, void *data)
 		session_unref(req);
 }
 
-static DBusMessage *set_discoverable_timeout(DBusConnection *conn,
-							DBusMessage *msg,
-							uint32_t timeout,
-							void *data)
+static DBusMessage *set_discoverable_timeout(DBusMessage *msg,
+						uint32_t timeout, void *data)
 {
 	struct btd_adapter *adapter = data;
 	const char *path;
@@ -661,10 +654,8 @@ static DBusMessage *set_discoverable_timeout(DBusConnection *conn,
 	return dbus_message_new_method_return(msg);
 }
 
-static DBusMessage *set_pairable_timeout(DBusConnection *conn,
-						DBusMessage *msg,
-						uint32_t timeout,
-						void *data)
+static DBusMessage *set_pairable_timeout(DBusMessage *msg,
+						uint32_t timeout, void *data)
 {
 	struct btd_adapter *adapter = data;
 	const char *path;
@@ -725,8 +716,8 @@ void adapter_name_changed(struct btd_adapter *adapter, const char *name)
 	adapter->name = g_strdup(name);
 
 	emit_property_changed(adapter->path,
-					ADAPTER_INTERFACE, "Name",
-					DBUS_TYPE_STRING, &name);
+				ADAPTER_INTERFACE, "Name",
+				DBUS_TYPE_STRING, &name);
 
 	if (main_opts.gatt_enabled)
 		attrib_gap_set(adapter, GATT_CHARAC_DEVICE_NAME,
@@ -761,8 +752,7 @@ int adapter_set_name(struct btd_adapter *adapter, const char *name)
 	return 0;
 }
 
-static DBusMessage *set_name(DBusConnection *conn, DBusMessage *msg,
-					const char *name, void *data)
+static DBusMessage *set_name(DBusMessage *msg, const char *name, void *data)
 {
 	struct btd_adapter *adapter = data;
 	int ret;
@@ -930,8 +920,7 @@ void adapter_service_remove(struct btd_adapter *adapter, void *r)
 	adapter_emit_uuids_updated(adapter);
 }
 
-static struct btd_device *adapter_create_device(DBusConnection *conn,
-						struct btd_adapter *adapter,
+static struct btd_device *adapter_create_device(struct btd_adapter *adapter,
 						const char *address,
 						uint8_t bdaddr_type)
 {
@@ -949,7 +938,7 @@ static struct btd_device *adapter_create_device(DBusConnection *conn,
 	adapter->devices = g_slist_append(adapter->devices, device);
 
 	path = device_get_path(device);
-	g_dbus_emit_signal(conn, adapter->path,
+	g_dbus_emit_signal(btd_get_dbus_connection(), adapter->path,
 			ADAPTER_INTERFACE, "DeviceCreated",
 			DBUS_TYPE_OBJECT_PATH, &path,
 			DBUS_TYPE_INVALID);
@@ -959,7 +948,7 @@ static struct btd_device *adapter_create_device(DBusConnection *conn,
 	return device;
 }
 
-void adapter_remove_device(DBusConnection *conn, struct btd_adapter *adapter,
+void adapter_remove_device(struct btd_adapter *adapter,
 						struct btd_device *device,
 						gboolean remove_storage)
 {
@@ -971,7 +960,7 @@ void adapter_remove_device(DBusConnection *conn, struct btd_adapter *adapter,
 
 	adapter_update_devices(adapter);
 
-	g_dbus_emit_signal(conn, adapter->path,
+	g_dbus_emit_signal(btd_get_dbus_connection(), adapter->path,
 			ADAPTER_INTERFACE, "DeviceRemoved",
 			DBUS_TYPE_OBJECT_PATH, &dev_path,
 			DBUS_TYPE_INVALID);
@@ -984,9 +973,8 @@ void adapter_remove_device(DBusConnection *conn, struct btd_adapter *adapter,
 	device_remove(device, remove_storage);
 }
 
-struct btd_device *adapter_get_device(DBusConnection *conn,
-						struct btd_adapter *adapter,
-						const gchar *address)
+struct btd_device *adapter_get_device(struct btd_adapter *adapter,
+							const gchar *address)
 {
 	struct btd_device *device;
 
@@ -999,8 +987,7 @@ struct btd_device *adapter_get_device(DBusConnection *conn,
 	if (device)
 		return device;
 
-	return adapter_create_device(conn, adapter, address,
-						BDADDR_BREDR);
+	return adapter_create_device(adapter, address, BDADDR_BREDR);
 }
 
 static gboolean discovery_cb(gpointer user_data)
@@ -1047,8 +1034,7 @@ static DBusMessage *adapter_start_discovery(DBusConnection *conn,
 		return btd_error_failed(msg, strerror(-err));
 
 done:
-	req = create_session(adapter, conn, msg, 0,
-				session_owner_exit);
+	req = create_session(adapter, msg, 0, session_owner_exit);
 
 	adapter->disc_sessions = g_slist_append(adapter->disc_sessions, req);
 
@@ -1201,7 +1187,7 @@ static DBusMessage *set_property(DBusConnection *conn,
 			return btd_error_invalid_args(msg);
 		dbus_message_iter_get_basic(&sub, &name);
 
-		return set_name(conn, msg, name, data);
+		return set_name(msg, name, data);
 	} else if (g_str_equal("Powered", property)) {
 		gboolean powered;
 
@@ -1210,7 +1196,7 @@ static DBusMessage *set_property(DBusConnection *conn,
 
 		dbus_message_iter_get_basic(&sub, &powered);
 
-		return set_powered(conn, msg, powered, data);
+		return set_powered(msg, powered, data);
 	} else if (g_str_equal("Discoverable", property)) {
 		gboolean discoverable;
 
@@ -1219,7 +1205,7 @@ static DBusMessage *set_property(DBusConnection *conn,
 
 		dbus_message_iter_get_basic(&sub, &discoverable);
 
-		return set_discoverable(conn, msg, discoverable, data);
+		return set_discoverable(msg, discoverable, data);
 	} else if (g_str_equal("DiscoverableTimeout", property)) {
 		uint32_t timeout;
 
@@ -1228,7 +1214,7 @@ static DBusMessage *set_property(DBusConnection *conn,
 
 		dbus_message_iter_get_basic(&sub, &timeout);
 
-		return set_discoverable_timeout(conn, msg, timeout, data);
+		return set_discoverable_timeout(msg, timeout, data);
 	} else if (g_str_equal("Pairable", property)) {
 		gboolean pairable;
 
@@ -1237,7 +1223,7 @@ static DBusMessage *set_property(DBusConnection *conn,
 
 		dbus_message_iter_get_basic(&sub, &pairable);
 
-		return set_pairable(conn, msg, pairable, data);
+		return set_pairable(msg, pairable, data);
 	} else if (g_str_equal("PairableTimeout", property)) {
 		uint32_t timeout;
 
@@ -1246,7 +1232,7 @@ static DBusMessage *set_property(DBusConnection *conn,
 
 		dbus_message_iter_get_basic(&sub, &timeout);
 
-		return set_pairable_timeout(conn, msg, timeout, data);
+		return set_pairable_timeout(msg, timeout, data);
 	}
 
 	return btd_error_invalid_args(msg);
@@ -1274,8 +1260,8 @@ static DBusMessage *request_session(DBusConnection *conn,
 		session_ref(req);
 		return dbus_message_new_method_return(msg);
 	} else {
-		req = create_session(adapter, conn, msg, new_mode,
-					session_owner_exit);
+		req = create_session(adapter, msg, new_mode,
+							session_owner_exit);
 		adapter->mode_sessions = g_slist_append(adapter->mode_sessions,
 							req);
 	}
@@ -1338,13 +1324,12 @@ static DBusMessage *cancel_device_creation(DBusConnection *conn,
 		return NULL;
 	}
 
-	adapter_remove_device(conn, adapter, device, TRUE);
+	adapter_remove_device(adapter, device, TRUE);
 
 	return dbus_message_new_method_return(msg);
 }
 
-static struct btd_device *create_device_internal(DBusConnection *conn,
-						struct btd_adapter *adapter,
+static struct btd_device *create_device_internal(struct btd_adapter *adapter,
 						const char *address, int *err)
 {
 	struct remote_dev_info *dev;
@@ -1360,7 +1345,7 @@ static struct btd_device *create_device_internal(DBusConnection *conn,
 	else
 		bdaddr_type = BDADDR_BREDR;
 
-	device = adapter_create_device(conn, adapter, address, bdaddr_type);
+	device = adapter_create_device(adapter, address, bdaddr_type);
 	if (!device && err)
 		*err = -ENOMEM;
 
@@ -1391,7 +1376,7 @@ static DBusMessage *create_device(DBusConnection *conn,
 
 	DBG("%s", address);
 
-	device = create_device_internal(conn, adapter, address, &err);
+	device = create_device_internal(adapter, address, &err);
 	if (!device)
 		goto failed;
 
@@ -1401,7 +1386,7 @@ static DBusMessage *create_device(DBusConnection *conn,
 		err = device_browse_primary(device, msg, FALSE);
 
 	if (err < 0) {
-		adapter_remove_device(conn, adapter, device, TRUE);
+		adapter_remove_device(adapter, device, TRUE);
 		return btd_error_failed(msg, strerror(-err));
 	}
 
@@ -1474,7 +1459,7 @@ static DBusMessage *create_paired_device(DBusConnection *conn,
 
 	device = adapter_find_device(adapter, address);
 	if (!device) {
-		device = create_device_internal(conn, adapter, address, &err);
+		device = create_device_internal(adapter, address, &err);
 		if (!device)
 			return btd_error_failed(msg, strerror(-err));
 	}
@@ -1516,7 +1501,7 @@ static DBusMessage *remove_device(DBusConnection *conn, DBusMessage *msg,
 	device_set_temporary(device, TRUE);
 
 	if (!device_is_connected(device)) {
-		adapter_remove_device(conn, adapter, device, TRUE);
+		adapter_remove_device(adapter, device, TRUE);
 		return dbus_message_new_method_return(msg);
 	}
 
@@ -2086,7 +2071,7 @@ static void load_connections(struct btd_adapter *adapter)
 		ba2str(bdaddr, address);
 		DBG("Adding existing connection to %s", address);
 
-		device = adapter_get_device(connection, adapter, address);
+		device = adapter_get_device(adapter, address);
 		if (device)
 			adapter_add_connection(adapter, device);
 	}
@@ -2135,7 +2120,7 @@ static void emit_device_disappeared(gpointer data, gpointer user_data)
 
 	ba2str(&dev->bdaddr, address);
 
-	g_dbus_emit_signal(connection, adapter->path,
+	g_dbus_emit_signal(btd_get_dbus_connection(), adapter->path,
 			ADAPTER_INTERFACE, "DeviceDisappeared",
 			DBUS_TYPE_STRING, &paddr,
 			DBUS_TYPE_INVALID);
@@ -2332,7 +2317,7 @@ static void set_mode_complete(struct btd_adapter *adapter)
 			reply = g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 		}
 
-		g_dbus_send_message(connection, reply);
+		g_dbus_send_message(btd_get_dbus_connection(), reply);
 	}
 
 	if (err != 0)
@@ -2449,7 +2434,8 @@ void btd_adapter_unref(struct btd_adapter *adapter)
 
 	path = g_strdup(adapter->path);
 
-	g_dbus_unregister_interface(connection, path, ADAPTER_INTERFACE);
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
+						path, ADAPTER_INTERFACE);
 
 	g_free(path);
 }
@@ -2491,15 +2477,12 @@ gboolean adapter_init(struct btd_adapter *adapter, gboolean up)
 	return TRUE;
 }
 
-struct btd_adapter *adapter_create(DBusConnection *conn, int id)
+struct btd_adapter *adapter_create(int id)
 {
 	char path[MAX_PATH_LENGTH];
 	struct btd_adapter *adapter;
 	const char *base_path = manager_get_base_path();
 
-	if (!connection)
-		connection = conn;
-
 	adapter = g_try_new0(struct btd_adapter, 1);
 	if (!adapter) {
 		error("adapter_create: failed to alloc memory for hci%d", id);
@@ -2511,7 +2494,8 @@ struct btd_adapter *adapter_create(DBusConnection *conn, int id)
 	snprintf(path, sizeof(path), "%s/hci%d", base_path, id);
 	adapter->path = g_strdup(path);
 
-	if (!g_dbus_register_interface(conn, path, ADAPTER_INTERFACE,
+	if (!g_dbus_register_interface(btd_get_dbus_connection(),
+					path, ADAPTER_INTERFACE,
 					adapter_methods, adapter_signals, NULL,
 					adapter, adapter_free)) {
 		error("Adapter interface init failed on path %s", path);
@@ -2702,7 +2686,7 @@ static void emit_device_found(const char *path, const char *address,
 	append_dict_valist(&iter, first_key, var_args);
 	va_end(var_args);
 
-	g_dbus_send_message(connection, signal);
+	g_dbus_send_message(btd_get_dbus_connection(), signal);
 }
 
 static char **strlist2array(GSList *list)
@@ -3109,7 +3093,7 @@ void adapter_remove_connection(struct btd_adapter *adapter,
 		const char *path = device_get_path(device);
 
 		DBG("Removing temporary device %s", path);
-		adapter_remove_device(connection, adapter, device, TRUE);
+		adapter_remove_device(adapter, device, TRUE);
 	}
 }
 
@@ -3552,7 +3536,7 @@ void adapter_bonding_complete(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 
 	ba2str(bdaddr, addr);
 	if (status == 0)
-		device = adapter_get_device(connection, adapter, addr);
+		device = adapter_get_device(adapter, addr);
 	else
 		device = adapter_find_device(adapter, addr);
 
diff --git a/src/adapter.h b/src/adapter.h
index cd37b15..eece6f5 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -87,16 +87,16 @@ void btd_adapter_get_mode(struct btd_adapter *adapter, uint8_t *mode,
 void btd_adapter_get_class(struct btd_adapter *adapter, uint8_t *major,
 							uint8_t *minor);
 const char *btd_adapter_get_name(struct btd_adapter *adapter);
-struct btd_device *adapter_get_device(DBusConnection *conn,
-				struct btd_adapter *adapter, const char *address);
+struct btd_device *adapter_get_device(struct btd_adapter *adapter,
+							const char *address);
 
 struct btd_device *adapter_find_device(struct btd_adapter *adapter, const char *dest);
 
-void adapter_remove_device(DBusConnection *conn, struct btd_adapter *adapter,
+void adapter_remove_device(struct btd_adapter *adapter,
 						struct btd_device *device,
 						gboolean remove_storage);
 
-struct btd_adapter *adapter_create(DBusConnection *conn, int id);
+struct btd_adapter *adapter_create(int id);
 gboolean adapter_init(struct btd_adapter *adapter, gboolean up);
 void adapter_remove(struct btd_adapter *adapter);
 void adapter_set_allow_name_changes(struct btd_adapter *adapter,
diff --git a/src/event.c b/src/event.c
index f1f5aaf..1db73be 100644
--- a/src/event.c
+++ b/src/event.c
@@ -56,7 +56,6 @@ static gboolean get_adapter_and_device(bdaddr_t *src, bdaddr_t *dst,
 					struct btd_device **device,
 					gboolean create)
 {
-	DBusConnection *conn = btd_get_dbus_connection();
 	char peer_addr[18];
 
 	*adapter = manager_find_adapter(src);
@@ -68,7 +67,7 @@ static gboolean get_adapter_and_device(bdaddr_t *src, bdaddr_t *dst,
 	ba2str(dst, peer_addr);
 
 	if (create)
-		*device = adapter_get_device(conn, *adapter, peer_addr);
+		*device = adapter_get_device(*adapter, peer_addr);
 	else
 		*device = adapter_find_device(*adapter, peer_addr);
 
@@ -483,7 +482,6 @@ void btd_event_conn_failed(bdaddr_t *local, bdaddr_t *peer, uint8_t status)
 {
 	struct btd_adapter *adapter;
 	struct btd_device *device;
-	DBusConnection *conn = btd_get_dbus_connection();
 
 	DBG("status 0x%02x", status);
 
@@ -497,7 +495,7 @@ void btd_event_conn_failed(bdaddr_t *local, bdaddr_t *peer, uint8_t status)
 		device_cancel_bonding(device, status);
 
 	if (device_is_temporary(device))
-		adapter_remove_device(conn, adapter, device, TRUE);
+		adapter_remove_device(adapter, device, TRUE);
 }
 
 void btd_event_disconn_complete(bdaddr_t *local, bdaddr_t *peer)
@@ -544,7 +542,6 @@ void btd_event_device_unpaired(bdaddr_t *local, bdaddr_t *peer)
 {
 	struct btd_adapter *adapter;
 	struct btd_device *device;
-	DBusConnection *conn = btd_get_dbus_connection();
 
 	if (!get_adapter_and_device(local, peer, &adapter, &device, FALSE))
 		return;
@@ -554,7 +551,7 @@ void btd_event_device_unpaired(bdaddr_t *local, bdaddr_t *peer)
 	if (device_is_connected(device))
 		device_request_disconnect(device, NULL);
 	else
-		adapter_remove_device(conn, adapter, device, TRUE);
+		adapter_remove_device(adapter, device, TRUE);
 }
 
 /* Section reserved to device HCI callbacks */
diff --git a/src/manager.c b/src/manager.c
index fe8706b..15a2571 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -352,7 +352,7 @@ struct btd_adapter *btd_manager_register_adapter(int id, gboolean up)
 		return NULL;
 	}
 
-	adapter = adapter_create(btd_get_dbus_connection(), id);
+	adapter = adapter_create(id);
 	if (!adapter)
 		return NULL;
 
-- 
1.7.11.3

