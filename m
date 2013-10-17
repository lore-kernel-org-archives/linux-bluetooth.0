Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 2/2] android: Make toool compile on Android 4.2.2
Date: Thu, 17 Oct 2013 11:50:28 +0300
Message-Id: <1381999828-29649-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1381999828-29649-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1381993898-30445-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1381999828-29649-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

On our current target the tools cannot be compiled.
---
 android/Android.mk        |    2 ++
 android/client/if-bt.c    |    4 ++++
 android/client/if-main.h  |    3 +++
 android/client/textconv.c |    2 ++
 4 files changed, 11 insertions(+)

diff --git a/android/Android.mk b/android/Android.mk
index f59afc6..e63add9 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -92,6 +92,8 @@ LOCAL_SRC_FILES := \
 	client/textconv.c \
 	client/if-bt.c \
 
+LOCAL_CFLAGS := -DPLATFORM_SDK_VERSION=$(PLATFORM_SDK_VERSION)
+
 LOCAL_SHARED_LIBRARIES := libhardware
 
 LOCAL_MODULE_TAGS := optional
diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index 90ef732..6aadeef 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -277,7 +277,9 @@ static bt_callbacks_t bt_callbacks = {
 	.acl_state_changed_cb = acl_state_changed_cb,
 	.thread_evt_cb = thread_evt_cb,
 	.dut_mode_recv_cb = dut_mode_recv_cb,
+#if PLATFORM_SDK_VERSION > 17
 	.le_test_mode_cb = le_test_mode_cb
+#endif
 };
 
 static void init_p(int argc, const char **argv)
@@ -577,8 +579,10 @@ static void get_profile_interface_p(int argc, const char **argv)
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
index 9cac7ef..1cebb72 100644
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
index eebad70..f38e368 100644
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
1.7.10.4

