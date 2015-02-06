Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 05/12] client: Add command list-attributes
Date: Fri,  6 Feb 2015 13:03:37 +0200
Message-Id: <1423220624-18861-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1423220624-18861-1-git-send-email-luiz.dentz@gmail.com>
References: <1423220624-18861-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This command can be used to list service attributes of a device.
---
 client/gatt.c | 29 +++++++++++++++++++++++++++++
 client/gatt.h |  2 ++
 client/main.c | 13 +++++++++++++
 3 files changed, 44 insertions(+)

diff --git a/client/gatt.c b/client/gatt.c
index 47785a8..7c44a9f 100644
--- a/client/gatt.c
+++ b/client/gatt.c
@@ -220,3 +220,32 @@ void gatt_remove_descriptor(GDBusProxy *proxy)
 
 	print_descriptor(proxy, COLORED_DEL);
 }
+
+static void list_attributes(const char *path, GList *source)
+{
+	GList *l;
+
+	for (l = source; l; l = g_list_next(l)) {
+		GDBusProxy *proxy = l->data;
+		const char *proxy_path;
+
+		proxy_path = g_dbus_proxy_get_path(proxy);
+
+		if (!g_str_has_prefix(proxy_path, path))
+			continue;
+
+		if (source == services) {
+			print_service(proxy, NULL);
+			list_attributes(proxy_path, characteristics);
+		} else if (source == characteristics) {
+			print_characteristic(proxy, NULL);
+			list_attributes(proxy_path, descriptors);
+		} else if (source == descriptors)
+			print_descriptor(proxy, NULL);
+	}
+}
+
+void gatt_list_attributes(const char *path)
+{
+	list_attributes(path, services);
+}
diff --git a/client/gatt.h b/client/gatt.h
index 8b30668..5785073 100644
--- a/client/gatt.h
+++ b/client/gatt.h
@@ -29,3 +29,5 @@ void gatt_remove_characteristic(GDBusProxy *proxy);
 
 void gatt_add_descriptor(GDBusProxy *proxy);
 void gatt_remove_descriptor(GDBusProxy *proxy);
+
+void gatt_list_attributes(const char *device);
diff --git a/client/main.c b/client/main.c
index 72223d5..7cdb19a 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1150,6 +1150,17 @@ static void cmd_disconn(const char *arg)
 	rl_printf("Attempting to disconnect from %s\n", arg);
 }
 
+static void cmd_list_attributes(const char *arg)
+{
+	GDBusProxy *proxy;
+
+	proxy = find_device(arg);
+	if (!proxy)
+		return;
+
+	gatt_list_attributes(g_dbus_proxy_get_path(proxy));
+}
+
 static void cmd_version(const char *arg)
 {
 	rl_printf("Version %s\n", VERSION);
@@ -1268,6 +1279,8 @@ static const struct {
 							dev_generator },
 	{ "disconnect",   "[dev]",    cmd_disconn, "Disconnect device",
 							dev_generator },
+	{ "list-attributes", "[dev]", cmd_list_attributes, "List attributes",
+							dev_generator },
 	{ "version",      NULL,       cmd_version, "Display version" },
 	{ "quit",         NULL,       cmd_quit, "Quit program" },
 	{ "exit",         NULL,       cmd_quit },
-- 
2.1.0

