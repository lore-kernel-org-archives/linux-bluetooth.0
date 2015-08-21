Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] build: Add support for running make check with valgrind
Date: Fri, 21 Aug 2015 16:51:42 +0300
Message-Id: <1440165103-25042-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1440165103-25042-1-git-send-email-luiz.dentz@gmail.com>
References: <1440165103-25042-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This check if valgrind tool is available adding it to be run with make
check.
---
 Makefile.am   |  6 ++++++
 configure.ac  |  3 +++
 valgrind.supp | 14 ++++++++++++++
 3 files changed, 23 insertions(+)
 create mode 100644 valgrind.supp

diff --git a/Makefile.am b/Makefile.am
index 3df694c..90e1209 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -428,6 +428,12 @@ if DBUS_RUN_SESSION
 AM_TESTS_ENVIRONMENT += dbus-run-session --
 endif
 
+if VALGRIND
+LOG_COMPILER = valgrind --error-exitcode=1 --num-callers=30
+LOG_FLAGS = --trace-children=yes --leak-check=full --show-reachable=no \
+		--suppressions=$(srcdir)/valgrind.supp --quiet
+endif
+
 pkgconfigdir = $(libdir)/pkgconfig
 
 if LIBRARY
diff --git a/configure.ac b/configure.ac
index 8ea503c..9b766fc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -35,9 +35,12 @@ AC_PROG_LIBTOOL
 if (test "$USE_MAINTAINER_MODE" = "yes"); then
 	AC_CHECK_PROG(enable_coverage, [lcov], [yes], [no])
 	AC_CHECK_PROG(enable_dbus_run_session, [dbus-run-session], [yes])
+	AC_CHECK_PROG(enable_valgrind, [valgrind], [yes])
+	AC_CHECK_HEADERS(valgrind/memcheck.h)
 fi
 AM_CONDITIONAL(COVERAGE, test "${enable_coverage}" = "yes")
 AM_CONDITIONAL(DBUS_RUN_SESSION, test "${enable_dbus_run_session}" = "yes")
+AM_CONDITIONAL(VALGRIND, test "${enable_dbus_run_session}" = "yes")
 
 MISC_FLAGS
 
diff --git a/valgrind.supp b/valgrind.supp
new file mode 100644
index 0000000..bf28bcd
--- /dev/null
+++ b/valgrind.supp
@@ -0,0 +1,14 @@
+{
+   ecb_bind
+   Memcheck:Param
+   socketcall.bind(my_addr.sa_data)
+   fun:bind
+   fun:ecb_aes_setup
+}
+{
+   cmac_bind
+   Memcheck:Param
+   socketcall.bind(my_addr.sa_data)
+   fun:bind
+   fun:cmac_aes_setup
+}
-- 
2.4.3

