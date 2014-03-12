Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v1 03/15] gatt: Add characteristic to the database
Date: Wed, 12 Mar 2014 13:26:59 -0300
Message-Id: <1394641631-1534-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1394641631-1534-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1394477445-8987-1-git-send-email-claudio.takahasi@openbossa.org>
 <1394641631-1534-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Initial support for GATT characteristics. This patch adds the
characteristic declaration attribute to the GATT local database based
on the fetched GDBusProxy objects.
---
 src/gatt-dbus.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
index 3fbff87..9f94c4f 100644
--- a/src/gatt-dbus.c
+++ b/src/gatt-dbus.c
@@ -163,6 +163,44 @@ static int register_external_service(const struct external_app *eapp,
 	return 0;
 }
 
+static int register_external_characteristics(GSList *proxies)
+
+{
+	GSList *list;
+
+	for (list = proxies; list; list = g_slist_next(proxies)) {
+		DBusMessageIter iter;
+		const char *str, *path;
+		bt_uuid_t uuid;
+		GDBusProxy *proxy = list->data;
+
+		if (!g_dbus_proxy_get_property(proxy, "UUID", &iter))
+			return -EINVAL;
+
+		if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_STRING)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(&iter, &str);
+
+		if (bt_string_to_uuid(&uuid, str) < 0)
+			return -EINVAL;
+
+		/*
+		 * TODO: Missing Flags/property
+		 * Add properties according to Core SPEC 4.1 page 2183.
+		 * Reference table 3.5: Characteristic Properties bit field.
+		 */
+
+		if (btd_gatt_add_char(&uuid, 0x00) == NULL)
+			return -EINVAL;
+
+		path = g_dbus_proxy_get_path(proxy);
+		DBG("Added GATT CHR: %s (%s)", path, str);
+	}
+
+	return 0;
+}
+
 static void client_ready(GDBusClient *client, void *user_data)
 {
 	struct external_app *eapp = user_data;
@@ -177,6 +215,9 @@ static void client_ready(GDBusClient *client, void *user_data)
 	if (register_external_service(eapp, proxy) < 0)
 		goto fail;
 
+	if (register_external_characteristics(g_slist_next(eapp->proxies)) < 0)
+		goto fail;
+
 	DBG("Added GATT service %s", eapp->path);
 
 	reply = dbus_message_new_method_return(eapp->reg);
@@ -186,7 +227,7 @@ fail:
 	error("Could not register external service: %s", eapp->path);
 
 	reply = btd_error_invalid_args(eapp->reg);
-	/* TODO: missing eapp cleanup */
+	/* TODO: missing eapp/database cleanup */
 
 reply:
 	dbus_message_unref(eapp->reg);
-- 
1.8.3.1

