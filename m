Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 5/7] Add thermometer driver skeleton
Date: Mon, 18 Jul 2011 15:10:40 +0200
Message-Id: <1310994642-16375-5-git-send-email-sancane@gmail.com>
In-Reply-To: <1310994642-16375-4-git-send-email-sancane@gmail.com>
References: <1310994642-16375-1-git-send-email-sancane@gmail.com>
 <1310994642-16375-2-git-send-email-sancane@gmail.com>
 <1310994642-16375-3-git-send-email-sancane@gmail.com>
 <1310994642-16375-4-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am               |    3 ++-
 thermometer/manager.c     |   10 +++-------
 thermometer/thermometer.c |   41 +++++++++++++++++++++++++++++++++++++++++
 thermometer/thermometer.h |   30 ++++++++++++++++++++++++++++++
 4 files changed, 76 insertions(+), 8 deletions(-)
 create mode 100644 thermometer/thermometer.c
 create mode 100644 thermometer/thermometer.h

diff --git a/Makefile.am b/Makefile.am
index 8c25eab..4a7f34f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -211,7 +211,8 @@ endif
 if THERMOMETERPLUGIN
 builtin_modules += thermometer
 builtin_sources += thermometer/main.c \
-			thermometer/manager.h thermometer/manager.c
+			thermometer/manager.h thermometer/manager.c \
+			thermometer/thermometer.h thermometer/thermometer.c
 endif
 
 builtin_modules += hciops mgmtops
diff --git a/thermometer/manager.c b/thermometer/manager.c
index 988bd57..b5fba4c 100644
--- a/thermometer/manager.c
+++ b/thermometer/manager.c
@@ -27,23 +27,19 @@
 
 #include "adapter.h"
 #include "device.h"
-#include "log.h"
+#include "thermometer.h"
 #include "manager.h"
 
-#define HEALTH_THERMOMETER_SVC_UUID	0x1809
-#define HEALTH_THERMOMETER_UUID		"00001809-0000-1000-8000-00805f9b34fb"
-
 static DBusConnection *connection = NULL;
 
 static int thermometer_driver_probe(struct btd_device *device, GSList *uuids)
 {
-	/* TODO; */
-	return 0;
+	return thermometer_register(connection, device);
 }
 
 static void thermometer_driver_remove(struct btd_device *device)
 {
-	/* TODO: */
+	thermometer_unregister(device);
 }
 
 static struct btd_device_driver thermometer_device_driver = {
diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
new file mode 100644
index 0000000..a05d37d
--- /dev/null
+++ b/thermometer/thermometer.c
@@ -0,0 +1,41 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011 GSyC/LibreSoft, Universidad Rey Juan Carlos.
+ *  Authors:
+ *  Santiago Carot Nemesio <sancane at gmail.com>
+ *  Jorge Fernandez Gonzalez <jorge.fernandez.gonzalez at gmail.com>
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
+#include <gdbus.h>
+
+#include "adapter.h"
+#include "device.h"
+#include "thermometer.h"
+
+int thermometer_register(DBusConnection *connection, struct btd_device *device)
+{
+	/* TODO: Register Health Thermometer Interface */
+	return 0;
+}
+
+void thermometer_unregister(struct btd_device *device)
+{
+	/* TODO: Unregister Health Thermometer Interface */
+}
\ No newline at end of file
diff --git a/thermometer/thermometer.h b/thermometer/thermometer.h
new file mode 100644
index 0000000..28c9d18
--- /dev/null
+++ b/thermometer/thermometer.h
@@ -0,0 +1,30 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011 GSyC/LibreSoft, Universidad Rey Juan Carlos.
+ *  Authors:
+ *  Santiago Carot Nemesio <sancane at gmail.com>
+ *  Jorge Fernandez Gonzalez <jorge.fernandez.gonzalez at gmail.com>
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
+#define HEALTH_THERMOMETER_SVC_UUID	0x1809
+#define HEALTH_THERMOMETER_UUID		"00001809-0000-1000-8000-00805f9b34fb"
+
+int thermometer_register(DBusConnection *connection, struct btd_device *device);
+void thermometer_unregister(struct btd_device *device);
\ No newline at end of file
-- 
1.7.6

