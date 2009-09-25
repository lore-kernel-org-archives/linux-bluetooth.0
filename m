Return-Path: <cyrus@holtmann.org>
From: Steve Grubb <sgrubb@redhat.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Drop Posix Capabilities
Date: Fri, 25 Sep 2009 16:47:15 -0400
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <200909251647.15440.sgrubb@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

The following patch against the 4.54 codebase drops posix capabilities
after startup so that the bluetooth daemon is less of a threat to the
system should there be any way to compromise it. The retained 
capabilities was compared to selinux policy to make sure that its 
roughly the same. It uses the libcap-ng library which allows patches
for dropping capabilities to be much smaller.

Signed-off-by: Steve Grubb <sgrubb@redhat.com>


diff -urp bluez-4.54.orig/acinclude.m4 bluez-4.54/acinclude.m4
--- bluez-4.54.orig/acinclude.m4	2009-09-25 11:33:47.000000000 -0400
+++ bluez-4.54/acinclude.m4	2009-09-25 16:38:32.000000000 -0400
@@ -352,3 +352,36 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(CONFIGFILES, test "${configfiles_enable}" = "yes")
 	AM_CONDITIONAL(CABLE, test "${cable_enable}" = "yes" && test "${cable_found}" = "yes")
 ])
+
+AC_DEFUN([LIBCAP_NG_PATH],
+[
+	AC_ARG_WITH(libcap-ng,
+	[ --with-libcap-ng=[auto/yes/no]  Add Libcap-ng support
+		[default=auto]],, with_libcap_ng=auto)
+
+	if test x$with_libcap_ng = xno ; then
+		have_libcap_ng=no;
+	else
+		# Start by checking for header file
+		AC_CHECK_HEADER(cap-ng.h, capng_headers=yes, capng_headers=no)
+
+		# See if we have libcap-ng library
+		AC_CHECK_LIB(cap-ng, capng_clear, CAPNG_LDADD=-lcap-ng,)
+
+		# Check results are usable
+		if test x$with_libcap_ng = xyes -a x$CAPNG_LDADD = x ; then
+			AC_MSG_ERROR(libcap-ng support was requested and the library was not found)
+		fi
+		if test x$CAPNG_LDADD != x -a $capng_headers = no ; then
+			AC_MSG_ERROR(libcap-ng libraries found but headers are missing)
+		fi
+	fi
+	AC_SUBST(CAPNG_LDADD)
+	AC_MSG_CHECKING(whether to use libcap-ng)
+	if test x$CAPNG_LDADD != x ; then
+		AC_DEFINE(HAVE_LIBCAP_NG,1,[libcap-ng support])
+		AC_MSG_RESULT(yes)
+	else
+		AC_MSG_RESULT(no)
+	fi
+])
diff -urp bluez-4.54.orig/configure.ac bluez-4.54/configure.ac
--- bluez-4.54.orig/configure.ac	2009-09-25 11:33:47.000000000 -0400
+++ bluez-4.54/configure.ac	2009-09-25 16:38:32.000000000 -0400
@@ -45,6 +45,7 @@ AC_PATH_NETLINK
 AC_PATH_SNDFILE
 
 AC_ARG_BLUEZ
+LIBCAP_NG_PATH
 
 AC_OUTPUT(Makefile scripts/bluetooth.rules doc/version.xml
 					src/bluetoothd.8 bluez.pc)
diff -urp bluez-4.54.orig/Makefile.am bluez-4.54/Makefile.am
--- bluez-4.54.orig/Makefile.am	2009-09-25 11:33:47.000000000 -0400
+++ bluez-4.54/Makefile.am	2009-09-25 16:39:11.000000000 -0400
@@ -200,7 +200,8 @@ src_bluetoothd_SOURCES = $(gdbus_sources
 			src/device.h src/device.c \
 			src/dbus-common.c src/dbus-common.h \
 			src/dbus-hci.h src/dbus-hci.c
-src_bluetoothd_LDADD = lib/libbluetooth.la @GLIB_LIBS@ @DBUS_LIBS@ -ldl
+src_bluetoothd_LDADD = lib/libbluetooth.la @GLIB_LIBS@ @DBUS_LIBS@ \
+				@CAPNG_LDADD@ -ldl
 src_bluetoothd_LDFLAGS = -Wl,--export-dynamic \
 					-Wl,--version-script=src/bluetooth.ver
 src_bluetoothd_DEPENDENCIES = src/bluetooth.ver lib/libbluetooth.la
diff -urp bluez-4.54.orig/src/main.c bluez-4.54/src/main.c
--- bluez-4.54.orig/src/main.c	2009-09-25 11:33:47.000000000 -0400
+++ bluez-4.54/src/main.c	2009-09-25 16:38:32.000000000 -0400
@@ -55,6 +55,9 @@
 #include "dbus-common.h"
 #include "agent.h"
 #include "manager.h"
+#ifdef HAVE_LIBCAP_NG
+#include <cap-ng.h>
+#endif
 
 #define LAST_ADAPTER_EXIT_TIMEOUT 30
 
@@ -343,6 +346,14 @@ int main(int argc, char *argv[])
 	GKeyFile *config;
 
 	init_defaults();
+#ifdef HAVE_LIBCAP_NG
+	/* Drop capabilities */
+	capng_clear(CAPNG_SELECT_BOTH);
+	capng_updatev(CAPNG_ADD, CAPNG_EFFECTIVE|CAPNG_PERMITTED,
+			CAP_NET_BIND_SERVICE, CAP_NET_ADMIN, CAP_NET_RAW,
+			CAP_IPC_LOCK, -1);
+	capng_apply(CAPNG_SELECT_BOTH);
+#endif
 
 	context = g_option_context_new(NULL);
 	g_option_context_add_main_entries(context, options, NULL);
