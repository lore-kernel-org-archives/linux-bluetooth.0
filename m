Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH] heartrate: Always write measurement CCC on discovery
Date: Wed, 17 Oct 2012 09:51:33 +0200
Message-ID: <1350460293-31316-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Measurement CCC is written during discovery only in case watcher is
registered and notifications shall be enabled. However, it may happen
that (e.g. during reconnection scenario) notifications are already
enabled on remote but watcher is no longer registered and we will
be receiving unwanted notifications.

This patch makes sure measurement CCC is written to proper value
every time it's discovered during connection.
---
 profiles/heartrate/heartrate.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 9a92960..bcdce8b 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -412,28 +412,30 @@ static void discover_ccc_cb(guint8 status, const guint8 *pdu,
 	for (i = 0; i < list->num; i++) {
 		uint8_t *value;
 		uint16_t handle, uuid;
+		char *msg;
+		uint8_t attr_val[2];
 
 		value = list->data[i];
 		handle = att_get_u16(value);
 		uuid = att_get_u16(value + 2);
 
-		if (uuid == GATT_CLIENT_CHARAC_CFG_UUID) {
-			char *msg;
-			uint8_t value[2];
+		if (uuid != GATT_CLIENT_CHARAC_CFG_UUID)
+			continue;
 
-			hr->measurement_ccc_handle = handle;
+		hr->measurement_ccc_handle = handle;
 
-			if (g_slist_length(hr->hradapter->watchers) == 0)
-				break;
-
-			att_put_u16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
+		if (g_slist_length(hr->hradapter->watchers) == 0) {
+			att_put_u16(0x0000, attr_val);
+			msg = g_strdup("Disable measurement");
+		} else {
+			att_put_u16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, attr_val);
 			msg = g_strdup("Enable measurement");
+		}
 
-			gatt_write_char(hr->attrib, handle, value,
-					sizeof(value), char_write_cb, msg);
+		gatt_write_char(hr->attrib, handle, attr_val,
+				sizeof(attr_val), char_write_cb, msg);
 
-			break;
-		}
+		break;
 	}
 
 done:
-- 
1.7.11.3

