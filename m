Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ 16/22] alert: Update new alert characteristic value
Date: Mon, 27 Aug 2012 13:12:00 -0400
Message-Id: <1346087526-15107-17-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1346087526-15107-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1346087526-15107-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/alert/server.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index b06ef20..a06429c 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -61,6 +61,8 @@
 
 /* Maximum length for "Text String Information" */
 #define NEW_ALERT_MAX_INFO_SIZE		18
+/* Maximum length for New Alert Characteristic Value */
+#define NEW_ALERT_CHR_MAX_VALUE_SIZE	(NEW_ALERT_MAX_INFO_SIZE + 2)
 
 enum {
 	ENABLE_NEW_INCOMING,
@@ -88,6 +90,7 @@ struct alert_adapter {
 	struct btd_adapter *adapter;
 	uint16_t supp_new_alert_cat_handle;
 	uint16_t supp_unread_alert_cat_handle;
+	uint16_t new_alert_handle;
 };
 
 static DBusConnection *connection = NULL;
@@ -317,6 +320,16 @@ static DBusMessage *register_alert(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
+static void update_new_alert(gpointer data, gpointer user_data)
+{
+	struct alert_adapter *al_adapter = data;
+	struct btd_adapter *adapter = al_adapter->adapter;
+	uint8_t *value = user_data;
+
+	attrib_db_update(adapter, al_adapter->new_alert_handle, NULL, &value[1],
+								value[0], NULL);
+}
+
 static DBusMessage *new_alert(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
@@ -324,6 +337,7 @@ static DBusMessage *new_alert(DBusConnection *conn, DBusMessage *msg,
 	const char *category, *description;
 	struct alert_data *alert;
 	uint16_t count;
+	unsigned int i;
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &category,
 			DBUS_TYPE_UINT16, &count, DBUS_TYPE_STRING,
@@ -353,6 +367,29 @@ static DBusMessage *new_alert(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_invalid_args(msg);
 	}
 
+	for (i = 0; i < G_N_ELEMENTS(anp_categories); i++) {
+		if (g_str_equal(anp_categories[i], category)) {
+			uint8_t value[NEW_ALERT_CHR_MAX_VALUE_SIZE + 1];
+			size_t dlen = strlen(description);
+			uint8_t *ptr = value;
+
+			memset(value, 0, sizeof(value));
+
+			*ptr++ = 2; /* Attribute value size */
+			*ptr++ = i; /* Category ID (mandatory) */
+			*ptr++ = count; /* Number of New Alert (mandatory) */
+			/* Text String Information (optional) */
+			strncpy((char *) ptr, description,
+						NEW_ALERT_MAX_INFO_SIZE - 1);
+
+			if (dlen > 0)
+				*value += dlen + 1;
+
+			g_slist_foreach(alert_adapters, update_new_alert,
+									value);
+		}
+	}
+
 	DBG("NewAlert(\"%s\", %d, \"%s\")", category, count, description);
 
 	return dbus_message_new_method_return(msg);
@@ -537,6 +574,8 @@ static void register_alert_notif_service(struct alert_adapter *al_adapter)
 			/* New Alert */
 			GATT_OPT_CHR_UUID, NEW_ALERT_CHR_UUID,
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_NOTIFY,
+			GATT_OPT_CHR_VALUE_GET_HANDLE,
+			&al_adapter->new_alert_handle,
 			/* Supported Unread Alert Category */
 			GATT_OPT_CHR_UUID, SUPP_UNREAD_ALERT_CAT_CHR_UUID,
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ,
-- 
1.7.9.5

