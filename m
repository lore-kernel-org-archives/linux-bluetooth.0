Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/uhid: Add initial API
Date: Fri, 16 May 2014 12:46:33 +0300
Message-Id: <1400233593-30392-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 Makefile.am       |  6 +++++
 src/shared/uhid.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/uhid.h | 43 ++++++++++++++++++++++++++++++++++++
 unit/test-uhid.c  | 37 +++++++++++++++++++++++++++++++
 4 files changed, 151 insertions(+)
 create mode 100644 src/shared/uhid.c
 create mode 100644 src/shared/uhid.h
 create mode 100644 unit/test-uhid.c

diff --git a/Makefile.am b/Makefile.am
index f96c700..660c851 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -261,6 +261,12 @@ unit_test_mgmt_SOURCES = unit/test-mgmt.c \
 				src/shared/mgmt.h src/shared/mgmt.c
 unit_test_mgmt_LDADD = @GLIB_LIBS@
 
+unit_tests += unit/test-uhid
+
+unit_test_uhid_SOURCES = unit/test-uhid.c \
+				src/shared/uhid.h src/shared/uhid.c
+unit_test_uhid_LDADD = @GLIB_LIBS@
+
 unit_tests += unit/test-sdp
 
 unit_test_sdp_SOURCES = unit/test-sdp.c \
diff --git a/src/shared/uhid.c b/src/shared/uhid.c
new file mode 100644
index 0000000..fafad6a
--- /dev/null
+++ b/src/shared/uhid.c
@@ -0,0 +1,65 @@
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
+
+#include "src/shared/uhid.h"
+
+struct bt_uhid *bt_uhid_new(const char *name, uint32_t vendor, uint32_t product,
+					uint32_t version, uint8_t *rd_data,
+					uint16_t rd_size)
+{
+	return NULL;
+}
+
+struct bt_uhid *bt_uhid_ref(struct bt_uhid *uhid)
+{
+	return NULL;
+}
+
+void bt_uhid_unref(struct bt_uhid *uhid)
+{
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
+int bt_uhid_send(struct bt_uhid *uhid, struct uhid_event *ev)
+{
+	return 0;
+}
diff --git a/src/shared/uhid.h b/src/shared/uhid.h
new file mode 100644
index 0000000..58f4f74
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
+struct bt_uhid *bt_uhid_new(const char *name, uint32_t vendor, uint32_t product,
+					uint32_t version, uint8_t *rd_data,
+					uint16_t rd_size);
+
+struct bt_uhid *bt_uhid_ref(struct bt_uhid *uhid);
+void bt_uhid_unref(struct bt_uhid *uhid);
+
+typedef void (*bt_uhid_notify_func_t)(struct bt_uhid *uhid,
+					struct uhid_event *ev, void *user_data);
+unsigned int bt_uhid_register(struct bt_uhid *uhid, uint32_t event,
+				bt_uhid_notify_func_t func, void *user_data);
+bool bt_uhid_unregister(struct bt_uhid *uhid, unsigned int id);
+
+int bt_uhid_send(struct bt_uhid *uhid, struct uhid_event *ev);
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

