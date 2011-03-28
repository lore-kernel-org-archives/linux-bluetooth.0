Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH v2 4/6] Remove _init and _exit methods from Attrib client
Date: Mon, 28 Mar 2011 19:40:49 -0300
Message-Id: <1301352051-12046-5-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1301352051-12046-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1301352051-12046-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now that Attrib client is being moved to the core, there's no
need to have explicit _init and _exit methods.

This also means that we need to pass the DBusConnection explicitly
to the registration method.
---
 attrib/client.c |   44 ++++++++++++++------------------------------
 attrib/client.h |    5 ++---
 src/adapter.c   |    2 +-
 src/device.c    |    2 +-
 4 files changed, 18 insertions(+), 35 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 590f33b..acd35f9 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -52,6 +52,7 @@
 
 struct gatt_service {
 	struct btd_device *dev;
+	DBusConnection *conn;
 	bdaddr_t sba;
 	bdaddr_t dba;
 	char *path;
@@ -108,8 +109,6 @@ struct watcher {
 
 static GSList *gatt_services = NULL;
 
-static DBusConnection *connection;
-
 static void characteristic_free(void *user_data)
 {
 	struct characteristic *chr = user_data;
@@ -138,7 +137,7 @@ static void primary_free(void *user_data)
 
 	for (l = prim->watchers; l; l = l->next) {
 		struct watcher *watcher = l->data;
-		g_dbus_remove_watch(connection, watcher->id);
+		g_dbus_remove_watch(prim->gatt->conn, watcher->id);
 	}
 
 	g_slist_foreach(prim->chars, (GFunc) characteristic_free, NULL);
@@ -156,6 +155,7 @@ static void gatt_service_free(void *user_data)
 	g_attrib_unref(gatt->attrib);
 	g_free(gatt->path);
 	btd_device_unref(gatt->dev);
+	dbus_connection_unref(gatt->conn);
 	g_free(gatt);
 }
 
@@ -249,6 +249,7 @@ static void update_watchers(gpointer data, gpointer user_data)
 {
 	struct watcher *w = data;
 	struct characteristic *chr = user_data;
+	DBusConnection *conn = w->prim->gatt->conn;
 	DBusMessage *msg;
 
 	msg = dbus_message_new_method_call(w->name, w->path,
@@ -261,7 +262,7 @@ static void update_watchers(gpointer data, gpointer user_data)
 			&chr->value, chr->vlen, DBUS_TYPE_INVALID);
 
 	dbus_message_set_no_reply(msg, TRUE);
-	g_dbus_send_message(connection, msg);
+	g_dbus_send_message(conn, msg);
 }
 
 static void events_handler(const uint8_t *pdu, uint16_t len,
@@ -337,7 +338,7 @@ static void connect_cb(GIOChannel *chan, GError *gerr, gpointer user_data)
 		if (gatt->msg) {
 			DBusMessage *reply = btd_error_failed(gatt->msg,
 							gerr->message);
-			g_dbus_send_message(connection, reply);
+			g_dbus_send_message(gatt->conn, reply);
 		}
 
 		error("%s", gerr->message);
@@ -592,7 +593,7 @@ static void register_characteristics(struct primary *prim)
 
 	for (lc = prim->chars; lc; lc = lc->next) {
 		struct characteristic *chr = lc->data;
-		g_dbus_register_interface(connection, chr->path,
+		g_dbus_register_interface(prim->gatt->conn, chr->path,
 				CHAR_INTERFACE, char_methods,
 				NULL, NULL, chr, NULL);
 		DBG("Registered: %s", chr->path);
@@ -936,7 +937,7 @@ static void char_discovered_cb(GSList *characteristics, guint8 status,
 	g_slist_foreach(prim->chars, update_all_chars, prim);
 
 fail:
-	g_dbus_send_message(connection, reply);
+	g_dbus_send_message(gatt->conn, reply);
 	g_attrib_unref(gatt->attrib);
 	g_free(current);
 }
@@ -1033,7 +1034,7 @@ static void register_primaries(struct gatt_service *gatt, GSList *primaries)
 		prim->path = g_strdup_printf("%s/service%04x", gatt->path,
 								att->start);
 
-		g_dbus_register_interface(connection, prim->path,
+		g_dbus_register_interface(gatt->conn, prim->path,
 				CHAR_INTERFACE, prim_methods,
 				NULL, NULL, prim, NULL);
 		DBG("Registered: %s", prim->path);
@@ -1044,7 +1045,8 @@ static void register_primaries(struct gatt_service *gatt, GSList *primaries)
 	}
 }
 
-int attrib_client_register(struct btd_device *device, int psm, GSList *primaries)
+int attrib_client_register(DBusConnection *connection,
+		struct btd_device *device, int psm, GSList *primaries)
 {
 	struct btd_adapter *adapter = device_get_adapter(device);
 	const char *path = device_get_path(device);
@@ -1056,6 +1058,7 @@ int attrib_client_register(struct btd_device *device, int psm, GSList *primaries
 
 	gatt = g_new0(struct gatt_service, 1);
 	gatt->dev = btd_device_ref(device);
+	gatt->conn = dbus_connection_ref(connection);
 	gatt->listen = FALSE;
 	gatt->path = g_strdup(path);
 	bacpy(&gatt->sba, &sba);
@@ -1085,31 +1088,12 @@ void attrib_client_unregister(struct btd_device *device)
 		struct primary *prim = lp->data;
 		for (lc = prim->chars; lc; lc = lc->next) {
 			struct characteristic *chr = lc->data;
-			g_dbus_unregister_interface(connection, chr->path,
+			g_dbus_unregister_interface(gatt->conn, chr->path,
 								CHAR_INTERFACE);
 		}
-		g_dbus_unregister_interface(connection, prim->path,
+		g_dbus_unregister_interface(gatt->conn, prim->path,
 								CHAR_INTERFACE);
 	}
 
 	gatt_service_free(gatt);
 }
-
-int attrib_client_init(DBusConnection *conn)
-{
-
-	connection = dbus_connection_ref(conn);
-
-	/*
-	 * FIXME: if the adapter supports BLE start scanning. Temporary
-	 * solution, this approach doesn't allow to control scanning based
-	 * on the discoverable property.
-	 */
-
-	return 0;
-}
-
-void attrib_client_exit(void)
-{
-	dbus_connection_unref(connection);
-}
diff --git a/attrib/client.h b/attrib/client.h
index 2bee84c..650b0c1 100644
--- a/attrib/client.h
+++ b/attrib/client.h
@@ -22,7 +22,6 @@
  *
  */
 
-int attrib_client_init(DBusConnection *conn);
-void attrib_client_exit(void);
-int attrib_client_register(struct btd_device *device, int psm, GSList *primaries);
+int attrib_client_register(DBusConnection *connection,
+		struct btd_device *device, int psm, GSList *primaries);
 void attrib_client_unregister(struct btd_device *device);
diff --git a/src/adapter.c b/src/adapter.c
index dad427f..da13f69 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2182,7 +2182,7 @@ static void create_stored_device_from_primary(char *key, char *value,
 	}
 
 	/* FIXME: Need the correct psm */
-	attrib_client_register(device, -1, services);
+	attrib_client_register(connection, device, -1, services);
 
 	device_probe_drivers(device, uuids);
 
diff --git a/src/device.c b/src/device.c
index 1d7094b..511c9d0 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1548,7 +1548,7 @@ static void primary_cb(GSList *services, guint8 status, gpointer user_data)
 	device_probe_drivers(device, uuids);
 
 	/* FIXME: Need the correct psm */
-	attrib_client_register(device, -1, services);
+	attrib_client_register(req->conn, device, -1, services);
 
 	g_slist_free(uuids);
 
-- 
1.7.4.1

