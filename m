Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 05/13] shared: Fix compilation errors  with musl
Date: Fri, 19 Sep 2014 16:10:08 +0200
Message-Id: <1411135816-18966-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1411135816-18966-1-git-send-email-szymon.janc@tieto.com>
References: <1411135816-18966-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

C       src/shared/hci.o
src/shared/hci.c: In function 'send_command':
src/shared/hci.c:139:2: error: implicit declaration of function
    'writev' [-Werror=implicit-function-declaration]
  if (writev(fd, iov, iovcnt) < 0)
  ^
cc1: all warnings being treated as errors
Makefile:5422: recipe for target 'src/shared/hci.o' failed
make[1]: *** [src/shared/hci.o] Error 1
---
 src/shared/hci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/shared/hci.c b/src/shared/hci.c
index 6d0a5f8..6ce62eb 100644
--- a/src/shared/hci.c
+++ b/src/shared/hci.c
@@ -29,6 +29,7 @@
 #include <unistd.h>
 #include <string.h>
 #include <sys/socket.h>
+#include <sys/uio.h>
 
 #include "monitor/bt.h"
 #include "monitor/mainloop.h"
-- 
1.9.3

