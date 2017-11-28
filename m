Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] client: Fix not printing device address
Date: Tue, 28 Nov 2017 13:42:11 +0200
Message-Id: <20171128114211.20485-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Commands which operate on the connected device shall not assume the
address was passed as argument, instead this move the logic of
retrieving the device address to common place and always uses the proxy
instead of printing the input argument.
---
 client/main.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/client/main.c b/client/main.c
index 7661b33c0..924da2fcd 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1470,6 +1470,17 @@ static void pair_reply(DBusMessage *message, void *user_data)
 	bt_shell_printf("Pairing successful\n");
 }
 
+static const char *device_addr(GDBusProxy *proxy)
+{
+	DBusMessageIter iter;
+	const char *addr = NULL;
+
+	if (g_dbus_proxy_get_property(proxy, "Address", &iter) == TRUE)
+		dbus_message_iter_get_basic(&iter, &addr);
+
+	return addr;
+}
+
 static void cmd_pair(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
@@ -1484,7 +1495,7 @@ static void cmd_pair(int argc, char *argv[])
 		return;
 	}
 
-	bt_shell_printf("Attempting to pair with %s\n", argv[0]);
+	bt_shell_printf("Attempting to pair with %s", device_addr(proxy));
 }
 
 static void cmd_trust(int argc, char *argv[])
@@ -1499,7 +1510,7 @@ static void cmd_trust(int argc, char *argv[])
 
 	trusted = TRUE;
 
-	str = g_strdup_printf("%s trust", argv[0]);
+	str = g_strdup_printf("%s trust", device_addr(proxy));
 
 	if (g_dbus_proxy_set_property_basic(proxy, "Trusted",
 					DBUS_TYPE_BOOLEAN, &trusted,
@@ -1521,7 +1532,7 @@ static void cmd_untrust(int argc, char *argv[])
 
 	trusted = FALSE;
 
-	str = g_strdup_printf("%s untrust", argv[0]);
+	str = g_strdup_printf("%s untrust", device_addr(proxy));
 
 	if (g_dbus_proxy_set_property_basic(proxy, "Trusted",
 					DBUS_TYPE_BOOLEAN, &trusted,
@@ -1543,7 +1554,7 @@ static void cmd_block(int argc, char *argv[])
 
 	blocked = TRUE;
 
-	str = g_strdup_printf("%s block", argv[0]);
+	str = g_strdup_printf("%s block", device_addr(proxy));
 
 	if (g_dbus_proxy_set_property_basic(proxy, "Blocked",
 					DBUS_TYPE_BOOLEAN, &blocked,
@@ -1565,7 +1576,7 @@ static void cmd_unblock(int argc, char *argv[])
 
 	blocked = FALSE;
 
-	str = g_strdup_printf("%s unblock", argv[0]);
+	str = g_strdup_printf("%s unblock", device_addr(proxy));
 
 	if (g_dbus_proxy_set_property_basic(proxy, "Blocked",
 					DBUS_TYPE_BOOLEAN, &blocked,
@@ -1718,16 +1729,8 @@ static void cmd_disconn(int argc, char *argv[])
 		return;
 	}
 
-	if (!argc || strlen(argv[0]) == 0) {
-		DBusMessageIter iter;
-		const char *addr;
-
-		if (g_dbus_proxy_get_property(proxy, "Address", &iter) == TRUE)
-			dbus_message_iter_get_basic(&iter, &addr);
-
-		bt_shell_printf("Attempting to disconnect from %s\n", addr);
-	} else
-		bt_shell_printf("Attempting to disconnect from %s\n", argv[0]);
+	bt_shell_printf("Attempting to disconnect from %s\n",
+					device_addr(proxy));
 }
 
 static void cmd_list_attributes(int argc, char *argv[])
-- 
2.13.6

