Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH v2 BlueZ 16/27] alert: Update unread alert characteristic value
Date: Thu, 27 Sep 2012 14:36:25 -0400
Message-Id: <1348770996-12236-17-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1348770996-12236-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1348509661-15967-1-git-send-email-anderson.lizardo@openbossa.org>
 <1348770996-12236-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Update the attribute value when the unread alert count is changed.
---
 profiles/alert/server.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index 49cf530..e025cb2 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -94,6 +94,7 @@ struct alert_adapter {
 	uint16_t supp_new_alert_cat_handle;
 	uint16_t supp_unread_alert_cat_handle;
 	uint16_t new_alert_handle;
+	uint16_t unread_alert_handle;
 };
 
 static GSList *registered_alerts = NULL;
@@ -396,12 +397,23 @@ static DBusMessage *new_alert(DBusConnection *conn, DBusMessage *msg,
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
@@ -415,12 +427,29 @@ static DBusMessage *unread_alert(DBusConnection *conn, DBusMessage *msg,
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
@@ -587,6 +616,8 @@ static void register_alert_notif_service(struct alert_adapter *al_adapter)
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

