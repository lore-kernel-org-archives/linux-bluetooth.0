Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Per Thomas Jahr <perja@extern.uio.no>
To: linux-bluetooth@vger.kernel.org
Cc: Per Thomas Jahr <perja@extern.uio.no>
Subject: [PATCH BlueZ v2] client: Include UUID when listing attributes
Date: Mon, 29 Aug 2016 14:10:58 +0200
Message-Id: <1472472658-3518-1-git-send-email-perja@extern.uio.no>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Show the full UUID for services, characteristics and descriptors.

Example output with this change:

[NEW] Primary Service
	/org/bluez/hci0/dev_D1_6E_07_45_B2_36/service0008
	00001801-0000-1000-8000-00805f9b34fb
	Generic Attribute Profile
---
 client/gatt.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index fee1cf9..2dc455f 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -75,13 +75,13 @@ static void print_service(GDBusProxy *proxy, const char *description)
 	if (!text)
 		text = uuid;
 
-	rl_printf("%s%s%s%s Service\n\t%s\n\t%s\n",
+	rl_printf("%s%s%s%s Service\n\t%s\n\t%s\n\t%s\n",
 				description ? "[" : "",
 				description ? : "",
 				description ? "] " : "",
 				primary ? "Primary" : "Secondary",
 				g_dbus_proxy_get_path(proxy),
-				text);
+				uuid, text);
 }
 
 void gatt_add_service(GDBusProxy *proxy)
@@ -118,12 +118,12 @@ static void print_characteristic(GDBusProxy *proxy, const char *description)
 	if (!text)
 		text = uuid;
 
-	rl_printf("%s%s%sCharacteristic\n\t%s\n\t%s\n",
+	rl_printf("%s%s%sCharacteristic\n\t%s\n\t%s\n\t%s\n",
 				description ? "[" : "",
 				description ? : "",
 				description ? "] " : "",
 				g_dbus_proxy_get_path(proxy),
-				text);
+				uuid, text);
 }
 
 static gboolean characteristic_is_child(GDBusProxy *characteristic)
@@ -186,12 +186,12 @@ static void print_descriptor(GDBusProxy *proxy, const char *description)
 	if (!text)
 		text = uuid;
 
-	rl_printf("%s%s%sDescriptor\n\t%s\n\t%s\n",
+	rl_printf("%s%s%sDescriptor\n\t%s\n\t%s\n\t%s\n",
 				description ? "[" : "",
 				description ? : "",
 				description ? "] " : "",
 				g_dbus_proxy_get_path(proxy),
-				text);
+				uuid, text);
 }
 
 static gboolean descriptor_is_child(GDBusProxy *characteristic)
-- 
2.5.5

