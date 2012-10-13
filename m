Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH] heartrate: Convert to DBus.Properties
Date: Sat, 13 Oct 2012 18:56:19 +0200
Message-Id: <1350147379-10912-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/heartrate-api.txt          |  7 +---
 profiles/heartrate/heartrate.c | 73 ++++++++++++++++++++++++------------------
 test/test-heartrate            |  5 ++-
 3 files changed, 46 insertions(+), 39 deletions(-)

diff --git a/doc/heartrate-api.txt b/doc/heartrate-api.txt
index 39a0cbd..d1d5191 100644
--- a/doc/heartrate-api.txt
+++ b/doc/heartrate-api.txt
@@ -28,12 +28,7 @@ Service		org.bluez
 Interface	org.bluez.HeartRate
 Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
 
-Methods		dict GetProperties()
-
-			Returns all properties for the interface. See the
-			Properties section for the available properties.
-
-		Reset()
+Methods		Reset()
 
 			Restart the accumulation of energy expended from zero.
 
diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 28c1932..9a92960 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -641,43 +641,47 @@ static const GDBusMethodTable heartrate_manager_methods[] = {
 	{ }
 };
 
-static DBusMessage *get_properties(DBusConnection *conn, DBusMessage *msg,
-								void *data)
+static gboolean property_get_location(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
 {
 	struct heartrate *hr = data;
-	DBusMessageIter iter;
-	DBusMessageIter dict;
-	DBusMessage *reply;
-	gboolean has_reset;
+	char *loc;
 
-	reply = dbus_message_new_method_return(msg);
-	if (reply == NULL)
-		return NULL;
+	if (!hr->has_location)
+		return FALSE;
 
-	dbus_message_iter_init_append(reply, &iter);
+	loc = g_strdup(location2str(hr->location));
 
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
-			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+	if (loc == NULL)
+		return FALSE;
 
-	if (hr->has_location) {
-		char *loc = g_strdup(location2str(hr->location));
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &loc);
 
-		if (loc) {
-			dict_append_entry(&dict, "Location",
-						DBUS_TYPE_STRING, &loc);
-			g_free(loc);
-		}
-	}
+	g_free(loc);
 
-	has_reset = !!hr->hrcp_val_handle;
-	dict_append_entry(&dict, "ResetSupported", DBUS_TYPE_BOOLEAN,
-								&has_reset);
+	return TRUE;
+}
 
-	dbus_message_iter_close_container(&iter, &dict);
+static gboolean property_exists_location(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct heartrate *hr = data;
+
+	if (!hr->has_location || location2str(hr->location) == NULL)
+		return FALSE;
+
+	return TRUE;
+}
+
+static gboolean property_get_reset_supported(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct heartrate *hr = data;
+	dbus_bool_t has_reset = !!hr->hrcp_val_handle;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &has_reset);
 
-	return reply;
+	return TRUE;
 }
 
 static DBusMessage *hrcp_reset(DBusConnection *conn, DBusMessage *msg,
@@ -704,13 +708,17 @@ static DBusMessage *hrcp_reset(DBusConnection *conn, DBusMessage *msg,
 }
 
 static const GDBusMethodTable heartrate_device_methods[] = {
-	{ GDBUS_METHOD("GetProperties",
-			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-			get_properties) },
 	{ GDBUS_METHOD("Reset", NULL, NULL, hrcp_reset) },
 	{ }
 };
 
+static const GDBusPropertyTable heartrate_device_properties[] = {
+	{ "Location", "s", property_get_location, NULL,
+						property_exists_location },
+	{ "ResetSupported", "b", property_get_reset_supported },
+	{ }
+};
+
 int heartrate_adapter_register(struct btd_adapter *adapter)
 {
 	struct heartrate_adapter *hradapter;
@@ -772,8 +780,9 @@ int heartrate_device_register(struct btd_device *device,
 						device_get_path(device),
 						HEART_RATE_INTERFACE,
 						heartrate_device_methods,
-						NULL, NULL, hr,
-						destroy_heartrate)) {
+						NULL,
+						heartrate_device_properties,
+						hr, destroy_heartrate)) {
 		error("D-Bus failed to register %s interface",
 						HEART_RATE_INTERFACE);
 		destroy_heartrate(hr);
diff --git a/test/test-heartrate b/test/test-heartrate
index 316375d..a7d05b4 100755
--- a/test/test-heartrate
+++ b/test/test-heartrate
@@ -80,7 +80,10 @@ if __name__ == "__main__":
 
 	watcher = Watcher(bus, path)
 
-	properties = heartrate.GetProperties()
+	dev_prop = dbus.Interface(bus.get_object("org.bluez", device_path),
+					"org.freedesktop.DBus.Properties")
+
+	properties = dev_prop.GetAll("org.bluez.HeartRate")
 
 	if "Location" in properties:
 		print("Sensor location: %s" % properties["Location"])
-- 
1.7.11.3

