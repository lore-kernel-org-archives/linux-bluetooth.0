Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 21/26] scanparam: Get rid of guint* types
Date: Thu,  9 May 2013 01:16:51 -0300
Message-Id: <1368073016-28434-21-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

guint -> unsigned int
guint8 -> uint8_t
guint16 -> uint16_t
guint32 -> uint32_t
guint64 -> uint64_t

Add "#include <inttypes.h>" where appropriate.
---
 profiles/scanparam/scan.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index a9baec8..2458a7b 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -26,6 +26,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <stdbool.h>
 #include <errno.h>
 
@@ -56,7 +57,7 @@ struct scan {
 	struct btd_device *device;
 	GAttrib *attrib;
 	struct att_range range;
-	guint attioid;
+	unsigned int attioid;
 	uint16_t interval;
 	uint16_t window;
 	uint16_t iwhandle;
@@ -95,8 +96,8 @@ static void refresh_value_cb(const uint8_t *pdu, uint16_t len,
 		write_scan_params(scan->attrib, scan->iwhandle);
 }
 
-static void ccc_written_cb(guint8 status, const guint8 *pdu,
-					guint16 plen, gpointer user_data)
+static void ccc_written_cb(uint8_t status, const uint8_t *pdu,
+					uint16_t plen, gpointer user_data)
 {
 	struct scan *scan = user_data;
 
@@ -113,8 +114,8 @@ static void ccc_written_cb(guint8 status, const guint8 *pdu,
 				refresh_value_cb, scan, NULL);
 }
 
-static void discover_descriptor_cb(guint8 status, const guint8 *pdu,
-					guint16 len, gpointer user_data)
+static void discover_descriptor_cb(uint8_t status, const uint8_t *pdu,
+					uint16_t len, gpointer user_data)
 {
 	struct scan *scan = user_data;
 	struct att_data_list *list;
@@ -144,7 +145,7 @@ done:
 	att_data_list_free(list);
 }
 
-static void refresh_discovered_cb(GSList *chars, guint8 status,
+static void refresh_discovered_cb(GSList *chars, uint8_t status,
 						gpointer user_data)
 {
 	struct scan *scan = user_data;
@@ -177,7 +178,7 @@ static void refresh_discovered_cb(GSList *chars, guint8 status,
 				discover_descriptor_cb, user_data);
 }
 
-static void iwin_discovered_cb(GSList *chars, guint8 status,
+static void iwin_discovered_cb(GSList *chars, uint8_t status,
 						gpointer user_data)
 {
 	struct scan *scan = user_data;
-- 
1.8.2.2

