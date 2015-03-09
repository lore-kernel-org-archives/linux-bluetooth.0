Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH 1/2] profiles/input: Move HOG common code to profiles/input
Date: Mon,  9 Mar 2015 15:23:36 +0100
Message-Id: <1425911017-17254-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces HOGP deduplication.
Common hog source code has been fetched.
hog_device has been implemented to keep profile dependent code.
---
 Makefile.plugins            |   4 +-
 profiles/input/hog.c        | 924 +++++++++++++++++++++++++++-----------------
 profiles/input/hog.h        |  36 ++
 profiles/input/hog_device.c | 235 +++++++++++
 4 files changed, 840 insertions(+), 359 deletions(-)
 create mode 100644 profiles/input/hog.h
 create mode 100644 profiles/input/hog_device.c

diff --git a/Makefile.plugins b/Makefile.plugins
index 52b51c5..af41c74 100644
--- a/Makefile.plugins
+++ b/Makefile.plugins
@@ -59,7 +59,9 @@ builtin_sources += profiles/input/manager.c \
 			profiles/input/hidp_defs.h
 
 builtin_modules += hog
-builtin_sources += profiles/input/hog.c profiles/input/uhid_copy.h \
+builtin_sources += profiles/input/hog.h profiles/input/hog.c\
+			profiles/input/hog_device.c \
+			profiles/input/uhid_copy.h \
 			profiles/input/suspend.h profiles/input/suspend-dummy.c
 
 if EXPERIMENTAL
diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index 3d23d5b..ea2e89f 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -2,6 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
+ *  Copyright (C) 2014  Intel Corporation.
  *  Copyright (C) 2012  Marcel Holtmann <marcel@holtmann.org>
  *  Copyright (C) 2012  Nordic Semiconductor Inc.
  *  Copyright (C) 2012  Instituto Nokia de Tecnologia - INdT
@@ -42,20 +43,17 @@
 #include "lib/uuid.h"
 
 #include "src/log.h"
-#include "src/adapter.h"
-#include "src/device.h"
-#include "src/profile.h"
-#include "src/service.h"
 #include "src/shared/util.h"
 #include "src/shared/uhid.h"
-#include "src/plugin.h"
-
-#include "suspend.h"
+#include "src/shared/queue.h"
 #include "attrib/att.h"
 #include "attrib/gattrib.h"
-#include "src/attio.h"
 #include "attrib/gatt.h"
 
+#include "btio/btio.h"
+
+#include "hog.h"
+
 #define HOG_UUID		"00001812-0000-1000-8000-00805f9b34fb"
 
 #define HOG_INFO_UUID		0x2A4A
@@ -75,12 +73,14 @@
 #define HID_INFO_SIZE			4
 #define ATT_NOTIFICATION_HEADER_SIZE	3
 
-struct hog_device {
-	uint16_t		id;
-	struct btd_device	*device;
+struct bt_hog {
+	int			ref_count;
+	char			*name;
+	uint16_t		vendor;
+	uint16_t		product;
+	uint16_t		version;
+	struct gatt_primary	*primary;
 	GAttrib			*attrib;
-	guint			attioid;
-	struct gatt_primary	*hog_primary;
 	GSList			*reports;
 	struct bt_uhid		*uhid;
 	gboolean		has_report_id;
@@ -89,27 +89,148 @@ struct hog_device {
 	uint16_t		proto_mode_handle;
 	uint16_t		ctrlpt_handle;
 	uint8_t			flags;
-	guint			getrep_att;
+	unsigned int		getrep_att;
 	uint16_t		getrep_id;
-	guint			setrep_att;
+	unsigned int		setrep_att;
 	uint16_t		setrep_id;
+	struct queue		*gatt_op;
 };
 
-struct report {
+struct hog_report {
+	struct bt_hog		*hog;
 	uint8_t			id;
 	uint8_t			type;
+	uint16_t		ccc_handle;
 	guint			notifyid;
 	struct gatt_char	*decl;
-	struct hog_device	*hogdev;
+	uint16_t		len;
+	uint8_t			*value;
+};
+
+struct gatt_request {
+	unsigned int id;
+	struct bt_hog *hog;
+	void *user_data;
 };
 
-static gboolean suspend_supported = FALSE;
-static GSList *devices = NULL;
+static struct gatt_request *create_request(struct bt_hog *hog,
+							void *user_data)
+{
+	struct gatt_request *req;
+
+	req = new0(struct gatt_request, 1);
+	if (!req)
+		return NULL;
+
+	req->user_data = user_data;
+	req->hog = bt_hog_ref(hog);
+
+	return req;
+}
+
+static bool set_and_store_gatt_req(struct bt_hog *hog,
+						struct gatt_request *req,
+						unsigned int id)
+{
+	req->id = id;
+	return queue_push_head(hog->gatt_op, req);
+}
+
+static void destroy_gatt_req(struct gatt_request *req)
+{
+	queue_remove(req->hog->gatt_op, req);
+	bt_hog_unref(req->hog);
+	free(req);
+}
+
+static void write_char(struct bt_hog *hog, GAttrib *attrib, uint16_t handle,
+					const uint8_t *value, size_t vlen,
+					GAttribResultFunc func,
+					gpointer user_data)
+{
+	struct gatt_request *req;
+	unsigned int id;
+
+	req = create_request(hog, user_data);
+	if (!req)
+		return;
+
+	id = gatt_write_char(attrib, handle, value, vlen, func, req);
+
+	if (set_and_store_gatt_req(hog, req, id))
+		return;
+
+	error("hog: Could not read char");
+	g_attrib_cancel(attrib, id);
+	free(req);
+}
+
+static void read_char(struct bt_hog *hog, GAttrib *attrib, uint16_t handle,
+				GAttribResultFunc func, gpointer user_data)
+{
+	struct gatt_request *req;
+	unsigned int id;
+
+	req = create_request(hog, user_data);
+	if (!req)
+		return;
+
+	id = gatt_read_char(attrib, handle, func, req);
+
+	if (set_and_store_gatt_req(hog, req, id))
+		return;
+
+	error("hog: Could not read char");
+	g_attrib_cancel(attrib, id);
+	free(req);
+}
+
+static void discover_desc(struct bt_hog *hog, GAttrib *attrib,
+				uint16_t start, uint16_t end, gatt_cb_t func,
+				gpointer user_data)
+{
+	struct gatt_request *req;
+	unsigned int id;
+
+	req = create_request(hog, user_data);
+	if (!req)
+		return;
+
+	id = gatt_discover_desc(attrib, start, end, NULL, func, req);
+	if (set_and_store_gatt_req(hog, req, id))
+		return;
+
+	error("hog: Could not discover descriptors");
+	g_attrib_cancel(attrib, id);
+	free(req);
+}
+
+static void discover_char(struct bt_hog *hog, GAttrib *attrib,
+						uint16_t start, uint16_t end,
+						bt_uuid_t *uuid, gatt_cb_t func,
+						gpointer user_data)
+{
+	struct gatt_request *req;
+	unsigned int id;
+
+	req = create_request(hog, user_data);
+	if (!req)
+		return;
+
+	id = gatt_discover_char(attrib, start, end, uuid, func, req);
+
+	if (set_and_store_gatt_req(hog, req, id))
+		return;
+
+	error("hog: Could not discover characteristic");
+	g_attrib_cancel(attrib, id);
+	free(req);
+}
 
 static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
 {
-	struct report *report = user_data;
-	struct hog_device *hogdev = report->hogdev;
+	struct hog_report *report = user_data;
+	struct bt_hog *hog = report->hog;
 	struct uhid_event ev;
 	uint8_t *buf;
 	int err;
@@ -126,7 +247,7 @@ static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
 	ev.type = UHID_INPUT;
 	buf = ev.u.input.data;
 
-	if (hogdev->has_report_id) {
+	if (hog->has_report_id) {
 		buf[0] = report->id;
 		len = MIN(len, sizeof(ev.u.input.data) - 1);
 		memcpy(buf + 1, pdu, len);
@@ -137,7 +258,7 @@ static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
 		ev.u.input.size = len;
 	}
 
-	err = bt_uhid_send(hogdev->uhid, &ev);
+	err = bt_uhid_send(hog->uhid, &ev);
 	if (err < 0) {
 		error("bt_uhid_send: %s (%d)", strerror(-err), -err);
 		return;
@@ -149,8 +270,11 @@ static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
 static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data)
 {
-	struct report *report = user_data;
-	struct hog_device *hogdev = report->hogdev;
+	struct gatt_request *req = user_data;
+	struct hog_report *report = req->user_data;
+	struct bt_hog *hog = report->hog;
+
+	destroy_gatt_req(req);
 
 	if (status != 0) {
 		error("Write report characteristic descriptor failed: %s",
@@ -158,7 +282,7 @@ static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
 		return;
 	}
 
-	report->notifyid = g_attrib_register(hogdev->attrib,
+	report->notifyid = g_attrib_register(hog->attrib,
 					ATT_OP_HANDLE_NOTIFY,
 					report->decl->value_handle,
 					report_value_cb, report, NULL);
@@ -166,20 +290,40 @@ static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
 	DBG("Report characteristic descriptor written: notifications enabled");
 }
 
-static void write_ccc(uint16_t handle, gpointer user_data)
+static void write_ccc(struct bt_hog *hog, GAttrib *attrib, uint16_t handle,
+							void *user_data)
+{
+	uint8_t value[2];
+
+	put_le16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
+
+	write_char(hog, attrib, handle, value, sizeof(value),
+					report_ccc_written_cb, user_data);
+}
+
+static void ccc_read_cb(guint8 status, const guint8 *pdu, guint16 len,
+							gpointer user_data)
 {
-	struct report *report = user_data;
-	struct hog_device *hogdev = report->hogdev;
-	uint8_t value[] = { 0x01, 0x00 };
+	struct gatt_request *req = user_data;
+	struct hog_report *report = req->user_data;
+
+	destroy_gatt_req(req);
+
+	if (status != 0) {
+		error("Error reading CCC value: %s", att_ecode2str(status));
+		return;
+	}
 
-	gatt_write_char(hogdev->attrib, handle, value, sizeof(value),
-					report_ccc_written_cb, report);
+	write_ccc(report->hog, report->hog->attrib, report->ccc_handle, report);
 }
 
 static void report_reference_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data)
 {
-	struct report *report = user_data;
+	struct gatt_request *req = user_data;
+	struct hog_report *report = req->user_data;
+
+	destroy_gatt_req(req);
 
 	if (status != 0) {
 		error("Read Report Reference descriptor failed: %s",
@@ -195,21 +339,63 @@ static void report_reference_cb(guint8 status, const guint8 *pdu,
 	report->id = pdu[1];
 	report->type = pdu[2];
 	DBG("Report ID: 0x%02x Report type: 0x%02x", pdu[1], pdu[2]);
+
+	/* Enable notifications only for Input Reports */
+	if (report->type == HOG_REPORT_TYPE_INPUT)
+		read_char(report->hog, report->hog->attrib, report->ccc_handle,
+							ccc_read_cb, report);
 }
 
 static void external_report_reference_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data);
 
+static void discover_external_cb(uint8_t status, GSList *descs, void *user_data)
+{
+	struct gatt_request *req = user_data;
+	struct bt_hog *hog = req->user_data;
+
+	destroy_gatt_req(req);
 
-static void discover_descriptor_cb(uint8_t status, GSList *descs,
-								void *user_data)
+	if (status != 0) {
+		error("Discover external descriptors failed: %s",
+							att_ecode2str(status));
+		return;
+	}
+
+	for ( ; descs; descs = descs->next) {
+		struct gatt_desc *desc = descs->data;
+
+		read_char(hog, hog->attrib, desc->handle,
+						external_report_reference_cb,
+						hog);
+	}
+}
+
+static void discover_external(struct bt_hog *hog, GAttrib *attrib,
+						uint16_t start, uint16_t end,
+						gpointer user_data)
+{
+	bt_uuid_t uuid;
+
+	if (start > end)
+		return;
+
+	bt_uuid16_create(&uuid, GATT_EXTERNAL_REPORT_REFERENCE);
+
+	discover_desc(hog, attrib, start, end, discover_external_cb,
+								user_data);
+}
+
+static void discover_report_cb(uint8_t status, GSList *descs, void *user_data)
 {
-	struct report *report;
-	struct hog_device *hogdev;
-	GAttrib *attrib = NULL;
+	struct gatt_request *req = user_data;
+	struct hog_report *report = req->user_data;
+	struct bt_hog *hog = report->hog;
+
+	destroy_gatt_req(req);
 
 	if (status != 0) {
-		error("Discover all descriptors failed: %s",
+		error("Discover report descriptors failed: %s",
 							att_ecode2str(status));
 		return;
 	}
@@ -219,43 +405,71 @@ static void discover_descriptor_cb(uint8_t status, GSList *descs,
 
 		switch (desc->uuid16) {
 		case GATT_CLIENT_CHARAC_CFG_UUID:
-			report = user_data;
-			write_ccc(desc->handle, report);
+			report->ccc_handle = desc->handle;
 			break;
 		case GATT_REPORT_REFERENCE:
-			report = user_data;
-			attrib = report->hogdev->attrib;
-			gatt_read_char(attrib, desc->handle,
+			read_char(hog, hog->attrib, desc->handle,
 						report_reference_cb, report);
 			break;
-		case GATT_EXTERNAL_REPORT_REFERENCE:
-			hogdev = user_data;
-			attrib = hogdev->attrib;
-			gatt_read_char(attrib, desc->handle,
-					external_report_reference_cb, hogdev);
-			break;
 		}
 	}
 }
 
-static void discover_descriptor(GAttrib *attrib, uint16_t start, uint16_t end,
+static void discover_report(struct bt_hog *hog, GAttrib *attrib,
+						uint16_t start, uint16_t end,
 							gpointer user_data)
 {
 	if (start > end)
 		return;
 
-	gatt_discover_desc(attrib, start, end, NULL,
-					discover_descriptor_cb, user_data);
+	discover_desc(hog, attrib, start, end, discover_report_cb, user_data);
+}
+
+static void report_read_cb(guint8 status, const guint8 *pdu, guint16 len,
+							gpointer user_data)
+{
+	struct gatt_request *req = user_data;
+	struct hog_report *report = req->user_data;
+
+	destroy_gatt_req(req);
+
+	if (status != 0) {
+		error("Error reading Report value: %s", att_ecode2str(status));
+		return;
+	}
+
+	if (report->value)
+		g_free(report->value);
+
+	report->value = g_memdup(pdu, len);
+	report->len = len;
+}
+
+static struct hog_report *report_new(struct bt_hog *hog, struct gatt_char *chr)
+{
+	struct hog_report *report;
+
+	report = g_new0(struct hog_report, 1);
+	report->hog = hog;
+	report->decl = g_memdup(chr, sizeof(*chr));
+	hog->reports = g_slist_append(hog->reports, report);
+
+	read_char(hog, hog->attrib, chr->value_handle, report_read_cb, report);
+
+	return report;
 }
 
 static void external_service_char_cb(uint8_t status, GSList *chars,
 								void *user_data)
 {
-	struct hog_device *hogdev = user_data;
-	struct gatt_primary *prim = hogdev->hog_primary;
-	struct report *report;
+	struct gatt_request *req = user_data;
+	struct bt_hog *hog = req->user_data;
+	struct gatt_primary *primary = hog->primary;
+	struct hog_report *report;
 	GSList *l;
 
+	destroy_gatt_req(req);
+
 	if (status != 0) {
 		const char *str = att_ecode2str(status);
 		DBG("Discover external service characteristic failed: %s", str);
@@ -272,23 +486,23 @@ static void external_service_char_cb(uint8_t status, GSList *chars,
 		DBG("0x%04x UUID: %s properties: %02x",
 				chr->handle, chr->uuid, chr->properties);
 
-		report = g_new0(struct report, 1);
-		report->hogdev = hogdev;
-		report->decl = g_memdup(chr, sizeof(*chr));
-		hogdev->reports = g_slist_append(hogdev->reports, report);
+		report = report_new(hog, chr);
 		start = chr->value_handle + 1;
-		end = (next ? next->handle - 1 : prim->range.end);
-		discover_descriptor(hogdev->attrib, start, end, report);
+		end = (next ? next->handle - 1 : primary->range.end);
+		discover_report(hog, hog->attrib, start, end, report);
 	}
 }
 
 static void external_report_reference_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data)
 {
-	struct hog_device *hogdev = user_data;
+	struct gatt_request *req = user_data;
+	struct bt_hog *hog = req->user_data;
 	uint16_t uuid16;
 	bt_uuid_t uuid;
 
+	destroy_gatt_req(req);
+
 	if (status != 0) {
 		error("Read External Report Reference descriptor failed: %s",
 							att_ecode2str(status));
@@ -303,72 +517,96 @@ static void external_report_reference_cb(guint8 status, const guint8 *pdu,
 	uuid16 = get_le16(&pdu[1]);
 	DBG("External report reference read, external report characteristic "
 						"UUID: 0x%04x", uuid16);
+
+	/* Do not discover if is not a Report */
+	if (uuid16 != HOG_REPORT_UUID)
+		return;
+
 	bt_uuid16_create(&uuid, uuid16);
-	gatt_discover_char(hogdev->attrib, 0x00, 0xff, &uuid,
-					external_service_char_cb, hogdev);
+	discover_char(hog, hog->attrib, 0x0001, 0xffff, &uuid,
+					external_service_char_cb, hog);
 }
 
 static int report_cmp(gconstpointer a, gconstpointer b)
 {
-	const struct report *ra = a, *rb = b;
+	const struct hog_report *ra = a, *rb = b;
 
 	/* sort by type first.. */
 	if (ra->type != rb->type)
 		return ra->type - rb->type;
 
+	/* skip id check in case of report id 0 */
+	if (!rb->id)
+		return 0;
+
 	/* ..then by id */
 	return ra->id - rb->id;
 }
 
-static void output_written_cb(guint8 status, const guint8 *pdu,
-					guint16 plen, gpointer user_data)
+static struct hog_report *find_report(struct bt_hog *hog, uint8_t type,
+								uint8_t id)
 {
-	if (status != 0) {
-		error("Write output report failed: %s", att_ecode2str(status));
-		return;
-	}
+	struct hog_report cmp;
+	GSList *l;
+
+	cmp.type = type;
+	cmp.id = hog->has_report_id ? id : 0;
+
+	l = g_slist_find_custom(hog->reports, &cmp, report_cmp);
+
+	return l ? l->data : NULL;
 }
 
-static struct report *find_report(struct hog_device *hogdev, uint8_t type, uint8_t id)
+static struct hog_report *find_report_by_rtype(struct bt_hog *hog,
+						uint8_t rtype, uint8_t id)
 {
-	struct report cmp;
-	GSList *l;
+	uint8_t type;
 
-	switch (type) {
+	switch (rtype) {
 	case UHID_FEATURE_REPORT:
-		cmp.type = HOG_REPORT_TYPE_FEATURE;
+		type = HOG_REPORT_TYPE_FEATURE;
 		break;
 	case UHID_OUTPUT_REPORT:
-		cmp.type = HOG_REPORT_TYPE_OUTPUT;
+		type = HOG_REPORT_TYPE_OUTPUT;
 		break;
 	case UHID_INPUT_REPORT:
-		cmp.type = HOG_REPORT_TYPE_INPUT;
+		type = HOG_REPORT_TYPE_INPUT;
 		break;
 	default:
 		return NULL;
 	}
 
-	cmp.id = hogdev->has_report_id ? id : 0;
+	return find_report(hog, type, id);
+}
+
+static void output_written_cb(guint8 status, const guint8 *pdu,
+					guint16 plen, gpointer user_data)
+{
+	struct gatt_request *req = user_data;
 
-	l = g_slist_find_custom(hogdev->reports, &cmp, report_cmp);
+	destroy_gatt_req(req);
 
-	return l ? l->data : NULL;
+	if (status != 0) {
+		error("Write output report failed: %s", att_ecode2str(status));
+		return;
+	}
 }
 
 static void forward_report(struct uhid_event *ev, void *user_data)
 {
-	struct hog_device *hogdev = user_data;
-	struct report *report;
+	struct bt_hog *hog = user_data;
+	struct hog_report *report;
 	void *data;
 	int size;
 
-	report = find_report(hogdev, ev->u.output.rtype, ev->u.output.data[0]);
+	report = find_report_by_rtype(hog, ev->u.output.rtype,
+							ev->u.output.data[0]);
 	if (!report)
 		return;
 
 	data = ev->u.output.data;
 	size = ev->u.output.size;
-	if (hogdev->has_report_id && size > 0) {
+	if (hog->has_report_id && size > 0) {
 		data++;
 		--size;
 	}
@@ -376,56 +614,88 @@ static void forward_report(struct uhid_event *ev, void *user_data)
 	DBG("Sending report type %d ID %d to handle 0x%X", report->type,
 				report->id, report->decl->value_handle);
 
-	if (hogdev->attrib == NULL)
+	if (hog->attrib == NULL)
 		return;
 
 	if (report->decl->properties & GATT_CHR_PROP_WRITE)
-		gatt_write_char(hogdev->attrib, report->decl->value_handle,
-				data, size, output_written_cb, hogdev);
+		write_char(hog, hog->attrib, report->decl->value_handle,
+				data, size, output_written_cb, hog);
 	else if (report->decl->properties & GATT_CHR_PROP_WRITE_WITHOUT_RESP)
-		gatt_write_cmd(hogdev->attrib, report->decl->value_handle,
+		gatt_write_cmd(hog->attrib, report->decl->value_handle,
 						data, size, NULL, NULL);
 }
 
+static void get_feature(struct uhid_event *ev, void *user_data)
+{
+	struct bt_hog *hog = user_data;
+	struct hog_report *report;
+	struct uhid_event rsp;
+	int err;
+
+	memset(&rsp, 0, sizeof(rsp));
+	rsp.type = UHID_FEATURE_ANSWER;
+	rsp.u.feature_answer.id = ev->u.feature.id;
+
+	report = find_report_by_rtype(hog, ev->u.feature.rtype,
+							ev->u.feature.rnum);
+	if (!report) {
+		rsp.u.feature_answer.err = ENOTSUP;
+		goto done;
+	}
+
+	if (!report->value) {
+		rsp.u.feature_answer.err = EIO;
+		goto done;
+	}
+
+	rsp.u.feature_answer.size = report->len;
+	memcpy(rsp.u.feature_answer.data, report->value, report->len);
+
+done:
+	err = bt_uhid_send(hog->uhid, &rsp);
+	if (err < 0)
+		error("bt_uhid_send: %s", strerror(-err));
+}
+
 static void set_report_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data)
 {
-	struct hog_device *hogdev = user_data;
+	struct bt_hog *hog = user_data;
 	struct uhid_event rsp;
 	int err;
 
-	hogdev->setrep_att = 0;
+	hog->setrep_att = 0;
 
 	memset(&rsp, 0, sizeof(rsp));
 	rsp.type = UHID_SET_REPORT_REPLY;
-	rsp.u.set_report_reply.id = hogdev->setrep_id;
+	rsp.u.set_report_reply.id = hog->setrep_id;
 	rsp.u.set_report_reply.err = status;
 
 	if (status != 0)
 		error("Error setting Report value: %s", att_ecode2str(status));
 
-	err = bt_uhid_send(hogdev->uhid, &rsp);
+	err = bt_uhid_send(hog->uhid, &rsp);
 	if (err < 0)
 		error("bt_uhid_send: %s", strerror(-err));
 }
 
 static void set_report(struct uhid_event *ev, void *user_data)
 {
-	struct hog_device *hogdev = user_data;
-	struct report *report;
+	struct bt_hog *hog = user_data;
+	struct hog_report *report;
 	void *data;
 	int size;
 	int err;
 
 	/* uhid never sends reqs in parallel; if there's a req, it timed out */
-	if (hogdev->setrep_att) {
-		g_attrib_cancel(hogdev->attrib, hogdev->setrep_att);
-		hogdev->setrep_att = 0;
+	if (hog->setrep_att) {
+		g_attrib_cancel(hog->attrib, hog->setrep_att);
+		hog->setrep_att = 0;
 	}
 
-	hogdev->setrep_id = ev->u.set_report.id;
+	hog->setrep_id = ev->u.set_report.id;
 
-	report = find_report(hogdev, ev->u.set_report.rtype,
+	report = find_report_by_rtype(hog, ev->u.set_report.rtype,
 							ev->u.set_report.rnum);
 	if (!report) {
 		err = ENOTSUP;
@@ -434,7 +704,7 @@ static void set_report(struct uhid_event *ev, void *user_data)
 
 	data = ev->u.set_report.data;
 	size = ev->u.set_report.size;
-	if (hogdev->has_report_id && size > 0) {
+	if (hog->has_report_id && size > 0) {
 		data++;
 		--size;
 	}
@@ -442,14 +712,14 @@ static void set_report(struct uhid_event *ev, void *user_data)
 	DBG("Sending report type %d ID %d to handle 0x%X", report->type,
 				report->id, report->decl->value_handle);
 
-	if (hogdev->attrib == NULL)
+	if (hog->attrib == NULL)
 		return;
 
-	hogdev->setrep_att = gatt_write_char(hogdev->attrib,
+	hog->setrep_att = gatt_write_char(hog->attrib,
 						report->decl->value_handle,
 						data, size, set_report_cb,
-						hogdev);
-	if (!hogdev->setrep_att) {
+						hog);
+	if (!hog->setrep_att) {
 		err = ENOMEM;
 		goto fail;
 	}
@@ -457,21 +727,21 @@ static void set_report(struct uhid_event *ev, void *user_data)
 	return;
 fail:
 	/* cancel the request on failure */
-	set_report_cb(err, NULL, 0, hogdev);
+	set_report_cb(err, NULL, 0, hog);
 }
 
 static void get_report_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
-	struct hog_device *hogdev = user_data;
+	struct bt_hog *hog = user_data;
 	struct uhid_event rsp;
 	int err;
 
-	hogdev->getrep_att = 0;
+	hog->getrep_att = 0;
 
 	memset(&rsp, 0, sizeof(rsp));
 	rsp.type = UHID_GET_REPORT_REPLY;
-	rsp.u.get_report_reply.id = hogdev->getrep_id;
+	rsp.u.get_report_reply.id = hog->getrep_id;
 
 	if (status != 0) {
 		error("Error reading Report value: %s", att_ecode2str(status));
@@ -492,7 +762,7 @@ static void get_report_cb(guint8 status, const guint8 *pdu, guint16 len,
 
 	--len;
 	++pdu;
-	if (hogdev->has_report_id && len > 0) {
+	if (hog->has_report_id && len > 0) {
 		--len;
 		++pdu;
 	}
@@ -502,36 +772,36 @@ static void get_report_cb(guint8 status, const guint8 *pdu, guint16 len,
 
 exit:
 	rsp.u.get_report_reply.err = status;
-	err = bt_uhid_send(hogdev->uhid, &rsp);
+	err = bt_uhid_send(hog->uhid, &rsp);
 	if (err < 0)
 		error("bt_uhid_send: %s", strerror(-err));
 }
 
 static void get_report(struct uhid_event *ev, void *user_data)
 {
-	struct hog_device *hogdev = user_data;
-	struct report *report;
+	struct bt_hog *hog = user_data;
+	struct hog_report *report;
 	guint8 err;
 
 	/* uhid never sends reqs in parallel; if there's a req, it timed out */
-	if (hogdev->getrep_att) {
-		g_attrib_cancel(hogdev->attrib, hogdev->getrep_att);
-		hogdev->getrep_att = 0;
+	if (hog->getrep_att) {
+		g_attrib_cancel(hog->attrib, hog->getrep_att);
+		hog->getrep_att = 0;
 	}
 
-	hogdev->getrep_id = ev->u.get_report.id;
+	hog->getrep_id = ev->u.get_report.id;
 
-	report = find_report(hogdev, ev->u.get_report.rtype,
+	report = find_report_by_rtype(hog, ev->u.get_report.rtype,
 							ev->u.get_report.rnum);
 	if (!report) {
 		err = ENOTSUP;
 		goto fail;
 	}
 
-	hogdev->getrep_att = gatt_read_char(hogdev->attrib,
+	hog->getrep_att = gatt_read_char(hog->attrib,
 						report->decl->value_handle,
-						get_report_cb, hogdev);
-	if (!hogdev->getrep_att) {
+						get_report_cb, hog);
+	if (!hog->getrep_att) {
 		err = ENOMEM;
 		goto fail;
 	}
@@ -540,7 +810,7 @@ static void get_report(struct uhid_event *ev, void *user_data)
 
 fail:
 	/* cancel the request on failure */
-	get_report_cb(err, NULL, 0, hogdev);
+	get_report_cb(err, NULL, 0, hog);
 }
 
 static bool get_descriptor_item_info(uint8_t *buf, ssize_t blen, ssize_t *len,
@@ -608,14 +878,16 @@ static char *item2string(char *str, uint8_t *buf, uint8_t len)
 static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
-	struct hog_device *hogdev = user_data;
-	struct btd_adapter *adapter = device_get_adapter(hogdev->device);
+	struct gatt_request *req = user_data;
+	struct bt_hog *hog = req->user_data;
 	uint8_t value[HOG_REPORT_MAP_MAX_SIZE];
 	struct uhid_event ev;
-	uint16_t vendor_src, vendor, product, version;
 	ssize_t vlen;
 	char itemstr[20]; /* 5x3 (data) + 4 (continuation) + 1 (null) */
 	int i, err;
+	GError *gerr = NULL;
+
+	destroy_gatt_req(req);
 
 	if (status != 0) {
 		error("Report Map read failed: %s", att_ecode2str(status));
@@ -637,7 +909,7 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 								&long_item)) {
 			/* Report ID is short item with prefix 100001xx */
 			if (!long_item && (value[i] & 0xfc) == 0x84)
-				hogdev->has_report_id = TRUE;
+				hog->has_report_id = TRUE;
 
 			DBG("\t%s", item2string(itemstr, &value[i], ilen));
 
@@ -651,49 +923,51 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		}
 	}
 
-	vendor_src = btd_device_get_vendor_src(hogdev->device);
-	vendor = btd_device_get_vendor(hogdev->device);
-	product = btd_device_get_product(hogdev->device);
-	version = btd_device_get_version(hogdev->device);
-	DBG("DIS information: vendor_src=0x%X, vendor=0x%X, product=0x%X, "
-			"version=0x%X",	vendor_src, vendor, product, version);
-
 	/* create uHID device */
 	memset(&ev, 0, sizeof(ev));
 	ev.type = UHID_CREATE;
-	if (device_name_known(hogdev->device))
-		device_get_name(hogdev->device, (char *) ev.u.create.name,
-						sizeof(ev.u.create.name));
-	else
-		strcpy((char *) ev.u.create.name, "bluez-hog-device");
-	ba2str(btd_adapter_get_address(adapter), (char *) ev.u.create.phys);
-	ba2str(device_get_address(hogdev->device), (char *) ev.u.create.uniq);
-	ev.u.create.vendor = vendor;
-	ev.u.create.product = product;
-	ev.u.create.version = version;
-	ev.u.create.country = hogdev->bcountrycode;
+
+	bt_io_get(g_attrib_get_channel(hog->attrib), &gerr,
+			BT_IO_OPT_SOURCE, ev.u.create.phys,
+			BT_IO_OPT_DEST, ev.u.create.uniq,
+			BT_IO_OPT_INVALID);
+	if (gerr) {
+		error("Failed to connection details: %s", gerr->message);
+		g_error_free(gerr);
+		return;
+	}
+
+	strcpy((char *) ev.u.create.name, hog->name);
+	ev.u.create.vendor = hog->vendor;
+	ev.u.create.product = hog->product;
+	ev.u.create.version = hog->version;
+	ev.u.create.country = hog->bcountrycode;
 	ev.u.create.bus = BUS_BLUETOOTH;
 	ev.u.create.rd_data = value;
 	ev.u.create.rd_size = vlen;
 
-	err = bt_uhid_send(hogdev->uhid, &ev);
+	err = bt_uhid_send(hog->uhid, &ev);
 	if (err < 0) {
 		error("bt_uhid_send: %s", strerror(-err));
 		return;
 	}
 
-	bt_uhid_register(hogdev->uhid, UHID_OUTPUT, forward_report, hogdev);
-	bt_uhid_register(hogdev->uhid, UHID_SET_REPORT, set_report, hogdev);
-	bt_uhid_register(hogdev->uhid, UHID_GET_REPORT, get_report, hogdev);
+	bt_uhid_register(hog->uhid, UHID_OUTPUT, forward_report, hog);
+	bt_uhid_register(hog->uhid, UHID_FEATURE, get_feature, hog);
+	bt_uhid_register(hog->uhid, UHID_GET_REPORT, get_report, hog);
+	bt_uhid_register(hog->uhid, UHID_SET_REPORT, set_report, hog);
 }
 
 static void info_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
-	struct hog_device *hogdev = user_data;
+	struct gatt_request *req = user_data;
+	struct bt_hog *hog = req->user_data;
 	uint8_t value[HID_INFO_SIZE];
 	ssize_t vlen;
 
+	destroy_gatt_req(req);
+
 	if (status != 0) {
 		error("HID Information read failed: %s",
 						att_ecode2str(status));
@@ -706,21 +980,24 @@ static void info_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		return;
 	}
 
-	hogdev->bcdhid = get_le16(&value[0]);
-	hogdev->bcountrycode = value[2];
-	hogdev->flags = value[3];
+	hog->bcdhid = get_le16(&value[0]);
+	hog->bcountrycode = value[2];
+	hog->flags = value[3];
 
 	DBG("bcdHID: 0x%04X bCountryCode: 0x%02X Flags: 0x%02X",
-			hogdev->bcdhid, hogdev->bcountrycode, hogdev->flags);
+			hog->bcdhid, hog->bcountrycode, hog->flags);
 }
 
 static void proto_mode_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
-	struct hog_device *hogdev = user_data;
+	struct gatt_request *req = user_data;
+	struct bt_hog *hog = req->user_data;
 	uint8_t value;
 	ssize_t vlen;
 
+	destroy_gatt_req(req);
+
 	if (status != 0) {
 		error("Protocol Mode characteristic read failed: %s",
 							att_ecode2str(status));
@@ -736,26 +1013,27 @@ static void proto_mode_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 	if (value == HOG_PROTO_MODE_BOOT) {
 		uint8_t nval = HOG_PROTO_MODE_REPORT;
 
-		DBG("HoG device 0x%04X is operating in Boot Procotol Mode",
-								hogdev->id);
+		DBG("HoG is operating in Boot Procotol Mode");
 
-		gatt_write_cmd(hogdev->attrib, hogdev->proto_mode_handle, &nval,
+		gatt_write_cmd(hog->attrib, hog->proto_mode_handle, &nval,
 						sizeof(nval), NULL, NULL);
 	} else if (value == HOG_PROTO_MODE_REPORT)
-		DBG("HoG device 0x%04X is operating in Report Protocol Mode",
-								hogdev->id);
+		DBG("HoG is operating in Report Protocol Mode");
 }
 
 static void char_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 {
-	struct hog_device *hogdev = user_data;
-	struct gatt_primary *prim = hogdev->hog_primary;
+	struct gatt_request *req = user_data;
+	struct bt_hog *hog = req->user_data;
+	struct gatt_primary *primary = hog->primary;
 	bt_uuid_t report_uuid, report_map_uuid, info_uuid;
 	bt_uuid_t proto_mode_uuid, ctrlpt_uuid;
-	struct report *report;
+	struct hog_report *report;
 	GSList *l;
 	uint16_t info_handle = 0, proto_mode_handle = 0;
 
+	destroy_gatt_req(req);
+
 	if (status != 0) {
 		const char *str = att_ecode2str(status);
 		DBG("Discover all characteristics failed: %s", str);
@@ -782,277 +1060,207 @@ static void char_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 		bt_string_to_uuid(&uuid, chr->uuid);
 
 		start = chr->value_handle + 1;
-		end = (next ? next->handle - 1 : prim->range.end);
+		end = (next ? next->handle - 1 : primary->range.end);
 
 		if (bt_uuid_cmp(&uuid, &report_uuid) == 0) {
-			report = g_new0(struct report, 1);
-			report->hogdev = hogdev;
-			report->decl = g_memdup(chr, sizeof(*chr));
-			hogdev->reports = g_slist_append(hogdev->reports,
-								report);
-			discover_descriptor(hogdev->attrib, start, end, report);
+			report = report_new(hog, chr);
+			discover_report(hog, hog->attrib, start, end, report);
 		} else if (bt_uuid_cmp(&uuid, &report_map_uuid) == 0) {
-			gatt_read_char(hogdev->attrib, chr->value_handle,
-						report_map_read_cb, hogdev);
-			discover_descriptor(hogdev->attrib, start, end, hogdev);
+			read_char(hog, hog->attrib, chr->value_handle,
+						report_map_read_cb, hog);
+			discover_external(hog, hog->attrib, start, end, hog);
 		} else if (bt_uuid_cmp(&uuid, &info_uuid) == 0)
 			info_handle = chr->value_handle;
 		else if (bt_uuid_cmp(&uuid, &proto_mode_uuid) == 0)
 			proto_mode_handle = chr->value_handle;
 		else if (bt_uuid_cmp(&uuid, &ctrlpt_uuid) == 0)
-			hogdev->ctrlpt_handle = chr->value_handle;
+			hog->ctrlpt_handle = chr->value_handle;
 	}
 
 	if (proto_mode_handle) {
-		hogdev->proto_mode_handle = proto_mode_handle;
-		gatt_read_char(hogdev->attrib, proto_mode_handle,
-						proto_mode_read_cb, hogdev);
+		hog->proto_mode_handle = proto_mode_handle;
+		read_char(hog, hog->attrib, proto_mode_handle,
+						proto_mode_read_cb, hog);
 	}
 
 	if (info_handle)
-		gatt_read_char(hogdev->attrib, info_handle, info_read_cb,
-									hogdev);
+		read_char(hog, hog->attrib, info_handle, info_read_cb, hog);
 }
 
-static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
+static void report_free(void *data)
 {
-	struct hog_device *hogdev = user_data;
-	struct gatt_primary *prim = hogdev->hog_primary;
-	GSList *l;
-
-	DBG("HoG connected");
-
-	hogdev->attrib = g_attrib_ref(attrib);
-
-	if (hogdev->reports == NULL) {
-		gatt_discover_char(hogdev->attrib, prim->range.start,
-						prim->range.end, NULL,
-						char_discovered_cb, hogdev);
-		return;
-	}
+	struct hog_report *report = data;
 
-	for (l = hogdev->reports; l; l = l->next) {
-		struct report *r = l->data;
-
-		r->notifyid = g_attrib_register(hogdev->attrib,
-					ATT_OP_HANDLE_NOTIFY,
-					r->decl->value_handle,
-					report_value_cb, r, NULL);
-	}
+	g_free(report->value);
+	g_free(report->decl);
+	g_free(report);
 }
 
-static void attio_disconnected_cb(gpointer user_data)
+static void cancel_gatt_req(struct gatt_request *req)
 {
-	struct hog_device *hogdev = user_data;
-	GSList *l;
-
-	DBG("HoG disconnected");
-
-	for (l = hogdev->reports; l; l = l->next) {
-		struct report *r = l->data;
-
-		g_attrib_unregister(hogdev->attrib, r->notifyid);
-	}
-
-	g_attrib_unref(hogdev->attrib);
-	hogdev->attrib = NULL;
+	if (g_attrib_cancel(req->hog->attrib, req->id))
+		destroy_gatt_req(req);
 }
 
-static struct hog_device *hog_new_device(struct btd_device *device,
-								uint16_t id)
+static void hog_free(struct bt_hog *hog)
 {
-	struct hog_device *hogdev;
-
-	hogdev = g_try_new0(struct hog_device, 1);
-	if (!hogdev)
-		return NULL;
-
-	hogdev->id = id;
-	hogdev->device = btd_device_ref(device);
-
-	return hogdev;
+	bt_hog_detach(hog);
+
+	bt_uhid_unref(hog->uhid);
+	g_slist_free_full(hog->reports, report_free);
+	g_free(hog->name);
+	g_free(hog->primary);
+	queue_destroy(hog->gatt_op, (void *) destroy_gatt_req);
+	g_free(hog);
 }
 
-static void report_free(void *data)
+struct bt_hog *bt_hog_new(const char *name, uint16_t vendor, uint16_t product,
+					uint16_t version, void *primary)
 {
-	struct report *report = data;
-	struct hog_device *hogdev = report->hogdev;
-
-	if (hogdev->attrib)
-		g_attrib_unregister(hogdev->attrib, report->notifyid);
-
-	g_free(report->decl);
-	g_free(report);
-}
+	struct bt_hog *hog;
 
-static void hog_free_device(struct hog_device *hogdev)
-{
-	btd_device_unref(hogdev->device);
-	g_slist_free_full(hogdev->reports, report_free);
-	g_attrib_unref(hogdev->attrib);
-	g_free(hogdev->hog_primary);
-	g_free(hogdev);
-}
-
-static struct hog_device *hog_register_device(struct btd_device *device,
-						struct gatt_primary *prim)
-{
-	struct hog_device *hogdev;
+	hog = g_try_new0(struct bt_hog, 1);
+	if (!hog)
+		return NULL;
 
-	hogdev = hog_new_device(device, prim->range.start);
-	if (!hogdev)
+	hog->gatt_op = queue_new();
+	if (!hog->gatt_op) {
+		hog_free(hog);
 		return NULL;
+	}
 
-	hogdev->uhid = bt_uhid_new_default();
-	if (!hogdev->uhid) {
-		error("bt_uhid_new_default: failed");
-		hog_free_device(hogdev);
+	hog->uhid = bt_uhid_new_default();
+	if (!hog->uhid) {
+		hog_free(hog);
+		queue_destroy(hog->gatt_op, NULL);
 		return NULL;
 	}
 
-	hogdev->hog_primary = g_memdup(prim, sizeof(*prim));
+	hog->name = g_strdup(name);
+	hog->vendor = vendor;
+	hog->product = product;
+	hog->version = version;
 
-	hogdev->attioid = btd_device_add_attio_callback(device,
-							attio_connected_cb,
-							attio_disconnected_cb,
-							hogdev);
+	if (primary)
+		hog->primary = g_memdup(primary, sizeof(*hog->primary));
 
-	return hogdev;
+	return bt_hog_ref(hog);
 }
 
-static int hog_unregister_device(struct hog_device *hogdev)
+struct bt_hog *bt_hog_ref(struct bt_hog *hog)
 {
-	btd_device_remove_attio_callback(hogdev->device, hogdev->attioid);
-	bt_uhid_unref(hogdev->uhid);
-	hog_free_device(hogdev);
+	if (!hog)
+		return NULL;
 
-	return 0;
+	__sync_fetch_and_add(&hog->ref_count, 1);
+
+	return hog;
 }
 
-static int set_control_point(struct hog_device *hogdev, gboolean suspend)
+void bt_hog_unref(struct bt_hog *hog)
 {
-	uint8_t value = suspend ? 0x00 : 0x01;
-
-	if (hogdev->attrib == NULL)
-		return -ENOTCONN;
-
-	DBG("0x%4X HID Control Point: %s", hogdev->id, suspend ?
-						"Suspend" : "Exit Suspend");
-
-	if (hogdev->ctrlpt_handle == 0)
-		return -ENOTSUP;
+	if (!hog)
+		return;
 
-	gatt_write_cmd(hogdev->attrib, hogdev->ctrlpt_handle, &value,
-					sizeof(value), NULL, NULL);
+	if (__sync_sub_and_fetch(&hog->ref_count, 1))
+		return;
 
-	return 0;
+	hog_free(hog);
 }
 
-static void set_suspend(gpointer data, gpointer user_data)
+bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 {
-	struct hog_device *hogdev = data;
-	gboolean suspend = GPOINTER_TO_INT(user_data);
-
-	set_control_point(hogdev, suspend);
-}
+	struct gatt_primary *primary = hog->primary;
+	GSList *l;
 
-static void suspend_callback(void)
-{
-	gboolean suspend = TRUE;
+	if (hog->attrib)
+		return false;
 
-	DBG("Suspending ...");
+	DBG("HoG connected");
 
-	g_slist_foreach(devices, set_suspend, GINT_TO_POINTER(suspend));
-}
+	hog->attrib = g_attrib_ref(gatt);
 
-static void resume_callback(void)
-{
-	gboolean suspend = FALSE;
+	if (hog->reports == NULL) {
+		discover_char(hog, hog->attrib, primary->range.start,
+						primary->range.end, NULL,
+						char_discovered_cb, hog);
+		return true;
+	}
 
-	DBG("Resuming ...");
+	for (l = hog->reports; l; l = l->next) {
+		struct hog_report *r = l->data;
 
-	g_slist_foreach(devices, set_suspend, GINT_TO_POINTER(suspend));
+		r->notifyid = g_attrib_register(hog->attrib,
+					ATT_OP_HANDLE_NOTIFY,
+					r->decl->value_handle,
+					report_value_cb, r, NULL);
+	}
+	return true;
 }
 
-static int hog_probe(struct btd_service *service)
+void bt_hog_detach(gpointer user_data)
 {
-	struct btd_device *device = btd_service_get_device(service);
-	const char *path = device_get_path(device);
-	GSList *primaries, *l;
-
-	DBG("path %s", path);
-
-	primaries = btd_device_get_primaries(device);
-	if (primaries == NULL)
-		return -EINVAL;
+	struct bt_hog *hog = user_data;
+	GSList *l;
 
-	for (l = primaries; l; l = g_slist_next(l)) {
-		struct gatt_primary *prim = l->data;
-		struct hog_device *hogdev;
+	if (!hog->attrib)
+		return;
 
-		if (strcmp(prim->uuid, HOG_UUID) != 0)
-			continue;
+	DBG("HoG disconnected");
 
-		hogdev = hog_register_device(device, prim);
-		if (hogdev == NULL)
-			continue;
+	for (l = hog->reports; l; l = l->next) {
+		struct hog_report *r = l->data;
 
-		devices = g_slist_append(devices, hogdev);
+		if (r->notifyid > 0) {
+			g_attrib_unregister(hog->attrib, r->notifyid);
+			r->notifyid = 0;
+		}
 	}
 
-	return 0;
+	queue_foreach(hog->gatt_op, (void *) cancel_gatt_req, NULL);
+	g_attrib_unref(hog->attrib);
+	hog->attrib = NULL;
 }
 
-static void remove_device(gpointer a, gpointer b)
+int bt_hog_set_control_point(struct bt_hog *hog, bool suspend)
 {
-	struct hog_device *hogdev = a;
-	struct btd_device *device = b;
+	uint8_t value = suspend ? 0x00 : 0x01;
 
-	if (hogdev->device != device)
-		return;
+	if (hog->attrib == NULL)
+		return -ENOTCONN;
+
+	if (hog->ctrlpt_handle == 0)
+		return -ENOTSUP;
+
+	gatt_write_cmd(hog->attrib, hog->ctrlpt_handle, &value,
+					sizeof(value), NULL, NULL);
 
-	devices = g_slist_remove(devices, hogdev);
-	hog_unregister_device(hogdev);
+	return 0;
 }
 
-static void hog_remove(struct btd_service *service)
+int bt_hog_send_report(struct bt_hog *hog, void *data, size_t size, int type)
 {
-	struct btd_device *device = btd_service_get_device(service);
-	const char *path = device_get_path(device);
+	struct hog_report *report;
 
-	DBG("path %s", path);
-
-	g_slist_foreach(devices, remove_device, device);
-}
+	if (!hog)
+		return -EINVAL;
 
-static struct btd_profile hog_profile = {
-	.name		= "input-hog",
-	.remote_uuid	= HOG_UUID,
-	.device_probe	= hog_probe,
-	.device_remove	= hog_remove,
-};
+	if (!hog->attrib)
+		return -ENOTCONN;
 
-static int hog_init(void)
-{
-	int err;
+	report = find_report(hog, type, 0);
+	if (!report)
+		return -ENOTSUP;
 
-	err = suspend_init(suspend_callback, resume_callback);
-	if (err < 0)
-		error("Loading suspend plugin failed: %s (%d)", strerror(-err),
-									-err);
-	else
-		suspend_supported = TRUE;
+	DBG("hog: Write report, handle 0x%X", report->decl->value_handle);
 
-	return btd_profile_register(&hog_profile);
-}
+	if (report->decl->properties & GATT_CHR_PROP_WRITE)
+		write_char(hog, hog->attrib, report->decl->value_handle,
+				data, size, output_written_cb, hog);
 
-static void hog_exit(void)
-{
-	if (suspend_supported)
-		suspend_exit();
+	if (report->decl->properties & GATT_CHR_PROP_WRITE_WITHOUT_RESP)
+		gatt_write_cmd(hog->attrib, report->decl->value_handle,
+						data, size, NULL, NULL);
 
-	btd_profile_unregister(&hog_profile);
+	return 0;
 }
-
-BLUETOOTH_PLUGIN_DEFINE(hog, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
-							hog_init, hog_exit)
diff --git a/profiles/input/hog.h b/profiles/input/hog.h
new file mode 100644
index 0000000..d32b71e
--- /dev/null
+++ b/profiles/input/hog.h
@@ -0,0 +1,36 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+struct bt_hog;
+
+struct bt_hog *bt_hog_new(const char *name, uint16_t vendor, uint16_t product,
+					uint16_t version, void *primary);
+
+struct bt_hog *bt_hog_ref(struct bt_hog *hog);
+void bt_hog_unref(struct bt_hog *hog);
+
+bool bt_hog_attach(struct bt_hog *hog, void *gatt);
+void bt_hog_detach(gpointer user_data);
+
+int bt_hog_set_control_point(struct bt_hog *hog, bool suspend);
+int bt_hog_send_report(struct bt_hog *hog, void *data, size_t size, int type);
diff --git a/profiles/input/hog_device.c b/profiles/input/hog_device.c
new file mode 100644
index 0000000..b783410
--- /dev/null
+++ b/profiles/input/hog_device.c
@@ -0,0 +1,235 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Intel Corporation.
+ *  Copyright (C) 2012  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2012  Nordic Semiconductor Inc.
+ *  Copyright (C) 2012  Instituto Nokia de Tecnologia - INdT
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdlib.h>
+#include <stdbool.h>
+#include <errno.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+
+#include <bluetooth/bluetooth.h>
+
+#include <glib.h>
+
+#include "src/log.h"
+
+#include "lib/uuid.h"
+#include "src/adapter.h"
+#include "src/device.h"
+#include "src/profile.h"
+#include "src/service.h"
+#include "src/shared/util.h"
+#include "src/shared/uhid.h"
+#include "src/shared/queue.h"
+
+#include "src/plugin.h"
+
+#include "suspend.h"
+#include "attrib/att.h"
+#include "attrib/gattrib.h"
+#include "src/attio.h"
+#include "attrib/gatt.h"
+
+#include "hog.h"
+
+#define HOG_UUID		"00001812-0000-1000-8000-00805f9b34fb"
+
+static gboolean suspend_supported = FALSE;
+static struct queue *hog_devices;
+
+struct hog_device {
+	struct bt_hog		*hog;
+	guint				attioid;
+	struct btd_device	*device;
+};
+
+static void hog_attach(GAttrib *attrib, gpointer user_data)
+{
+	struct bt_hog *hog = user_data;
+
+	bt_hog_attach(hog, attrib);
+}
+
+static struct hog_device *hog_register_device(struct btd_device *device,
+						struct gatt_primary *prim)
+{
+	struct hog_device *hogdev;
+	uint16_t vendor, product, version;
+	char buf[100];
+
+	hogdev = g_try_new0(struct hog_device, 1);
+	if (!hogdev)
+		return NULL;
+
+	hogdev->device = btd_device_ref(device);
+
+	vendor = btd_device_get_vendor(hogdev->device);
+	product = btd_device_get_product(hogdev->device);
+	version = btd_device_get_version(hogdev->device);
+
+	if (device_name_known(hogdev->device))
+		device_get_name(hogdev->device, buf, sizeof(buf));
+	else
+		strcpy(buf, "bluez-hog-device");
+
+	hogdev->hog = bt_hog_new(buf, vendor, product, version, prim);
+
+	if (!hogdev->hog) {
+		btd_device_unref(hogdev->device);
+		g_free(hogdev);
+		return NULL;
+	}
+
+	hogdev->attioid = btd_device_add_attio_callback(device,
+			hog_attach,
+			bt_hog_detach,
+			hogdev->hog);
+
+	return hogdev;
+}
+
+static void set_suspend(struct bt_hog *hog, gpointer user_data)
+{
+	gboolean suspend = GPOINTER_TO_INT(user_data);
+
+	bt_hog_set_control_point(hog, suspend);
+}
+
+static void suspend_callback(void)
+{
+	gboolean suspend = TRUE;
+
+	DBG("Suspending ...");
+
+	queue_foreach(hog_devices, (void *) set_suspend,
+						GINT_TO_POINTER(suspend));
+}
+
+static void resume_callback(void)
+{
+	gboolean suspend = FALSE;
+
+	DBG("Resuming ...");
+
+	queue_foreach(hog_devices, (void *) set_suspend,
+						GINT_TO_POINTER(suspend));
+}
+
+static int hog_probe(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	const char *path = device_get_path(device);
+	GSList *primaries, *l;
+
+	DBG("path %s", path);
+
+	if (!hog_devices)
+		hog_devices = queue_new();
+
+	primaries = btd_device_get_primaries(device);
+	if (primaries == NULL)
+		return -EINVAL;
+
+	for (l = primaries; l; l = g_slist_next(l)) {
+		struct gatt_primary *prim = l->data;
+		struct hog_device *hogdev;
+
+		if (strcmp(prim->uuid, HOG_UUID) != 0)
+			continue;
+
+		hogdev = hog_register_device(device, prim);
+		if (hogdev == NULL)
+			continue;
+
+		queue_push_tail(hog_devices, hogdev);
+	}
+	return 0;
+}
+
+static void remove_device(struct hog_device *hogdev, struct btd_device *device)
+{
+	if (hogdev->device != device)
+		return;
+
+	queue_remove(hog_devices, hogdev);
+	btd_device_remove_attio_callback(hogdev->device, hogdev->attioid);
+	bt_hog_unref(hogdev->hog);
+	btd_device_unref(hogdev->device);
+	g_free(hogdev);
+}
+
+static void hog_remove(struct btd_service *service)
+{
+	struct btd_device *device = btd_service_get_device(service);
+	const char *path = device_get_path(device);
+
+	DBG("path %s", path);
+
+	queue_foreach(hog_devices, (void *) remove_device, device);
+
+	if (queue_isempty(hog_devices)) {
+		queue_destroy(hog_devices, NULL);
+		hog_devices = NULL;
+	}
+}
+
+static struct btd_profile hog_profile = {
+	.name		= "input-hog",
+	.remote_uuid	= HOG_UUID,
+	.device_probe	= hog_probe,
+	.device_remove	= hog_remove,
+};
+
+static int hog_init(void)
+{
+	int err;
+
+	err = suspend_init(suspend_callback, resume_callback);
+	if (err < 0)
+		error("Loading suspend plugin failed: %s (%d)", strerror(-err),
+									-err);
+	else
+		suspend_supported = TRUE;
+
+	return btd_profile_register(&hog_profile);
+}
+
+static void hog_exit(void)
+{
+	if (suspend_supported)
+		suspend_exit();
+
+	btd_profile_unregister(&hog_profile);
+}
+
+BLUETOOTH_PLUGIN_DEFINE(hog, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+							hog_init, hog_exit)
-- 
1.9.1

