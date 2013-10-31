Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/5] android: Add support for starting and cancelling device discovery
Date: Thu, 31 Oct 2013 15:25:30 +0100
Message-Id: <1383229534-17157-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Android will cancel ongoing discovery after some period of time so there
is no need for another timeout inside the daemon itself.

---
 android/adapter.c | 108 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 1 deletion(-)

diff --git a/android/adapter.c b/android/adapter.c
index 02f356d..a12ccb3 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -26,8 +26,9 @@
 #include <glib.h>
 
 #include "lib/bluetooth.h"
-#include "src/shared/mgmt.h"
+#include "lib/sdp.h"
 #include "lib/mgmt.h"
+#include "src/shared/mgmt.h"
 #include "log.h"
 #include "hal-msg.h"
 #include "ipc.h"
@@ -52,6 +53,8 @@ struct bt_adapter {
 
 	uint32_t supported_settings;
 	uint32_t current_settings;
+
+	bool discovering;
 };
 
 static struct bt_adapter *adapter;
@@ -349,6 +352,35 @@ static void user_passkey_notify_callback(uint16_t index, uint16_t length,
 								ev->passkey);
 }
 
+static void mgmt_discovering_event(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_ev_discovering *ev = param;
+	struct hal_ev_discovery_state_changed cp;
+
+	if (length < sizeof(*ev)) {
+		error("Too small discovering event");
+		return;
+	}
+
+	DBG("hci%u type %u discovering %u", adapter->index, ev->type,
+							ev->discovering);
+
+	if (adapter->discovering == !!ev->discovering)
+		return;
+
+	adapter->discovering = !!ev->discovering;
+
+	DBG("new discovering state %u", ev->discovering);
+
+	cp.state = adapter->discovering ? HAL_DISCOVERY_STATE_STARTED :
+						HAL_DISCOVERY_STATE_STOPPED;
+
+	ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH,
+						HAL_EV_DISCOVERY_STATE_CHANGED,
+						sizeof(cp), &cp, -1);
+}
+
 static void register_mgmt_handlers(void)
 {
 	mgmt_register(adapter->mgmt, MGMT_EV_NEW_SETTINGS, adapter->index,
@@ -379,6 +411,10 @@ static void register_mgmt_handlers(void)
 	mgmt_register(adapter->mgmt, MGMT_EV_PASSKEY_NOTIFY, adapter->index,
 				user_passkey_notify_callback, NULL, NULL);
 
+	mgmt_register(adapter->mgmt, MGMT_EV_DISCOVERING, adapter->index,
+							mgmt_discovering_event,
+							NULL, NULL);
+
 }
 
 static void load_link_keys_complete(uint8_t status, uint16_t length,
@@ -551,6 +587,7 @@ void bt_adapter_init(uint16_t index, struct mgmt *mgmt, bt_adapter_ready cb)
 
 	adapter->mgmt = mgmt_ref(mgmt);
 	adapter->index = index;
+	adapter->discovering = false;
 	adapter->ready = cb;
 
 	if (mgmt_send(mgmt, MGMT_OP_READ_INFO, index, 0, NULL,
@@ -624,6 +661,46 @@ static bool get_property(void *buf, uint16_t len)
 	}
 }
 
+static bool start_discovery(void)
+{
+	struct mgmt_cp_start_discovery cp;
+	uint8_t type = 1 << BDADDR_BREDR;
+
+	if (adapter->current_settings & type)
+		cp.type = type;
+	else
+		cp.type = 0;
+
+	DBG("type=0x%x", type);
+
+	if (mgmt_send(adapter->mgmt, MGMT_OP_START_DISCOVERY, adapter->index,
+			sizeof(cp), &cp, NULL, NULL, NULL) > 0)
+		return true;
+
+	error("Failed to start discovery");
+	return false;
+}
+
+static bool stop_discovery(void)
+{
+	struct mgmt_cp_stop_discovery cp;
+	uint8_t type = 1 << BDADDR_BREDR;
+
+	if (adapter->current_settings & type)
+		cp.type = type;
+	else
+		cp.type = 0;
+
+	DBG("type=0x%x", type);
+
+	if (mgmt_send(adapter->mgmt, MGMT_OP_STOP_DISCOVERY, adapter->index,
+			sizeof(cp), &cp, NULL, NULL, NULL) > 0)
+		return true;
+
+	error("Failed to start discovery");
+	return false;
+}
+
 static uint8_t set_scan_mode(void *buf, uint16_t len)
 {
 	uint8_t *mode = buf;
@@ -987,6 +1064,35 @@ void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 		status = ssp_reply(buf, len);
 		if (status != HAL_STATUS_SUCCESS)
 			goto error;
+		break;
+	case HAL_OP_START_DISCOVERY:
+		if (adapter->discovering) {
+			status = HAL_STATUS_DONE;
+			goto error;
+		}
+
+		if (!(adapter->current_settings & MGMT_SETTING_POWERED)) {
+			status = HAL_STATUS_NOT_READY;
+			goto error;
+		}
+
+		if (!start_discovery())
+			goto error;
+
+		break;
+	case HAL_OP_CANCEL_DISCOVERY:
+		if (!adapter->discovering) {
+			status = HAL_STATUS_DONE;
+			goto error;
+		}
+
+		if (!(adapter->current_settings & MGMT_SETTING_POWERED)) {
+			status = HAL_STATUS_NOT_READY;
+			goto error;
+		}
+
+		if (!stop_discovery())
+			goto error;
 
 		break;
 	default:
-- 
1.8.4.1

