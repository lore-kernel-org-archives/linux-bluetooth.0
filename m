Return-Path: <cyrus@holtmann.org>
From: Steven Walter <stevenrwalter@gmail.com>
To: linux-bluetooth@vger.kernel.org, armansito@chromium.org
Cc: Steven Walter <stevenrwalter@gmail.com>
Subject: [PATCH BlueZ 2/2] src/gatt-dbus: register desciptors after the characteristic they apply to
Date: Mon,  9 Feb 2015 10:53:47 -0500
Message-Id: <1423497227-11109-2-git-send-email-stevenrwalter@gmail.com>
In-Reply-To: <1423497227-11109-1-git-send-email-stevenrwalter@gmail.com>
References: <1423497227-11109-1-git-send-email-stevenrwalter@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ordering of these entries in the attribute database matters
---
 src/gatt-dbus.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 61 insertions(+), 5 deletions(-)

diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
index f0cd26c..89cec91 100644
--- a/src/gatt-dbus.c
+++ b/src/gatt-dbus.c
@@ -374,8 +374,59 @@ static int register_external_service(struct external_service *esvc,
 	return 0;
 }
 
+static int add_char_desc(struct gatt_db_attribute *service,
+			 GDBusProxy *proxy, const bt_uuid_t *uuid);
+
+static int add_desc_for_char (struct gatt_db_attribute *service,
+			     DBusMessageIter *iter, GSList *proxies)
+{
+	DBusMessageIter desc_iter;
+	GDBusProxy *proxy = NULL;
+	GSList *list = NULL;
+	const char *path, *str;
+	bt_uuid_t uuid;
+
+	dbus_message_iter_recurse(iter, &desc_iter);
+
+	do {
+		DBusMessageIter iter2;
+
+		if (dbus_message_iter_get_arg_type(&desc_iter) != DBUS_TYPE_OBJECT_PATH)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(&desc_iter, &path);
+		/* Find the proxy matching path */
+		for (list = proxies; list; list = g_slist_next(list)) {
+			const char *iface;
+			proxy = list->data;
+			iface = g_dbus_proxy_get_interface(proxy);
+			if (strcmp(iface, GATT_DESCRIPTOR_IFACE))
+				continue;
+			if (!strcmp(g_dbus_proxy_get_path(proxy), path))
+				break;
+		}
+		if (!list) 
+			return -EINVAL;
+
+		if (!g_dbus_proxy_get_property(proxy, "UUID", &iter2))
+			return -EINVAL;
+
+		if (dbus_message_iter_get_arg_type(&iter2) != DBUS_TYPE_STRING)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(&iter2, &str);
+
+		if (bt_string_to_uuid(&uuid, str) < 0)
+			return -EINVAL;
+
+		add_char_desc(service, proxy, &uuid);
+	} while (dbus_message_iter_next(&desc_iter));
+
+	return 0;
+}
+
 static int add_char(struct gatt_db_attribute *service,
-		    GDBusProxy *proxy, const bt_uuid_t *uuid)
+		    GDBusProxy *proxy, const bt_uuid_t *uuid, GSList *proxies)
 {
 	DBusMessageIter iter;
 	struct btd_attribute *attr;
@@ -417,6 +468,12 @@ static int add_char(struct gatt_db_attribute *service,
 					   read_cb, write_cb, proxy);
 	assert(res);
 
+	if (g_dbus_proxy_get_property(proxy, "Descriptors", &iter)) {
+		int ret = add_desc_for_char(service, &iter, proxies);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -442,7 +499,7 @@ static int register_external_characteristics(struct gatt_db_attribute *service,
 		DBusMessageIter iter;
 		bt_uuid_t uuid;
 		const char *path, *iface, *str;
-		int ret;
+		int ret = 0;
 
 		/* Mandatory property */
 		if (!g_dbus_proxy_get_property(proxy, "UUID", &iter))
@@ -460,9 +517,8 @@ static int register_external_characteristics(struct gatt_db_attribute *service,
 		path = g_dbus_proxy_get_path(proxy);
 
 		if (!strcmp(GATT_CHR_IFACE, iface))
-			ret = add_char(service, proxy, &uuid);
-		else
-			ret = add_char_desc(service, proxy, &uuid);
+			ret = add_char(service, proxy, &uuid, proxies);
+		/* skip descriptors, they're added by add_char */
 
 		if (ret < 0)
 			return ret;
-- 
1.9.1

