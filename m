Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 5/5] android: Set umask in system-emulator
Date: Thu, 19 Dec 2013 13:38:33 +0100
Message-Id: <1387456713-12794-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1387456713-12794-1-git-send-email-szymon.janc@tieto.com>
References: <1387456713-12794-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will make sure files are created with proper permissions so
Android daemon doesn't have to handle that. On Android umask is
set by init.
---
 android/system-emulator.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/android/system-emulator.c b/android/system-emulator.c
index 24f2741..299de0f 100644
--- a/android/system-emulator.c
+++ b/android/system-emulator.c
@@ -37,6 +37,8 @@
 #include <sys/param.h>
 #include <sys/socket.h>
 #include <sys/un.h>
+#include <sys/types.h>
+#include <sys/stat.h>
 
 #include "monitor/mainloop.h"
 
@@ -169,5 +171,7 @@ int main(int argc, char *argv[])
 
 	mainloop_add_fd(fd, EPOLLIN, system_socket_callback, NULL, NULL);
 
+	umask(0177);
+
 	return mainloop_run();
 }
-- 
1.8.3.2

