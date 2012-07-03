Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH 10/21] hog: HID I/O driver
Date: Tue,  3 Jul 2012 15:43:02 -0300
Message-Id: <1341340993-7480-11-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1341340993-7480-1-git-send-email-jprvita@openbossa.org>
References: <1341340993-7480-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

uHID is HID I/O driver that makes possible to implement HID I/O drivers in
user-space. It works similar to the uinput but it is initialized with a HID
descriptor and deals with raw HID reports.

This commit uses uHID to create a HID device for the remote HoG device and
to tranfers HID reports to HID subsystem.
---
 acinclude.m4       |    9 +++++-
 configure.ac       |    2 ++
 input/hog_device.c |   89 +++++++++++++++++++++++++++++++++++++++++-----------
 input/main.c       |    2 ++
 input/manager.c    |    2 ++
 5 files changed, 84 insertions(+), 20 deletions(-)

diff --git a/acinclude.m4 b/acinclude.m4
index 3247036..21f1a9c 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -161,6 +161,13 @@ AC_DEFUN([AC_PATH_OUI], [
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
@@ -384,5 +391,5 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(DBUSOOBPLUGIN, test "${dbusoob_enable}" = "yes")
 	AM_CONDITIONAL(WIIMOTEPLUGIN, test "${wiimote_enable}" = "yes")
 	AM_CONDITIONAL(GATTMODULES, test "${gatt_enable}" = "yes")
-	AM_CONDITIONAL(HOGPLUGIN, test "${gatt_enable}" = "yes" && test "${input_enable}" = "yes")
+	AM_CONDITIONAL(HOGPLUGIN, test "${gatt_enable}" = "yes" && test "${input_enable}" = "yes" && test "${uhid_found}" = "yes")
 ])
diff --git a/configure.ac b/configure.ac
index 7f331ae..150171f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -39,6 +39,7 @@ AC_CHECK_HEADER([sys/inotify.h],
 		[AC_DEFINE([HAVE_SYS_INOTIFY_H], 1,
 			[Define to 1 if you have <sys/inotify.h>.])],
 			[AC_MSG_ERROR(inotify headers are required and missing)])
+
 AC_PATH_DBUS
 AC_PATH_GLIB
 AC_PATH_GSTREAMER
@@ -48,6 +49,7 @@ AC_PATH_SNDFILE
 AC_PATH_OUI
 AC_PATH_READLINE
 AC_PATH_CHECK
+AC_PATH_UHID
 
 AC_ARG_BLUEZ
 
diff --git a/input/hog_device.c b/input/hog_device.c
index 8e5e758..5dd9cf1 100644
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
 
diff --git a/input/main.c b/input/main.c
index 722bc49..d1623ec 100644
--- a/input/main.c
+++ b/input/main.c
@@ -86,6 +86,7 @@ static void input_exit(void)
 BLUETOOTH_PLUGIN_DEFINE(input, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
 							input_init, input_exit)
 
+#ifdef HAVE_LINUX_UHID_H
 static int hog_init(void)
 {
 	if (!main_opts.gatt_enabled) {
@@ -106,3 +107,4 @@ static void hog_exit(void)
 
 BLUETOOTH_PLUGIN_DEFINE(hog, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
 							hog_init, hog_exit)
+#endif
diff --git a/input/manager.c b/input/manager.c
index 01f83ce..28f3f81 100644
--- a/input/manager.c
+++ b/input/manager.c
@@ -197,6 +197,7 @@ void input_manager_exit(void)
 	connection = NULL;
 }
 
+#ifdef HAVE_LINUX_UHID_H
 static int hog_device_probe(struct btd_device *device, GSList *uuids)
 {
 	const char *path = device_get_path(device);
@@ -231,3 +232,4 @@ void hog_manager_exit(void)
 {
 	btd_unregister_device_driver(&hog_driver);
 }
+#endif
-- 
1.7.10.4

