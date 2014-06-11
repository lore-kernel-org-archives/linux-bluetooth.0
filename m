Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 3/3] android: Re-enable support for Android 4.4.2
Date: Wed, 11 Jun 2014 13:31:01 +0200
Message-Id: <1402486261-22488-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1402486261-22488-1-git-send-email-szymon.janc@tieto.com>
References: <1402486261-22488-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Due to very unfortunate change Android 4.4.3-r1.1 BT GATT HAL API is
not backward compatible. This adds support for 4.4.3-r1.1 and 4.4.2.

On android PLATFORM_VERSION is used to determine which API should be
used. On Linux we always build with latest API.
---
 android/Android.mk  |  3 +++
 android/Makefile.am |  3 +++
 android/hal-gatt.c  | 37 ++++++++++++++++++++++++++++++++++++-
 android/hal-utils.h |  2 ++
 4 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/android/Android.mk b/android/Android.mk
index a9a0982..199334f 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -3,12 +3,15 @@ LOCAL_PATH := external/bluetooth
 # Retrieve BlueZ version from configure.ac file
 BLUEZ_VERSION := `grep "^AC_INIT" $(LOCAL_PATH)/bluez/configure.ac | sed -e "s/.*,.\(.*\))/\1/"`
 
+ANDROID_VERSION := `echo $(PLATFORM_VERSION) | awk -F. '{ printf "0x%02d%02d%02d",$$1,$$2,$$3 }'`
+
 # Specify pathmap for glib and sbc
 pathmap_INCL += glib:external/bluetooth/glib \
 		sbc:external/bluetooth/sbc \
 
 # Specify common compiler flags
 BLUEZ_COMMON_CFLAGS := -DVERSION=\"$(BLUEZ_VERSION)\" \
+			-DANDROID_VERSION=$(ANDROID_VERSION) \
 			-DANDROID_STORAGEDIR=\"/data/misc/bluetooth\" \
 
 # Enable warnings enabled in autotools build
diff --git a/android/Makefile.am b/android/Makefile.am
index 3429adb..a9a9e7d 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -1,4 +1,7 @@
 if ANDROID
+
+AM_CFLAGS += -DANDROID_VERSION=0xFFFFFF
+
 android_plugindir = $(abs_top_srcdir)/android/.libs
 
 noinst_PROGRAMS += android/system-emulator
diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index a8f5bd1..043c379 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -971,7 +971,7 @@ static int get_device_type(const bt_bdaddr_t *bd_addr)
 	return dev_type;
 }
 
-static bt_status_t set_adv_data(int server_if, bool set_scan_rsp,
+static bt_status_t set_adv_data_real(int server_if, bool set_scan_rsp,
 				bool include_name, bool include_txpower,
 				int min_interval, int max_interval,
 				int appearance, uint16_t manufacturer_len,
@@ -1025,6 +1025,41 @@ static bt_status_t set_adv_data(int server_if, bool set_scan_rsp,
 						cmd_len, cmd, 0, NULL, NULL);
 }
 
+/*
+ * This is temporary solution and support for older Android versions might
+ * be removed at any time.
+ */
+#if ANDROID_VERSION < PLATFORM_VER(4,4,3)
+static bt_status_t set_adv_data(int server_if, bool set_scan_rsp,
+				bool include_name, bool include_txpower,
+				int min_interval, int max_interval,
+				int appearance, uint16_t manufacturer_len,
+				char *manufacturer_data)
+{
+	return set_adv_data_real(server_if, set_scan_rsp, include_name,
+					include_txpower, min_interval,
+					max_interval, appearance,
+					manufacturer_len, manufacturer_data,
+					0, NULL, 0, NULL);
+}
+#else
+static bt_status_t set_adv_data(int server_if, bool set_scan_rsp,
+				bool include_name, bool include_txpower,
+				int min_interval, int max_interval,
+				int appearance, uint16_t manufacturer_len,
+				char *manufacturer_data,
+				uint16_t service_data_len, char *service_data,
+				uint16_t service_uuid_len, char *service_uuid)
+{
+	return set_adv_data_real(server_if, set_scan_rsp, include_name,
+					include_txpower, min_interval,
+					max_interval, appearance,
+					manufacturer_len, manufacturer_data,
+					service_data_len, service_data,
+					service_uuid_len, service_uuid);
+}
+#endif
+
 static bt_status_t test_command(int command, btgatt_test_params_t *params)
 {
 	struct hal_cmd_gatt_client_test_command cmd;
diff --git a/android/hal-utils.h b/android/hal-utils.h
index 8a1d015..0c994ee 100644
--- a/android/hal-utils.h
+++ b/android/hal-utils.h
@@ -17,6 +17,8 @@
 
 #include <hardware/bluetooth.h>
 
+#define PLATFORM_VER(a,b,c) ((a << 16) | ( b << 8) | c)
+
 #define MAX_UUID_STR_LEN	37
 #define HAL_UUID_LEN		16
 #define MAX_ADDR_STR_LEN	18
-- 
1.9.1

