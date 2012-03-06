Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 3/3] core: Add Interfaces property to org.bluez.Device
Date: Tue,  6 Mar 2012 14:07:38 +0200
Message-Id: <1331035658-10000-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1331035658-10000-1-git-send-email-luiz.dentz@gmail.com>
References: <1331035658-10000-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables applications to be able to detect when an interface is
enabled/disabled without depending on UUIDs.
---
 doc/device-api.txt |    4 ++++
 src/device.c       |   27 ++++++++++++++++++++++-----
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/doc/device-api.txt b/doc/device-api.txt
index e8fc314..2531d05 100644
--- a/doc/device-api.txt
+++ b/doc/device-api.txt
@@ -209,3 +209,7 @@ Properties	string Address [readonly]
 			Note that this property can exhibit false-positives
 			in the case of Bluetooth 2.1 (or newer) devices that
 			have disabled Extended Inquiry Response support.
+
+		array{string} Interfaces [readonly]
+
+			List of supported interface by the object.
diff --git a/src/device.c b/src/device.c
index dfc8e59..32527da 100644
--- a/src/device.c
+++ b/src/device.c
@@ -410,6 +410,14 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	dict_append_array(&dict, "UUIDs", DBUS_TYPE_STRING, &str, i);
 	g_free(str);
 
+	/* Interfaces */
+	str = g_dbus_list_interfaces(conn, device->path, &i);
+	if (str != NULL) {
+		dict_append_array(&dict, "Interfaces", DBUS_TYPE_STRING, &str,
+									i);
+		g_strfreev(str);
+	}
+
 	/* Services */
 	str = g_new0(char *, g_slist_length(device->services) + 1);
 	for (i = 0, l = device->services; l; l = l->next, i++)
@@ -1379,18 +1387,27 @@ static void device_remove_drivers(struct btd_device *device, GSList *uuids)
 static void services_changed(struct btd_device *device)
 {
 	DBusConnection *conn = get_dbus_connection();
-	char **uuids;
+	char **array;
 	GSList *l;
 	int i;
 
-	uuids = g_new0(char *, g_slist_length(device->uuids) + 1);
+	array = g_new0(char *, g_slist_length(device->uuids) + 1);
 	for (i = 0, l = device->uuids; l; l = l->next, i++)
-		uuids[i] = l->data;
+		array[i] = l->data;
 
 	emit_array_property_changed(conn, device->path, DEVICE_INTERFACE,
-					"UUIDs", DBUS_TYPE_STRING, &uuids, i);
+					"UUIDs", DBUS_TYPE_STRING, &array, i);
+
+	g_free(array);
+
+	array = g_dbus_list_interfaces(conn, device->path, &i);
+	if (array == NULL)
+		return;
 
-	g_free(uuids);
+	emit_array_property_changed(conn, device->path,
+					DEVICE_INTERFACE, "Interfaces",
+					DBUS_TYPE_STRING, &array, i);
+	g_strfreev(array);
 }
 
 static int rec_cmp(const void *a, const void *b)
-- 
1.7.7.6

