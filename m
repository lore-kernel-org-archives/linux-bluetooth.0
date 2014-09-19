Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 06/13] alert: Fix compilation error with musl
Date: Fri, 19 Sep 2014 16:10:09 +0200
Message-Id: <1411135816-18966-7-git-send-email-szymon.janc@tieto.com>
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
 profiles/alert/server.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index 1612d6c..8601bf1 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -31,6 +31,9 @@
 #include <gdbus/gdbus.h>
 #include <glib.h>
 #include <stdlib.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <fcntl.h>
 
 #include "lib/uuid.h"
 #include "src/plugin.h"
-- 
1.9.3

