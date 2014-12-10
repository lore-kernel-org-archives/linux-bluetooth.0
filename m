Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 01/13] build: Add coverage support
Date: Wed, 10 Dec 2014 16:16:58 +0200
Message-Id: <1418221031-4379-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1418221031-4379-1-git-send-email-luiz.dentz@gmail.com>
References: <1418221031-4379-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Coverage is enabled with --enable-maintainer-mode, 2 new targets are
added 'coverage' and 'clean-coverage', the first generate the reports
using lcov and depend on the second to cleanup previous generated
reports and .gcda files.
---
 .gitignore   |  4 ++++
 Makefile.am  | 20 ++++++++++++++++++++
 acinclude.m4 |  4 ++++
 configure.ac |  5 +++++
 4 files changed, 33 insertions(+)

diff --git a/.gitignore b/.gitignore
index 484f41f..a0c9389 100644
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
index c506122..cb42033 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -442,5 +442,25 @@ lib/bluetooth/%.h: lib/%.h
 	$(AM_V_at)$(MKDIR_P) lib/bluetooth
 	$(AM_V_GEN)$(LN_S) -f "$(abs_top_builddir)"/$< $@
 
+if COVERAGE
+clean-coverage:
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
+	-find $(top_builddir) -name "*.gcno" -delete
+	-find $(top_builddir) -name "*.gcda" -delete
+	$(RM) -r lib/bluetooth
+
+else
 clean-local:
+	-find $(top_builddir) -name "*.gcno" -delete
+	-find $(top_builddir) -name "*.gcda" -delete
 	$(RM) -r lib/bluetooth
+endif
diff --git a/acinclude.m4 b/acinclude.m4
index 4c241bf..4cfc80a 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -52,6 +52,10 @@ AC_DEFUN([MISC_FLAGS], [
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
index 6533cab..952914a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -274,4 +274,9 @@ fi
 AC_DEFINE_UNQUOTED(ANDROID_STORAGEDIR, "${storagedir}/android",
 			[Directory for the Android daemon storage files])
 
+if (test "$USE_MAINTAINER_MODE" = "yes"); then
+	AC_CHECK_PROG([LCOV], [lcov], [yes], AC_MSG_ERROR(lcov is required))
+fi
+AM_CONDITIONAL(COVERAGE, test "$LCOV" = "yes")
+
 AC_OUTPUT(Makefile src/bluetoothd.8 lib/bluez.pc)
-- 
1.9.3

