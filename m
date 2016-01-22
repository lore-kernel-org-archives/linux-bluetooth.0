Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Francois Beaufort <beaufort.francois@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Updated bluetoothctl command to remove all devices
Date: Fri, 22 Jan 2016 15:38:51 +0100
Message-Id: <1453473531-10940-1-git-send-email-beaufort.francois@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 client/main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/client/main.c b/client/main.c
index b695744..1361e80 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1317,6 +1317,7 @@ static void remove_device_setup(DBusMessageIter *iter, void *user_data)
 static void cmd_remove(const char *arg)
 {
 	GDBusProxy *proxy;
+	GList *list;
 	char *path;
 
 	if (!arg || !strlen(arg)) {
@@ -1327,6 +1328,14 @@ static void cmd_remove(const char *arg)
 	if (check_default_ctrl() == FALSE)
 		return;
 
+	if (strcmp(arg, "*") == 0) {
+		for (list = g_list_first(dev_list); list; list = g_list_next(list)) {
+			GDBusProxy *proxy = list->data;
+			cmd_remove(g_dbus_proxy_get_path(proxy));
+		}
+		return;
+	}
+
 	proxy = find_proxy_by_address(dev_list, arg);
 	if (!proxy) {
 		rl_printf("Device %s not available\n", arg);
-- 
2.7.0

