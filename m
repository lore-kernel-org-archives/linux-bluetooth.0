Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 1/3] android/hal: Make hal.h self contained
Date: Tue, 22 Oct 2013 13:18:21 +0200
Message-Id: <1382440703-21612-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-av.c        | 3 ---
 android/hal-bluetooth.c | 5 -----
 android/hal-hidhost.c   | 3 ---
 android/hal-pan.c       | 3 ---
 android/hal-sock.c      | 3 ---
 android/hal.h           | 1 +
 6 files changed, 1 insertion(+), 17 deletions(-)

diff --git a/android/hal-av.c b/android/hal-av.c
index ef45066..b1c5276 100644
--- a/android/hal-av.c
+++ b/android/hal-av.c
@@ -18,9 +18,6 @@
 #include <stdbool.h>
 #include <stddef.h>
 
-#include <hardware/bluetooth.h>
-#include <hardware/bt_av.h>
-
 #include "hal-log.h"
 #include "hal.h"
 
diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 5b07070..6adf0cb 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -20,11 +20,6 @@
 #include <stdbool.h>
 #include <string.h>
 
-#include <hardware/bluetooth.h>
-#include <hardware/bt_sock.h>
-#include <hardware/bt_hh.h>
-#include <hardware/bt_pan.h>
-
 #include "hal-log.h"
 #include "hal.h"
 #include "hal-msg.h"
diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index 8c47e27..2d5d091 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -18,9 +18,6 @@
 #include <stdbool.h>
 #include <stddef.h>
 
-#include <hardware/bluetooth.h>
-#include <hardware/bt_hh.h>
-
 #include "hal-log.h"
 #include "hal.h"
 
diff --git a/android/hal-pan.c b/android/hal-pan.c
index 645fe8c..f05a93b 100644
--- a/android/hal-pan.c
+++ b/android/hal-pan.c
@@ -18,9 +18,6 @@
 #include <stdbool.h>
 #include <stddef.h>
 
-#include <hardware/bluetooth.h>
-#include <hardware/bt_pan.h>
-
 #include "hal-log.h"
 #include "hal.h"
 
diff --git a/android/hal-sock.c b/android/hal-sock.c
index dab3756..364663c 100644
--- a/android/hal-sock.c
+++ b/android/hal-sock.c
@@ -17,9 +17,6 @@
 
 #include <stdlib.h>
 
-#include <hardware/bluetooth.h>
-#include <hardware/bt_sock.h>
-
 #include "hal-log.h"
 #include "hal.h"
 
diff --git a/android/hal.h b/android/hal.h
index d984336..e3c4122 100644
--- a/android/hal.h
+++ b/android/hal.h
@@ -15,6 +15,7 @@
  *
  */
 
+#include <hardware/bluetooth.h>
 #include <hardware/bt_sock.h>
 #include <hardware/bt_hh.h>
 #include <hardware/bt_pan.h>
-- 
1.8.4

