Return-Path: <cyrus@holtmann.org>
From: Paulo Borges <paulo.borges@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH 2/9] battery: Implement Generic device battery
Date: Mon,  7 Jan 2013 16:40:57 -0300
Message-Id: <1357587664-16818-3-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1357587664-16818-1-git-send-email-paulo.borges@openbossa.org>
References: <1357587664-16818-1-git-send-email-paulo.borges@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add implementation for the generic battery in bluetooth device.
This patch adds new D-Bus interface for adding/removing/changing
peer device battery status, allowing management of remote device
batteries.
---
 src/device.c     |  140 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/device.h     |   15 ++++++
 test/test-device |   15 ++++++
 3 files changed, 170 insertions(+)

diff --git a/src/device.c b/src/device.c
index 20099e6..bbd0bbf 100644
--- a/src/device.c
+++ b/src/device.c
@@ -187,6 +187,7 @@ struct btd_device {
 	int8_t		rssi;
 
 	gint		ref;
+	GSList		*batteries;
 
 	GIOChannel	*att_io;
 	guint		cleanup_id;
@@ -331,6 +332,24 @@ static void store_device_info(struct btd_device *device)
 	device->store_id = g_idle_add(store_device_info_cb, device);
 }
 
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
+	g_dbus_unregister_interface(btd_get_dbus_connection(), b->path,
+							BATTERY_INTERFACE);
+	btd_device_unref(b->device);
+	g_free(b->path);
+	g_free(b);
+}
+
 static void browse_request_free(struct browse_req *req)
 {
 	if (req->listener_id)
@@ -393,6 +412,7 @@ static void device_free(gpointer user_data)
 	g_slist_free_full(device->primaries, g_free);
 	g_slist_free_full(device->attios, g_free);
 	g_slist_free_full(device->attios_offline, g_free);
+	g_slist_free_full(device->batteries, battery_free);
 
 	attio_cleanup(device);
 
@@ -4111,3 +4131,123 @@ void btd_device_set_pnpid(struct btd_device *device, uint16_t source,
 
 	store_device_info(device);
 }
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
+static gboolean battery_property_get_level(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_battery *batt = data;
+	uint16_t level = batt->level;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &level);
+
+	return TRUE;
+}
+
+static gboolean battery_property_get_device(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_battery *batt = data;
+	const char *str = device_get_path(batt->device);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &str);
+
+	return TRUE;
+}
+
+static GDBusMethodTable battery_methods[] = {
+	{ GDBUS_METHOD("Refresh",
+		NULL, NULL,
+		refresh_batt_level) },
+	{ }
+};
+
+static const GDBusPropertyTable battery_properties[] = {
+	{ "Level", "q",  battery_property_get_level },
+	{ "Device", "o", battery_property_get_device },
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
+			BATTERY_INTERFACE, battery_methods, NULL,
+			battery_properties, batt, NULL)) {
+		error("D-Bus register interface %s failed", BATTERY_INTERFACE);
+		g_free(batt->path);
+		g_free(batt);
+		return NULL;
+	}
+
+	batt->device = btd_device_ref(device);
+	device->batteries = g_slist_append(device->batteries, batt);
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
+				g_dbus_emit_property_changed(
+					btd_get_dbus_connection(),
+					batt->path, BATTERY_INTERFACE,
+					"Level");
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
index ae70690..0f7babd 100644
--- a/src/device.h
+++ b/src/device.h
@@ -23,8 +23,18 @@
  */
 
 #define DEVICE_INTERFACE	"org.bluez.Device1"
+#define BATTERY_INTERFACE	"org.bluez.Battery1"
 
 struct btd_device;
+struct btd_battery;
+
+typedef void (*refresh_battery_cb) (struct btd_battery *batt);
+
+typedef enum {
+	BATTERY_OPT_INVALID = 0,
+	BATTERY_OPT_LEVEL,
+	BATTERY_OPT_REFRESH_FUNC,
+} battery_option_t;
 
 struct btd_device *device_create(struct btd_adapter *adapter,
 				const char *address, uint8_t bdaddr_type);
@@ -116,3 +126,8 @@ void device_profile_connected(struct btd_device *dev,
 					struct btd_profile *profile, int err);
 void device_profile_disconnected(struct btd_device *dev,
 					struct btd_profile *profile, int err);
+
+struct btd_battery *btd_device_add_battery(struct btd_device *device);
+void btd_device_remove_battery(struct btd_battery *batt);
+gboolean btd_device_set_battery_opt(struct btd_battery *batt,
+						    battery_option_t opt1, ...);
diff --git a/test/test-device b/test/test-device
index 3d7b852..ee144f1 100755
--- a/test/test-device
+++ b/test/test-device
@@ -27,6 +27,7 @@ if (len(args) < 1):
 	print("Usage: %s <command>" % (sys.argv[0]))
 	print("")
 	print("  list")
+	print("  batteries <address>")
 	print("  create <address>")
 	print("  remove <address|path>")
 	print("  connect <address> [profile]")
@@ -196,5 +197,19 @@ if (args[0] == "blocked"):
 			props.Set("org.bluez.Device1", "Blocked", value)
 	sys.exit(0)
 
+if (args[0] == "batteries"):
+	if (len(args) < 2):
+		print("Need address parameter")
+	else:
+		BATT_INTERFACE = "org.bluez.Battery1"
+		objs = bluezutils.get_managed_objects()
+		device = bluezutils.find_device(args[1], options.dev_id)
+		batteries = [path for path, ifaces in objs.iteritems()
+			if (lambda obj: obj and obj.get("Device") ==
+			device.object_path)(ifaces.get(BATT_INTERFACE))]
+		for batt in batteries:
+			print(batt)
+	sys.exit(0)
+
 print("Unknown command")
 sys.exit(1)
-- 
1.7.9.5

