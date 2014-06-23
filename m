Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 3/3] android/client: Fix coding style
Date: Mon, 23 Jun 2014 15:00:25 +0300
Message-Id: <1403524825-7656-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1403524825-7656-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1403524825-7656-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-hl.c | 10 +++++-----
 android/client/if-rc.c |  8 ++++----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/android/client/if-hl.c b/android/client/if-hl.c
index 5940526..9c00a4d 100644
--- a/android/client/if-hl.c
+++ b/android/client/if-hl.c
@@ -15,12 +15,12 @@
  *
  */
 
-#include<stdio.h>
-#include<ctype.h>
-#include<unistd.h>
+#include <stdio.h>
+#include <ctype.h>
+#include <unistd.h>
 
-#include<hardware/bluetooth.h>
-#include<hardware/bt_hl.h>
+#include <hardware/bluetooth.h>
+#include <hardware/bt_hl.h>
 
 #include "if-main.h"
 #include "pollhandler.h"
diff --git a/android/client/if-rc.c b/android/client/if-rc.c
index cdf6311..afd90a3 100644
--- a/android/client/if-rc.c
+++ b/android/client/if-rc.c
@@ -15,11 +15,11 @@
  *
  */
 
-#include<stdio.h>
-#include<ctype.h>
+#include <stdio.h>
+#include <ctype.h>
 
-#include<hardware/bluetooth.h>
-#include<hardware/bt_hh.h>
+#include <hardware/bluetooth.h>
+#include <hardware/bt_hh.h>
 
 #include "if-main.h"
 #include "pollhandler.h"
-- 
1.9.1

