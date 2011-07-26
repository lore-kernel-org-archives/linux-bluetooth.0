Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 3/3] Add thermometer driver skeleton
Date: Tue, 26 Jul 2011 14:15:54 +0200
Message-Id: <1311682554-21241-4-git-send-email-sancane@gmail.com>
In-Reply-To: <1311682554-21241-3-git-send-email-sancane@gmail.com>
References: <1311682554-21241-1-git-send-email-sancane@gmail.com>
 <1311682554-21241-2-git-send-email-sancane@gmail.com>
 <1311682554-21241-3-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am               |    3 ++-
 thermometer/manager.c     |   38 ++++++++++++++++++++++++++++++++++++--
 thermometer/thermometer.c |   41 +++++++++++++++++++++++++++++++++++++++++
 thermometer/thermometer.h |   27 +++++++++++++++++++++++++++
 4 files changed, 106 insertions(+), 3 deletions(-)
 create mode 100644 thermometer/thermometer.c
 create mode 100644 thermometer/thermometer.h

diff --git a/Makefile.am b/Makefile.am
index 87b21a6..2735728 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -218,7 +218,8 @@ endif
 if THERMOMETERPLUGIN
 builtin_modules += thermometer
 builtin_sources += thermometer/main.c \
-			thermometer/manager.h thermometer/manager.c
+			thermometer/manager.h thermometer/manager.c \
+			thermometer/thermometer.h thermometer/thermometer.c
 endif
 
 builtin_modules += hciops mgmtops
diff --git a/thermometer/manager.c b/thermometer/manager.c
index a243de0..4fad5ed 100644
--- a/thermometer/manager.c
+++ b/thermometer/manager.c
@@ -24,15 +24,49 @@
  */
 
 #include <gdbus.h>
+
+#include "adapter.h"
+#include "device.h"
+#include "thermometer.h"
 #include "manager.h"
 
+#define HEALTH_THERMOMETER_UUID		"00001809-0000-1000-8000-00805f9b34fb"
+
+static DBusConnection *connection = NULL;
+
+static int thermometer_driver_probe(struct btd_device *device, GSList *uuids)
+{
+	return thermometer_register(connection, device);
+}
+
+static void thermometer_driver_remove(struct btd_device *device)
+{
+	thermometer_unregister(device);
+}
+
+static struct btd_device_driver thermometer_device_driver = {
+	.name	= "thermometer-device-driver",
+	.uuids	= BTD_UUIDS(HEALTH_THERMOMETER_UUID),
+	.probe	= thermometer_driver_probe,
+	.remove	= thermometer_driver_remove
+};
+
 int thermometer_manager_init(DBusConnection *conn)
 {
-	/*TODO: */
+	int ret;
+
+	ret = btd_register_device_driver(&thermometer_device_driver);
+	if (ret < 0)
+                return ret;
+
+	connection = dbus_connection_ref(conn);
 	return 0;
 }
 
 void thermometer_manager_exit(void)
 {
-	/*TODO: */
+	btd_unregister_device_driver(&thermometer_device_driver);
+
+	dbus_connection_unref(connection);
+	connection = NULL;
 }
diff --git a/thermometer/thermometer.c b/thermometer/thermometer.c
new file mode 100644
index 0000000..8b521e3
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
diff --git a/thermometer/thermometer.h b/thermometer/thermometer.h
new file mode 100644
index 0000000..2f64e21
--- /dev/null
+++ b/thermometer/thermometer.h
@@ -0,0 +1,27 @@
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
+int thermometer_register(DBusConnection *connection, struct btd_device *device);
+void thermometer_unregister(struct btd_device *device);
-- 
1.7.6

