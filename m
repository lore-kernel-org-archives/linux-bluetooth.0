Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 03/12] client: Add support for GattDescriptor1
Date: Fri,  6 Feb 2015 13:03:35 +0200
Message-Id: <1423220624-18861-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1423220624-18861-1-git-send-email-luiz.dentz@gmail.com>
References: <1423220624-18861-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This add support for GattDescriptor1 interface detection and
prints when they are added or removed.
---
 client/gatt.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 client/gatt.h |  3 +++
 client/main.c |  4 ++++
 3 files changed, 73 insertions(+)

diff --git a/client/gatt.c b/client/gatt.c
index 8fd113f..47785a8 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -47,6 +47,7 @@
 
 static GList *services;
 static GList *characteristics;
+static GList *descriptors;
 
 static void print_service(GDBusProxy *proxy, const char *description)
 {
@@ -154,3 +155,68 @@ void gatt_remove_characteristic(GDBusProxy *proxy)
 
 	print_characteristic(proxy, COLORED_DEL);
 }
+
+static void print_descriptor(GDBusProxy *proxy, const char *description)
+{
+	DBusMessageIter iter;
+	const char *uuid, *text;
+
+	if (g_dbus_proxy_get_property(proxy, "UUID", &iter) == FALSE)
+		return;
+
+	dbus_message_iter_get_basic(&iter, &uuid);
+
+	text = uuidstr_to_str(uuid);
+	if (!text)
+		text = uuid;
+
+	rl_printf("%s%s%sDescriptor %s %s\n",
+				description ? "[" : "",
+				description ? : "",
+				description ? "] " : "",
+				g_dbus_proxy_get_path(proxy),
+				text);
+}
+
+static gboolean descriptor_is_child(GDBusProxy *characteristic)
+{
+	GList *l;
+	DBusMessageIter iter;
+	const char *service, *path;
+
+	if (!g_dbus_proxy_get_property(characteristic, "Characteristic", &iter))
+		return FALSE;
+
+	dbus_message_iter_get_basic(&iter, &service);
+
+	for (l = characteristics; l; l = g_list_next(l)) {
+		GDBusProxy *proxy = l->data;
+
+		path = g_dbus_proxy_get_path(proxy);
+
+		if (!strcmp(path, service))
+			return TRUE;
+	}
+
+	return FALSE;
+}
+
+void gatt_add_descriptor(GDBusProxy *proxy)
+{
+	if (!descriptor_is_child(proxy))
+		return;
+
+	descriptors = g_list_append(descriptors, proxy);
+
+	print_descriptor(proxy, COLORED_NEW);
+}
+
+void gatt_remove_descriptor(GDBusProxy *proxy)
+{
+	if (!descriptor_is_child(proxy))
+		return;
+
+	descriptors = g_list_remove(descriptors, proxy);
+
+	print_descriptor(proxy, COLORED_DEL);
+}
diff --git a/client/gatt.h b/client/gatt.h
index 924c4d9..8b30668 100644
--- a/client/gatt.h
+++ b/client/gatt.h
@@ -26,3 +26,6 @@ void gatt_remove_service(GDBusProxy *proxy);
 
 void gatt_add_characteristic(GDBusProxy *proxy);
 void gatt_remove_characteristic(GDBusProxy *proxy);
+
+void gatt_add_descriptor(GDBusProxy *proxy);
+void gatt_remove_descriptor(GDBusProxy *proxy);
diff --git a/client/main.c b/client/main.c
index 3db18af..0590266 100644
--- a/client/main.c
+++ b/client/main.c
@@ -340,6 +340,8 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
 			gatt_add_service(proxy);
 	} else if (!strcmp(interface, "org.bluez.GattCharacteristic1")) {
 		gatt_add_characteristic(proxy);
+	} else if (!strcmp(interface, "org.bluez.GattDescriptor1")) {
+		gatt_add_descriptor(proxy);
 	}
 }
 
@@ -377,6 +379,8 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 			gatt_remove_service(proxy);
 	} else if (!strcmp(interface, "org.bluez.GattCharacteristic1")) {
 		gatt_remove_characteristic(proxy);
+	} else if (!strcmp(interface, "org.bluez.GattDescriptor1")) {
+		gatt_remove_descriptor(proxy);
 	}
 }
 
-- 
2.1.0

