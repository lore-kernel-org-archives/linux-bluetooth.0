Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 1/3] time: Introduce manager abstraction layer
Date: Wed, 20 Jun 2012 14:14:19 -0400
Message-Id: <1340216061-24778-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This abstraction layer makes the GATT Time profile implementation
consistent with other profiles. It is the first step before implementing
the adapter driver for the Time server implementation.
---
 Makefile.am    |    1 +
 time/main.c    |    6 +++---
 time/manager.c |   40 ++++++++++++++++++++++++++++++++++++++++
 time/manager.h |   26 ++++++++++++++++++++++++++
 4 files changed, 70 insertions(+), 3 deletions(-)
 create mode 100644 time/manager.c
 create mode 100644 time/manager.h

diff --git a/Makefile.am b/Makefile.am
index 1c214c6..b606b9c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -226,6 +226,7 @@ builtin_sources += thermometer/main.c \
 			thermometer/thermometer.h thermometer/thermometer.c \
 			alert/main.c alert/server.h alert/server.c \
 			time/main.c time/server.h time/server.c \
+			time/manager.h time/manager.c \
 			plugins/gatt-example.c \
 			proximity/main.c proximity/manager.h proximity/manager.c \
 			proximity/monitor.h proximity/monitor.c \
diff --git a/time/main.c b/time/main.c
index d876725..9ef5bf1 100644
--- a/time/main.c
+++ b/time/main.c
@@ -33,7 +33,7 @@
 #include "plugin.h"
 #include "hcid.h"
 #include "log.h"
-#include "server.h"
+#include "manager.h"
 
 static int time_init(void)
 {
@@ -42,7 +42,7 @@ static int time_init(void)
 		return -ENOTSUP;
 	}
 
-	return time_server_init();
+	return time_manager_init();
 }
 
 static void time_exit(void)
@@ -50,7 +50,7 @@ static void time_exit(void)
 	if (!main_opts.gatt_enabled)
 		return;
 
-	time_server_exit();
+	time_manager_exit();
 }
 
 BLUETOOTH_PLUGIN_DEFINE(time, VERSION,
diff --git a/time/manager.c b/time/manager.c
new file mode 100644
index 0000000..5bda1a3
--- /dev/null
+++ b/time/manager.c
@@ -0,0 +1,40 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012  Nokia Corporation
+ *  Copyright (C) 2012  Marcel Holtmann <marcel@holtmann.org>
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
+#include "manager.h"
+#include "server.h"
+
+int time_manager_init(void)
+{
+	return time_server_init();
+}
+
+void time_manager_exit(void)
+{
+	time_server_exit();
+}
diff --git a/time/manager.h b/time/manager.h
new file mode 100644
index 0000000..74641d6
--- /dev/null
+++ b/time/manager.h
@@ -0,0 +1,26 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012  Nokia Corporation
+ *  Copyright (C) 2012  Marcel Holtmann <marcel@holtmann.org>
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
+int time_manager_init(void);
+void time_manager_exit(void);
-- 
1.7.9.5

