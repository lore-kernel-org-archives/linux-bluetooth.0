Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 4/9] gatt: Add GATT service to the local database
Date: Fri, 28 Feb 2014 14:05:31 -0300
Message-Id: <1393607136-16908-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1393607136-16908-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1393607136-16908-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch creates GATT service attribute based on its GDBusProxy
object, and inserts the declaration to the local database.
---
 src/gatt-dbus.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
index 28d7f78..93d5b7c 100644
--- a/src/gatt-dbus.c
+++ b/src/gatt-dbus.c
@@ -39,6 +39,7 @@
 #include "log.h"
 
 #include "error.h"
+#include "gatt.h"
 #include "gatt-dbus.h"
 
 #define GATT_MGR_IFACE			"org.bluez.GattManager1"
@@ -129,6 +130,56 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 	eapp->proxies = g_slist_remove(eapp->proxies, proxy);
 }
 
+static int register_external_service(const struct external_app *eapp,
+							GDBusProxy *proxy)
+{
+	DBusMessageIter iter;
+	const char *str, *path, *iface;
+	bt_uuid_t uuid;
+
+	path = g_dbus_proxy_get_path(proxy);
+	iface = g_dbus_proxy_get_interface(proxy);
+	if (g_strcmp0(eapp->path, path) != 0 ||
+			g_strcmp0(iface, GATT_SERVICE_IFACE) != 0)
+		return -EINVAL;
+
+	if (!g_dbus_proxy_get_property(proxy, "UUID", &iter))
+		return -EINVAL;
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+		return -EINVAL;
+
+	dbus_message_iter_get_basic(&iter, &str);
+
+	if (bt_string_to_uuid(&uuid, str) < 0)
+		return -EINVAL;
+
+	if (btd_gatt_add_service(&uuid) == NULL)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void client_ready(void *user_data)
+{
+	struct external_app *eapp = user_data;
+	GDBusProxy *proxy;
+
+	if (eapp->proxies == NULL)
+		goto fail;
+
+	proxy = eapp->proxies->data;
+	if (register_external_service(eapp, proxy) < 0)
+		goto fail;
+
+	DBG("Added GATT service %s", eapp->path);
+
+	return;
+
+fail:
+	DBG("No proxies: inconsistent service (%s)!", eapp->path);
+}
+
 static struct external_app *new_external_app(DBusConnection *conn,
 					const char *sender, const char *path)
 {
@@ -156,6 +207,8 @@ static struct external_app *new_external_app(DBusConnection *conn,
 	g_dbus_client_set_proxy_handlers(client, proxy_added, proxy_removed,
 								NULL, eapp);
 
+	g_dbus_client_set_proxies_ready_watch(client, client_ready, eapp);
+
 	return eapp;
 }
 
-- 
1.8.3.1

