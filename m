Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A711BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Dec 2021 23:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbhLTX71 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Dec 2021 18:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbhLTX70 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Dec 2021 18:59:26 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E85BC061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Dec 2021 15:59:26 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id v13so10114202pfi.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Dec 2021 15:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9gioiTWwalIa5OF/HF4UybI9NBTE5c0RS3SWUdaQliA=;
        b=p0SyZh7GJrQmbK7ojjoz/R6f+eL116ySJKK96AkvkoAcMAYHr3NfuQWrKOZZXmc0Sa
         W1c2y+lYxDKUyaniPf6hd0Bnl4F4dk2QgbjBjNHL01LZfohnxEeFEzjaY7MFnW/d9jh6
         7W/ui2Yp74iNeSiPJs0zFShWA4bZLNH6F8YYWy5rjkORfvLY/7QOB7FzAEYmhVBxf2YF
         X4Qpl/yvJ0qpvmlZG9q5ro8fOo31Tt6OcpBgO8bGS6V1ojAGKZU1dByUv8+CM5IMHVGV
         4Hy8irBT2hPsf35Nx3pAHb/RMrO2xedSBIePbzVB+s/7tqgKno0SqmGquk44rrbIZVgq
         aacA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9gioiTWwalIa5OF/HF4UybI9NBTE5c0RS3SWUdaQliA=;
        b=CWeklg/LPKZic+A/pIHLWE6SpijDQ34oCucNX3Mn1Nzg5zdGsNEjJRO8JMm9Bnl6UH
         zTB3r0K1dUPwMa0JWgcwIm/zuHU4Z10HmmKJRzJeUz5d8mN8PVLarOCRsKIRkroWf3Vn
         cx17NNfodXnjpbDeThwogmvMyGz/Apyn09dOKUq0aAKJnVkwbJJNonk9zYEPt0l7PAel
         oPx/7yODZ+r3fcbVf+toDhqES4z6hcG3+oA0NkUyRjEXJ2eWNeFbaFc6CEHuKf3VgYva
         JQF0EU0ZDVGWXh92v3SprRzjOk3BBzXb2/lK5SU8RWjCNEg3/fXyPQrW/7UmSOQ13AmY
         G6LQ==
X-Gm-Message-State: AOAM53086Pa/FCGbEX62Bmnxso9H3ZY0pqu1eMIqZDlBfz0iSmYeg5vW
        CUuc6QAi7T0WoRXTwbdS0qxvUZueUac=
X-Google-Smtp-Source: ABdhPJz9dpbbGINWrc+DDhf8SgQq122Z3Z5YDOszN9bhw1hyB9z/jrJ4dH7T9JjSwxA+cbNVBFOPKA==
X-Received: by 2002:a65:5c88:: with SMTP id a8mr472218pgt.542.1640044765711;
        Mon, 20 Dec 2021 15:59:25 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x9sm447263pjp.48.2021.12.20.15.59.25
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 15:59:25 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/3] build: Add sanitizer options
Date:   Mon, 20 Dec 2021 15:59:22 -0800
Message-Id: <20211220235924.349373-1-luiz.dentz@gmail.com>
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
 Makefile.am  |  6 +++++
 acinclude.m4 | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 configure.ac |  3 +++
 3 files changed, 84 insertions(+)

diff --git a/Makefile.am b/Makefile.am
index 993168f00..36ff19340 100644
--- a/Makefile.am
+++ b/Makefile.am
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
index 529848357..cf9ede408 100644
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
@@ -53,6 +92,42 @@ AC_DEFUN([MISC_FLAGS], [
 			misc_ldflags="$misc_ldflags -pie -Wl,-z,now"
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
+			misc_ldflags="$misc_ldflags -fsanitize=undefined"
+		fi
+	])
 	if (test "$enable_coverage" = "yes"); then
 		misc_cflags="$misc_cflags --coverage"
 		misc_ldflags="$misc_ldflags --coverage"
diff --git a/configure.ac b/configure.ac
index 2674e30d3..c9a7f40a9 100644
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
 
-- 
2.33.1

