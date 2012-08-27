Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Subject: [RFC BlueZ 10/22] alert: Implement category registration in RegisterAlert()
Date: Mon, 27 Aug 2012 13:11:54 -0400
Message-Id: <1346087526-15107-11-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1346087526-15107-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1346087526-15107-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eder Ruiz Maria <eder.ruiz@openbossa.org>

The alert category is now properly verified and stored (if
supported).
---
 profiles/alert/server.c |  106 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 101 insertions(+), 5 deletions(-)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index 78c3e39..69069a2 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -74,20 +74,114 @@ enum {
 	RINGER_NORMAL,
 };
 
+struct alert_data {
+	const char *category;
+	char *srv;
+	char *path;
+};
+
 static DBusConnection *connection = NULL;
+static GSList *registered_alerts = NULL;
 static uint8_t ringer_setting = RINGER_NORMAL;
 static uint8_t alert_status = 0;
 
+static const char *anp_categories[] = {
+	"simple",
+	"email",
+	"news",
+	"call",
+	"missed_call",
+	"sms_mms",
+	"voice_mail",
+	"schedule",
+	"high_priority",
+	"instant_message",
+};
+
+static const char *pasp_categories[] = {
+	"ringer",
+	"vibrate",
+	"display",
+};
+
+static void alert_data_destroy(gpointer user_data)
+{
+	struct alert_data *alert = user_data;
+
+	g_free(alert->srv);
+	g_free(alert->path);
+	g_free(alert);
+}
+
+static void alert_destroy(gpointer user_data)
+{
+	g_slist_free_full(registered_alerts, alert_data_destroy);
+	registered_alerts = NULL;
+}
+
+static const char *valid_category(const char *category)
+{
+	unsigned i;
+
+	for (i = 0; i < G_N_ELEMENTS(anp_categories); i++) {
+		if (g_str_equal(anp_categories[i], category))
+			return anp_categories[i];
+	}
+
+	for (i = 0; i < G_N_ELEMENTS(pasp_categories); i++) {
+		if (g_str_equal(pasp_categories[i], category))
+			return pasp_categories[i];
+	}
+
+	return NULL;
+}
+
+static gboolean registered_category(const char *category)
+{
+	GSList *l;
+	struct alert_data *alert;
+
+	for (l = registered_alerts; l; l = g_slist_next(l)) {
+		alert = l->data;
+		if (g_str_equal(alert->category, category))
+			return TRUE;
+	}
+
+	return FALSE;
+}
+
 static DBusMessage *register_alert(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
+	const char *sender = dbus_message_get_sender(msg);
+	char *path;
 	const char *category;
+	const char *c;
+	struct alert_data *alert;
 
-	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &category,
-							DBUS_TYPE_INVALID))
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &c,
+			DBUS_TYPE_OBJECT_PATH, &path, DBUS_TYPE_INVALID))
 		return btd_error_invalid_args(msg);
 
-	DBG("RegisterAlert: %s", category);
+	category = valid_category(c);
+	if (!category) {
+		DBG("Invalid category: %s", c);
+		return btd_error_invalid_args(msg);
+	}
+
+	if (registered_category(category)) {
+		DBG("Category %s already registered", category);
+		return dbus_message_new_method_return(msg);
+	}
+
+	alert = g_new0(struct alert_data, 1);
+	alert->srv = g_strdup(sender);
+	alert->path = g_strdup(path);
+	alert->category = category;
+
+	registered_alerts = g_slist_append(registered_alerts, alert);
+
+	DBG("RegisterAlert(\"%s\", \"%s\")", alert->category, alert->path);
 
 	return dbus_message_new_method_return(msg);
 }
@@ -288,8 +382,8 @@ int alert_server_init(void)
 		return -EIO;
 
 	if (!g_dbus_register_interface(connection, ALERT_OBJECT_PATH,
-						ALERT_INTERFACE, alert_methods,
-						NULL, NULL, NULL, NULL)) {
+					ALERT_INTERFACE, alert_methods, NULL,
+					NULL, NULL, alert_destroy)) {
 
 		error("D-Bus failed to register %s interface",
 							ALERT_INTERFACE);
@@ -305,6 +399,8 @@ void alert_server_exit(void)
 {
 	btd_unregister_adapter_driver(&alert_server_driver);
 
+	g_dbus_unregister_interface(connection, ALERT_OBJECT_PATH,
+							ALERT_INTERFACE);
 	dbus_connection_unref(connection);
 	connection = NULL;
 }
-- 
1.7.9.5

