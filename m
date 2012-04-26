Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [BlueZ 01/15] HoG: Register HID over GATT device driver
Date: Thu, 26 Apr 2012 16:45:31 -0300
Message-Id: <1335469545-1007-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

---
 Makefile.am        |    5 +++++
 acinclude.m4       |    1 +
 input/hog_device.h |   25 +++++++++++++++++++++++++
 input/main.c       |   13 +++++++++++++
 input/manager.c    |   34 ++++++++++++++++++++++++++++++++++
 input/manager.h    |    3 +++
 6 files changed, 81 insertions(+), 0 deletions(-)
 create mode 100644 input/hog_device.h

diff --git a/Makefile.am b/Makefile.am
index 62705f6..6e152f4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -183,6 +183,11 @@ builtin_sources += input/main.c \
 			input/fakehid.c input/fakehid.h
 endif
 
+if HOGPLUGIN
+builtin_modules += hog
+builtin_sources += input/hog_device.h
+endif
+
 if SERIALPLUGIN
 builtin_modules += serial
 builtin_sources += serial/main.c \
diff --git a/acinclude.m4 b/acinclude.m4
index dcf9a48..8656379 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -392,4 +392,5 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(DBUSOOBPLUGIN, test "${dbusoob_enable}" = "yes")
 	AM_CONDITIONAL(WIIMOTEPLUGIN, test "${wiimote_enable}" = "yes")
 	AM_CONDITIONAL(GATTMODULES, test "${gatt_enable}" = "yes")
+	AM_CONDITIONAL(HOGPLUGIN, test "${gatt_enable}" = "yes" && test "${input_enable}" = "yes")
 ])
diff --git a/input/hog_device.h b/input/hog_device.h
new file mode 100644
index 0000000..a0158ea
--- /dev/null
+++ b/input/hog_device.h
@@ -0,0 +1,25 @@
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
+#define HOG_UUID		"00001812-0000-1000-8000-00805f9b34fb"
diff --git a/input/main.c b/input/main.c
index da09b86..2aac3db 100644
--- a/input/main.c
+++ b/input/main.c
@@ -84,3 +84,16 @@ static void input_exit(void)
 
 BLUETOOTH_PLUGIN_DEFINE(input, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
 							input_init, input_exit)
+
+static int hog_init(void)
+{
+	return hog_manager_init();
+}
+
+static void hog_exit(void)
+{
+	hog_manager_exit();
+}
+
+BLUETOOTH_PLUGIN_DEFINE(hog, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+							hog_init, hog_exit)
diff --git a/input/manager.c b/input/manager.c
index 4ac5686..e1d1f81 100644
--- a/input/manager.c
+++ b/input/manager.c
@@ -39,6 +39,7 @@
 #include "../src/device.h"
 
 #include "device.h"
+#include "hog_device.h"
 #include "server.h"
 #include "manager.h"
 
@@ -194,3 +195,36 @@ void input_manager_exit(void)
 
 	connection = NULL;
 }
+
+static int hog_device_probe(struct btd_device *device, GSList *uuids)
+{
+	const char *path = device_get_path(device);
+
+	DBG("path %s", path);
+
+	return 0;
+}
+
+static void hog_device_remove(struct btd_device *device)
+{
+	const gchar *path = device_get_path(device);
+
+	DBG("path %s", path);
+}
+
+static struct btd_device_driver hog_driver = {
+	.name	= "input-hog",
+	.uuids	= BTD_UUIDS(HOG_UUID),
+	.probe	= hog_device_probe,
+	.remove	= hog_device_remove,
+};
+
+int hog_manager_init(void)
+{
+	return btd_register_device_driver(&hog_driver);
+}
+
+void hog_manager_exit(void)
+{
+	btd_unregister_device_driver(&hog_driver);
+}
diff --git a/input/manager.h b/input/manager.h
index 7b93c5b..468de64 100644
--- a/input/manager.h
+++ b/input/manager.h
@@ -23,3 +23,6 @@
 
 int input_manager_init(DBusConnection *conn, GKeyFile *config);
 void input_manager_exit(void);
+
+int hog_manager_init(void);
+void hog_manager_exit(void);
-- 
1.7.7.6

