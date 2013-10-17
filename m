Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 7/9] android: Fix building with local cutils/log.h
Date: Thu, 17 Oct 2013 11:55:26 +0300
Message-Id: <1382000128-23762-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1382000128-23762-1-git-send-email-luiz.dentz@gmail.com>
References: <1382000128-23762-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

android/hal_bt_sock.c: In function 'btsock_listen_rfcomm':
android/hal_bt_sock.c:30:47: error: expected ')' before '__func__'
  ALOGD(__func__);
---
 android/hal_bluetooth.c | 52 ++++++++++++++++++++++++-------------------------
 android/hal_bt_sock.c   |  2 +-
 2 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/android/hal_bluetooth.c b/android/hal_bluetooth.c
index 9bb9dcf..cf8f3ae 100644
--- a/android/hal_bluetooth.c
+++ b/android/hal_bluetooth.c
@@ -44,7 +44,7 @@ static bool start_bt_daemon(void)
 {
 	int tries = 40; /* wait 4 seconds for completion */
 
-	ALOGD(__func__);
+	ALOGD("%s",__func__);
 
 	/* Start Android Bluetooth daemon service */
 	property_set("ctl.start", SERVICE_NAME);
@@ -69,7 +69,7 @@ static bool start_bt_daemon(void)
 
 static int init(bt_callbacks_t *callbacks)
 {
-	ALOGD(__func__);
+	ALOGD("%s",__func__);
 
 	if (interface_ready())
 		return BT_STATUS_SUCCESS;
@@ -87,14 +87,14 @@ static int init(bt_callbacks_t *callbacks)
 
 static int enable(void)
 {
-	ALOGD(__func__);
+	ALOGD("%s",__func__);
 
 	return BT_STATUS_UNSUPPORTED;
 }
 
 static int disable(void)
 {
-	ALOGD(__func__);
+	ALOGD("%s",__func__);
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -104,7 +104,7 @@ static int disable(void)
 
 static void cleanup(void)
 {
-	ALOGD(__func__);
+	ALOGD("%s",__func__);
 
 	if (!interface_ready())
 		return;
@@ -114,7 +114,7 @@ static void cleanup(void)
 
 static int get_adapter_properties(void)
 {
-	ALOGD(__func__);
+	ALOGD("%s",__func__);
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -124,7 +124,7 @@ static int get_adapter_properties(void)
 
 static int get_adapter_property(bt_property_type_t type)
 {
-	ALOGD(__func__);
+	ALOGD("%s",__func__);
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -134,7 +134,7 @@ static int get_adapter_property(bt_property_type_t type)
 
 static int set_adapter_property(const bt_property_t *property)
 {
-	ALOGD(__func__);
+	ALOGD("%s",__func__);
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -147,7 +147,7 @@ static int set_adapter_property(const bt_property_t *property)
 
 static int get_remote_device_properties(bt_bdaddr_t *remote_addr)
 {
-	ALOGD(__func__);
+	ALOGD("%s",__func__);
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -158,7 +158,7 @@ static int get_remote_device_properties(bt_bdaddr_t *remote_addr)
 static int get_remote_device_property(bt_bdaddr_t *remote_addr,
 						bt_property_type_t type)
 {
-	ALOGD(__func__);
+	ALOGD("%s",__func__);
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -169,7 +169,7 @@ static int get_remote_device_property(bt_bdaddr_t *remote_addr,
 static int set_remote_device_property(bt_bdaddr_t *remote_addr,
 						const bt_property_t *property)
 {
-	ALOGD(__func__);
+	ALOGD("%s",__func__);
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -179,7 +179,7 @@ static int set_remote_device_property(bt_bdaddr_t *remote_addr,
 
 static int get_remote_service_record(bt_bdaddr_t *remote_addr, bt_uuid_t *uuid)
 {
-	ALOGD(__func__);
+	ALOGD("%s",__func__);
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -189,7 +189,7 @@ static int get_remote_service_record(bt_bdaddr_t *remote_addr, bt_uuid_t *uuid)
 
 static int get_remote_services(bt_bdaddr_t *remote_addr)
 {
-	ALOGD(__func__);
+	ALOGD("%s",__func__);
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -199,7 +199,7 @@ static int get_remote_services(bt_bdaddr_t *remote_addr)
 
 static int start_discovery(void)
 {
-	ALOGD(__func__);
+	ALOGD("%s",__func__);
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -209,7 +209,7 @@ static int start_discovery(void)
 
 static int cancel_discovery(void)
 {
-	ALOGD(__func__);
+	ALOGD("%s",__func__);
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -219,7 +219,7 @@ static int cancel_discovery(void)
 
 static int create_bond(const bt_bdaddr_t *bd_addr)
 {
-	ALOGD(__func__);
+	ALOGD("%s",__func__);
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -232,7 +232,7 @@ static int create_bond(const bt_bdaddr_t *bd_addr)
 
 static int cancel_bond(const bt_bdaddr_t *bd_addr)
 {
-	ALOGD(__func__);
+	ALOGD("%s",__func__);
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -242,7 +242,7 @@ static int cancel_bond(const bt_bdaddr_t *bd_addr)
 
 static int remove_bond(const bt_bdaddr_t *bd_addr)
 {
-	ALOGD(__func__);
+	ALOGD("%s",__func__);
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -253,7 +253,7 @@ static int remove_bond(const bt_bdaddr_t *bd_addr)
 static int pin_reply(const bt_bdaddr_t *bd_addr, uint8_t accept,
 				uint8_t pin_len, bt_pin_code_t *pin_code)
 {
-	ALOGD(__func__);
+	ALOGD("%s",__func__);
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -264,7 +264,7 @@ static int pin_reply(const bt_bdaddr_t *bd_addr, uint8_t accept,
 static int ssp_reply(const bt_bdaddr_t *bd_addr, bt_ssp_variant_t variant,
 					uint8_t accept, uint32_t passkey)
 {
-	ALOGD(__func__);
+	ALOGD("%s",__func__);
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -277,7 +277,7 @@ static int ssp_reply(const bt_bdaddr_t *bd_addr, bt_ssp_variant_t variant,
 
 static const void *get_profile_interface(const char *profile_id)
 {
-	ALOGD("%s: %s", __func__, profile_id);
+	ALOGD("%s: %s",__func__, profile_id);
 
 	if (!interface_ready())
 		return NULL;
@@ -290,7 +290,7 @@ static const void *get_profile_interface(const char *profile_id)
 
 static int dut_mode_configure(uint8_t enable)
 {
-	ALOGD(__func__);
+	ALOGD("%s",__func__);
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -300,7 +300,7 @@ static int dut_mode_configure(uint8_t enable)
 
 static int dut_mode_send(uint16_t opcode, uint8_t *buf, uint8_t len)
 {
-	ALOGD(__func__);
+	ALOGD("%s",__func__);
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -336,14 +336,14 @@ static const bt_interface_t bluetooth_if = {
 
 static const bt_interface_t *get_bluetooth_interface(void)
 {
-	ALOGD(__func__);
+	ALOGD("%s",__func__);
 
 	return &bluetooth_if;
 }
 
 static int close_bluetooth(struct hw_device_t *device)
 {
-	ALOGD(__func__);
+	ALOGD("%s",__func__);
 
 	cleanup();
 
@@ -355,7 +355,7 @@ static int open_bluetooth(const struct hw_module_t *module, char const *name,
 {
 	bluetooth_device_t *dev = malloc(sizeof(bluetooth_device_t));
 
-	ALOGD(__func__);
+	ALOGD("%s",__func__);
 
 	memset(dev, 0, sizeof(bluetooth_device_t));
 	dev->common.tag = HARDWARE_DEVICE_TAG;
diff --git a/android/hal_bt_sock.c b/android/hal_bt_sock.c
index 3a6d173..318c9c9 100644
--- a/android/hal_bt_sock.c
+++ b/android/hal_bt_sock.c
@@ -27,7 +27,7 @@ static bt_status_t btsock_listen_rfcomm(const char *service_name,
 					const uint8_t *uuid, int chan,
 					int *sock, int flags)
 {
-	ALOGD(__func__);
+	ALOGD("%s", __func__);
 
 	return BT_STATUS_UNSUPPORTED;
 }
-- 
1.8.3.1

