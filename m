Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 01/17] Rename get_dbus_connection to btd_get_dbus_connection
Date: Wed, 19 Sep 2012 12:22:03 +0200
Message-ID: <1348050139-27883-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1348050139-27883-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348050139-27883-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

get_dbus_connection is exported function which can be used by plugins thus
should be prefixed with "btd_"
---
 plugins/dbusoob.c             |  2 +-
 profiles/proximity/immalert.c |  2 +-
 profiles/proximity/linkloss.c |  2 +-
 profiles/proximity/monitor.c  | 15 +++++++++------
 profiles/proximity/reporter.c |  4 ++--
 src/dbus-common.c             |  2 +-
 src/dbus-common.h             |  2 +-
 src/device.c                  | 28 ++++++++++++++--------------
 src/event.c                   | 10 +++++-----
 src/main.c                    |  2 +-
 10 files changed, 36 insertions(+), 33 deletions(-)

diff --git a/plugins/dbusoob.c b/plugins/dbusoob.c
index a7259ba..11b2594 100644
--- a/plugins/dbusoob.c
+++ b/plugins/dbusoob.c
@@ -358,7 +358,7 @@ static int dbusoob_init(void)
 {
 	DBG("Setup dbusoob plugin");
 
-	connection = get_dbus_connection();
+	connection = btd_get_dbus_connection();
 
 	oob_register_cb(read_local_data_complete);
 
diff --git a/profiles/proximity/immalert.c b/profiles/proximity/immalert.c
index d0480e4..ebd788a 100644
--- a/profiles/proximity/immalert.c
+++ b/profiles/proximity/immalert.c
@@ -136,7 +136,7 @@ static void imm_alert_emit_alert_signal(struct connected_device *condev,
 
 	DBG("alert %s remote %s", alert_level_str, path);
 
-	emit_property_changed(get_dbus_connection(), path,
+	emit_property_changed(btd_get_dbus_connection(), path,
 			PROXIMITY_REPORTER_INTERFACE, "ImmediateAlertLevel",
 			DBUS_TYPE_STRING, &alert_level_str);
 }
diff --git a/profiles/proximity/linkloss.c b/profiles/proximity/linkloss.c
index 82df3a1..37d1f86 100644
--- a/profiles/proximity/linkloss.c
+++ b/profiles/proximity/linkloss.c
@@ -137,7 +137,7 @@ static void link_loss_emit_alert_signal(struct connected_device *condev)
 
 	DBG("alert %s remote %s", alert_level_str, path);
 
-	emit_property_changed(get_dbus_connection(), path,
+	emit_property_changed(btd_get_dbus_connection(), path,
 			PROXIMITY_REPORTER_INTERFACE, "LinkLossAlertLevel",
 			DBUS_TYPE_STRING, &alert_level_str);
 }
diff --git a/profiles/proximity/monitor.c b/profiles/proximity/monitor.c
index f7100f9..a9de85b 100644
--- a/profiles/proximity/monitor.c
+++ b/profiles/proximity/monitor.c
@@ -160,7 +160,7 @@ static void linkloss_written(guint8 status, const guint8 *pdu, guint16 plen,
 
 	DBG("Link Loss Alert Level written");
 
-	emit_property_changed(get_dbus_connection(), path,
+	emit_property_changed(btd_get_dbus_connection(), path,
 				PROXIMITY_INTERFACE, "LinkLossAlertLevel",
 				DBUS_TYPE_STRING, &monitor->linklosslevel);
 }
@@ -289,7 +289,8 @@ static gboolean immediate_timeout(gpointer user_data)
 
 	g_free(monitor->immediatelevel);
 	monitor->immediatelevel = g_strdup("none");
-	emit_property_changed(get_dbus_connection(), path, PROXIMITY_INTERFACE,
+	emit_property_changed(btd_get_dbus_connection(),
+					path, PROXIMITY_INTERFACE,
 					"ImmediateAlertLevel", DBUS_TYPE_STRING,
 					&monitor->immediatelevel);
 
@@ -304,7 +305,8 @@ static void immediate_written(gpointer user_data)
 	g_free(monitor->fallbacklevel);
 	monitor->fallbacklevel = NULL;
 
-	emit_property_changed(get_dbus_connection(), path, PROXIMITY_INTERFACE,
+	emit_property_changed(btd_get_dbus_connection(),
+				path, PROXIMITY_INTERFACE,
 				"ImmediateAlertLevel",
 				DBUS_TYPE_STRING, &monitor->immediatelevel);
 
@@ -390,7 +392,8 @@ static void attio_disconnected_cb(gpointer user_data)
 
 	g_free(monitor->immediatelevel);
 	monitor->immediatelevel = g_strdup("none");
-	emit_property_changed(get_dbus_connection(), path, PROXIMITY_INTERFACE,
+	emit_property_changed(btd_get_dbus_connection(),
+					path, PROXIMITY_INTERFACE,
 					"ImmediateAlertLevel", DBUS_TYPE_STRING,
 					&monitor->immediatelevel);
 }
@@ -607,7 +610,7 @@ int monitor_register(struct btd_device *device,
 	monitor->signallevel = g_strdup("unknown");
 	monitor->immediatelevel = g_strdup("none");
 
-	if (g_dbus_register_interface(get_dbus_connection(), path,
+	if (g_dbus_register_interface(btd_get_dbus_connection(), path,
 				PROXIMITY_INTERFACE,
 				monitor_methods, monitor_signals,
 				NULL, monitor, monitor_destroy) == FALSE) {
@@ -663,6 +666,6 @@ void monitor_unregister(struct btd_device *device)
 {
 	const char *path = device_get_path(device);
 
-	g_dbus_unregister_interface(get_dbus_connection(), path,
+	g_dbus_unregister_interface(btd_get_dbus_connection(), path,
 							PROXIMITY_INTERFACE);
 }
diff --git a/profiles/proximity/reporter.c b/profiles/proximity/reporter.c
index 3843018..a425d53 100644
--- a/profiles/proximity/reporter.c
+++ b/profiles/proximity/reporter.c
@@ -199,7 +199,7 @@ static void unregister_reporter_device(gpointer data, gpointer user_data)
 
 	DBG("unregister on device %s", path);
 
-	g_dbus_unregister_interface(get_dbus_connection(), path,
+	g_dbus_unregister_interface(btd_get_dbus_connection(), path,
 					PROXIMITY_REPORTER_INTERFACE);
 
 	radapter->devices = g_slist_remove(radapter->devices, device);
@@ -213,7 +213,7 @@ static void register_reporter_device(struct btd_device *device,
 
 	DBG("register on device %s", path);
 
-	g_dbus_register_interface(get_dbus_connection(), path,
+	g_dbus_register_interface(btd_get_dbus_connection(), path,
 					PROXIMITY_REPORTER_INTERFACE,
 					reporter_methods, reporter_signals,
 					NULL, device, NULL);
diff --git a/src/dbus-common.c b/src/dbus-common.c
index fb55027..f7e9e8f 100644
--- a/src/dbus-common.c
+++ b/src/dbus-common.c
@@ -175,7 +175,7 @@ void set_dbus_connection(DBusConnection *conn)
 	connection = conn;
 }
 
-DBusConnection *get_dbus_connection(void)
+DBusConnection *btd_get_dbus_connection(void)
 {
 	return connection;
 }
diff --git a/src/dbus-common.h b/src/dbus-common.h
index b9531f2..127cf9c 100644
--- a/src/dbus-common.h
+++ b/src/dbus-common.h
@@ -42,7 +42,7 @@ dbus_bool_t emit_array_property_changed(DBusConnection *conn,
 					int type, void *value, int num);
 
 void set_dbus_connection(DBusConnection *conn);
-DBusConnection *get_dbus_connection(void);
+DBusConnection *btd_get_dbus_connection(void);
 
 const char *class_to_icon(uint32_t class);
 const char *gap_appearance_to_icon(uint16_t appearance);
diff --git a/src/device.c b/src/device.c
index 77215f1..278d721 100644
--- a/src/device.c
+++ b/src/device.c
@@ -821,7 +821,7 @@ static void bonding_request_cancel(struct bonding_req *bonding)
 
 void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
 {
-	DBusConnection *conn = get_dbus_connection();
+	DBusConnection *conn = btd_get_dbus_connection();
 
 	if (device->bonding)
 		bonding_request_cancel(device->bonding);
@@ -988,7 +988,7 @@ void device_remove_disconnect_watch(struct btd_device *device, guint id)
 
 static void device_set_vendor(struct btd_device *device, uint16_t value)
 {
-	DBusConnection *conn = get_dbus_connection();
+	DBusConnection *conn = btd_get_dbus_connection();
 
 	if (device->vendor == value)
 		return;
@@ -1001,7 +1001,7 @@ static void device_set_vendor(struct btd_device *device, uint16_t value)
 
 static void device_set_vendor_src(struct btd_device *device, uint16_t value)
 {
-	DBusConnection *conn = get_dbus_connection();
+	DBusConnection *conn = btd_get_dbus_connection();
 
 	if (device->vendor_src == value)
 		return;
@@ -1014,7 +1014,7 @@ static void device_set_vendor_src(struct btd_device *device, uint16_t value)
 
 static void device_set_product(struct btd_device *device, uint16_t value)
 {
-	DBusConnection *conn = get_dbus_connection();
+	DBusConnection *conn = btd_get_dbus_connection();
 
 	if (device->product == value)
 		return;
@@ -1027,7 +1027,7 @@ static void device_set_product(struct btd_device *device, uint16_t value)
 
 static void device_set_version(struct btd_device *device, uint16_t value)
 {
-	DBusConnection *conn = get_dbus_connection();
+	DBusConnection *conn = btd_get_dbus_connection();
 
 	if (device->version == value)
 		return;
@@ -1106,7 +1106,7 @@ struct btd_device *device_create(DBusConnection *conn,
 
 void device_set_name(struct btd_device *device, const char *name)
 {
-	DBusConnection *conn = get_dbus_connection();
+	DBusConnection *conn = btd_get_dbus_connection();
 
 	if (strncmp(name, device->name, MAX_NAME_LENGTH) == 0)
 		return;
@@ -1154,7 +1154,7 @@ static void device_remove_stored(struct btd_device *device)
 {
 	bdaddr_t src, dst;
 	uint8_t dst_type;
-	DBusConnection *conn = get_dbus_connection();
+	DBusConnection *conn = btd_get_dbus_connection();
 
 	adapter_get_address(device->adapter, &src);
 	device_get_address(device, &dst, &dst_type);
@@ -1382,7 +1382,7 @@ static void device_remove_profiles(struct btd_device *device, GSList *uuids)
 
 static void uuids_changed(struct btd_device *device)
 {
-	DBusConnection *conn = get_dbus_connection();
+	DBusConnection *conn = btd_get_dbus_connection();
 	char **uuids;
 	GSList *l;
 	int i;
@@ -2077,7 +2077,7 @@ int device_browse_primary(struct btd_device *device, DBusConnection *conn,
 
 done:
 	if (conn == NULL)
-		conn = get_dbus_connection();
+		conn = btd_get_dbus_connection();
 
 	req->conn = dbus_connection_ref(conn);
 
@@ -2129,7 +2129,7 @@ int device_browse_sdp(struct btd_device *device, DBusConnection *conn,
 	}
 
 	if (conn == NULL)
-		conn = get_dbus_connection();
+		conn = btd_get_dbus_connection();
 
 	req->conn = dbus_connection_ref(conn);
 	device->browse = req;
@@ -2344,7 +2344,7 @@ static void bonding_request_free(struct bonding_req *bonding)
 
 void device_set_paired(struct btd_device *device, gboolean value)
 {
-	DBusConnection *conn = get_dbus_connection();
+	DBusConnection *conn = btd_get_dbus_connection();
 
 	if (device->paired == value)
 		return;
@@ -3056,7 +3056,7 @@ struct btd_device *btd_device_ref(struct btd_device *device)
 
 void btd_device_unref(struct btd_device *device)
 {
-	DBusConnection *conn = get_dbus_connection();
+	DBusConnection *conn = btd_get_dbus_connection();
 	gchar *path;
 
 	device->ref--;
@@ -3075,7 +3075,7 @@ void btd_device_unref(struct btd_device *device)
 
 void device_set_class(struct btd_device *device, uint32_t value)
 {
-	DBusConnection *conn = get_dbus_connection();
+	DBusConnection *conn = btd_get_dbus_connection();
 	const char *icon = class_to_icon(value);
 
 	emit_property_changed(conn, device->path, DEVICE_INTERFACE, "Class",
@@ -3107,7 +3107,7 @@ int device_get_appearance(struct btd_device *device, uint16_t *value)
 
 void device_set_appearance(struct btd_device *device, uint16_t value)
 {
-	DBusConnection *conn = get_dbus_connection();
+	DBusConnection *conn = btd_get_dbus_connection();
 	const char *icon = gap_appearance_to_icon(value);
 	bdaddr_t src;
 
diff --git a/src/event.c b/src/event.c
index 3b85961..e720b26 100644
--- a/src/event.c
+++ b/src/event.c
@@ -56,7 +56,7 @@ static gboolean get_adapter_and_device(bdaddr_t *src, bdaddr_t *dst,
 					struct btd_device **device,
 					gboolean create)
 {
-	DBusConnection *conn = get_dbus_connection();
+	DBusConnection *conn = btd_get_dbus_connection();
 	char peer_addr[18];
 
 	*adapter = manager_find_adapter(src);
@@ -483,7 +483,7 @@ void btd_event_conn_failed(bdaddr_t *local, bdaddr_t *peer, uint8_t status)
 {
 	struct btd_adapter *adapter;
 	struct btd_device *device;
-	DBusConnection *conn = get_dbus_connection();
+	DBusConnection *conn = btd_get_dbus_connection();
 
 	DBG("status 0x%02x", status);
 
@@ -521,7 +521,7 @@ void btd_event_device_blocked(bdaddr_t *local, bdaddr_t *peer)
 	struct btd_adapter *adapter;
 	struct btd_device *device;
 
-	DBusConnection *conn = get_dbus_connection();
+	DBusConnection *conn = btd_get_dbus_connection();
 
 	if (!get_adapter_and_device(local, peer, &adapter, &device, FALSE))
 		return;
@@ -535,7 +535,7 @@ void btd_event_device_unblocked(bdaddr_t *local, bdaddr_t *peer)
 	struct btd_adapter *adapter;
 	struct btd_device *device;
 
-	DBusConnection *conn = get_dbus_connection();
+	DBusConnection *conn = btd_get_dbus_connection();
 
 	if (!get_adapter_and_device(local, peer, &adapter, &device, FALSE))
 		return;
@@ -548,7 +548,7 @@ void btd_event_device_unpaired(bdaddr_t *local, bdaddr_t *peer)
 {
 	struct btd_adapter *adapter;
 	struct btd_device *device;
-	DBusConnection *conn = get_dbus_connection();
+	DBusConnection *conn = btd_get_dbus_connection();
 
 	if (!get_adapter_and_device(local, peer, &adapter, &device, FALSE))
 		return;
diff --git a/src/main.c b/src/main.c
index 34c74ec..249d29e 100644
--- a/src/main.c
+++ b/src/main.c
@@ -383,7 +383,7 @@ void btd_stop_exit_timer(void)
 
 static void disconnect_dbus(void)
 {
-	DBusConnection *conn = get_dbus_connection();
+	DBusConnection *conn = btd_get_dbus_connection();
 
 	if (!conn || !dbus_connection_get_is_connected(conn))
 		return;
-- 
1.7.11.3

