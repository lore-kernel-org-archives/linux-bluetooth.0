Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/6] Make use of g_slist_free_full when elements are dynamically-allocated
Date: Wed, 29 Jun 2011 11:52:48 +0300
Message-Id: <1309337573-8295-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This avoid having to iterate twice in the list to free its elements.
---
 acinclude.m4        |    4 ++--
 src/adapter.c       |   33 ++++++++++++++-------------------
 src/attrib-server.c |   18 ++++++------------
 src/device.c        |   14 ++++----------
 src/eir.c           |    3 +--
 src/manager.c       |    3 +--
 src/storage.c       |    6 ++----
 7 files changed, 30 insertions(+), 51 deletions(-)

diff --git a/acinclude.m4 b/acinclude.m4
index 10e648d..a37959a 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -106,8 +106,8 @@ AC_DEFUN([AC_PATH_DBUS], [
 ])
 
 AC_DEFUN([AC_PATH_GLIB], [
-	PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.16, dummy=yes,
-				AC_MSG_ERROR(GLib library version 2.16 or later is required))
+	PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.28, dummy=yes,
+				AC_MSG_ERROR(GLib library version 2.28 or later is required))
 	AC_SUBST(GLIB_CFLAGS)
 	AC_SUBST(GLIB_LIBS)
 ])
diff --git a/src/adapter.c b/src/adapter.c
index 99d3eee..0909a22 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -173,12 +173,13 @@ static int found_device_cmp(const struct remote_dev_info *d1,
 	return 0;
 }
 
-static void dev_info_free(struct remote_dev_info *dev)
+static void dev_info_free(void *data)
 {
+	struct remote_dev_info *dev = data;
+
 	g_free(dev->name);
 	g_free(dev->alias);
-	g_slist_foreach(dev->services, (GFunc) g_free, NULL);
-	g_slist_free(dev->services);
+	g_slist_free_full(dev->services, g_free);
 	g_strfreev(dev->uuids);
 	g_free(dev);
 }
@@ -698,8 +699,10 @@ static void session_remove(struct session_req *req)
 	}
 }
 
-static void session_free(struct session_req *req)
+static void session_free(void *data)
 {
+	struct session_req *req = data;
+
 	if (req->id)
 		g_dbus_remove_watch(req->conn, req->id);
 
@@ -1181,8 +1184,7 @@ static DBusMessage *adapter_start_discovery(DBusConnection *conn,
 	if (adapter->disc_sessions)
 		goto done;
 
-	g_slist_foreach(adapter->found_devices, (GFunc) dev_info_free, NULL);
-	g_slist_free(adapter->found_devices);
+	g_slist_free_full(adapter->found_devices, dev_info_free);
 	adapter->found_devices = NULL;
 
 	g_slist_free(adapter->oor_devices);
@@ -1879,8 +1881,7 @@ static void create_stored_device_from_profiles(char *key, char *value,
 	if (list)
 		device_register_services(connection, device, list, ATT_PSM);
 
-	g_slist_foreach(uuids, (GFunc) g_free, NULL);
-	g_slist_free(uuids);
+	g_slist_free_full(uuids, g_free);
 }
 
 struct adapter_keys {
@@ -2081,8 +2082,7 @@ static void load_devices(struct btd_adapter *adapter)
 	if (err < 0) {
 		error("Unable to load keys to adapter_ops: %s (%d)",
 							strerror(-err), -err);
-		g_slist_foreach(keys.keys, (GFunc) g_free, NULL);
-		g_slist_free(keys.keys);
+		g_slist_free_full(keys.keys, g_free);
 	}
 
 	create_name(filename, PATH_MAX, STORAGEDIR, srcaddr, "blocked");
@@ -2166,8 +2166,7 @@ static void load_connections(struct btd_adapter *adapter)
 			adapter_add_connection(adapter, device);
 	}
 
-	g_slist_foreach(conns, (GFunc) g_free, NULL);
-	g_slist_free(conns);
+	g_slist_free_full(conns, g_free);
 }
 
 static int get_discoverable_timeout(const char *src)
@@ -2222,8 +2221,7 @@ static void emit_device_disappeared(gpointer data, gpointer user_data)
 static void update_oor_devices(struct btd_adapter *adapter)
 {
 	g_slist_foreach(adapter->oor_devices, emit_device_disappeared, adapter);
-	g_slist_foreach(adapter->oor_devices, (GFunc) dev_info_free, NULL);
-	g_slist_free(adapter->oor_devices);
+	g_slist_free_full(adapter->oor_devices, dev_info_free);
 	adapter->oor_devices =  g_slist_copy(adapter->found_devices);
 }
 
@@ -2400,9 +2398,7 @@ int btd_adapter_stop(struct btd_adapter *adapter)
 	stop_discovery(adapter);
 
 	if (adapter->disc_sessions) {
-		g_slist_foreach(adapter->disc_sessions, (GFunc) session_free,
-				NULL);
-		g_slist_free(adapter->disc_sessions);
+		g_slist_free_full(adapter->disc_sessions, session_free);
 		adapter->disc_sessions = NULL;
 	}
 
@@ -2467,8 +2463,7 @@ static void adapter_free(gpointer user_data)
 
 	sdp_list_free(adapter->services, NULL);
 
-	g_slist_foreach(adapter->found_devices, (GFunc) dev_info_free, NULL);
-	g_slist_free(adapter->found_devices);
+	g_slist_free_full(adapter->found_devices, dev_info_free);
 
 	g_slist_free(adapter->oor_devices);
 
diff --git a/src/attrib-server.c b/src/attrib-server.c
index c55167f..c02d575 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -351,8 +351,7 @@ static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
 			status = a->read_cb(a, a->cb_user_data);
 
 		if (status) {
-			g_slist_foreach(groups, (GFunc) g_free, NULL);
-			g_slist_free(groups);
+			g_slist_free_full(groups, g_free);
 			return enc_error_resp(ATT_OP_READ_BY_GROUP_REQ,
 						a->handle, status, pdu, len);
 		}
@@ -399,8 +398,7 @@ static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
 	length = enc_read_by_grp_resp(adl, pdu, len);
 
 	att_data_list_free(adl);
-	g_slist_foreach(groups, (GFunc) g_free, NULL);
-	g_slist_free(groups);
+	g_slist_free_full(groups, g_free);
 
 	return length;
 }
@@ -614,8 +612,7 @@ static int find_by_type(uint16_t start, uint16_t end, bt_uuid_t *uuid,
 
 	len = enc_find_by_type_resp(matches, opdu, mtu);
 
-	g_slist_foreach(matches, (GFunc) g_free, NULL);
-	g_slist_free(matches);
+	g_slist_free_full(matches, g_free);
 
 	return len;
 }
@@ -786,8 +783,7 @@ static void channel_disconnect(void *user_data)
 
 	g_slist_free(channel->notify);
 	g_slist_free(channel->indicate);
-	g_slist_foreach(channel->configs, (GFunc) g_free, NULL);
-	g_slist_free(channel->configs);
+	g_slist_free_full(channel->configs, g_free);
 
 	g_free(channel);
 }
@@ -1132,8 +1128,7 @@ void attrib_server_exit(void)
 {
 	GSList *l;
 
-	g_slist_foreach(database, (GFunc) g_free, NULL);
-	g_slist_free(database);
+	g_slist_free_full(database, g_free);
 
 	if (l2cap_io) {
 		g_io_channel_unref(l2cap_io);
@@ -1150,8 +1145,7 @@ void attrib_server_exit(void)
 
 		g_slist_free(channel->notify);
 		g_slist_free(channel->indicate);
-		g_slist_foreach(channel->configs, (GFunc) g_free, NULL);
-		g_slist_free(channel->configs);
+		g_slist_free_full(channel->configs, g_free);
 
 		g_attrib_unref(channel->attrib);
 		g_free(channel);
diff --git a/src/device.c b/src/device.c
index ae6a0d5..82759a4 100644
--- a/src/device.c
+++ b/src/device.c
@@ -156,8 +156,7 @@ static void browse_request_free(struct browse_req *req)
 		dbus_connection_unref(req->conn);
 	if (req->device)
 		btd_device_unref(req->device);
-	g_slist_foreach(req->profiles_added, (GFunc) g_free, NULL);
-	g_slist_free(req->profiles_added);
+	g_slist_free_full(req->profiles_added, g_free);
 	g_slist_free(req->profiles_removed);
 	if (req->records)
 		sdp_list_free(req->records, (sdp_free_func_t) sdp_record_free);
@@ -198,14 +197,9 @@ static void device_free(gpointer user_data)
 				agent_is_busy(agent, device->authr)))
 		agent_cancel(agent);
 
-	g_slist_foreach(device->services, (GFunc) g_free, NULL);
-	g_slist_free(device->services);
-
-	g_slist_foreach(device->uuids, (GFunc) g_free, NULL);
-	g_slist_free(device->uuids);
-
-	g_slist_foreach(device->primaries, (GFunc) g_free, NULL);
-	g_slist_free(device->primaries);
+	g_slist_free_full(device->services, g_free);
+	g_slist_free_full(device->uuids, g_free);
+	g_slist_free_full(device->primaries, g_free);
 
 	if (device->tmp_records)
 		sdp_list_free(device->tmp_records,
diff --git a/src/eir.c b/src/eir.c
index 01b6ac5..ac23064 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -47,8 +47,7 @@
 
 void eir_data_free(struct eir_data *eir)
 {
-	g_slist_foreach(eir->services, (GFunc) g_free, NULL);
-	g_slist_free(eir->services);
+	g_slist_free_full(eir->services, g_free);
 	g_free(eir->name);
 }
 
diff --git a/src/manager.c b/src/manager.c
index 254ace4..dd8cb50 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -295,8 +295,7 @@ static void manager_remove_adapter(struct btd_adapter *adapter)
 
 void manager_cleanup(DBusConnection *conn, const char *path)
 {
-	g_slist_foreach(adapters, (GFunc) manager_remove_adapter, NULL);
-	g_slist_free(adapters);
+	g_slist_free_full(adapters, (GDestroyNotify) manager_remove_adapter);
 
 	g_dbus_unregister_interface(conn, "/", MANAGER_INTERFACE);
 }
diff --git a/src/storage.c b/src/storage.c
index d416d75..73bbc36 100644
--- a/src/storage.c
+++ b/src/storage.c
@@ -1211,8 +1211,7 @@ int delete_device_service(const bdaddr_t *sba, const bdaddr_t *dba)
 		textfile_del(filename, key);
 	}
 
-	g_slist_foreach(match.keys, (GFunc) g_free, NULL);
-	g_slist_free(match.keys);
+	g_slist_free_full(match.keys, g_free);
 
 	/* Deleting all attributes values of a given address */
 	memset(&match, 0, sizeof(match));
@@ -1228,8 +1227,7 @@ int delete_device_service(const bdaddr_t *sba, const bdaddr_t *dba)
 		textfile_del(filename, key);
 	}
 
-	g_slist_foreach(match.keys, (GFunc) g_free, NULL);
-	g_slist_free(match.keys);
+	g_slist_free_full(match.keys, g_free);
 
 	return 0;
 }
-- 
1.7.5.4

