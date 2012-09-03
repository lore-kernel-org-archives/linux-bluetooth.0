Return-Path: <cyrus@holtmann.org>
From: <chen.ganir@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <chen.ganir@ti.com>
Subject: [PATCH v5] gatt: Translate Characteristic names
Date: Mon, 3 Sep 2012 16:20:03 +0300
Message-ID: <1346678403-14322-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Translate Characteristic UUID's to name. This list was taken from
the Bluetooth SIG developer site.
---
 attrib/client.c |   78 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 75 insertions(+), 3 deletions(-)

diff --git a/attrib/client.c b/attrib/client.c
index 906d345..479aac3 100644
--- a/attrib/client.c
+++ b/attrib/client.c
@@ -106,8 +106,79 @@ struct watcher {
 	struct gatt_service *gatt;
 };
 
+struct characteristic_info {
+	const char *uuid;
+	const char *name;
+};
+
+static const struct characteristic_info charInfo[] = {
+	{ "00002a43-0000-1000-8000-00805f9b34fb", "Alert Category ID" },
+	{ "00002a42-0000-1000-8000-00805f9b34fb", "Alert Category ID Bit Mask" },
+	{ "00002a06-0000-1000-8000-00805f9b34fb", "Alert Level" },
+	{ "00002a44-0000-1000-8000-00805f9b34fb", "Alert Notification Control Point" },
+	{ "00002a3f-0000-1000-8000-00805f9b34fb", "Alert Status" },
+	{ "00002a01-0000-1000-8000-00805f9b34fb", "Appearance" },
+	{ "00002a49-0000-1000-8000-00805f9b34fb", "Blood Pressure Feature" },
+	{ "00002a35-0000-1000-8000-00805f9b34fb", "Blood Pressure Measurement" },
+	{ "00002a38-0000-1000-8000-00805f9b34fb", "Body Sensor Location" },
+	{ "00002a2b-0000-1000-8000-00805f9b34fb", "Current Time" },
+	{ "00002a08-0000-1000-8000-00805f9b34fb", "Date Time" },
+	{ "00002a0a-0000-1000-8000-00805f9b34fb", "Day Date Time" },
+	{ "00002a09-0000-1000-8000-00805f9b34fb", "Day of Week" },
+	{ "00002a00-0000-1000-8000-00805f9b34fb", "Device Name" },
+	{ "00002a0d-0000-1000-8000-00805f9b34fb", "DST Offset" },
+	{ "00002a0c-0000-1000-8000-00805f9b34fb", "Exact Time 256" },
+	{ "00002a26-0000-1000-8000-00805f9b34fb", "Firmware Revision String" },
+	{ "00002a27-0000-1000-8000-00805f9b34fb", "Hardware Revision String" },
+	{ "00002a39-0000-1000-8000-00805f9b34fb", "Heart Rate Control Point" },
+	{ "00002a37-0000-1000-8000-00805f9b34fb", "Heart Rate Measurement" },
+	{ "00002a2a-0000-1000-8000-00805f9b34fb", "IEEE 11073-20601 Regulatory" },
+	{ "00002a36-0000-1000-8000-00805f9b34fb", "Intermediate Cuff Pressure" },
+	{ "00002a1e-0000-1000-8000-00805f9b34fb", "Intermediate Temperature" },
+	{ "00002a0f-0000-1000-8000-00805f9b34fb", "Local Time Information" },
+	{ "00002a29-0000-1000-8000-00805f9b34fb", "Manufacturer Name String" },
+	{ "00002a21-0000-1000-8000-00805f9b34fb", "Measurement Interval" },
+	{ "00002a24-0000-1000-8000-00805f9b34fb", "Model Number String" },
+	{ "00002a46-0000-1000-8000-00805f9b34fb", "New Alert" },
+	{ "00002a04-0000-1000-8000-00805f9b34fb", "Peripheral Preferred Connection Parameters" },
+	{ "00002a02-0000-1000-8000-00805f9b34fb", "Peripheral Privacy Flag" },
+	{ "00002a03-0000-1000-8000-00805f9b34fb", "Reconnection Address" },
+	{ "00002a14-0000-1000-8000-00805f9b34fb", "Reference Time Information" },
+	{ "00002a40-0000-1000-8000-00805f9b34fb", "Ringer Control Point" },
+	{ "00002a41-0000-1000-8000-00805f9b34fb", "Ringer Setting" },
+	{ "00002a25-0000-1000-8000-00805f9b34fb", "Serial Number String" },
+	{ "00002a05-0000-1000-8000-00805f9b34fb", "Service Changed" },
+	{ "00002a28-0000-1000-8000-00805f9b34fb", "Software Revision String" },
+	{ "00002a47-0000-1000-8000-00805f9b34fb", "Supported New Alert Category" },
+	{ "00002a48-0000-1000-8000-00805f9b34fb", "Supported Unread Alert Category" },
+	{ "00002a23-0000-1000-8000-00805f9b34fb", "System ID" },
+	{ "00002a1c-0000-1000-8000-00805f9b34fb", "Temperature Measurement" },
+	{ "00002a1d-0000-1000-8000-00805f9b34fb", "Temperature Type" },
+	{ "00002a12-0000-1000-8000-00805f9b34fb", "Time Accuracy" },
+	{ "00002a13-0000-1000-8000-00805f9b34fb", "Time Source" },
+	{ "00002a16-0000-1000-8000-00805f9b34fb", "Time Update Control Point" },
+	{ "00002a17-0000-1000-8000-00805f9b34fb", "Time Update State" },
+	{ "00002a11-0000-1000-8000-00805f9b34fb", "Time with DST" },
+	{ "00002a0e-0000-1000-8000-00805f9b34fb", "Time Zone" },
+	{ "00002a07-0000-1000-8000-00805f9b34fb", "Tx Power Level" },
+	{ "00002a45-0000-1000-8000-00805f9b34fb", "Unread Alert Status" },
+	{ }
+};
+
 static GSList *gatt_services = NULL;
 
+static const char *get_char_name(const char *uuid)
+{
+	const struct characteristic_info *c;
+
+	for (c = charInfo; c->uuid; c++) {
+		if (bt_uuid_strcmp(c->uuid, uuid) == 0)
+			return c->name;
+	}
+
+	return NULL;
+}
+
 static void characteristic_free(void *user_data)
 {
 	struct characteristic *chr = user_data;
@@ -191,7 +262,7 @@ static int watcher_cmp(gconstpointer a, gconstpointer b)
 static void append_char_dict(DBusMessageIter *iter, struct characteristic *chr)
 {
 	DBusMessageIter dict;
-	const char *name = "";
+	const char *name;
 	char *uuid;
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
@@ -203,8 +274,9 @@ static void append_char_dict(DBusMessageIter *iter, struct characteristic *chr)
 	dict_append_entry(&dict, "UUID", DBUS_TYPE_STRING, &uuid);
 	g_free(uuid);
 
-	/* FIXME: Translate UUID to name. */
-	dict_append_entry(&dict, "Name", DBUS_TYPE_STRING, &name);
+	name = get_char_name(chr->type);
+	if (name)
+		dict_append_entry(&dict, "Name", DBUS_TYPE_STRING, &name);
 
 	if (chr->desc)
 		dict_append_entry(&dict, "Description", DBUS_TYPE_STRING,
-- 
1.7.9.5

