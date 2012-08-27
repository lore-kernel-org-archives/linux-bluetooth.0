Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ 17/22] alert: Update unread alert characteristic value
Date: Mon, 27 Aug 2012 13:12:01 -0400
Message-Id: <1346087526-15107-18-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1346087526-15107-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1346087526-15107-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/alert/server.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index a06429c..bdf13ee 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -91,6 +91,7 @@ struct alert_adapter {
 	uint16_t supp_new_alert_cat_handle;
 	uint16_t supp_unread_alert_cat_handle;
 	uint16_t new_alert_handle;
+	uint16_t unread_alert_handle;
 };
 
 static DBusConnection *connection = NULL;
@@ -395,12 +396,23 @@ static DBusMessage *new_alert(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
+static void update_unread_alert(gpointer data, gpointer user_data)
+{
+	struct alert_adapter *al_adapter = data;
+	struct btd_adapter *adapter = al_adapter->adapter;
+	uint8_t *value = user_data;
+
+	attrib_db_update(adapter, al_adapter->unread_alert_handle, NULL, value,
+								2, NULL);
+}
+
 static DBusMessage *unread_alert(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
 	const char *sender = dbus_message_get_sender(msg);
 	struct alert_data *alert;
 	const char *category;
+	unsigned int i;
 	uint16_t count;
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &category,
@@ -414,12 +426,29 @@ static DBusMessage *unread_alert(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_invalid_args(msg);
 	}
 
+	if (!valid_count(category, count)) {
+		DBG("Count %d is invalid for %s category", count, category);
+		return btd_error_invalid_args(msg);
+	}
+
 	if (!g_str_equal(alert->srv, sender)) {
 		DBG("Sender %s is not registered in category %s", sender,
 								category);
 		return btd_error_invalid_args(msg);
 	}
 
+	for (i = 0; i < G_N_ELEMENTS(anp_categories); i++) {
+		if (g_str_equal(anp_categories[i], category)) {
+			uint8_t value[2];
+
+			value[0] = i; /* Category ID */
+			value[1] = count; /* Unread count */
+
+			g_slist_foreach(alert_adapters, update_unread_alert,
+									value);
+		}
+	}
+
 	DBG("category %s, count %d", category, count);
 
 	return dbus_message_new_method_return(msg);
@@ -586,6 +615,8 @@ static void register_alert_notif_service(struct alert_adapter *al_adapter)
 			/* Unread Alert Status */
 			GATT_OPT_CHR_UUID, UNREAD_ALERT_CHR_UUID,
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_NOTIFY,
+			GATT_OPT_CHR_VALUE_GET_HANDLE,
+			&al_adapter->unread_alert_handle,
 			/* Alert Notification Control Point */
 			GATT_OPT_CHR_UUID, ALERT_NOTIF_CP_CHR_UUID,
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_WRITE,
-- 
1.7.9.5

