Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 17/21] alert: move alert to profiles dir
Date: Wed, 13 Jun 2012 17:43:39 -0300
Message-Id: <1339620223-6639-18-git-send-email-gustavo@padovan.org>
In-Reply-To: <1339620223-6639-1-git-send-email-gustavo@padovan.org>
References: <1339620223-6639-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

---
 Makefile.am             |    3 ++-
 alert/main.c            |   58 -----------------------------------------------
 alert/server.c          |   38 -------------------------------
 alert/server.h          |   26 ---------------------
 profiles/alert/main.c   |   58 +++++++++++++++++++++++++++++++++++++++++++++++
 profiles/alert/server.c |   38 +++++++++++++++++++++++++++++++
 profiles/alert/server.h |   26 +++++++++++++++++++++
 7 files changed, 124 insertions(+), 123 deletions(-)
 delete mode 100644 alert/main.c
 delete mode 100644 alert/server.c
 delete mode 100644 alert/server.h
 create mode 100644 profiles/alert/main.c
 create mode 100644 profiles/alert/server.c
 create mode 100644 profiles/alert/server.h

diff --git a/Makefile.am b/Makefile.am
index 6dc1415..b8f3bbb 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -223,7 +223,8 @@ builtin_modules += thermometer alert time gatt_example proximity \
 builtin_sources += thermometer/main.c \
 			thermometer/manager.h thermometer/manager.c \
 			thermometer/thermometer.h thermometer/thermometer.c \
-			alert/main.c alert/server.h alert/server.c \
+			profiles/alert/main.c profiles/alert/server.h \
+			profiles/alert/server.c \
 			time/main.c time/server.h time/server.c \
 			plugins/gatt-example.c \
 			proximity/main.c proximity/manager.h proximity/manager.c \
diff --git a/alert/main.c b/alert/main.c
deleted file mode 100644
index ec4ab6d..0000000
--- a/alert/main.c
+++ /dev/null
@@ -1,58 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2011  Nokia Corporation
- *  Copyright (C) 2011  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <stdint.h>
-#include <glib.h>
-#include <errno.h>
-
-#include "plugin.h"
-#include "hcid.h"
-#include "log.h"
-#include "server.h"
-
-static int alert_init(void)
-{
-	if (!main_opts.gatt_enabled) {
-		DBG("GATT is disabled");
-		return -ENOTSUP;
-	}
-
-	return alert_server_init();
-}
-
-static void alert_exit(void)
-{
-	if (!main_opts.gatt_enabled)
-		return;
-
-	alert_server_exit();
-}
-
-BLUETOOTH_PLUGIN_DEFINE(alert, VERSION,
-			BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
-			alert_init, alert_exit)
diff --git a/alert/server.c b/alert/server.c
deleted file mode 100644
index d91b156..0000000
--- a/alert/server.c
+++ /dev/null
@@ -1,38 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2011  Nokia Corporation
- *  Copyright (C) 2011  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include "server.h"
-
-int alert_server_init(void)
-{
-	return 0;
-}
-
-void alert_server_exit(void)
-{
-}
diff --git a/alert/server.h b/alert/server.h
deleted file mode 100644
index e59bdb1..0000000
--- a/alert/server.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2011  Nokia Corporation
- *  Copyright (C) 2011  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-int alert_server_init(void);
-void alert_server_exit(void);
diff --git a/profiles/alert/main.c b/profiles/alert/main.c
new file mode 100644
index 0000000..ec4ab6d
--- /dev/null
+++ b/profiles/alert/main.c
@@ -0,0 +1,58 @@
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
+#include <stdint.h>
+#include <glib.h>
+#include <errno.h>
+
+#include "plugin.h"
+#include "hcid.h"
+#include "log.h"
+#include "server.h"
+
+static int alert_init(void)
+{
+	if (!main_opts.gatt_enabled) {
+		DBG("GATT is disabled");
+		return -ENOTSUP;
+	}
+
+	return alert_server_init();
+}
+
+static void alert_exit(void)
+{
+	if (!main_opts.gatt_enabled)
+		return;
+
+	alert_server_exit();
+}
+
+BLUETOOTH_PLUGIN_DEFINE(alert, VERSION,
+			BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+			alert_init, alert_exit)
diff --git a/profiles/alert/server.c b/profiles/alert/server.c
new file mode 100644
index 0000000..d91b156
--- /dev/null
+++ b/profiles/alert/server.c
@@ -0,0 +1,38 @@
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
+#include "server.h"
+
+int alert_server_init(void)
+{
+	return 0;
+}
+
+void alert_server_exit(void)
+{
+}
diff --git a/profiles/alert/server.h b/profiles/alert/server.h
new file mode 100644
index 0000000..e59bdb1
--- /dev/null
+++ b/profiles/alert/server.h
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
+int alert_server_init(void);
+void alert_server_exit(void);
-- 
1.7.10.2

