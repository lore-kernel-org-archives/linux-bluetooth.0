Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] android/hog: Fix report lookup
Date: Thu,  7 Aug 2014 12:03:51 +0300
Message-Id: <1407402231-32496-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1407402231-32496-1-git-send-email-luiz.dentz@gmail.com>
References: <1407402231-32496-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes not utilizing the report id to match the characteristic that
map it.
---
 android/hog.c | 87 ++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 53 insertions(+), 34 deletions(-)

diff --git a/android/hog.c b/android/hog.c
index 09a16d5..51c7c64 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -382,12 +382,47 @@ static void external_report_reference_cb(guint8 status, const guint8 *pdu,
 					external_service_char_cb, hog);
 }
 
-static int report_type_cmp(gconstpointer a, gconstpointer b)
+
+static int report_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct report *ra = a, *rb = b;
+
+	/* sort by type first.. */
+	if (ra->type != rb->type)
+		return ra->type - rb->type;
+
+	/* skip id check in case of report id 0 */
+	if (!rb->id)
+		return 0;
+
+	/* ..then by id */
+	return ra->id - rb->id;
+}
+
+static struct report *find_report(struct bt_hog *hog, uint8_t type, uint8_t id)
 {
-	const struct report *report = a;
-	uint8_t type = GPOINTER_TO_UINT(b);
+	struct report cmp;
+	GSList *l;
+
+	switch (type) {
+	case UHID_FEATURE_REPORT:
+		cmp.type = HOG_REPORT_TYPE_FEATURE;
+		break;
+	case UHID_OUTPUT_REPORT:
+		cmp.type = HOG_REPORT_TYPE_OUTPUT;
+		break;
+	case UHID_INPUT_REPORT:
+		cmp.type = HOG_REPORT_TYPE_INPUT;
+		break;
+	default:
+		return NULL;
+	}
+
+	cmp.id = hog->has_report_id ? id : 0;
 
-	return report->type - type;
+	l = g_slist_find_custom(hog->reports, &cmp, report_cmp);
+
+	return l ? l->data : NULL;
 }
 
 static void output_written_cb(guint8 status, const guint8 *pdu,
@@ -403,30 +438,22 @@ static void forward_report(struct uhid_event *ev, void *user_data)
 {
 	struct bt_hog *hog = user_data;
 	struct report *report;
-	GSList *l;
 	void *data;
 	int size;
-	guint type;
-
-	if (hog->has_report_id) {
-		data = ev->u.output.data + 1;
-		size = ev->u.output.size - 1;
-	} else {
-		data = ev->u.output.data;
-		size = ev->u.output.size;
-	}
 
-	type = HOG_REPORT_TYPE_OUTPUT;
-
-	l = g_slist_find_custom(hog->reports, GUINT_TO_POINTER(type),
-							report_type_cmp);
-	if (!l)
+	report = find_report(hog, ev->u.output.rtype, ev->u.output.data[0]);
+	if (!report)
 		return;
 
-	report = l->data;
+	data = ev->u.output.data;
+	size = ev->u.output.size;
+	if (hog->has_report_id && size > 0) {
+		data++;
+		--size;
+	}
 
-	DBG("Sending report type %d to handle 0x%X", type,
-						report->decl->value_handle);
+	DBG("Sending report type %d ID %d to handle 0x%X", report->type,
+				report->id, report->decl->value_handle);
 
 	if (hog->attrib == NULL)
 		return;
@@ -443,7 +470,6 @@ static void get_report(struct uhid_event *ev, void *user_data)
 {
 	struct bt_hog *hog = user_data;
 	struct report *report;
-	GSList *l;
 	struct uhid_event rsp;
 	int err;
 
@@ -451,16 +477,12 @@ static void get_report(struct uhid_event *ev, void *user_data)
 	rsp.type = UHID_FEATURE_ANSWER;
 	rsp.u.feature_answer.id = ev->u.feature.id;
 
-	l = g_slist_find_custom(hog->reports,
-				GUINT_TO_POINTER(ev->u.feature.rtype),
-				report_type_cmp);
-	if (!l) {
+	report = find_report(hog, ev->u.feature.rtype, ev->u.feature.rnum);
+	if (!report) {
 		rsp.u.feature_answer.err = ENOTSUP;
 		goto done;
 	}
 
-	report = l->data;
-
 	if (!report->value) {
 		rsp.u.feature_answer.err = EIO;
 		goto done;
@@ -1090,13 +1112,10 @@ int bt_hog_send_report(struct bt_hog *hog, void *data, size_t size, int type)
 	if (!hog->attrib)
 		return -ENOTCONN;
 
-	l = g_slist_find_custom(hog->reports, GUINT_TO_POINTER(type),
-							report_type_cmp);
-	if (!l)
+	report = find_report(hog, type, 0);
+	if (!report)
 		return -ENOTSUP;
 
-	report = l->data;
-
 	DBG("hog: Write report, handle 0x%X", report->decl->value_handle);
 
 	if (report->decl->properties & GATT_CHR_PROP_WRITE)
-- 
1.9.3

