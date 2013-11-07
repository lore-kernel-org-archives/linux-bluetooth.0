Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>, <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2] android: Add set/get for discovery timeout
Date: Thu, 7 Nov 2013 16:26:19 +0100
Message-ID: <1383837979-4390-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Android handles discoverable timeout in Settings app, however still
expects BT stack to maintain this value so we should do it as well.
Otherwise we will get some unexpected behaviour.
For now we keep discovery_timeout only during runtime, but we need to move
it to some local storage once we will have it.

Note: That since Android Settings up handles timer there is no reason to
use discovery timer we have in kernel.
---
 android/adapter.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index 2e8d2df..d59778b 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -48,6 +48,9 @@
 
 /* Default to DisplayYesNo */
 #define DEFAULT_IO_CAPABILITY 0x01
+/* Default discoverable timeout 120sec as in Android */
+#define DEFAULT_DISCOVERABLE_TIMEOUT 120
+
 #define BASELEN_PROP_CHANGED sizeof(struct hal_ev_adapter_props_changed) \
 				+ (sizeof(struct hal_property))
 
@@ -70,6 +73,7 @@ struct bt_adapter {
 	uint32_t current_settings;
 
 	bool discovering;
+	uint32_t discoverable_timeout;
 };
 
 struct browse_req {
@@ -1101,6 +1105,17 @@ static uint8_t set_adapter_name(uint8_t *name, uint16_t len)
 	return HAL_STATUS_FAILED;
 }
 
+static uint8_t set_discoverable_timeout(uint8_t *timeout)
+{
+	/* Android handles discoverable timeout in Settings app.
+	 * There is no need to use kernel feature for that.
+	 * Just need to store this value here */
+
+	/* TODO: This should be in some storage */
+	memcpy(&adapter->discoverable_timeout, timeout, sizeof(uint32_t));
+
+	return HAL_STATUS_SUCCESS;
+}
 static void read_info_complete(uint8_t status, uint16_t length, const void *param,
 							void *user_data)
 {
@@ -1169,6 +1184,8 @@ void bt_adapter_init(uint16_t index, struct mgmt *mgmt, bt_adapter_ready cb)
 	adapter->index = index;
 	adapter->discovering = false;
 	adapter->ready = cb;
+	/* TODO: Read it from some storage */
+	adapter->discoverable_timeout = DEFAULT_DISCOVERABLE_TIMEOUT;
 
 	if (mgmt_send(mgmt, MGMT_OP_READ_INFO, index, 0, NULL,
 					read_info_complete, NULL, NULL) > 0)
@@ -1286,11 +1303,25 @@ static bool get_devices(void)
 
 static bool get_discoverable_timeout(void)
 {
-	DBG("Not implemented");
+	struct hal_ev_adapter_props_changed *ev;
+	int len = sizeof(uint32_t);
+	uint8_t buf[BASELEN_PROP_CHANGED + len];
 
-	/* TODO: Add implementation */
 
-	return false;
+	memset(buf, 0, sizeof(buf));
+	ev = (void *) buf;
+
+	ev->num_props = 1;
+	ev->status = HAL_STATUS_SUCCESS;
+
+	ev->props[0].type = HAL_PROP_ADAPTER_DISC_TIMEOUT;
+	ev->props[0].len = len;
+	memcpy(&ev->props[0].val, &adapter->discoverable_timeout, sizeof(uint32_t));
+
+	ipc_send(notification_sk, HAL_SERVICE_ID_BLUETOOTH,
+				HAL_EV_ADAPTER_PROPS_CHANGED, sizeof(buf), ev, -1);
+
+	return true;
 }
 
 static bool get_property(void *buf, uint16_t len)
@@ -1441,6 +1472,7 @@ static uint8_t set_property(void *buf, uint16_t len)
 	case HAL_PROP_ADAPTER_NAME:
 		return set_adapter_name(cmd->val, cmd->len);
 	case HAL_PROP_ADAPTER_DISC_TIMEOUT:
+		return set_discoverable_timeout(cmd->val);
 	default:
 		DBG("Unhandled property type 0x%x", cmd->type);
 		return HAL_STATUS_FAILED;
-- 
1.8.4

