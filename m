Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 15/26] heartrate: Get rid of guint* types
Date: Thu,  9 May 2013 01:16:45 -0300
Message-Id: <1368073016-28434-15-git-send-email-lucas.demarchi@profusion.mobi>
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
 profiles/heartrate/heartrate.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/profiles/heartrate/heartrate.c b/profiles/heartrate/heartrate.c
index 8de81bb..25077ad 100644
--- a/profiles/heartrate/heartrate.c
+++ b/profiles/heartrate/heartrate.c
@@ -24,6 +24,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <errno.h>
 #include <stdbool.h>
 #include <glib.h>
@@ -63,8 +64,8 @@ struct heartrate {
 	struct btd_device		*dev;
 	struct heartrate_adapter	*hradapter;
 	GAttrib				*attrib;
-	guint				attioid;
-	guint				attionotid;
+	unsigned int				attioid;
+	unsigned int				attionotid;
 
 	struct att_range		*svc_range;	/* primary svc range */
 
@@ -77,7 +78,7 @@ struct heartrate {
 
 struct watcher {
 	struct heartrate_adapter	*hradapter;
-	guint				id;
+	unsigned int				id;
 	char				*srv;
 	char				*path;
 };
@@ -222,8 +223,8 @@ static void destroy_heartrate_adapter(gpointer user_data)
 	g_free(hradapter);
 }
 
-static void read_sensor_location_cb(guint8 status, const guint8 *pdu,
-						guint16 len, gpointer user_data)
+static void read_sensor_location_cb(uint8_t status, const uint8_t *pdu,
+					uint16_t len, gpointer user_data)
 {
 	struct heartrate *hr = user_data;
 	uint8_t value;
@@ -250,7 +251,7 @@ static void read_sensor_location_cb(guint8 status, const guint8 *pdu,
 	hr->location = value;
 }
 
-static void char_write_cb(guint8 status, const guint8 *pdu, guint16 len,
+static void char_write_cb(uint8_t status, const uint8_t *pdu, uint16_t len,
 							gpointer user_data)
 {
 	char *msg = user_data;
@@ -390,8 +391,8 @@ static void notify_handler(const uint8_t *pdu, uint16_t len, gpointer user_data)
 	process_measurement(hr, pdu + 3, len - 3);
 }
 
-static void discover_ccc_cb(guint8 status, const guint8 *pdu,
-						guint16 len, gpointer user_data)
+static void discover_ccc_cb(uint8_t status, const uint8_t *pdu,
+					uint16_t len, gpointer user_data)
 {
 	struct heartrate *hr = user_data;
 	struct att_data_list *list;
@@ -464,7 +465,7 @@ static void discover_measurement_ccc(struct heartrate *hr,
 	gatt_find_info(hr->attrib, start, end, discover_ccc_cb, hr);
 }
 
-static void discover_char_cb(GSList *chars, guint8 status, gpointer user_data)
+static void discover_char_cb(GSList *chars, uint8_t status, gpointer user_data)
 {
 	struct heartrate *hr = user_data;
 
-- 
1.8.2.2

