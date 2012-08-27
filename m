Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [RFC BlueZ 02/22] alert: Introduce manager abstraction layer
Date: Mon, 27 Aug 2012 13:11:46 -0400
Message-Id: <1346087526-15107-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1346087526-15107-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1346087526-15107-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This abstraction layer makes the GATT Phone Alert Status and Alert
Notification implementation consistent with other GATT profiles.
---
 Makefile.am              |    3 ++-
 profiles/alert/main.c    |    6 +++---
 profiles/alert/manager.c |   40 ++++++++++++++++++++++++++++++++++++++++
 profiles/alert/manager.h |   26 ++++++++++++++++++++++++++
 4 files changed, 71 insertions(+), 4 deletions(-)
 create mode 100644 profiles/alert/manager.c
 create mode 100644 profiles/alert/manager.h

diff --git a/Makefile.am b/Makefile.am
index 4977a05..1088991 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -219,7 +219,8 @@ builtin_sources += profiles/thermometer/main.c \
 			profiles/thermometer/thermometer.h \
 			profiles/thermometer/thermometer.c \
 			profiles/alert/main.c profiles/alert/server.h \
-			profiles/alert/server.c \
+			profiles/alert/server.c profiles/alert/manager.h \
+			profiles/alert/manager.c \
 			profiles/time/main.c profiles/time/server.h \
 			profiles/time/server.c profiles/time/manager.c \
 			profiles/time/manager.h \
diff --git a/profiles/alert/main.c b/profiles/alert/main.c
index ec4ab6d..5e6910a 100644
--- a/profiles/alert/main.c
+++ b/profiles/alert/main.c
@@ -33,7 +33,7 @@
 #include "plugin.h"
 #include "hcid.h"
 #include "log.h"
-#include "server.h"
+#include "manager.h"
 
 static int alert_init(void)
 {
@@ -42,7 +42,7 @@ static int alert_init(void)
 		return -ENOTSUP;
 	}
 
-	return alert_server_init();
+	return alert_manager_init();
 }
 
 static void alert_exit(void)
@@ -50,7 +50,7 @@ static void alert_exit(void)
 	if (!main_opts.gatt_enabled)
 		return;
 
-	alert_server_exit();
+	alert_manager_exit();
 }
 
 BLUETOOTH_PLUGIN_DEFINE(alert, VERSION,
diff --git a/profiles/alert/manager.c b/profiles/alert/manager.c
new file mode 100644
index 0000000..eb2d627
--- /dev/null
+++ b/profiles/alert/manager.c
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
+int alert_manager_init(void)
+{
+	return alert_server_init();
+}
+
+void alert_manager_exit(void)
+{
+	alert_server_exit();
+}
diff --git a/profiles/alert/manager.h b/profiles/alert/manager.h
new file mode 100644
index 0000000..e4c6bd0
--- /dev/null
+++ b/profiles/alert/manager.h
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
+int alert_manager_init(void);
+void alert_manager_exit(void);
-- 
1.7.9.5

