Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: dh.herrmann@googlemail.com, chen.ganir@ti.com,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [RFC 8/8] HoG: HID I/O driver
Date: Tue, 27 Mar 2012 19:31:27 -0300
Message-Id: <1332887487-13601-9-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1332887487-13601-1-git-send-email-jprvita@openbossa.org>
References: <1332887487-13601-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

UHID is HID I/O driver that makes possible to implement HID I/O drivers in
user-space. It works similar to the uinput but it is initialized with a HID
descriptor and deals with raw HID reports.

This commit uses UHID to create a HID device for the remote HoG device and
to tranfers HID reports to HID subsystem.
---
 input/hog_device.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/input/hog_device.c b/input/hog_device.c
index 7a757f4..183da22 100644
--- a/input/hog_device.c
+++ b/input/hog_device.c
@@ -29,6 +29,10 @@
 #include <stdlib.h>
 #include <errno.h>
 #include <unistd.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+#include <linux/uhid.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/uuid.h>
@@ -48,6 +52,7 @@
 #include "gatt.h"
 
 #define HOG_REPORT_UUID		0x2A4D
+#define UHID_DEVICE_FILE	"/dev/uhid"
 
 struct hog_device {
 	char			*path;
@@ -56,13 +61,17 @@ struct hog_device {
 	guint			attioid;
 	struct gatt_primary	*hog_primary;
 	struct gatt_char	*report;
+	int			uhid_fd;
 };
 
 static GSList *devices = NULL;
 
 static void report_value_cb(const uint8_t *pdu, uint16_t len, gpointer user_data)
 {
+	struct hog_device *hogdev = user_data;
+	struct uhid_event ev;
 	uint16_t handle;
+	uint16_t report_size = len - 2;
 
 	if (len < 3) {
 		error("Malformed ATT notification");
@@ -74,6 +83,14 @@ static void report_value_cb(const uint8_t *pdu, uint16_t len, gpointer user_data
 	DBG("Report(0x%04x): 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x "
 				"0x%02x", handle, pdu[2], pdu[3], pdu[4],
 				pdu[5], pdu[6], pdu[7], pdu[8], pdu[9]);
+
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_INPUT;
+	ev.u.input.size = report_size;
+	memcpy(ev.u.input.data, &pdu[2], report_size);
+
+	if (write(hogdev->uhid_fd, &ev, sizeof(ev)) < 0)
+		error("UHID write failed: %s", strerror(errno));
 }
 
 static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
@@ -96,6 +113,8 @@ static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
 static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
+	struct hog_device *hogdev = user_data;
+	struct uhid_event ev;
 	uint8_t value[ATT_MAX_MTU];
 	int vlen, i;
 
@@ -116,6 +135,22 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 		else
 			DBG("\t %02x %02x", value[i], value[i + 1]);
 	}
+
+	/* create UHID device */
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_CREATE;
+	/* TODO: get info from DIS */
+	strcpy((char*)ev.u.create.name, "bluez-hog-device");
+	ev.u.create.vendor = 0xBEBA;
+	ev.u.create.product = 0xCAFE;
+	ev.u.create.version = 0;
+	ev.u.create.country = 0;
+	ev.u.create.bus = BUS_USB; /* BUS_BLUETOOTH doesn't work here */
+	ev.u.create.rd_data = value;
+	ev.u.create.rd_size = vlen;
+
+	if (write(hogdev->uhid_fd, &ev, sizeof(ev)) < 0)
+		error("Failed to create UHID device: %s", strerror(errno));
 }
 
 static void char_discovered_cb(GSList *chars, guint8 status, gpointer user_data)
@@ -162,11 +197,27 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 
 	gatt_discover_char(hogdev->attrib, prim->range.start, prim->range.end,
 					NULL, char_discovered_cb, hogdev);
+
+	if (hogdev->uhid_fd > 0)
+		return;
+
+	hogdev->uhid_fd = open(UHID_DEVICE_FILE, O_RDWR, 0666);
+	if (hogdev->uhid_fd < 0)
+		error("Failed to open UHID device: %s", strerror(errno));
 }
 
 static void attio_disconnected_cb(gpointer user_data)
 {
 	struct hog_device *hogdev = user_data;
+	struct uhid_event ev;
+
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_DESTROY;
+	if (write(hogdev->uhid_fd, &ev, sizeof(ev)) < 0)
+		error("Failed to destroy UHID device: %s", strerror(errno));
+
+	close(hogdev->uhid_fd);
+	hogdev->uhid_fd = -1;
 
 	g_attrib_unref(hogdev->attrib);
 	hogdev->attrib = NULL;
-- 
1.7.7.6

