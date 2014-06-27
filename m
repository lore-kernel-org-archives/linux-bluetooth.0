Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 06/12] android: Add initial implementation of Battery Service client
Date: Fri, 27 Jun 2014 21:08:54 +0300
Message-Id: <1403892540-21222-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1403892540-21222-1-git-send-email-luiz.dentz@gmail.com>
References: <1403892540-21222-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/Android.mk  |   1 +
 android/Makefile.am |   1 +
 android/bas.c       | 137 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 android/bas.h       |  32 ++++++++++++
 4 files changed, 171 insertions(+)
 create mode 100644 android/bas.c
 create mode 100644 android/bas.h

diff --git a/android/Android.mk b/android/Android.mk
index 3cd17d5..075fe70 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -37,6 +37,7 @@ LOCAL_SRC_FILES := \
 	bluez/android/bluetooth.c \
 	bluez/android/scpp.c \
 	bluez/android/dis.c \
+	bluez/android/bas.c \
 	bluez/android/hog.c \
 	bluez/android/hidhost.c \
 	bluez/android/socket.c \
diff --git a/android/Makefile.am b/android/Makefile.am
index b1842f9..730be2f 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -40,6 +40,7 @@ android_bluetoothd_SOURCES = android/main.c \
 				android/hidhost.h android/hidhost.c \
 				android/scpp.h android/scpp.c \
 				android/dis.h android/dis.c \
+				android/bas.h android/bas.c \
 				android/hog.h android/hog.c \
 				android/ipc-common.h \
 				android/ipc.h android/ipc.c \
diff --git a/android/bas.c b/android/bas.c
new file mode 100644
index 0000000..ae7d274
--- /dev/null
+++ b/android/bas.c
@@ -0,0 +1,137 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can rebastribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is bastributed in the hope that it will be useful,
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
+#include <stdbool.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include "src/log.h"
+
+#include "lib/uuid.h"
+#include "src/shared/util.h"
+
+#include "attrib/gattrib.h"
+#include "attrib/att.h"
+#include "attrib/gatt.h"
+
+#include "android/bas.h"
+
+struct bt_bas {
+	int ref_count;
+	GAttrib *attrib;
+	struct gatt_primary *primary;
+	uint16_t handle;
+};
+
+static void bas_free(struct bt_bas *bas)
+{
+	if (bas->attrib)
+		g_attrib_unref(bas->attrib);
+
+	g_free(bas->primary);
+	g_free(bas);
+}
+
+struct bt_bas *bt_bas_new(void *primary)
+{
+	struct bt_bas *bas;
+
+	bas = g_try_new0(struct bt_bas, 1);
+	if (!bas)
+		return NULL;
+
+	if (primary)
+		bas->primary = g_memdup(primary, sizeof(*bas->primary));
+
+	return bt_bas_ref(bas);
+}
+
+struct bt_bas *bt_bas_ref(struct bt_bas *bas)
+{
+	if (!bas)
+		return NULL;
+
+	__sync_fetch_and_add(&bas->ref_count, 1);
+
+	return bas;
+}
+
+void bt_bas_unref(struct bt_bas *bas)
+{
+	if (!bas)
+		return;
+
+	if (__sync_sub_and_fetch(&bas->ref_count, 1))
+		return;
+
+	bas_free(bas);
+}
+
+static void bas_discovered_cb(uint8_t status, GSList *chars, void *user_data)
+{
+	struct bt_bas *bas = user_data;
+	struct gatt_char *chr;
+
+	if (status) {
+		error("Battery: %s", att_ecode2str(status));
+		return;
+	}
+
+	chr = chars->data;
+	bas->handle = chr->value_handle;
+
+	DBG("Battery handle: 0x%04x", bas->handle);
+
+	/* TODO: Add handling for notification */
+}
+
+bool bt_bas_attach(struct bt_bas *bas, void *attrib)
+{
+	if (!bas || bas->attrib || !bas->primary)
+		return false;
+
+	bas->attrib = g_attrib_ref(attrib);
+
+	if (bas->handle > 0)
+		return true;
+
+	gatt_discover_char(bas->attrib, bas->primary->range.start,
+					bas->primary->range.end, NULL,
+					bas_discovered_cb, bas);
+
+	return true;
+}
+
+void bt_bas_detach(struct bt_bas *bas)
+{
+	if (!bas || !bas->attrib)
+		return;
+
+	g_attrib_unref(bas->attrib);
+	bas->attrib = NULL;
+}
diff --git a/android/bas.h b/android/bas.h
new file mode 100644
index 0000000..3e175b5
--- /dev/null
+++ b/android/bas.h
@@ -0,0 +1,32 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can rebastribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is bastributed in the hope that it will be useful,
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
+struct bt_bas;
+
+struct bt_bas *bt_bas_new(void *primary);
+
+struct bt_bas *bt_bas_ref(struct bt_bas *bas);
+void bt_bas_unref(struct bt_bas *bas);
+
+bool bt_bas_attach(struct bt_bas *bas, void *gatt);
+void bt_bas_detach(struct bt_bas *bas);
-- 
1.9.3

