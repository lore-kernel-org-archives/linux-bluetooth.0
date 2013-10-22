Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/5] android/hal: Unify HALs callbacks pointers definition
Date: Tue, 22 Oct 2013 15:24:55 +0200
Message-Id: <1382448299-16887-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Those are not suppose to be modified or used outside of each HAL.
---
 android/hal-av.c        | 2 +-
 android/hal-bluetooth.c | 2 +-
 android/hal-hidhost.c   | 2 +-
 android/hal-pan.c       | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/android/hal-av.c b/android/hal-av.c
index b1c5276..0fe1b74 100644
--- a/android/hal-av.c
+++ b/android/hal-av.c
@@ -21,7 +21,7 @@
 #include "hal-log.h"
 #include "hal.h"
 
-const btav_callbacks_t *cbs = NULL;
+static const btav_callbacks_t *cbs = NULL;
 
 static bool interface_ready(void)
 {
diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 5bad409..2c8a902 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -25,7 +25,7 @@
 #include "hal-msg.h"
 #include "hal-ipc.h"
 
-bt_callbacks_t *bt_hal_cbacks = NULL;
+static const bt_callbacks_t *bt_hal_cbacks = NULL;
 
 static void handle_adapter_state_changed(void *buf)
 {
diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index e1a3e97..f941f2f 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -24,7 +24,7 @@
 #include "hal-msg.h"
 #include "hal-ipc.h"
 
-bthh_callbacks_t *bt_hh_cbacks;
+static const bthh_callbacks_t *bt_hh_cbacks;
 
 static bool interface_ready(void)
 {
diff --git a/android/hal-pan.c b/android/hal-pan.c
index f05a93b..4ca7cbb 100644
--- a/android/hal-pan.c
+++ b/android/hal-pan.c
@@ -21,7 +21,7 @@
 #include "hal-log.h"
 #include "hal.h"
 
-const btpan_callbacks_t *bt_pan_cbacks = NULL;
+static const btpan_callbacks_t *bt_pan_cbacks = NULL;
 
 static bool interface_ready(void)
 {
-- 
1.8.4

