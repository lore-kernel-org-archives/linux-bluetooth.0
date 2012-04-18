Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [RFC v2 09/16] HoG: HID I/O driver
Date: Wed, 18 Apr 2012 19:08:17 -0300
Message-Id: <1334786904-26282-10-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1334786904-26282-1-git-send-email-jprvita@openbossa.org>
References: <1334786904-26282-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

UHID is HID I/O driver that makes possible to implement HID I/O drivers in
user-space. It works similar to the uinput but it is initialized with a HID
descriptor and deals with raw HID reports.

This commit uses UHID to create a HID device for the remote HoG device and
to tranfers HID reports to HID subsystem.
---
 acinclude.m4       |    9 +++++++-
 configure.ac       |    2 +
 input/hog_device.c |   55 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 input/main.c       |    2 +
 input/manager.c    |    2 +
 5 files changed, 69 insertions(+), 1 deletions(-)

diff --git a/acinclude.m4 b/acinclude.m4
index 8656379..5069878 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -168,6 +168,13 @@ AC_DEFUN([AC_PATH_OUI], [
 	AC_DEFINE_UNQUOTED(OUIFILE, ["$ac_with_ouifile"], [Define the OUI file path])
 ])
 
+AC_DEFUN([AC_PATH_UHID], [
+	AC_CHECK_HEADERS(linux/uhid.h,
+		uhid_found=yes,
+		uhid_found=no
+	)
+])
+
 AC_DEFUN([AC_ARG_BLUEZ], [
 	debug_enable=no
 	optimization_enable=yes
@@ -392,5 +399,5 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(DBUSOOBPLUGIN, test "${dbusoob_enable}" = "yes")
 	AM_CONDITIONAL(WIIMOTEPLUGIN, test "${wiimote_enable}" = "yes")
 	AM_CONDITIONAL(GATTMODULES, test "${gatt_enable}" = "yes")
-	AM_CONDITIONAL(HOGPLUGIN, test "${gatt_enable}" = "yes" && test "${input_enable}" = "yes")
+	AM_CONDITIONAL(HOGPLUGIN, test "${gatt_enable}" = "yes" && test "${input_enable}" = "yes" && test "${uhid_found}" = "yes")
 ])
diff --git a/configure.ac b/configure.ac
index f298909..689f189 100644
--- a/configure.ac
+++ b/configure.ac
@@ -39,6 +39,7 @@ AC_CHECK_HEADER([sys/inotify.h],
 		[AC_DEFINE([HAVE_SYS_INOTIFY_H], 1,
 			[Define to 1 if you have <sys/inotify.h>.])],
 			[AC_MSG_ERROR(inotify headers are required and missing)])
+
 AC_PATH_DBUS
 AC_PATH_GLIB
 AC_PATH_ALSA
@@ -49,6 +50,7 @@ AC_PATH_SNDFILE
 AC_PATH_OUI
 AC_PATH_READLINE
 AC_PATH_CHECK
+AC_PATH_UHID
 
 AC_ARG_BLUEZ
 
diff --git a/input/hog_device.c b/input/hog_device.c
index 5df6879..9066191 100644
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
@@ -49,6 +53,11 @@
 
 #define HOG_REPORT_MAP_UUID	0x2A4B
 #define HOG_REPORT_UUID		0x2A4D
+#define UHID_DEVICE_FILE	"/dev/uhid"
+
+#ifndef MIN
+#define MIN(x, y) ((x) < (y) ? (x) : (y))
+#endif
 
 struct report {
 	struct gatt_char *decl;
@@ -61,6 +70,7 @@ struct hog_device {
 	guint			attioid;
 	struct gatt_primary	*hog_primary;
 	GSList			*reports;
+	int			uhid_fd;
 };
 
 static GSList *devices = NULL;
@@ -73,7 +83,10 @@ static void report_free(struct report *report)
 
 static void report_value_cb(const uint8_t *pdu, uint16_t len, gpointer user_data)
 {
+	struct hog_device *hogdev = user_data;
+	struct uhid_event ev;
 	uint16_t handle;
+	uint16_t report_size = len - 3;
 
 	if (len < 3) {
 		error("Malformed ATT notification");
@@ -85,6 +98,14 @@ static void report_value_cb(const uint8_t *pdu, uint16_t len, gpointer user_data
 	DBG("Report(0x%04x): 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x 0x%02x "
 				"0x%02x", handle, pdu[2], pdu[3], pdu[4],
 				pdu[5], pdu[6], pdu[7], pdu[8], pdu[9]);
+
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_INPUT;
+	ev.u.input.size = MIN(report_size, UHID_DATA_MAX);
+	memcpy(ev.u.input.data, &pdu[3], MIN(report_size, UHID_DATA_MAX));
+
+	if (write(hogdev->uhid_fd, &ev, sizeof(ev)) < 0)
+		error("UHID write failed: %s", strerror(errno));
 }
 
 static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
@@ -168,6 +189,8 @@ static void discover_descriptor(GAttrib *attrib, struct gatt_char *chr,
 static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
+	struct hog_device *hogdev = user_data;
+	struct uhid_event ev;
 	uint8_t value[ATT_MAX_MTU];
 	int vlen, i;
 
@@ -188,6 +211,22 @@ static void report_map_read_cb(guint8 status, const guint8 *pdu, guint16 plen,
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
@@ -239,11 +278,27 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 
 	gatt_discover_char(hogdev->attrib, prim->range.start, prim->range.end,
 					NULL, char_discovered_cb, hogdev);
+
+	if (hogdev->uhid_fd > 0)
+		return;
+
+	hogdev->uhid_fd = open(UHID_DEVICE_FILE, O_RDWR | O_CLOEXEC);
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
diff --git a/input/main.c b/input/main.c
index 2aac3db..cea83d8 100644
--- a/input/main.c
+++ b/input/main.c
@@ -85,6 +85,7 @@ static void input_exit(void)
 BLUETOOTH_PLUGIN_DEFINE(input, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
 							input_init, input_exit)
 
+#ifdef HAVE_LINUX_UHID_H
 static int hog_init(void)
 {
 	return hog_manager_init();
@@ -97,3 +98,4 @@ static void hog_exit(void)
 
 BLUETOOTH_PLUGIN_DEFINE(hog, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
 							hog_init, hog_exit)
+#endif
diff --git a/input/manager.c b/input/manager.c
index 3707e88..8692712 100644
--- a/input/manager.c
+++ b/input/manager.c
@@ -196,6 +196,7 @@ void input_manager_exit(void)
 	connection = NULL;
 }
 
+#ifdef HAVE_LINUX_UHID_H
 static int hog_device_probe(struct btd_device *device, GSList *uuids)
 {
 	const char *path = device_get_path(device);
@@ -230,3 +231,4 @@ void hog_manager_exit(void)
 {
 	btd_unregister_device_driver(&hog_driver);
 }
+#endif
-- 
1.7.7.6

