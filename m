Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 1/3] Add Proximity Profile plugin skeleton
Date: Wed, 13 Jul 2011 09:37:55 -0300
Message-Id: <1310560677-2773-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1310560677-2773-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1310560677-2773-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am         |    5 +++++
 acinclude.m4        |    6 ++++++
 bootstrap-configure |    1 +
 proximity/main.c    |   42 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 54 insertions(+), 0 deletions(-)
 create mode 100644 proximity/main.c

diff --git a/Makefile.am b/Makefile.am
index 5f54b5b..0fd52fd 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -190,6 +190,11 @@ builtin_sources += network/main.c \
 			network/connection.h network/connection.c
 endif
 
+if PROXIMITYPLUGIN
+builtin_modules += proximity
+builtin_sources += proximity/main.c
+endif
+
 if SERVICEPLUGIN
 builtin_modules += service
 builtin_sources += plugins/service.c
diff --git a/acinclude.m4 b/acinclude.m4
index af97cce..d613086 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -193,6 +193,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	serial_enable=yes
 	network_enable=yes
 	sap_enable=no
+	proximity_enable=no
 	service_enable=yes
 	health_enable=no
 	pnat_enable=no
@@ -239,6 +240,10 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	])
 	AC_SUBST([SAP_DRIVER], [sap-${sap_driver}.c])
 
+	AC_ARG_ENABLE(proximity, AC_HELP_STRING([--enable-proximity], [enable proximity plugin]), [
+		proximity_enable=${enableval}
+	])
+
 	AC_ARG_ENABLE(serial, AC_HELP_STRING([--disable-serial], [disable serial plugin]), [
 		serial_enable=${enableval}
 	])
@@ -381,6 +386,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(SERIALPLUGIN, test "${serial_enable}" = "yes")
 	AM_CONDITIONAL(NETWORKPLUGIN, test "${network_enable}" = "yes")
 	AM_CONDITIONAL(SAPPLUGIN, test "${sap_enable}" = "yes")
+	AM_CONDITIONAL(PROXIMITYPLUGIN, test "${proximity_enable}" = "yes")
 	AM_CONDITIONAL(SERVICEPLUGIN, test "${service_enable}" = "yes")
 	AM_CONDITIONAL(HEALTHPLUGIN, test "${health_enable}" = "yes")
 	AM_CONDITIONAL(MCAP, test "${health_enable}" = "yes")
diff --git a/bootstrap-configure b/bootstrap-configure
index 55c1049..b0020cb 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -18,6 +18,7 @@ fi
 		--libexecdir=/lib \
 		--enable-capng \
 		--enable-gatt-example \
+		--enable-proximity \
 		--enable-health \
 		--enable-tracer \
 		--enable-tools \
diff --git a/proximity/main.c b/proximity/main.c
new file mode 100644
index 0000000..dccd619
--- /dev/null
+++ b/proximity/main.c
@@ -0,0 +1,42 @@
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
+#include "plugin.h"
+
+static int proximity_init(void)
+{
+	return 0;
+}
+
+static void proximity_exit(void)
+{
+}
+
+BLUETOOTH_PLUGIN_DEFINE(proximity, VERSION,
+			BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
+			proximity_init, proximity_exit)
-- 
1.7.6

