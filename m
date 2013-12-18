Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ] build: Add coverage support
Date: Wed, 18 Dec 2013 15:09:22 +0200
Message-Id: <1387372162-7096-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Coverage is enabled with --enable-maintainer-mode, 2 new targets are
added 'coverage' and 'clean-coverage', the first generate the reports
using lcov and depend on the second to cleanup previous generated
reports and .gcda files.
---
 .gitignore   |  4 ++++
 Makefile.am  | 18 ++++++++++++++++++
 acinclude.m4 |  4 ++++
 configure.ac |  4 ++++
 4 files changed, 30 insertions(+)

diff --git a/.gitignore b/.gitignore
index c570728..21dbe26 100644
--- a/.gitignore
+++ b/.gitignore
@@ -3,6 +3,8 @@
 *.lo
 *.la
 *.so
+*.gcno
+*.gcda
 .deps
 .libs
 .dirstamp
@@ -27,7 +29,9 @@ stamp-h1
 autom4te.cache
 test-driver
 test-suite.log
+coverage.info
 
+coverage
 lib/bluez.pc
 lib/bluetooth
 src/builtin.h
diff --git a/Makefile.am b/Makefile.am
index 15cc149..7380e61 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -331,5 +331,23 @@ lib/bluetooth/%.h: lib/%.h
 	$(AM_V_at)$(MKDIR_P) lib/bluetooth
 	$(AM_V_GEN)$(LN_S) -f "$(abs_top_builddir)"/$< $@
 
+if MAINTAINER_MODE
+clean-coverage:
+	-find $(top_builddir) -name "*.gcda" -delete
+	@lcov --directory $(top_builddir) --zerocounters
+	$(RM) -r coverage $(top_builddir)/coverage.info
+
+coverage: clean-coverage check
+	@lcov --compat-libtool --directory $(top_builddir) --capture \
+				--output-file $(top_builddir)/coverage.info
+	$(AM_V_at)$(MKDIR_P) coverage
+	@genhtml -o coverage/ $(top_builddir)/coverage.info
+
+clean-local: clean-coverage
+	-find $(top_builddir) -name "*.gcno" -delete
+	$(RM) -r lib/bluetooth
+
+else
 clean-local:
 	$(RM) -r lib/bluetooth
+endif
diff --git a/acinclude.m4 b/acinclude.m4
index 2065852..afc7c6d 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -51,6 +51,10 @@ AC_DEFUN([MISC_FLAGS], [
 			misc_ldflags="$misc_ldflags -pie"
 		fi
 	])
+	if (test "$USE_MAINTAINER_MODE" = "yes"); then
+		misc_cflags="$misc_cflags --coverage"
+		misc_ldflags="$misc_ldflags --coverage"
+	fi
 	AC_SUBST([MISC_CFLAGS], $misc_cflags)
 	AC_SUBST([MISC_LDFLAGS], $misc_ldflags)
 ])
diff --git a/configure.ac b/configure.ac
index 18d0b55..4f36355 100644
--- a/configure.ac
+++ b/configure.ac
@@ -252,4 +252,8 @@ AC_ARG_ENABLE(android, AC_HELP_STRING([--enable-android],
 					[enable_android=${enableval}])
 AM_CONDITIONAL(ANDROID, test "${enable_android}" = "yes")
 
+if (test "$USE_MAINTAINER_MODE" = "yes"); then
+	AC_CHECK_PROG([LCOV], [lcov], [yes], AC_MSG_ERROR(lcov is required))
+fi
+
 AC_OUTPUT(Makefile src/bluetoothd.8 lib/bluez.pc)
-- 
1.8.3.1

