Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [RFC 5/6] health: Convert HealthDevice to DBus.Properties
Date: Thu, 18 Oct 2012 19:03:50 -0300
Message-Id: <1350597831-28380-6-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1350597831-28380-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1350597831-28380-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

---
 profiles/health/hdp.c | 56 ++++++++++++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 30 deletions(-)

diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index 845155e..0692d43 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -968,9 +968,9 @@ static void hdp_mcap_mdl_connected_cb(struct mcap_mdl *mdl, void *data)
 
 	dev->fr = hdp_channel_ref(chan);
 
-	emit_property_changed(device_get_path(dev->dev),
-				HEALTH_DEVICE, "MainChannel",
-				DBUS_TYPE_OBJECT_PATH, &dev->fr->path);
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+				device_get_path(dev->dev), HEALTH_DEVICE,
+				"MainChannel");
 
 end:
 	hdp_channel_unref(dev->ndc);
@@ -1690,9 +1690,9 @@ static void hdp_mdl_conn_cb(struct mcap_mdl *mdl, GError *err, gpointer data)
 
 	dev->fr = hdp_channel_ref(hdp_chann);
 
-	emit_property_changed(device_get_path(dev->dev),
-				HEALTH_DEVICE, "MainChannel",
-				DBUS_TYPE_OBJECT_PATH, &dev->fr->path);
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+				device_get_path(dev->dev), HEALTH_DEVICE,
+				"MainChannel");
 }
 
 static void device_create_mdl_cb(struct mcap_mdl *mdl, uint8_t conf,
@@ -2049,31 +2049,26 @@ fail:
 	return reply;
 }
 
-static DBusMessage *device_get_properties(DBusConnection *conn,
-					DBusMessage *msg, void *user_data)
+static gboolean dev_property_exists_main_channel(
+				const GDBusPropertyTable *property, void *data)
 {
-	struct hdp_device *device = user_data;
-	DBusMessageIter iter, dict;
-	DBusMessage *reply;
-
-	reply = dbus_message_new_method_return(msg);
-	if (reply == NULL)
-		return NULL;
+	struct hdp_device *device = data;
+	return device->fr != NULL;
+}
 
-	dbus_message_iter_init_append(reply, &iter);
+static gboolean dev_property_get_main_channel(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct hdp_device *device = data;
 
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
-			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+	if (device->fr == NULL)
+		return FALSE;
 
-	if (device->fr != NULL)
-		dict_append_entry(&dict, "MainChannel", DBUS_TYPE_OBJECT_PATH,
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH,
 							&device->fr->path);
 
-	dbus_message_iter_close_container(&iter, &dict);
-
-	return reply;
+	return TRUE;
 }
 
 static void health_device_destroy(void *data)
@@ -2104,9 +2099,6 @@ static const GDBusMethodTable health_device_methods[] = {
 	{ GDBUS_ASYNC_METHOD("DestroyChannel",
 			GDBUS_ARGS({ "channel", "o" }), NULL,
 			device_destroy_channel) },
-	{ GDBUS_METHOD("GetProperties",
-			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-			device_get_properties) },
 	{ }
 };
 
@@ -2115,8 +2107,12 @@ static const GDBusSignalTable health_device_signals[] = {
 			GDBUS_ARGS({ "channel", "o" })) },
 	{ GDBUS_SIGNAL("ChannelDeleted",
 			GDBUS_ARGS({ "channel", "o" })) },
-	{ GDBUS_SIGNAL("PropertyChanged",
-			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
+	{ }
+};
+
+static const GDBusPropertyTable health_device_properties[] = {
+	{ "MainChannel", "o", dev_property_get_main_channel, NULL,
+					dev_property_exists_main_channel },
 	{ }
 };
 
-- 
1.7.12.3

