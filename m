Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 1/2] heartrate: Fix registration of notification handler
Date: Sat, 13 Oct 2012 17:18:21 +0200
Message-Id: <1350141502-4385-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Notification handler is registered only when CCC is written during
descriptors discovery, i.e. at least one watcher is registered before
device is connected. This means there will be no handler registered in
case watcher is registered after device already connected.
This is side-effect of 74a9fc7.

This patch registers handler immediately when measurement characteristic
is discovered so it does not matter when watcher is registered.

ccc_write_cb() is reduntant in this case so it's removed.
---
 profiles/heartrate/heartrate.c | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 871b74e..81ff310 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -389,21 +389,6 @@ static void notify_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
 	process_measurement(hr, pdu + 3, len - 3);
 }
 
-static void ccc_write_cb(guint8 status, const guint8 *pdu, guint16 len,
-							gpointer user_data)
-{
-	struct heartrate *hr = user_data;
-
-	if (status != 0) {
-		error("Enable measurement failed");
-		return;
-	}
-
-	hr->attionotid = g_attrib_register(hr->attrib, ATT_OP_HANDLE_NOTIFY,
-						hr->measurement_val_handle,
-						notify_handler, hr, NULL);
-}
-
 static void discover_ccc_cb(guint8 status, const guint8 *pdu,
 						guint16 len, gpointer user_data)
 {
@@ -434,6 +419,7 @@ static void discover_ccc_cb(guint8 status, const guint8 *pdu,
 		uuid = att_get_u16(value + 2);
 
 		if (uuid == GATT_CLIENT_CHARAC_CFG_UUID) {
+			char *msg;
 			uint8_t value[2];
 
 			hr->measurement_ccc_handle = handle;
@@ -442,9 +428,10 @@ static void discover_ccc_cb(guint8 status, const guint8 *pdu,
 				break;
 
 			att_put_u16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
+			msg = g_strdup("Enable measurement");
 
 			gatt_write_char(hr->attrib, handle, value,
-					sizeof(value), ccc_write_cb, hr);
+					sizeof(value), char_write_cb, msg);
 
 			break;
 		}
@@ -493,6 +480,11 @@ static void discover_char_cb(GSList *chars, guint8 status, gpointer user_data)
 
 			hr->measurement_val_handle = c->value_handle;
 
+			hr->attionotid = g_attrib_register(hr->attrib,
+						ATT_OP_HANDLE_NOTIFY,
+						c->value_handle,
+						notify_handler, hr, NULL);
+
 			discover_measurement_ccc(hr, c, c_next);
 		} else if (g_strcmp0(c->uuid, BODY_SENSOR_LOCATION_UUID) == 0) {
 			DBG("Body Sensor Location supported");
-- 
1.7.11.3

