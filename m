Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 1/2] build: Fix --disable-optimization configure option
Date: Tue,  8 Jan 2013 11:46:26 -0400
Message-Id: <1357659987-4219-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On commit cc9e4e7cae0379864ea06038d92bf7ecc192bba7, this flag was
mistakenly replaced with the behavior of the old --enable-fortify
option.

This patch restores the "-O0" flag when --disable-optimization is used.

Unfortunately, this is not enough to disable build optimization. By
default, autoconf adds -O2 to CFLAGS if the compiler is GCC. AM_CFLAGS
(where -O0 is added with --disable-optimization) is passed as argument
to GCC before autoconf CFLAGS, so it is not possible to override the
default -O2. One solution is to use:

CFLAGS= ./configure --disable-optimization

i.e. remove -O2 from CFLAGS, and let autoconf add -O0.
---
 acinclude.m4 |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/acinclude.m4 b/acinclude.m4
index 4357c00..286340d 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -32,7 +32,7 @@ AC_DEFUN([MISC_FLAGS], [
 	AC_ARG_ENABLE(optimization, AC_HELP_STRING([--disable-optimization],
 			[disable code optimization through compiler]), [
 		if (test "${enableval}" = "no"); then
-			misc_cflags="$misc_cflags -D_FORTIFY_SOURCE=2"
+			misc_cflags="$misc_cflags -O0"
 		fi
 	])
 	AC_ARG_ENABLE(debug, AC_HELP_STRING([--enable-debug],
-- 
1.7.9.5

