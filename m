Return-Path: <cyrus@holtmann.org>
From: chen.ganir@ti.com
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH 2/4] Centralize property changed events
Date: Wed, 28 Mar 2012 16:46:27 +0200
Message-Id: <1332945989-375-3-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1332945989-375-1-git-send-email-chen.ganir@ti.com>
References: <1332945989-375-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Move all D-BUS property changed events into one function, allowing
more logic to be added later.
---
 src/device.c |   82 +++++++++++++++++++++++++++++++++------------------------
 1 files changed, 47 insertions(+), 35 deletions(-)

diff --git a/src/device.c b/src/device.c
index 45ce62e..fbed9f8 100644
--- a/src/device.c
+++ b/src/device.c
@@ -187,6 +187,25 @@ static uint16_t uuid_list[] = {
 
 static GSList *device_drivers = NULL;
 
+
+static void notify_property_changed(DBusConnection *conn,
+					const char *path,
+					const char *name,
+					int type, void *value, int num)
+{
+	const char *interface = DEVICE_INTERFACE;
+
+	if (num == 0)
+		emit_property_changed(conn, path,
+					interface, name,
+					type, value);
+	else
+		emit_array_property_changed(conn, path,
+				interface, name,
+				type, value,num);
+}
+
+
 static void browse_request_free(struct browse_req *req)
 {
 	if (req->listener_id)
@@ -461,9 +480,8 @@ static DBusMessage *set_alias(DBusConnection *conn, DBusMessage *msg,
 	g_free(device->alias);
 	device->alias = g_str_equal(alias, "") ? NULL : g_strdup(alias);
 
-	emit_property_changed(conn, dbus_message_get_path(msg),
-				DEVICE_INTERFACE, "Alias",
-				DBUS_TYPE_STRING, &alias);
+	notify_property_changed(conn, dbus_message_get_path(msg),
+				"Alias", DBUS_TYPE_STRING, &alias, 0);
 
 	return dbus_message_new_method_return(msg);
 }
@@ -490,9 +508,8 @@ static DBusMessage *set_trust(DBusConnection *conn, DBusMessage *msg,
 
 	device->trusted = value;
 
-	emit_property_changed(conn, dbus_message_get_path(msg),
-				DEVICE_INTERFACE, "Trusted",
-				DBUS_TYPE_BOOLEAN, &value);
+	notify_property_changed(conn, dbus_message_get_path(msg),
+				"Trusted", DBUS_TYPE_BOOLEAN, &value, 0);
 
 	return dbus_message_new_method_return(msg);
 }
@@ -548,8 +565,8 @@ int device_block(DBusConnection *conn, struct btd_device *device,
 
 	device_set_temporary(device, FALSE);
 
-	emit_property_changed(conn, device->path, DEVICE_INTERFACE, "Blocked",
-					DBUS_TYPE_BOOLEAN, &device->blocked);
+	notify_property_changed(conn, device->path, "Blocked",
+					DBUS_TYPE_BOOLEAN, &device->blocked, 0);
 
 	return 0;
 }
@@ -579,9 +596,8 @@ int device_unblock(DBusConnection *conn, struct btd_device *device,
 		error("write_blocked(): %s (%d)", strerror(-err), -err);
 
 	if (!silent) {
-		emit_property_changed(conn, device->path,
-					DEVICE_INTERFACE, "Blocked",
-					DBUS_TYPE_BOOLEAN, &device->blocked);
+		notify_property_changed(conn, device->path,
+					"Blocked", DBUS_TYPE_BOOLEAN, &device->blocked, 0);
 		device_probe_drivers(device, device->uuids);
 	}
 
@@ -906,9 +922,8 @@ void device_add_connection(struct btd_device *device, DBusConnection *conn)
 
 	device->connected = TRUE;
 
-	emit_property_changed(conn, device->path,
-					DEVICE_INTERFACE, "Connected",
-					DBUS_TYPE_BOOLEAN, &device->connected);
+	notify_property_changed(conn, device->path,
+					"Connected", DBUS_TYPE_BOOLEAN, &device->connected, 0);
 }
 
 void device_remove_connection(struct btd_device *device, DBusConnection *conn)
@@ -937,9 +952,8 @@ void device_remove_connection(struct btd_device *device, DBusConnection *conn)
 	if (device_is_paired(device) && !device_is_bonded(device))
 		device_set_paired(device, FALSE);
 
-	emit_property_changed(conn, device->path,
-					DEVICE_INTERFACE, "Connected",
-					DBUS_TYPE_BOOLEAN, &device->connected);
+	notify_property_changed(conn, device->path,
+					"Connected", DBUS_TYPE_BOOLEAN, &device->connected, 0);
 }
 
 guint device_add_disconnect_watch(struct btd_device *device,
@@ -987,8 +1001,8 @@ static void device_set_vendor(struct btd_device *device, uint16_t value)
 
 	device->vendor = value;
 
-	emit_property_changed(conn, device->path, DEVICE_INTERFACE, "Vendor",
-				DBUS_TYPE_UINT16, &value);
+	notify_property_changed(conn, device->path, "Vendor",
+				DBUS_TYPE_UINT16, &value, 0);
 }
 
 static void device_set_product(struct btd_device *device, uint16_t value)
@@ -1000,8 +1014,8 @@ static void device_set_product(struct btd_device *device, uint16_t value)
 
 	device->product = value;
 
-	emit_property_changed(conn, device->path, DEVICE_INTERFACE, "Product",
-				DBUS_TYPE_UINT16, &value);
+	notify_property_changed(conn, device->path, "Product",
+				DBUS_TYPE_UINT16, &value, 0);
 }
 
 static void device_set_version(struct btd_device *device, uint16_t value)
@@ -1013,8 +1027,8 @@ static void device_set_version(struct btd_device *device, uint16_t value)
 
 	device->version = value;
 
-	emit_property_changed(conn, device->path, DEVICE_INTERFACE, "Version",
-				DBUS_TYPE_UINT16, &value);
+	notify_property_changed(conn, device->path, "Version",
+				DBUS_TYPE_UINT16, &value, 0);
 }
 
 struct btd_device *device_create(DBusConnection *conn,
@@ -1088,16 +1102,14 @@ void device_set_name(struct btd_device *device, const char *name)
 
 	strncpy(device->name, name, MAX_NAME_LENGTH);
 
-	emit_property_changed(conn, device->path,
-				DEVICE_INTERFACE, "Name",
-				DBUS_TYPE_STRING, &name);
+	notify_property_changed(conn, device->path,
+				"Name",	DBUS_TYPE_STRING, &name, 0);
 
 	if (device->alias != NULL)
 		return;
 
-	emit_property_changed(conn, device->path,
-				DEVICE_INTERFACE, "Alias",
-				DBUS_TYPE_STRING, &name);
+	notify_property_changed(conn, device->path,
+				"Alias", DBUS_TYPE_STRING, &name, 0);
 }
 
 void device_get_name(struct btd_device *device, char *name, size_t len)
@@ -1387,8 +1399,8 @@ static void services_changed(struct btd_device *device)
 	for (i = 0, l = device->uuids; l; l = l->next, i++)
 		uuids[i] = l->data;
 
-	emit_array_property_changed(conn, device->path, DEVICE_INTERFACE,
-					"UUIDs", DBUS_TYPE_STRING, &uuids, i);
+	notify_property_changed(conn, device->path, "UUIDs",
+					DBUS_TYPE_STRING, &uuids, i);
 
 	g_free(uuids);
 }
@@ -2321,8 +2333,8 @@ void device_set_paired(struct btd_device *device, gboolean value)
 
 	device->paired = value;
 
-	emit_property_changed(conn, device->path, DEVICE_INTERFACE, "Paired",
-				DBUS_TYPE_BOOLEAN, &value);
+	notify_property_changed(conn, device->path, "Paired",
+				DBUS_TYPE_BOOLEAN, &value, 0);
 }
 
 static void device_agent_removed(struct agent *agent, void *user_data)
@@ -2908,8 +2920,8 @@ void device_set_class(struct btd_device *device, uint32_t value)
 {
 	DBusConnection *conn = get_dbus_connection();
 
-	emit_property_changed(conn, device->path, DEVICE_INTERFACE, "Class",
-				DBUS_TYPE_UINT32, &value);
+	notify_property_changed(conn, device->path, "Class",
+				DBUS_TYPE_UINT32, &value, 0);
 }
 
 static gboolean notify_attios(gpointer user_data)
-- 
1.7.4.1

