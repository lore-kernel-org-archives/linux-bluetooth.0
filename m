Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Subject: [PATCH v2 BlueZ 24/27] alert: Add support for new alert notification
Date: Thu, 27 Sep 2012 14:36:33 -0400
Message-Id: <1348770996-12236-25-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1348770996-12236-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1348509661-15967-1-git-send-email-anderson.lizardo@openbossa.org>
 <1348770996-12236-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eder Ruiz Maria <eder.ruiz@openbossa.org>

When NewAlert D-Bus method is called for one category from Alert
Notification Profile, the new alert characteristic value is notified.
---
 profiles/alert/server.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index e4ad7e2..560765b 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -95,6 +95,7 @@ enum {
 enum notify_type {
 	NOTIFY_RINGER_SETTING = 0,
 	NOTIFY_ALERT_STATUS,
+	NOTIFY_NEW_ALERT,
 	NOTIFY_SIZE,
 };
 
@@ -109,7 +110,6 @@ struct alert_adapter {
 	struct btd_adapter *adapter;
 	uint16_t supp_new_alert_cat_handle;
 	uint16_t supp_unread_alert_cat_handle;
-	uint16_t new_alert_handle;
 	uint16_t unread_alert_handle;
 	uint16_t hnd_ccc[NOTIFY_SIZE];
 	uint16_t hnd_value[NOTIFY_SIZE];
@@ -351,6 +351,10 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 				&alert_status, sizeof(alert_status),
 				pdu, sizeof(pdu));
 		break;
+	case NOTIFY_NEW_ALERT:
+		len = enc_notification(al_adapter->hnd_value[type],
+					nd->value, nd->len, pdu, sizeof(pdu));
+		break;
 	default:
 		DBG("Unknown type, could not send notification");
 		goto end;
@@ -483,8 +487,11 @@ static void update_new_alert(gpointer data, gpointer user_data)
 	struct btd_adapter *adapter = al_adapter->adapter;
 	uint8_t *value = user_data;
 
-	attrib_db_update(adapter, al_adapter->new_alert_handle, NULL, &value[1],
-								value[0], NULL);
+        attrib_db_update(adapter,
+				al_adapter->hnd_value[NOTIFY_NEW_ALERT],
+				NULL, &value[1], value[0], NULL);
+
+	notify_devices(al_adapter, NOTIFY_NEW_ALERT, &value[1], value[0]);
 }
 
 static void update_phone_alerts(const char *category, const char *description)
@@ -869,8 +876,10 @@ static void register_alert_notif_service(struct alert_adapter *al_adapter)
 			/* New Alert */
 			GATT_OPT_CHR_UUID, NEW_ALERT_CHR_UUID,
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_NOTIFY,
+			GATT_OPT_CCC_GET_HANDLE,
+			&al_adapter->hnd_ccc[NOTIFY_NEW_ALERT],
 			GATT_OPT_CHR_VALUE_GET_HANDLE,
-			&al_adapter->new_alert_handle,
+			&al_adapter->hnd_value[NOTIFY_NEW_ALERT],
 			/* Supported Unread Alert Category */
 			GATT_OPT_CHR_UUID, SUPP_UNREAD_ALERT_CAT_CHR_UUID,
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_READ,
-- 
1.7.9.5

