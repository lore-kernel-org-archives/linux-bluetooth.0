Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v5 07/16] gatt: Assign read callback for external services
Date: Tue, 18 Mar 2014 17:26:22 -0300
Message-Id: <1395174391-27251-8-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395174391-27251-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1394802800-8424-1-git-send-email-claudio.takahasi@openbossa.org>
 <1395174391-27251-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the callback for reading the external characteristic
Value. Internally, GDBusProxy implementation tracks all properties Value
changes consequently Value can be ready directly from the proxy without
additional method calls.
---
 src/gatt-dbus.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
index 275b263..fff2d3a 100644
--- a/src/gatt-dbus.c
+++ b/src/gatt-dbus.c
@@ -139,6 +139,46 @@ static void proxy_removed(GDBusProxy *proxy, void *user_data)
 	eapp->proxies = g_slist_remove(eapp->proxies, proxy);
 }
 
+static void proxy_read_cb(struct btd_attribute *attr,
+				btd_attr_read_result_t result, void *user_data)
+{
+	DBusMessageIter iter, array;
+	GDBusProxy *proxy;
+	uint8_t *value;
+	int len;
+
+	/*
+	 * Remote device is trying to read the informed attribute,
+	 * "Value" should be read from the proxy. GDBusProxy tracks
+	 * properties changes automatically, it is not necessary to
+	 * get the value directly from the GATT server.
+	 */
+	proxy = g_hash_table_lookup(proxy_hash, attr);
+	if (proxy == NULL) {
+		result(ENOENT, NULL, 0, user_data);
+		return;
+	}
+
+	if (!g_dbus_proxy_get_property(proxy, "Value", &iter)) {
+		/* Unusual situation, read property will checked earlier */
+		result(EPERM, NULL, 0, user_data);
+		return;
+	}
+
+	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY) {
+		DBG("External service inconsistent!");
+		result(EPERM, NULL, 0, user_data);
+		return;
+	}
+
+	dbus_message_iter_recurse(&iter, &array);
+	dbus_message_iter_get_fixed_array(&array, &value, &len);
+
+	DBG("attribute: %p read %d bytes", attr, len);
+
+	result(0, value, len, user_data);
+}
+
 static int register_external_service(const struct external_app *eapp,
 							GDBusProxy *proxy)
 {
@@ -198,7 +238,7 @@ static int register_external_characteristics(GSList *proxies)
 		 * Reference table 3.5: Characteristic Properties bit field.
 		 */
 
-		attr = btd_gatt_add_char(&uuid, 0x00, NULL);
+		attr = btd_gatt_add_char(&uuid, 0x00, proxy_read_cb);
 		if (attr == NULL)
 			return -EINVAL;
 
-- 
1.8.3.1

