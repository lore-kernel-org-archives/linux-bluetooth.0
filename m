Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Chih-Wei Huang <cwhuang@android-x86.org>
To: linux-bluetooth@vger.kernel.org
Cc: Chih-Wei Huang <cwhuang@linux.org.tw>
Subject: [PATCH 1/3] shared/utils: add the missing header <strings.h>
Date: Wed,  2 Dec 2015 21:19:03 +0800
Message-Id: <1449062345-31502-2-git-send-email-cwhuang@linux.org.tw>
In-Reply-To: <1449062345-31502-1-git-send-email-cwhuang@linux.org.tw>
References: <1449062345-31502-1-git-send-email-cwhuang@linux.org.tw>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It defines the prototype of ffs() that fixes the building errors
of an Android 6.0 64-bit target.

Signed-off-by: Chih-Wei Huang <cwhuang@linux.org.tw>
---
 src/shared/util.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/shared/util.c b/src/shared/util.c
index 7878552..e19b264 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -34,6 +34,7 @@
 #include <dirent.h>
 #include <limits.h>
 #include <string.h>
+#include <strings.h>
 
 #include "src/shared/util.h"
 
-- 
1.9.1

