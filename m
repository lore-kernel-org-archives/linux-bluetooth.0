Return-Path: <cyrus@holtmann.org>
From: <chen.ganir@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <chen.ganir@ti.com>
Subject: [PATCH v4 02/10] battery: Implement Generic device battery
Date: Mon, 24 Sep 2012 09:15:11 +0200
Message-ID: <1348470919-25567-3-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1348470919-25567-1-git-send-email-chen.ganir@ti.com>
References: <1348470919-25567-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Add implementation for the generic battery in bluetooth device.
This patch adds new D-Bus interface for adding/removing/changing
peer device battery status, allowing management of remote device
batteries.
---
 src/device.c     |  175 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/device.h     |   14 +++++
 test/test-device |   13 ++++
 3 files changed, 202 insertions(+)

diff --git a/src/device.c b/src/device.c
index aa3a607..750d3a8 100644
--- a/src/device.c
+++ b/src/device.c
@@ -163,6 +163,7 @@ struct btd_device {
 
 	gboolean	authorizing;
 	gint		ref;
+	GSList		*batteries;
 
 	GIOChannel      *att_io;
 	guint		cleanup_id;
@@ -175,6 +176,24 @@ static uint16_t uuid_list[] = {
 	0
 };
 
+struct btd_battery {
+	uint16_t		level;
+	char			*path;
+	struct btd_device	*device;
+	refresh_battery_cb	refresh;
+};
+
+static void battery_free(gpointer user_data)
+{
+	struct btd_battery *b = user_data;
+
+	g_dbus_unregister_interface(btd_get_dbus_connection(), b->path, BATTERY_INTERFACE);
+	btd_device_unref(b->device);
+	g_free(b->path);
+	g_free(b);
+
+}
+
 static void browse_request_free(struct browse_req *req)
 {
 	if (req->listener_id)
@@ -253,6 +272,7 @@ static void device_free(gpointer user_data)
 	g_slist_free_full(device->primaries, g_free);
 	g_slist_free_full(device->attios, g_free);
 	g_slist_free_full(device->attios_offline, g_free);
+	g_slist_free_full(device->batteries, battery_free);
 
 	attio_cleanup(device);
 
@@ -426,6 +446,15 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	ptr = adapter_get_path(adapter);
 	dict_append_entry(&dict, "Adapter", DBUS_TYPE_OBJECT_PATH, &ptr);
 
+	/* Batteries */
+	str = g_new0(char *, g_slist_length(device->batteries) + 1);
+	for (i = 0, l = device->batteries; l; l = l->next, i++) {
+		struct btd_battery *b = l->data;
+		str[i] = b->path;
+	}
+	dict_append_array(&dict, "Batteries", DBUS_TYPE_OBJECT_PATH, &str, i);
+	g_free(str);
+
 	dbus_message_iter_close_container(&iter, &dict);
 
 	return reply;
@@ -3177,3 +3206,149 @@ void device_set_pnpid(struct btd_device *device, uint8_t vendor_id_src,
 	device_set_version(device, product_ver);
 }
 
+static void batteries_changed(struct btd_device *device)
+{
+	char **batteries;
+	GSList *l;
+	int i;
+
+	batteries = g_new0(char *, g_slist_length(device->batteries) + 1);
+	for (i = 0, l = device->batteries; l; l = l->next, i++) {
+		struct btd_battery *batt = l->data;
+		batteries[i] = batt->path;
+	}
+
+	emit_array_property_changed(device->path, DEVICE_INTERFACE, "Batteries",
+					  DBUS_TYPE_OBJECT_PATH, &batteries, i);
+
+	g_free(batteries);
+}
+
+static DBusMessage *refresh_batt_level(DBusConnection *conn,
+						  DBusMessage *msg, void *data)
+{
+	struct btd_battery *b = data;
+
+	if (!b->refresh)
+		return btd_error_not_supported(msg);
+
+	b->refresh(b);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *get_batt_properties(DBusConnection *conn,
+						  DBusMessage *msg, void *data)
+{
+	struct btd_battery *b = data;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	DBusMessage *reply;
+
+	reply = dbus_message_new_method_return(msg);
+	if (reply == NULL)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	dict_append_entry(&dict, "Level", DBUS_TYPE_UINT16, &b->level);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static GDBusMethodTable battery_methods[] = {
+	{ GDBUS_METHOD("GetProperties",
+		NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
+		get_batt_properties) },
+	{ GDBUS_METHOD("Refresh",
+		NULL, NULL,
+		refresh_batt_level) },
+	{ }
+};
+
+static GDBusSignalTable battery_signals[] = {
+	{ GDBUS_SIGNAL("PropertyChanged",
+		GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
+	{ }
+};
+
+struct btd_battery *btd_device_add_battery(struct btd_device *device)
+{
+	struct btd_battery *batt;
+
+	batt = g_new0(struct btd_battery, 1);
+	batt->path = g_strdup_printf("%s/BATT%04X", device->path,
+					     g_slist_length(device->batteries));
+
+	if (!g_dbus_register_interface(btd_get_dbus_connection(), batt->path,
+			BATTERY_INTERFACE, battery_methods, battery_signals,
+			NULL, batt, NULL)) {
+		error("D-Bus register interface %s failed", BATTERY_INTERFACE);
+		g_free(batt->path);
+		g_free(batt);
+		return NULL;
+	}
+
+	batt->device = btd_device_ref(device);
+	device->batteries = g_slist_append(device->batteries, batt);
+	batteries_changed(device);
+
+	return batt;
+}
+
+void btd_device_remove_battery(struct btd_battery *batt)
+{
+	struct btd_device *dev = batt->device;
+
+	dev->batteries = g_slist_remove(dev->batteries, batt);
+
+	battery_free(batt);
+
+	batteries_changed(dev);
+}
+
+gboolean btd_device_set_battery_opt(struct btd_battery *batt,
+						    battery_option_t opt1, ...)
+{
+	va_list args;
+	battery_option_t opt = opt1;
+	int level;
+
+	if (!batt)
+		return FALSE;
+
+	va_start(args, opt1);
+
+	while (opt != BATTERY_OPT_INVALID) {
+		switch (opt) {
+		case BATTERY_OPT_LEVEL:
+			level = va_arg(args, int);
+			if (level != batt->level) {
+				batt->level = level;
+				emit_property_changed(batt->path,
+						BATTERY_INTERFACE, "Level",
+						DBUS_TYPE_UINT16, &level);
+			}
+			break;
+		case BATTERY_OPT_REFRESH_FUNC:
+			batt->refresh = va_arg(args, refresh_battery_cb);
+			break;
+		default:
+			error("Unknown option %d", opt);
+			return FALSE;
+		}
+
+		opt = va_arg(args, int);
+	}
+
+	va_end(args);
+
+	return TRUE;
+}
diff --git a/src/device.h b/src/device.h
index aee6d13..a82ae74 100644
--- a/src/device.h
+++ b/src/device.h
@@ -23,8 +23,10 @@
  */
 
 #define DEVICE_INTERFACE	"org.bluez.Device"
+#define BATTERY_INTERFACE      "org.bluez.Battery"
 
 struct btd_device;
+struct btd_battery;
 
 typedef enum {
 	AUTH_TYPE_PINCODE,
@@ -34,6 +36,14 @@ typedef enum {
 	AUTH_TYPE_NOTIFY_PINCODE,
 } auth_type_t;
 
+typedef void (*refresh_battery_cb) (struct btd_battery *batt);
+
+typedef enum {
+	BATTERY_OPT_INVALID = 0,
+	BATTERY_OPT_LEVEL,
+	BATTERY_OPT_REFRESH_FUNC,
+} battery_option_t;
+
 struct btd_device *device_create(struct btd_adapter *adapter,
 				const char *address, uint8_t bdaddr_type);
 
@@ -125,3 +135,7 @@ void device_set_pnpid(struct btd_device *device, uint8_t vendor_id_src,
 			uint16_t vendor_id, uint16_t product_id,
 			uint16_t product_ver);
 gboolean device_att_connect(gpointer user_data);
+struct btd_battery *btd_device_add_battery(struct btd_device *device);
+void btd_device_remove_battery(struct btd_battery *batt);
+gboolean btd_device_set_battery_opt(struct btd_battery *batt,
+						    battery_option_t opt1, ...);
diff --git a/test/test-device b/test/test-device
index 63a96d3..7edb7b8 100755
--- a/test/test-device
+++ b/test/test-device
@@ -37,6 +37,7 @@ if (len(args) < 1):
 	print("")
 	print("  list")
 	print("  services <address>")
+	print("  batteries <address>")
 	print("  create <address>")
 	print("  remove <address|path>")
 	print("  disconnect <address>")
@@ -205,5 +206,17 @@ if (args[0] == "services"):
 			print(path)
 	sys.exit(0)
 
+if (args[0] == "batteries"):
+	if (len(args) < 2):
+		print("Need address parameter")
+	else:
+		path = adapter.FindDevice(args[1])
+		device = dbus.Interface(bus.get_object("org.bluez", path),
+							"org.bluez.Device")
+		properties = device.GetProperties()
+		for path in properties["Batteries"]:
+			print(path)
+	sys.exit(0)
+
 print("Unknown command")
 sys.exit(1)
-- 
1.7.9.5

