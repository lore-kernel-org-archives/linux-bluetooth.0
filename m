Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 3/5] android/client: Fix coding style
Date: Mon, 23 Jun 2014 18:06:02 +0300
Message-Id: <1403535964-32644-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1403535964-32644-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1403535964-32644-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/client/if-hl.c | 10 +++++-----
 android/client/if-rc.c |  8 ++++----
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/android/client/if-hl.c b/android/client/if-hl.c
index c6374f1..d27afcc 100644
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

