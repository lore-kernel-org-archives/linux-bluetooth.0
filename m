Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ 04/13] hog: Prepend Report ID to the HID report
Date: Tue, 10 Jul 2012 16:16:56 -0300
Message-Id: <1341947825-14789-5-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1341947825-14789-1-git-send-email-jprvita@openbossa.org>
References: <1341947825-14789-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If the report descriptor has a Report ID tag it has to be prepended
to the report data to construct the HID report itself.
---
 profiles/input/hog_device.c |   78 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 64 insertions(+), 14 deletions(-)

diff --git a/profiles/input/hog_device.c b/profiles/input/hog_device.c
index 823d7a4..53b4746 100644
--- a/profiles/input/hog_device.c
+++ b/profiles/input/hog_device.c
@@ -57,10 +57,6 @@
 
 #define HOG_REPORT_MAP_MAX_SIZE        512
 
-struct report {
-	struct gatt_char *decl;
-};
-
 struct hog_device {
 	char			*path;
 	struct btd_device	*device;
@@ -70,25 +66,64 @@ struct hog_device {
 	struct gatt_primary	*hog_primary;
 	GSList			*reports;
 	int			uhid_fd;
+	gboolean		prepend_id;
+};
+
+struct report {
+	uint8_t			id;
+	uint8_t			type;
+	struct gatt_char	*decl;
+	struct hog_device	*hogdev;
 };
 
 static GSList *devices = NULL;
 
+static gint report_handle_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct report *report = a;
+	uint16_t handle = GPOINTER_TO_UINT(b);
+
+	return report->decl->value_handle - handle;
+}
+
 static void report_value_cb(const uint8_t *pdu, uint16_t len, gpointer user_data)
 {
 	struct hog_device *hogdev = user_data;
 	struct uhid_event ev;
 	uint16_t report_size = len - 3;
+	guint handle;
+	GSList *l;
+	struct report *report;
+	uint8_t *buf;
 
 	if (len < 3) { /* 1-byte opcode + 2-byte handle */
 		error("Malformed ATT notification");
 		return;
 	}
 
+	handle = att_get_u16(&pdu[1]);
+
+	l = g_slist_find_custom(hogdev->reports, GUINT_TO_POINTER(handle),
+							report_handle_cmp);
+	if (!l) {
+		error("Invalid report");
+		return;
+	}
+
+	report = l->data;
+
 	memset(&ev, 0, sizeof(ev));
 	ev.type = UHID_INPUT;
 	ev.u.input.size = MIN(report_size, UHID_DATA_MAX);
-	memcpy(ev.u.input.data, &pdu[3], MIN(report_size, UHID_DATA_MAX));
+
+	buf = ev.u.input.data;
+	if (hogdev->prepend_id) {
+		*buf = report->id;
+		buf++;
+		ev.u.input.size++;
+	}
+
+	memcpy(buf, &pdu[3], MIN(report_size, UHID_DATA_MAX));
 
 	if (write(hogdev->uhid_fd, &ev, sizeof(ev)) < 0)
 		error("uHID write failed: %s", strerror(errno));
@@ -121,6 +156,8 @@ static void write_ccc(uint16_t handle, gpointer user_data)
 static void report_reference_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data)
 {
+	struct report *report = user_data;
+
 	if (status != 0) {
 		error("Read Report Reference descriptor failed: %s",
 							att_ecode2str(status));
@@ -132,13 +169,16 @@ static void report_reference_cb(guint8 status, const guint8 *pdu,
 		return;
 	}
 
+	report->id = pdu[1];
+	report->type = pdu[2];
 	DBG("Report ID: 0x%02x Report type: 0x%02x", pdu[1], pdu[2]);
 }
 
 static void discover_descriptor_cb(guint8 status, const guint8 *pdu,
 					guint16 len, gpointer user_data)
 {
-	struct hog_device *hogdev = user_data;
+	struct report *report = user_data;
+	struct hog_device *hogdev = report->hogdev;
 	struct att_data_list *list;
 	uint8_t format;
 	int i;
@@ -165,10 +205,10 @@ static void discover_descriptor_cb(guint8 status, const guint8 *pdu,
 		uuid16 = att_get_u16(&value[2]);
 
 		if (uuid16 == GATT_CLIENT_CHARAC_CFG_UUID)
-			write_ccc(handle, user_data);
+			write_ccc(handle, hogdev);
 		else if (uuid16 == GATT_REPORT_REFERENCE)
 			gatt_read_char(hogdev->attrib, handle, 0,
-					report_reference_cb, hogdev);
+					report_reference_cb, report);
 	}
 
 done:
@@ -211,11 +251,20 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	}
 
 	DBG("Report MAP:");
-	for (i = 0; i < vlen; i += 2) {
-		if (i + 1 == vlen)
-			DBG("\t %02x", value[i]);
-		else
-			DBG("\t %02x %02x", value[i], value[i + 1]);
+	for (i = 0; i < vlen; i++) {
+		switch (value[i]) {
+		case 0x85:
+		case 0x86:
+		case 0x87:
+			hogdev->prepend_id = TRUE;
+		}
+
+		if (i % 2 == 0) {
+			if (i + 1 == vlen)
+				DBG("\t %02x", value[i]);
+			else
+				DBG("\t %02x %02x", value[i], value[i + 1]);
+		}
 	}
 
 	vendor_src = btd_device_get_vendor_src(hogdev->device);
@@ -271,10 +320,11 @@ static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
 
 		if (bt_uuid_cmp(&uuid, &report_uuid) == 0) {
 			report = g_new0(struct report, 1);
+			report->hogdev = hogdev;
 			report->decl = g_memdup(chr, sizeof(*chr));
 			hogdev->reports = g_slist_append(hogdev->reports,
 								report);
-			discover_descriptor(hogdev->attrib, chr, next, hogdev);
+			discover_descriptor(hogdev->attrib, chr, next, report);
 		} else if (bt_uuid_cmp(&uuid, &report_map_uuid) == 0)
 			gatt_read_char(hogdev->attrib, chr->value_handle, 0,
 						report_map_read_cb, hogdev);
-- 
1.7.10.4

