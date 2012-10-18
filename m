Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [RFC 4/6] health: Convert HealthChannel to DBus.Properties
Date: Thu, 18 Oct 2012 19:03:49 -0300
Message-Id: <1350597831-28380-5-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1350597831-28380-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1350597831-28380-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

Also remove a needless strdup to send type property.
---
 profiles/health/hdp.c | 68 +++++++++++++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 32 deletions(-)

diff --git a/profiles/health/hdp.c b/profiles/health/hdp.c
index fd21a23..845155e 100644
--- a/profiles/health/hdp.c
+++ b/profiles/health/hdp.c
@@ -418,44 +418,43 @@ static const GDBusMethodTable health_manager_methods[] = {
 	{ }
 };
 
-static DBusMessage *channel_get_properties(DBusConnection *conn,
-					DBusMessage *msg, void *user_data)
+static gboolean channel_property_get_device(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
 {
-	struct hdp_channel *chan = user_data;
-	DBusMessageIter iter, dict;
-	DBusMessage *reply;
-	const char *path;
-	char *type;
+	struct hdp_channel *chan = data;
+	const char *path = device_get_path(chan->dev->dev);
 
-	reply = dbus_message_new_method_return(msg);
-	if (reply == NULL)
-		return NULL;
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
 
-	dbus_message_iter_init_append(reply, &iter);
+	return TRUE;
+}
 
-	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
-			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+static gboolean channel_property_get_application(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct hdp_channel *chan = data;
+	const char *path = chan->app->path;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
 
-	path = device_get_path(chan->dev->dev);
-	dict_append_entry(&dict, "Device", DBUS_TYPE_OBJECT_PATH, &path);
+	return TRUE;
+}
 
-	path = chan->app->path;
-	dict_append_entry(&dict, "Application", DBUS_TYPE_OBJECT_PATH, &path);
+static gboolean channel_property_get_type(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct hdp_channel *chan = data;
+	const char *type;
 
 	if (chan->config == HDP_RELIABLE_DC)
-		type = g_strdup("Reliable");
+		type = "Reliable";
 	else
-		type = g_strdup("Streaming");
-
-	dict_append_entry(&dict, "Type", DBUS_TYPE_STRING, &type);
-
-	g_free(type);
+		type = "Streaming";
 
-	dbus_message_iter_close_container(&iter, &dict);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &type);
 
-	return reply;
+	return TRUE;
 }
 
 static void hdp_tmp_dc_data_destroy(gpointer data)
@@ -720,9 +719,6 @@ end:
 }
 
 static const GDBusMethodTable health_channels_methods[] = {
-	{ GDBUS_METHOD("GetProperties",
-			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-			channel_get_properties) },
 	{ GDBUS_ASYNC_METHOD("Acquire",
 			NULL, GDBUS_ARGS({ "fd", "h" }),
 			channel_acquire) },
@@ -730,6 +726,13 @@ static const GDBusMethodTable health_channels_methods[] = {
 	{ }
 };
 
+static const GDBusPropertyTable health_channels_properties[] = {
+	{ "Device", "o",  channel_property_get_device },
+	{ "Application", "o", channel_property_get_application },
+	{ "Type", "s", channel_property_get_type },
+	{ }
+};
+
 static struct hdp_channel *create_channel(struct hdp_device *dev,
 						uint8_t config,
 						struct mcap_mdl *mdl,
@@ -768,8 +771,9 @@ static struct hdp_channel *create_channel(struct hdp_device *dev,
 
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 					hdp_chann->path, HEALTH_CHANNEL,
-					health_channels_methods, NULL, NULL,
-					hdp_chann, health_channel_destroy)) {
+					health_channels_methods, NULL,
+					health_channels_properties, hdp_chann,
+					health_channel_destroy)) {
 		g_set_error(err, HDP_ERROR, HDP_UNSPECIFIED_ERROR,
 					"Can't register the channel interface");
 		health_channel_destroy(hdp_chann);
-- 
1.7.12.3

