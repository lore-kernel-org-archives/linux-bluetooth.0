Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: dh.herrmann@googlemail.com, chen.ganir@ti.com,
	=?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [RFC 2/8] HoG: register ATTIO callbacks
Date: Tue, 27 Mar 2012 19:31:21 -0300
Message-Id: <1332887487-13601-3-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1332887487-13601-1-git-send-email-jprvita@openbossa.org>
References: <1332887487-13601-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This way the LE connection is kept up.
---
 Makefile.am        |    2 +-
 input/hog_device.c |  140 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 input/hog_device.h |    5 ++
 input/manager.c    |    4 +-
 4 files changed, 149 insertions(+), 2 deletions(-)
 create mode 100644 input/hog_device.c

diff --git a/Makefile.am b/Makefile.am
index 32f98b2..fb8c8df 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -180,7 +180,7 @@ builtin_sources += input/main.c \
 			input/server.h input/server.c \
 			input/device.h input/device.c \
 			input/fakehid.c input/fakehid.h \
-			input/hog_device.h
+			input/hog_device.c input/hog_device.h
 endif
 
 if SERIALPLUGIN
diff --git a/input/hog_device.c b/input/hog_device.c
new file mode 100644
index 0000000..2228a76
--- /dev/null
+++ b/input/hog_device.c
@@ -0,0 +1,140 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2012  Instituto Nokia de Tecnologia - INdT
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
+#include <stdlib.h>
+#include <errno.h>
+#include <unistd.h>
+
+#include <bluetooth/bluetooth.h>
+
+#include <glib.h>
+
+#include "log.h"
+
+#include "../src/adapter.h"
+#include "../src/device.h"
+
+#include "hog_device.h"
+
+#include "gattrib.h"
+#include "attio.h"
+
+struct hog_device {
+	char			*path;
+	struct btd_device	*device;
+	GAttrib			*attrib;
+	guint			attioid;
+};
+
+static GSList *devices = NULL;
+
+static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
+{
+	struct hog_device *hogdev = user_data;
+
+	hogdev->attrib = g_attrib_ref(attrib);
+}
+
+static void attio_disconnected_cb(gpointer user_data)
+{
+	struct hog_device *hogdev = user_data;
+
+	g_attrib_unref(hogdev->attrib);
+	hogdev->attrib = NULL;
+}
+
+static struct hog_device *find_device_by_path(GSList *list, const char *path)
+{
+	for (; list; list = list->next) {
+		struct hog_device *hogdev = list->data;
+
+		if (!strcmp(hogdev->path, path))
+			return hogdev;
+	}
+
+	return NULL;
+}
+
+static struct hog_device *hog_device_new(struct btd_device *device,
+							const char *path)
+{
+	struct hog_device *hogdev;
+
+	hogdev = g_new0(struct hog_device, 1);
+	if (!hogdev)
+		return NULL;
+
+	hogdev->path = g_strdup(path);
+	hogdev->device = btd_device_ref(device);
+
+	return hogdev;
+}
+
+int hog_device_register(struct btd_device *device, const char *path)
+{
+	struct hog_device *hogdev;
+
+	hogdev = find_device_by_path(devices, path);
+	if (hogdev)
+		return -EALREADY;
+
+	hogdev = hog_device_new(device, path);
+	if (!hogdev)
+		return -ENOMEM;
+
+	hogdev->attioid = btd_device_add_attio_callback(device,
+							attio_connected_cb,
+							attio_disconnected_cb,
+							hogdev);
+
+	devices = g_slist_append(devices, hogdev);
+
+	return 0;
+}
+
+static void hog_device_free(struct hog_device *hogdev)
+{
+	btd_device_unref(hogdev->device);
+	g_free(hogdev->path);
+	g_free(hogdev);
+}
+
+int hog_device_unregister(const char *path)
+{
+	struct hog_device *hogdev;
+
+	hogdev = find_device_by_path(devices, path);
+	if (hogdev == NULL)
+		return -EINVAL;
+
+	btd_device_remove_attio_callback(hogdev->device, hogdev->attioid);
+	devices = g_slist_remove(devices, hogdev);
+	hog_device_free(hogdev);
+
+	return 0;
+}
diff --git a/input/hog_device.h b/input/hog_device.h
index a0158ea..585e3d5 100644
--- a/input/hog_device.h
+++ b/input/hog_device.h
@@ -23,3 +23,8 @@
  */
 
 #define HOG_UUID		"00001812-0000-1000-8000-00805f9b34fb"
+
+struct hog_device;
+
+int hog_device_register(struct btd_device *device, const char *path);
+int hog_device_unregister(const char *path);
diff --git a/input/manager.c b/input/manager.c
index 6025295..a38edd4 100644
--- a/input/manager.c
+++ b/input/manager.c
@@ -202,7 +202,7 @@ static int hog_device_probe(struct btd_device *device, GSList *uuids)
 
 	DBG("path %s", path);
 
-	return 0;
+	return hog_device_register(device, path);
 }
 
 static void hog_device_remove(struct btd_device *device)
@@ -210,6 +210,8 @@ static void hog_device_remove(struct btd_device *device)
 	const gchar *path = device_get_path(device);
 
 	DBG("path %s", path);
+
+	hog_device_unregister(path);
 }
 
 static struct btd_device_driver hog_driver = {
-- 
1.7.7.6

