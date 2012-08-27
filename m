Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ 14/22] alert: Add per adapter attribute handle information
Date: Mon, 27 Aug 2012 13:11:58 -0400
Message-Id: <1346087526-15107-15-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1346087526-15107-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1346087526-15107-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Each adapter may have different GATT services running, therefore any
attribute handles (e.g. for updating characteristic values) need to be
saved per adapter.
---
 profiles/alert/server.c |   57 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 10 deletions(-)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index c77e1f1..b717c51 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -84,8 +84,14 @@ struct alert_data {
 	guint watcher;
 };
 
+struct alert_adapter {
+	struct btd_adapter *adapter;
+	/* TODO: store characteristic value handles */
+};
+
 static DBusConnection *connection = NULL;
 static GSList *registered_alerts = NULL;
+static GSList *alert_adapters = NULL;
 static uint8_t ringer_setting = RINGER_NORMAL;
 static uint8_t alert_status = 0;
 
@@ -108,6 +114,21 @@ static const char *pasp_categories[] = {
 	"display",
 };
 
+static int adapter_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct alert_adapter *al_adapter = a;
+	const struct btd_adapter *adapter = b;
+
+	return (al_adapter->adapter == adapter ? 0 : -1);
+}
+
+static struct alert_adapter *find_alert_adapter(struct btd_adapter *adapter)
+{
+	GSList *l = g_slist_find_custom(alert_adapters, adapter, adapter_cmp);
+
+	return (l ? l->data : NULL);
+}
+
 static void alert_data_destroy(gpointer user_data)
 {
 	struct alert_data *alert = user_data;
@@ -378,20 +399,20 @@ static uint8_t ringer_setting_read(struct attribute *a,
 	return 0;
 }
 
-static void register_phone_alert_service(struct btd_adapter *adapter)
+static void register_phone_alert_service(struct alert_adapter *al_adapter)
 {
 	bt_uuid_t uuid;
 
 	bt_uuid16_create(&uuid, PHONE_ALERT_STATUS_SVC_UUID);
 
 	/* Phone Alert Status Service */
-	gatt_service_add(adapter, GATT_PRIM_SVC_UUID, &uuid,
+	gatt_service_add(al_adapter->adapter, GATT_PRIM_SVC_UUID, &uuid,
 			/* Alert Status characteristic */
 			GATT_OPT_CHR_UUID, ALERT_STATUS_CHR_UUID,
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ |
 							ATT_CHAR_PROPER_NOTIFY,
 			GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
-			alert_status_read, adapter,
+			alert_status_read, al_adapter->adapter,
 			/* Ringer Control Point characteristic */
 			GATT_OPT_CHR_UUID, RINGER_CP_CHR_UUID,
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_WRITE_WITHOUT_RESP,
@@ -402,7 +423,7 @@ static void register_phone_alert_service(struct btd_adapter *adapter)
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ |
 							ATT_CHAR_PROPER_NOTIFY,
 			GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
-			ringer_setting_read, adapter,
+			ringer_setting_read, al_adapter->adapter,
 			GATT_OPT_INVALID);
 }
 
@@ -470,19 +491,19 @@ static uint8_t alert_notif_cp_write(struct attribute *a,
 	return 0;
 }
 
-static void register_alert_notif_service(struct btd_adapter *adapter)
+static void register_alert_notif_service(struct alert_adapter *al_adapter)
 {
 	bt_uuid_t uuid;
 
 	bt_uuid16_create(&uuid, ALERT_NOTIF_SVC_UUID);
 
 	/* Alert Notification Service */
-	gatt_service_add(adapter, GATT_PRIM_SVC_UUID, &uuid,
+	gatt_service_add(al_adapter->adapter, GATT_PRIM_SVC_UUID, &uuid,
 			/* Supported New Alert Category */
 			GATT_OPT_CHR_UUID, SUPP_NEW_ALERT_CAT_CHR_UUID,
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ,
 			GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
-			supp_new_alert_cat_read, adapter,
+			supp_new_alert_cat_read, al_adapter->adapter,
 			/* New Alert */
 			GATT_OPT_CHR_UUID, NEW_ALERT_CHR_UUID,
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_NOTIFY,
@@ -490,7 +511,7 @@ static void register_alert_notif_service(struct btd_adapter *adapter)
 			GATT_OPT_CHR_UUID, SUPP_UNREAD_ALERT_CAT_CHR_UUID,
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ,
 			GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
-			supp_unread_alert_cat_read, adapter,
+			supp_unread_alert_cat_read, al_adapter->adapter,
 			/* Unread Alert Status */
 			GATT_OPT_CHR_UUID, UNREAD_ALERT_CHR_UUID,
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_NOTIFY,
@@ -504,14 +525,30 @@ static void register_alert_notif_service(struct btd_adapter *adapter)
 
 static int alert_server_probe(struct btd_adapter *adapter)
 {
-	register_phone_alert_service(adapter);
-	register_alert_notif_service(adapter);
+	struct alert_adapter *al_adapter;
+
+	al_adapter = g_new0(struct alert_adapter, 1);
+	al_adapter->adapter = btd_adapter_ref(adapter);
+
+	alert_adapters = g_slist_append(alert_adapters, al_adapter);
+
+	register_phone_alert_service(al_adapter);
+	register_alert_notif_service(al_adapter);
 
 	return 0;
 }
 
 static void alert_server_remove(struct btd_adapter *adapter)
 {
+	struct alert_adapter *al_adapter;
+
+	al_adapter = find_alert_adapter(adapter);
+	if (!al_adapter)
+		return;
+
+	alert_adapters = g_slist_remove(alert_adapters, al_adapter);
+	btd_adapter_unref(al_adapter->adapter);
+	g_free(al_adapter);
 }
 
 struct btd_adapter_driver alert_server_driver = {
-- 
1.7.9.5

