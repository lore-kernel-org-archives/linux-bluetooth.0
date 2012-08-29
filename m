Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v1 1/6] hog: Add initial files for suspend support
Date: Wed, 29 Aug 2012 17:53:05 -0300
Message-Id: <1346273590-16693-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1346273590-16693-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345237703-15342-1-git-send-email-claudio.takahasi@openbossa.org>
 <1346273590-16693-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the initial files to support HoG suspend. The suspend
concept for HoG is implementation specific. The proposal is allowing
back-end selection at build time. Each Linux distribution/platform is
responsible for defining and writting their own policy to manage suspend
on HoG capable devices.

When setting the Control Point, the report device can execute actions to
save power. eg: Reduce the cycle of the key press detection or disable
LEDs.
---
 Makefile.am                    |  3 ++-
 profiles/input/hog_manager.c   | 14 ++++++++++++++
 profiles/input/suspend-dummy.c | 38 ++++++++++++++++++++++++++++++++++++++
 profiles/input/suspend.h       | 26 ++++++++++++++++++++++++++
 4 files changed, 80 insertions(+), 1 deletion(-)
 create mode 100644 profiles/input/suspend-dummy.c
 create mode 100644 profiles/input/suspend.h

diff --git a/Makefile.am b/Makefile.am
index 4977a05..f6eb96b 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -184,7 +184,8 @@ endif
 if HOGPLUGIN
 builtin_modules += hog
 builtin_sources += profiles/input/hog_manager.c profiles/input/hog_device.h \
-			profiles/input/hog_device.c profiles/input/uhid_copy.h
+			profiles/input/hog_device.c profiles/input/uhid_copy.h \
+			profiles/input/suspend-dummy.c profiles/input/suspend.h
 endif
 
 if NETWORKPLUGIN
diff --git a/profiles/input/hog_manager.c b/profiles/input/hog_manager.c
index c544e79..149ed34 100644
--- a/profiles/input/hog_manager.c
+++ b/profiles/input/hog_manager.c
@@ -35,8 +35,11 @@
 #include "plugin.h"
 #include "hcid.h"
 #include "device.h"
+#include "suspend.h"
 #include "hog_device.h"
 
+static gboolean suspend_supported = FALSE;
+
 static int hog_device_probe(struct btd_device *device, GSList *uuids)
 {
 	const char *path = device_get_path(device);
@@ -64,11 +67,22 @@ static struct btd_device_driver hog_driver = {
 
 static int hog_manager_init(void)
 {
+	int err;
+
+	err = suspend_init();
+	if (err < 0)
+		DBG("Suspend: %s(%d)", strerror(-err), -err);
+	else
+		suspend_supported = TRUE;
+
 	return btd_register_device_driver(&hog_driver);
 }
 
 static void hog_manager_exit(void)
 {
+	if (suspend_supported)
+		suspend_exit();
+
 	btd_unregister_device_driver(&hog_driver);
 }
 
diff --git a/profiles/input/suspend-dummy.c b/profiles/input/suspend-dummy.c
new file mode 100644
index 0000000..0a97158
--- /dev/null
+++ b/profiles/input/suspend-dummy.c
@@ -0,0 +1,38 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012  Nordic Semiconductor Inc.
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
+#include "suspend.h"
+
+int suspend_init(void)
+{
+	return 0;
+}
+
+void suspend_exit(void)
+{
+}
diff --git a/profiles/input/suspend.h b/profiles/input/suspend.h
new file mode 100644
index 0000000..3f37a29
--- /dev/null
+++ b/profiles/input/suspend.h
@@ -0,0 +1,26 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012  Nordic Semiconductor Inc.
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
+int suspend_init(void);
+void suspend_exit(void);
-- 
1.7.12

