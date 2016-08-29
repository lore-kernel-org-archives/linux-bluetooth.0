Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Per Thomas Jahr <perja@extern.uio.no>
To: linux-bluetooth@vger.kernel.org
Cc: Per Thomas Jahr <perja@extern.uio.no>
Subject: [PATCH BlueZ] client: Include UUID when listing attributes
Date: Mon, 29 Aug 2016 11:14:49 +0200
Message-Id: <1472462089-22900-2-git-send-email-perja@extern.uio.no>
In-Reply-To: <1472462089-22900-1-git-send-email-perja@extern.uio.no>
References: <1472462089-22900-1-git-send-email-perja@extern.uio.no>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Show the full UUID for services, characteristics and descriptors.
---
 client/gatt.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/client/gatt.c b/client/gatt.c
index fee1cf9..201d668 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -75,12 +75,13 @@ static void print_service(GDBusProxy *proxy, const char *description)
 	if (!text)
 		text = uuid;
 
-	rl_printf("%s%s%s%s Service\n\t%s\n\t%s\n",
+        rl_printf("%s%s%s%s Service\n\t%s\n\t%s\n\t%s\n",
 				description ? "[" : "",
 				description ? : "",
 				description ? "] " : "",
 				primary ? "Primary" : "Secondary",
-				g_dbus_proxy_get_path(proxy),
+                                g_dbus_proxy_get_path(proxy),
+                                uuid,
 				text);
 }
 
@@ -118,12 +119,13 @@ static void print_characteristic(GDBusProxy *proxy, const char *description)
 	if (!text)
 		text = uuid;
 
-	rl_printf("%s%s%sCharacteristic\n\t%s\n\t%s\n",
+        rl_printf("%s%s%sCharacteristic\n\t%s\n\t%s\n\t%s\n",
 				description ? "[" : "",
 				description ? : "",
 				description ? "] " : "",
 				g_dbus_proxy_get_path(proxy),
-				text);
+                                uuid,
+                                text);
 }
 
 static gboolean characteristic_is_child(GDBusProxy *characteristic)
@@ -186,12 +188,13 @@ static void print_descriptor(GDBusProxy *proxy, const char *description)
 	if (!text)
 		text = uuid;
 
-	rl_printf("%s%s%sDescriptor\n\t%s\n\t%s\n",
+        rl_printf("%s%s%sDescriptor\n\t%s\n\t%s\n\t%s\n",
 				description ? "[" : "",
 				description ? : "",
 				description ? "] " : "",
 				g_dbus_proxy_get_path(proxy),
-				text);
+                                uuid,
+                                text);
 }
 
 static gboolean descriptor_is_child(GDBusProxy *characteristic)
-- 
2.5.5

