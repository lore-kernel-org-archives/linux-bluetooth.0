Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] build: Fix requiring ell
Date: Thu, 17 May 2018 11:24:45 +0300
Message-Id: <20180517082445.11006-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Make sure libshared-ell is only build if ell is available.
---
 Makefile.am  | 6 ++++--
 configure.ac | 5 +++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 322706fad..27b6027d5 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -95,8 +95,7 @@ gdbus_libgdbus_internal_la_SOURCES = gdbus/gdbus.h \
 				gdbus/mainloop.c gdbus/watch.c \
 				gdbus/object.c gdbus/client.c gdbus/polkit.c
 
-noinst_LTLIBRARIES += src/libshared-glib.la src/libshared-mainloop.la \
-				src/libshared-ell.la
+noinst_LTLIBRARIES += src/libshared-glib.la src/libshared-mainloop.la
 
 shared_sources = src/shared/io.h src/shared/timeout.h \
 			src/shared/queue.h src/shared/queue.c \
@@ -136,8 +135,11 @@ src_libshared_mainloop_la_SOURCES = $(shared_sources) \
 				src/shared/timeout-mainloop.c \
 				src/shared/mainloop.h src/shared/mainloop.c
 
+if ELL
 src_libshared_ell_la_SOURCES = $(shared_sources) \
 				src/shared/io-ell.c
+noinst_LTLIBRARIES += src/libshared-ell.la
+endif
 
 attrib_sources = attrib/att.h attrib/att-database.h attrib/att.c \
 		attrib/gatt.h attrib/gatt.c \
diff --git a/configure.ac b/configure.ac
index 5132131f2..1599b72c4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -248,12 +248,13 @@ AC_ARG_ENABLE(btpclient, AC_HELP_STRING([--enable-btpclient],
 		[enable BTP client]), [enable_btpclient=${enableval}])
 AM_CONDITIONAL(BTPCLIENT, test "${enable_btpclient}" = "yes")
 
-if (test "${enable_btpclient}" = "yes"); then
-	PKG_CHECK_MODULES(ELL, ell >= 0.3, dummy=yes,
+if (test "${enable_btpclient}" = "yes" || test "${enable_mesh}"); then
+	PKG_CHECK_MODULES(ELL, ell >= 0.3, enable_ell=yes,
 			  AC_MSG_ERROR(ell library >= 0.3 is required))
 	AC_SUBST(ELL_CFLAGS)
 	AC_SUBST(ELL_LIBS)
 fi
+AM_CONDITIONAL(ELL, test "${enable_ell}" != "no")
 
 AC_ARG_ENABLE(client, AC_HELP_STRING([--disable-client],
 		[disable command line client]), [enable_client=${enableval}])
-- 
2.14.3

