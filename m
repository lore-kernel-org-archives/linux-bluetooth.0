Return-Path: <cyrus@holtmann.org>
From: Filippo Giunchedi <filippo@esaurito.net>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] remove _FORTIFY_SOURCE=2 from default CFLAGS
Date: Sat,  4 Jul 2009 10:14:05 +0200
Message-Id: <1246695245-27280-1-git-send-email-filippo@esaurito.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

otherwise --disable-fortify has no effect and the default is
--enable-fortify anyway
---
 acinclude.m4 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/acinclude.m4 b/acinclude.m4
index 479d3cd..47a9453 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -12,7 +12,7 @@ AC_DEFUN([AC_PROG_CC_PIE], [
 
 AC_DEFUN([COMPILER_FLAGS], [
 	if (test "${CFLAGS}" = ""); then
-		CFLAGS="-Wall -O2 -D_FORTIFY_SOURCE=2"
+		CFLAGS="-Wall -O2"
 	fi
 	if (test "$USE_MAINTAINER_MODE" = "yes"); then
 		CFLAGS+=" -Werror -Wextra"
-- 
1.6.3.3

