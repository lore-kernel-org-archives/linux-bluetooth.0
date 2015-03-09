Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH 2/2] android/hog: Remove HOG common code from android/hog
Date: Mon,  9 Mar 2015 15:23:37 +0100
Message-Id: <1425911017-17254-2-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1425911017-17254-1-git-send-email-mariusz.skamra@tieto.com>
References: <1425911017-17254-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes HOG common code which has been already moved
into profiles/input. bt_hog struct has been replaced by bt_hogdev.
---
 android/Android.mk          |    1 +
 android/Makefile.am         |    1 +
 android/hidhost.c           |   40 +-
 android/hog.c               | 1335 ++++---------------------------------------
 android/hog.h               |   19 +-
 profiles/input/hog_device.c |    1 +
 6 files changed, 158 insertions(+), 1239 deletions(-)

diff --git a/android/Android.mk b/android/Android.mk
index 6c0eda8..9846a4b 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -42,6 +42,7 @@ LOCAL_SRC_FILES := \
 	bluez/android/scpp.c \
 	bluez/android/dis.c \
 	bluez/android/bas.c \
+	bluez/profiles/input/hog.c \
 	bluez/android/hog.c \
 	bluez/android/hidhost.c \
 	bluez/android/socket.c \
diff --git a/android/Makefile.am b/android/Makefile.am
index 676daab..f0be8d1 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -32,6 +32,7 @@ android_bluetoothd_SOURCES = android/main.c \
 				android/dis.h android/dis.c \
 				android/bas.h android/bas.c \
 				android/hog.h android/hog.c \
+				profiles/input/hog.h profiles/input/hog.c \
 				android/ipc-common.h \
 				android/ipc.h android/ipc.c \
 				android/avdtp.h android/avdtp.c \
diff --git a/android/hidhost.c b/android/hidhost.c
index 2e589f4..77e8176 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -44,6 +44,7 @@
 #include "src/sdp-client.h"
 #include "src/uuid-helper.h"
 #include "src/log.h"
+#include "attrib/gattrib.h"
 
 #include "hal-msg.h"
 #include "ipc-common.h"
@@ -111,7 +112,7 @@ struct hid_device {
 	guint		intr_watch;
 	struct bt_uhid	*uhid;
 	uint8_t		last_hid_msg;
-	struct bt_hog	*hog;
+	struct bt_hogdev	*hogdev;
 	int		sec_level;
 };
 
@@ -127,6 +128,8 @@ static void hid_device_free(void *data)
 {
 	struct hid_device *dev = data;
 
+	DBG("");
+
 	if (dev->ctrl_watch > 0)
 		g_source_remove(dev->ctrl_watch);
 
@@ -142,8 +145,8 @@ static void hid_device_free(void *data)
 	if (dev->uhid)
 		bt_uhid_unref(dev->uhid);
 
-	if (dev->hog)
-		bt_hog_unref(dev->hog);
+	if (dev->hogdev)
+		bt_hogdev_unref(dev->hogdev);
 
 	g_free(dev->rd_data);
 	g_free(dev);
@@ -151,6 +154,8 @@ static void hid_device_free(void *data)
 
 static void hid_device_remove(struct hid_device *dev)
 {
+	DBG("");
+
 	devices = g_slist_remove(devices, dev);
 	hid_device_free(dev);
 }
@@ -803,10 +808,10 @@ static void hog_conn_cb(const bdaddr_t *addr, int err, void *attrib)
 	if (err < 0) {
 		if (!dev)
 			return;
-		if (dev->hog) {
+		if (dev->hogdev) {
 			bt_hid_notify_state(dev,
 						HAL_HIDHOST_STATE_DISCONNECTED);
-			bt_hog_detach(dev->hog);
+			bt_hogdev_detach(dev->hogdev);
 			return;
 		}
 		goto fail;
@@ -815,20 +820,20 @@ static void hog_conn_cb(const bdaddr_t *addr, int err, void *attrib)
 	if (!dev)
 		dev = hid_device_new(addr);
 
-	if (!dev->hog) {
+	if (!dev->hogdev) {
 		/* TODO: Get device details and primary */
-		dev->hog = bt_hog_new("bluez-input-device", dev->vendor,
+		dev->hogdev = bt_hogdev_new("bluez-input-device", dev->vendor,
 					dev->product, dev->version, NULL);
-		if (!dev->hog) {
+		if (!dev->hogdev) {
 			error("HoG: unable to create session");
 			goto fail;
 		}
 	}
 
-	if (!bt_hog_attach(dev->hog, attrib)) {
-		error("HoG: unable to attach");
-		goto fail;
-	}
+	if (!bt_hogdev_attach(dev->hogdev, attrib)) {
+			error("HoG: unable to attach");
+			goto fail;
+		}
 
 	if (!bt_gatt_set_security(addr, BT_IO_SEC_MEDIUM)) {
 		error("Failed to set security level");
@@ -930,6 +935,7 @@ static bool hog_disconnect(struct hid_device *dev)
 	bt_hid_notify_state(dev, HAL_HIDHOST_STATE_DISCONNECTING);
 
 	if (!bt_gatt_disconnect_app(hog_app, &dev->dst)) {
+		DBG("1");
 		bt_hid_notify_state(dev, HAL_HIDHOST_STATE_DISCONNECTED);
 		hid_device_remove(dev);
 	}
@@ -1270,7 +1276,7 @@ static void bt_hid_set_report(const void *buf, uint16_t len)
 
 	dev = l->data;
 
-	if (!dev->ctrl_io && !dev->hog) {
+	if (!dev->ctrl_io && !dev->hogdev) {
 		status = HAL_STATUS_FAILED;
 		goto failed;
 	}
@@ -1292,8 +1298,8 @@ static void bt_hid_set_report(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	if (dev->hog) {
-		if (bt_hog_send_report(dev->hog, req + 1, req_size - 1,
+	if (dev->hogdev) {
+		if (bt_hogdev_send_report(dev->hogdev, req + 1, req_size - 1,
 							cmd->type) < 0) {
 			status = HAL_STATUS_FAILED;
 			goto failed;
@@ -1520,8 +1526,6 @@ bool bt_hid_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 {
 	GError *err = NULL;
 
-	DBG("");
-
 	if (!bt_unpaired_register(hid_unpaired_cb)) {
 		error("hidhost: Could not register unpaired callback");
 		return false;
@@ -1568,8 +1572,6 @@ bool bt_hid_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 
 void bt_hid_unregister(void)
 {
-	DBG("");
-
 	if (hog_app > 0)
 		bt_gatt_unregister_app(hog_app);
 
diff --git a/android/hog.c b/android/hog.c
index 88a5460..0030e7c 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -57,71 +57,31 @@
 #include "android/dis.h"
 #include "android/bas.h"
 #include "android/hog.h"
+#include "profiles/input/hog.h"
 
 #define HOG_UUID		"00001812-0000-1000-8000-00805f9b34fb"
 
-#define HOG_INFO_UUID		0x2A4A
-#define HOG_REPORT_MAP_UUID	0x2A4B
-#define HOG_REPORT_UUID		0x2A4D
-#define HOG_PROTO_MODE_UUID	0x2A4E
-#define HOG_CONTROL_POINT_UUID	0x2A4C
-
-#define HOG_REPORT_TYPE_INPUT	1
-#define HOG_REPORT_TYPE_OUTPUT	2
-#define HOG_REPORT_TYPE_FEATURE	3
-
-#define HOG_PROTO_MODE_BOOT    0
-#define HOG_PROTO_MODE_REPORT  1
-
-#define HOG_REPORT_MAP_MAX_SIZE        512
-#define HID_INFO_SIZE			4
-#define ATT_NOTIFICATION_HEADER_SIZE	3
-
-struct bt_hog {
+struct bt_hogdev {
 	int			ref_count;
 	char			*name;
 	uint16_t		vendor;
 	uint16_t		product;
 	uint16_t		version;
-	struct gatt_primary	*primary;
 	GAttrib			*attrib;
-	GSList			*reports;
-	struct bt_uhid		*uhid;
-	gboolean		has_report_id;
-	uint16_t		bcdhid;
-	uint8_t			bcountrycode;
-	uint16_t		proto_mode_handle;
-	uint16_t		ctrlpt_handle;
-	uint8_t			flags;
-	unsigned int		getrep_att;
-	uint16_t		getrep_id;
-	unsigned int		setrep_att;
-	uint16_t		setrep_id;
 	struct bt_scpp		*scpp;
 	struct bt_dis		*dis;
 	struct queue		*bas;
-	GSList			*instances;
+	struct queue		*hog;
 	struct queue		*gatt_op;
 };
 
-struct report {
-	struct bt_hog		*hog;
-	uint8_t			id;
-	uint8_t			type;
-	uint16_t		ccc_handle;
-	guint			notifyid;
-	struct gatt_char	*decl;
-	uint16_t		len;
-	uint8_t			*value;
-};
-
 struct gatt_request {
 	unsigned int id;
-	struct bt_hog *hog;
+	struct bt_hogdev *hogdev;
 	void *user_data;
 };
 
-static struct gatt_request *create_request(struct bt_hog *hog,
+static struct gatt_request *create_request(struct bt_hogdev *hogdev,
 							void *user_data)
 {
 	struct gatt_request *req;
@@ -131,124 +91,40 @@ static struct gatt_request *create_request(struct bt_hog *hog,
 		return NULL;
 
 	req->user_data = user_data;
-	req->hog = bt_hog_ref(hog);
+	req->hogdev = bt_hogdev_ref(hogdev);
 
 	return req;
 }
 
-static bool set_and_store_gatt_req(struct bt_hog *hog,
+static bool set_and_store_gatt_req(struct bt_hogdev *hogdev,
 						struct gatt_request *req,
 						unsigned int id)
 {
 	req->id = id;
-	return queue_push_head(hog->gatt_op, req);
+	return queue_push_head(hogdev->gatt_op, req);
 }
 
 static void destroy_gatt_req(struct gatt_request *req)
 {
-	queue_remove(req->hog->gatt_op, req);
-	bt_hog_unref(req->hog);
-	free(req);
-}
-
-static void write_char(struct bt_hog *hog, GAttrib *attrib, uint16_t handle,
-					const uint8_t *value, size_t vlen,
-					GAttribResultFunc func,
-					gpointer user_data)
-{
-	struct gatt_request *req;
-	unsigned int id;
-
-	req = create_request(hog, user_data);
-	if (!req)
-		return;
-
-	id = gatt_write_char(attrib, handle, value, vlen, func, req);
-
-	if (set_and_store_gatt_req(hog, req, id))
-		return;
-
-	error("hog: Could not read char");
-	g_attrib_cancel(attrib, id);
-	free(req);
-}
-
-static void read_char(struct bt_hog *hog, GAttrib *attrib, uint16_t handle,
-				GAttribResultFunc func, gpointer user_data)
-{
-	struct gatt_request *req;
-	unsigned int id;
-
-	req = create_request(hog, user_data);
-	if (!req)
-		return;
-
-	id = gatt_read_char(attrib, handle, func, req);
-
-	if (set_and_store_gatt_req(hog, req, id))
-		return;
-
-	error("hog: Could not read char");
-	g_attrib_cancel(attrib, id);
-	free(req);
-}
-
-static void discover_desc(struct bt_hog *hog, GAttrib *attrib,
-				uint16_t start, uint16_t end, gatt_cb_t func,
-				gpointer user_data)
-{
-	struct gatt_request *req;
-	unsigned int id;
-
-	req = create_request(hog, user_data);
-	if (!req)
-		return;
-
-	id = gatt_discover_desc(attrib, start, end, NULL, func, req);
-	if (set_and_store_gatt_req(hog, req, id))
-		return;
-
-	error("hog: Could not discover descriptors");
-	g_attrib_cancel(attrib, id);
-	free(req);
-}
-
-static void discover_char(struct bt_hog *hog, GAttrib *attrib,
-						uint16_t start, uint16_t end,
-						bt_uuid_t *uuid, gatt_cb_t func,
-						gpointer user_data)
-{
-	struct gatt_request *req;
-	unsigned int id;
-
-	req = create_request(hog, user_data);
-	if (!req)
-		return;
-
-	id = gatt_discover_char(attrib, start, end, uuid, func, req);
-
-	if (set_and_store_gatt_req(hog, req, id))
-		return;
-
-	error("hog: Could not discover characteristic");
-	g_attrib_cancel(attrib, id);
+	queue_remove(req->hogdev->gatt_op, req);
+	bt_hogdev_unref(req->hogdev);
 	free(req);
 }
 
-static void discover_primary(struct bt_hog *hog, GAttrib *attrib,
+static void discover_primary(struct bt_hogdev *hogdev, GAttrib *attrib,
 						bt_uuid_t *uuid, gatt_cb_t func,
 						gpointer user_data)
 {
 	struct gatt_request *req;
 	unsigned int id;
 
-	req = create_request(hog, user_data);
+	req = create_request(hogdev, user_data);
 	if (!req)
 		return;
 
 	id = gatt_discover_primary(attrib, uuid, func, req);
 
-	if (set_and_store_gatt_req(hog, req, id))
+	if (set_and_store_gatt_req(hogdev, req, id))
 		return;
 
 	error("hog: Could not send discover primary");
@@ -256,20 +132,20 @@ static void discover_primary(struct bt_hog *hog, GAttrib *attrib,
 	free(req);
 }
 
-static void find_included(struct bt_hog *hog, GAttrib *attrib,
+static void find_included(struct bt_hogdev *hogdev, GAttrib *attrib,
 					uint16_t start, uint16_t end,
 					gatt_cb_t func, gpointer user_data)
 {
 	struct gatt_request *req;
 	unsigned int id;
 
-	req = create_request(hog, user_data);
+	req = create_request(hogdev, user_data);
 	if (!req)
 		return;
 
 	id = gatt_find_included(attrib, start, end, func, req);
 
-	if (set_and_store_gatt_req(hog, req, id))
+	if (set_and_store_gatt_req(hogdev, req, id))
 		return;
 
 	error("Could not find included");
@@ -277,959 +153,85 @@ static void find_included(struct bt_hog *hog, GAttrib *attrib,
 	free(req);
 }
 
-static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
-{
-	struct report *report = user_data;
-	struct bt_hog *hog = report->hog;
-	struct uhid_event ev;
-	uint8_t *buf;
-	int err;
-
-	if (len < ATT_NOTIFICATION_HEADER_SIZE) {
-		error("Malformed ATT notification");
-		return;
-	}
-
-	pdu += ATT_NOTIFICATION_HEADER_SIZE;
-	len -= ATT_NOTIFICATION_HEADER_SIZE;
-
-	memset(&ev, 0, sizeof(ev));
-	ev.type = UHID_INPUT;
-	buf = ev.u.input.data;
-
-	if (hog->has_report_id) {
-		buf[0] = report->id;
-		len = MIN(len, sizeof(ev.u.input.data) - 1);
-		memcpy(buf + 1, pdu, len);
-		ev.u.input.size = ++len;
-	} else {
-		len = MIN(len, sizeof(ev.u.input.data));
-		memcpy(buf, pdu, len);
-		ev.u.input.size = len;
-	}
-
-	err = bt_uhid_send(hog->uhid, &ev);
-	if (err < 0) {
-		error("bt_uhid_send: %s (%d)", strerror(-err), -err);
-		return;
-	}
-
-	DBG("HoG report (%u bytes)", ev.u.input.size);
-}
-
-static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
-					guint16 plen, gpointer user_data)
-{
-	struct gatt_request *req = user_data;
-	struct report *report = req->user_data;
-	struct bt_hog *hog = report->hog;
-
-	destroy_gatt_req(req);
-
-	if (status != 0) {
-		error("Write report characteristic descriptor failed: %s",
-							att_ecode2str(status));
-		return;
-	}
-
-	report->notifyid = g_attrib_register(hog->attrib,
-					ATT_OP_HANDLE_NOTIFY,
-					report->decl->value_handle,
-					report_value_cb, report, NULL);
-
-	DBG("Report characteristic descriptor written: notifications enabled");
-}
-
-static void write_ccc(struct bt_hog *hog, GAttrib *attrib, uint16_t handle,
-							void *user_data)
-{
-	uint8_t value[2];
-
-	put_le16(GATT_CLIENT_CHARAC_CFG_NOTIF_BIT, value);
-
-	write_char(hog, attrib, handle, value, sizeof(value),
-					report_ccc_written_cb, user_data);
-}
-
-static void ccc_read_cb(guint8 status, const guint8 *pdu, guint16 len,
-							gpointer user_data)
-{
-	struct gatt_request *req = user_data;
-	struct report *report = req->user_data;
-
-	destroy_gatt_req(req);
-
-	if (status != 0) {
-		error("Error reading CCC value: %s", att_ecode2str(status));
-		return;
-	}
-
-	write_ccc(report->hog, report->hog->attrib, report->ccc_handle, report);
-}
-
-static void report_reference_cb(guint8 status, const guint8 *pdu,
-					guint16 plen, gpointer user_data)
-{
-	struct gatt_request *req = user_data;
-	struct report *report = req->user_data;
-
-	destroy_gatt_req(req);
-
-	if (status != 0) {
-		error("Read Report Reference descriptor failed: %s",
-							att_ecode2str(status));
-		return;
-	}
-
-	if (plen != 3) {
-		error("Malformed ATT read response");
-		return;
-	}
-
-	report->id = pdu[1];
-	report->type = pdu[2];
-	DBG("Report ID: 0x%02x Report type: 0x%02x", pdu[1], pdu[2]);
-
-	/* Enable notifications only for Input Reports */
-	if (report->type == HOG_REPORT_TYPE_INPUT)
-		read_char(report->hog, report->hog->attrib, report->ccc_handle,
-							ccc_read_cb, report);
-}
-
-static void external_report_reference_cb(guint8 status, const guint8 *pdu,
-					guint16 plen, gpointer user_data);
-
-static void discover_external_cb(uint8_t status, GSList *descs, void *user_data)
-{
-	struct gatt_request *req = user_data;
-	struct bt_hog *hog = req->user_data;
-
-	destroy_gatt_req(req);
-
-	if (status != 0) {
-		error("Discover external descriptors failed: %s",
-							att_ecode2str(status));
-		return;
-	}
-
-	for ( ; descs; descs = descs->next) {
-		struct gatt_desc *desc = descs->data;
-
-		read_char(hog, hog->attrib, desc->handle,
-						external_report_reference_cb,
-						hog);
-	}
-}
-
-static void discover_external(struct bt_hog *hog, GAttrib *attrib,
-						uint16_t start, uint16_t end,
-						gpointer user_data)
-{
-	bt_uuid_t uuid;
-
-	if (start > end)
-		return;
-
-	bt_uuid16_create(&uuid, GATT_EXTERNAL_REPORT_REFERENCE);
-
-	discover_desc(hog, attrib, start, end, discover_external_cb,
-								user_data);
-}
-
-static void discover_report_cb(uint8_t status, GSList *descs, void *user_data)
-{
-	struct gatt_request *req = user_data;
-	struct report *report = req->user_data;
-	struct bt_hog *hog = report->hog;
-
-	destroy_gatt_req(req);
-
-	if (status != 0) {
-		error("Discover report descriptors failed: %s",
-							att_ecode2str(status));
-		return;
-	}
-
-	for ( ; descs; descs = descs->next) {
-		struct gatt_desc *desc = descs->data;
-
-		switch (desc->uuid16) {
-		case GATT_CLIENT_CHARAC_CFG_UUID:
-			report->ccc_handle = desc->handle;
-			break;
-		case GATT_REPORT_REFERENCE:
-			read_char(hog, hog->attrib, desc->handle,
-						report_reference_cb, report);
-			break;
-		}
-	}
-}
-
-static void discover_report(struct bt_hog *hog, GAttrib *attrib,
-						uint16_t start, uint16_t end,
-							gpointer user_data)
-{
-	if (start > end)
-		return;
-
-	discover_desc(hog, attrib, start, end, discover_report_cb, user_data);
-}
-
-static void report_read_cb(guint8 status, const guint8 *pdu, guint16 len,
-							gpointer user_data)
-{
-	struct gatt_request *req = user_data;
-	struct report *report = req->user_data;
-
-	destroy_gatt_req(req);
-
-	if (status != 0) {
-		error("Error reading Report value: %s", att_ecode2str(status));
-		return;
-	}
-
-	if (report->value)
-		g_free(report->value);
-
-	report->value = g_memdup(pdu, len);
-	report->len = len;
-}
-
-static struct report *report_new(struct bt_hog *hog, struct gatt_char *chr)
-{
-	struct report *report;
-
-	report = g_new0(struct report, 1);
-	report->hog = hog;
-	report->decl = g_memdup(chr, sizeof(*chr));
-	hog->reports = g_slist_append(hog->reports, report);
-
-	read_char(hog, hog->attrib, chr->value_handle, report_read_cb, report);
-
-	return report;
-}
-
-static void external_service_char_cb(uint8_t status, GSList *chars,
-								void *user_data)
-{
-	struct gatt_request *req = user_data;
-	struct bt_hog *hog = req->user_data;
-	struct gatt_primary *primary = hog->primary;
-	struct report *report;
-	GSList *l;
-
-	destroy_gatt_req(req);
-
-	if (status != 0) {
-		const char *str = att_ecode2str(status);
-		DBG("Discover external service characteristic failed: %s", str);
-		return;
-	}
-
-	for (l = chars; l; l = g_slist_next(l)) {
-		struct gatt_char *chr, *next;
-		uint16_t start, end;
-
-		chr = l->data;
-		next = l->next ? l->next->data : NULL;
-
-		DBG("0x%04x UUID: %s properties: %02x",
-				chr->handle, chr->uuid, chr->properties);
-
-		report = report_new(hog, chr);
-		start = chr->value_handle + 1;
-		end = (next ? next->handle - 1 : primary->range.end);
-		discover_report(hog, hog->attrib, start, end, report);
-	}
-}
-
-static void external_report_reference_cb(guint8 status, const guint8 *pdu,
-					guint16 plen, gpointer user_data)
-{
-	struct gatt_request *req = user_data;
-	struct bt_hog *hog = req->user_data;
-	uint16_t uuid16;
-	bt_uuid_t uuid;
-
-	destroy_gatt_req(req);
-
-	if (status != 0) {
-		error("Read External Report Reference descriptor failed: %s",
-							att_ecode2str(status));
-		return;
-	}
-
-	if (plen != 3) {
-		error("Malformed ATT read response");
-		return;
-	}
-
-	uuid16 = get_le16(&pdu[1]);
-	DBG("External report reference read, external report characteristic "
-						"UUID: 0x%04x", uuid16);
-
-	/* Do not discover if is not a Report */
-	if (uuid16 != HOG_REPORT_UUID)
-		return;
-
-	bt_uuid16_create(&uuid, uuid16);
-	discover_char(hog, hog->attrib, 0x0001, 0xffff, &uuid,
-					external_service_char_cb, hog);
-}
-
-static int report_cmp(gconstpointer a, gconstpointer b)
-{
-	const struct report *ra = a, *rb = b;
-
-	/* sort by type first.. */
-	if (ra->type != rb->type)
-		return ra->type - rb->type;
-
-	/* skip id check in case of report id 0 */
-	if (!rb->id)
-		return 0;
-
-	/* ..then by id */
-	return ra->id - rb->id;
-}
-
-static struct report *find_report(struct bt_hog *hog, uint8_t type, uint8_t id)
-{
-	struct report cmp;
-	GSList *l;
-
-	cmp.type = type;
-	cmp.id = hog->has_report_id ? id : 0;
-
-	l = g_slist_find_custom(hog->reports, &cmp, report_cmp);
-
-	return l ? l->data : NULL;
-}
-
-static struct report *find_report_by_rtype(struct bt_hog *hog, uint8_t rtype,
-								uint8_t id)
-{
-	uint8_t type;
-
-	switch (rtype) {
-	case UHID_FEATURE_REPORT:
-		type = HOG_REPORT_TYPE_FEATURE;
-		break;
-	case UHID_OUTPUT_REPORT:
-		type = HOG_REPORT_TYPE_OUTPUT;
-		break;
-	case UHID_INPUT_REPORT:
-		type = HOG_REPORT_TYPE_INPUT;
-		break;
-	default:
-		return NULL;
-	}
-
-	return find_report(hog, type, id);
-}
-
-static void output_written_cb(guint8 status, const guint8 *pdu,
-					guint16 plen, gpointer user_data)
-{
-	struct gatt_request *req = user_data;
-
-	destroy_gatt_req(req);
-
-	if (status != 0) {
-		error("Write output report failed: %s", att_ecode2str(status));
-		return;
-	}
-}
-
-static void forward_report(struct uhid_event *ev, void *user_data)
-{
-	struct bt_hog *hog = user_data;
-	struct report *report;
-	void *data;
-	int size;
-
-	report = find_report_by_rtype(hog, ev->u.output.rtype,
-							ev->u.output.data[0]);
-	if (!report)
-		return;
-
-	data = ev->u.output.data;
-	size = ev->u.output.size;
-	if (hog->has_report_id && size > 0) {
-		data++;
-		--size;
-	}
-
-	DBG("Sending report type %d ID %d to handle 0x%X", report->type,
-				report->id, report->decl->value_handle);
-
-	if (hog->attrib == NULL)
-		return;
-
-	if (report->decl->properties & GATT_CHR_PROP_WRITE)
-		write_char(hog, hog->attrib, report->decl->value_handle,
-				data, size, output_written_cb, hog);
-	else if (report->decl->properties & GATT_CHR_PROP_WRITE_WITHOUT_RESP)
-		gatt_write_cmd(hog->attrib, report->decl->value_handle,
-						data, size, NULL, NULL);
-}
-
-static void get_feature(struct uhid_event *ev, void *user_data)
-{
-	struct bt_hog *hog = user_data;
-	struct report *report;
-	struct uhid_event rsp;
-	int err;
-
-	memset(&rsp, 0, sizeof(rsp));
-	rsp.type = UHID_FEATURE_ANSWER;
-	rsp.u.feature_answer.id = ev->u.feature.id;
-
-	report = find_report_by_rtype(hog, ev->u.feature.rtype,
-							ev->u.feature.rnum);
-	if (!report) {
-		rsp.u.feature_answer.err = ENOTSUP;
-		goto done;
-	}
-
-	if (!report->value) {
-		rsp.u.feature_answer.err = EIO;
-		goto done;
-	}
-
-	rsp.u.feature_answer.size = report->len;
-	memcpy(rsp.u.feature_answer.data, report->value, report->len);
-
-done:
-	err = bt_uhid_send(hog->uhid, &rsp);
-	if (err < 0)
-		error("bt_uhid_send: %s", strerror(-err));
-}
-
-static void set_report_cb(guint8 status, const guint8 *pdu,
-					guint16 plen, gpointer user_data)
-{
-	struct bt_hog *hog = user_data;
-	struct uhid_event rsp;
-	int err;
-
-	hog->setrep_att = 0;
-
-	memset(&rsp, 0, sizeof(rsp));
-	rsp.type = UHID_SET_REPORT_REPLY;
-	rsp.u.set_report_reply.id = hog->setrep_id;
-	rsp.u.set_report_reply.err = status;
-
-	if (status != 0)
-		error("Error setting Report value: %s", att_ecode2str(status));
-
-	err = bt_uhid_send(hog->uhid, &rsp);
-	if (err < 0)
-		error("bt_uhid_send: %s", strerror(-err));
-}
-
-static void set_report(struct uhid_event *ev, void *user_data)
-{
-	struct bt_hog *hog = user_data;
-	struct report *report;
-	void *data;
-	int size;
-	int err;
-
-	/* uhid never sends reqs in parallel; if there's a req, it timed out */
-	if (hog->setrep_att) {
-		g_attrib_cancel(hog->attrib, hog->setrep_att);
-		hog->setrep_att = 0;
-	}
-
-	hog->setrep_id = ev->u.set_report.id;
-
-	report = find_report_by_rtype(hog, ev->u.set_report.rtype,
-							ev->u.set_report.rnum);
-	if (!report) {
-		err = ENOTSUP;
-		goto fail;
-	}
-
-	data = ev->u.set_report.data;
-	size = ev->u.set_report.size;
-	if (hog->has_report_id && size > 0) {
-		data++;
-		--size;
-	}
-
-	DBG("Sending report type %d ID %d to handle 0x%X", report->type,
-				report->id, report->decl->value_handle);
-
-	if (hog->attrib == NULL)
-		return;
-
-	hog->setrep_att = gatt_write_char(hog->attrib,
-						report->decl->value_handle,
-						data, size, set_report_cb,
-						hog);
-	if (!hog->setrep_att) {
-		err = ENOMEM;
-		goto fail;
-	}
-
-	return;
-fail:
-	/* cancel the request on failure */
-	set_report_cb(err, NULL, 0, hog);
-}
-
-static void get_report_cb(guint8 status, const guint8 *pdu, guint16 len,
-							gpointer user_data)
-{
-	struct bt_hog *hog = user_data;
-	struct uhid_event rsp;
-	int err;
-
-	hog->getrep_att = 0;
-
-	memset(&rsp, 0, sizeof(rsp));
-	rsp.type = UHID_GET_REPORT_REPLY;
-	rsp.u.get_report_reply.id = hog->getrep_id;
-
-	if (status != 0) {
-		error("Error reading Report value: %s", att_ecode2str(status));
-		goto exit;
-	}
-
-	if (len == 0) {
-		error("Error reading Report, length %d", len);
-		status = EIO;
-		goto exit;
-	}
-
-	if (pdu[0] != 0x0b) {
-		error("Error reading Report, invalid response: %02x", pdu[0]);
-		status = EPROTO;
-		goto exit;
-	}
-
-	--len;
-	++pdu;
-	if (hog->has_report_id && len > 0) {
-		--len;
-		++pdu;
-	}
-
-	rsp.u.get_report_reply.size = len;
-	memcpy(rsp.u.get_report_reply.data, pdu, len);
-
-exit:
-	rsp.u.get_report_reply.err = status;
-	err = bt_uhid_send(hog->uhid, &rsp);
-	if (err < 0)
-		error("bt_uhid_send: %s", strerror(-err));
-}
-
-static void get_report(struct uhid_event *ev, void *user_data)
-{
-	struct bt_hog *hog = user_data;
-	struct report *report;
-	guint8 err;
-
-	/* uhid never sends reqs in parallel; if there's a req, it timed out */
-	if (hog->getrep_att) {
-		g_attrib_cancel(hog->attrib, hog->getrep_att);
-		hog->getrep_att = 0;
-	}
-
-	hog->getrep_id = ev->u.get_report.id;
-
-	report = find_report_by_rtype(hog, ev->u.get_report.rtype,
-							ev->u.get_report.rnum);
-	if (!report) {
-		err = ENOTSUP;
-		goto fail;
-	}
-
-	hog->getrep_att = gatt_read_char(hog->attrib,
-						report->decl->value_handle,
-						get_report_cb, hog);
-	if (!hog->getrep_att) {
-		err = ENOMEM;
-		goto fail;
-	}
-
-	return;
-
-fail:
-	/* cancel the request on failure */
-	get_report_cb(err, NULL, 0, hog);
-}
-
-static bool get_descriptor_item_info(uint8_t *buf, ssize_t blen, ssize_t *len,
-								bool *is_long)
-{
-	if (!blen)
-		return false;
-
-	*is_long = (buf[0] == 0xfe);
-
-	if (*is_long) {
-		if (blen < 3)
-			return false;
-
-		/*
-		 * long item:
-		 * byte 0 -> 0xFE
-		 * byte 1 -> data size
-		 * byte 2 -> tag
-		 * + data
-		 */
-
-		*len = buf[1] + 3;
-	} else {
-		uint8_t b_size;
-
-		/*
-		 * short item:
-		 * byte 0[1..0] -> data size (=0, 1, 2, 4)
-		 * byte 0[3..2] -> type
-		 * byte 0[7..4] -> tag
-		 * + data
-		 */
-
-		b_size = buf[0] & 0x03;
-		*len = (b_size ? 1 << (b_size - 1) : 0) + 1;
-	}
-
-	/* item length should be no more than input buffer length */
-	return *len <= blen;
-}
-
-static char *item2string(char *str, uint8_t *buf, uint8_t len)
-{
-	char *p = str;
-	int i;
-
-	/*
-	 * Since long item tags are not defined except for vendor ones, we
-	 * just ensure that short items are printed properly (up to 5 bytes).
-	 */
-	for (i = 0; i < 6 && i < len; i++)
-		p += sprintf(p, " %02x", buf[i]);
-
-	/*
-	 * If there are some data left, just add continuation mark to indicate
-	 * this.
-	 */
-	if (i < len)
-		sprintf(p, " ...");
-
-	return str;
-}
-
-static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
-{
-	struct gatt_request *req = user_data;
-	struct bt_hog *hog = req->user_data;
-	uint8_t value[HOG_REPORT_MAP_MAX_SIZE];
-	struct uhid_event ev;
-	ssize_t vlen;
-	char itemstr[20]; /* 5x3 (data) + 4 (continuation) + 1 (null) */
-	int i, err;
-	GError *gerr = NULL;
-
-	destroy_gatt_req(req);
-
-	if (status != 0) {
-		error("Report Map read failed: %s", att_ecode2str(status));
-		return;
-	}
-
-	vlen = dec_read_resp(pdu, plen, value, sizeof(value));
-	if (vlen < 0) {
-		error("ATT protocol error");
-		return;
-	}
-
-	DBG("Report MAP:");
-	for (i = 0; i < vlen;) {
-		ssize_t ilen = 0;
-		bool long_item = false;
-
-		if (get_descriptor_item_info(&value[i], vlen - i, &ilen,
-								&long_item)) {
-			/* Report ID is short item with prefix 100001xx */
-			if (!long_item && (value[i] & 0xfc) == 0x84)
-				hog->has_report_id = TRUE;
-
-			DBG("\t%s", item2string(itemstr, &value[i], ilen));
-
-			i += ilen;
-		} else {
-			error("Report Map parsing failed at %d", i);
-
-			/* Just print remaining items at once and break */
-			DBG("\t%s", item2string(itemstr, &value[i], vlen - i));
-			break;
-		}
-	}
-
-	/* create uHID device */
-	memset(&ev, 0, sizeof(ev));
-	ev.type = UHID_CREATE;
-
-	bt_io_get(g_attrib_get_channel(hog->attrib), &gerr,
-			BT_IO_OPT_SOURCE, ev.u.create.phys,
-			BT_IO_OPT_DEST, ev.u.create.uniq,
-			BT_IO_OPT_INVALID);
-	if (gerr) {
-		error("Failed to connection details: %s", gerr->message);
-		g_error_free(gerr);
-		return;
-	}
-
-	strcpy((char *) ev.u.create.name, hog->name);
-	ev.u.create.vendor = hog->vendor;
-	ev.u.create.product = hog->product;
-	ev.u.create.version = hog->version;
-	ev.u.create.country = hog->bcountrycode;
-	ev.u.create.bus = BUS_BLUETOOTH;
-	ev.u.create.rd_data = value;
-	ev.u.create.rd_size = vlen;
-
-	err = bt_uhid_send(hog->uhid, &ev);
-	if (err < 0) {
-		error("bt_uhid_send: %s", strerror(-err));
-		return;
-	}
-
-	bt_uhid_register(hog->uhid, UHID_OUTPUT, forward_report, hog);
-	bt_uhid_register(hog->uhid, UHID_FEATURE, get_feature, hog);
-	bt_uhid_register(hog->uhid, UHID_GET_REPORT, get_report, hog);
-	bt_uhid_register(hog->uhid, UHID_SET_REPORT, set_report, hog);
-}
-
-static void info_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
-{
-	struct gatt_request *req = user_data;
-	struct bt_hog *hog = req->user_data;
-	uint8_t value[HID_INFO_SIZE];
-	ssize_t vlen;
-
-	destroy_gatt_req(req);
-
-	if (status != 0) {
-		error("HID Information read failed: %s",
-						att_ecode2str(status));
-		return;
-	}
-
-	vlen = dec_read_resp(pdu, plen, value, sizeof(value));
-	if (vlen != 4) {
-		error("ATT protocol error");
-		return;
-	}
-
-	hog->bcdhid = get_le16(&value[0]);
-	hog->bcountrycode = value[2];
-	hog->flags = value[3];
-
-	DBG("bcdHID: 0x%04X bCountryCode: 0x%02X Flags: 0x%02X",
-			hog->bcdhid, hog->bcountrycode, hog->flags);
-}
-
-static void proto_mode_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
-							gpointer user_data)
-{
-	struct gatt_request *req = user_data;
-	struct bt_hog *hog = req->user_data;
-	uint8_t value;
-	ssize_t vlen;
-
-	destroy_gatt_req(req);
-
-	if (status != 0) {
-		error("Protocol Mode characteristic read failed: %s",
-							att_ecode2str(status));
-		return;
-	}
-
-	vlen = dec_read_resp(pdu, plen, &value, sizeof(value));
-	if (vlen < 0) {
-		error("ATT protocol error");
-		return;
-	}
-
-	if (value == HOG_PROTO_MODE_BOOT) {
-		uint8_t nval = HOG_PROTO_MODE_REPORT;
-
-		DBG("HoG is operating in Boot Procotol Mode");
-
-		gatt_write_cmd(hog->attrib, hog->proto_mode_handle, &nval,
-						sizeof(nval), NULL, NULL);
-	} else if (value == HOG_PROTO_MODE_REPORT)
-		DBG("HoG is operating in Report Protocol Mode");
-}
-
-static void char_discovered_cb(uint8_t status, GSList *chars, void *user_data)
-{
-	struct gatt_request *req = user_data;
-	struct bt_hog *hog = req->user_data;
-	struct gatt_primary *primary = hog->primary;
-	bt_uuid_t report_uuid, report_map_uuid, info_uuid;
-	bt_uuid_t proto_mode_uuid, ctrlpt_uuid;
-	struct report *report;
-	GSList *l;
-	uint16_t info_handle = 0, proto_mode_handle = 0;
-
-	destroy_gatt_req(req);
-
-	if (status != 0) {
-		const char *str = att_ecode2str(status);
-		DBG("Discover all characteristics failed: %s", str);
-		return;
-	}
-
-	bt_uuid16_create(&report_uuid, HOG_REPORT_UUID);
-	bt_uuid16_create(&report_map_uuid, HOG_REPORT_MAP_UUID);
-	bt_uuid16_create(&info_uuid, HOG_INFO_UUID);
-	bt_uuid16_create(&proto_mode_uuid, HOG_PROTO_MODE_UUID);
-	bt_uuid16_create(&ctrlpt_uuid, HOG_CONTROL_POINT_UUID);
-
-	for (l = chars; l; l = g_slist_next(l)) {
-		struct gatt_char *chr, *next;
-		bt_uuid_t uuid;
-		uint16_t start, end;
-
-		chr = l->data;
-		next = l->next ? l->next->data : NULL;
-
-		DBG("0x%04x UUID: %s properties: %02x",
-				chr->handle, chr->uuid, chr->properties);
-
-		bt_string_to_uuid(&uuid, chr->uuid);
-
-		start = chr->value_handle + 1;
-		end = (next ? next->handle - 1 : primary->range.end);
-
-		if (bt_uuid_cmp(&uuid, &report_uuid) == 0) {
-			report = report_new(hog, chr);
-			discover_report(hog, hog->attrib, start, end, report);
-		} else if (bt_uuid_cmp(&uuid, &report_map_uuid) == 0) {
-			read_char(hog, hog->attrib, chr->value_handle,
-						report_map_read_cb, hog);
-			discover_external(hog, hog->attrib, start, end, hog);
-		} else if (bt_uuid_cmp(&uuid, &info_uuid) == 0)
-			info_handle = chr->value_handle;
-		else if (bt_uuid_cmp(&uuid, &proto_mode_uuid) == 0)
-			proto_mode_handle = chr->value_handle;
-		else if (bt_uuid_cmp(&uuid, &ctrlpt_uuid) == 0)
-			hog->ctrlpt_handle = chr->value_handle;
-	}
-
-	if (proto_mode_handle) {
-		hog->proto_mode_handle = proto_mode_handle;
-		read_char(hog, hog->attrib, proto_mode_handle,
-						proto_mode_read_cb, hog);
-	}
-
-	if (info_handle)
-		read_char(hog, hog->attrib, info_handle, info_read_cb, hog);
-}
-
-static void report_free(void *data)
-{
-	struct report *report = data;
-
-	g_free(report->value);
-	g_free(report->decl);
-	g_free(report);
-}
-
 static void cancel_gatt_req(struct gatt_request *req)
 {
-	if (g_attrib_cancel(req->hog->attrib, req->id))
+	if (g_attrib_cancel(req->hogdev->attrib, req->id))
 		destroy_gatt_req(req);
 }
 
-static void hog_free(void *data)
+static void hogdev_free(void *data)
 {
-	struct bt_hog *hog = data;
+	struct bt_hogdev *hogdev = data;
 
-	bt_hog_detach(hog);
+	bt_hogdev_detach(hogdev);
 
-	queue_destroy(hog->bas, (void *) bt_bas_unref);
-	g_slist_free_full(hog->instances, hog_free);
-
-	bt_scpp_unref(hog->scpp);
-	bt_dis_unref(hog->dis);
-	bt_uhid_unref(hog->uhid);
-	g_slist_free_full(hog->reports, report_free);
-	g_free(hog->name);
-	g_free(hog->primary);
-	queue_destroy(hog->gatt_op, (void *) destroy_gatt_req);
-	g_free(hog);
+	queue_destroy(hogdev->bas, (void *) bt_bas_unref);
+	queue_destroy(hogdev->hog, (void *) bt_hog_unref);
+	bt_scpp_unref(hogdev->scpp);
+	bt_dis_unref(hogdev->dis);
+	g_free(hogdev->name);
+	queue_destroy(hogdev->gatt_op, (void *) destroy_gatt_req);
+	g_free(hogdev);
 }
 
-struct bt_hog *bt_hog_new(const char *name, uint16_t vendor, uint16_t product,
-					uint16_t version, void *primary)
+struct bt_hogdev *bt_hogdev_new(const char *name, uint16_t vendor,
+					uint16_t product, uint16_t version,
+					void *primary)
 {
-	struct bt_hog *hog;
+	struct bt_hogdev *hogdev;
 
-	hog = g_try_new0(struct bt_hog, 1);
-	if (!hog)
+	hogdev = g_try_new0(struct bt_hogdev, 1);
+	if (!hogdev)
 		return NULL;
 
-	hog->gatt_op = queue_new();
-	if (!hog->gatt_op) {
-		hog_free(hog);
+	hogdev->gatt_op = queue_new();
+	if (!hogdev->gatt_op) {
+		hogdev_free(hogdev);
 		return NULL;
 	}
 
-	hog->bas = queue_new();
-	if (!hog->bas) {
-		queue_destroy(hog->gatt_op, NULL);
-		hog_free(hog);
+	hogdev->bas = queue_new();
+	if (!hogdev->bas) {
+		queue_destroy(hogdev->gatt_op, NULL);
+		hogdev_free(hogdev);
 		return NULL;
 	}
 
-	hog->uhid = bt_uhid_new_default();
-	if (!hog->uhid) {
-		hog_free(hog);
-		queue_destroy(hog->gatt_op, NULL);
-		queue_destroy(hog->bas, NULL);
+	hogdev->hog = queue_new();
+	if (!hogdev->hog) {
+		queue_destroy(hogdev->bas, NULL);
+		queue_destroy(hogdev->gatt_op, NULL);
+		hogdev_free(hogdev);
 		return NULL;
 	}
 
-	hog->name = g_strdup(name);
-	hog->vendor = vendor;
-	hog->product = product;
-	hog->version = version;
-
-	if (primary)
-		hog->primary = g_memdup(primary, sizeof(*hog->primary));
+	hogdev->name = g_strdup(name);
+	hogdev->vendor = vendor;
+	hogdev->product = product;
+	hogdev->version = version;
 
-	return bt_hog_ref(hog);
+	return bt_hogdev_ref(hogdev);
 }
 
-struct bt_hog *bt_hog_ref(struct bt_hog *hog)
+struct bt_hogdev *bt_hogdev_ref(struct bt_hogdev *hogdev)
 {
-	if (!hog)
+	if (!hogdev)
 		return NULL;
 
-	__sync_fetch_and_add(&hog->ref_count, 1);
+	__sync_fetch_and_add(&hogdev->ref_count, 1);
 
-	return hog;
+	return hogdev;
 }
 
-void bt_hog_unref(struct bt_hog *hog)
+void bt_hogdev_unref(struct bt_hogdev *hogdev)
 {
-	if (!hog)
+	if (!hogdev)
 		return;
 
-	if (__sync_sub_and_fetch(&hog->ref_count, 1))
+	if (__sync_sub_and_fetch(&hogdev->ref_count, 1))
 		return;
 
-	hog_free(hog);
+	hogdev_free(hogdev);
 }
 
 static void find_included_cb(uint8_t status, GSList *services, void *user_data)
@@ -1237,8 +239,6 @@ static void find_included_cb(uint8_t status, GSList *services, void *user_data)
 	struct gatt_request *req = user_data;
 	GSList *l;
 
-	DBG("");
-
 	destroy_gatt_req(req);
 
 	if (status) {
@@ -1255,43 +255,35 @@ static void find_included_cb(uint8_t status, GSList *services, void *user_data)
 	}
 }
 
-static void hog_attach_scpp(struct bt_hog *hog, struct gatt_primary *primary)
+static void hogdev_attach_scpp(struct bt_hogdev *hogdev,
+						struct gatt_primary *primary)
 {
-	if (hog->scpp) {
-		bt_scpp_attach(hog->scpp, hog->attrib);
+	if (hogdev->scpp) {
+		bt_scpp_attach(hogdev->scpp, hogdev->attrib);
 		return;
 	}
 
-	hog->scpp = bt_scpp_new(primary);
-	if (hog->scpp)
-		bt_scpp_attach(hog->scpp, hog->attrib);
+	hogdev->scpp = bt_scpp_new(primary);
+	if (hogdev->scpp)
+		bt_scpp_attach(hogdev->scpp, hogdev->attrib);
 }
 
-static void dis_notify(uint8_t source, uint16_t vendor, uint16_t product,
-					uint16_t version, void *user_data)
+static void hogdev_attach_dis(struct bt_hogdev *hogdev,
+						struct gatt_primary *primary)
 {
-	struct bt_hog *hog = user_data;
-
-	hog->vendor = vendor;
-	hog->product = product;
-	hog->version = version;
-}
-
-static void hog_attach_dis(struct bt_hog *hog, struct gatt_primary *primary)
-{
-	if (hog->dis) {
-		bt_dis_attach(hog->dis, hog->attrib);
+	if (hogdev->dis) {
+		bt_dis_attach(hogdev->dis, hogdev->attrib);
 		return;
 	}
 
-	hog->dis = bt_dis_new(primary);
-	if (hog->dis) {
-		bt_dis_set_notification(hog->dis, dis_notify, hog);
-		bt_dis_attach(hog->dis, hog->attrib);
+	hogdev->dis = bt_dis_new(primary);
+	if (hogdev->dis) {
+		bt_dis_attach(hogdev->dis, hogdev->attrib);
 	}
 }
 
-static void hog_attach_bas(struct bt_hog *hog, struct gatt_primary *primary)
+static void hogdev_attach_bas(struct bt_hogdev *hogdev,
+						struct gatt_primary *primary)
 {
 	struct bt_bas *instance;
 
@@ -1299,40 +291,32 @@ static void hog_attach_bas(struct bt_hog *hog, struct gatt_primary *primary)
 	if (!instance)
 		return;
 
-	bt_bas_attach(instance, hog->attrib);
-	queue_push_head(hog->bas, instance);
+	bt_bas_attach(instance, hogdev->attrib);
+	queue_push_head(hogdev->bas, instance);
 }
 
-static void hog_attach_hog(struct bt_hog *hog, struct gatt_primary *primary)
+static void hogdev_attach_hog(struct bt_hogdev *hogdev,
+						struct gatt_primary *primary)
 {
 	struct bt_hog *instance;
 
-	if (!hog->primary) {
-		hog->primary = g_memdup(primary, sizeof(*primary));
-		discover_char(hog, hog->attrib, primary->range.start,
-						primary->range.end, NULL,
-						char_discovered_cb, hog);
-		find_included(hog, hog->attrib, primary->range.start,
-				primary->range.end, find_included_cb, hog);
-		return;
-	}
-
-	instance = bt_hog_new(hog->name, hog->vendor, hog->product,
-							hog->version, primary);
+	instance = bt_hog_new(hogdev->name, hogdev->vendor, hogdev->product,
+						hogdev->version, primary);
 	if (!instance)
 		return;
 
-	find_included(instance, hog->attrib, primary->range.start,
-			primary->range.end, find_included_cb, instance);
+	bt_hog_attach(instance, hogdev->attrib);
+	queue_push_head(hogdev->hog, instance);
 
-	bt_hog_attach(instance, hog->attrib);
-	hog->instances = g_slist_append(hog->instances, instance);
+
+	find_included(hogdev, hogdev->attrib, primary->range.start,
+				primary->range.end, find_included_cb, hogdev);
 }
 
 static void primary_cb(uint8_t status, GSList *services, void *user_data)
 {
 	struct gatt_request *req = user_data;
-	struct bt_hog *hog = req->user_data;
+	struct bt_hogdev *hogdev = req->user_data;
 	struct gatt_primary *primary;
 	GSList *l;
 
@@ -1355,154 +339,85 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
 		primary = l->data;
 
 		if (strcmp(primary->uuid, SCAN_PARAMETERS_UUID) == 0) {
-			hog_attach_scpp(hog, primary);
+			hogdev_attach_scpp(hogdev, primary);
 			continue;
 		}
 
 		if (strcmp(primary->uuid, DEVICE_INFORMATION_UUID) == 0) {
-			hog_attach_dis(hog, primary);
+			hogdev_attach_dis(hogdev, primary);
 			continue;
 		}
 
 		if (strcmp(primary->uuid, BATTERY_UUID) == 0) {
-			hog_attach_bas(hog, primary);
+			hogdev_attach_bas(hogdev, primary);
 			continue;
 		}
 
 		if (strcmp(primary->uuid, HOG_UUID) == 0)
-			hog_attach_hog(hog, primary);
+			hogdev_attach_hog(hogdev, primary);
 	}
 }
 
-bool bt_hog_attach(struct bt_hog *hog, void *gatt)
+bool bt_hogdev_attach(struct bt_hogdev *hogdev, void *gatt)
 {
-	struct gatt_primary *primary = hog->primary;
-	GSList *l;
-
-	if (hog->attrib)
+	if (hogdev->attrib)
 		return false;
 
-	hog->attrib = g_attrib_ref(gatt);
+	hogdev->attrib = g_attrib_ref(gatt);
 
-	if (!primary) {
-		discover_primary(hog, hog->attrib, NULL, primary_cb, hog);
+	if (queue_isempty(hogdev->hog)) {
+		discover_primary(hogdev, hogdev->attrib, NULL,
+						primary_cb, hogdev);
 		return true;
 	}
 
-	if (hog->scpp)
-		bt_scpp_attach(hog->scpp, gatt);
-
-	if (hog->dis)
-		bt_dis_attach(hog->dis, gatt);
+	if (hogdev->scpp)
+		bt_scpp_attach(hogdev->scpp, gatt);
 
-	queue_foreach(hog->bas, (void *) bt_bas_attach, gatt);
+	if (hogdev->dis)
+		bt_dis_attach(hogdev->dis, gatt);
 
-	for (l = hog->instances; l; l = l->next) {
-		struct bt_hog *instance = l->data;
-
-		bt_hog_attach(instance, gatt);
-	}
-
-	if (hog->reports == NULL) {
-		discover_char(hog, hog->attrib, primary->range.start,
-						primary->range.end, NULL,
-						char_discovered_cb, hog);
-		return true;
-	}
-
-	for (l = hog->reports; l; l = l->next) {
-		struct report *r = l->data;
-
-		r->notifyid = g_attrib_register(hog->attrib,
-					ATT_OP_HANDLE_NOTIFY,
-					r->decl->value_handle,
-					report_value_cb, r, NULL);
-	}
+	queue_foreach(hogdev->hog, (void *) bt_hog_attach, gatt);
+	queue_foreach(hogdev->bas, (void *) bt_bas_attach, gatt);
 
 	return true;
 }
 
-void bt_hog_detach(struct bt_hog *hog)
+void bt_hogdev_detach(struct bt_hogdev *hogdev)
 {
-	GSList *l;
-
-	if (!hog->attrib)
+	if (!hogdev->attrib)
 		return;
 
-	queue_foreach(hog->bas, (void *) bt_bas_detach, NULL);
-
-	for (l = hog->instances; l; l = l->next) {
-		struct bt_hog *instance = l->data;
-
-		bt_hog_detach(instance);
-	}
-
-	for (l = hog->reports; l; l = l->next) {
-		struct report *r = l->data;
-
-		if (r->notifyid > 0) {
-			g_attrib_unregister(hog->attrib, r->notifyid);
-			r->notifyid = 0;
-		}
-	}
-
-	if (hog->scpp)
-		bt_scpp_detach(hog->scpp);
-
-	if (hog->dis)
-		bt_dis_detach(hog->dis);
-
-	queue_foreach(hog->gatt_op, (void *) cancel_gatt_req, NULL);
-	g_attrib_unref(hog->attrib);
-	hog->attrib = NULL;
-}
-
-int bt_hog_set_control_point(struct bt_hog *hog, bool suspend)
-{
-	uint8_t value = suspend ? 0x00 : 0x01;
-
-	if (hog->attrib == NULL)
-		return -ENOTCONN;
+	if (hogdev->scpp)
+		bt_scpp_detach(hogdev->scpp);
 
-	if (hog->ctrlpt_handle == 0)
-		return -ENOTSUP;
+	if (hogdev->dis)
+		bt_dis_detach(hogdev->dis);
 
-	gatt_write_cmd(hog->attrib, hog->ctrlpt_handle, &value,
-					sizeof(value), NULL, NULL);
+	queue_foreach(hogdev->hog, (void *) bt_hog_detach, NULL);
+	queue_foreach(hogdev->bas, (void *) bt_bas_detach, NULL);
+	queue_foreach(hogdev->gatt_op, (void *) cancel_gatt_req, NULL);
 
-	return 0;
+	g_attrib_unref(hogdev->attrib);
+	hogdev->attrib = NULL;
 }
 
-int bt_hog_send_report(struct bt_hog *hog, void *data, size_t size, int type)
+int bt_hogdev_send_report(struct bt_hogdev *hogdev, void *data,
+							size_t size, int type)
 {
-	struct report *report;
-	GSList *l;
-
-	if (!hog)
-		return -EINVAL;
-
-	if (!hog->attrib)
-		return -ENOTCONN;
-
-	report = find_report(hog, type, 0);
-	if (!report)
-		return -ENOTSUP;
-
-	DBG("hog: Write report, handle 0x%X", report->decl->value_handle);
-
-	if (report->decl->properties & GATT_CHR_PROP_WRITE)
-		write_char(hog, hog->attrib, report->decl->value_handle,
-				data, size, output_written_cb, hog);
+	const struct queue_entry *hog_entry;
+	struct bt_hog *hog;
+	int status;
 
-	if (report->decl->properties & GATT_CHR_PROP_WRITE_WITHOUT_RESP)
-		gatt_write_cmd(hog->attrib, report->decl->value_handle,
-						data, size, NULL, NULL);
+	hog_entry = queue_get_entries(hogdev->hog);
 
-	for (l = hog->instances; l; l = l->next) {
-		struct bt_hog *instance = l->data;
+	while (hog_entry) {
+		hog = hog_entry->data;
+		status = bt_hog_send_report(hog, data, size, type);
+		if (status)
+			return status;
 
-		bt_hog_send_report(instance, data, size, type);
+		hog_entry = hog_entry->next;
 	}
-
 	return 0;
 }
diff --git a/android/hog.h b/android/hog.h
index ddb2cea..d6094c6 100644
--- a/android/hog.h
+++ b/android/hog.h
@@ -4,7 +4,6 @@
  *
  *  Copyright (C) 2014  Intel Corporation. All rights reserved.
  *
- *
  *  This library is free software; you can redistribute it and/or
  *  modify it under the terms of the GNU Lesser General Public
  *  License as published by the Free Software Foundation; either
@@ -21,16 +20,16 @@
  *
  */
 
-struct bt_hog;
+struct bt_hogdev;
 
-struct bt_hog *bt_hog_new(const char *name, uint16_t vendor, uint16_t product,
-					uint16_t version, void *primary);
+struct bt_hogdev *bt_hogdev_new(const char *name, uint16_t vendor,
+			uint16_t product, uint16_t version, void *primary);
 
-struct bt_hog *bt_hog_ref(struct bt_hog *hog);
-void bt_hog_unref(struct bt_hog *hog);
+struct bt_hogdev *bt_hogdev_ref(struct bt_hogdev *hogdev);
+void bt_hogdev_unref(struct bt_hogdev *hogdev);
 
-bool bt_hog_attach(struct bt_hog *hog, void *gatt);
-void bt_hog_detach(struct bt_hog *hog);
+bool bt_hogdev_attach(struct bt_hogdev *hogdev, void *gatt);
+void bt_hogdev_detach(struct bt_hogdev *hogdev);
 
-int bt_hog_set_control_point(struct bt_hog *hog, bool suspend);
-int bt_hog_send_report(struct bt_hog *hog, void *data, size_t size, int type);
+int bt_hogdev_send_report(struct bt_hogdev *hogdev, void *data,
+							size_t size, int type);
diff --git a/profiles/input/hog_device.c b/profiles/input/hog_device.c
index b783410..c6bb9bf 100644
--- a/profiles/input/hog_device.c
+++ b/profiles/input/hog_device.c
@@ -43,6 +43,7 @@
 #include "src/log.h"
 
 #include "lib/uuid.h"
+#include "lib/sdp.h"
 #include "src/adapter.h"
 #include "src/device.h"
 #include "src/profile.h"
-- 
1.9.1

