Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v0 04/16] gatt: Add hash table of GDBusProxy objects
Date: Mon, 10 Mar 2014 15:50:33 -0300
Message-Id: <1394477445-8987-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1394477445-8987-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1394477445-8987-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This commits adds a hash table to map attributes into GDBusProxy,
allowing to call remote objects for reading and writing values.
---
 src/gatt-dbus.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
index 8cf222d..014b8d6 100644
--- a/src/gatt-dbus.c
+++ b/src/gatt-dbus.c
@@ -56,6 +56,12 @@ struct external_app {
 	unsigned int watch;
 };
 
+/*
+ * Attribute to Proxy hash table. Used to map incoming
+ * ATT operations to its external characteristic proxy.
+ */
+static GHashTable *proxy_hash;
+
 static GSList *external_apps;
 
 static int external_app_path_cmp(gconstpointer a, gconstpointer b)
@@ -172,6 +178,7 @@ static int register_external_characteristics(GSList *proxies)
 		DBusMessageIter iter;
 		const char *str, *path;
 		bt_uuid_t uuid;
+		struct btd_attribute *attr;
 		GDBusProxy *proxy = list->data;
 
 		if (!g_dbus_proxy_get_property(proxy, "UUID", &iter))
@@ -186,11 +193,14 @@ static int register_external_characteristics(GSList *proxies)
 			return -EINVAL;
 
 		/* TODO: Missing Flags/property */
-		if (btd_gatt_add_char(&uuid, 0x00) == NULL)
+		attr = btd_gatt_add_char(&uuid, 0x00);
+		if (attr == NULL)
 			return -EINVAL;
 
 		path = g_dbus_proxy_get_path(proxy);
 		DBG("Added GATT CHR: %s (%s)", path, str);
+
+		g_hash_table_insert(proxy_hash, attr, g_dbus_proxy_ref(proxy));
 	}
 
 	return 0;
@@ -313,13 +323,22 @@ static const GDBusMethodTable methods[] = {
 
 gboolean gatt_dbus_manager_register(void)
 {
-	return g_dbus_register_interface(btd_get_dbus_connection(),
-					"/org/bluez", GATT_MGR_IFACE,
-					methods, NULL, NULL, NULL, NULL);
+	if (g_dbus_register_interface(btd_get_dbus_connection(),
+				"/org/bluez", GATT_MGR_IFACE,
+				methods, NULL, NULL, NULL, NULL) == FALSE)
+		return FALSE;
+
+	proxy_hash = g_hash_table_new_full(g_direct_hash, g_direct_equal,
+				NULL, (GDestroyNotify) g_dbus_proxy_unref);
+
+	return TRUE;
 }
 
 void gatt_dbus_manager_unregister(void)
 {
+	g_hash_table_destroy(proxy_hash);
+	proxy_hash = NULL;
+
 	g_dbus_unregister_interface(btd_get_dbus_connection(), "/org/bluez",
 							GATT_MGR_IFACE);
 }
-- 
1.8.3.1

