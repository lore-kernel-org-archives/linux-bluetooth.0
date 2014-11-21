Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: [PATCH 2/4] hog: break out the report retrieval in its own function
Date: Fri, 21 Nov 2014 15:41:44 +0100
Message-Id: <1416580906-22134-3-git-send-email-dh.herrmann@gmail.com>
In-Reply-To: <1416580906-22134-1-git-send-email-dh.herrmann@gmail.com>
References: <1416580906-22134-1-git-send-email-dh.herrmann@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Benjamin Tissoires <benjamin.tissoires@redhat.com>

HoG currently only implements UHID_OUTPUT. We need to also implement
UHID_GET_REPORT and UHID_SET_REPORT. Break out the report retrieval
to use this function in the two missing implementation.
---
 profiles/input/hog.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index b9aba65..de7e583 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -327,15 +327,12 @@ static void output_written_cb(guint8 status, const guint8 *pdu,
 	}
 }
 
-static void forward_report(struct uhid_event *ev, void *user_data)
+static struct report *find_report(struct hog_device *hogdev, uint8_t type, uint8_t id)
 {
-	struct hog_device *hogdev = user_data;
-	struct report *report, cmp;
+	struct report cmp;
 	GSList *l;
-	uint8_t *data;
-	int size;
 
-	switch (ev->u.output.rtype) {
+	switch (type) {
 	case UHID_FEATURE_REPORT:
 		cmp.type = HOG_REPORT_TYPE_FEATURE;
 		break;
@@ -346,25 +343,36 @@ static void forward_report(struct uhid_event *ev, void *user_data)
 		cmp.type = HOG_REPORT_TYPE_INPUT;
 		break;
 	default:
-		return;
+		return NULL;
 	}
 
-	cmp.id = 0;
+	cmp.id = hogdev->has_report_id ? id : 0;
+
+	l = g_slist_find_custom(hogdev->reports, &cmp, report_cmp);
+
+	return l ? l->data : NULL;
+}
+
+static void forward_report(struct uhid_event *ev, void *user_data)
+{
+	struct hog_device *hogdev = user_data;
+	struct report *report;
+	void *data;
+	int size;
+
+	report = find_report(hogdev, ev->u.output.rtype, ev->u.output.data[0]);
+	if (!report)
+		return;
+
 	data = ev->u.output.data;
 	size = ev->u.output.size;
 	if (hogdev->has_report_id && size > 0) {
-		cmp.id = *data++;
+		data++;
 		--size;
 	}
 
-	l = g_slist_find_custom(hogdev->reports, &cmp, report_cmp);
-	if (!l)
-		return;
-
-	report = l->data;
-
-	DBG("Sending report type %d ID %d to device 0x%04X handle 0x%X",
-		cmp.type, cmp.id, hogdev->id, report->decl->value_handle);
+	DBG("Sending report type %d ID %d to handle 0x%X", report->type,
+				report->id, report->decl->value_handle);
 
 	if (hogdev->attrib == NULL)
 		return;
-- 
2.1.3

