Return-Path: <cyrus@holtmann.org>
From: chen.ganir@ti.com
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH 3/4] Use macros instead of strings
Date: Wed, 28 Mar 2012 16:46:28 +0200
Message-Id: <1332945989-375-4-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1332945989-375-1-git-send-email-chen.ganir@ti.com>
References: <1332945989-375-1-git-send-email-chen.ganir@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Use macros instead of strings when calling notify_property_changed.
Use a helper array to get the correct D-BUS Property name.
---
 src/device.c |   96 ++++++++++++++++++++++++++++++++++++++++------------------
 src/device.h |   18 +++++++++++
 2 files changed, 84 insertions(+), 30 deletions(-)

diff --git a/src/device.c b/src/device.c
index fbed9f8..dbabd87 100644
--- a/src/device.c
+++ b/src/device.c
@@ -187,13 +187,37 @@ static uint16_t uuid_list[] = {
 
 static GSList *device_drivers = NULL;
 
-
-static void notify_property_changed(DBusConnection *conn,
+const char *property_name[] = { "Address",
+								"Name",
+								"Vendor",
+								"Product",
+								"Version",
+								"Icon",
+								"Class",
+								"UUIDs",
+								"Services",
+								"Paired",
+								"Connected",
+								"Trusted",
+								"Blocked",
+								"Alias",
+								"Nodes",
+								"Adapter",
+								"LegacyPairing"};
+
+static void notify_property_changed(struct btd_device *device,
+					DBusConnection *conn,
 					const char *path,
-					const char *name,
+					const uint16_t property,
 					int type, void *value, int num)
 {
 	const char *interface = DEVICE_INTERFACE;
+	const char *name = "";
+
+	if (property > 0 && property <= DEVICE_PROPERTY_CHANGED_LEGACYPAIRING)
+		name = property_name[property-1];
+	else
+		name = "UNKNOWN";
 
 	if (num == 0)
 		emit_property_changed(conn, path,
@@ -480,8 +504,9 @@ static DBusMessage *set_alias(DBusConnection *conn, DBusMessage *msg,
 	g_free(device->alias);
 	device->alias = g_str_equal(alias, "") ? NULL : g_strdup(alias);
 
-	notify_property_changed(conn, dbus_message_get_path(msg),
-				"Alias", DBUS_TYPE_STRING, &alias, 0);
+	notify_property_changed(device, conn, dbus_message_get_path(msg),
+						DEVICE_PROPERTY_CHANGED_ALIAS,
+						DBUS_TYPE_STRING, &alias, 0);
 
 	return dbus_message_new_method_return(msg);
 }
@@ -508,8 +533,9 @@ static DBusMessage *set_trust(DBusConnection *conn, DBusMessage *msg,
 
 	device->trusted = value;
 
-	notify_property_changed(conn, dbus_message_get_path(msg),
-				"Trusted", DBUS_TYPE_BOOLEAN, &value, 0);
+	notify_property_changed(device, conn, dbus_message_get_path(msg),
+				DEVICE_PROPERTY_CHANGED_TRUSTED,
+				DBUS_TYPE_BOOLEAN, &value, 0);
 
 	return dbus_message_new_method_return(msg);
 }
@@ -565,8 +591,9 @@ int device_block(DBusConnection *conn, struct btd_device *device,
 
 	device_set_temporary(device, FALSE);
 
-	notify_property_changed(conn, device->path, "Blocked",
-					DBUS_TYPE_BOOLEAN, &device->blocked, 0);
+	notify_property_changed(device, conn, device->path,
+					DEVICE_PROPERTY_CHANGED_BLOCKED, DBUS_TYPE_BOOLEAN,
+					&device->blocked, 0);
 
 	return 0;
 }
@@ -596,8 +623,10 @@ int device_unblock(DBusConnection *conn, struct btd_device *device,
 		error("write_blocked(): %s (%d)", strerror(-err), -err);
 
 	if (!silent) {
-		notify_property_changed(conn, device->path,
-					"Blocked", DBUS_TYPE_BOOLEAN, &device->blocked, 0);
+		notify_property_changed(device, conn, device->path,
+					DEVICE_PROPERTY_CHANGED_BLOCKED,
+					DBUS_TYPE_BOOLEAN, &device->blocked, 0);
+
 		device_probe_drivers(device, device->uuids);
 	}
 
@@ -922,8 +951,10 @@ void device_add_connection(struct btd_device *device, DBusConnection *conn)
 
 	device->connected = TRUE;
 
-	notify_property_changed(conn, device->path,
-					"Connected", DBUS_TYPE_BOOLEAN, &device->connected, 0);
+	notify_property_changed(device, conn, device->path,
+					DEVICE_PROPERTY_CHANGED_CONNECTED,
+					DBUS_TYPE_BOOLEAN, &device->connected, 0);
+
 }
 
 void device_remove_connection(struct btd_device *device, DBusConnection *conn)
@@ -952,8 +983,9 @@ void device_remove_connection(struct btd_device *device, DBusConnection *conn)
 	if (device_is_paired(device) && !device_is_bonded(device))
 		device_set_paired(device, FALSE);

-	notify_property_changed(conn, device->path,
-					"Connected", DBUS_TYPE_BOOLEAN, &device->connected, 0);
+	notify_property_changed(device, conn, device->path,
+					DEVICE_PROPERTY_CHANGED_CONNECTED,
+					DBUS_TYPE_BOOLEAN, &device->connected, 0);
 }
 
 guint device_add_disconnect_watch(struct btd_device *device,
@@ -1001,8 +1033,8 @@ static void device_set_vendor(struct btd_device *device, uint16_t value)

 	device->vendor = value;

-	notify_property_changed(conn, device->path, "Vendor",
-				DBUS_TYPE_UINT16, &value, 0);
+	notify_property_changed(device, conn, device->path,
+				DEVICE_PROPERTY_CHANGED_VENDOR,	DBUS_TYPE_UINT16, &value, 0);
 }
 
 static void device_set_product(struct btd_device *device, uint16_t value)
@@ -1014,8 +1046,8 @@ static void device_set_product(struct btd_device *device, uint16_t value)
 
 	device->product = value;
 
-	notify_property_changed(conn, device->path, "Product",
-				DBUS_TYPE_UINT16, &value, 0);
+	notify_property_changed(device, conn, device->path,
+				DEVICE_PROPERTY_CHANGED_PRODUCT, DBUS_TYPE_UINT16, &value, 0);
 }
 
 static void device_set_version(struct btd_device *device, uint16_t value)
@@ -1027,8 +1059,8 @@ static void device_set_version(struct btd_device *device, uint16_t value)
 
 	device->version = value;
 
-	notify_property_changed(conn, device->path, "Version",
-				DBUS_TYPE_UINT16, &value, 0);
+	notify_property_changed(device, conn, device->path,
+				DEVICE_PROPERTY_CHANGED_VERSION, DBUS_TYPE_UINT16, &value, 0);
 }
 
 struct btd_device *device_create(DBusConnection *conn,
@@ -1102,14 +1134,17 @@ void device_set_name(struct btd_device *device, const char *name)
 
 	strncpy(device->name, name, MAX_NAME_LENGTH);
 
-	notify_property_changed(conn, device->path,
-				"Name",	DBUS_TYPE_STRING, &name, 0);
+	notify_property_changed(device, conn, device->path,
+				DEVICE_PROPERTY_CHANGED_NAME,
+				DBUS_TYPE_STRING, &name, 0);
 
 	if (device->alias != NULL)
 		return;
 
-	notify_property_changed(conn, device->path,
-				"Alias", DBUS_TYPE_STRING, &name, 0);
+	notify_property_changed(device, conn, device->path,
+				DEVICE_PROPERTY_CHANGED_ALIAS,
+				DBUS_TYPE_STRING, &name, 0);
+
 }
 
 void device_get_name(struct btd_device *device, char *name, size_t len)
@@ -1399,7 +1434,8 @@ static void services_changed(struct btd_device *device)
 	for (i = 0, l = device->uuids; l; l = l->next, i++)
 		uuids[i] = l->data;
 
-	notify_property_changed(conn, device->path, "UUIDs",
+	notify_property_changed(device, conn, device->path,
+					DEVICE_PROPERTY_CHANGED_UUIDS,
 					DBUS_TYPE_STRING, &uuids, i);
 
 	g_free(uuids);
@@ -2333,8 +2369,8 @@ void device_set_paired(struct btd_device *device, gboolean value)
 
 	device->paired = value;
 
-	notify_property_changed(conn, device->path, "Paired",
-				DBUS_TYPE_BOOLEAN, &value, 0);
+	notify_property_changed(device, conn, device->path,
+			DEVICE_PROPERTY_CHANGED_PAIRED,	DBUS_TYPE_BOOLEAN, &value, 0);
 }
 
 static void device_agent_removed(struct agent *agent, void *user_data)
@@ -2920,8 +2956,8 @@ void device_set_class(struct btd_device *device, uint32_t value)
 {
 	DBusConnection *conn = get_dbus_connection();
 
-	notify_property_changed(conn, device->path, "Class",
-				DBUS_TYPE_UINT32, &value, 0);
+	notify_property_changed(device, conn, device->path,
+				DEVICE_PROPERTY_CHANGED_CLASS, DBUS_TYPE_UINT32, &value, 0);
 }
 
 static gboolean notify_attios(gpointer user_data)
diff --git a/src/device.h b/src/device.h
index ba9ed32..ce0a83a 100644
--- a/src/device.h
+++ b/src/device.h
@@ -28,6 +28,24 @@ struct btd_device;
 
 typedef void (*dev_property_changed_cb)(uint16_t property, uint8_t *value, uint16_t len);
 
+#define DEVICE_PROPERTY_CHANGED_ADDRESS			0x01
+#define DEVICE_PROPERTY_CHANGED_NAME			0x02
+#define DEVICE_PROPERTY_CHANGED_VENDOR			0x03
+#define DEVICE_PROPERTY_CHANGED_PRODUCT			0x04
+#define DEVICE_PROPERTY_CHANGED_VERSION			0x05
+#define DEVICE_PROPERTY_CHANGED_ICON			0x06
+#define DEVICE_PROPERTY_CHANGED_CLASS			0x07
+#define DEVICE_PROPERTY_CHANGED_UUIDS			0x08
+#define DEVICE_PROPERTY_CHANGED_SERVICES		0x09
+#define DEVICE_PROPERTY_CHANGED_PAIRED			0x0A
+#define DEVICE_PROPERTY_CHANGED_CONNECTED       0x0B
+#define DEVICE_PROPERTY_CHANGED_TRUSTED			0x0C
+#define DEVICE_PROPERTY_CHANGED_BLOCKED			0x0D
+#define DEVICE_PROPERTY_CHANGED_ALIAS			0x0E
+#define DEVICE_PROPERTY_CHANGED_NODES			0x0F
+#define DEVICE_PROPERTY_CHANGED_ADAPTER			0x10
+#define DEVICE_PROPERTY_CHANGED_LEGACYPAIRING	0x11
+
 typedef enum {
 	AUTH_TYPE_PINCODE,
 	AUTH_TYPE_PASSKEY,
-- 
1.7.4.1

