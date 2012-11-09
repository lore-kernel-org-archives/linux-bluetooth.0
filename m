Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 1/4] proximity: Convert reporter properties to DBus.Properties
Date: Fri, 9 Nov 2012 13:33:18 +0100
Message-ID: <1352464401-12702-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/proximity/immalert.c |  5 ++--
 profiles/proximity/linkloss.c |  5 ++--
 profiles/proximity/reporter.c | 62 +++++++++++++++----------------------------
 3 files changed, 25 insertions(+), 47 deletions(-)

diff --git a/profiles/proximity/immalert.c b/profiles/proximity/immalert.c
index 77b4966..ff40bdf 100644
--- a/profiles/proximity/immalert.c
+++ b/profiles/proximity/immalert.c
@@ -137,9 +137,8 @@ static void imm_alert_emit_alert_signal(struct connected_device *condev,
 
 	DBG("alert %s remote %s", alert_level_str, path);
 
-	emit_property_changed(path,
-			PROXIMITY_REPORTER_INTERFACE, "ImmediateAlertLevel",
-			DBUS_TYPE_STRING, &alert_level_str);
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), path,
+			PROXIMITY_REPORTER_INTERFACE, "ImmediateAlertLevel");
 }
 
 static void imm_alert_remove_condev(struct connected_device *condev)
diff --git a/profiles/proximity/linkloss.c b/profiles/proximity/linkloss.c
index 40510d8..de92be7 100644
--- a/profiles/proximity/linkloss.c
+++ b/profiles/proximity/linkloss.c
@@ -138,9 +138,8 @@ static void link_loss_emit_alert_signal(struct connected_device *condev)
 
 	DBG("alert %s remote %s", alert_level_str, path);
 
-	emit_property_changed(path,
-			PROXIMITY_REPORTER_INTERFACE, "LinkLossAlertLevel",
-			DBUS_TYPE_STRING, &alert_level_str);
+	g_dbus_emit_property_changed(btd_get_dbus_connection(), path,
+			PROXIMITY_REPORTER_INTERFACE, "LinkLossAlertLevel");
 }
 
 static uint8_t link_loss_alert_lvl_read(struct attribute *a,
diff --git a/profiles/proximity/reporter.c b/profiles/proximity/reporter.c
index 6ec5f73..1d98ba9 100644
--- a/profiles/proximity/reporter.c
+++ b/profiles/proximity/reporter.c
@@ -139,56 +139,36 @@ static void register_tx_power(struct btd_adapter *adapter)
 	g_assert(h - start_handle == svc_size);
 }
 
-static DBusMessage *get_properties(DBusConnection *conn,
-						DBusMessage *msg, void *data)
+static gboolean property_get_link_loss_level(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
 {
-	DBusMessageIter iter;
-	DBusMessageIter dict;
-	DBusMessage *reply = NULL;
-	const char *linkloss_level, *immalert_level;
 	struct btd_device *device = data;
+	const char *level;
 
-	reply = dbus_message_new_method_return(msg);
-	if (!reply)
-		return NULL;
-
-	linkloss_level = link_loss_get_alert_level(device);
-	immalert_level = imm_alert_get_level(device);
+	level = link_loss_get_alert_level(device);
 
-	dbus_message_iter_init_append(reply, &iter);
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &level);
 
-	if (!dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
-			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
-			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
-			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict))
-		goto err;
+	return TRUE;
+}
 
-	dict_append_entry(&dict, "LinkLossAlertLevel", DBUS_TYPE_STRING,
-							&linkloss_level);
-	dict_append_entry(&dict, "ImmediateAlertLevel", DBUS_TYPE_STRING,
-							&immalert_level);
+static gboolean property_get_immediate_alert_level(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+	const char *level;
 
-	if (!dbus_message_iter_close_container(&iter, &dict))
-		goto err;
+	level = imm_alert_get_level(device);
 
-	return reply;
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &level);
 
-err:
-	if (reply)
-		dbus_message_unref(reply);
-	return btd_error_failed(msg, "not enough memory");
+	return TRUE;
 }
 
-static const GDBusMethodTable reporter_methods[] = {
-	{ GDBUS_METHOD("GetProperties",
-			NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-			get_properties) },
-	{ }
-};
-
-static const GDBusSignalTable reporter_signals[] = {
-	{ GDBUS_SIGNAL("PropertyChanged",
-			GDBUS_ARGS({ "name", "s" }, { "value", "v" })) },
+static const GDBusPropertyTable reporter_device_properties[] = {
+	{ "LinkLossAlertLevel", "s", property_get_link_loss_level },
+	{ "ImmediateAlertLevel", "s", property_get_immediate_alert_level },
 	{ }
 };
 
@@ -216,8 +196,8 @@ static void register_reporter_device(struct btd_device *device,
 
 	g_dbus_register_interface(btd_get_dbus_connection(), path,
 					PROXIMITY_REPORTER_INTERFACE,
-					reporter_methods, reporter_signals,
-					NULL, device, NULL);
+					NULL, NULL, reporter_device_properties,
+					device, NULL);
 
 	btd_device_ref(device);
 	radapter->devices = g_slist_prepend(radapter->devices, device);
-- 
1.8.0

