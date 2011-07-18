Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 2/7] Add manager files for HTP
Date: Mon, 18 Jul 2011 15:10:37 +0200
Message-Id: <1310994642-16375-2-git-send-email-sancane@gmail.com>
In-Reply-To: <1310994642-16375-1-git-send-email-sancane@gmail.com>
References: <1310994642-16375-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am           |    3 ++-
 thermometer/main.c    |   21 +++++++++++++++++++--
 thermometer/manager.c |   38 ++++++++++++++++++++++++++++++++++++++
 thermometer/manager.h |   27 +++++++++++++++++++++++++++
 4 files changed, 86 insertions(+), 3 deletions(-)
 create mode 100644 thermometer/manager.c
 create mode 100644 thermometer/manager.h

diff --git a/Makefile.am b/Makefile.am
index 4443943..8c25eab 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -210,7 +210,8 @@ endif
 
 if THERMOMETERPLUGIN
 builtin_modules += thermometer
-builtin_sources += thermometer/main.c
+builtin_sources += thermometer/main.c \
+			thermometer/manager.h thermometer/manager.c
 endif
 
 builtin_modules += hciops mgmtops
diff --git a/thermometer/main.c b/thermometer/main.c
index 2a73208..33649a7 100644
--- a/thermometer/main.c
+++ b/thermometer/main.c
@@ -27,18 +27,35 @@
 #include <config.h>
 #endif
 
+#include <glib.h>
+#include <errno.h>
+#include <gdbus.h>
+
 #include "plugin.h"
+#include "manager.h"
 
+static DBusConnection *connection = NULL;
 
 static int thermometer_init(void)
 {
-	/*TODO: */
+	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+	if (connection == NULL)
+		return -EIO;
+
+	if (thermometer_manager_init(connection) < 0) {
+		dbus_connection_unref(connection);
+		return -EIO;
+	}
+
 	return 0;
 }
 
 static void thermometer_exit(void)
 {
-	/*TODO: */
+	thermometer_manager_exit();
+
+	dbus_connection_unref(connection);
+	connection = NULL;
 }
 
 BLUETOOTH_PLUGIN_DEFINE(thermometer, VERSION, BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
diff --git a/thermometer/manager.c b/thermometer/manager.c
new file mode 100644
index 0000000..8ace3f9
--- /dev/null
+++ b/thermometer/manager.c
@@ -0,0 +1,38 @@
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
+#include "manager.h"
+
+int thermometer_manager_init(DBusConnection *conn)
+{
+	/*TODO: */
+	return 0;
+}
+
+void thermometer_manager_exit(void)
+{
+	/*TODO: */
+}
\ No newline at end of file
diff --git a/thermometer/manager.h b/thermometer/manager.h
new file mode 100644
index 0000000..801ae5b
--- /dev/null
+++ b/thermometer/manager.h
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
+int thermometer_manager_init(DBusConnection *conn);
+void thermometer_manager_exit(void);
\ No newline at end of file
-- 
1.7.6

