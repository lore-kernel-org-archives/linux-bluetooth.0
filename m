Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2] android: Remove temporary BLUEZ_EXTENSION flag
Date: Fri,  7 Nov 2014 11:33:53 +0200
Message-Id: <1415352833-12217-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

BLUEZ_EXTENSION is replaced by ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
check.
---
 android/Android.mk            | 15 +++++++--------
 android/client/haltest.c      |  4 ++--
 android/client/if-bt.c        |  4 ++--
 android/client/if-hf-client.c |  4 ++++
 android/client/if-main.h      |  8 +++++---
 android/client/if-mce.c       |  4 ++++
 android/hal-audio.c           |  1 +
 android/hal-bluetooth.c       |  2 +-
 android/hal-sco.c             |  1 +
 android/hal-utils.h           |  2 --
 android/hal.h                 |  6 ++++--
 11 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/android/Android.mk b/android/Android.mk
index bfdf03f..6b5d51f 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -5,6 +5,10 @@ BLUEZ_VERSION := `grep "^AC_INIT" $(LOCAL_PATH)/bluez/configure.ac | sed -e "s/.
 
 ANDROID_VERSION := `echo $(PLATFORM_VERSION) | awk -F. '{ printf "0x%02d%02d%02d",$$1,$$2,$$3 }'`
 
+ANDROID_VERSION_DEC := `echo $(PLATFORM_VERSION) | awk -F. '{ printf "%02d%02d%02d",$$1,$$2,$$3 }'`
+
+ANDROID_GE_5_0 := $(shell echo $(ANDROID_VERSION_DEC)\>=050000 | bc)
+
 # Specify pathmap for glib and sbc
 pathmap_INCL += glib:external/bluetooth/glib \
 		sbc:external/bluetooth/sbc \
@@ -14,10 +18,6 @@ BLUEZ_COMMON_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\" \
 			-DANDROID_VERSION=$(ANDROID_VERSION) \
 			-DANDROID_STORAGEDIR=\"/data/misc/bluetooth\" \
 
-ifeq ($(BLUEZ_EXTENSIONS), true)
-BLUEZ_COMMON_CFLAGS += -DBLUEZ_EXTENSIONS
-endif
-
 # Enable warnings enabled in autotools build
 BLUEZ_COMMON_CFLAGS += -Wall -Wextra \
 			-Wdeclaration-after-statement \
@@ -134,11 +134,10 @@ LOCAL_SRC_FILES := \
 	bluez/android/hal-utils.c \
 	bluez/android/hal-health.c \
 
-ifeq ($(BLUEZ_EXTENSIONS), true)
+ifeq ($(ANDROID_GE_5_0), 1)
 LOCAL_SRC_FILES += \
 	bluez/android/hal-handsfree-client.c \
-	bluez/android/hal-map-client.c \
-
+	bluez/android/hal-map-client.c
 endif
 
 LOCAL_C_INCLUDES += \
@@ -183,7 +182,7 @@ LOCAL_SRC_FILES := \
 	bluez/android/client/if-gatt.c \
 	bluez/android/hal-utils.c \
 
-ifeq ($(BLUEZ_EXTENSIONS), true)
+ifeq ($(ANDROID_GE_5_0), 1)
 LOCAL_SRC_FILES += \
 	bluez/android/client/if-hf-client.c \
 	bluez/android/client/if-mce.c
diff --git a/android/client/haltest.c b/android/client/haltest.c
index 781e45c..c8cfdc4 100644
--- a/android/client/haltest.c
+++ b/android/client/haltest.c
@@ -48,7 +48,7 @@ const struct interface *interfaces[] = {
 	&pan_if,
 	&hl_if,
 	&sock_if,
-#ifdef BLUEZ_EXTENSIONS
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
 	&hf_client_if,
 	&mce_if,
 #endif
@@ -396,7 +396,7 @@ static void init(void)
 		BT_PROFILE_PAN_ID,
 		BT_PROFILE_GATT_ID,
 		BT_PROFILE_SOCKETS_ID,
-#ifdef BLUEZ_EXTENSIONS
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
 		BT_PROFILE_HANDSFREE_CLIENT_ID,
 		BT_PROFILE_MAP_CLIENT_ID,
 #endif
diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index eef4454..48aff1b 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -757,7 +757,7 @@ static void get_profile_interface_c(int argc, const char **argv,
 		BT_PROFILE_PAN_ID,
 		BT_PROFILE_GATT_ID,
 		BT_PROFILE_AV_RC_ID,
-#ifdef BLUEZ_EXTENSIONS
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
 		BT_PROFILE_HANDSFREE_CLIENT_ID,
 		BT_PROFILE_MAP_CLIENT_ID,
 #endif
@@ -799,7 +799,7 @@ static void get_profile_interface_p(int argc, const char **argv)
 		pif = (const void **) &if_rc;
 	else if (strcmp(BT_PROFILE_GATT_ID, id) == 0)
 		pif = (const void **) &if_gatt;
-#ifdef BLUEZ_EXTENSIONS
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
 	else if (strcmp(BT_PROFILE_HANDSFREE_CLIENT_ID, id) == 0)
 		pif = (const void **) &if_hf_client;
 	else if (strcmp(BT_PROFILE_MAP_CLIENT_ID, id) == 0)
diff --git a/android/client/if-hf-client.c b/android/client/if-hf-client.c
index 3f6f7c2..5783ffe 100644
--- a/android/client/if-hf-client.c
+++ b/android/client/if-hf-client.c
@@ -18,6 +18,8 @@
 #include "if-main.h"
 #include "../hal-utils.h"
 
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+
 const bthf_client_interface_t *if_hf_client = NULL;
 
 static char last_addr[MAX_ADDR_STR_LEN];
@@ -666,3 +668,5 @@ const struct interface hf_client_if = {
 	.name = "handsfree_client",
 	.methods = methods
 };
+
+#endif
diff --git a/android/client/if-main.h b/android/client/if-main.h
index cb5f558..93cc98d 100644
--- a/android/client/if-main.h
+++ b/android/client/if-main.h
@@ -37,7 +37,9 @@
 #include <hardware/bt_hf.h>
 #include <hardware/bt_hl.h>
 
-#ifdef BLUEZ_EXTENSIONS
+#include "hal.h"
+
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
 #include <hardware/bt_hf_client.h>
 #include <hardware/bt_mce.h>
 #endif
@@ -62,7 +64,7 @@ extern const btsock_interface_t *if_sock;
 extern const btgatt_interface_t *if_gatt;
 extern const btgatt_server_interface_t *if_gatt_server;
 extern const btgatt_client_interface_t *if_gatt_client;
-#ifdef BLUEZ_EXTENSIONS
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
 extern const bthf_client_interface_t *if_hf_client;
 extern const btmce_interface_t *if_mce;
 #endif
@@ -89,7 +91,7 @@ extern const struct interface sock_if;
 extern const struct interface hf_if;
 extern const struct interface hh_if;
 extern const struct interface hl_if;
-#ifdef BLUEZ_EXTENSIONS
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
 extern const struct interface hf_client_if;
 extern const struct interface mce_if;
 #endif
diff --git a/android/client/if-mce.c b/android/client/if-mce.c
index 5f101e0..b656328 100644
--- a/android/client/if-mce.c
+++ b/android/client/if-mce.c
@@ -18,6 +18,8 @@
 #include "if-main.h"
 #include "../hal-utils.h"
 
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+
 const btmce_interface_t *if_mce = NULL;
 
 /*
@@ -85,3 +87,5 @@ const struct interface mce_if = {
 	.name = "mce",
 	.methods = methods
 };
+
+#endif
diff --git a/android/hal-audio.c b/android/hal-audio.c
index 1caa4eb..207101f 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -36,6 +36,7 @@
 #include "hal-msg.h"
 #include "hal-audio.h"
 #include "hal-utils.h"
+#include "hal.h"
 
 #define FIXED_A2DP_PLAYBACK_LATENCY_MS 25
 
diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 1599174..9b5ce16 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -865,7 +865,7 @@ static const void *get_profile_interface(const char *profile_id)
 	if (!strcmp(profile_id, BT_PROFILE_HEALTH_ID))
 		return bt_get_health_interface();
 
-#if BLUEZ_EXTENSIONS
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
 	if (!strcmp(profile_id, BT_PROFILE_HANDSFREE_CLIENT_ID))
 		return bt_get_hf_client_interface();
 
diff --git a/android/hal-sco.c b/android/hal-sco.c
index 6c4e975..380b2a8 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -33,6 +33,7 @@
 #include "sco-msg.h"
 #include "ipc-common.h"
 #include "hal-log.h"
+#include "hal.h"
 
 #define AUDIO_STREAM_DEFAULT_RATE	44100
 #define AUDIO_STREAM_SCO_RATE		8000
diff --git a/android/hal-utils.h b/android/hal-utils.h
index ee0320c..9c59948 100644
--- a/android/hal-utils.h
+++ b/android/hal-utils.h
@@ -19,8 +19,6 @@
 
 #include <hardware/bluetooth.h>
 
-#define PLATFORM_VER(a,b,c) ((a << 16) | ( b << 8) | (c))
-
 #define MAX_UUID_STR_LEN	37
 #define HAL_UUID_LEN		16
 #define MAX_ADDR_STR_LEN	18
diff --git a/android/hal.h b/android/hal.h
index 9b41952..a2888f0 100644
--- a/android/hal.h
+++ b/android/hal.h
@@ -27,7 +27,9 @@
 #include <hardware/bt_gatt_server.h>
 #include <hardware/bt_hl.h>
 
-#ifdef BLUEZ_EXTENSIONS
+#define PLATFORM_VER(a,b,c) ((a << 16) | ( b << 8) | (c))
+
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
 #include <hardware/bt_hf_client.h>
 #include <hardware/bt_mce.h>
 #endif
@@ -41,7 +43,7 @@ bthf_interface_t *bt_get_handsfree_interface(void);
 btgatt_interface_t *bt_get_gatt_interface(void);
 bthl_interface_t *bt_get_health_interface(void);
 
-#ifdef BLUEZ_EXTENSIONS
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
 bthf_client_interface_t *bt_get_hf_client_interface(void);
 btmce_interface_t *bt_get_map_client_interface(void);
 #endif
-- 
1.9.1

