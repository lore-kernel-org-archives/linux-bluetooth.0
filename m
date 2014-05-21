Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/8] shared/uhid: Add initial API
Date: Wed, 21 May 2014 18:01:02 +0300
Message-Id: <1400684469-2693-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 Makefile.am       |   8 +++
 src/shared/uhid.c | 175 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/uhid.h |  43 ++++++++++++++
 unit/test-uhid.c  |  37 ++++++++++++
 4 files changed, 263 insertions(+)
 create mode 100644 src/shared/uhid.c
 create mode 100644 src/shared/uhid.h
 create mode 100644 unit/test-uhid.c

diff --git a/Makefile.am b/Makefile.am
index 3ca98d0..6b989b4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -263,6 +263,14 @@ unit_test_mgmt_SOURCES = unit/test-mgmt.c \
 				src/shared/mgmt.h src/shared/mgmt.c
 unit_test_mgmt_LDADD = @GLIB_LIBS@
 
+unit_tests += unit/test-uhid
+
+unit_test_uhid_SOURCES = unit/test-uhid.c \
+				src/shared/uhid.h src/shared/uhid.c \
+				src/shared/io.h src/shared/io-glib.c \
+				src/shared/util.h src/shared/util.c
+unit_test_uhid_LDADD = @GLIB_LIBS@
+
 unit_tests += unit/test-sdp
 
 unit_test_sdp_SOURCES = unit/test-sdp.c \
diff --git a/src/shared/uhid.c b/src/shared/uhid.c
new file mode 100644
index 0000000..13d9b5e
--- /dev/null
+++ b/src/shared/uhid.c
@@ -0,0 +1,175 @@
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
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+#include <fcntl.h>
+
+#include "src/shared/io.h"
+#include "src/shared/util.h"
+#include "src/shared/uhid.h"
+
+#define UHID_DEVICE_FILE "/dev/uhid"
+
+struct bt_uhid {
+	int ref_count;
+	struct io *io;
+};
+
+static void uhid_free(struct bt_uhid *uhid)
+{
+	if (uhid->io)
+		io_destroy(uhid->io);
+
+	free(uhid);
+}
+
+static bool uhid_read_handler(struct io *io, void *user_data)
+{
+	int fd;
+	ssize_t len;
+	struct uhid_event ev;
+
+	fd = io_get_fd(io);
+	if (fd < 0)
+		return false;
+
+	memset(&ev, 0, sizeof(ev));
+
+	len = read(fd, &ev, sizeof(ev));
+	if (len < 0)
+		return false;
+
+	if ((size_t) len < sizeof(ev.type))
+		return false;
+
+	return true;
+}
+
+struct bt_uhid *bt_uhid_new_default(void)
+{
+	struct bt_uhid *uhid;
+	int fd;
+
+	fd = open(UHID_DEVICE_FILE, O_RDWR | O_CLOEXEC);
+	if (fd < 0)
+		return NULL;
+
+	uhid = bt_uhid_new(fd);
+	if (!uhid) {
+		close(fd);
+		return NULL;
+	}
+
+	io_set_close_on_destroy(uhid->io, true);
+
+	return uhid;
+}
+
+struct bt_uhid *bt_uhid_new(int fd)
+{
+	struct bt_uhid *uhid;
+
+	uhid = new0(struct bt_uhid, 1);
+	if (!uhid)
+		return NULL;
+
+	uhid->io = io_new(fd);
+	if (!uhid->io)
+		goto failed;
+
+	if (!io_set_read_handler(uhid->io, uhid_read_handler, uhid, NULL))
+		goto failed;
+
+	return bt_uhid_ref(uhid);
+
+failed:
+	uhid_free(uhid);
+	return NULL;
+}
+
+struct bt_uhid *bt_uhid_ref(struct bt_uhid *uhid)
+{
+	if (!uhid)
+		return NULL;
+
+	__sync_fetch_and_add(&uhid->ref_count, 1);
+
+	return uhid;
+}
+
+void bt_uhid_unref(struct bt_uhid *uhid)
+{
+	if (!uhid)
+		return;
+
+	if (__sync_sub_and_fetch(&uhid->ref_count, 1))
+		return;
+
+	uhid_free(uhid);
+}
+
+bool bt_uhid_set_close_on_unref(struct bt_uhid *uhid, bool do_close)
+{
+	if (!uhid || !uhid->io)
+		return false;
+
+	io_set_close_on_destroy(uhid->io, do_close);
+
+	return true;
+}
+
+unsigned int bt_uhid_register(struct bt_uhid *uhid, uint32_t type,
+				bt_uhid_notify_func_t func, void *user_data)
+{
+	return 0;
+}
+
+bool bt_uhid_unregister(struct bt_uhid *uhid, unsigned int id)
+{
+	return false;
+}
+
+int bt_uhid_send(struct bt_uhid *uhid, const struct uhid_event *ev)
+{
+	int fd;
+	ssize_t len;
+
+	if (!uhid->io)
+		return -ENOTCONN;
+
+	fd = io_get_fd(uhid->io);
+
+	len = write(fd, ev, sizeof(*ev));
+	if (len < 0)
+		return -errno;
+
+	/* uHID kernel driver does not handle partial writes */
+	return len != sizeof(*ev) ? -EIO : 0;
+}
diff --git a/src/shared/uhid.h b/src/shared/uhid.h
new file mode 100644
index 0000000..fcf5379
--- /dev/null
+++ b/src/shared/uhid.h
@@ -0,0 +1,43 @@
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
+#include <stdbool.h>
+#include <stdint.h>
+#include <linux/uhid.h>
+
+struct bt_uhid;
+
+struct bt_uhid *bt_uhid_new_default(void);
+struct bt_uhid *bt_uhid_new(int fd);
+
+struct bt_uhid *bt_uhid_ref(struct bt_uhid *uhid);
+void bt_uhid_unref(struct bt_uhid *uhid);
+
+bool bt_uhid_set_close_on_unref(struct bt_uhid *uhid, bool do_close);
+
+typedef void (*bt_uhid_callback_t)(struct uhid_event *ev, void *user_data);
+unsigned int bt_uhid_register(struct bt_uhid *uhid, uint32_t event,
+				bt_uhid_callback_t func, void *user_data);
+bool bt_uhid_unregister(struct bt_uhid *uhid, unsigned int id);
+
+int bt_uhid_send(struct bt_uhid *uhid, const struct uhid_event *ev);
diff --git a/unit/test-uhid.c b/unit/test-uhid.c
new file mode 100644
index 0000000..e0fb411
--- /dev/null
+++ b/unit/test-uhid.c
@@ -0,0 +1,37 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Intel Corporation. All rights reserved.
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
+#include <glib.h>
+
+#include "src/shared/uhid.h"
+
+int main(int argc, char *argv[])
+{
+	g_test_init(&argc, &argv, NULL);
+
+	return g_test_run();
+}
-- 
1.9.0

