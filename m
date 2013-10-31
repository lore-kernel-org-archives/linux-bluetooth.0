Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] android/hid: Initial implementation for uHID
Date: Thu, 31 Oct 2013 17:57:06 +0200
Message-Id: <1383235026-12247-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1383235026-12247-1-git-send-email-luiz.dentz@gmail.com>
References: <1383235026-12247-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>

This patch reads data on interrupt channel and feeds into uHID.
Kernel will take care rest of the things and connects bt mouse
and keyboard:

[168988.557647] input: bluez-input-device as /devices/virtual/misc/uhid/input54
---
 android/hid.c | 129 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 125 insertions(+), 4 deletions(-)

diff --git a/android/hid.c b/android/hid.c
index 6b3b1f7..68dcec7 100644
--- a/android/hid.c
+++ b/android/hid.c
@@ -37,6 +37,7 @@
 #include "src/shared/mgmt.h"
 #include "src/sdp-client.h"
 #include "src/glib-helper.h"
+#include "profiles/input/uhid_copy.h"
 
 #include "log.h"
 #include "hal-msg.h"
@@ -47,7 +48,7 @@
 
 #define L2CAP_PSM_HIDP_CTRL	0x11
 #define L2CAP_PSM_HIDP_INTR	0x13
-#define MAX_READ_BUFFER		4096
+#define UHID_DEVICE_FILE	"/dev/uhid"
 
 static GIOChannel *notification_io = NULL;
 static GIOChannel *ctrl_io = NULL;
@@ -67,6 +68,8 @@ struct hid_device {
 	GIOChannel	*intr_io;
 	guint		ctrl_watch;
 	guint		intr_watch;
+	int		uhid_fd;
+	guint		uhid_watch_id;
 };
 
 static int device_cmp(gconstpointer s, gconstpointer user_data)
@@ -77,6 +80,21 @@ static int device_cmp(gconstpointer s, gconstpointer user_data)
 	return bacmp(&hdev->dst, dst);
 }
 
+static void uhid_destroy(int fd)
+{
+	struct uhid_event ev;
+
+	/* destroy uHID device */
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_DESTROY;
+
+	if (write(fd, &ev, sizeof(ev)) < 0)
+		error("Failed to destroy uHID device: %s (%d)",
+						strerror(errno), errno);
+
+	close(fd);
+}
+
 static void hid_device_free(struct hid_device *hdev)
 {
 	if (hdev->ctrl_watch > 0)
@@ -91,17 +109,63 @@ static void hid_device_free(struct hid_device *hdev)
 	if (hdev->ctrl_io)
 		g_io_channel_unref(hdev->ctrl_io);
 
+	if (hdev->uhid_watch_id) {
+		g_source_remove(hdev->uhid_watch_id);
+		hdev->uhid_watch_id = 0;
+	}
+
+	if (hdev->uhid_fd > 0)
+		uhid_destroy(hdev->uhid_fd);
+
 	g_free(hdev->rd_data);
 
 	devices = g_slist_remove(devices, hdev);
 	g_free(hdev);
 }
 
+static gboolean uhid_event_cb(GIOChannel *io, GIOCondition cond,
+							gpointer user_data)
+{
+	struct hid_device *hdev = user_data;
+	struct uhid_event ev;
+	ssize_t bread;
+	int fd;
+
+	DBG("");
+
+	if (cond & (G_IO_ERR | G_IO_NVAL))
+		goto failed;
+
+	fd = g_io_channel_unix_get_fd(io);
+	memset(&ev, 0, sizeof(ev));
+
+	bread = read(fd, &ev, sizeof(ev));
+	if (bread < 0) {
+		DBG("read: %s (%d)", strerror(errno), errno);
+		goto failed;
+	}
+
+	DBG("uHID event type %d received", ev.type);
+	/* TODO Handle events */
+
+	return TRUE;
+
+failed:
+	hdev->uhid_watch_id = 0;
+	return FALSE;
+}
+
 static gboolean intr_io_watch_cb(GIOChannel *chan, gpointer data)
 {
-	char buf[MAX_READ_BUFFER];
+	struct hid_device *hdev = data;
+	uint8_t buf[UHID_DATA_MAX];
+	struct uhid_event ev;
 	int fd, bread;
 
+	/* Wait uHID if not ready */
+	if (hdev->uhid_fd < 0)
+		return TRUE;
+
 	fd = g_io_channel_unix_get_fd(chan);
 	bread = read(fd, buf, sizeof(buf));
 	if (bread < 0) {
@@ -109,7 +173,18 @@ static gboolean intr_io_watch_cb(GIOChannel *chan, gpointer data)
 		return TRUE;
 	}
 
-	DBG("bytes read %d", bread);
+	/* Discard non-data packets */
+	if (bread == 0 || buf[0] != 0xA1)
+		return TRUE;
+
+	/* send data to uHID device skipping HIDP header byte */
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_INPUT;
+	ev.u.input.size = bread - 1;
+	memcpy(ev.u.input.data, &buf[1], ev.u.input.size);
+
+	if (write(hdev->uhid_fd, &ev, sizeof(ev)) < 0)
+		DBG("write: %s (%d)", strerror(errno), errno);
 
 	return TRUE;
 }
@@ -185,6 +260,44 @@ static gboolean ctrl_watch_cb(GIOChannel *chan, GIOCondition cond,
 	return FALSE;
 }
 
+static int uhid_create(struct hid_device *hdev)
+{
+	GIOCondition cond = G_IO_IN | G_IO_ERR | G_IO_NVAL;
+	GIOChannel *io;
+	struct uhid_event ev;
+
+	hdev->uhid_fd = open(UHID_DEVICE_FILE, O_RDWR | O_CLOEXEC);
+	if (hdev->uhid_fd < 0) {
+		error("Failed to open uHID device: %s", strerror(errno));
+		return -errno;
+	}
+
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_CREATE;
+	strcpy((char *) ev.u.create.name, "bluez-input-device");
+	ev.u.create.bus = BUS_BLUETOOTH;
+	ev.u.create.vendor = hdev->vendor;
+	ev.u.create.product = hdev->product;
+	ev.u.create.version = hdev->vendor;
+	ev.u.create.country = hdev->country;
+	ev.u.create.rd_size = hdev->rd_size;
+	ev.u.create.rd_data = hdev->rd_data;
+
+	if (write(hdev->uhid_fd, &ev, sizeof(ev)) < 0) {
+		error("Failed to create uHID device: %s", strerror(errno));
+		close(hdev->uhid_fd);
+		hdev->uhid_fd = -1;
+		return -errno;
+	}
+
+	io = g_io_channel_unix_new(hdev->uhid_fd);
+	g_io_channel_set_encoding(io, NULL, NULL);
+	hdev->uhid_watch_id = g_io_add_watch(io, cond, uhid_event_cb, hdev);
+	g_io_channel_unref(io);
+
+	return 0;
+}
+
 static void interrupt_connect_cb(GIOChannel *chan, GError *conn_err,
 							gpointer user_data)
 {
@@ -195,6 +308,9 @@ static void interrupt_connect_cb(GIOChannel *chan, GError *conn_err,
 	if (conn_err)
 		goto failed;
 
+	if (uhid_create(hdev) < 0)
+		goto failed;
+
 	hdev->intr_watch = g_io_add_watch(hdev->intr_io,
 				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 				intr_watch_cb, hdev);
@@ -321,8 +437,11 @@ static void hid_sdp_search_cb(sdp_list_t *recs, int err, gpointer data)
 		}
 	}
 
-	if (hdev->ctrl_io)
+	if (hdev->ctrl_io) {
+		if (uhid_create(hdev) < 0)
+			goto fail;
 		return;
+	}
 
 	hdev->ctrl_io = bt_io_connect(control_connect_cb, hdev, NULL, &gerr,
 					BT_IO_OPT_SOURCE_BDADDR, src,
@@ -365,6 +484,7 @@ static uint8_t bt_hid_connect(struct hal_cmd_hid_connect *cmd, uint16_t len)
 
 	hdev = g_new0(struct hid_device, 1);
 	bacpy(&hdev->dst, &dst);
+	hdev->uhid_fd = -1;
 
 	ba2str(&hdev->dst, addr);
 	DBG("connecting to %s", addr);
@@ -472,6 +592,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 		hdev = g_new0(struct hid_device, 1);
 		bacpy(&hdev->dst, &dst);
 		hdev->ctrl_io = g_io_channel_ref(chan);
+		hdev->uhid_fd = -1;
 
 		bt_string2uuid(&uuid, HID_UUID);
 		if (bt_search_service(src, &hdev->dst, &uuid,
-- 
1.8.3.1

