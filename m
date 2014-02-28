Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 2/9] gatt: Add proxy added handler
Date: Fri, 28 Feb 2014 14:05:29 -0300
Message-Id: <1393607136-16908-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1393607136-16908-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1393607136-16908-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch creates a list of GATT objects sorting the entries based on
the object path to allow inserting the attributes following hierarchical
association.
---
 src/gatt-dbus.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
index fd614f9..f8486f3 100644
--- a/src/gatt-dbus.c
+++ b/src/gatt-dbus.c
@@ -42,11 +42,15 @@
 #include "gatt-dbus.h"
 
 #define GATT_MGR_IFACE			"org.bluez.GattManager1"
+#define GATT_SERVICE_IFACE		"org.bluez.GattService1"
+#define GATT_CHR_IFACE			"org.bluez.GattCharacteristic1"
+#define GATT_DESCRIPTOR_IFACE		"org.bluez.GattDescriptor1"
 
 struct external_app {
 	char *owner;
 	char *path;
 	GDBusClient *client;
+	GSList *proxies;
 	unsigned int watch;
 };
 
@@ -75,6 +79,43 @@ static void external_app_watch_destroy(gpointer user_data)
 	g_free(eapp);
 }
 
+static int proxy_path_cmp(gconstpointer a, gconstpointer b)
+{
+	GDBusProxy *proxy1 = (GDBusProxy *) a;
+	GDBusProxy *proxy2 = (GDBusProxy *) b;
+	const char *path1 = g_dbus_proxy_get_path(proxy1);
+	const char *path2 = g_dbus_proxy_get_path(proxy2);
+
+	return g_strcmp0(path1, path2);
+}
+
+static void proxy_added(GDBusProxy *proxy, void *user_data)
+{
+	struct external_app *eapp = user_data;
+	const char *interface, *path;
+
+	interface = g_dbus_proxy_get_interface(proxy);
+	path = g_dbus_proxy_get_path(proxy);
+
+	if (!g_str_has_prefix(path, eapp->path))
+		return;
+
+	if (g_strcmp0(interface, GATT_CHR_IFACE) != 0 &&
+			g_strcmp0(interface, GATT_SERVICE_IFACE) != 0 &&
+			g_strcmp0(interface, GATT_DESCRIPTOR_IFACE) != 0)
+		return;
+
+	DBG("path %s iface %s", path, interface);
+
+	/*
+	 * Object path follows a hierarchical organization. Add the
+	 * proxies sorted by path helps the logic to register the
+	 * object path later.
+	 */
+	eapp->proxies = g_slist_insert_sorted(eapp->proxies, proxy,
+							proxy_path_cmp);
+}
+
 static struct external_app *new_external_app(DBusConnection *conn,
 					const char *sender, const char *path)
 {
@@ -99,6 +140,9 @@ static struct external_app *new_external_app(DBusConnection *conn,
 	eapp->client = client;
 	eapp->path = g_strdup(path);
 
+	g_dbus_client_set_proxy_handlers(client, proxy_added, NULL, NULL,
+								eapp);
+
 	return eapp;
 }
 
-- 
1.8.3.1

