Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v0 10/16] gatt: Assign write callback for external services
Date: Mon, 10 Mar 2014 15:50:39 -0300
Message-Id: <1394477445-8987-11-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1394477445-8987-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1394477445-8987-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the callback for writing the external characteristic
value. Internally, DBusProxy implementation calls the Set method of the
"Value" property. At the moment, potential errors returned by the
external service implementation are being ignored.

The ATT operation (Write Command or Request) is not exposed to the service
implementation. Internally, gatt-dbus will handle possible returned errors,
and notify the core based on the callbacks informed. Write Command
doesn't have callback since it doesn't return ATT errors.
---
 src/gatt-dbus.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
index 10d682d..d71d993 100644
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
@@ -237,7 +261,8 @@ static int register_external_characteristics(GSList *proxies)
 		 * Add properties according to Core SPEC 4.1 page 2183.
 		 * Reference table 3.5: Characteristic Properties bit field.
 		 */
-		attr = btd_gatt_add_char(&uuid, 0x00, proxy_read_cb, NULL);
+		attr = btd_gatt_add_char(&uuid, 0x00, proxy_read_cb,
+							proxy_write_cb);
 		if (attr == NULL)
 			return -EINVAL;
 
-- 
1.8.3.1

