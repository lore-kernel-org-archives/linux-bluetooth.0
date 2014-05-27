Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RCF BlueZ 2/2] android/hog: Strip dependencies from input plugin
Date: Tue, 27 May 2014 14:15:38 +0300
Message-Id: <1401189338-9045-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1401189338-9045-1-git-send-email-luiz.dentz@gmail.com>
References: <1401189338-9045-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This strip any dependecy from input plugin so the code can be used by
hidhost interface.
---
 android/Android.mk  |   2 +
 android/Makefile.am |   2 +
 android/hog.c       | 465 +++++++++++++++++++---------------------------------
 android/hog.h       |  35 ++++
 4 files changed, 208 insertions(+), 296 deletions(-)
 create mode 100644 android/hog.h

diff --git a/android/Android.mk b/android/Android.mk
index f59352a..6cc44a9 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -32,6 +32,7 @@ include $(CLEAR_VARS)
 LOCAL_SRC_FILES := \
 	bluez/android/main.c \
 	bluez/android/bluetooth.c \
+	bluez/android/hog.c \
 	bluez/android/hidhost.c \
 	bluez/android/socket.c \
 	bluez/android/ipc.c \
@@ -53,6 +54,7 @@ LOCAL_SRC_FILES := \
 	bluez/src/shared/hfp.c \
 	bluez/src/shared/gatt-db.c \
 	bluez/src/shared/io-glib.c \
+	bluez/src/share/uhid.c \
 	bluez/src/sdpd-database.c \
 	bluez/src/sdpd-service.c \
 	bluez/src/sdpd-request.c \
diff --git a/android/Makefile.am b/android/Makefile.am
index f2172a9..01dd8de 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -31,8 +31,10 @@ android_bluetoothd_SOURCES = android/main.c \
 				src/shared/ringbuf.h src/shared/ringbuf.c \
 				src/shared/hfp.h src/shared/hfp.c \
 				src/shared/gatt-db.h src/shared/gatt-db.c \
+				src/shared/uhid.h src/shared/uhid.c \
 				android/bluetooth.h android/bluetooth.c \
 				android/hidhost.h android/hidhost.c \
+				android/hog.h android/hog.c \
 				android/ipc-common.h \
 				android/ipc.h android/ipc.c \
 				android/avdtp.h android/avdtp.c \
diff --git a/android/hog.c b/android/hog.c
index 47a4fb1..bd4f458 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -2,6 +2,7 @@
  *
  *  BlueZ - Bluetooth protocol stack for Linux
  *
+ *  Copyright (C) 2014  Intel Corporation.
  *  Copyright (C) 2012  Marcel Holtmann <marcel@holtmann.org>
  *  Copyright (C) 2012  Nordic Semiconductor Inc.
  *  Copyright (C) 2012  Instituto Nokia de Tecnologia - INdT
@@ -42,21 +43,17 @@
 #include "src/log.h"
 
 #include "lib/uuid.h"
-#include "src/adapter.h"
-#include "src/device.h"
-#include "src/profile.h"
-#include "src/service.h"
 #include "src/shared/util.h"
 #include "src/shared/uhid.h"
 
-#include "src/plugin.h"
-
-#include "suspend.h"
 #include "attrib/att.h"
 #include "attrib/gattrib.h"
-#include "src/attio.h"
 #include "attrib/gatt.h"
 
+#include "btio/btio.h"
+
+#include "android/hog.h"
+
 #define HOG_UUID		"00001812-0000-1000-8000-00805f9b34fb"
 
 #define HOG_INFO_UUID		0x2A4A
@@ -76,12 +73,14 @@
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
@@ -93,20 +92,17 @@ struct hog_device {
 };
 
 struct report {
+	struct bt_hog		*hog;
 	uint8_t			id;
 	uint8_t			type;
 	guint			notifyid;
 	struct gatt_char	*decl;
-	struct hog_device	*hogdev;
 };
 
-static gboolean suspend_supported = FALSE;
-static GSList *devices = NULL;
-
 static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
 {
 	struct report *report = user_data;
-	struct hog_device *hogdev = report->hogdev;
+	struct bt_hog *hog = report->hog;
 	struct uhid_event ev;
 	uint8_t *buf;
 	int err;
@@ -123,7 +119,7 @@ static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
 	ev.type = UHID_INPUT;
 	buf = ev.u.input.data;
 
-	if (hogdev->has_report_id) {
+	if (hog->has_report_id) {
 		buf[0] = report->id;
 		len = MIN(len, sizeof(ev.u.input.data) - 1);
 		memcpy(buf + 1, pdu, len);
@@ -134,7 +130,7 @@ static void report_value_cb(const guint8 *pdu, guint16 len, gpointer user_data)
 		ev.u.input.size = len;
 	}
 
-	err = bt_uhid_send(hogdev->uhid, &ev);
+	err = bt_uhid_send(hog->uhid, &ev);
 	if (err < 0) {
 		error("bt_uhid_send: %s (%d)", strerror(-err), -err);
 		return;
@@ -147,7 +143,7 @@ static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data)
 {
 	struct report *report = user_data;
-	struct hog_device *hogdev = report->hogdev;
+	struct bt_hog *hog = report->hog;
 
 	if (status != 0) {
 		error("Write report characteristic descriptor failed: %s",
@@ -155,7 +151,7 @@ static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
 		return;
 	}
 
-	report->notifyid = g_attrib_register(hogdev->attrib,
+	report->notifyid = g_attrib_register(hog->attrib,
 					ATT_OP_HANDLE_NOTIFY,
 					report->decl->value_handle,
 					report_value_cb, report, NULL);
@@ -166,10 +162,10 @@ static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
 static void write_ccc(uint16_t handle, gpointer user_data)
 {
 	struct report *report = user_data;
-	struct hog_device *hogdev = report->hogdev;
+	struct bt_hog *hog = report->hog;
 	uint8_t value[] = { 0x01, 0x00 };
 
-	gatt_write_char(hogdev->attrib, handle, value, sizeof(value),
+	gatt_write_char(hog->attrib, handle, value, sizeof(value),
 					report_ccc_written_cb, report);
 }
 
@@ -202,7 +198,7 @@ static void discover_descriptor_cb(uint8_t status, GSList *descs,
 								void *user_data)
 {
 	struct report *report;
-	struct hog_device *hogdev;
+	struct bt_hog *hog;
 	GAttrib *attrib = NULL;
 
 	if (status != 0) {
@@ -217,20 +213,20 @@ static void discover_descriptor_cb(uint8_t status, GSList *descs,
 		switch (desc->uuid16) {
 		case GATT_CLIENT_CHARAC_CFG_UUID:
 			report = user_data;
-			attrib = report->hogdev->attrib;
+			attrib = report->hog->attrib;
 			write_ccc(desc->handle, report);
 			break;
 		case GATT_REPORT_REFERENCE:
 			report = user_data;
-			attrib = report->hogdev->attrib;
+			attrib = report->hog->attrib;
 			gatt_read_char(attrib, desc->handle,
 						report_reference_cb, report);
 			break;
 		case GATT_EXTERNAL_REPORT_REFERENCE:
-			hogdev = user_data;
-			attrib = hogdev->attrib;
+			hog = user_data;
+			attrib = hog->attrib;
 			gatt_read_char(attrib, desc->handle,
-					external_report_reference_cb, hogdev);
+					external_report_reference_cb, hog);
 			break;
 		}
 	}
@@ -249,8 +245,8 @@ static void discover_descriptor(GAttrib *attrib, uint16_t start, uint16_t end,
 static void external_service_char_cb(uint8_t status, GSList *chars,
 								void *user_data)
 {
-	struct hog_device *hogdev = user_data;
-	struct gatt_primary *prim = hogdev->hog_primary;
+	struct bt_hog *hog = user_data;
+	struct gatt_primary *primary = hog->primary;
 	struct report *report;
 	GSList *l;
 
@@ -271,19 +267,19 @@ static void external_service_char_cb(uint8_t status, GSList *chars,
 				chr->handle, chr->uuid, chr->properties);
 
 		report = g_new0(struct report, 1);
-		report->hogdev = hogdev;
+		report->hog = hog;
 		report->decl = g_memdup(chr, sizeof(*chr));
-		hogdev->reports = g_slist_append(hogdev->reports, report);
+		hog->reports = g_slist_append(hog->reports, report);
 		start = chr->value_handle + 1;
-		end = (next ? next->handle - 1 : prim->range.end);
-		discover_descriptor(hogdev->attrib, start, end, report);
+		end = (next ? next->handle - 1 : primary->range.end);
+		discover_descriptor(hog->attrib, start, end, report);
 	}
 }
 
 static void external_report_reference_cb(guint8 status, const guint8 *pdu,
 					guint16 plen, gpointer user_data)
 {
-	struct hog_device *hogdev = user_data;
+	struct bt_hog *hog = user_data;
 	uint16_t uuid16;
 	bt_uuid_t uuid;
 
@@ -302,8 +298,8 @@ static void external_report_reference_cb(guint8 status, const guint8 *pdu,
 	DBG("External report reference read, external report characteristic "
 						"UUID: 0x%04x", uuid16);
 	bt_uuid16_create(&uuid, uuid16);
-	gatt_discover_char(hogdev->attrib, 0x00, 0xff, &uuid,
-					external_service_char_cb, hogdev);
+	gatt_discover_char(hog->attrib, 0x00, 0xff, &uuid,
+					external_service_char_cb, hog);
 }
 
 static int report_type_cmp(gconstpointer a, gconstpointer b)
@@ -325,14 +321,14 @@ static void output_written_cb(guint8 status, const guint8 *pdu,
 
 static void forward_report(struct uhid_event *ev, void *user_data)
 {
-	struct hog_device *hogdev = user_data;
+	struct bt_hog *hog = user_data;
 	struct report *report;
 	GSList *l;
 	void *data;
 	int size;
 	guint type;
 
-	if (hogdev->has_report_id) {
+	if (hog->has_report_id) {
 		data = ev->u.output.data + 1;
 		size = ev->u.output.size - 1;
 	} else {
@@ -351,24 +347,24 @@ static void forward_report(struct uhid_event *ev, void *user_data)
 		return;
 	}
 
-	l = g_slist_find_custom(hogdev->reports, GUINT_TO_POINTER(type),
+	l = g_slist_find_custom(hog->reports, GUINT_TO_POINTER(type),
 							report_type_cmp);
 	if (!l)
 		return;
 
 	report = l->data;
 
-	DBG("Sending report type %d to device 0x%04X handle 0x%X", type,
-				hogdev->id, report->decl->value_handle);
+	DBG("Sending report type %d to handle 0x%X", type,
+						report->decl->value_handle);
 
-	if (hogdev->attrib == NULL)
+	if (hog->attrib == NULL)
 		return;
 
 	if (report->decl->properties & GATT_CHR_PROP_WRITE)
-		gatt_write_char(hogdev->attrib, report->decl->value_handle,
-				data, size, output_written_cb, hogdev);
+		gatt_write_char(hog->attrib, report->decl->value_handle,
+				data, size, output_written_cb, hog);
 	else if (report->decl->properties & GATT_CHR_PROP_WRITE_WITHOUT_RESP)
-		gatt_write_cmd(hogdev->attrib, report->decl->value_handle,
+		gatt_write_cmd(hog->attrib, report->decl->value_handle,
 						data, size, NULL, NULL);
 }
 
@@ -437,14 +433,13 @@ static char *item2string(char *str, uint8_t *buf, uint8_t len)
 static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
-	struct hog_device *hogdev = user_data;
-	struct btd_adapter *adapter = device_get_adapter(hogdev->device);
+	struct bt_hog *hog = user_data;
 	uint8_t value[HOG_REPORT_MAP_MAX_SIZE];
 	struct uhid_event ev;
-	uint16_t vendor_src, vendor, product, version;
 	ssize_t vlen;
 	char itemstr[20]; /* 5x3 (data) + 4 (continuation) + 1 (null) */
 	int i, err;
+	GError *gerr = NULL;
 
 	if (status != 0) {
 		error("Report Map read failed: %s", att_ecode2str(status));
@@ -466,7 +461,7 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 								&long_item)) {
 			/* Report ID is short item with prefix 100001xx */
 			if (!long_item && (value[i] & 0xfc) == 0x84)
-				hogdev->has_report_id = TRUE;
+				hog->has_report_id = TRUE;
 
 			DBG("\t%s", item2string(itemstr, &value[i], ilen));
 
@@ -480,45 +475,43 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
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
-	bt_uhid_register(hogdev->uhid, UHID_FEATURE, forward_report, hogdev);
+	bt_uhid_register(hog->uhid, UHID_OUTPUT, forward_report, hog);
+	bt_uhid_register(hog->uhid, UHID_FEATURE, forward_report, hog);
 }
 
 static void info_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
-	struct hog_device *hogdev = user_data;
+	struct bt_hog *hog = user_data;
 	uint8_t value[HID_INFO_SIZE];
 	ssize_t vlen;
 
@@ -534,18 +527,18 @@ static void info_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
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
+	struct bt_hog *hog = user_data;
 	uint8_t value;
 	ssize_t vlen;
 
@@ -564,20 +557,18 @@ static void proto_mode_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
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
+	struct bt_hog *hog = user_data;
+	struct gatt_primary *primary = hog->primary;
 	bt_uuid_t report_uuid, report_map_uuid, info_uuid;
 	bt_uuid_t proto_mode_uuid, ctrlpt_uuid;
 	struct report *report;
@@ -610,287 +601,169 @@ static void char_discovered_cb(uint8_t status, GSList *chars, void *user_data)
 		bt_string_to_uuid(&uuid, chr->uuid);
 
 		start = chr->value_handle + 1;
-		end = (next ? next->handle - 1 : prim->range.end);
+		end = (next ? next->handle - 1 : primary->range.end);
 
 		if (bt_uuid_cmp(&uuid, &report_uuid) == 0) {
 			report = g_new0(struct report, 1);
-			report->hogdev = hogdev;
+			report->hog = hog;
 			report->decl = g_memdup(chr, sizeof(*chr));
-			hogdev->reports = g_slist_append(hogdev->reports,
+			hog->reports = g_slist_append(hog->reports,
 								report);
-			discover_descriptor(hogdev->attrib, start, end, report);
+			discover_descriptor(hog->attrib, start, end, report);
 		} else if (bt_uuid_cmp(&uuid, &report_map_uuid) == 0) {
-			gatt_read_char(hogdev->attrib, chr->value_handle,
-						report_map_read_cb, hogdev);
-			discover_descriptor(hogdev->attrib, start, end, hogdev);
+			gatt_read_char(hog->attrib, chr->value_handle,
+						report_map_read_cb, hog);
+			discover_descriptor(hog->attrib, start, end, hog);
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
+		gatt_read_char(hog->attrib, proto_mode_handle,
+						proto_mode_read_cb, hog);
 	}
 
 	if (info_handle)
-		gatt_read_char(hogdev->attrib, info_handle, info_read_cb,
-									hogdev);
-}
-
-static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
-{
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
-
-	for (l = hogdev->reports; l; l = l->next) {
-		struct report *r = l->data;
-
-		r->notifyid = g_attrib_register(hogdev->attrib,
-					ATT_OP_HANDLE_NOTIFY,
-					r->decl->value_handle,
-					report_value_cb, r, NULL);
-	}
-}
-
-static void attio_disconnected_cb(gpointer user_data)
-{
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
-}
-
-static struct hog_device *hog_new_device(struct btd_device *device,
-								uint16_t id)
-{
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
+		gatt_read_char(hog->attrib, info_handle, info_read_cb,
+									hog);
 }
 
 static void report_free(void *data)
 {
 	struct report *report = data;
-	struct hog_device *hogdev = report->hogdev;
+	struct bt_hog *hog = report->hog;
 
-	if (hogdev->attrib)
-		g_attrib_unregister(hogdev->attrib, report->notifyid);
+	if (hog->attrib)
+		g_attrib_unregister(hog->attrib, report->notifyid);
 
 	g_free(report->decl);
 	g_free(report);
 }
 
-static void hog_free_device(struct hog_device *hogdev)
+static void hog_free(struct bt_hog *hog)
 {
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
-
-	hogdev = hog_new_device(device, prim->range.start);
-	if (!hogdev)
-		return NULL;
+	struct uhid_event ev;
 
-	hogdev->uhid = bt_uhid_new_default();
-	if (!hogdev->uhid) {
-		error("bt_uhid_new_default: failed");
-		hog_free_device(hogdev);
-		return NULL;
+	if (hog->uhid) {
+		memset(&ev, 0, sizeof(ev));
+		ev.type = UHID_DESTROY;
+		bt_uhid_send(hog->uhid, &ev);
+		bt_uhid_unref(hog->uhid);
 	}
 
-	hogdev->hog_primary = g_memdup(prim, sizeof(*prim));
-
-	hogdev->attioid = btd_device_add_attio_callback(device,
-							attio_connected_cb,
-							attio_disconnected_cb,
-							hogdev);
-
-	return hogdev;
+	g_slist_free_full(hog->reports, report_free);
+	g_attrib_unref(hog->attrib);
+	g_free(hog->name);
+	g_free(hog->primary);
+	g_free(hog);
 }
 
-static int hog_unregister_device(struct hog_device *hogdev)
-{
-	struct uhid_event ev;
-	int err;
-
-	btd_device_remove_attio_callback(hogdev->device, hogdev->attioid);
-
-	memset(&ev, 0, sizeof(ev));
-	ev.type = UHID_DESTROY;
-	err = bt_uhid_send(hogdev->uhid, &ev);
-	if (err < 0)
-		error("bt_uhid_send: %s (%d)", strerror(-err), -err);
-
-	bt_uhid_unref(hogdev->uhid);
-	hog_free_device(hogdev);
-
-	return 0;
-}
+struct bt_hog *bt_hog_new(const char *name, uint16_t vendor, uint16_t product,
+			uint16_t version, const struct gatt_primary *primary)
 
-static int set_control_point(struct hog_device *hogdev, gboolean suspend)
 {
-	uint8_t value = suspend ? 0x00 : 0x01;
+	struct bt_hog *hog;
 
-	if (hogdev->attrib == NULL)
-		return -ENOTCONN;
-
-	DBG("0x%4X HID Control Point: %s", hogdev->id, suspend ?
-						"Suspend" : "Exit Suspend");
-
-	if (hogdev->ctrlpt_handle == 0)
-		return -ENOTSUP;
+	hog = g_try_new0(struct bt_hog, 1);
+	if (!hog)
+		return NULL;
 
-	gatt_write_cmd(hogdev->attrib, hogdev->ctrlpt_handle, &value,
-					sizeof(value), NULL, NULL);
+	hog->uhid = bt_uhid_new_default();
+	if (!hog->uhid) {
+		hog_free(hog);
+		return NULL;
+	}
 
-	return 0;
-}
+	hog->name = g_strdup(name);
+	hog->vendor = vendor;
+	hog->product = product;
+	hog->version = version;
+	hog->primary = g_memdup(primary, sizeof(*primary));
 
-static void set_suspend(gpointer data, gpointer user_data)
-{
-	struct hog_device *hogdev = data;
-	gboolean suspend = GPOINTER_TO_INT(user_data);
-
-	set_control_point(hogdev, suspend);
+	return bt_hog_ref(hog);
 }
 
-static void suspend_callback(void)
+struct bt_hog *bt_hog_ref(struct bt_hog *hog)
 {
-	gboolean suspend = TRUE;
+	if (!hog)
+		return NULL;
 
-	DBG("Suspending ...");
+	__sync_fetch_and_add(&hog->ref_count, 1);
 
-	g_slist_foreach(devices, set_suspend, GINT_TO_POINTER(suspend));
+	return hog;
 }
 
-static void resume_callback(void)
+void bt_hog_unref(struct bt_hog *hog)
 {
-	gboolean suspend = FALSE;
+	if (!hog)
+		return;
 
-	DBG("Resuming ...");
+	if (__sync_sub_and_fetch(&hog->ref_count, 1))
+		return;
 
-	g_slist_foreach(devices, set_suspend, GINT_TO_POINTER(suspend));
+	hog_free(hog);
 }
 
-static int hog_probe(struct btd_service *service)
+bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 {
-	struct btd_device *device = btd_service_get_device(service);
-	const char *path = device_get_path(device);
-	GSList *primaries, *l;
-
-	DBG("path %s", path);
+	struct gatt_primary *primary = hog->primary;
+	GSList *l;
 
-	primaries = btd_device_get_primaries(device);
-	if (primaries == NULL)
-		return -EINVAL;
+	if (hog->attrib)
+		return false;
 
-	for (l = primaries; l; l = g_slist_next(l)) {
-		struct gatt_primary *prim = l->data;
-		struct hog_device *hogdev;
+	hog->attrib = g_attrib_ref(gatt);
 
-		if (strcmp(prim->uuid, HOG_UUID) != 0)
-			continue;
+	if (hog->reports == NULL) {
+		gatt_discover_char(hog->attrib, primary->range.start,
+						primary->range.end, NULL,
+						char_discovered_cb, hog);
+		return true;
+	}
 
-		hogdev = hog_register_device(device, prim);
-		if (hogdev == NULL)
-			continue;
+	for (l = hog->reports; l; l = l->next) {
+		struct report *r = l->data;
 
-		devices = g_slist_append(devices, hogdev);
+		r->notifyid = g_attrib_register(hog->attrib,
+					ATT_OP_HANDLE_NOTIFY,
+					r->decl->value_handle,
+					report_value_cb, r, NULL);
 	}
 
-	return 0;
+	return true;
 }
 
-static void remove_device(gpointer a, gpointer b)
+void bt_hog_detach(struct bt_hog *hog)
 {
-	struct hog_device *hogdev = a;
-	struct btd_device *device = b;
-
-	if (hogdev->device != device)
-		return;
-
-	devices = g_slist_remove(devices, hogdev);
-	hog_unregister_device(hogdev);
-}
+	GSList *l;
 
-static void hog_remove(struct btd_service *service)
-{
-	struct btd_device *device = btd_service_get_device(service);
-	const char *path = device_get_path(device);
+	for (l = hog->reports; l; l = l->next) {
+		struct report *r = l->data;
 
-	DBG("path %s", path);
+		g_attrib_unregister(hog->attrib, r->notifyid);
+	}
 
-	g_slist_foreach(devices, remove_device, device);
+	g_attrib_unref(hog->attrib);
+	hog->attrib = NULL;
 }
 
-static struct btd_profile hog_profile = {
-	.name		= "input-hog",
-	.remote_uuid	= HOG_UUID,
-	.device_probe	= hog_probe,
-	.device_remove	= hog_remove,
-};
-
-static int hog_init(void)
+int bt_hog_set_control_point(struct bt_hog *hog, bool suspend)
 {
-	int err;
+	uint8_t value = suspend ? 0x00 : 0x01;
 
-	err = suspend_init(suspend_callback, resume_callback);
-	if (err < 0)
-		error("Loading suspend plugin failed: %s (%d)", strerror(-err),
-									-err);
-	else
-		suspend_supported = TRUE;
+	if (hog->attrib == NULL)
+		return -ENOTCONN;
 
-	return btd_profile_register(&hog_profile);
-}
+	if (hog->ctrlpt_handle == 0)
+		return -ENOTSUP;
 
-static void hog_exit(void)
-{
-	if (suspend_supported)
-		suspend_exit();
+	gatt_write_cmd(hog->attrib, hog->ctrlpt_handle, &value,
+					sizeof(value), NULL, NULL);
 
-	btd_profile_unregister(&hog_profile);
+	return 0;
 }
-
-BLUETOOTH_PLUGIN_DEFINE(hog, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
-							hog_init, hog_exit)
diff --git a/android/hog.h b/android/hog.h
new file mode 100644
index 0000000..fb95b2a
--- /dev/null
+++ b/android/hog.h
@@ -0,0 +1,35 @@
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
+			uint16_t version, const struct gatt_primary *primary);
+
+struct bt_hog *bt_hog_ref(struct bt_hog *hog);
+void bt_hog_unref(struct bt_hog *hog);
+
+bool bt_hog_attach(struct bt_hog *hog, void *gatt);
+void bt_hog_detach(struct bt_hog *hog);
+
+int bt_hog_set_control_point(struct bt_hog *hog, bool suspend);
-- 
1.9.0

