Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Francois Beaufort <beaufort.francois@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] client: Show UUIDs when listing services, characteristics and descriptors.
Date: Tue, 20 Sep 2016 15:13:37 +0200
Message-Id: <20160920131337.19494-3-beaufort.francois@gmail.com>
In-Reply-To: <20160920131337.19494-1-beaufort.francois@gmail.com>
References: <20160920131337.19494-1-beaufort.francois@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Example output after this patch:

[bluetooth]# connect 7B:3F:2C:2B:D0:06
Attempting to connect to 7B:3F:2C:2B:D0:06
[CHG] Device 7B:3F:2C:2B:D0:06 Connected: yes
Connection successful
[NEW] Primary Service
        /org/bluez/hci0/dev_7B_3F_2C_2B_D0_06/service0001
        00001801-0000-1000-8000-00805f9b34fb
        Generic Attribute Profile
[NEW] Characteristic
        /org/bluez/hci0/dev_7B_3F_2C_2B_D0_06/service0001/char0002
        00002a05-0000-1000-8000-00805f9b34fb
        Service Changed
[NEW] Primary Service
        /org/bluez/hci0/dev_7B_3F_2C_2B_D0_06/service0028
        0000180f-0000-1000-8000-00805f9b34fb
        Battery Service
[NEW] Characteristic
        /org/bluez/hci0/dev_7B_3F_2C_2B_D0_06/service0028/char0029
        00002a19-0000-1000-8000-00805f9b34fb
        Battery Level
[NEW] Descriptor
        /org/bluez/hci0/dev_7B_3F_2C_2B_D0_06/service0028/char0029/desc002b
        00002902-0000-1000-8000-00805f9b34fb
        Client Characteristic Configuration
[CHG] Device 7B:3F:2C:2B:D0:06 UUIDs: 00001800-0000-1000-8000-00805f9b34fb
[CHG] Device 7B:3F:2C:2B:D0:06 UUIDs: 00001801-0000-1000-8000-00805f9b34fb
[CHG] Device 7B:3F:2C:2B:D0:06 UUIDs: 0000180f-0000-1000-8000-00805f9b34fb
[CHG] Device 7B:3F:2C:2B:D0:06 ServicesResolved: yes
---
 client/gatt.c | 75 +++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 47 insertions(+), 28 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index fee1cf9..e6159bc 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -72,16 +72,23 @@ static void print_service(GDBusProxy *proxy, const char *description)
 	dbus_message_iter_get_basic(&iter, &primary);
 
 	text = uuidstr_to_str(uuid);
-	if (!text)
-		text = uuid;
-
-	rl_printf("%s%s%s%s Service\n\t%s\n\t%s\n",
-				description ? "[" : "",
-				description ? : "",
-				description ? "] " : "",
-				primary ? "Primary" : "Secondary",
-				g_dbus_proxy_get_path(proxy),
-				text);
+	if (!text) {
+		rl_printf("%s%s%s%s Service\n\t%s\n\t%s\n",
+					description ? "[" : "",
+					description ? : "",
+					description ? "] " : "",
+					primary ? "Primary" : "Secondary",
+					g_dbus_proxy_get_path(proxy),
+					uuid);
+	} else {
+		rl_printf("%s%s%s%s Service\n\t%s\n\t%s\n\t%s\n",
+					description ? "[" : "",
+					description ? : "",
+					description ? "] " : "",
+					primary ? "Primary" : "Secondary",
+					g_dbus_proxy_get_path(proxy),
+					uuid, text);
+	}
 }
 
 void gatt_add_service(GDBusProxy *proxy)
@@ -115,15 +122,21 @@ static void print_characteristic(GDBusProxy *proxy, const char *description)
 	dbus_message_iter_get_basic(&iter, &uuid);
 
 	text = uuidstr_to_str(uuid);
-	if (!text)
-		text = uuid;
-
-	rl_printf("%s%s%sCharacteristic\n\t%s\n\t%s\n",
-				description ? "[" : "",
-				description ? : "",
-				description ? "] " : "",
-				g_dbus_proxy_get_path(proxy),
-				text);
+	if (!text) {
+		rl_printf("%s%s%sCharacteristic\n\t%s\n\t%s\n",
+					description ? "[" : "",
+					description ? : "",
+					description ? "] " : "",
+					g_dbus_proxy_get_path(proxy),
+					uuid);
+	} else {
+		rl_printf("%s%s%sCharacteristic\n\t%s\n\t%s\n\t%s\n",
+					description ? "[" : "",
+					description ? : "",
+					description ? "] " : "",
+					g_dbus_proxy_get_path(proxy),
+					uuid, text);
+	}
 }
 
 static gboolean characteristic_is_child(GDBusProxy *characteristic)
@@ -183,15 +196,21 @@ static void print_descriptor(GDBusProxy *proxy, const char *description)
 	dbus_message_iter_get_basic(&iter, &uuid);
 
 	text = uuidstr_to_str(uuid);
-	if (!text)
-		text = uuid;
-
-	rl_printf("%s%s%sDescriptor\n\t%s\n\t%s\n",
-				description ? "[" : "",
-				description ? : "",
-				description ? "] " : "",
-				g_dbus_proxy_get_path(proxy),
-				text);
+	if (!text) {
+		rl_printf("%s%s%sDescriptor\n\t%s\n\t%s\n",
+					description ? "[" : "",
+					description ? : "",
+					description ? "] " : "",
+					g_dbus_proxy_get_path(proxy),
+					uuid);
+	} else {
+		rl_printf("%s%s%sDescriptor\n\t%s\n\t%s\n\t%s\n",
+					description ? "[" : "",
+					description ? : "",
+					description ? "] " : "",
+					g_dbus_proxy_get_path(proxy),
+					uuid, text);
+	}
 }
 
 static gboolean descriptor_is_child(GDBusProxy *characteristic)
-- 
2.10.0

