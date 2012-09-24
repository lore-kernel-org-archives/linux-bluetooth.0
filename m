Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Subject: [PATCH BlueZ 10/25] alert: Add initial support for NewAlert D-Bus method
Date: Mon, 24 Sep 2012 14:00:46 -0400
Message-Id: <1348509661-15967-11-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1348509661-15967-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1348509661-15967-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eder Ruiz Maria <eder.ruiz@openbossa.org>

NewAlert() is used for notifying BlueZ of new alert(s) for the given
category.
---
 profiles/alert/server.c |  106 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 1 deletion(-)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index 533d47e..d70f82a 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -62,6 +62,9 @@
 #define ALERT_OBJECT_PATH "/org/bluez"
 #define ALERT_INTERFACE   "org.bluez.Alert"
 
+/* Maximum length for "Text String Information" */
+#define NEW_ALERT_MAX_INFO_SIZE		18
+
 enum {
 	ENABLE_NEW_INCOMING,
 	ENABLE_UNREAD_CAT,
@@ -138,7 +141,7 @@ static const char *valid_category(const char *category)
 	return NULL;
 }
 
-static gboolean registered_category(const char *category)
+static struct alert_data *get_alert_data_by_category(const char *category)
 {
 	GSList *l;
 	struct alert_data *alert;
@@ -146,9 +149,64 @@ static gboolean registered_category(const char *category)
 	for (l = registered_alerts; l; l = g_slist_next(l)) {
 		alert = l->data;
 		if (g_str_equal(alert->category, category))
+			return alert;
+	}
+
+	return NULL;
+}
+
+static gboolean registered_category(const char *category)
+{
+	struct alert_data *alert;
+
+	alert = get_alert_data_by_category(category);
+	if (alert)
+		return TRUE;
+
+	return FALSE;
+}
+
+static gboolean pasp_category(const char *category)
+{
+	unsigned i;
+
+	for (i = 0; i < G_N_ELEMENTS(pasp_categories); i++)
+		if (g_str_equal(category, pasp_categories[i]))
 			return TRUE;
+
+	return FALSE;
+}
+
+static gboolean valid_description(const char *category,
+							const char *description)
+{
+	if (!pasp_category(category)) {
+		if (strlen(description) >= NEW_ALERT_MAX_INFO_SIZE)
+			return FALSE;
+
+		return TRUE;
 	}
 
+	if (g_str_equal(description, "active") ||
+					g_str_equal(description, "not active"))
+		return TRUE;
+
+	if (g_str_equal(category, "ringer"))
+		if (g_str_equal(description, "enabled") ||
+					g_str_equal(description, "disabled"))
+			return TRUE;
+
+	return FALSE;
+}
+
+static gboolean valid_count(const char *category, uint16_t count)
+{
+	if (!pasp_category(category) && count > 0 && count <= 255)
+		return TRUE;
+
+	if (pasp_category(category) && count == 1)
+		return TRUE;
+
 	return FALSE;
 }
 
@@ -188,6 +246,47 @@ static DBusMessage *register_alert(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
+static DBusMessage *new_alert(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	const char *sender = dbus_message_get_sender(msg);
+	const char *category, *description;
+	struct alert_data *alert;
+	uint16_t count;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &category,
+			DBUS_TYPE_UINT16, &count, DBUS_TYPE_STRING,
+			&description, DBUS_TYPE_INVALID))
+		return btd_error_invalid_args(msg);
+
+	alert = get_alert_data_by_category(category);
+	if (!alert) {
+		DBG("Category %s not registered", category);
+		return btd_error_invalid_args(msg);
+	}
+
+	if (!g_str_equal(alert->srv, sender)) {
+		DBG("Sender %s is not registered in category %s", sender,
+								category);
+		return btd_error_invalid_args(msg);
+	}
+
+	if (!valid_description(category, description)) {
+		DBG("Description %s is invalid for %s category",
+							description, category);
+		return btd_error_invalid_args(msg);
+	}
+
+	if (!valid_count(category, count)) {
+		DBG("Count %d is invalid for %s category", count, category);
+		return btd_error_invalid_args(msg);
+	}
+
+	DBG("NewAlert(\"%s\", %d, \"%s\")", category, count, description);
+
+	return dbus_message_new_method_return(msg);
+}
+
 static uint8_t ringer_cp_write(struct attribute *a,
 						struct btd_device *device,
 						gpointer user_data)
@@ -374,6 +473,11 @@ static const GDBusMethodTable alert_methods[] = {
 			GDBUS_ARGS({ "category", "s" },
 				   { "agent", "o" }), NULL,
 			register_alert) },
+	{ GDBUS_METHOD("NewAlert",
+			GDBUS_ARGS({ "category", "s" },
+				   { "count", "q" },
+				   { "description", "s" }), NULL,
+			new_alert) },
 	{ }
 };
 
-- 
1.7.9.5

