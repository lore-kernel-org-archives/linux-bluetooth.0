Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 1/2] android: Add initial HID connect implementation
Date: Mon, 28 Oct 2013 16:47:31 +0200
Message-Id: <1382971653-11727-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1382971653-11727-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1382971653-11727-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implemented basic HID connect method. Host connects to
bt device at L2CAP level.
---
 Makefile.android   |    3 +-
 android/Android.mk |    1 +
 android/hid.c      |  237 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 240 insertions(+), 1 deletion(-)

diff --git a/Makefile.android b/Makefile.android
index 2b57daa..22002be 100644
--- a/Makefile.android
+++ b/Makefile.android
@@ -12,7 +12,8 @@ android_bluetoothd_SOURCES =	android/main.c \
 				android/adapter.h android/adapter.c \
 				android/hid.h android/hid.c \
 				android/ipc.h android/ipc.c \
-				android/socket.h android/socket.c
+				android/socket.h android/socket.c \
+				btio/btio.h btio/btio.c
 
 android_bluetoothd_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
diff --git a/android/Android.mk b/android/Android.mk
index 22208e0..28ec465 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -28,6 +28,7 @@ LOCAL_SRC_FILES := \
 	../lib/sdp.c \
 	../lib/bluetooth.c \
 	../lib/hci.c \
+	../btio/btio.c
 
 LOCAL_C_INCLUDES := \
 	$(call include-path-for, glib) \
diff --git a/android/hid.c b/android/hid.c
index f2da0d3..b7bdc07 100644
--- a/android/hid.c
+++ b/android/hid.c
@@ -23,16 +23,252 @@
 
 #include <stdint.h>
 #include <stdbool.h>
+#include <errno.h>
+#include <unistd.h>
+#include <fcntl.h>
 
 #include <glib.h>
 
+#include "btio/btio.h"
 #include "lib/bluetooth.h"
+#include "src/shared/mgmt.h"
+
 #include "log.h"
 #include "hal-msg.h"
 #include "ipc.h"
 #include "hid.h"
+#include "adapter.h"
+#include "utils.h"
+
+#define L2CAP_PSM_HIDP_CTRL	0x11
+#define L2CAP_PSM_HIDP_INTR	0x13
+#define MAX_READ_BUFFER		4096
 
 static GIOChannel *notification_io = NULL;
+static GSList *devices = NULL;
+
+struct input_device {
+	bdaddr_t	src;
+	bdaddr_t	dst;
+	GIOChannel	*ctrl_io;
+	GIOChannel	*intr_io;
+	guint		ctrl_watch;
+	guint		intr_watch;
+};
+
+static int device_cmp(gconstpointer s, gconstpointer user_data)
+{
+	const struct input_device *idev = s;
+	const bdaddr_t *dst = user_data;
+
+	return bacmp(&idev->dst, dst);
+}
+
+static void input_device_free(struct input_device *idev)
+{
+	if (idev->ctrl_watch > 0)
+		g_source_remove(idev->ctrl_watch);
+
+	if (idev->intr_watch > 0)
+		g_source_remove(idev->intr_watch);
+
+	if (idev->intr_io)
+		g_io_channel_unref(idev->intr_io);
+
+	if (idev->ctrl_io)
+		g_io_channel_unref(idev->ctrl_io);
+
+	devices = g_slist_remove(devices, idev);
+	g_free(idev);
+}
+
+static gboolean intr_io_watch_cb(GIOChannel *chan, gpointer data)
+{
+	char buf[MAX_READ_BUFFER];
+	int fd, bread;
+
+	fd = g_io_channel_unix_get_fd(chan);
+	bread = read(fd, buf, sizeof(buf));
+	if (bread < 0) {
+		error("read: %s(%d)", strerror(-errno), -errno);
+		return TRUE;
+	}
+
+	DBG("bytes read %d", bread);
+
+	/* TODO: At this moment only baseband is connected, i.e. mouse
+	 * movements keyboard events doesn't effect on UI. Have to send
+	 * this data to uhid fd for profile connection. */
+
+	return TRUE;
+}
+
+static gboolean intr_watch_cb(GIOChannel *chan, GIOCondition cond,
+								gpointer data)
+{
+	struct input_device *idev = data;
+	char address[18];
+
+	if (cond & G_IO_IN)
+		return intr_io_watch_cb(chan, data);
+
+	ba2str(&idev->dst, address);
+	DBG("Device %s disconnected", address);
+
+	/* Checking for ctrl_watch avoids a double g_io_channel_shutdown since
+	 * it's likely that ctrl_watch_cb has been queued for dispatching in
+	 * this mainloop iteration */
+	if ((cond & (G_IO_HUP | G_IO_ERR)) && idev->ctrl_watch)
+		g_io_channel_shutdown(chan, TRUE, NULL);
+
+	idev->intr_watch = 0;
+
+	if (idev->intr_io) {
+		g_io_channel_unref(idev->intr_io);
+		idev->intr_io = NULL;
+	}
+
+	/* Close control channel */
+	if (idev->ctrl_io && !(cond & G_IO_NVAL))
+		g_io_channel_shutdown(idev->ctrl_io, TRUE, NULL);
+
+	return FALSE;
+}
+
+static gboolean ctrl_watch_cb(GIOChannel *chan, GIOCondition cond,
+								gpointer data)
+{
+	struct input_device *idev = data;
+	char address[18];
+
+	ba2str(&idev->dst, address);
+	DBG("Device %s disconnected", address);
+
+	/* Checking for intr_watch avoids a double g_io_channel_shutdown since
+	 * it's likely that intr_watch_cb has been queued for dispatching in
+	 * this mainloop iteration */
+	if ((cond & (G_IO_HUP | G_IO_ERR)) && idev->intr_watch)
+		g_io_channel_shutdown(chan, TRUE, NULL);
+
+	idev->ctrl_watch = 0;
+
+	if (idev->ctrl_io) {
+		g_io_channel_unref(idev->ctrl_io);
+		idev->ctrl_io = NULL;
+	}
+
+	if (idev->intr_io && !(cond & G_IO_NVAL))
+		g_io_channel_shutdown(idev->intr_io, TRUE, NULL);
+
+	return FALSE;
+}
+
+static void interrupt_connect_cb(GIOChannel *chan, GError *conn_err,
+							gpointer user_data)
+{
+	struct input_device *idev = user_data;
+
+	DBG("");
+
+	if (conn_err)
+		goto failed;
+
+	/*TODO: Get device details through SDP and create UHID fd and start
+	 * listening on uhid events */
+	idev->intr_watch = g_io_add_watch(idev->intr_io,
+				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				intr_watch_cb, idev);
+
+	return;
+
+failed:
+	/* So we guarantee the interrupt channel is closed before the
+	 * control channel (if we only do unref GLib will close it only
+	 * after returning control to the mainloop */
+	if (!conn_err)
+		g_io_channel_shutdown(idev->intr_io, FALSE, NULL);
+
+	g_io_channel_unref(idev->intr_io);
+	idev->intr_io = NULL;
+
+	if (idev->ctrl_io) {
+		g_io_channel_unref(idev->ctrl_io);
+		idev->ctrl_io = NULL;
+	}
+}
+
+static void control_connect_cb(GIOChannel *chan, GError *conn_err,
+							gpointer user_data)
+{
+	struct input_device *idev = user_data;
+	GError *err = NULL;
+
+	DBG("");
+
+	if (conn_err) {
+		error("%s", conn_err->message);
+		goto failed;
+	}
+
+	/* Connect to the HID interrupt channel */
+	idev->intr_io = bt_io_connect(interrupt_connect_cb, idev, NULL, &err,
+					BT_IO_OPT_SOURCE_BDADDR, &idev->src,
+					BT_IO_OPT_DEST_BDADDR, &idev->dst,
+					BT_IO_OPT_PSM, L2CAP_PSM_HIDP_INTR,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+					BT_IO_OPT_INVALID);
+	if (!idev->intr_io) {
+		error("%s", err->message);
+		g_error_free(err);
+		goto failed;
+	}
+
+	idev->ctrl_watch = g_io_add_watch(idev->ctrl_io,
+					G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+					ctrl_watch_cb, idev);
+
+	return;
+
+failed:
+	g_io_channel_unref(idev->ctrl_io);
+	idev->ctrl_io = NULL;
+}
+
+static uint8_t dev_connect(struct hal_cmd_hid_connect *cmd, uint16_t len)
+{
+	struct input_device *idev;
+	char addr[18];
+	GError *err = NULL;
+
+	DBG("");
+
+	if (len < sizeof(*cmd))
+		return HAL_STATUS_INVALID;
+
+	idev = g_new0(struct input_device, 1);
+	bacpy(&idev->src, bt_adapter_get_address());
+	android2bdaddr((bdaddr_t *)&cmd->bdaddr, &idev->dst);
+	ba2str(&idev->dst, addr);
+
+	DBG("connecting to %s", addr);
+
+	idev->ctrl_io = bt_io_connect(control_connect_cb, idev, NULL, &err,
+					BT_IO_OPT_SOURCE_BDADDR, &idev->src,
+					BT_IO_OPT_DEST_BDADDR, &idev->dst,
+					BT_IO_OPT_PSM, L2CAP_PSM_HIDP_CTRL,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+					BT_IO_OPT_INVALID);
+	if (err) {
+		error("%s", err->message);
+		g_error_free(err);
+		input_device_free(idev);
+		return HAL_STATUS_FAILED;
+	}
+
+	devices = g_slist_append(devices, idev);
+
+	return HAL_STATUS_SUCCESS;
+}
 
 void bt_hid_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf, uint16_t len)
 {
@@ -40,6 +276,7 @@ void bt_hid_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf, uint16_t len)
 
 	switch (opcode) {
 	case HAL_OP_HID_CONNECT:
+		status = dev_connect((struct hal_cmd_hid_connect *) buf, len);
 		break;
 	case HAL_OP_HID_DISCONNECT:
 		break;
-- 
1.7.9.5

