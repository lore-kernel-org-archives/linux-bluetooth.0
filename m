Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 01/16] Initial support for MCAP
Date: Wed, 28 Jul 2010 10:00:10 +0200
Message-Id: <1280304015-9230-2-git-send-email-sancane@gmail.com>
In-Reply-To: <1280304015-9230-1-git-send-email-sancane@gmail.com>
References: <1280304015-9230-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am       |   12 +++++++++-
 acinclude.m4      |    6 +++++
 health/mcap.c     |   55 +++++++++++++++++++++++++++++++++++++++++++++++
 health/mcap.h     |   38 +++++++++++++++++++++++++++++++++
 health/mcap_lib.h |   61 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 171 insertions(+), 1 deletions(-)
 create mode 100644 health/mcap.c
 create mode 100644 health/mcap.h
 create mode 100644 health/mcap_lib.h

diff --git a/Makefile.am b/Makefile.am
index 65d4312..0781643 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -102,6 +102,7 @@ gdbus_sources = gdbus/gdbus.h gdbus/mainloop.c gdbus/object.c gdbus/watch.c
 builtin_modules =
 builtin_sources =
 builtin_nodist =
+mcap_sources =
 
 if PNATPLUGIN
 builtin_modules += pnat
@@ -168,6 +169,11 @@ builtin_modules += service
 builtin_sources += plugins/service.c
 endif
 
+if MCAP
+mcap_sources += health/mcap_lib.h 	\
+		health/mcap.h health/mcap.c
+endif
+
 builtin_modules += hciops
 builtin_sources += plugins/hciops.c
 
@@ -201,7 +207,8 @@ src_bluetoothd_SOURCES = $(gdbus_sources) $(builtin_sources) \
 			src/adapter.h src/adapter.c \
 			src/device.h src/device.c \
 			src/dbus-common.c src/dbus-common.h \
-			src/dbus-hci.h src/dbus-hci.c
+			src/dbus-hci.h src/dbus-hci.c \
+			$(mcap_sources)
 src_bluetoothd_LDADD = lib/libbluetooth.la @GLIB_LIBS@ @DBUS_LIBS@ \
 							@CAPNG_LIBS@ -ldl
 src_bluetoothd_LDFLAGS = -Wl,--export-dynamic \
@@ -323,6 +330,9 @@ AM_CFLAGS = @DBUS_CFLAGS@ @GLIB_CFLAGS@ @CAPNG_CFLAGS@ \
 INCLUDES = -I$(builddir)/lib -I$(builddir)/src -I$(srcdir)/src \
 			-I$(srcdir)/audio -I$(srcdir)/sbc -I$(srcdir)/gdbus
 
+if MCAP
+INCLUDES += -I$(builddir)/health
+endif
 
 pkgconfigdir = $(libdir)/pkgconfig
 
diff --git a/acinclude.m4 b/acinclude.m4
index f5fdd66..239ccb1 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -167,6 +167,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	serial_enable=yes
 	network_enable=yes
 	service_enable=yes
+	mcap_enable=no
 	pnat_enable=no
 	tracer_enable=no
 	tools_enable=yes
@@ -216,6 +217,10 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		service_enable=${enableval}
 	])
 
+	AC_ARG_ENABLE(mcap, AC_HELP_STRING([--enable-mcap], [enable mcap support]), [
+		mcap_enable=${enableval}
+	])
+
 	AC_ARG_ENABLE(pnat, AC_HELP_STRING([--enable-pnat], [enable pnat plugin]), [
 		pnat_enable=${enableval}
 	])
@@ -330,6 +335,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(SERIALPLUGIN, test "${serial_enable}" = "yes")
 	AM_CONDITIONAL(NETWORKPLUGIN, test "${network_enable}" = "yes")
 	AM_CONDITIONAL(SERVICEPLUGIN, test "${service_enable}" = "yes")
+	AM_CONDITIONAL(MCAP, test "${mcap_enable}" = "yes")
 	AM_CONDITIONAL(ECHOPLUGIN, test "no" = "yes")
 	AM_CONDITIONAL(PNATPLUGIN, test "${pnat_enable}" = "yes")
 	AM_CONDITIONAL(TRACER, test "${tracer_enable}" = "yes")
diff --git a/health/mcap.c b/health/mcap.c
new file mode 100644
index 0000000..c17546b
--- /dev/null
+++ b/health/mcap.c
@@ -0,0 +1,55 @@
+/*
+ *
+ *  MCAP for BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010 GSyC/LibreSoft, Universidad Rey Juan Carlos.
+ *
+ *  Authors:
+ *  Santiago Carot-Nemesio <sancane at gmail.com>
+ *  Jose Antonio Santos-Cadenas <santoscadenas at gmail.com>
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
+#include "log.h"
+#include "error.h"
+
+#include <netinet/in.h>
+#include <stdlib.h>
+#include <errno.h>
+
+#include "mcap.h"
+#include "mcap_lib.h"
+
+struct mcap_instance *mcap_create_instance(struct btd_adapter *btd_adapter,
+					BtIOSecLevel sec,
+					uint16_t ccpsm,
+					uint16_t dcpsm,
+					mcap_mcl_event_cb mcl_connected,
+					mcap_mcl_event_cb mcl_reconnected,
+					mcap_mcl_event_cb mcl_disconnected,
+					mcap_mcl_event_cb mcl_uncached,
+					gpointer user_data,
+					GError **gerr)
+{
+	/* TODO: Create mcap_create_instance */
+	return NULL;
+}
+
+void mcap_release_instance(struct mcap_instance *mi)
+{
+	/* TODO: Create mcap_release_instance */
+}
diff --git a/health/mcap.h b/health/mcap.h
new file mode 100644
index 0000000..c1167fa
--- /dev/null
+++ b/health/mcap.h
@@ -0,0 +1,38 @@
+/*
+ *
+ *  MCAP for BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010 GSyC/LibreSoft, Universidad Rey Juan Carlos.
+ *
+ *  Authors:
+ *  Santiago Carot-Nemesio <sancane at gmail.com>
+ *  Jose Antonio Santos-Cadenas <santoscadenas at gmail.com>
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
+#ifndef __MCAP_H
+#define __MCAP_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __MCAP_H */
diff --git a/health/mcap_lib.h b/health/mcap_lib.h
new file mode 100644
index 0000000..714610e
--- /dev/null
+++ b/health/mcap_lib.h
@@ -0,0 +1,61 @@
+/*
+ *
+ *  MCAP for BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010 GSyC/LibreSoft, Universidad Rey Juan Carlos.
+ *
+ *  Authors:
+ *  Santiago Carot-Nemesio <sancane at gmail.com>
+ *  Jose Antonio Santos-Cadenas <santoscadenas at gmail.com>
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
+#ifndef __MCAP_LIB_H
+#define __MCAP_LIB_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include "adapter.h"
+#include "btio.h"
+#include <bluetooth/l2cap.h>
+
+struct mcap_instance;
+struct mcap_mcl;
+
+typedef void (* mcap_mcl_event_cb) (struct mcap_mcl *mcl, gpointer data);
+
+/* MCAP main operations */
+
+struct mcap_instance *mcap_create_instance(struct btd_adapter *btd_adapter,
+					BtIOSecLevel sec, uint16_t ccpsm,
+					uint16_t dcpsm,
+					mcap_mcl_event_cb mcl_connected,
+					mcap_mcl_event_cb mcl_reconnected,
+					mcap_mcl_event_cb mcl_disconnected,
+					mcap_mcl_event_cb mcl_uncached,
+					gpointer user_data,
+					GError **gerr);
+
+void mcap_release_instance(struct mcap_instance *mi);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __MCAP_LIB_H */
-- 
1.6.3.3

