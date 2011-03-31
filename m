Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH 1/2] Remove deprecated attrib plugin
Date: Thu, 31 Mar 2011 11:59:10 -0400
Message-Id: <1301587151-18975-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The attrib plugin is deprecated and it is not used anymore. Remove it
and all related configuration. Note that GATT utility (gatttool)
configuration item was moved to Makefile.tools and it is compiled when
--enable-tools is used in configure.
---
 Makefile.am         |   18 ------------------
 Makefile.tools      |   11 +++++++++++
 acinclude.m4        |    6 ------
 attrib/main.c       |   48 ------------------------------------------------
 attrib/manager.c    |   43 -------------------------------------------
 attrib/manager.h    |   26 --------------------------
 bootstrap-configure |    1 -
 7 files changed, 11 insertions(+), 142 deletions(-)
 delete mode 100644 attrib/main.c
 delete mode 100644 attrib/manager.c
 delete mode 100644 attrib/manager.h

diff --git a/Makefile.am b/Makefile.am
index 9b74970..4670886 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -189,24 +189,6 @@ builtin_modules += service
 builtin_sources += plugins/service.c
 endif
 
-if ATTRIBPLUGIN
-
-if READLINE
-bin_PROGRAMS += attrib/gatttool
-
-attrib_gatttool_SOURCES = attrib/gatttool.c attrib/att.c attrib/gatt.c \
-				attrib/gattrib.c btio/btio.c \
-				src/glib-helper.h src/glib-helper.c \
-				attrib/gatttool.h attrib/interactive.c \
-				attrib/utils.c
-attrib_gatttool_LDADD = lib/libbluetooth.la @GLIB_LIBS@ @READLINE_LIBS@
-endif
-
-builtin_modules += attrib
-builtin_sources += attrib/main.c \
-		attrib/manager.h attrib/manager.c
-endif
-
 if GATT_EXAMPLE_PLUGIN
 builtin_modules += gatt_example
 builtin_sources += plugins/gatt-example.c
diff --git a/Makefile.tools b/Makefile.tools
index 7c5ff55..feef380 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -49,6 +49,17 @@ tools_ppporc_LDADD = lib/libbluetooth.la
 
 tools_hcieventmask_LDADD = lib/libbluetooth.la
 
+if READLINE
+bin_PROGRAMS += attrib/gatttool
+
+attrib_gatttool_SOURCES = attrib/gatttool.c attrib/att.c attrib/gatt.c \
+				attrib/gattrib.c btio/btio.c \
+				src/glib-helper.h src/glib-helper.c \
+				attrib/gatttool.h attrib/interactive.c \
+				attrib/utils.c
+attrib_gatttool_LDADD = lib/libbluetooth.la @GLIB_LIBS@ @READLINE_LIBS@
+endif
+
 dist_man_MANS += tools/rfcomm.1 tools/l2ping.8 \
 			tools/hciattach.8 tools/hciconfig.8 \
 			tools/hcitool.1 tools/sdptool.1 tools/ciptool.1
diff --git a/acinclude.m4 b/acinclude.m4
index 81b366e..22fcd5c 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -189,7 +189,6 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	service_enable=yes
 	health_enable=no
 	pnat_enable=no
-	attrib_enable=no
 	gatt_example_enable=no
 	tracer_enable=no
 	tools_enable=yes
@@ -258,10 +257,6 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		pnat_enable=${enableval}
 	])
 
-	AC_ARG_ENABLE(attrib, AC_HELP_STRING([--enable-attrib], [enable attrib plugin]), [
-		attrib_enable=${enableval}
-	])
-
 	AC_ARG_ENABLE(gatt-example, AC_HELP_STRING([--enable-gatt-example], [enable GATT example plugin]), [
 		gatt_example_enable=${enableval}
 	])
@@ -389,7 +384,6 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(MCAP, test "${health_enable}" = "yes")
 	AM_CONDITIONAL(HAL, test "${hal_enable}" = "yes")
 	AM_CONDITIONAL(READLINE, test "${readline_found}" = "yes")
-	AM_CONDITIONAL(ATTRIBPLUGIN, test "${attrib_enable}" = "yes")
 	AM_CONDITIONAL(GATT_EXAMPLE_PLUGIN, test "${gatt_example_enable}" = "yes")
 	AM_CONDITIONAL(ECHOPLUGIN, test "no" = "yes")
 	AM_CONDITIONAL(PNATPLUGIN, test "${pnat_enable}" = "yes")
diff --git a/attrib/main.c b/attrib/main.c
deleted file mode 100644
index 91ddab1..0000000
--- a/attrib/main.c
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2010  Nokia Corporation
- *  Copyright (C) 2010  Marcel Holtmann <marcel@holtmann.org>
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
-#include <errno.h>
-
-#include "plugin.h"
-#include "manager.h"
-
-static int attrib_init(void)
-{
-	if (attrib_manager_init() < 0)
-		return -EIO;
-
-	return 0;
-}
-
-static void attrib_exit(void)
-{
-	attrib_manager_exit();
-}
-
-BLUETOOTH_PLUGIN_DEFINE(attrib, VERSION,
-		BLUETOOTH_PLUGIN_PRIORITY_DEFAULT, attrib_init, attrib_exit)
diff --git a/attrib/manager.c b/attrib/manager.c
deleted file mode 100644
index 6a2b80a..0000000
--- a/attrib/manager.c
+++ /dev/null
@@ -1,43 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2010  Nokia Corporation
- *  Copyright (C) 2010  Marcel Holtmann <marcel@holtmann.org>
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
-
-#include "hcid.h"
-
-#include "manager.h"
-
-int attrib_manager_init(void)
-{
-	return 0;
-}
-
-void attrib_manager_exit(void)
-{
-}
diff --git a/attrib/manager.h b/attrib/manager.h
deleted file mode 100644
index 19dc539..0000000
--- a/attrib/manager.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2010  Nokia Corporation
- *  Copyright (C) 2010  Marcel Holtmann <marcel@holtmann.org>
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
-int attrib_manager_init(void);
-void attrib_manager_exit(void);
diff --git a/bootstrap-configure b/bootstrap-configure
index 364998f..cff3ac1 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -17,7 +17,6 @@ fi
 		--localstatedir=/var \
 		--libexecdir=/lib \
 		--enable-capng \
-		--enable-attrib \
 		--enable-gatt-example \
 		--enable-health \
 		--enable-tracer \
-- 
1.7.0.4

