Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 9/9] android/bluetooth: Code style and whitespace cleanup
Date: Wed, 11 Dec 2013 11:31:27 +0100
Message-Id: <1386757887-29018-9-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1386757887-29018-1-git-send-email-szymon.janc@tieto.com>
References: <1386757887-29018-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix some random style or whitespace damages. Also moves statics
after last type definition.
---
 android/bluetooth.c | 63 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index b139ff7..4bb2c92 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -52,20 +52,37 @@
 
 /* Default to DisplayYesNo */
 #define DEFAULT_IO_CAPABILITY 0x01
+
 /* Default discoverable timeout 120sec as in Android */
 #define DEFAULT_DISCOVERABLE_TIMEOUT 120
 
 #define BASELEN_PROP_CHANGED (sizeof(struct hal_ev_adapter_props_changed) \
-				+ (sizeof(struct hal_property)))
+					+ (sizeof(struct hal_property)))
 
 static uint16_t option_index = MGMT_INDEX_NONE;
 
 #define BASELEN_REMOTE_DEV_PROP (sizeof(struct hal_ev_remote_device_props) \
 					+ sizeof(struct hal_property))
-/* This list contains addresses which are asked for records */
-static GSList *browse_reqs;
 
-static struct mgmt *mgmt_if = NULL;
+struct device {
+	bdaddr_t bdaddr;
+	uint8_t bdaddr_type;
+
+	int bond_state;
+
+	char *name;
+	char *friendly_name;
+
+	uint32_t class;
+	int32_t rssi;
+};
+
+struct browse_req {
+	bdaddr_t bdaddr;
+	GSList *uuids;
+	int search_uuid;
+	int reconnect_attempt;
+};
 
 static struct {
 	uint16_t index;
@@ -91,23 +108,6 @@ static struct {
 	.uuids = NULL,
 };
 
-struct device {
-	bdaddr_t bdaddr;
-	uint8_t bdaddr_type;
-	int bond_state;
-	char *name;
-	char *friendly_name;
-	uint32_t class;
-	int32_t rssi;
-};
-
-struct browse_req {
-	bdaddr_t bdaddr;
-	GSList *uuids;
-	int search_uuid;
-	int reconnect_attempt;
-};
-
 static const uint16_t uuid_list[] = {
 	L2CAP_UUID,
 	PNP_INFO_SVCLASS_ID,
@@ -115,8 +115,12 @@ static const uint16_t uuid_list[] = {
 	0
 };
 
+static struct mgmt *mgmt_if = NULL;
 static GSList *devices = NULL;
 
+/* This list contains addresses which are asked for records */
+static GSList *browse_reqs;
+
 static int bdaddr_cmp(gconstpointer a, gconstpointer b)
 {
 	const bdaddr_t *bda = a;
@@ -349,7 +353,6 @@ static void store_link_key(const bdaddr_t *dst, const uint8_t *key,
 					uint8_t type, uint8_t pin_length)
 {
 	/* TODO store link key */
-
 }
 
 static void send_bond_state_change(const bdaddr_t *addr, uint8_t status,
@@ -368,7 +371,6 @@ static void send_bond_state_change(const bdaddr_t *addr, uint8_t status,
 static void set_device_bond_state(const bdaddr_t *addr, uint8_t status,
 								int state)
 {
-
 	struct device *dev;
 
 	dev = find_device(addr);
@@ -570,6 +572,7 @@ static void new_link_key_callback(uint16_t index, uint16_t length,
 
 	browse_remote_sdp(&addr->bdaddr);
 }
+
 static  void send_device_property(const bdaddr_t *bdaddr, uint8_t type,
 						uint16_t len, const void *val)
 {
@@ -693,7 +696,8 @@ static void user_passkey_request_callback(uint16_t index, uint16_t length,
 }
 
 static void user_passkey_notify_callback(uint16_t index, uint16_t length,
-					const void *param, void *user_data)
+							const void *param,
+							void *user_data)
 {
 	const struct mgmt_ev_passkey_notify *ev = param;
 	char dst[18];
@@ -713,8 +717,7 @@ static void user_passkey_notify_callback(uint16_t index, uint16_t length,
 	set_device_bond_state(&ev->addr.bdaddr, HAL_STATUS_SUCCESS,
 						HAL_BOND_STATE_BONDING);
 
-	send_ssp_request(&ev->addr.bdaddr, HAL_SSP_VARIANT_NOTIF,
-								ev->passkey);
+	send_ssp_request(&ev->addr.bdaddr, HAL_SSP_VARIANT_NOTIF, ev->passkey);
 }
 
 static void mgmt_discovering_event(uint16_t index, uint16_t length,
@@ -760,7 +763,6 @@ static void confirm_device_name(const bdaddr_t *addr, uint8_t addr_type)
 		error("Failed to send confirm name request");
 }
 
-
 static int fill_hal_prop(void *buf, uint8_t type, uint16_t len,
 							const void *val)
 {
@@ -813,7 +815,8 @@ static void update_found_device(const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 		bdaddr2android(bdaddr, &android_bdaddr);
 
 		size += fill_hal_prop(buf + size, HAL_PROP_DEVICE_ADDR,
-				sizeof(android_bdaddr), &android_bdaddr);
+							sizeof(android_bdaddr),
+							&android_bdaddr);
 		(*num_prop)++;
 
 		android_type = bdaddr_type2android(dev->bdaddr_type);
@@ -932,7 +935,8 @@ static void mgmt_device_connected_event(uint16_t index, uint16_t length,
 }
 
 static void mgmt_device_disconnected_event(uint16_t index, uint16_t length,
-					const void *param, void *user_data)
+							const void *param,
+							void *user_data)
 {
 	const struct mgmt_ev_device_disconnected *ev = param;
 	struct hal_ev_acl_state_changed hal_ev;
@@ -1699,7 +1703,6 @@ static uint8_t get_adapter_name(void)
 	return HAL_STATUS_SUCCESS;
 }
 
-
 static uint8_t get_adapter_class(void)
 {
 	DBG("");
-- 
1.8.3.2

