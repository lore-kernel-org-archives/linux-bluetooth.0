Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <andrei.emeltchenko@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android: Add initial UHID code
Date: Tue, 22 Oct 2013 14:17:05 +0300
Message-Id: <1382440625-26764-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>

---
 Makefile.android  |   3 +-
 android/hidhost.c | 244 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 246 insertions(+), 1 deletion(-)
 create mode 100644 android/hidhost.c

diff --git a/Makefile.android b/Makefile.android
index aebc715..4ff3abe 100644
--- a/Makefile.android
+++ b/Makefile.android
@@ -9,7 +9,8 @@ android_bluetoothd_SOURCES =	android/main.c \
 				src/shared/util.h src/shared/util.c \
 				src/shared/mgmt.h src/shared/mgmt.c \
 				android/adapter.h android/adapter.c \
-				android/ipc.h android/ipc.c
+				android/ipc.h android/ipc.c \
+				android/hidhost.c
 
 android_bluetoothd_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
diff --git a/android/hidhost.c b/android/hidhost.c
new file mode 100644
index 0000000..4ab914e
--- /dev/null
+++ b/android/hidhost.c
@@ -0,0 +1,244 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2013  Intel Corporation. All rights reserved.
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
+#include <stdbool.h>
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
+
+#include <linux/uhid.h>
+
+#include "log.h"
+#include "adapter.h"
+#include "device.h"
+
+#define UHID_DEVICE_FILE        "/dev/uhid"
+
+struct input_device {
+	uint16_t                id;
+	struct bt_device       *device;
+	int                     uhid_fd;
+	guint                   uhid_watch_id;
+};
+
+static GSList *devices = NULL;
+
+static int uhid_create(int fd)
+{
+	struct uhid_event ev;
+
+	/* create uHID device */
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_CREATE;
+	strcpy((char *) ev.u.create.name, "bluez-input-device");
+	ev.u.create.vendor = 0;
+	ev.u.create.product = 0;
+	ev.u.create.version = 0;
+	ev.u.create.country = 0;
+	ev.u.create.bus = BUS_BLUETOOTH;
+	ev.u.create.rd_data = 0;
+	ev.u.create.rd_size = 0;
+
+	if (write(fd, &ev, sizeof(ev)) < 0) {
+		error("Failed to create uHID device: %s", strerror(errno));
+		return -errno;
+	}
+
+	return 0;
+}
+
+static void uhid_destroy(int fd)
+{
+	struct uhid_event ev;
+
+	/* destroy uHID device */
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_DESTROY;
+
+	if (write(fd, &ev, sizeof(ev)) < 0)
+		error("Failed to destroy uHID device: %s", strerror(errno));
+}
+
+static int uhid_send_input(int fd, uint8_t *data, ssize_t size)
+{
+	struct uhid_event ev;
+
+	/* send data to uHID device */
+	memset(&ev, 0, sizeof(ev));
+	ev.type = UHID_INPUT;
+	ev.u.input.size = size;
+	memcpy(ev.u.input.data, data, size);
+
+	if (write(fd, &ev, sizeof(ev)) < 0) {
+		error("Failed to send input to uHID device: %s", strerror(errno));
+		return -errno;
+	}
+
+	return 0;
+} 
+
+static int get_report(int fd)
+{
+	/* TODO: prepare get_report request */
+
+	return uhid_send_input(fd, NULL, 0);
+}
+
+static int set_report(int fd)
+{
+	/* TODO: prepare set_report request */
+
+	return uhid_send_input(fd, NULL, 0);
+}
+
+static int get_protocol(int fd)
+{
+	/* TODO: prepare get_protocol request */
+
+	return uhid_send_input(fd, NULL, 0);
+}
+
+static int set_protocol(int fd)
+{
+	/* TODO: prepare set_protocol request */
+
+	return uhid_send_input(fd, NULL, 0);
+}
+
+static gboolean uhid_event_cb(GIOChannel *io, GIOCondition cond,
+                                                        gpointer user_data)
+{
+	struct input_device *inputdev = user_data;
+	struct uhid_event ev;
+	ssize_t bread;
+	int fd;
+
+	if (cond & (G_IO_ERR | G_IO_NVAL))
+		goto failed;
+
+	fd = g_io_channel_unix_get_fd(io);
+	memset(&ev, 0, sizeof(ev));
+
+	bread = read(fd, &ev, sizeof(ev));
+	if (bread < 0) {
+		int err = -errno;
+		DBG("uhid-dev read: %s(%d)", strerror(-err), -err);
+		goto failed;
+	}
+
+	DBG("uHID event type %d received", ev.type);
+
+	switch (ev.type) {
+	case UHID_START:
+	case UHID_STOP:
+	case UHID_OPEN:
+	case UHID_CLOSE:
+		break;
+	case UHID_OUTPUT:
+	case UHID_FEATURE:
+		// TODO inform hal_if through ipc
+		break;
+	case UHID_OUTPUT_EV:
+		DBG("Unsupported uHID output event: type %d code %d value %d",
+			ev.u.output_ev.type, ev.u.output_ev.code,
+			ev.u.output_ev.value);
+		break;
+	default:
+		warn("unexpected uHID event");
+		break;
+	}
+
+	return TRUE;
+
+failed:
+	inputdev->uhid_watch_id = 0;
+	return FALSE;
+}
+
+static struct input_device *input_new_device(struct bt_device *device)
+{
+	struct input_device *inputdev;
+
+	inputdev = g_try_new0(struct input_device, 1);
+	if (!inputdev)
+		return NULL;
+
+	return inputdev;
+}
+
+static void input_free_device(struct input_device *inputdev)
+{
+	devices = g_slist_remove(devices, inputdev);
+	g_free(inputdev);
+}
+
+
+static struct input_device *input_register_device(struct bt_device *device)
+{
+	struct input_device *inputdev;
+	GIOCondition cond = G_IO_IN | G_IO_ERR | G_IO_NVAL;
+	GIOChannel *io;
+
+	inputdev = input_new_device(device);
+	if (!inputdev)
+		return NULL;
+
+	inputdev->uhid_fd = open(UHID_DEVICE_FILE, O_RDWR | O_CLOEXEC);
+	if (inputdev->uhid_fd < 0) {
+		error("Failed to open uHID device: %s(%d)", strerror(errno),
+									errno);
+		input_free_device(inputdev);
+		return NULL;
+	}
+
+	io = g_io_channel_unix_new(inputdev->uhid_fd);
+	g_io_channel_set_encoding(io, NULL, NULL);
+	inputdev->uhid_watch_id = g_io_add_watch(io, cond, uhid_event_cb,
+								inputdev);
+	g_io_channel_unref(io);
+
+	devices = g_slist_append(devices, inputdev);
+
+	return inputdev;
+}
+
+static int input_unregister_device(struct input_device *inputdev)
+{
+	if (inputdev->uhid_watch_id) {
+		g_source_remove(inputdev->uhid_watch_id);
+		inputdev->uhid_watch_id = 0;
+	}
+
+	uhid_destroy(inputdev->uhid_fd);
+	close(inputdev->uhid_fd);
+	inputdev->uhid_fd = -1;
+
+	input_free_device(inputdev);
+
+	return 0;
+}
-- 
1.8.1.2

