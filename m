Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] client: Fix removing all devices
Date: Fri, 12 Feb 2016 14:46:41 +0100
Message-Id: <1455284801-2798-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

cmd_remove takes address string not device path.
---
 client/main.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/client/main.c b/client/main.c
index be785c5..b18bedd 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1333,10 +1333,24 @@ static void remove_device_setup(DBusMessageIter *iter, void *user_data)
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
 }
 
+static void remove_device(GDBusProxy *proxy)
+{
+	char *path;
+
+	path = g_strdup(g_dbus_proxy_get_path(proxy));
+
+	if (g_dbus_proxy_method_call(default_ctrl, "RemoveDevice",
+						remove_device_setup,
+						remove_device_reply,
+						path, g_free) == FALSE) {
+		rl_printf("Failed to remove device\n");
+		g_free(path);
+	}
+}
+
 static void cmd_remove(const char *arg)
 {
 	GDBusProxy *proxy;
-	char *path;
 
 	if (!arg || !strlen(arg)) {
 		rl_printf("Missing device address argument\n");
@@ -1351,7 +1365,7 @@ static void cmd_remove(const char *arg)
 
 		for (list = g_list_first(dev_list); list; list = g_list_next(list)) {
 			GDBusProxy *proxy = list->data;
-			cmd_remove(g_dbus_proxy_get_path(proxy));
+			remove_device(proxy);
 		}
 
 		return;
@@ -1363,16 +1377,7 @@ static void cmd_remove(const char *arg)
 		return;
 	}
 
-	path = g_strdup(g_dbus_proxy_get_path(proxy));
-
-	if (g_dbus_proxy_method_call(default_ctrl, "RemoveDevice",
-						remove_device_setup,
-						remove_device_reply,
-						path, g_free) == FALSE) {
-		rl_printf("Failed to remove device\n");
-		g_free(path);
-		return;
-	}
+	remove_device(proxy);
 }
 
 static void connect_reply(DBusMessage *message, void *user_data)
-- 
2.6.2

