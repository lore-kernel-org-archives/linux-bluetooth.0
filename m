Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v0 2/5] gatt: Add descriptor to the database
Date: Fri, 28 Mar 2014 11:19:07 -0300
Message-Id: <1396016350-16943-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1396016350-16943-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1396016350-16943-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Initial support for GATT characteristic descriptors. This patch adds the
characteristic descriptor attribute to the GATT local database based
on the fetched GDBusProxy objects.
---
 src/gatt-dbus.c | 100 ++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 65 insertions(+), 35 deletions(-)

diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
index 3c9dc05..1bfa21f 100644
--- a/src/gatt-dbus.c
+++ b/src/gatt-dbus.c
@@ -353,20 +353,71 @@ static int register_external_service(const struct external_app *eapp,
 	return 0;
 }
 
+static int add_char(GDBusProxy *proxy, const bt_uuid_t *uuid)
+{
+	DBusMessageIter iter;
+	struct btd_attribute *attr;
+	btd_attr_write_t write_cb;
+	btd_attr_read_t read_cb;
+	uint8_t propmask = 0;
+
+	/*
+	 * Optional property. If is not informed, read and write
+	 * procedures will be allowed. Upper-layer should handle
+	 * characteristic requirements.
+	 */
+	if (g_dbus_proxy_get_property(proxy, "Flags", &iter))
+		propmask = flags_get_bitmask(&iter);
+	else
+		propmask = GATT_CHR_PROP_WRITE_WITHOUT_RESP
+						| GATT_CHR_PROP_WRITE
+						| GATT_CHR_PROP_READ;
+	if (!propmask)
+		return -EINVAL;
+
+	if (propmask & GATT_CHR_PROP_READ)
+		read_cb = proxy_read_cb;
+	else
+		read_cb = NULL;
+
+	if (propmask & (GATT_CHR_PROP_WRITE | GATT_CHR_PROP_WRITE_WITHOUT_RESP))
+		write_cb = proxy_write_cb;
+	else
+		write_cb = NULL;
+
+	attr = btd_gatt_add_char(uuid, propmask, read_cb, write_cb);
+	if (!attr)
+		return -ENOMEM;
+
+	g_hash_table_insert(proxy_hash, attr, g_dbus_proxy_ref(proxy));
+
+	return 0;
+}
+
+static int add_char_desc(GDBusProxy *proxy, const bt_uuid_t *uuid)
+{
+	struct btd_attribute *attr;
+
+	attr = btd_gatt_add_char_desc(uuid, proxy_read_cb, proxy_write_cb);
+	if (!attr)
+		return -ENOMEM;
+
+	g_hash_table_insert(proxy_hash, attr, g_dbus_proxy_ref(proxy));
+
+	return 0;
+}
+
 static int register_external_characteristics(GSList *proxies)
 
 {
 	GSList *list;
 
 	for (list = proxies; list; list = g_slist_next(list)) {
+		GDBusProxy *proxy = list->data;
 		DBusMessageIter iter;
-		const char *str, *path;
 		bt_uuid_t uuid;
-		struct btd_attribute *attr;
-		GDBusProxy *proxy = list->data;
-		btd_attr_write_t write_cb;
-		btd_attr_read_t read_cb;
-		uint8_t propmask = 0;
+		const char *path, *iface, *str;
+		int ret;
 
 		/* Mandatory property */
 		if (!g_dbus_proxy_get_property(proxy, "UUID", &iter))
@@ -380,39 +431,18 @@ static int register_external_characteristics(GSList *proxies)
 		if (bt_string_to_uuid(&uuid, str) < 0)
 			return -EINVAL;
 
-		/*
-		 * Optional property. If is not informed, read and write
-		 * procedures will be allowed. Upper-layer should handle
-		 * characteristic requirements.
-		 */
-		if (g_dbus_proxy_get_property(proxy, "Flags", &iter))
-			propmask = flags_get_bitmask(&iter);
-		else
-			propmask = GATT_CHR_PROP_WRITE_WITHOUT_RESP
-						| GATT_CHR_PROP_WRITE
-						| GATT_CHR_PROP_READ;
-		if (!propmask)
-			return -EINVAL;
-
-		if (propmask & GATT_CHR_PROP_READ)
-			read_cb = proxy_read_cb;
-		else
-			read_cb = NULL;
+		iface = g_dbus_proxy_get_interface(proxy);
+		path = g_dbus_proxy_get_path(proxy);
 
-		if (propmask & (GATT_CHR_PROP_WRITE |
-					GATT_CHR_PROP_WRITE_WITHOUT_RESP))
-			write_cb = proxy_write_cb;
+		if (!strcmp(GATT_CHR_IFACE, iface))
+			ret = add_char(proxy, &uuid);
 		else
-			write_cb = NULL;
+			ret = add_char_desc(proxy, &uuid);
 
-		attr = btd_gatt_add_char(&uuid, propmask, read_cb, write_cb);
-		if (!attr)
-			return -EINVAL;
-
-		path = g_dbus_proxy_get_path(proxy);
-		DBG("Added GATT CHR: %s (%s)", path, str);
+		if (ret < 0)
+			return ret;
 
-		g_hash_table_insert(proxy_hash, attr, g_dbus_proxy_ref(proxy));
+		DBG("Added GATT: %s (%s)", path, str);
 	}
 
 	return 0;
-- 
1.8.3.1

