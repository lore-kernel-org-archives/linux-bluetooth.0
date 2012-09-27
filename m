Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH v2 BlueZ 11/27] alert: Add initial support for UnreadAlert D-Bus method
Date: Thu, 27 Sep 2012 14:36:20 -0400
Message-Id: <1348770996-12236-12-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1348770996-12236-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1348509661-15967-1-git-send-email-anderson.lizardo@openbossa.org>
 <1348770996-12236-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This method is used for updating the "unread" counter for categories
that support it.
---
 profiles/alert/server.c |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index ce8404c..e7eb38f 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -287,6 +287,36 @@ static DBusMessage *new_alert(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
+static DBusMessage *unread_alert(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	const char *sender = dbus_message_get_sender(msg);
+	struct alert_data *alert;
+	const char *category;
+	uint16_t count;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &category,
+						DBUS_TYPE_UINT16, &count,
+						DBUS_TYPE_INVALID))
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
+	DBG("category %s, count %d", category, count);
+
+	return dbus_message_new_method_return(msg);
+}
+
 static uint8_t ringer_cp_write(struct attribute *a,
 						struct btd_device *device,
 						gpointer user_data)
@@ -480,6 +510,9 @@ static const GDBusMethodTable alert_methods[] = {
 				   { "count", "q" },
 				   { "description", "s" }), NULL,
 			new_alert) },
+	{ GDBUS_METHOD("UnreadAlert",
+			GDBUS_ARGS({ "category", "s" }, { "count", "q" }), NULL,
+			unread_alert) },
 	{ }
 };
 
-- 
1.7.9.5

