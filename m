Return-Path: <cyrus@holtmann.org>
From: Natanael Copa <ncopa@alpinelinux.org>
To: linux-bluetooth@vger.kernel.org
Cc: Natanael Copa <ncopa@alpinelinux.org>
Subject: [PATCH] tools: fix headers for bcm43xx
Date: Mon, 21 Apr 2014 14:20:58 +0000
Message-Id: <1398090058-2966-1-git-send-email-ncopa@alpinelinux.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PATH_MAX is defined in limits.h so includ it explicitly.

This fixes the following compile error on musl libc (Alpine Linux):
tools/hciattach_bcm43xx.c: In function 'bcm43xx_locate_patch':
tools/hciattach_bcm43xx.c:313:14: error: 'PATH_MAX' undeclared (first use in this function)
    char path[PATH_MAX];
                  ^

Signed-off-by: Natanael Copa <ncopa@alpinelinux.org>
---
 tools/hciattach_bcm43xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/hciattach_bcm43xx.c b/tools/hciattach_bcm43xx.c
index ad9b239..cb4bfb9 100644
--- a/tools/hciattach_bcm43xx.c
+++ b/tools/hciattach_bcm43xx.c
@@ -34,6 +34,7 @@
 #include <errno.h>
 #include <dirent.h>
 #include <time.h>
+#include <limits.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
-- 
1.9.2

