Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Murat Kilivan <Murat.Kilivan@csr.com>,
	Aravind Parvathala <Aravind.Parvathala@csr.com>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH] hog: fix output-report to attr mapping
Date: Tue,  5 Aug 2014 15:38:16 +0200
Message-Id: <1407245896-23211-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of mapping all UHID_OUTPUT events blindly to the first hid output
report found, we now map it to the correct attribute. We use the rtype and
report-id information in each UHID_OUTPUT message and map it according to
the mapping-characteristics provided by the device.
---
 profiles/input/hog.c | 55 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index df2b30b..30f9ed1 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -306,12 +306,16 @@ static void external_report_reference_cb(guint8 status, const guint8 *pdu,
 					external_service_char_cb, hogdev);
 }
 
-static int report_type_cmp(gconstpointer a, gconstpointer b)
+static int report_cmp(gconstpointer a, gconstpointer b)
 {
-	const struct report *report = a;
-	uint8_t type = GPOINTER_TO_UINT(b);
+	const struct report *ra = a, *rb = b;
 
-	return report->type - type;
+	/* sort by type first.. */
+	if (ra->type != rb->type)
+		return ra->type - rb->type;
+
+	/* ..then by id */
+	return ra->id - rb->id;
 }
 
 static void output_written_cb(guint8 status, const guint8 *pdu,
@@ -326,31 +330,44 @@ static void output_written_cb(guint8 status, const guint8 *pdu,
 static void forward_report(struct uhid_event *ev, void *user_data)
 {
 	struct hog_device *hogdev = user_data;
-	struct report *report;
+	struct report *report, cmp;
 	GSList *l;
-	void *data;
-	int size;
-	guint type;
+	uint8_t *data;
+	int size, type, id;
+
+	switch (ev->u.output.rtype) {
+	case UHID_FEATURE_REPORT:
+		type = HOG_REPORT_TYPE_FEATURE;
+		break;
+	case UHID_OUTPUT_REPORT:
+		type = HOG_REPORT_TYPE_OUTPUT;
+		break;
+	case UHID_INPUT_REPORT:
+		type = HOG_REPORT_TYPE_INPUT;
+		break;
+	default:
+		return;
+	}
 
-	if (hogdev->has_report_id) {
-		data = ev->u.output.data + 1;
-		size = ev->u.output.size - 1;
-	} else {
-		data = ev->u.output.data;
-		size = ev->u.output.size;
+	id = 0;
+	data = ev->u.output.data;
+	size = ev->u.output.size;
+	if (hogdev->has_report_id && size > 0) {
+		id = *data++;
+		--size;
 	}
 
-	type = HOG_REPORT_TYPE_OUTPUT;
+	cmp.type = type;
+	cmp.id = id;
 
-	l = g_slist_find_custom(hogdev->reports, GUINT_TO_POINTER(type),
-							report_type_cmp);
+	l = g_slist_find_custom(hogdev->reports, &cmp, report_cmp);
 	if (!l)
 		return;
 
 	report = l->data;
 
-	DBG("Sending report type %d to device 0x%04X handle 0x%X", type,
-				hogdev->id, report->decl->value_handle);
+	DBG("Sending report type %d ID %d to device 0x%04X handle 0x%X",
+			type, id, hogdev->id, report->decl->value_handle);
 
 	if (hogdev->attrib == NULL)
 		return;
-- 
2.0.4

