Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] btmon: Fix compiler warnings
Date: Tue,  7 Jan 2014 10:05:46 +0200
Message-Id: <1389081946-28347-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

When building for Android this fixes following warnings:
...
monitor/ellisys.c: In function 'ellisys_inject_hci':
monitor/ellisys.c:159:2: warning: implicit declaration of function 'writev'
[-Wimplicit-function-declaration]
...
---
 monitor/ellisys.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/monitor/ellisys.c b/monitor/ellisys.c
index d21c164..dae690f 100644
--- a/monitor/ellisys.c
+++ b/monitor/ellisys.c
@@ -32,6 +32,7 @@
 #include <time.h>
 #include <sys/time.h>
 #include <sys/socket.h>
+#include <sys/uio.h>
 
 #include <netdb.h>
 #include <arpa/inet.h>
-- 
1.8.3.2

