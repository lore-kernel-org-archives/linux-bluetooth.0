Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH 27/28] android/hog: Remove glib dependencies
Date: Wed,  1 Apr 2015 18:40:43 +0200
Message-Id: <1427906444-11769-28-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1427906444-11769-1-git-send-email-mariusz.skamra@tieto.com>
References: <1427906444-11769-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

All the glib functions and types have been replaced so that
glib can be excluded
---
 android/hog.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/android/hog.c b/android/hog.c
index c2017f8..a18275e 100644
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
@@ -93,7 +91,7 @@ struct bt_hog {
 	struct queue		*reports;
 	struct bt_uhid		*uhid;
 	int			uhid_fd;
-	gboolean		has_report_id;
+	bool			has_report_id;
 	uint16_t		bcdhid;
 	uint8_t			bcountrycode;
 	uint16_t		proto_mode_handle;
@@ -263,9 +261,10 @@ static void report_read_cb(bool success, uint8_t att_ecode,
 	}
 
 	if (report->value)
-		g_free(report->value);
+		free(report->value);
 
-	report->value = g_memdup(value, len);
+	report->value = new0(uint8_t, len);
+	memcpy(report->value, value, len);
 	report->len = len;
 }
 
@@ -274,7 +273,7 @@ static struct report *report_new(struct bt_hog *hog, uint16_t value_handle,
 {
 	struct report *report;
 
-	report = g_new0(struct report, 1);
+	report = new0(struct report, 1);
 	report->hog = hog;
 	report->decl = new0(struct gatt_char, 1);
 	report->decl->value_handle = value_handle;
@@ -600,7 +599,7 @@ static void get_report(struct uhid_event *ev, void *user_data)
 {
 	struct bt_hog *hog = user_data;
 	struct report *report;
-	guint8 err;
+	uint8_t err;
 
 	/* uhid never sends reqs in parallel; if there's a req, it timed out */
 	if (hog->getrep_att) {
@@ -752,7 +751,7 @@ static void report_map_read_cb(bool success, uint8_t att_ecode,
 								&long_item)) {
 			/* Report ID is short item with prefix 100001xx */
 			if (!long_item && (value[i] & 0xfc) == 0x84)
-				hog->has_report_id = TRUE;
+				hog->has_report_id = true;
 
 			DBG("\t%s", item2string(itemstr, &value[i], ilen));
 
@@ -854,9 +853,9 @@ static void report_free(void *data)
 {
 	struct report *report = data;
 
-	g_free(report->value);
+	free(report->value);
 	free(report->decl);
-	g_free(report);
+	free(report);
 }
 
 static void hog_free(void *data)
@@ -872,8 +871,8 @@ static void hog_free(void *data)
 	bt_dis_unref(hog->dis);
 	bt_uhid_unref(hog->uhid);
 	queue_destroy(hog->reports, report_free);
-	g_free(hog->name);
-	g_free(hog);
+	free(hog->name);
+	free(hog);
 }
 
 struct bt_hog *bt_hog_new_default(const char *name, uint16_t vendor,
@@ -892,7 +891,7 @@ struct bt_hog *bt_hog_new(int fd, const char *name, uint16_t vendor,
 {
 	struct bt_hog *hog;
 
-	hog = g_try_new0(struct bt_hog, 1);
+	hog = new0(struct bt_hog, 1);
 	if (!hog)
 		return NULL;
 
@@ -912,7 +911,7 @@ struct bt_hog *bt_hog_new(int fd, const char *name, uint16_t vendor,
 		return NULL;
 	}
 
-	hog->name = g_strdup(name);
+	hog->name = strdup(name);
 	hog->vendor = vendor;
 	hog->product = product;
 	hog->version = version;
-- 
1.9.1

