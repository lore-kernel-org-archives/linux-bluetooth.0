Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 2/8] client: Use g_dbus_proxy_lookup()
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <6f0b4053-4936-8d8c-3095-d6326d9a0e93@jp.fujitsu.com>
Message-ID: <797e7584-9a2b-76fe-5743-5f6dea873967@jp.fujitsu.com>
Date: Fri, 22 Dec 2017 16:35:35 +0900
MIME-Version: 1.0
In-Reply-To: <6f0b4053-4936-8d8c-3095-d6326d9a0e93@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/gatt.c | 37 ++++++++-----------------------------
 client/main.c | 15 +++------------
 2 files changed, 11 insertions(+), 41 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index 224a78a13..cdf14363c 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -206,25 +206,16 @@ static void print_characteristic(GDBusProxy *proxy, const char *description)
 
 static gboolean chrc_is_child(GDBusProxy *characteristic)
 {
-	GList *l;
 	DBusMessageIter iter;
-	const char *service, *path;
+	const char *service;
 
 	if (!g_dbus_proxy_get_property(characteristic, "Service", &iter))
 		return FALSE;
 
 	dbus_message_iter_get_basic(&iter, &service);
 
-	for (l = services; l; l = g_list_next(l)) {
-		GDBusProxy *proxy = l->data;
-
-		path = g_dbus_proxy_get_path(proxy);
-
-		if (!strcmp(path, service))
-			return TRUE;
-	}
-
-	return FALSE;
+	return g_dbus_proxy_lookup(services, service,
+					"org.bluez.GattService1") != NULL;
 }
 
 void gatt_add_characteristic(GDBusProxy *proxy)
@@ -378,33 +369,21 @@ void gatt_list_attributes(const char *path)
 	list_attributes(path, services);
 }
 
-static GDBusProxy *select_proxy(const char *path, GList *source)
-{
-	GList *l;
-
-	for (l = source; l; l = g_list_next(l)) {
-		GDBusProxy *proxy = l->data;
-
-		if (strcmp(path, g_dbus_proxy_get_path(proxy)) == 0)
-			return proxy;
-	}
-
-	return NULL;
-}
-
 static GDBusProxy *select_attribute(const char *path)
 {
 	GDBusProxy *proxy;
 
-	proxy = select_proxy(path, services);
+	proxy = g_dbus_proxy_lookup(services, path, "org.bluez.GattService1");
 	if (proxy)
 		return proxy;
 
-	proxy = select_proxy(path, characteristics);
+	proxy = g_dbus_proxy_lookup(characteristics, path,
+					"org.bluez.GattCharacteristic1");
 	if (proxy)
 		return proxy;
 
-	return select_proxy(path, descriptors);
+	return g_dbus_proxy_lookup(descriptors, path,
+						"org.bluez.GattDescriptor1");
 }
 
 static GDBusProxy *select_proxy_by_uuid(GDBusProxy *parent, const char *uuid,
diff --git a/client/main.c b/client/main.c
index 26d99d6ed..3d8f1f5f4 100644
--- a/client/main.c
+++ b/client/main.c
@@ -392,9 +392,8 @@ static gboolean device_is_child(GDBusProxy *device, GDBusProxy *master)
 
 static gboolean service_is_child(GDBusProxy *service)
 {
-	GList *l;
 	DBusMessageIter iter;
-	const char *device, *path;
+	const char *device;
 
 	if (g_dbus_proxy_get_property(service, "Device", &iter) == FALSE)
 		return FALSE;
@@ -404,16 +403,8 @@ static gboolean service_is_child(GDBusProxy *service)
 	if (!default_ctrl)
 		return FALSE;
 
-	for (l = default_ctrl->devices; l; l = g_list_next(l)) {
-		struct GDBusProxy *proxy = l->data;
-
-		path = g_dbus_proxy_get_path(proxy);
-
-		if (!strcmp(path, device))
-			return TRUE;
-	}
-
-	return FALSE;
+	return g_dbus_proxy_lookup(default_ctrl->devices, device,
+					"org.bluez.Device1") != NULL;
 }
 
 static struct adapter *find_parent(GDBusProxy *device)
-- 
2.14.1

