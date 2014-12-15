Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] build: Fix enabling coverage
Date: Mon, 15 Dec 2014 10:33:48 -0200
Message-Id: <1418646828-15057-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Since MISC_FLAGS now checks for enable_coverage to add --coverage flag
the check for lcov needs happen before before it otherwise make coverage
doesn't work.
---
 configure.ac | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/configure.ac b/configure.ac
index a70d55a..0acd734 100644
--- a/configure.ac
+++ b/configure.ac
@@ -32,6 +32,11 @@ m4_ifdef([AC_LIBTOOL_TAGS], [AC_LIBTOOL_TAGS([])])
 AC_DISABLE_STATIC
 AC_PROG_LIBTOOL
 
+if (test "$USE_MAINTAINER_MODE" = "yes"); then
+	AC_CHECK_PROG(enable_coverage, [lcov], [yes], [no])
+fi
+AM_CONDITIONAL(COVERAGE, test "${enable_coverage}" = "yes")
+
 MISC_FLAGS
 
 AC_ARG_ENABLE(threads, AC_HELP_STRING([--enable-threads],
@@ -274,9 +279,4 @@ fi
 AC_DEFINE_UNQUOTED(ANDROID_STORAGEDIR, "${storagedir}/android",
 			[Directory for the Android daemon storage files])
 
-if (test "$USE_MAINTAINER_MODE" = "yes"); then
-	AC_CHECK_PROG(enable_coverage, [lcov], [yes], [no])
-fi
-AM_CONDITIONAL(COVERAGE, test "${enable_coverage}" = "yes")
-
 AC_OUTPUT(Makefile src/bluetoothd.8 lib/bluez.pc)
-- 
1.9.3

