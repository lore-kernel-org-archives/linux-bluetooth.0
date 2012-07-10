Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ] hog: fix build with --disable-gatt
Date: Tue, 10 Jul 2012 18:13:32 -0300
Message-Id: <1341954812-10255-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

To be able to build HoG only if gatt and input are enabled it needs
a separate plugin manager.
---
 Makefile.am                  |    3 +-
 profiles/input/hog_manager.c |   93 ++++++++++++++++++++++++++++++++++++++++++
 profiles/input/main.c        |   21 ----------
 profiles/input/manager.c     |   35 ----------------
 profiles/input/manager.h     |    3 --
 5 files changed, 95 insertions(+), 60 deletions(-)
 create mode 100644 profiles/input/hog_manager.c

diff --git a/Makefile.am b/Makefile.am
index ffb57e8..e1daf44 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -183,7 +183,8 @@ endif
 
 if HOGPLUGIN
 builtin_modules += hog
-builtin_sources += profiles/input/hog_device.h profiles/input/hog_device.c
+builtin_sources += profiles/input/hog_manager.c profiles/input/hog_device.h \
+			profiles/input/hog_device.c
 endif
 
 if NETWORKPLUGIN
diff --git a/profiles/input/hog_manager.c b/profiles/input/hog_manager.c
new file mode 100644
index 0000000..ddc5baf
--- /dev/null
+++ b/profiles/input/hog_manager.c
@@ -0,0 +1,93 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012  Instituto Nokia de Tecnologia
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
+#include <errno.h>
+
+#include "log.h"
+#include "../src/adapter.h"
+#include "../src/device.h"
+
+#include "plugin.h"
+#include "hcid.h"
+#include "device.h"
+#include "hog_device.h"
+
+static int hog_device_probe(struct btd_device *device, GSList *uuids)
+{
+	const char *path = device_get_path(device);
+
+	DBG("path %s", path);
+
+	return hog_device_register(device, path);
+}
+
+static void hog_device_remove(struct btd_device *device)
+{
+	const gchar *path = device_get_path(device);
+
+	DBG("path %s", path);
+
+	hog_device_unregister(path);
+}
+
+static struct btd_device_driver hog_driver = {
+	.name	= "input-hog",
+	.uuids	= BTD_UUIDS(HOG_UUID),
+	.probe	= hog_device_probe,
+	.remove	= hog_device_remove,
+};
+
+static int hog_manager_init(void)
+{
+	return btd_register_device_driver(&hog_driver);
+}
+
+static void hog_manager_exit(void)
+{
+	btd_unregister_device_driver(&hog_driver);
+}
+
+static int hog_init(void)
+{
+	if (!main_opts.gatt_enabled) {
+		DBG("GATT is disabled");
+		return -ENOTSUP;
+	}
+
+	return hog_manager_init();
+}
+
+static void hog_exit(void)
+{
+	if (!main_opts.gatt_enabled)
+		return;
+
+	hog_manager_exit();
+}
+
+BLUETOOTH_PLUGIN_DEFINE(hog, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+							hog_init, hog_exit)
diff --git a/profiles/input/main.c b/profiles/input/main.c
index 722bc49..05469a1 100644
--- a/profiles/input/main.c
+++ b/profiles/input/main.c
@@ -85,24 +85,3 @@ static void input_exit(void)
 
 BLUETOOTH_PLUGIN_DEFINE(input, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
 							input_init, input_exit)
-
-static int hog_init(void)
-{
-	if (!main_opts.gatt_enabled) {
-		DBG("GATT is disabled");
-		return -ENOTSUP;
-	}
-
-	return hog_manager_init();
-}
-
-static void hog_exit(void)
-{
-	if (!main_opts.gatt_enabled)
-		return;
-
-	hog_manager_exit();
-}
-
-BLUETOOTH_PLUGIN_DEFINE(hog, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
-							hog_init, hog_exit)
diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index 928a2f5..add9789 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -193,38 +193,3 @@ void input_manager_exit(void)
 
 	connection = NULL;
 }
-
-static int hog_device_probe(struct btd_device *device, GSList *uuids)
-{
-	const char *path = device_get_path(device);
-
-	DBG("path %s", path);
-
-	return hog_device_register(device, path);
-}
-
-static void hog_device_remove(struct btd_device *device)
-{
-	const gchar *path = device_get_path(device);
-
-	DBG("path %s", path);
-
-	hog_device_unregister(path);
-}
-
-static struct btd_device_driver hog_driver = {
-	.name	= "input-hog",
-	.uuids	= BTD_UUIDS(HOG_UUID),
-	.probe	= hog_device_probe,
-	.remove	= hog_device_remove,
-};
-
-int hog_manager_init(void)
-{
-	return btd_register_device_driver(&hog_driver);
-}
-
-void hog_manager_exit(void)
-{
-	btd_unregister_device_driver(&hog_driver);
-}
diff --git a/profiles/input/manager.h b/profiles/input/manager.h
index 468de64..7b93c5b 100644
--- a/profiles/input/manager.h
+++ b/profiles/input/manager.h
@@ -23,6 +23,3 @@
 
 int input_manager_init(DBusConnection *conn, GKeyFile *config);
 void input_manager_exit(void);
-
-int hog_manager_init(void);
-void hog_manager_exit(void);
-- 
1.7.10.4

