Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH 1/3] android/bas: Read battery level characteristic
Date: Tue, 24 Feb 2015 19:18:31 +0100
Message-Id: <1424801911-18082-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For TC_HGRF_HH_BV_10_I test purposes, apart from registration for
notification, read request should be sent to get battery level.
---
 android/bas.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/android/bas.c b/android/bas.c
index 3d4bee0..b3fb41f 100644
--- a/android/bas.c
+++ b/android/bas.c
@@ -44,6 +44,7 @@
 #include "android/bas.h"
 
 #define ATT_NOTIFICATION_HEADER_SIZE 3
+#define ATT_READ_RESPONSE_HEADER_SIZE 1
 
 struct bt_bas {
 	int ref_count;
@@ -226,11 +227,17 @@ static void discover_desc(struct bt_bas *bas, GAttrib *attrib,
 	free(req);
 }
 
-static void value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
+static void notification_cb(const guint8 *pdu, guint16 len, gpointer user_data)
 {
 	DBG("Battery Level at %u", pdu[ATT_NOTIFICATION_HEADER_SIZE]);
 }
 
+static void read_value_cb(guint8 status, const guint8 *pdu, guint16 len,
+					gpointer user_data)
+{
+	DBG("Battery Level at %u", pdu[ATT_READ_RESPONSE_HEADER_SIZE]);
+}
+
 static void ccc_written_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data)
 {
@@ -248,7 +255,7 @@ static void ccc_written_cb(guint8 status, const guint8 *pdu,
 	DBG("Battery Level: notification enabled");
 
 	bas->id = g_attrib_register(bas->attrib, ATT_OP_HANDLE_NOTIFY,
-					bas->handle, value_cb, bas, NULL);
+					bas->handle, notification_cb, bas, NULL);
 }
 
 static void write_ccc(struct bt_bas *bas, GAttrib *attrib, uint16_t handle,
@@ -319,6 +326,8 @@ static void bas_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 
 	DBG("Battery handle: 0x%04x", bas->handle);
 
+	read_char(bas, bas->attrib, bas->handle, read_value_cb, bas);
+
 	start = chr->value_handle + 1;
 	end = bas->primary->range.end;
 
-- 
1.9.1

