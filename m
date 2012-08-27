Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ 15/22] alert: Update Supported New/Unread Category characteristic values
Date: Mon, 27 Aug 2012 13:11:59 -0400
Message-Id: <1346087526-15107-16-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1346087526-15107-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1346087526-15107-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/alert/server.c |   34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index b717c51..b06ef20 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -86,7 +86,8 @@ struct alert_data {
 
 struct alert_adapter {
 	struct btd_adapter *adapter;
-	/* TODO: store characteristic value handles */
+	uint16_t supp_new_alert_cat_handle;
+	uint16_t supp_unread_alert_cat_handle;
 };
 
 static DBusConnection *connection = NULL;
@@ -233,6 +234,29 @@ static gboolean valid_count(const char *category, uint16_t count)
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
@@ -242,6 +266,8 @@ static void watcher_disconnect(DBusConnection *conn, void *user_data)
 	registered_alerts = g_slist_remove(registered_alerts, alert);
 	g_dbus_remove_watch(connection, alert->watcher);
 	alert_data_destroy(alert);
+
+	g_slist_foreach(alert_adapters, update_supported_categories, NULL);
 }
 
 static DBusMessage *register_alert(DBusConnection *conn, DBusMessage *msg,
@@ -284,6 +310,8 @@ static DBusMessage *register_alert(DBusConnection *conn, DBusMessage *msg,
 
 	registered_alerts = g_slist_append(registered_alerts, alert);
 
+	g_slist_foreach(alert_adapters, update_supported_categories, NULL);
+
 	DBG("RegisterAlert(\"%s\", \"%s\")", alert->category, alert->path);
 
 	return dbus_message_new_method_return(msg);
@@ -504,6 +532,8 @@ static void register_alert_notif_service(struct alert_adapter *al_adapter)
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ,
 			GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
 			supp_new_alert_cat_read, al_adapter->adapter,
+			GATT_OPT_CHR_VALUE_GET_HANDLE,
+			&al_adapter->supp_new_alert_cat_handle,
 			/* New Alert */
 			GATT_OPT_CHR_UUID, NEW_ALERT_CHR_UUID,
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_NOTIFY,
@@ -512,6 +542,8 @@ static void register_alert_notif_service(struct alert_adapter *al_adapter)
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

