Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Eder Ruiz Maria <eder.ruiz@openbossa.org>
Subject: [PATCH v2 BlueZ 23/27] alert: Add support for alert status notification
Date: Thu, 27 Sep 2012 14:36:32 -0400
Message-Id: <1348770996-12236-24-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1348770996-12236-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1348509661-15967-1-git-send-email-anderson.lizardo@openbossa.org>
 <1348770996-12236-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Eder Ruiz Maria <eder.ruiz@openbossa.org>

The notification is sent (to peer devices that have it enabled on the
CCC descriptor) every time the alert status characteristic value
changes.
---
 profiles/alert/server.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index 6fc6384..e4ad7e2 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -94,6 +94,7 @@ enum {
 
 enum notify_type {
 	NOTIFY_RINGER_SETTING = 0,
+	NOTIFY_ALERT_STATUS,
 	NOTIFY_SIZE,
 };
 
@@ -345,6 +346,11 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 				&ringer_setting, sizeof(ringer_setting),
 				pdu, sizeof(pdu));
 		break;
+	case NOTIFY_ALERT_STATUS:
+		len = enc_notification(al_adapter->hnd_value[type],
+				&alert_status, sizeof(alert_status),
+				pdu, sizeof(pdu));
+		break;
 	default:
 		DBG("Unknown type, could not send notification");
 		goto end;
@@ -499,10 +505,14 @@ static void update_phone_alerts(const char *category, const char *description)
 
 	for (i = 0; i < G_N_ELEMENTS(pasp_categories); i++) {
 		if (g_str_equal(pasp_categories[i], category)) {
-			if (g_str_equal(description, "active"))
+			if (g_str_equal(description, "active")) {
 				alert_status |= (1 << i);
-			else if (g_str_equal(description, "not active"))
+				pasp_notification(NOTIFY_ALERT_STATUS);
+			} else if (g_str_equal(description, "not active")) {
 				alert_status &= ~(1 << i);
+				pasp_notification(NOTIFY_ALERT_STATUS);
+			}
+			break;
 		}
 	}
 }
@@ -755,6 +765,10 @@ static void register_phone_alert_service(struct alert_adapter *al_adapter)
 							ATT_CHAR_PROPER_NOTIFY,
 			GATT_OPT_CHR_VALUE_CB, ATTRIB_READ,
 			alert_status_read, al_adapter->adapter,
+			GATT_OPT_CCC_GET_HANDLE,
+			&al_adapter->hnd_ccc[NOTIFY_ALERT_STATUS],
+			GATT_OPT_CHR_VALUE_GET_HANDLE,
+			&al_adapter->hnd_value[NOTIFY_ALERT_STATUS],
 			/* Ringer Control Point characteristic */
 			GATT_OPT_CHR_UUID, RINGER_CP_CHR_UUID,
 			GATT_OPT_CHR_PROPS, ATT_CHAR_PROPER_WRITE_WITHOUT_RESP,
-- 
1.7.9.5

