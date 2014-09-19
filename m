Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 09/13] android/pan: Fix compilation error with musl
Date: Fri, 19 Sep 2014 16:10:12 +0200
Message-Id: <1411135816-18966-10-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1411135816-18966-1-git-send-email-szymon.janc@tieto.com>
References: <1411135816-18966-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

  CC       android/pan.o
android/pan.c: In function 'bridge_if_down':
android/pan.c:153:33: error: 'caddr_t' undeclared
   (first use in this function)
  err = ioctl(sk, SIOCSIFFLAGS, (caddr_t) &ifr);
                                 ^
android/pan.c:153:33: note: each undeclared identifier
   is reported only once for each function it appears in
Makefile:5422: recipe for target 'android/pan.o' failed
make[1]: *** [android/pan.o] Error 1
---
 android/pan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/pan.c b/android/pan.c
index d8572cc..6131890 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -34,6 +34,7 @@
 #include <sys/ioctl.h>
 #include <sys/socket.h>
 #include <sys/wait.h>
+#include <sys/types.h>
 #include <net/if.h>
 #include <linux/sockios.h>
 #include <netinet/in.h>
-- 
1.9.3

