Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 2/6] android: Use hal-log.h for logging in bluetooth HAL
Date: Sun, 20 Oct 2013 19:45:42 +0200
Message-Id: <1382291146-23518-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382291146-23518-1-git-send-email-szymon.janc@tieto.com>
References: <1382291146-23518-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow to log both on Android and Linux (in haltest).
---
 Makefile.android        |  4 ++-
 android/hal-bluetooth.c | 68 ++++++++++++++++++++++++-------------------------
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/Makefile.android b/Makefile.android
index 244a13b..e9992d9 100644
--- a/Makefile.android
+++ b/Makefile.android
@@ -32,7 +32,9 @@ android_libhal_internal_la_SOURCES = android/hal.h android/hal-bluetooth.c \
 					android/hardware/bt_sock.h \
 					android/hardware/hardware.h \
 					android/cutils/log.h \
-					android/cutils/properties.h
+					android/cutils/properties.h \
+					android/hal-log.h
+
 android_libhal_internal_la_CPPFLAGS = -I$(srcdir)/android
 
 noinst_PROGRAMS += android/haltest
diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index ce64d3b..035bb0f 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -31,9 +31,7 @@
 
 #include <cutils/properties.h>
 
-#define LOG_TAG "BlueZ"
-#include <cutils/log.h>
-
+#include "hal-log.h"
 #include "hal.h"
 #include "hal-msg.h"
 
@@ -63,19 +61,19 @@ static int accept_connection(int sk)
 	err = poll(&pfd, 1, CONNECT_TIMEOUT);
 	if (err < 0) {
 		err = errno;
-		ALOGE("Failed to poll: %d (%s)", err, strerror(err));
+		error("Failed to poll: %d (%s)", err, strerror(err));
 		return -1;
 	}
 
 	if (err == 0) {
-		ALOGE("bluetoothd connect timeout");
+		error("bluetoothd connect timeout");
 		return -1;
 	}
 
 	new_sk = accept(sk, NULL, NULL);
 	if (new_sk < 0) {
 		err = errno;
-		ALOGE("Failed to accept socket: %d (%s)", err, strerror(err));
+		error("Failed to accept socket: %d (%s)", err, strerror(err));
 		return -1;
 	}
 
@@ -91,7 +89,7 @@ static bool start_daemon(void)
 	sk = socket(AF_LOCAL, SOCK_SEQPACKET, 0);
 	if (sk < 0) {
 		err = errno;
-		ALOGE("Failed to create socket: %d (%s)", err,
+		error("Failed to create socket: %d (%s)", err,
 							strerror(err));
 		return false;
 	}
@@ -103,14 +101,14 @@ static bool start_daemon(void)
 
 	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
 		err = errno;
-		ALOGE("Failed to bind socket: %d (%s)", err, strerror(err));
+		error("Failed to bind socket: %d (%s)", err, strerror(err));
 		close(sk);
 		return false;
 	}
 
 	if (listen(sk, 2) < 0) {
 		err = errno;
-		ALOGE("Failed to listen on socket: %d (%s)", err,
+		error("Failed to listen on socket: %d (%s)", err,
 								strerror(err));
 		close(sk);
 		return false;
@@ -133,7 +131,7 @@ static bool start_daemon(void)
 		return false;
 	}
 
-	ALOGI("bluetoothd connected");
+	info("bluetoothd connected");
 
 	close(sk);
 
@@ -151,7 +149,7 @@ static void stop_daemon(void)
 
 static int init(bt_callbacks_t *callbacks)
 {
-	ALOGD(__func__);
+	DBG("");
 
 	if (interface_ready())
 		return BT_STATUS_SUCCESS;
@@ -166,14 +164,14 @@ static int init(bt_callbacks_t *callbacks)
 
 static int enable(void)
 {
-	ALOGD(__func__);
+	DBG("");
 
 	return BT_STATUS_UNSUPPORTED;
 }
 
 static int disable(void)
 {
-	ALOGD(__func__);
+	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -183,7 +181,7 @@ static int disable(void)
 
 static void cleanup(void)
 {
-	ALOGD(__func__);
+	DBG("");
 
 	if (!interface_ready())
 		return;
@@ -195,7 +193,7 @@ static void cleanup(void)
 
 static int get_adapter_properties(void)
 {
-	ALOGD(__func__);
+	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -205,7 +203,7 @@ static int get_adapter_properties(void)
 
 static int get_adapter_property(bt_property_type_t type)
 {
-	ALOGD(__func__);
+	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -215,7 +213,7 @@ static int get_adapter_property(bt_property_type_t type)
 
 static int set_adapter_property(const bt_property_t *property)
 {
-	ALOGD(__func__);
+	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -228,7 +226,7 @@ static int set_adapter_property(const bt_property_t *property)
 
 static int get_remote_device_properties(bt_bdaddr_t *remote_addr)
 {
-	ALOGD(__func__);
+	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -239,7 +237,7 @@ static int get_remote_device_properties(bt_bdaddr_t *remote_addr)
 static int get_remote_device_property(bt_bdaddr_t *remote_addr,
 						bt_property_type_t type)
 {
-	ALOGD(__func__);
+	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -250,7 +248,7 @@ static int get_remote_device_property(bt_bdaddr_t *remote_addr,
 static int set_remote_device_property(bt_bdaddr_t *remote_addr,
 						const bt_property_t *property)
 {
-	ALOGD(__func__);
+	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -260,7 +258,7 @@ static int set_remote_device_property(bt_bdaddr_t *remote_addr,
 
 static int get_remote_service_record(bt_bdaddr_t *remote_addr, bt_uuid_t *uuid)
 {
-	ALOGD(__func__);
+	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -270,7 +268,7 @@ static int get_remote_service_record(bt_bdaddr_t *remote_addr, bt_uuid_t *uuid)
 
 static int get_remote_services(bt_bdaddr_t *remote_addr)
 {
-	ALOGD(__func__);
+	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -280,7 +278,7 @@ static int get_remote_services(bt_bdaddr_t *remote_addr)
 
 static int start_discovery(void)
 {
-	ALOGD(__func__);
+	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -290,7 +288,7 @@ static int start_discovery(void)
 
 static int cancel_discovery(void)
 {
-	ALOGD(__func__);
+	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -300,7 +298,7 @@ static int cancel_discovery(void)
 
 static int create_bond(const bt_bdaddr_t *bd_addr)
 {
-	ALOGD(__func__);
+	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -313,7 +311,7 @@ static int create_bond(const bt_bdaddr_t *bd_addr)
 
 static int cancel_bond(const bt_bdaddr_t *bd_addr)
 {
-	ALOGD(__func__);
+	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -323,7 +321,7 @@ static int cancel_bond(const bt_bdaddr_t *bd_addr)
 
 static int remove_bond(const bt_bdaddr_t *bd_addr)
 {
-	ALOGD(__func__);
+	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -334,7 +332,7 @@ static int remove_bond(const bt_bdaddr_t *bd_addr)
 static int pin_reply(const bt_bdaddr_t *bd_addr, uint8_t accept,
 				uint8_t pin_len, bt_pin_code_t *pin_code)
 {
-	ALOGD(__func__);
+	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -345,7 +343,7 @@ static int pin_reply(const bt_bdaddr_t *bd_addr, uint8_t accept,
 static int ssp_reply(const bt_bdaddr_t *bd_addr, bt_ssp_variant_t variant,
 					uint8_t accept, uint32_t passkey)
 {
-	ALOGD(__func__);
+	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -358,7 +356,7 @@ static int ssp_reply(const bt_bdaddr_t *bd_addr, bt_ssp_variant_t variant,
 
 static const void *get_profile_interface(const char *profile_id)
 {
-	ALOGD("%s: %s", __func__, profile_id);
+	DBG("%s: %s", __func__, profile_id);
 
 	if (!interface_ready())
 		return NULL;
@@ -377,7 +375,7 @@ static const void *get_profile_interface(const char *profile_id)
 
 static int dut_mode_configure(uint8_t enable)
 {
-	ALOGD(__func__);
+	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -387,7 +385,7 @@ static int dut_mode_configure(uint8_t enable)
 
 static int dut_mode_send(uint16_t opcode, uint8_t *buf, uint8_t len)
 {
-	ALOGD(__func__);
+	DBG("");
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -423,14 +421,14 @@ static const bt_interface_t bluetooth_if = {
 
 static const bt_interface_t *get_bluetooth_interface(void)
 {
-	ALOGD(__func__);
+	DBG("");
 
 	return &bluetooth_if;
 }
 
 static int close_bluetooth(struct hw_device_t *device)
 {
-	ALOGD(__func__);
+	DBG("");
 
 	cleanup();
 
@@ -442,7 +440,7 @@ static int open_bluetooth(const struct hw_module_t *module, char const *name,
 {
 	bluetooth_device_t *dev = malloc(sizeof(bluetooth_device_t));
 
-	ALOGD(__func__);
+	DBG("");
 
 	memset(dev, 0, sizeof(bluetooth_device_t));
 	dev->common.tag = HARDWARE_DEVICE_TAG;
-- 
1.8.4

