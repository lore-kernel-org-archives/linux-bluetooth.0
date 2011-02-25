Return-Path: <cyrus@holtmann.org>
From: lkslawek@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH] Fix support for shells that do not have "+="
Date: Fri, 25 Feb 2011 13:34:32 +0100
Message-Id: <1298637272-21031-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Slawomir Bochenski <lkslawek@gmail.com>

This will make maintainer mode work on less advanced shells, the ones
that do not support appending.
---
 acinclude.m4 |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/acinclude.m4 b/acinclude.m4
index 329c6a9..ac29c2b 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -15,13 +15,13 @@ AC_DEFUN([COMPILER_FLAGS], [
 		CFLAGS="-Wall -O2 -D_FORTIFY_SOURCE=2"
 	fi
 	if (test "$USE_MAINTAINER_MODE" = "yes"); then
-		CFLAGS+=" -Werror -Wextra"
-		CFLAGS+=" -Wno-unused-parameter"
-		CFLAGS+=" -Wno-missing-field-initializers"
-		CFLAGS+=" -Wdeclaration-after-statement"
-		CFLAGS+=" -Wmissing-declarations"
-		CFLAGS+=" -Wredundant-decls"
-		CFLAGS+=" -Wcast-align"
-		CFLAGS+=" -DG_DISABLE_DEPRECATED"
+		CFLAGS="$CFLAGS -Werror -Wextra"
+		CFLAGS="$CFLAGS -Wno-unused-parameter"
+		CFLAGS="$CFLAGS -Wno-missing-field-initializers"
+		CFLAGS="$CFLAGS -Wdeclaration-after-statement"
+		CFLAGS="$CFLAGS -Wmissing-declarations"
+		CFLAGS="$CFLAGS -Wredundant-decls"
+		CFLAGS="$CFLAGS -Wcast-align"
+		CFLAGS="$CFLAGS -DG_DISABLE_DEPRECATED"
 	fi
 ])
-- 
1.7.1

