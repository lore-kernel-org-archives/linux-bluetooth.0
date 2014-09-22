Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] build: Add coverage support
Date: Mon, 22 Sep 2014 10:37:13 +0300
Message-Id: <1411371433-10414-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Coverage is enabled with --enable-maintainer-mode, 2 new targets are
added 'coverage' and 'clean-coverage', the first generate the reports
using lcov and depend on the second to cleanup previous generated
reports and .gcda files.
---
 .gitignore   |  4 ++++
 Makefile.am  | 17 +++++++++++++++++
 acinclude.m4 |  4 ++++
 configure.ac |  4 ++++
 4 files changed, 29 insertions(+)

diff --git a/.gitignore b/.gitignore
index e22274f..ecd4a3b 100644
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
index 14b4f55..483933d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -409,5 +409,22 @@ lib/bluetooth/%.h: lib/%.h
 	$(AM_V_at)$(MKDIR_P) lib/bluetooth
 	$(AM_V_GEN)$(LN_S) -f "$(abs_top_builddir)"/$< $@
 
+if MAINTAINER_MODE
+clean-coverage:
+	-find $(top_builddir) -name "*.gcno" -delete
+	-find $(top_builddir) -name "*.gcda" -delete
+	@lcov --directory $(top_builddir) --zerocounters
+	$(RM) -r coverage $(top_builddir)/coverage.info
+
+coverage: check
+	@lcov --compat-libtool --directory $(top_builddir) --capture \
+				--output-file $(top_builddir)/coverage.info
+	$(AM_V_at)$(MKDIR_P) coverage
+	@genhtml -o coverage/ $(top_builddir)/coverage.info
+
+clean-local: clean-coverage
+	$(RM) -r lib/bluetooth
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
index 9bdd239..144b8de 100644
--- a/configure.ac
+++ b/configure.ac
@@ -274,4 +274,8 @@ fi
 AC_DEFINE_UNQUOTED(ANDROID_STORAGEDIR, "${storagedir}/android",
 			[Directory for the Android daemon storage files])
 
+if (test "$USE_MAINTAINER_MODE" = "yes"); then
+	AC_CHECK_PROG([LCOV], [lcov], [yes], AC_MSG_ERROR(lcov is required))
+fi
+
 AC_OUTPUT(Makefile src/bluetoothd.8 lib/bluez.pc)
-- 
1.9.3

