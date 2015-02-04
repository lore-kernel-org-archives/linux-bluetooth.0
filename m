Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 2/9] client: Add support for GattCharacteristic1
Date: Wed,  4 Feb 2015 17:33:12 +0200
Message-Id: <1423063999-15734-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1423063999-15734-1-git-send-email-luiz.dentz@gmail.com>
References: <1423063999-15734-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This add support for GattCharacteristici1 interface detection and
prints when they are added or removed
---
 client/gatt.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 client/gatt.h |  3 +++
 client/main.c |  4 ++++
 3 files changed, 73 insertions(+)

diff --git a/client/gatt.c b/client/gatt.c
index 7de5c7b..8fd113f 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -46,6 +46,7 @@
 #define COLORED_DEL	COLOR_RED "DEL" COLOR_OFF
 
 static GList *services;
+static GList *characteristics;
 
 static void print_service(GDBusProxy *proxy, const char *description)
 {
@@ -88,3 +89,68 @@ void gatt_remove_service(GDBusProxy *proxy)
 
 	print_service(proxy, COLORED_DEL);
 }
+
+static void print_characteristic(GDBusProxy *proxy, const char *description)
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
+	rl_printf("%s%s%sCharacteristic %s %s\n",
+				description ? "[" : "",
+				description ? : "",
+				description ? "] " : "",
+				g_dbus_proxy_get_path(proxy),
+				text);
+}
+
+static gboolean characteristic_is_child(GDBusProxy *characteristic)
+{
+	GList *l;
+	DBusMessageIter iter;
+	const char *service, *path;
+
+	if (!g_dbus_proxy_get_property(characteristic, "Service", &iter))
+		return FALSE;
+
+	dbus_message_iter_get_basic(&iter, &service);
+
+	for (l = services; l; l = g_list_next(l)) {
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
+void gatt_add_characteristic(GDBusProxy *proxy)
+{
+	if (!characteristic_is_child(proxy))
+		return;
+
+	characteristics = g_list_append(characteristics, proxy);
+
+	print_characteristic(proxy, COLORED_NEW);
+}
+
+void gatt_remove_characteristic(GDBusProxy *proxy)
+{
+	if (!characteristic_is_child(proxy))
+		return;
+
+	characteristics = g_list_remove(characteristics, proxy);
+
+	print_characteristic(proxy, COLORED_DEL);
+}
diff --git a/client/gatt.h b/client/gatt.h
index f049039..924c4d9 100644
--- a/client/gatt.h
+++ b/client/gatt.h
@@ -23,3 +23,6 @@
 
 void gatt_add_service(GDBusProxy *proxy);
 void gatt_remove_service(GDBusProxy *proxy);
+
+void gatt_add_characteristic(GDBusProxy *proxy);
+void gatt_remove_characteristic(GDBusProxy *proxy);
diff --git a/client/main.c b/client/main.c
index ab644ba..3db18af 100644
--- a/client/main.c
+++ b/client/main.c
@@ -338,6 +338,8 @@ static void proxy_added(GDBusProxy *proxy, void *user_data)
 	} else if (!strcmp(interface, "org.bluez.GattService1")) {
 		if (service_is_child(proxy))
 			gatt_add_service(proxy);
+	} else if (!strcmp(interface, "org.bluez.GattCharacteristic1")) {
+		gatt_add_characteristic(proxy);
 	}
 }
 
@@ -373,6 +375,8 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 	} else if (!strcmp(interface, "org.bluez.GattService1")) {
 		if (service_is_child(proxy))
 			gatt_remove_service(proxy);
+	} else if (!strcmp(interface, "org.bluez.GattCharacteristic1")) {
+		gatt_remove_characteristic(proxy);
 	}
 }
 
-- 
2.1.0

