Return-Path: <cyrus@holtmann.org>
From: "Dirk-Jan C. Binnema" <djcb.bulk@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: "Dirk-Jan C. Binnema" <djcb@djcbsoftware.nl>
Subject: [PATCH] build: use -lrt for clock_gettime on glibc < 2.17
Date: Fri,  6 Sep 2013 09:43:37 +0300
Message-Id: <1378449817-575-1-git-send-email-djcb.bulk@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Dirk-Jan C. Binnema" <djcb@djcbsoftware.nl>

glibc before 2.17 (e.g., fedora 18) requires -lrt for clock_gettime.
AC_SEARCH_LIBS adds it to LIBS in that case
---
 configure.ac | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure.ac b/configure.ac
index 050d30d..403e323 100644
--- a/configure.ac
+++ b/configure.ac
@@ -40,6 +40,7 @@ AC_ARG_ENABLE(threads, AC_HELP_STRING([--enable-threads],
 AC_CHECK_FUNC(signalfd, dummy=yes,
 			AC_MSG_ERROR(signalfd support is required))
 
+AC_SEARCH_LIBS(clock_gettime,rt)
 AC_CHECK_FUNC(clock_gettime, dummy=yes,
 			AC_MSG_ERROR(realtime clock support is required))
 
-- 
1.8.3.1

