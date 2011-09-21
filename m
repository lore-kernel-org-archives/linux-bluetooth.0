Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH BlueZ 2/2] Add Phone Alert Server skeleton plugin
Date: Wed, 21 Sep 2011 08:46:10 -0400
Message-Id: <1316609170-4929-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1316609170-4929-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1316609170-4929-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

---
 Makefile.am         |    6 +++++
 acinclude.m4        |    6 +++++
 alert/main.c        |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++
 alert/server.c      |   38 ++++++++++++++++++++++++++++++++++
 alert/server.h      |   26 +++++++++++++++++++++++
 bootstrap-configure |    1 +
 6 files changed, 134 insertions(+), 0 deletions(-)
 create mode 100644 alert/main.c
 create mode 100644 alert/server.c
 create mode 100644 alert/server.h

diff --git a/Makefile.am b/Makefile.am
index 05ed562..a63c469 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -228,6 +228,12 @@ builtin_sources += time/main.c \
 		   time/server.h time/server.c
 endif
 
+if ALERTPLUGIN
+builtin_modules += alert
+builtin_sources += alert/main.c \
+		   alert/server.h alert/server.c
+endif
+
 if HEALTHPLUGIN
 builtin_modules += health
 builtin_sources += health/hdp_main.c health/hdp_types.h \
diff --git a/acinclude.m4 b/acinclude.m4
index 115cd90..2097d77 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -195,6 +195,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	sap_enable=no
 	proximity_enable=no
 	time_enable=no
+	alert_enable=no
 	service_enable=yes
 	health_enable=no
 	pnat_enable=no
@@ -251,6 +252,10 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		time_enable=${enableval}
 	])
 
+	AC_ARG_ENABLE(alert, AC_HELP_STRING([--enable-alert], [enable Phone Alert Profile plugin]), [
+		alert_enable=${enableval}
+	])
+
 	AC_ARG_ENABLE(serial, AC_HELP_STRING([--disable-serial], [disable serial plugin]), [
 		serial_enable=${enableval}
 	])
@@ -403,6 +408,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(SAPPLUGIN, test "${sap_enable}" = "yes")
 	AM_CONDITIONAL(PROXIMITYPLUGIN, test "${proximity_enable}" = "yes")
 	AM_CONDITIONAL(TIMEPLUGIN, test "${time_enable}" = "yes")
+	AM_CONDITIONAL(ALERTPLUGIN, test "${alert_enable}" = "yes")
 	AM_CONDITIONAL(SERVICEPLUGIN, test "${service_enable}" = "yes")
 	AM_CONDITIONAL(HEALTHPLUGIN, test "${health_enable}" = "yes")
 	AM_CONDITIONAL(MCAP, test "${health_enable}" = "yes")
diff --git a/alert/main.c b/alert/main.c
new file mode 100644
index 0000000..25100e9
--- /dev/null
+++ b/alert/main.c
@@ -0,0 +1,57 @@
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
+
+#include "plugin.h"
+#include "hcid.h"
+#include "log.h"
+#include "server.h"
+
+static int alert_init(void)
+{
+	if (!main_opts.attrib_server) {
+		DBG("Attribute server is disabled");
+		return -1;
+	}
+
+	return alert_server_init();
+}
+
+static void alert_exit(void)
+{
+	if (!main_opts.attrib_server)
+		return;
+
+	alert_server_exit();
+}
+
+BLUETOOTH_PLUGIN_DEFINE(alert, VERSION,
+			BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+			alert_init, alert_exit)
diff --git a/alert/server.c b/alert/server.c
new file mode 100644
index 0000000..d91b156
--- /dev/null
+++ b/alert/server.c
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
diff --git a/alert/server.h b/alert/server.h
new file mode 100644
index 0000000..e59bdb1
--- /dev/null
+++ b/alert/server.h
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
diff --git a/bootstrap-configure b/bootstrap-configure
index 65e266f..94da969 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -20,6 +20,7 @@ fi
 		--enable-gatt-example \
 		--enable-proximity \
 		--enable-time \
+		--enable-alert \
 		--enable-health \
 		--enable-tracer \
 		--enable-tools \
-- 
1.7.0.4

