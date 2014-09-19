Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 02/13] lib: Fix compilation error with musl
Date: Fri, 19 Sep 2014 16:10:05 +0200
Message-Id: <1411135816-18966-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1411135816-18966-1-git-send-email-szymon.janc@tieto.com>
References: <1411135816-18966-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

  CC       lib/hci.lo
In file included from lib/hci.c:39:0:
/usr/include/sys/poll.h:1:2: error: #warning redirecting incorrect
   #include <sys/poll.h> to <poll.h> [-Werror=cpp]
 #warning redirecting incorrect #include <sys/poll.h> to <poll.h>
  ^
cc1: all warnings being treated as errors
---
 lib/hci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/hci.c b/lib/hci.c
index 005578a..ce272f6 100644
--- a/lib/hci.c
+++ b/lib/hci.c
@@ -33,10 +33,10 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include <string.h>
+#include <poll.h>
 
 #include <sys/param.h>
 #include <sys/uio.h>
-#include <sys/poll.h>
 #include <sys/types.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
-- 
1.9.3

