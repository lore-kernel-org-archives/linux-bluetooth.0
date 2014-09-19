Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 13/13] android/emulator: Fix compilation error with musl
Date: Fri, 19 Sep 2014 16:10:16 +0200
Message-Id: <1411135816-18966-14-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1411135816-18966-1-git-send-email-szymon.janc@tieto.com>
References: <1411135816-18966-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

  CC       android/system-emulator.o
In file included from android/system-emulator.c:35:0:
/usr/include/sys/poll.h:1:2: error: #warning redirecting
   incorrect #include <sys/poll.h> to <poll.h> [-Werror=cpp]
 #warning redirecting incorrect #include <sys/poll.h> to <poll.h>
  ^
android/system-emulator.c: In function 'signal_callback':
android/system-emulator.c:196:18: error: 'WAIT_ANY' undeclared
   (first use in this function)
    pid = waitpid(WAIT_ANY, &status, WNOHANG);
                  ^
android/system-emulator.c:196:18: note: each undeclared identifier is reported only once for each function it appears in
cc1: all warnings being treated as errors
---
 android/system-emulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/system-emulator.c b/android/system-emulator.c
index 4adc109..71e4d9e 100644
--- a/android/system-emulator.c
+++ b/android/system-emulator.c
@@ -32,7 +32,7 @@
 #include <signal.h>
 #include <string.h>
 #include <libgen.h>
-#include <sys/poll.h>
+#include <poll.h>
 #include <sys/wait.h>
 #include <sys/param.h>
 #include <sys/socket.h>
@@ -193,7 +193,7 @@ static void signal_callback(int signum, void *user_data)
 			pid_t pid;
 			int status;
 
-			pid = waitpid(WAIT_ANY, &status, WNOHANG);
+			pid = waitpid(-1, &status, WNOHANG);
 			if (pid < 0 || pid == 0)
 				break;
 
-- 
1.9.3

