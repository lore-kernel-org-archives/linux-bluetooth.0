Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 3/5] hog: Use the per handle GATT event notifier
Date: Wed, 10 Oct 2012 20:55:55 -0300
Message-Id: <1349913357-25547-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1349913357-25547-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1349913357-25547-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 profiles/input/hog_device.c | 70 +++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/profiles/input/hog_device.c b/profiles/input/hog_device.c
index 52ebd95..9ac7bd7 100644
--- a/profiles/input/hog_device.c
+++ b/profiles/input/hog_device.c
@@ -76,7 +76,6 @@ struct hog_device {
 	struct btd_device	*device;
 	GAttrib			*attrib;
 	guint			attioid;
-	guint			report_cb_id;
 	struct gatt_primary	*hog_primary;
 	GSList			*reports;
 	int			uhid_fd;
@@ -92,27 +91,18 @@ struct hog_device {
 struct report {
 	uint8_t			id;
 	uint8_t			type;
+	guint			notifyid;
 	struct gatt_char	*decl;
 	struct hog_device	*hogdev;
 };
 
-static gint report_handle_cmp(gconstpointer a, gconstpointer b)
-{
-	const struct report *report = a;
-	uint16_t handle = GPOINTER_TO_UINT(b);
-
-	return report->decl->value_handle - handle;
-}
-
 static void report_value_cb(const uint8_t *pdu, uint16_t len,
 							gpointer user_data)
 {
-	struct hog_device *hogdev = user_data;
+	struct report *report = user_data;
+	struct hog_device *hogdev = report->hogdev;
 	struct uhid_event ev;
 	uint16_t report_size = len - 3;
-	guint handle;
-	GSList *l;
-	struct report *report;
 	uint8_t *buf;
 
 	if (len < 3) { /* 1-byte opcode + 2-byte handle */
@@ -120,17 +110,6 @@ static void report_value_cb(const uint8_t *pdu, uint16_t len,
 		return;
 	}
 
-	handle = att_get_u16(&pdu[1]);
-
-	l = g_slist_find_custom(hogdev->reports, GUINT_TO_POINTER(handle),
-							report_handle_cmp);
-	if (!l) {
-		error("Invalid report");
-		return;
-	}
-
-	report = l->data;
-
 	memset(&ev, 0, sizeof(ev));
 	ev.type = UHID_INPUT;
 	ev.u.input.size = MIN(report_size, UHID_DATA_MAX);
@@ -154,22 +133,31 @@ static void report_value_cb(const uint8_t *pdu, uint16_t len,
 static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data)
 {
+	struct report *report = user_data;
+	struct hog_device *hogdev = report->hogdev;
+
 	if (status != 0) {
 		error("Write report characteristic descriptor failed: %s",
 							att_ecode2str(status));
 		return;
 	}
 
+	report->notifyid = g_attrib_register(hogdev->attrib,
+					ATT_OP_HANDLE_NOTIFY,
+					report->decl->value_handle,
+					report_value_cb, report, NULL);
+
 	DBG("Report characteristic descriptor written: notifications enabled");
 }
 
 static void write_ccc(uint16_t handle, gpointer user_data)
 {
-	struct hog_device *hogdev = user_data;
+	struct report *report = user_data;
+	struct hog_device *hogdev = report->hogdev;
 	uint8_t value[] = { 0x01, 0x00 };
 
 	gatt_write_char(hogdev->attrib, handle, value, sizeof(value),
-					report_ccc_written_cb, hogdev);
+					report_ccc_written_cb, report);
 }
 
 static void report_reference_cb(guint8 status, const guint8 *pdu,
@@ -196,6 +184,7 @@ static void report_reference_cb(guint8 status, const guint8 *pdu,
 static void external_report_reference_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data);
 
+
 static void discover_descriptor_cb(guint8 status, const guint8 *pdu,
 					guint16 len, gpointer user_data)
 {
@@ -229,7 +218,7 @@ static void discover_descriptor_cb(guint8 status, const guint8 *pdu,
 		switch (uuid16) {
 		case GATT_CLIENT_CHARAC_CFG_UUID:
 			report = user_data;
-			write_ccc(handle, report->hogdev);
+			write_ccc(handle, report);
 			break;
 		case GATT_REPORT_REFERENCE:
 			report = user_data;
@@ -608,27 +597,37 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 {
 	struct hog_device *hogdev = user_data;
 	struct gatt_primary *prim = hogdev->hog_primary;
+	GSList *l;
 
 	hogdev->attrib = g_attrib_ref(attrib);
 
-	hogdev->report_cb_id = g_attrib_register(hogdev->attrib,
-					ATT_OP_HANDLE_NOTIFY,
-					GATTRIB_ALL_HANDLES,
-					report_value_cb, hogdev, NULL);
-
 	if (hogdev->reports == NULL) {
 		gatt_discover_char(hogdev->attrib, prim->range.start,
 						prim->range.end, NULL,
 						char_discovered_cb, hogdev);
+		return;
+	}
+
+	for (l = hogdev->reports; l; l = l->next) {
+		struct report *r = l->data;
+
+		r->notifyid = g_attrib_register(hogdev->attrib,
+					ATT_OP_HANDLE_NOTIFY,
+					r->decl->value_handle,
+					report_value_cb, r, NULL);
 	}
 }
 
 static void attio_disconnected_cb(gpointer user_data)
 {
 	struct hog_device *hogdev = user_data;
+	GSList *l;
+
+	for (l = hogdev->reports; l; l = l->next) {
+		struct report *r = l->data;
 
-	g_attrib_unregister(hogdev->attrib, hogdev->report_cb_id);
-	hogdev->report_cb_id = 0;
+		g_attrib_unregister(hogdev->attrib, r->notifyid);
+	}
 
 	g_attrib_unref(hogdev->attrib);
 	hogdev->attrib = NULL;
@@ -652,6 +651,9 @@ static struct hog_device *hog_device_new(struct btd_device *device,
 static void report_free(void *data)
 {
 	struct report *report = data;
+	struct hog_device *hogdev = report->hogdev;
+
+	g_attrib_unregister(hogdev->attrib, report->notifyid);
 	g_free(report->decl);
 	g_free(report);
 }
-- 
1.7.12.3

