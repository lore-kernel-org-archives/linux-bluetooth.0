Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] client: Fix crash when exiting
Date: Thu, 12 Nov 2015 16:13:33 +0200
Message-Id: <1447337613-2214-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When exiting the available proxies are destroy in the same order they are
added causing the following crash when there are attributes whose service
has already been removed:

Invalid read of size 8
   at 0x414AAD: g_dbus_proxy_get_path (client.c:525)
   by 0x40B948: characteristic_is_child (gatt.c:136)
   by 0x40C420: gatt_remove_characteristic (gatt.c:157)
   by 0x4067A7: proxy_removed (main.c:446)
   by 0x414A2E: proxy_free (client.c:439)
   by 0x4E7AF6C: g_list_foreach (in /usr/lib64/libglib-2.0.so.0.4400.1)
   by 0x4E7AF8A: g_list_free_full (in /usr/lib64/libglib-2.0.so.0.4400.1)
   by 0x415D54: g_dbus_client_unref (client.c:1310)
   by 0x40511B: main (main.c:2067)
 Address 0x5eb5450 is 16 bytes inside a block of size 80 free'd
   at 0x4C29D6A: free (in /usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x4E8479E: g_free (in /usr/lib64/libglib-2.0.so.0.4400.1)
   by 0x4149D6: g_dbus_proxy_unref (client.c:517)
   by 0x414A8D: proxy_free (client.c:451)
   by 0x4E7AF6C: g_list_foreach (in /usr/lib64/libglib-2.0.so.0.4400.1)
   by 0x4E7AF8A: g_list_free_full (in /usr/lib64/libglib-2.0.so.0.4400.1)
   by 0x415D54: g_dbus_client_unref (client.c:1310)
   by 0x40511B: main (main.c:2067)
---
 client/gatt.c | 22 +++++++++++++++++-----
 client/main.c |  8 +++-----
 2 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index 0a3adb8..0617393 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -92,7 +92,13 @@ void gatt_add_service(GDBusProxy *proxy)
 
 void gatt_remove_service(GDBusProxy *proxy)
 {
-	services = g_list_remove(services, proxy);
+	GList *l;
+
+	l = g_list_find(services, proxy);
+	if (!l)
+		return;
+
+	services = g_list_delete_link(services, l);
 
 	print_service(proxy, COLORED_DEL);
 }
@@ -154,10 +160,13 @@ void gatt_add_characteristic(GDBusProxy *proxy)
 
 void gatt_remove_characteristic(GDBusProxy *proxy)
 {
-	if (!characteristic_is_child(proxy))
+	GList *l;
+
+	l = g_list_find(characteristics, proxy);
+	if (!l)
 		return;
 
-	characteristics = g_list_remove(characteristics, proxy);
+	characteristics = g_list_delete_link(characteristics, l);
 
 	print_characteristic(proxy, COLORED_DEL);
 }
@@ -219,10 +228,13 @@ void gatt_add_descriptor(GDBusProxy *proxy)
 
 void gatt_remove_descriptor(GDBusProxy *proxy)
 {
-	if (!descriptor_is_child(proxy))
+	GList *l;
+
+	l = g_list_find(descriptors, proxy);
+	if (!l)
 		return;
 
-	descriptors = g_list_remove(descriptors, proxy);
+	descriptors = g_list_delete_link(descriptors, l);
 
 	print_descriptor(proxy, COLORED_DEL);
 }
diff --git a/client/main.c b/client/main.c
index 6863593..731da7a 100644
--- a/client/main.c
+++ b/client/main.c
@@ -436,12 +436,10 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 				agent_unregister(dbus_conn, NULL);
 		}
 	} else if (!strcmp(interface, "org.bluez.GattService1")) {
-		if (service_is_child(proxy)) {
-			gatt_remove_service(proxy);
+		gatt_remove_service(proxy);
 
-			if (default_attr == proxy)
-				set_default_attribute(NULL);
-		}
+		if (default_attr == proxy)
+			set_default_attribute(NULL);
 	} else if (!strcmp(interface, "org.bluez.GattCharacteristic1")) {
 		gatt_remove_characteristic(proxy);
 
-- 
2.4.3

