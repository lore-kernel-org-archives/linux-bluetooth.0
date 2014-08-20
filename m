Return-Path: <cyrus@holtmann.org>
From: Natanael Copa <ncopa@alpinelinux.org>
To: linux-bluetooth@vger.kernel.org
Cc: Natanael Copa <ncopa@alpinelinux.org>
Subject: [PATCH] shared: include limits.h for PATH_MAX
Date: Wed, 20 Aug 2014 11:17:47 +0200
Message-Id: <1408526267-12159-1-git-send-email-ncopa@alpinelinux.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PATH_MAX is defined in limits.h so include it explicitly.

This fixes the following compile error on musl libc (Alpine Linux):
src/shared/util.c: In function 'util_get_dt':
src/shared/util.c:99:16: error: 'PATH_MAX' undeclared (first use in this function)
  char filename[PATH_MAX];
                ^
---
 src/shared/util.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index 8530440..74ffb08 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -32,6 +32,7 @@
 #include <sys/stat.h>
 #include <unistd.h>
 #include <dirent.h>
+#include <limits.h>
 
 #include "src/shared/util.h"
 
-- 
2.1.0

