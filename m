Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Subject: [PATCH v2 BlueZ 25/27] alert: Add support for unread alert notification
Date: Thu, 27 Sep 2012 14:36:34 -0400
Message-Id: <1348770996-12236-26-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1348770996-12236-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1348509661-15967-1-git-send-email-anderson.lizardo@openbossa.org>
 <1348770996-12236-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eder Ruiz Maria <eder.ruiz@openbossa.org>

When UnreadAlert D-Bus method is called for a registered category
from Alert Notification Profile, The unread alert characteristic value
is notified.
---
 profiles/alert/server.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index 560765b..c631e0d 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -96,6 +96,7 @@ enum notify_type {
 	NOTIFY_RINGER_SETTING = 0,
 	NOTIFY_ALERT_STATUS,
 	NOTIFY_NEW_ALERT,
+	NOTIFY_UNREAD_ALERT,
 	NOTIFY_SIZE,
 };
 
@@ -110,7 +111,6 @@ struct alert_adapter {
 	struct btd_adapter *adapter;
 	uint16_t supp_new_alert_cat_handle;
 	uint16_t supp_unread_alert_cat_handle;
-	uint16_t unread_alert_handle;
 	uint16_t hnd_ccc[NOTIFY_SIZE];
 	uint16_t hnd_value[NOTIFY_SIZE];
 };
@@ -352,6 +352,7 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 				pdu, sizeof(pdu));
 		break;
 	case NOTIFY_NEW_ALERT:
+	case NOTIFY_UNREAD_ALERT:
 		len = enc_notification(al_adapter->hnd_value[type],
 					nd->value, nd->len, pdu, sizeof(pdu));
 		break;
@@ -645,8 +646,11 @@ static void update_unread_alert(gpointer data, gpointer user_data)
 	struct btd_adapter *adapter = al_adapter->adapter;
 	uint8_t *value = user_data;
 
-	attrib_db_update(adapter, al_adapter->unread_alert_handle, NULL, value,
-								2, NULL);
+	attrib_db_update(adapter,
+			al_adapter->hnd_value[NOTIFY_UNREAD_ALERT], NULL, value,
+			2, NULL);
+
+	notify_devices(al_adapter, NOTIFY_UNREAD_ALERT, value, 2);
 }
 
 static DBusMessage *unread_alert(DBusConnection *conn, DBusMessage *msg,
@@ -890,8 +894,10 @@ static void register_alert_notif_service(struct alert_adapter *al_adapter)
 			/* Unread Alert Status */
 			GATT_OPT_CHR_UUID, UNREAD_ALERT_CHR_UUID,
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_NOTIFY,
+			GATT_OPT_CCC_GET_HANDLE,
+			&al_adapter->hnd_ccc[NOTIFY_UNREAD_ALERT],
 			GATT_OPT_CHR_VALUE_GET_HANDLE,
-			&al_adapter->unread_alert_handle,
+			&al_adapter->hnd_value[NOTIFY_UNREAD_ALERT],
 			/* Alert Notification Control Point */
 			GATT_OPT_CHR_UUID, ALERT_NOTIF_CP_CHR_UUID,
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_WRITE,
-- 
1.7.9.5

