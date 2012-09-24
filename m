Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 14/25] alert: Update Supported New/Unread Category characteristic values
Date: Mon, 24 Sep 2012 14:00:50 -0400
Message-Id: <1348509661-15967-15-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1348509661-15967-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1348509661-15967-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The value is now kept up-to-date when new/unread alerts arrive. This
value is not notified yet.
---
 profiles/alert/server.c |   34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index fb95f09..f1021cc 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -89,7 +89,8 @@ struct alert_data {
 
 struct alert_adapter {
 	struct btd_adapter *adapter;
-	/* TODO: store characteristic value handles */
+	uint16_t supp_new_alert_cat_handle;
+	uint16_t supp_unread_alert_cat_handle;
 };
 
 static GSList *registered_alerts = NULL;
@@ -235,6 +236,29 @@ static gboolean valid_count(const char *category, uint16_t count)
 	return FALSE;
 }
 
+static void update_supported_categories(gpointer data, gpointer user_data)
+{
+	struct alert_adapter *al_adapter = data;
+	struct btd_adapter *adapter = al_adapter->adapter;
+	uint8_t value[2];
+	unsigned int i;
+
+	memset(value, 0, sizeof(value));
+
+	for (i = 0; i < G_N_ELEMENTS(anp_categories); i++) {
+		if (registered_category(anp_categories[i]))
+			hci_set_bit(i, value);
+	}
+
+	attrib_db_update(adapter, al_adapter->supp_new_alert_cat_handle, NULL,
+						value, sizeof(value), NULL);
+
+	/* FIXME: For now report all registered categories as supporting unread
+	 * status, until it is known which ones should be supported */
+	attrib_db_update(adapter, al_adapter->supp_unread_alert_cat_handle,
+					NULL, value, sizeof(value), NULL);
+}
+
 static void watcher_disconnect(DBusConnection *conn, void *user_data)
 {
 	struct alert_data *alert = user_data;
@@ -243,6 +267,8 @@ static void watcher_disconnect(DBusConnection *conn, void *user_data)
 
 	registered_alerts = g_slist_remove(registered_alerts, alert);
 	alert_data_destroy(alert);
+
+	g_slist_foreach(alert_adapters, update_supported_categories, NULL);
 }
 
 static DBusMessage *register_alert(DBusConnection *conn, DBusMessage *msg,
@@ -285,6 +311,8 @@ static DBusMessage *register_alert(DBusConnection *conn, DBusMessage *msg,
 
 	registered_alerts = g_slist_append(registered_alerts, alert);
 
+	g_slist_foreach(alert_adapters, update_supported_categories, NULL);
+
 	DBG("RegisterAlert(\"%s\", \"%s\")", alert->category, alert->path);
 
 	return dbus_message_new_method_return(msg);
@@ -505,6 +533,8 @@ static void register_alert_notif_service(struct alert_adapter *al_adapter)
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ,
 			GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
 			supp_new_alert_cat_read, al_adapter->adapter,
+			GATT_OPT_CHR_VALUE_GET_HANDLE,
+			&al_adapter->supp_new_alert_cat_handle,
 			/* New Alert */
 			GATT_OPT_CHR_UUID, NEW_ALERT_CHR_UUID,
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_NOTIFY,
@@ -513,6 +543,8 @@ static void register_alert_notif_service(struct alert_adapter *al_adapter)
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ,
 			GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
 			supp_unread_alert_cat_read, al_adapter->adapter,
+			GATT_OPT_CHR_VALUE_GET_HANDLE,
+			&al_adapter->supp_unread_alert_cat_handle,
 			/* Unread Alert Status */
 			GATT_OPT_CHR_UUID, UNREAD_ALERT_CHR_UUID,
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_NOTIFY,
-- 
1.7.9.5

