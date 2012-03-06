Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ 2/3] core: Add Interfaces property to org.bluez.Adapter
Date: Tue,  6 Mar 2012 14:07:37 +0200
Message-Id: <1331035658-10000-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1331035658-10000-1-git-send-email-luiz.dentz@gmail.com>
References: <1331035658-10000-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables applications to be able to detect when some specific
such as org.bluez.Media is available so they don't have to guess based
on UUIDs.
---
 doc/adapter-api.txt |    4 ++++
 src/adapter.c       |   21 +++++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
index 20cef03..89688de 100644
--- a/doc/adapter-api.txt
+++ b/doc/adapter-api.txt
@@ -284,3 +284,7 @@ Properties	string Address [readonly]
 
 			List of 128-bit UUIDs that represents the available
 			local services.
+
+		array{string} Interfaces [readonly]
+
+			List of supported interface by the object.
diff --git a/src/adapter.c b/src/adapter.c
index c5f4d0d..b6424a1 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1077,7 +1077,7 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	DBusMessageIter dict;
 	char srcaddr[18];
 	gboolean value;
-	char **devices, **uuids;
+	char **devices, **uuids, **ifaces;
 	int i;
 	GSList *l;
 	sdp_list_t *list;
@@ -1162,6 +1162,14 @@ static DBusMessage *get_properties(DBusConnection *conn,
 
 	g_strfreev(uuids);
 
+	/* Interfaces */
+	ifaces = g_dbus_list_interfaces(connection, adapter->path, &i);
+	if (ifaces != NULL) {
+		dict_append_array(&dict, "Interfaces", DBUS_TYPE_STRING,
+								&ifaces, i);
+		g_strfreev(ifaces);
+	}
+
 	dbus_message_iter_close_container(&iter, &dict);
 
 	return reply;
@@ -2023,7 +2031,8 @@ static void clear_blocked(struct btd_adapter *adapter)
 static void probe_driver(struct btd_adapter *adapter, gpointer user_data)
 {
 	struct btd_adapter_driver *driver = user_data;
-	int err;
+	int err, count;
+	char **ifaces;
 
 	if (!adapter->up)
 		return;
@@ -2039,6 +2048,14 @@ static void probe_driver(struct btd_adapter *adapter, gpointer user_data)
 
 	adapter->loaded_drivers = g_slist_prepend(adapter->loaded_drivers,
 									driver);
+
+	ifaces = g_dbus_list_interfaces(connection, adapter->path, &count);
+	if (ifaces != NULL) {
+		emit_array_property_changed(connection, adapter->path,
+					ADAPTER_INTERFACE, "Interfaces",
+					DBUS_TYPE_STRING, &ifaces, count);
+		g_strfreev(ifaces);
+	}
 }
 
 static void load_drivers(struct btd_adapter *adapter)
-- 
1.7.7.6

