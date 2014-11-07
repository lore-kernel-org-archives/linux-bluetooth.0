Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android/hal-pan: Update control_state callback to Android 5 API
Date: Fri,  7 Nov 2014 08:46:20 +0100
Message-Id: <1415346380-23275-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Callback declaration was changed in Android 5 so parameters order must
be updated. Android Framework was also updated so we don't need
workaround for it in Android 5.
---
 android/hal-pan.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/android/hal-pan.c b/android/hal-pan.c
index d9e042a..56fd340 100644
--- a/android/hal-pan.c
+++ b/android/hal-pan.c
@@ -19,6 +19,7 @@
 #include <stddef.h>
 #include <string.h>
 
+#include "hal-utils.h"
 #include "hal-log.h"
 #include "hal.h"
 #include "hal-msg.h"
@@ -45,19 +46,25 @@ static void handle_ctrl_state(void *buf, uint16_t len, int fd)
 {
 	struct hal_ev_pan_ctrl_state *ev = buf;
 
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+	if (cbs->control_state_cb)
+		cbs->control_state_cb(ev->state, ev->local_role, ev->status,
+							(char *)ev->name);
+#else
 	/*
-	 * FIXME: Callback declared in bt_pan.h is 'typedef void
+	 * Callback declared in bt_pan.h is 'typedef void
 	 * (*btpan_control_state_callback)(btpan_control_state_t state,
 	 * bt_status_t error, int local_role, const char* ifname);
 	 * But PanService.Java defined it wrong way.
 	 * private void onControlStateChanged(int local_role, int state,
 	 * int error, String ifname).
 	 * First and third parameters are misplaced, so sending data according
-	 * to PanService.Java, fix this if issue fixed in PanService.Java.
+	 * to PanService.Java.
 	 */
 	if (cbs->control_state_cb)
 		cbs->control_state_cb(ev->local_role, ev->state, ev->status,
 							(char *)ev->name);
+#endif
 }
 
 /*
-- 
1.9.3

