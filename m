Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] android/hidhost: Rework uHID code to use bt_uhid
Date: Wed, 28 May 2014 14:27:54 +0300
Message-Id: <1401276475-20978-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/Android.mk  |   1 +
 android/Makefile.am |   1 +
 android/hidhost.c   | 143 ++++++++--------------------------------------------
 3 files changed, 23 insertions(+), 122 deletions(-)

diff --git a/android/Android.mk b/android/Android.mk
index afd6e9c..de909d6 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -54,6 +54,7 @@ LOCAL_SRC_FILES := \
 	bluez/src/shared/gatt-db.c \
 	bluez/src/shared/io-glib.c \
 	bluez/src/shared/crypto.c \
+	bluez/src/shared/uhid.c \
 	bluez/src/sdpd-database.c \
 	bluez/src/sdpd-service.c \
 	bluez/src/sdpd-request.c \
diff --git a/android/Makefile.am b/android/Makefile.am
index 2d74505..bcaec4c 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -32,6 +32,7 @@ android_bluetoothd_SOURCES = android/main.c \
 				src/shared/hfp.h src/shared/hfp.c \
 				src/shared/gatt-db.h src/shared/gatt-db.c \
 				src/shared/crypto.h src/shared/crypto.c \
+				src/shared/uhid.h src/shared/uhid.c \
 				android/bluetooth.h android/bluetooth.c \
 				android/hidhost.h android/hidhost.c \
 				android/ipc-common.h \
diff --git a/android/hidhost.c b/android/hidhost.c
index 1758020..4a158c6 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -40,9 +40,9 @@
 #include "lib/sdp_lib.h"
 #include "src/shared/mgmt.h"
 #include "src/shared/util.h"
+#include "src/shared/uhid.h"
 #include "src/sdp-client.h"
 #include "src/uuid-helper.h"
-#include "profiles/input/uhid_copy.h"
 #include "src/log.h"
 
 #include "hal-msg.h"
@@ -53,7 +53,6 @@
 
 #define L2CAP_PSM_HIDP_CTRL	0x11
 #define L2CAP_PSM_HIDP_INTR	0x13
-#define UHID_DEVICE_FILE	"/dev/uhid"
 
 /* HID message types */
 #define HID_MSG_CONTROL		0x10
@@ -101,8 +100,7 @@ struct hid_device {
 	GIOChannel	*intr_io;
 	guint		ctrl_watch;
 	guint		intr_watch;
-	int		uhid_fd;
-	guint		uhid_watch_id;
+	struct bt_uhid	*uhid;
 	uint8_t		last_hid_msg;
 };
 
@@ -114,21 +112,6 @@ static int device_cmp(gconstpointer s, gconstpointer user_data)
 	return bacmp(&dev->dst, dst);
 }
 
-static void uhid_destroy(int fd)
-{
-	struct uhid_event ev;
-
-	/* destroy uHID device */
-	memset(&ev, 0, sizeof(ev));
-	ev.type = UHID_DESTROY;
-
-	if (write(fd, &ev, sizeof(ev)) < 0)
-		error("hidhost: Failed to destroy uHID device: %s (%d)",
-						strerror(errno), errno);
-
-	close(fd);
-}
-
 static void hid_device_free(void *data)
 {
 	struct hid_device *dev = data;
@@ -145,13 +128,8 @@ static void hid_device_free(void *data)
 	if (dev->ctrl_io)
 		g_io_channel_unref(dev->ctrl_io);
 
-	if (dev->uhid_watch_id) {
-		g_source_remove(dev->uhid_watch_id);
-		dev->uhid_watch_id = 0;
-	}
-
-	if (dev->uhid_fd > 0)
-		uhid_destroy(dev->uhid_fd);
+	if (dev->uhid)
+		bt_uhid_unref(dev->uhid);
 
 	g_free(dev->rd_data);
 	g_free(dev);
@@ -196,9 +174,10 @@ static bool hex2buf(const uint8_t *hex, uint8_t *buf, int buf_size)
 	return true;
 }
 
-static void handle_uhid_output(struct hid_device *dev,
-						struct uhid_output_req *output)
+static void handle_uhid_output(struct uhid_event *event, void *user_data)
 {
+	struct uhid_output_req *output = &event->u.output;
+	struct hid_device *dev = user_data;
 	int fd, req_size;
 	uint8_t *req;
 
@@ -222,87 +201,15 @@ static void handle_uhid_output(struct hid_device *dev,
 	free(req);
 }
 
-static gboolean uhid_event_cb(GIOChannel *io, GIOCondition cond,
-							gpointer user_data)
-{
-	struct hid_device *dev = user_data;
-	struct uhid_event ev;
-	ssize_t bread;
-	int fd;
-
-	DBG("");
-
-	if (cond & (G_IO_ERR | G_IO_NVAL))
-		goto failed;
-
-	fd = g_io_channel_unix_get_fd(io);
-	memset(&ev, 0, sizeof(ev));
-
-	bread = read(fd, &ev, sizeof(ev));
-	if (bread < 0) {
-		DBG("read: %s (%d)", strerror(errno), errno);
-		goto failed;
-	}
-
-	DBG("uHID event type %d received", ev.type);
-
-	switch (ev.type) {
-	case UHID_START:
-	case UHID_STOP:
-		/*
-		 * These are called to start and stop the underlying hardware.
-		 * We open the channels before creating the device so the
-		 * hardware is always ready. No need to handle these.
-		 * The kernel never destroys a device itself! Only an explicit
-		 * UHID_DESTROY request can remove a device.
-		 */
-		break;
-	case UHID_OPEN:
-	case UHID_CLOSE:
-		/*
-		 * OPEN/CLOSE are sent whenever user-space opens any interface
-		 * provided by the kernel HID device. Whenever the open-count
-		 * is non-zero we must be ready for I/O. As long as it is zero,
-		 * we can decide to drop all I/O and put the device
-		 * asleep This is optional, though.
-		 */
-		break;
-	case UHID_OUTPUT:
-		handle_uhid_output(dev, &ev.u.output);
-		break;
-	case UHID_FEATURE:
-		/* TODO */
-		break;
-	case UHID_OUTPUT_EV:
-		/*
-		 * This is only sent by kernels prior to linux-3.11. It
-		 * requires us to parse HID-descriptors in user-space to
-		 * properly handle it. This is redundant as the kernel
-		 * does it already. That's why newer kernels assemble
-		 * the output-reports and send it to us via UHID_OUTPUT.
-		 */
-		DBG("UHID_OUTPUT_EV unsupported");
-		break;
-	default:
-		warn("unexpected uHID event");
-	}
-
-	return TRUE;
-
-failed:
-	dev->uhid_watch_id = 0;
-	return FALSE;
-}
-
 static gboolean intr_io_watch_cb(GIOChannel *chan, gpointer data)
 {
 	struct hid_device *dev = data;
 	uint8_t buf[UHID_DATA_MAX];
 	struct uhid_event ev;
-	int fd, bread;
+	int fd, bread, err;
 
 	/* Wait uHID if not ready */
-	if (dev->uhid_fd < 0)
+	if (!dev->uhid)
 		return TRUE;
 
 	fd = g_io_channel_unix_get_fd(chan);
@@ -323,8 +230,9 @@ static gboolean intr_io_watch_cb(GIOChannel *chan, gpointer data)
 	ev.u.input.size = bread - 1;
 	memcpy(ev.u.input.data, &buf[1], ev.u.input.size);
 
-	if (write(dev->uhid_fd, &ev, sizeof(ev)) < 0)
-		DBG("uhid write: %s (%d)", strerror(errno), errno);
+	err = bt_uhid_send(dev->uhid, &ev);
+	if (err < 0)
+		DBG("bt_uhid_send: %s (%d)", strerror(-err), -err);
 
 	return TRUE;
 }
@@ -571,16 +479,13 @@ static void bt_hid_set_info(struct hid_device *dev)
 
 static int uhid_create(struct hid_device *dev)
 {
-	GIOCondition cond = G_IO_IN | G_IO_ERR | G_IO_NVAL;
 	struct uhid_event ev;
-	GIOChannel *io;
 	int err;
 
-	dev->uhid_fd = open(UHID_DEVICE_FILE, O_RDWR | O_CLOEXEC);
-	if (dev->uhid_fd < 0) {
+	dev->uhid = bt_uhid_new_default();
+	if (!dev->uhid) {
 		err = -errno;
-		error("hidhost: Failed to open uHID device: %s",
-							strerror(errno));
+		error("hidhost: Failed to create bt_uhid instance");
 		return err;
 	}
 
@@ -595,20 +500,16 @@ static int uhid_create(struct hid_device *dev)
 	ev.u.create.rd_size = dev->rd_size;
 	ev.u.create.rd_data = dev->rd_data;
 
-	if (write(dev->uhid_fd, &ev, sizeof(ev)) < 0) {
-		err = -errno;
+	err = bt_uhid_send(dev->uhid, &ev);
+	if (err < 0) {
 		error("hidhost: Failed to create uHID device: %s",
-							strerror(errno));
-		close(dev->uhid_fd);
-		dev->uhid_fd = -1;
+							strerror(-err));
+		bt_uhid_unref(dev->uhid);
+		dev->uhid = NULL;
 		return err;
 	}
 
-	io = g_io_channel_unix_new(dev->uhid_fd);
-	g_io_channel_set_encoding(io, NULL, NULL);
-	dev->uhid_watch_id = g_io_add_watch(io, cond, uhid_event_cb, dev);
-	g_io_channel_unref(io);
-
+	bt_uhid_register(dev->uhid, UHID_OUTPUT, handle_uhid_output, dev);
 	bt_hid_set_info(dev);
 
 	return 0;
@@ -843,7 +744,6 @@ static void bt_hid_connect(const void *buf, uint16_t len)
 
 	dev = g_new0(struct hid_device, 1);
 	bacpy(&dev->dst, &dst);
-	dev->uhid_fd = -1;
 
 	ba2str(&dev->dst, addr);
 	DBG("connecting to %s", addr);
@@ -1361,7 +1261,6 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		dev = g_new0(struct hid_device, 1);
 		bacpy(&dev->dst, &dst);
 		dev->ctrl_io = g_io_channel_ref(chan);
-		dev->uhid_fd = -1;
 
 		sdp_uuid16_create(&uuid, PNP_INFO_SVCLASS_ID);
 		if (bt_search_service(&adapter_addr, &dev->dst, &uuid,
-- 
1.9.0

