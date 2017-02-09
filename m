Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: mcchou@chromium.org
To: linux-bluetooth@vger.kernel.org
Cc: luiz.von.dentz@intel.com, josephsih@chromium.org,
        ortuno@chromium.org, Eric Caruso <ejcaruso@chromium.org>
Subject: [PATCH] device: Add device type property
Date: Wed,  8 Feb 2017 17:05:08 -0800
Message-Id: <20170209010508.150518-1-mcchou@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eric Caruso <ejcaruso@chromium.org>

This allows us to gather information about whether a device
supports BR/EDR, BLE, or both. It appears as DBus Property
"Type" on the org.bluez.Device1 interface.

This is tested with the following steps:
Scan for devices and request the type property of a specific remote device,
using:
  # dbus-send --print-reply --system --dest=org.bluez <obj path> \
    org.freedesktop.DBus.Properties.Get \
      string:org.bluez.Device1 string:Type
or request the type of all remote devices, using:
  # dbus-send --print-reply --system --dest=org.bluez / \
    org.freedesktop.DBus.ObjectManager.GetManagedObjects | \
      grep -B1 -A2 Type
and check for "BR/EDR", "LE", and "DUAL"
---
 doc/device-api.txt |  5 +++++
 src/device.c       | 31 +++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index 13b28818e..2f3100cd5 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -141,6 +141,11 @@ Properties	string Address [readonly]

 			The Bluetooth class of device of the remote device.

+		string Type [readonly, optional]
+
+			The carriers supported by this remote device. If it
+			exists, it can be one of "BR/EDR", "LE", or "DUAL".
+
 		uint16 Appearance [readonly, optional]

 			External appearance of device, as found on GAP service.
diff --git a/src/device.c b/src/device.c
index 8693eb826..14c62e127 100644
--- a/src/device.c
+++ b/src/device.c
@@ -788,6 +788,35 @@ static gboolean dev_property_get_class(const GDBusPropertyTable *property,
 	return TRUE;
 }

+static gboolean dev_property_exists_type(const GDBusPropertyTable *property,
+								void *data)
+{
+	struct btd_device *device = data;
+
+	return device->bredr || device->le;
+}
+
+static gboolean dev_property_get_type(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+	const char *type;
+
+	if (!device->bredr && !device->le)
+		return FALSE;
+
+	if (!device->bredr)
+		type = "LE";
+	else if (!device->le)
+		type = "BR/EDR";
+	else
+		type = "DUAL";
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &type);
+
+	return TRUE;
+}
+
 static gboolean get_appearance(const GDBusPropertyTable *property, void *data,
 							uint16_t *appearance)
 {
@@ -2541,6 +2570,8 @@ static const GDBusPropertyTable device_properties[] = {
 	{ "Alias", "s", dev_property_get_alias, dev_property_set_alias },
 	{ "Class", "u", dev_property_get_class, NULL,
 					dev_property_exists_class },
+	{ "Type", "s", dev_property_get_type, NULL,
+					dev_property_exists_type },
 	{ "Appearance", "q", dev_property_get_appearance, NULL,
 					dev_property_exists_appearance },
 	{ "Icon", "s", dev_property_get_icon, NULL,
--
2.11.0.483.g087da7b7c-goog

