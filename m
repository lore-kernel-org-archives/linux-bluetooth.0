Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <andrei.emeltchenko@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android: Fix compilation error for Android 4.2.2
Date: Tue, 22 Oct 2013 13:37:08 +0300
Message-Id: <1382438228-23422-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1382436600-8598-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1382436600-8598-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

On our current target the tools cannot be compiled.
---
 android/Android.mk        | 2 ++
 android/client/if-bt.c    | 6 ++++++
 android/client/if-main.h  | 3 +++
 android/client/textconv.c | 2 ++
 4 files changed, 13 insertions(+)

diff --git a/android/Android.mk b/android/Android.mk
index 679c12b..657ab3e 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -84,6 +84,8 @@ LOCAL_SRC_FILES := \
 	client/tabcompletion.c \
 	client/if-bt.c \
 
+LOCAL_CFLAGS := -DPLATFORM_SDK_VERSION=$(PLATFORM_SDK_VERSION)
+
 LOCAL_SHARED_LIBRARIES := libhardware
 
 LOCAL_MODULE_TAGS := optional
diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index 30b41cd..330a3fa 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -364,11 +364,13 @@ static void dut_mode_recv_cb(uint16_t opcode, uint8_t *buf, uint8_t len)
 	haltest_info("%s\n", __func__);
 }
 
+#if PLATFORM_SDK_VERSION > 17
 static void le_test_mode_cb(bt_status_t status, uint16_t num_packets)
 {
 	haltest_info("%s %s %d\n", __func__, bt_state_t2str(status),
 								num_packets);
 }
+#endif
 
 static bt_callbacks_t bt_callbacks = {
 	.size = sizeof(bt_callbacks),
@@ -383,7 +385,9 @@ static bt_callbacks_t bt_callbacks = {
 	.acl_state_changed_cb = acl_state_changed_cb,
 	.thread_evt_cb = thread_evt_cb,
 	.dut_mode_recv_cb = dut_mode_recv_cb,
+#if PLATFORM_SDK_VERSION > 17
 	.le_test_mode_cb = le_test_mode_cb
+#endif
 };
 
 static void init_p(int argc, const char **argv)
@@ -808,8 +812,10 @@ static void get_profile_interface_p(int argc, const char **argv)
 		pif = &dummy; /* TODO: change when if_hh is there */
 	else if (strcmp(BT_PROFILE_PAN_ID, id) == 0)
 		pif = &dummy; /* TODO: change when if_pan is there */
+#if PLATFORM_SDK_VERSION > 17
 	else if (strcmp(BT_PROFILE_AV_RC_ID, id) == 0)
 		pif = &dummy; /* TODO: change when if_rc is there */
+#endif
 	else
 		haltest_error("%s is not correct for get_profile_interface\n",
 		     id);
diff --git a/android/client/if-main.h b/android/client/if-main.h
index 6d2b0cb..5f4a434 100644
--- a/android/client/if-main.h
+++ b/android/client/if-main.h
@@ -35,7 +35,10 @@
 #include <hardware/bt_sock.h>
 #include <hardware/bt_hf.h>
 #include <hardware/bt_hl.h>
+
+#if PLATFORM_SDK_VERSION > 17
 #include <hardware/bt_rc.h>
+#endif
 
 #include "textconv.h"
 
diff --git a/android/client/textconv.c b/android/client/textconv.c
index 3493b1c..cdd443e 100644
--- a/android/client/textconv.c
+++ b/android/client/textconv.c
@@ -94,7 +94,9 @@ INTMAP(bt_property_type_t, -1, "(unknown)")
 	DELEMENT(BT_PROPERTY_ADAPTER_DISCOVERY_TIMEOUT),
 	DELEMENT(BT_PROPERTY_REMOTE_FRIENDLY_NAME),
 	DELEMENT(BT_PROPERTY_REMOTE_RSSI),
+#if PLATFORM_SDK_VERSION > 17
 	DELEMENT(BT_PROPERTY_REMOTE_VERSION_INFO),
+#endif
 	DELEMENT(BT_PROPERTY_REMOTE_DEVICE_TIMESTAMP),
 ENDMAP
 
-- 
1.8.1.2

