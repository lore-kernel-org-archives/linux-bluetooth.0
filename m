Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCHv2 25/27] android/hog: Remove glib dependencies
Date: Fri,  3 Apr 2015 15:43:54 +0200
Message-Id: <1428068636-13073-26-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1428068636-13073-1-git-send-email-mariusz.skamra@tieto.com>
References: <1428068636-13073-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

All the glib functions and types have been replaced so that
glib can be excluded
---
 android/hog.c | 62 ++++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 22 deletions(-)

diff --git a/android/hog.c b/android/hog.c
index fdcd95a..22aac76 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -36,8 +36,6 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 
-#include <glib.h>
-
 #include "lib/bluetooth.h"
 #include "lib/sdp.h"
 #include "lib/uuid.h"
@@ -88,7 +86,7 @@ struct bt_hog {
 	struct queue		*reports;
 	struct bt_uhid		*uhid;
 	int			uhid_fd;
-	gboolean		has_report_id;
+	bool			has_report_id;
 	uint16_t		bcdhid;
 	uint8_t			bcountrycode;
 	uint16_t		proto_mode_handle;
@@ -246,6 +244,15 @@ static void discover_report_cb(struct gatt_db_attribute *attrib,
 					report_reference_cb, report, NULL);
 }
 
+static void report_free(void *data)
+{
+	struct report *report = data;
+
+	free(report->value);
+	free(report->decl);
+	free(report);
+}
+
 static void report_read_cb(bool success, uint8_t att_ecode,
 				const uint8_t *value, uint16_t len,
 				void *user_data)
@@ -258,9 +265,15 @@ static void report_read_cb(bool success, uint8_t att_ecode,
 	}
 
 	if (report->value)
-		g_free(report->value);
+		free(report->value);
 
-	report->value = g_memdup(value, len);
+	report->value = new0(uint8_t, len);
+	if (!report->value) {
+		report_free(report);
+		return;
+	}
+
+	memcpy(report->value, value, len);
 	report->len = len;
 }
 
@@ -269,9 +282,17 @@ static struct report *report_new(struct bt_hog *hog, uint16_t value_handle,
 {
 	struct report *report;
 
-	report = g_new0(struct report, 1);
-	report->hog = hog;
+	report = new0(struct report, 1);
+	if (!report)
+		return NULL;
+
 	report->decl = new0(struct gatt_char, 1);
+	if (!report->decl) {
+		free(report);
+		return NULL;
+	}
+
+	report->hog = hog;
 	report->decl->value_handle = value_handle;
 	report->decl->properties = properties;
 	queue_push_tail(hog->reports, report);
@@ -294,6 +315,9 @@ static void external_service_char_cb(void *data, void *user_data)
 							&properties, NULL);
 
 	report = report_new(hog, value_handle, properties);
+	if (!report)
+		return;
+
 	gatt_db_service_foreach_desc(attrib, discover_report_cb, report);
 }
 
@@ -598,7 +622,7 @@ static void get_report(struct uhid_event *ev, void *user_data)
 {
 	struct bt_hog *hog = user_data;
 	struct report *report;
-	guint8 err;
+	uint8_t err;
 
 	/* uhid never sends reqs in parallel; if there's a req, it timed out */
 	if (hog->getrep_att) {
@@ -750,7 +774,7 @@ static void report_map_read_cb(bool success, uint8_t att_ecode,
 								&long_item)) {
 			/* Report ID is short item with prefix 100001xx */
 			if (!long_item && (value[i] & 0xfc) == 0x84)
-				hog->has_report_id = TRUE;
+				hog->has_report_id = true;
 
 			DBG("\t%s", item2string(itemstr, &value[i], ilen));
 
@@ -837,6 +861,9 @@ static void char_discovered_cb(struct gatt_db_attribute *attrib,
 
 	if (!bt_uuid_cmp(&uuid, &report_uuid)) {
 		report = report_new(hog, value_handle, properties);
+		if (!report)
+			return;
+
 		gatt_db_service_foreach_desc(attrib, discover_report_cb,
 									report);
 	} else if (!bt_uuid_cmp(&uuid, &report_map_uuid)) {
@@ -855,15 +882,6 @@ static void char_discovered_cb(struct gatt_db_attribute *attrib,
 	}
 }
 
-static void report_free(void *data)
-{
-	struct report *report = data;
-
-	g_free(report->value);
-	free(report->decl);
-	g_free(report);
-}
-
 static void hog_free(void *data)
 {
 	struct bt_hog *hog = data;
@@ -877,8 +895,8 @@ static void hog_free(void *data)
 	bt_dis_unref(hog->dis);
 	bt_uhid_unref(hog->uhid);
 	queue_destroy(hog->reports, report_free);
-	g_free(hog->name);
-	g_free(hog);
+	free(hog->name);
+	free(hog);
 }
 
 struct bt_hog *bt_hog_new_default(const char *name, uint16_t vendor,
@@ -897,7 +915,7 @@ struct bt_hog *bt_hog_new(int fd, const char *name, uint16_t vendor,
 {
 	struct bt_hog *hog;
 
-	hog = g_try_new0(struct bt_hog, 1);
+	hog = new0(struct bt_hog, 1);
 	if (!hog)
 		return NULL;
 
@@ -917,7 +935,7 @@ struct bt_hog *bt_hog_new(int fd, const char *name, uint16_t vendor,
 		return NULL;
 	}
 
-	hog->name = g_strdup(name);
+	hog->name = strdup(name);
 	hog->vendor = vendor;
 	hog->product = product;
 	hog->version = version;
-- 
1.9.1

