Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 07/13] core: Fix compilation error with musl
Date: Fri, 19 Sep 2014 16:10:10 +0200
Message-Id: <1411135816-18966-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1411135816-18966-1-git-send-email-szymon.janc@tieto.com>
References: <1411135816-18966-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

  CC       profiles/alert/bluetoothd-server.o
In file included from profiles/alert/server.c:49:0:
./src/textfile.h:24:1: error: unknown type name 'mode_t'
 int create_file(const char *filename, const mode_t mode);
 ^
Makefile:7469: recipe for target 'profiles/alert/bluetoothd-server.o'
   failed
make[1]: *** [profiles/alert/bluetoothd-server.o] Error 1
Makefile:3072: recipe for target 'all' failed
---
 src/systemd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/systemd.c b/src/systemd.c
index f0985d1..cf3da1c 100644
--- a/src/systemd.c
+++ b/src/systemd.c
@@ -30,6 +30,7 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include <stddef.h>
+#include <string.h>
 #include <sys/socket.h>
 #include <sys/un.h>
 
-- 
1.9.3

