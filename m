Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 09/14] android: Remove not needed buf len from Bluetooth service functions
Date: Wed, 6 Nov 2013 15:09:25 +0100
Message-ID: <1383746970-25906-10-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383746970-25906-1-git-send-email-szymon.janc@tieto.com>
References: <1383746970-25906-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Message correctness is verified upon reception and handling functions
can simply make assumption that data in buffer is correct.
---
 android/adapter.c | 35 +++++++++++++++++------------------
 android/adapter.h |  3 +--
 android/main.c    |  3 +--
 3 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index cf5edcd..5b099fe 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -1293,7 +1293,7 @@ static bool get_disc_timeout(void)
 	return false;
 }
 
-static bool get_property(void *buf, uint16_t len)
+static bool get_property(void *buf)
 {
 	struct hal_cmd_get_adapter_prop *cmd = buf;
 
@@ -1431,7 +1431,7 @@ done:
 	return HAL_STATUS_DONE;
 }
 
-static uint8_t set_property(void *buf, uint16_t len)
+static uint8_t set_property(void *buf)
 {
 	struct hal_cmd_set_adapter_prop *cmd = buf;
 
@@ -1485,7 +1485,7 @@ static void pair_device_complete(uint8_t status, uint16_t length,
 							HAL_BOND_STATE_NONE);
 }
 
-static bool create_bond(void *buf, uint16_t len)
+static bool create_bond(void *buf)
 {
 	struct hal_cmd_create_bond *cmd = buf;
 	struct mgmt_cp_pair_device cp;
@@ -1505,7 +1505,7 @@ static bool create_bond(void *buf, uint16_t len)
 	return true;
 }
 
-static bool cancel_bond(void *buf, uint16_t len)
+static bool cancel_bond(void *buf)
 {
 	struct hal_cmd_cancel_bond *cmd = buf;
 	struct mgmt_addr_info cp;
@@ -1532,7 +1532,7 @@ static void unpair_device_complete(uint8_t status, uint16_t length,
 							HAL_BOND_STATE_NONE);
 }
 
-static bool remove_bond(void *buf, uint16_t len)
+static bool remove_bond(void *buf)
 {
 	struct hal_cmd_remove_bond *cmd = buf;
 	struct mgmt_cp_unpair_device cp;
@@ -1546,7 +1546,7 @@ static bool remove_bond(void *buf, uint16_t len)
 				unpair_device_complete, NULL, NULL) > 0;
 }
 
-static uint8_t pin_reply(void *buf, uint16_t len)
+static uint8_t pin_reply(void *buf)
 {
 	struct hal_cmd_pin_reply *cmd = buf;
 	bdaddr_t bdaddr;
@@ -1643,7 +1643,7 @@ static uint8_t user_passkey_reply(const bdaddr_t *bdaddr, bool accept,
 	return HAL_STATUS_SUCCESS;
 }
 
-static uint8_t ssp_reply(void *buf, uint16_t len)
+static uint8_t ssp_reply(void *buf)
 {
 	struct hal_cmd_ssp_reply *cmd = buf;
 	uint8_t status;
@@ -1677,7 +1677,7 @@ static uint8_t ssp_reply(void *buf, uint16_t len)
 	return status;
 }
 
-static uint8_t get_remote_services(void *buf, uint16_t len)
+static uint8_t get_remote_services(void *buf)
 {
 	struct hal_cmd_get_remote_services *cmd = buf;
 	bdaddr_t addr;
@@ -1687,8 +1687,7 @@ static uint8_t get_remote_services(void *buf, uint16_t len)
 	return browse_remote_sdp(&addr);
 }
 
-void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
-								uint16_t len)
+void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf)
 {
 	uint8_t status = HAL_STATUS_FAILED;
 
@@ -1722,39 +1721,39 @@ void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 
 		break;
 	case HAL_OP_GET_ADAPTER_PROP:
-		if (!get_property(buf, len))
+		if (!get_property(buf))
 			goto error;
 
 		break;
 	case HAL_OP_SET_ADAPTER_PROP:
-		status = set_property(buf, len);
+		status = set_property(buf);
 		if (status != HAL_STATUS_SUCCESS && status != HAL_STATUS_DONE)
 			goto error;
 
 		break;
 	case HAL_OP_CREATE_BOND:
-		if (!create_bond(buf, len))
+		if (!create_bond(buf))
 			goto error;
 
 		break;
 	case HAL_OP_CANCEL_BOND:
-		if (!cancel_bond(buf, len))
+		if (!cancel_bond(buf))
 			goto error;
 
 		break;
 	case HAL_OP_REMOVE_BOND:
-		if (!remove_bond(buf, len))
+		if (!remove_bond(buf))
 			goto error;
 
 		break;
 	case HAL_OP_PIN_REPLY:
-		status = pin_reply(buf, len);
+		status = pin_reply(buf);
 		if (status != HAL_STATUS_SUCCESS)
 			goto error;
 
 		break;
 	case HAL_OP_SSP_REPLY:
-		status = ssp_reply(buf, len);
+		status = ssp_reply(buf);
 		if (status != HAL_STATUS_SUCCESS)
 			goto error;
 		break;
@@ -1789,7 +1788,7 @@ void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
 
 		break;
 	case HAL_OP_GET_REMOTE_SERVICES:
-		status = get_remote_services(buf, len);
+		status = get_remote_services(buf);
 		if (status != HAL_STATUS_SUCCESS)
 			goto error;
 		break;
diff --git a/android/adapter.h b/android/adapter.h
index 2afc67a..d304575 100644
--- a/android/adapter.h
+++ b/android/adapter.h
@@ -33,8 +33,7 @@ typedef void (*bt_adapter_ready)(int err);
 void bt_adapter_init(uint16_t index, struct mgmt *mgmt_if,
 							bt_adapter_ready cb);
 
-void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf,
-								uint16_t len);
+void bt_adapter_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf);
 
 const bdaddr_t *bt_adapter_get_address(void);
 
diff --git a/android/main.c b/android/main.c
index d7e77a2..d309068 100644
--- a/android/main.c
+++ b/android/main.c
@@ -249,8 +249,7 @@ static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 		handle_service_core(msg->opcode, buf + sizeof(*msg));
 		break;
 	case HAL_SERVICE_ID_BLUETOOTH:
-		bt_adapter_handle_cmd(hal_cmd_io, msg->opcode, msg->payload,
-								msg->len);
+		bt_adapter_handle_cmd(hal_cmd_io, msg->opcode, msg->payload);
 		break;
 	case HAL_SERVICE_ID_HIDHOST:
 		bt_hid_handle_cmd(hal_cmd_io, msg->opcode, msg->payload,
-- 
1.8.4.2

