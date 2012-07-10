Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ] hog: HID I/O driver
Date: Tue, 10 Jul 2012 18:24:46 -0300
Message-Id: <1341955486-11189-1-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1341947825-14789-2-git-send-email-jprvita@openbossa.org>
References: <1341947825-14789-2-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

uHID is HID I/O driver that makes possible to implement HID I/O drivers in
user-space. It works similar to the uinput but it is initialized with a HID
descriptor and deals with raw HID reports.

This commit uses uHID to create a HID device for the remote HoG device and
to tranfers HID reports to HID subsystem.
---
 profiles/input/hog_device.c |   89 ++++++++++++++++++++++++++++--------
 profiles/input/uhid-copy.h  |  104 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 174 insertions(+), 19 deletions(-)
 create mode 100644 profiles/input/uhid-copy.h

diff --git a/profiles/input/hog_device.c b/profiles/input/hog_device.c
index 8e5e758..b0fa9da 100644
--- a/profiles/input/hog_device.c
+++ b/profiles/input/hog_device.c
@@ -29,6 +29,10 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <unistd.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include "uhid-copy.h"
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/uuid.h>
@@ -49,6 +53,7 @@
 
 #define HOG_REPORT_MAP_UUID	0x2A4B
 #define HOG_REPORT_UUID		0x2A4D
+#define UHID_DEVICE_FILE	"/dev/uhid"
 
 #define HOG_REPORT_MAP_MAX_SIZE        512
 
@@ -64,21 +69,32 @@ struct hog_device {
 	guint			report_cb_id;
 	struct gatt_primary	*hog_primary;
 	GSList			*reports;
+	int			uhid_fd;
 };
 
 static GSList *devices = NULL;
 
 static void report_value_cb(const uint8_t *pdu, uint16_t len, gpointer user_data)
 {
-	uint16_t handle;
+	struct hog_device *hogdev = user_data;
+	struct uhid_event ev;
+	uint16_t report_size = len - 3;
 
 	if (len < 3) { /* 1-byte opcode + 2-byte handle */
 		error("Malformed ATT notification");
 		return;
 	}
 
-	handle = att_get_u16(&pdu[1]);
-	DBG("Report notification on handle 0x%04x", handle);
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_INPUT;
+	ev.u.input.size = MIN(report_size, UHID_DATA_MAX);
+	memcpy(ev.u.input.data, &pdu[3], MIN(report_size, UHID_DATA_MAX));
+
+	if (write(hogdev->uhid_fd, &ev, sizeof(ev)) < 0)
+		error("uHID write failed: %s", strerror(errno));
+	else
+		DBG("Report from HoG device %s written to uHID fd %d",
+						hogdev->path, hogdev->uhid_fd);
 }
 
 static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
@@ -157,7 +173,9 @@ static void discover_descriptor(GAttrib *attrib, struct gatt_char *chr,
 static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
+	struct hog_device *hogdev = user_data;
 	uint8_t value[HOG_REPORT_MAP_MAX_SIZE];
+	struct uhid_event ev;
 	ssize_t vlen;
 	int i;
 
@@ -179,6 +197,22 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		else
 			DBG("\t %02x %02x", value[i], value[i + 1]);
 	}
+
+	/* create uHID device */
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_CREATE;
+	/* TODO: get info from DIS */
+	strcpy((char *)ev.u.create.name, "bluez-hog-device");
+	ev.u.create.vendor = 0xBEBA;
+	ev.u.create.product = 0xCAFE;
+	ev.u.create.version = 0;
+	ev.u.create.country = 0;
+	ev.u.create.bus = BUS_BLUETOOTH;
+	ev.u.create.rd_data = value;
+	ev.u.create.rd_size = vlen;
+
+	if (write(hogdev->uhid_fd, &ev, sizeof(ev)) < 0)
+		error("Failed to create uHID device: %s", strerror(errno));
 }
 
 static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
@@ -239,6 +273,12 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 static void attio_disconnected_cb(gpointer user_data)
 {
 	struct hog_device *hogdev = user_data;
+	struct uhid_event ev;
+
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_DESTROY;
+	if (write(hogdev->uhid_fd, &ev, sizeof(ev)) < 0)
+		error("Failed to destroy uHID device: %s", strerror(errno));
 
 	g_attrib_unregister(hogdev->attrib, hogdev->report_cb_id);
 	hogdev->report_cb_id = 0;
@@ -293,6 +333,22 @@ static struct gatt_primary *load_hog_primary(struct btd_device *device)
 	return (l ? l->data : NULL);
 }
 
+static void report_free(void *data)
+{
+	struct report *report = data;
+	g_free(report->decl);
+	g_free(report);
+}
+
+static void hog_device_free(struct hog_device *hogdev)
+{
+	btd_device_unref(hogdev->device);
+	g_slist_free_full(hogdev->reports, report_free);
+	g_free(hogdev->path);
+	g_free(hogdev->hog_primary);
+	g_free(hogdev);
+}
+
 int hog_device_register(struct btd_device *device, const char *path)
 {
 	struct hog_device *hogdev;
@@ -310,6 +366,13 @@ int hog_device_register(struct btd_device *device, const char *path)
 	if (!hogdev)
 		return -ENOMEM;
 
+	hogdev->uhid_fd = open(UHID_DEVICE_FILE, O_RDWR | O_CLOEXEC);
+	if (hogdev->uhid_fd < 0) {
+		error("Failed to open uHID device: %s", strerror(errno));
+		hog_device_free(hogdev);
+		return -errno;
+	}
+
 	hogdev->hog_primary = g_memdup(prim, sizeof(*prim));
 
 	hogdev->attioid = btd_device_add_attio_callback(device,
@@ -323,22 +386,6 @@ int hog_device_register(struct btd_device *device, const char *path)
 	return 0;
 }
 
-static void report_free(void *data)
-{
-	struct report *report = data;
-	g_free(report->decl);
-	g_free(report);
-}
-
-static void hog_device_free(struct hog_device *hogdev)
-{
-	btd_device_unref(hogdev->device);
-	g_slist_free_full(hogdev->reports, report_free);
-	g_free(hogdev->path);
-	g_free(hogdev->hog_primary);
-	g_free(hogdev);
-}
-
 int hog_device_unregister(const char *path)
 {
 	struct hog_device *hogdev;
@@ -348,6 +395,10 @@ int hog_device_unregister(const char *path)
 		return -EINVAL;
 
 	btd_device_remove_attio_callback(hogdev->device, hogdev->attioid);
+
+	close(hogdev->uhid_fd);
+	hogdev->uhid_fd = -1;
+
 	devices = g_slist_remove(devices, hogdev);
 	hog_device_free(hogdev);
 
diff --git a/profiles/input/uhid-copy.h b/profiles/input/uhid-copy.h
new file mode 100644
index 0000000..381b062
--- /dev/null
+++ b/profiles/input/uhid-copy.h
@@ -0,0 +1,104 @@
+#ifndef __UHID_H_
+#define __UHID_H_
+
+/*
+ * User-space I/O driver support for HID subsystem
+ * Copyright (c) 2012 David Herrmann
+ */
+
+/*
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+/*
+ * Public header for user-space communication. We try to keep every structure
+ * aligned but to be safe we also use __attribute__((__packed__)). Therefore,
+ * the communication should be ABI compatible even between architectures.
+ */
+
+#include <linux/input.h>
+#include <linux/types.h>
+
+enum uhid_event_type {
+	UHID_CREATE,
+	UHID_DESTROY,
+	UHID_START,
+	UHID_STOP,
+	UHID_OPEN,
+	UHID_CLOSE,
+	UHID_OUTPUT,
+	UHID_OUTPUT_EV,
+	UHID_INPUT,
+	UHID_FEATURE,
+	UHID_FEATURE_ANSWER,
+};
+
+struct uhid_create_req {
+	__u8 name[128];
+	__u8 phys[64];
+	__u8 uniq[64];
+	__u8 *rd_data;
+	__u16 rd_size;
+
+	__u16 bus;
+	__u32 vendor;
+	__u32 product;
+	__u32 version;
+	__u32 country;
+} __attribute__((__packed__));
+
+#define UHID_DATA_MAX 4096
+
+enum uhid_report_type {
+	UHID_FEATURE_REPORT,
+	UHID_OUTPUT_REPORT,
+	UHID_INPUT_REPORT,
+};
+
+struct uhid_input_req {
+	__u8 data[UHID_DATA_MAX];
+	__u16 size;
+} __attribute__((__packed__));
+
+struct uhid_output_req {
+	__u8 data[UHID_DATA_MAX];
+	__u16 size;
+	__u8 rtype;
+} __attribute__((__packed__));
+
+struct uhid_output_ev_req {
+	__u16 type;
+	__u16 code;
+	__s32 value;
+} __attribute__((__packed__));
+
+struct uhid_feature_req {
+	__u32 id;
+	__u8 rnum;
+	__u8 rtype;
+} __attribute__((__packed__));
+
+struct uhid_feature_answer_req {
+	__u32 id;
+	__u16 err;
+	__u16 size;
+	__u8 data[UHID_DATA_MAX];
+};
+
+struct uhid_event {
+	__u32 type;
+
+	union {
+		struct uhid_create_req create;
+		struct uhid_input_req input;
+		struct uhid_output_req output;
+		struct uhid_output_ev_req output_ev;
+		struct uhid_feature_req feature;
+		struct uhid_feature_answer_req feature_answer;
+	} u;
+} __attribute__((__packed__));
+
+#endif /* __UHID_H_ */
-- 
1.7.10.4

