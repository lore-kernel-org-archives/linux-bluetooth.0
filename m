Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 1/5] Add Proximity Reporter skeleton
Date: Mon, 25 Jul 2011 17:15:51 -0300
Message-Id: <1311624955-22360-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1311624955-22360-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1311624955-22360-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

---
 Makefile.am          |    3 ++-
 proximity/manager.c  |    4 +++-
 proximity/reporter.c |   47 +++++++++++++++++++++++++++++++++++++++++++++++
 proximity/reporter.h |   26 ++++++++++++++++++++++++++
 4 files changed, 78 insertions(+), 2 deletions(-)
 create mode 100644 proximity/reporter.c
 create mode 100644 proximity/reporter.h

diff --git a/Makefile.am b/Makefile.am
index f61c9a8..0783666 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -194,7 +194,8 @@ if PROXIMITYPLUGIN
 builtin_modules += proximity
 builtin_sources += proximity/main.c \
 			proximity/manager.h proximity/manager.c \
-			proximity/monitor.h proximity/monitor.c
+			proximity/monitor.h proximity/monitor.c \
+			proximity/reporter.h proximity/reporter.c
 endif
 
 if SERVICEPLUGIN
diff --git a/proximity/manager.c b/proximity/manager.c
index 4b07108..f49d066 100644
--- a/proximity/manager.c
+++ b/proximity/manager.c
@@ -32,6 +32,7 @@
 #include "adapter.h"
 #include "device.h"
 #include "monitor.h"
+#include "reporter.h"
 #include "manager.h"
 
 #define LINK_LOSS_UUID "00001803-0000-1000-8000-00805f9b34fb"
@@ -73,11 +74,12 @@ int proximity_manager_init(DBusConnection *conn)
 		return ret;
 	}
 
-	return 0;
+	return reporter_init();
 }
 
 void proximity_manager_exit(void)
 {
+	reporter_exit();
 	monitor_unregister(connection);
 	btd_unregister_device_driver(&monitor_driver);
 	dbus_connection_unref(connection);
diff --git a/proximity/reporter.c b/proximity/reporter.c
new file mode 100644
index 0000000..e8fd368
--- /dev/null
+++ b/proximity/reporter.c
@@ -0,0 +1,47 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011  Nokia Corporation
+ *  Copyright (C) 2011  Marcel Holtmann <marcel@holtmann.org>
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
+#include "log.h"
+
+#include "reporter.h"
+
+int reporter_init(void)
+{
+	/*
+	 * TODO: Create/Update Proximity Reporter Characteristics
+	 * for Link Loss, Path Loss and Immediate Alert Services.
+	 */
+
+	DBG("Proximity Reporter");
+
+	return 0;
+}
+
+void reporter_exit(void)
+{
+}
diff --git a/proximity/reporter.h b/proximity/reporter.h
new file mode 100644
index 0000000..ea6b83d
--- /dev/null
+++ b/proximity/reporter.h
@@ -0,0 +1,26 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011  Nokia Corporation
+ *  Copyright (C) 2011  Marcel Holtmann <marcel@holtmann.org>
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
+int reporter_init(void);
+void reporter_exit(void);
-- 
1.7.0.4

