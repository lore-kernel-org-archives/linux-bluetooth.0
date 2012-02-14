Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 3/3] thermometer: Fix re-enabling notification/indication on reconnection
Date: Tue, 14 Feb 2012 13:52:25 -0400
Message-Id: <1329241945-32414-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1329241945-32414-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1329241945-32414-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If a result callback is not specified for gatt_write_char() it is
assumed that Write Command will be used. This is not valid for
Characteristic Descriptors, which only support Write Request.
---
 thermometer/thermometer.c |   35 +++++++++++++++++++++--------------
 1 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
index 7906d84..d09c63c 100644
--- a/thermometer/thermometer.c
+++ b/thermometer/thermometer.c
@@ -331,6 +331,17 @@ static void valid_range_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 	change_property(desc->ch->t, "Minimum", &min);
 }
 
+static void measurement_cb(guint8 status, const guint8 *pdu,
+						guint16 len, gpointer user_data)
+{
+	char *msg = user_data;
+
+	if (status != 0)
+		error("%s failed", msg);
+
+	g_free(msg);
+}
+
 static void process_thermometer_desc(struct descriptor *desc)
 {
 	struct characteristic *ch = desc->ch;
@@ -342,6 +353,7 @@ static void process_thermometer_desc(struct descriptor *desc)
 	if (bt_uuid_cmp(&desc->uuid, &btuuid) == 0) {
 		uint8_t atval[2];
 		uint16_t val;
+		char *msg;
 
 		if (g_strcmp0(ch->attr.uuid,
 					TEMPERATURE_MEASUREMENT_UUID) == 0) {
@@ -349,21 +361,27 @@ static void process_thermometer_desc(struct descriptor *desc)
 				return;
 
 			val = ATT_CLIENT_CHAR_CONF_INDICATION;
+			msg = g_strdup("Enable Temperature Measurement "
+								"indication");
 		} else if (g_strcmp0(ch->attr.uuid,
 					INTERMEDIATE_TEMPERATURE_UUID) == 0) {
 			if (g_slist_length(ch->t->iwatchers) == 0)
 				return;
 
 			val = ATT_CLIENT_CHAR_CONF_NOTIFICATION;
+			msg = g_strdup("Enable Intermediate Temperature "
+								"notification");
 		} else if (g_strcmp0(ch->attr.uuid,
-					MEASUREMENT_INTERVAL_UUID) == 0)
+					MEASUREMENT_INTERVAL_UUID) == 0) {
 			val = ATT_CLIENT_CHAR_CONF_INDICATION;
-		else
+			msg = g_strdup("Enable Measurement Interval "
+								"indication");
+		} else
 			goto done;
 
 		att_put_u16(val, atval);
 		gatt_write_char(ch->t->attrib, desc->handle, atval, 2,
-								NULL, NULL);
+							measurement_cb, msg);
 		return;
 	}
 
@@ -655,17 +673,6 @@ static DBusMessage *set_property(DBusConnection *conn, DBusMessage *msg,
 	return write_attr_interval(t, msg, value);
 }
 
-static void measurement_cb(guint8 status, const guint8 *pdu,
-						guint16 len, gpointer user_data)
-{
-	char *msg = user_data;
-
-	if (status != 0)
-		error("%s failed", msg);
-
-	g_free(msg);
-}
-
 static void enable_final_measurement(struct thermometer *t)
 {
 	struct characteristic *ch;
-- 
1.7.5.4

