Return-Path: <cyrus@holtmann.org>
From: "Dirk-Jan C. Binnema" <djcb.bulk@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: "Dirk-Jan C. Binnema" <djcb@djcbsoftware.nl>
Subject: [PATCH] build: use -lrt for clock_gettime on glibc < 2.17
Date: Fri,  6 Sep 2013 11:09:16 +0300
Message-Id: <1378454956-26605-1-git-send-email-djcb.bulk@gmail.com>
In-Reply-To: <52E3B66B-DC7A-4225-8779-8C1E9B0FC15E@holtmann.org>
References: <52E3B66B-DC7A-4225-8779-8C1E9B0FC15E@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Dirk-Jan C. Binnema" <djcb@djcbsoftware.nl>

glibc before 2.17 (e.g., fedora 18) requires -lrt for clock_gettime;
add -lrt where needed in that case.
---
 Makefile.am  | 2 +-
 configure.ac | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 61daec4..8069af2 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -152,7 +152,7 @@ src_bluetoothd_SOURCES = $(builtin_sources) \
 			src/shared/util.h src/shared/util.c \
 			src/shared/mgmt.h src/shared/mgmt.c
 src_bluetoothd_LDADD = lib/libbluetooth-internal.la gdbus/libgdbus-internal.la \
-			@GLIB_LIBS@ @DBUS_LIBS@ -ldl -lrt
+			@GLIB_LIBS@ @DBUS_LIBS@ @RT_LIBS@ -ldl
 src_bluetoothd_LDFLAGS = $(AM_LDFLAGS) -Wl,--export-dynamic \
 				-Wl,--version-script=$(srcdir)/src/bluetooth.ver
 
diff --git a/configure.ac b/configure.ac
index 050d30d..e7a7b85 100644
--- a/configure.ac
+++ b/configure.ac
@@ -40,8 +40,10 @@ AC_ARG_ENABLE(threads, AC_HELP_STRING([--enable-threads],
 AC_CHECK_FUNC(signalfd, dummy=yes,
 			AC_MSG_ERROR(signalfd support is required))
 
-AC_CHECK_FUNC(clock_gettime, dummy=yes,
-			AC_MSG_ERROR(realtime clock support is required))
+AC_CHECK_FUNC(clock_gettime, [], [
+  AC_CHECK_LIB(rt, clock_gettime, RT_LIBS="-lrt",
+    AC_MSG_ERROR(realtime clock support is required))])
+AC_SUBST(RT_LIBS)
 
 AC_CHECK_LIB(pthread, pthread_create, dummy=yes,
 			AC_MSG_ERROR(posix thread support is required))
-- 
1.8.3.1

