Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7E9C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Dec 2021 23:42:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241033AbhLVXmH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Dec 2021 18:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhLVXmH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Dec 2021 18:42:07 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143C0C061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Dec 2021 15:42:07 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id 205so3716427pfu.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Dec 2021 15:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t8oC9xYdCyKFmFG3FG69bNAWwzuoyCTQ4q3t0DlzqUk=;
        b=JQdCywv9gwXQN5Vpfl10TxbCp+7fCWtsifVk1VFgjUK97DJn3KbYmjj0kjjGdLprZZ
         Xkzah5s/yvGFDiZMZYiv7DdwlvxIoyqXAiQ3Wv0HpiN6XXcOPKx1qcW8h6E+LNBMnZ3F
         jIob97AMmDsg5yeKeABwDVIt2zfTJrknSykbwJUtvuCeahPHLvlnsAx3Mm2uJK1E19px
         BdQs/y/Fj6U2eL74hNj2z9L9ONXjodnNxnjxidzjtrFH+h7Zl0ZIdk7Y2Iur6powlWeF
         fGpTwuP2OEua2FYFkEt0HUQOHpBg9Ew2MfkXI8ya0ZP1BVkk9KFjQwJx39/QvwYfVF5x
         N7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t8oC9xYdCyKFmFG3FG69bNAWwzuoyCTQ4q3t0DlzqUk=;
        b=I5Zlz61LDTd/3Z9+gAcsU0HxqhrVBJS/4Id+yf4vxkb/+7wApPylV+z0D0J3zrGMHE
         H9q6+TU1wlxFZCyxwltHL155HgKUZrPq/MfBwhhJl8vpiWr268RbxHlVT+wSLEhzMaYl
         GMgiw8PjJI8LcYn9ad+TNXZn/FH3pv8piDVU+Fwn26VRe0q9XyoeVh3aHLAsu+lvJPcI
         7Ck1RCeeNHQPeMTxxnhGleqleBv0IvV6HiE24Sdf7PgIi2KGhBYTrcqLmzsE1LMpd1MH
         fiCm8QCTwpH0qUQY1DLzXaCph70AaJ2cMARgTptrXaEvjc7l5oPumixjNh60KSIrX/rl
         8nXg==
X-Gm-Message-State: AOAM531IE1mVlTz7+yxfRu/aHvFcuVDjGWl+ExkSEUPuj/Rgr+kcJCRK
        4zIiYeAdfjPyqQ/lJxGpcHSawqgWgWY=
X-Google-Smtp-Source: ABdhPJx11cGrmcat/yLpUlav+JzDK8SZov/Bypoe4MIYR9tDsHNUgAEaxM95J9wiQ1Hkpovm7Yi0LQ==
X-Received: by 2002:a63:1349:: with SMTP id 9mr4562489pgt.379.1640216526169;
        Wed, 22 Dec 2021 15:42:06 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id r10sm3563666pff.120.2021.12.22.15.42.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 15:42:05 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/4] build: Add sanitizer options
Date:   Wed, 22 Dec 2021 15:42:01 -0800
Message-Id: <20211222234204.1455901-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Build using Address Sanitizer (asan), Leak Sanitizer (lsan), or
Undefined Behavior Sanitizer (ubsan) by using one of these options for
the configure script:

  --enable-asan
  --enable-lsan
  --enable-ubsan

For each of these to work, the compiler must support the requested
sanitizer and the requisite libraries must be installed (libasan,
liblsan, libubsan).
---
v2: Attempt to fix CI findings
v3: Yet again attempt to fix CI findings, disable running tests with
valgrind if either asan or lsan are enabled are they are likely going
to conflict.

 Makefile.am  |  8 +++++-
 acinclude.m4 | 77 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 configure.ac |  7 ++++-
 3 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 993168f00..308f13c50 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -24,7 +24,7 @@ pkgincludedir = $(includedir)/bluetooth
 
 pkginclude_HEADERS =
 
-AM_CFLAGS = $(WARNING_CFLAGS) $(MISC_CFLAGS) $(UDEV_CFLAGS) $(LIBEBOOK_CFLAGS) \
+AM_CFLAGS = $(MISC_CFLAGS) $(WARNING_CFLAGS) $(UDEV_CFLAGS) $(LIBEBOOK_CFLAGS) \
 				$(LIBEDATASERVER_CFLAGS) $(ell_cflags)
 AM_LDFLAGS = $(MISC_LDFLAGS)
 
@@ -243,6 +243,8 @@ src_libshared_glib_la_SOURCES = $(shared_sources) \
 				src/shared/mainloop-notify.h \
 				src/shared/mainloop-notify.c \
 				src/shared/tester.c
+src_libshared_glib_la_LDFLAGS = $(AM_LDFLAGS)
+src_libshared_glib_la_CFLAGS = $(AM_CFLAGS)
 
 src_libshared_mainloop_la_SOURCES = $(shared_sources) \
 				src/shared/io-mainloop.c \
@@ -250,6 +252,8 @@ src_libshared_mainloop_la_SOURCES = $(shared_sources) \
 				src/shared/mainloop.h src/shared/mainloop.c \
 				src/shared/mainloop-notify.h \
 				src/shared/mainloop-notify.c
+src_libshared_mainloop_la_LDFLAGS = $(AM_LDFLAGS)
+src_libshared_mainloop_la_CFLAGS = $(AM_CFLAGS)
 
 if LIBSHARED_ELL
 src_libshared_ell_la_SOURCES = $(shared_sources) \
@@ -257,6 +261,8 @@ src_libshared_ell_la_SOURCES = $(shared_sources) \
 				src/shared/timeout-ell.c \
 				src/shared/mainloop.h \
 				src/shared/mainloop-ell.c
+src_libshared_ell_la_LDFLAGS = $(AM_LDFLAGS)
+src_libshared_ell_la_CFLAGS = $(AM_CFLAGS)
 endif
 
 attrib_sources = attrib/att.h attrib/att-database.h attrib/att.c \
diff --git a/acinclude.m4 b/acinclude.m4
index 529848357..b388dfc11 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -10,6 +10,45 @@ AC_DEFUN([AC_PROG_CC_PIE], [
 	])
 ])
 
+AC_DEFUN([AC_PROG_CC_ASAN], [
+	AC_CACHE_CHECK([whether ${CC-cc} accepts -fsanitize=address],
+						ac_cv_prog_cc_asan, [
+		echo 'void f(){}' > asan.c
+		if test -z "`${CC-cc} -fsanitize=address -c asan.c 2>&1`"; then
+			ac_cv_prog_cc_asan=yes
+		else
+			ac_cv_prog_cc_asan=no
+		fi
+		rm -rf asan*
+       ])
+])
+
+AC_DEFUN([AC_PROG_CC_LSAN], [
+	AC_CACHE_CHECK([whether ${CC-cc} accepts -fsanitize=leak],
+						ac_cv_prog_cc_lsan, [
+		echo 'void f(){}' > lsan.c
+		if test -z "`${CC-cc} -fsanitize=leak -c lsan.c 2>&1`"; then
+			ac_cv_prog_cc_lsan=yes
+		else
+			ac_cv_prog_cc_lsan=no
+		fi
+		rm -rf lsan*
+	])
+])
+
+AC_DEFUN([AC_PROG_CC_UBSAN], [
+	AC_CACHE_CHECK([whether ${CC-cc} accepts -fsanitize=undefined],
+						ac_cv_prog_cc_ubsan, [
+		echo 'void f(){}' > ubsan.c
+		if test -z "`${CC-cc} -fsanitize=undefined -c ubsan.c 2>&1`"; then
+			ac_cv_prog_cc_ubsan=yes
+		else
+			ac_cv_prog_cc_ubsan=no
+		fi
+		rm -rf ubsan*
+	])
+])
+
 AC_DEFUN([COMPILER_FLAGS], [
 	with_cflags=""
 	if (test "$USE_MAINTAINER_MODE" = "yes"); then
@@ -38,6 +77,44 @@ AC_DEFUN([MISC_FLAGS], [
 			misc_cflags="$misc_cflags -O0"
 		fi
 	])
+	AC_ARG_ENABLE(asan, AC_HELP_STRING([--enable-asan],
+			[enable linking with address sanitizer]), [
+		save_LIBS=$LIBS
+		AC_CHECK_LIB(asan, _init)
+		LIBS=$save_LIBS
+		if (test "${enableval}" = "yes" &&
+				test "${ac_cv_lib_asan__init}" = "yes" &&
+				test "${ac_cv_prog_cc_asan}" = "yes"); then
+			misc_cflags="$misc_cflags -fsanitize=address";
+			misc_ldflags="$misc_ldflags -fsanitize=address"
+			AC_SUBST([ASAN_LIB], ${ac_cv_lib_asan__init})
+		fi
+	])
+	AC_ARG_ENABLE(lsan, AC_HELP_STRING([--enable-lsan],
+			[enable linking with address sanitizer]), [
+		save_LIBS=$LIBS
+		AC_CHECK_LIB(lsan, _init)
+		LIBS=$save_LIBS
+		if (test "${enableval}" = "yes" &&
+				test "${ac_cv_lib_lsan__init}" = "yes" &&
+				test "${ac_cv_prog_cc_lsan}" = "yes"); then
+			misc_cflags="$misc_cflags -fsanitize=leak";
+			misc_ldflags="$misc_ldflags -fsanitize=leak"
+			AC_SUBST([ASAN_LIB], ${ac_cv_lib_lsan__init})
+		fi
+	])
+	AC_ARG_ENABLE(ubsan, AC_HELP_STRING([--enable-ubsan],
+			[enable linking with address sanitizer]), [
+		save_LIBS=$LIBS
+		AC_CHECK_LIB(ubsan, _init)
+		LIBS=$save_LIBS
+		if (test "${enableval}" = "yes" &&
+				test "${ac_cv_lib_ubsan__init}" = "yes" &&
+				test "${ac_cv_prog_cc_ubsan}" = "yes"); then
+			misc_cflags="$misc_cflags -fsanitize=undefined";
+			misc_ldflags="$misc_ldflags -fsanitize=undefined";
+		fi
+	])
 	AC_ARG_ENABLE(debug, AC_HELP_STRING([--enable-debug],
 			[enable compiling with debugging information]), [
 		if (test "${enableval}" = "yes" &&
diff --git a/configure.ac b/configure.ac
index 2674e30d3..849e1db46 100644
--- a/configure.ac
+++ b/configure.ac
@@ -23,6 +23,9 @@ AC_C_RESTRICT
 AC_PROG_CC
 AM_PROG_CC_C_O
 AC_PROG_CC_PIE
+AC_PROG_CC_ASAN
+AC_PROG_CC_LSAN
+AC_PROG_CC_UBSAN
 AC_PROG_INSTALL
 AC_PROG_MKDIR_P
 
@@ -40,10 +43,12 @@ if (test "$USE_MAINTAINER_MODE" = "yes"); then
 fi
 AM_CONDITIONAL(COVERAGE, test "${enable_coverage}" = "yes")
 AM_CONDITIONAL(DBUS_RUN_SESSION, test "${enable_dbus_run_session}" = "yes")
-AM_CONDITIONAL(VALGRIND, test "${enable_valgrind}" = "yes")
 
 MISC_FLAGS
 
+AM_CONDITIONAL(VALGRIND, test "${enable_valgrind}" = "yes" &&
+		test "$ASAN_LIB" != "yes" && test "LSAN_LIB" != "yes")
+
 AC_ARG_ENABLE(threads, AC_HELP_STRING([--enable-threads],
 		[enable threading support]), [enable_threads=${enableval}])
 
-- 
2.33.1

