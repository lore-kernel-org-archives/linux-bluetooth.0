Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ] build: Add ax_valgrind_check.m4
Date: Thu, 12 Mar 2015 14:21:18 +0200
Message-Id: <1426162878-19615-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds ax_valgrind_check.m4 which enables checking test with valgrind
tools, for more details see:

http://www.gnu.org/software/autoconf-archive/ax_valgrind_check.html#ax_valgrind_check

How it works:

make check-valgrind
make --no-print-directory -k check-valgrind-tool VALGRIND_TOOL=memcheck;     make --no-print-directory -k check-valgrind-tool VALGRIND_TOOL=helgrind;     make --no-print-directory -k check-valgrind-tool VALGRIND_TOOL=drd;     make --no-print-directory -k check-valgrind-tool VALGRIND_TOOL=sgcheck;
make check-TESTS \
	TESTS_ENVIRONMENT=" env VALGRIND=valgrind G_SLICE=always-malloc,debug-blocks G_DEBUG=fatal-warnings,fatal-criticals,gc-friendly" \
	LOG_COMPILER="/bin/sh ./libtool   --mode=execute valgrind  --error-exitcode=1 --num-callers=30" \
	LOG_FLAGS="--tool=memcheck --leak-check=full --show-reachable=no" \
	TEST_SUITE_LOG=test-suite-memcheck.log
PASS: unit/test-eir
PASS: unit/test-uuid
PASS: unit/test-textfile
PASS: unit/test-crc
FAIL: unit/test-crypto
PASS: android/test-ipc
PASS: unit/test-mgmt
PASS: unit/test-uhid
PASS: unit/test-avctp
PASS: unit/test-ringbuf
PASS: unit/test-avdtp
PASS: unit/test-hfp
PASS: unit/test-sdp
PASS: unit/test-gobex-packet
PASS: unit/test-gobex-header
PASS: unit/test-queue
PASS: unit/test-gdbus-client
PASS: unit/test-gobex
PASS: unit/test-lib
PASS: unit/test-avrcp
PASS: unit/test-gobex-apparam
FAIL: unit/test-gattrib
FAIL: unit/test-gatt
PASS: unit/test-gobex-transfer
PASS: unit/test-ecc
make --no-print-directory all-am
============================================================================
Testsuite summary for bluez 5.29
============================================================================
============================================================================
See ./test-suite-memcheck.log
============================================================================
Makefile:8212: recipe for target 'test-suite-memcheck.log' failed
make[3]: *** [test-suite-memcheck.log] Error 1
Makefile:8318: recipe for target 'check-TESTS' failed
make[2]: *** [check-TESTS] Error 2
Makefile:9057: recipe for target 'check-valgrind-tool' failed
make[1]: *** [check-valgrind-tool] Error 2
make check-TESTS \
	TESTS_ENVIRONMENT=" env VALGRIND=valgrind G_SLICE=always-malloc,debug-blocks G_DEBUG=fatal-warnings,fatal-criticals,gc-friendly" \
	LOG_COMPILER="/bin/sh ./libtool   --mode=execute valgrind  --error-exitcode=1 --num-callers=30" \
	LOG_FLAGS="--tool=helgrind --history-level=approx" \
	TEST_SUITE_LOG=test-suite-helgrind.log
PASS: unit/test-eir
PASS: unit/test-uuid
PASS: android/test-ipc
PASS: unit/test-mgmt
PASS: unit/test-uhid
PASS: unit/test-crypto
PASS: unit/test-ringbuf
PASS: unit/test-queue
PASS: unit/test-avctp
PASS: unit/test-hfp
FAIL: unit/test-gdbus-client
PASS: unit/test-avrcp
PASS: unit/test-gobex-header
PASS: unit/test-gobex-packet
PASS: unit/test-gobex
PASS: unit/test-gobex-apparam
PASS: unit/test-lib
PASS: unit/test-gatt
PASS: unit/test-gobex-transfer
PASS: unit/test-gattrib
PASS: unit/test-avdtp
PASS: unit/test-sdp
PASS: unit/test-crc
PASS: unit/test-textfile
PASS: unit/test-ecc
make --no-print-directory all-am
============================================================================
Testsuite summary for bluez 5.29
============================================================================
============================================================================
See ./test-suite-helgrind.log
============================================================================
Makefile:8212: recipe for target 'test-suite-helgrind.log' failed
make[3]: *** [test-suite-helgrind.log] Error 1
Makefile:8318: recipe for target 'check-TESTS' failed
make[2]: *** [check-TESTS] Error 2
Makefile:9057: recipe for target 'check-valgrind-tool' failed
make[1]: *** [check-valgrind-tool] Error 2
make check-TESTS \
	TESTS_ENVIRONMENT=" env VALGRIND=valgrind G_SLICE=always-malloc,debug-blocks G_DEBUG=fatal-warnings,fatal-criticals,gc-friendly" \
	LOG_COMPILER="/bin/sh ./libtool   --mode=execute valgrind  --error-exitcode=1 --num-callers=30" \
	LOG_FLAGS="--tool=drd " \
	TEST_SUITE_LOG=test-suite-drd.log
PASS: unit/test-eir
PASS: android/test-ipc
PASS: unit/test-ringbuf
PASS: unit/test-mgmt
PASS: unit/test-uhid
PASS: unit/test-queue
PASS: unit/test-sdp
PASS: unit/test-crypto
PASS: unit/test-avctp
PASS: unit/test-hfp
PASS: unit/test-avdtp
PASS: unit/test-gobex-header
PASS: unit/test-gobex-packet
PASS: unit/test-gdbus-client
PASS: unit/test-gobex
PASS: unit/test-gobex-apparam
PASS: unit/test-avrcp
PASS: unit/test-lib
PASS: unit/test-gattrib
PASS: unit/test-gatt
PASS: unit/test-gobex-transfer
PASS: unit/test-ecc
PASS: unit/test-crc
PASS: unit/test-textfile
PASS: unit/test-uuid
make --no-print-directory all-am
============================================================================
Testsuite summary for bluez 5.29
============================================================================
============================================================================
make check-TESTS \
	TESTS_ENVIRONMENT=" env VALGRIND=valgrind G_SLICE=always-malloc,debug-blocks G_DEBUG=fatal-warnings,fatal-criticals,gc-friendly" \
	LOG_COMPILER="/bin/sh ./libtool   --mode=execute valgrind  --error-exitcode=1 --num-callers=30" \
	LOG_FLAGS="--tool=exp-sgcheck " \
	TEST_SUITE_LOG=test-suite-sgcheck.log
PASS: unit/test-eir
PASS: android/test-ipc
PASS: unit/test-mgmt
PASS: unit/test-ringbuf
PASS: unit/test-uhid
PASS: unit/test-queue
PASS: unit/test-avctp
FAIL: unit/test-avrcp
PASS: unit/test-avdtp
PASS: unit/test-hfp
PASS: unit/test-sdp
PASS: unit/test-gobex-header
PASS: unit/test-gdbus-client
PASS: unit/test-gobex
PASS: unit/test-gobex-packet
FAIL: unit/test-crypto
PASS: unit/test-gobex-transfer
PASS: unit/test-gobex-apparam
PASS: unit/test-lib
PASS: unit/test-crc
PASS: unit/test-gattrib
FAIL: unit/test-textfile
PASS: unit/test-uuid
FAIL: unit/test-gatt
PASS: unit/test-ecc
make --no-print-directory all-am
============================================================================
Testsuite summary for bluez 5.29
============================================================================
============================================================================
See ./test-suite-sgcheck.log
============================================================================
---
 Makefile.am          |   2 +
 ax_valgrind_check.m4 | 181 +++++++++++++++++++++++++++++++++++++++++++++++++++
 bootstrap-configure  |   1 +
 configure.ac         |   2 +
 4 files changed, 186 insertions(+)
 create mode 100644 ax_valgrind_check.m4

diff --git a/Makefile.am b/Makefile.am
index d0da411..350fa9c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -464,3 +464,5 @@ clean-local:
 	-find $(top_builddir) -name "*.gcda" -delete
 	$(RM) -r lib/bluetooth
 endif
+
+@VALGRIND_CHECK_RULES@
diff --git a/ax_valgrind_check.m4 b/ax_valgrind_check.m4
new file mode 100644
index 0000000..25d5b09
--- /dev/null
+++ b/ax_valgrind_check.m4
@@ -0,0 +1,181 @@
+# ===========================================================================
+#     http://www.gnu.org/software/autoconf-archive/ax_valgrind_check.html
+# ===========================================================================
+#
+# SYNOPSIS
+#
+#   AX_VALGRIND_CHECK()
+#
+# DESCRIPTION
+#
+#   Checks whether Valgrind is present and, if so, allows running `make
+#   check` under a variety of Valgrind tools to check for memory and
+#   threading errors.
+#
+#   Defines VALGRIND_CHECK_RULES which should be substituted in your
+#   Makefile; and $enable_valgrind which can be used in subsequent configure
+#   output. VALGRIND_ENABLED is defined and substituted, and corresponds to
+#   the value of the --enable-valgrind option, which defaults to being
+#   enabled if Valgrind is installed and disabled otherwise.
+#
+#   If unit tests are written using a shell script and automake's
+#   LOG_COMPILER system, the $(VALGRIND) variable can be used within the
+#   shell scripts to enable Valgrind, as described here:
+#
+#     https://www.gnu.org/software/gnulib/manual/html_node/Running-self_002dtests-under-valgrind.html
+#
+#   Usage example:
+#
+#   configure.ac:
+#
+#     AX_VALGRIND_CHECK
+#
+#   Makefile.am:
+#
+#     @VALGRIND_CHECK_RULES@
+#     VALGRIND_SUPPRESSIONS_FILES = my-project.supp
+#     EXTRA_DIST = my-project.supp
+#
+#   This results in a "check-valgrind" rule being added to any Makefile.am
+#   which includes "@VALGRIND_CHECK_RULES@" (assuming the module has been
+#   configured with --enable-valgrind). Running `make check-valgrind` in
+#   that directory will run the module's test suite (`make check`) once for
+#   each of the available Valgrind tools (out of memcheck, helgrind, drd and
+#   sgcheck), and will output results to test-suite-$toolname.log for each.
+#   The target will succeed if there are zero errors and fail otherwise.
+#
+#   The macro supports running with and without libtool.
+#
+# LICENSE
+#
+#   Copyright (c) 2014, 2015 Philip Withnall <philip.withnall@collabora.co.uk>
+#
+#   Copying and distribution of this file, with or without modification, are
+#   permitted in any medium without royalty provided the copyright notice
+#   and this notice are preserved.  This file is offered as-is, without any
+#   warranty.
+
+#serial 3
+
+AC_DEFUN([AX_VALGRIND_CHECK],[
+	dnl Check for --enable-valgrind
+	AC_MSG_CHECKING([whether to enable Valgrind on the unit tests])
+	AC_ARG_ENABLE([valgrind],
+	              [AS_HELP_STRING([--enable-valgrind], [Whether to enable Valgrind on the unit tests])],
+	              [enable_valgrind=$enableval],[enable_valgrind=])
+
+	# Check for Valgrind.
+	AC_CHECK_PROG([VALGRIND],[valgrind],[valgrind])
+
+	AS_IF([test "$enable_valgrind" = "yes" -a "$VALGRIND" = ""],[
+		AC_MSG_ERROR([Could not find valgrind; either install it or reconfigure with --disable-valgrind])
+	])
+	AS_IF([test "$enable_valgrind" != "no"],[enable_valgrind=yes])
+
+	AM_CONDITIONAL([VALGRIND_ENABLED],[test "$enable_valgrind" = "yes"])
+	AC_SUBST([VALGRIND_ENABLED],[$enable_valgrind])
+	AC_MSG_RESULT([$enable_valgrind])
+
+	# Check for Valgrind tools we care about.
+	m4_define([valgrind_tool_list],[[memcheck], [helgrind], [drd], [exp-sgcheck]])
+
+	AS_IF([test "$VALGRIND" != ""],[
+		m4_foreach([vgtool],[valgrind_tool_list],[
+			m4_define([vgtooln],AS_TR_SH(vgtool))
+			m4_define([ax_cv_var],[ax_cv_valgrind_tool_]vgtooln)
+			AC_CACHE_CHECK([for Valgrind tool ]vgtool,ax_cv_var,[
+				ax_cv_var=
+				AS_IF([`$VALGRIND --tool=vgtool --help 2&>/dev/null`],[
+					ax_cv_var="vgtool"
+				])
+			])
+
+			AC_SUBST([VALGRIND_HAVE_TOOL_]vgtooln,[$ax_cv_var])
+		])
+	])
+
+VALGRIND_CHECK_RULES='
+# Valgrind check
+#
+# Optional:
+#  - VALGRIND_SUPPRESSIONS_FILES: Space-separated list of Valgrind suppressions
+#    files to load. (Default: empty)
+#  - VALGRIND_FLAGS: General flags to pass to all Valgrind tools.
+#    (Default: --num-callers=30)
+#  - VALGRIND_$toolname_FLAGS: Flags to pass to Valgrind $toolname (one of:
+#    memcheck, helgrind, drd, sgcheck). (Default: various)
+
+# Optional variables
+VALGRIND_SUPPRESSIONS ?= $(addprefix --suppressions=,$(VALGRIND_SUPPRESSIONS_FILES))
+VALGRIND_FLAGS ?= --num-callers=30
+VALGRIND_memcheck_FLAGS ?= --leak-check=full --show-reachable=no
+VALGRIND_helgrind_FLAGS ?= --history-level=approx
+VALGRIND_drd_FLAGS ?=
+VALGRIND_sgcheck_FLAGS ?=
+
+# Internal use
+valgrind_tools = memcheck helgrind drd sgcheck
+valgrind_log_files = $(addprefix test-suite-,$(addsuffix .log,$(valgrind_tools)))
+
+valgrind_memcheck_flags = --tool=memcheck $(VALGRIND_memcheck_FLAGS)
+valgrind_helgrind_flags = --tool=helgrind $(VALGRIND_helgrind_FLAGS)
+valgrind_drd_flags = --tool=drd $(VALGRIND_drd_FLAGS)
+valgrind_sgcheck_flags = --tool=exp-sgcheck $(VALGRIND_sgcheck_FLAGS)
+
+valgrind_quiet = $(valgrind_quiet_$(V))
+valgrind_quiet_ = $(valgrind_quiet_$(AM_DEFAULT_VERBOSITY))
+valgrind_quiet_0 = --quiet
+
+# Support running with and without libtool.
+ifneq ($(LIBTOOL),)
+valgrind_lt = $(LIBTOOL) $(AM_LIBTOOLFLAGS) $(LIBTOOLFLAGS) --mode=execute
+else
+valgrind_lt =
+endif
+
+# Use recursive makes in order to ignore errors during check
+check-valgrind:
+ifeq ($(VALGRIND_ENABLED),yes)
+	-$(foreach tool,$(valgrind_tools), \
+		$(if $(VALGRIND_HAVE_TOOL_$(tool))$(VALGRIND_HAVE_TOOL_exp_$(tool)), \
+			$(MAKE) $(AM_MAKEFLAGS) -k check-valgrind-tool VALGRIND_TOOL=$(tool); \
+		) \
+	)
+else
+	@echo "Need to reconfigure with --enable-valgrind"
+endif
+
+# Valgrind running
+VALGRIND_TESTS_ENVIRONMENT = \
+	$(TESTS_ENVIRONMENT) \
+	env VALGRIND=$(VALGRIND) \
+	G_SLICE=always-malloc,debug-blocks \
+	G_DEBUG=fatal-warnings,fatal-criticals,gc-friendly
+
+VALGRIND_LOG_COMPILER = \
+	$(valgrind_lt) \
+	$(VALGRIND) $(VALGRIND_SUPPRESSIONS) --error-exitcode=1 $(VALGRIND_FLAGS)
+
+check-valgrind-tool:
+ifeq ($(VALGRIND_ENABLED),yes)
+	$(MAKE) check-TESTS \
+		TESTS_ENVIRONMENT="$(VALGRIND_TESTS_ENVIRONMENT)" \
+		LOG_COMPILER="$(VALGRIND_LOG_COMPILER)" \
+		LOG_FLAGS="$(valgrind_$(VALGRIND_TOOL)_flags)" \
+		TEST_SUITE_LOG=test-suite-$(VALGRIND_TOOL).log
+else
+	@echo "Need to reconfigure with --enable-valgrind"
+endif
+
+DISTCHECK_CONFIGURE_FLAGS ?=
+DISTCHECK_CONFIGURE_FLAGS += --disable-valgrind
+
+MOSTLYCLEANFILES ?=
+MOSTLYCLEANFILES += $(valgrind_log_files)
+
+.PHONY: check-valgrind check-valgrind-tool
+'
+
+	AC_SUBST([VALGRIND_CHECK_RULES])
+	m4_ifdef([_AM_SUBST_NOTMAKE], [_AM_SUBST_NOTMAKE([VALGRIND_CHECK_RULES])])
+])
diff --git a/bootstrap-configure b/bootstrap-configure
index 29cd7bf..b1b2080 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -7,6 +7,7 @@ fi
 ./bootstrap && \
     ./configure --enable-maintainer-mode \
 		--enable-debug \
+		--enable-valgrind \
 		--prefix=/usr \
 		--mandir=/usr/share/man \
 		--sysconfdir=/etc \
diff --git a/configure.ac b/configure.ac
index 68c0ae4..fdc15ce 100644
--- a/configure.ac
+++ b/configure.ac
@@ -37,6 +37,8 @@ if (test "$USE_MAINTAINER_MODE" = "yes"); then
 fi
 AM_CONDITIONAL(COVERAGE, test "${enable_coverage}" = "yes")
 
+AX_VALGRIND_CHECK
+
 MISC_FLAGS
 
 AC_ARG_ENABLE(threads, AC_HELP_STRING([--enable-threads],
-- 
2.1.0

