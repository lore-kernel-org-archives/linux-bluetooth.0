Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v1 09/15] gatt: Assign write callback for external services
Date: Wed, 12 Mar 2014 13:27:05 -0300
Message-Id: <1394641631-1534-10-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1394641631-1534-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1394477445-8987-1-git-send-email-claudio.takahasi@openbossa.org>
 <1394641631-1534-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the callback for writing the external characteristic
value. Internally, GDBusProxy implementation calls Set method of the
"Value" property. At the moment, potential errors returned by the
external service implementation are being ignored.

The ATT operation (Write Command or Request) is not exposed to the
external service implementation. GATT/GDBusProxy handles possible
DBus errors returned, and notify the core using the callbacks informed.
Write Command doesn't have callback since it doesn't return ATT errors.
---
 src/gatt-dbus.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
index a02d565..7e81dc6 100644
--- a/src/gatt-dbus.c
+++ b/src/gatt-dbus.c
@@ -179,6 +179,30 @@ static void proxy_read_cb(struct btd_attribute *attr,
 	result(0, value, len, user_data);
 }
 
+static void proxy_write_reply(const DBusError *derr, void *user_data)
+{
+	if (derr)
+		DBG("Write reply: %s", derr->message);
+}
+
+static void proxy_write_cb(struct btd_attribute *attr,
+					const uint8_t *value, size_t len)
+{
+	GDBusProxy *proxy;
+
+	proxy = g_hash_table_lookup(proxy_hash, attr);
+	if (proxy == NULL)
+		/* FIXME: Attribute not found */
+		return;
+
+	g_dbus_proxy_set_property_array(proxy, "Value", DBUS_TYPE_BYTE,
+						value, len, proxy_write_reply,
+						NULL, NULL);
+
+	DBG("Server: Write characteristic callback %s",
+					g_dbus_proxy_get_path(proxy));
+}
+
 static int register_external_service(const struct external_app *eapp,
 							GDBusProxy *proxy)
 {
@@ -238,7 +262,8 @@ static int register_external_characteristics(GSList *proxies)
 		 * Reference table 3.5: Characteristic Properties bit field.
 		 */
 
-		attr = btd_gatt_add_char(&uuid, 0x00, proxy_read_cb, NULL);
+		attr = btd_gatt_add_char(&uuid, 0x00, proxy_read_cb,
+							proxy_write_cb);
 		if (attr == NULL)
 			return -EINVAL;
 
-- 
1.8.3.1

