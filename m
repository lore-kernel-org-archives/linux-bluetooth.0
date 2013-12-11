Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] build: Add coverage support
Date: Wed, 11 Dec 2013 12:55:41 +0200
Message-Id: <1386759341-14346-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 Makefile.am         | 18 ++++++++++++++++++
 acinclude.m4        |  9 +++++++++
 bootstrap-configure |  1 +
 configure.ac        |  2 ++
 4 files changed, 30 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index 15cc149..1a59532 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -331,5 +331,23 @@ lib/bluetooth/%.h: lib/%.h
 	$(AM_V_at)$(MKDIR_P) lib/bluetooth
 	$(AM_V_GEN)$(LN_S) -f "$(abs_top_builddir)"/$< $@
 
+if COVERAGE
+clean-coverage:
+	$(RM) -r coverage
+	@find . -name "*.gcda" -exec $(RM) {} \;
+	$(LCOV) --directory . --zerocounters
+
+check-coverage:
+	@make check
+	$(AM_V_at)$(MKDIR_P) -p coverage
+	$(LCOV) --compat-libtool --directory . --capture --output-file \
+							coverage/check.info
+	@genhtml -o coverage/ coverage/check.info
+
 clean-local:
+	@make clean-coverage
 	$(RM) -r lib/bluetooth
+else
+clean-local:
+	$(RM) -r lib/bluetooth
+endif
diff --git a/acinclude.m4 b/acinclude.m4
index 2065852..e5eb481 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -51,6 +51,15 @@ AC_DEFUN([MISC_FLAGS], [
 			misc_ldflags="$misc_ldflags -pie"
 		fi
 	])
+	AC_ARG_ENABLE(coverage, AC_HELP_STRING([--enable-coverage],
+			[enable coverage flags]), [
+		AC_PATH_PROG([LCOV], [lcov])
+		if (test "$LCOV" && test "${enableval}" = "yes"); then
+			misc_cflags="$misc_cflags -ftest-coverage"
+			misc_cflags="$misc_cflags -fprofile-arcs"
+			misc_ldflags="$misc_ldflags -gcov"
+		fi
+	])
 	AC_SUBST([MISC_CFLAGS], $misc_cflags)
 	AC_SUBST([MISC_LDFLAGS], $misc_ldflags)
 ])
diff --git a/bootstrap-configure b/bootstrap-configure
index c7f08ed..35aa98b 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -14,4 +14,5 @@ fi
 		--enable-experimental \
 		--enable-android \
 		--enable-sixaxis \
+		--enable-coverage \
 		--disable-datafiles $*
diff --git a/configure.ac b/configure.ac
index 18d0b55..c55924f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -252,4 +252,6 @@ AC_ARG_ENABLE(android, AC_HELP_STRING([--enable-android],
 					[enable_android=${enableval}])
 AM_CONDITIONAL(ANDROID, test "${enable_android}" = "yes")
 
+AM_CONDITIONAL([COVERAGE], [test "$LCOV"])
+
 AC_OUTPUT(Makefile src/bluetoothd.8 lib/bluez.pc)
-- 
1.8.3.1

