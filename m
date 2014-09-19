Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 08/13] obexd: Fix compilation error with musl
Date: Fri, 19 Sep 2014 16:10:11 +0200
Message-Id: <1411135816-18966-9-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1411135816-18966-1-git-send-email-szymon.janc@tieto.com>
References: <1411135816-18966-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

  CC       obexd/plugins/obexd-filesystem.o
In file included from obexd/plugins/filesystem.c:40:0:
/usr/include/wait.h:1:2: error: #warning redirecting incorrect
    #include <wait.h> to <sys/wait.h> [-Werror=cpp]
 #warning redirecting incorrect #include <wait.h> to <sys/wait.h>
  ^
cc1: all warnings being treated as errors
Makefile:6447: recipe for target 'obexd/plugins/obexd-filesystem.o' failed
make[1]: *** [obexd/plugins/obexd-filesystem.o] Error 1
---
 obexd/plugins/filesystem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/obexd/plugins/filesystem.c b/obexd/plugins/filesystem.c
index 1132a34..98281f2 100644
--- a/obexd/plugins/filesystem.c
+++ b/obexd/plugins/filesystem.c
@@ -37,7 +37,7 @@
 #include <sys/statvfs.h>
 #include <sys/sendfile.h>
 #include <fcntl.h>
-#include <wait.h>
+#include <sys/wait.h>
 #include <inttypes.h>
 
 #include <glib.h>
-- 
1.9.3

