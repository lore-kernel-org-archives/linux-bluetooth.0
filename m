Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 10/14] android: Remove not needed buf len from Hidhost service functions
Date: Wed, 6 Nov 2013 15:09:26 +0100
Message-ID: <1383746970-25906-11-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383746970-25906-1-git-send-email-szymon.janc@tieto.com>
References: <1383746970-25906-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Message correctness is verified upon reception and handling functions
can simply make assumption that data in buffer is correct.
---
 android/hid.c  | 62 ++++++++++++++++++----------------------------------------
 android/hid.h  |  2 +-
 android/main.c |  3 +--
 3 files changed, 21 insertions(+), 46 deletions(-)

diff --git a/android/hid.c b/android/hid.c
index c38c4c1..968dc29 100644
--- a/android/hid.c
+++ b/android/hid.c
@@ -667,7 +667,7 @@ fail:
 	hid_device_free(dev);
 }
 
-static uint8_t bt_hid_connect(struct hal_cmd_hid_connect *cmd, uint16_t len)
+static uint8_t bt_hid_connect(struct hal_cmd_hid_connect *cmd)
 {
 	struct hid_device *dev;
 	char addr[18];
@@ -678,9 +678,6 @@ static uint8_t bt_hid_connect(struct hal_cmd_hid_connect *cmd, uint16_t len)
 
 	DBG("");
 
-	if (len < sizeof(*cmd))
-		return HAL_STATUS_INVALID;
-
 	android2bdaddr(&cmd->bdaddr, &dst);
 
 	l = g_slist_find_custom(devices, &dst, device_cmp);
@@ -708,8 +705,7 @@ static uint8_t bt_hid_connect(struct hal_cmd_hid_connect *cmd, uint16_t len)
 	return HAL_STATUS_SUCCESS;
 }
 
-static uint8_t bt_hid_disconnect(struct hal_cmd_hid_disconnect *cmd,
-								uint16_t len)
+static uint8_t bt_hid_disconnect(struct hal_cmd_hid_disconnect *cmd)
 {
 	struct hid_device *dev;
 	GSList *l;
@@ -717,9 +713,6 @@ static uint8_t bt_hid_disconnect(struct hal_cmd_hid_disconnect *cmd,
 
 	DBG("");
 
-	if (len < sizeof(*cmd))
-		return HAL_STATUS_INVALID;
-
 	android2bdaddr(&cmd->bdaddr, &dst);
 
 	l = g_slist_find_custom(devices, &dst, device_cmp);
@@ -740,22 +733,21 @@ static uint8_t bt_hid_disconnect(struct hal_cmd_hid_disconnect *cmd,
 	return HAL_STATUS_SUCCESS;
 }
 
-static uint8_t bt_hid_virtual_unplug(struct hal_cmd_hid_vp *cmd, uint16_t len)
+static uint8_t bt_hid_virtual_unplug(struct hal_cmd_hid_vp *cmd)
 {
 	DBG("Not Implemented");
 
 	return HAL_STATUS_FAILED;
 }
 
-static uint8_t bt_hid_info(struct hal_cmd_hid_set_info *cmd, uint16_t len)
+static uint8_t bt_hid_info(struct hal_cmd_hid_set_info *cmd)
 {
 	DBG("Not Implemented");
 
 	return HAL_STATUS_FAILED;
 }
 
-static uint8_t bt_hid_get_protocol(struct hal_cmd_hid_get_protocol *cmd,
-								uint16_t len)
+static uint8_t bt_hid_get_protocol(struct hal_cmd_hid_get_protocol *cmd)
 {
 	struct hid_device *dev;
 	GSList *l;
@@ -765,9 +757,6 @@ static uint8_t bt_hid_get_protocol(struct hal_cmd_hid_get_protocol *cmd,
 
 	DBG("");
 
-	if (len < sizeof(*cmd))
-		return HAL_STATUS_INVALID;
-
 	android2bdaddr(&cmd->bdaddr, &dst);
 
 	l = g_slist_find_custom(devices, &dst, device_cmp);
@@ -791,8 +780,7 @@ static uint8_t bt_hid_get_protocol(struct hal_cmd_hid_get_protocol *cmd,
 	return HAL_STATUS_SUCCESS;
 }
 
-static uint8_t bt_hid_set_protocol(struct hal_cmd_hid_set_protocol *cmd,
-								uint16_t len)
+static uint8_t bt_hid_set_protocol(struct hal_cmd_hid_set_protocol *cmd)
 {
 	struct hid_device *dev;
 	GSList *l;
@@ -802,9 +790,6 @@ static uint8_t bt_hid_set_protocol(struct hal_cmd_hid_set_protocol *cmd,
 
 	DBG("");
 
-	if (len < sizeof(*cmd))
-		return HAL_STATUS_INVALID;
-
 	android2bdaddr(&cmd->bdaddr, &dst);
 
 	l = g_slist_find_custom(devices, &dst, device_cmp);
@@ -828,8 +813,7 @@ static uint8_t bt_hid_set_protocol(struct hal_cmd_hid_set_protocol *cmd,
 	return HAL_STATUS_SUCCESS;
 }
 
-static uint8_t bt_hid_get_report(struct hal_cmd_hid_get_report *cmd,
-								uint16_t len)
+static uint8_t bt_hid_get_report(struct hal_cmd_hid_get_report *cmd)
 {
 	struct hid_device *dev;
 	GSList *l;
@@ -840,9 +824,6 @@ static uint8_t bt_hid_get_report(struct hal_cmd_hid_get_report *cmd,
 
 	DBG("");
 
-	if (len < sizeof(*cmd))
-		return HAL_STATUS_INVALID;
-
 	android2bdaddr(&cmd->bdaddr, &dst);
 
 	l = g_slist_find_custom(devices, &dst, device_cmp);
@@ -876,8 +857,7 @@ static uint8_t bt_hid_get_report(struct hal_cmd_hid_get_report *cmd,
 	return HAL_STATUS_SUCCESS;
 }
 
-static uint8_t bt_hid_set_report(struct hal_cmd_hid_set_report *cmd,
-								uint16_t len)
+static uint8_t bt_hid_set_report(struct hal_cmd_hid_set_report *cmd)
 {
 	struct hid_device *dev;
 	GSList *l;
@@ -888,9 +868,6 @@ static uint8_t bt_hid_set_report(struct hal_cmd_hid_set_report *cmd,
 
 	DBG("");
 
-	if (len < sizeof(*cmd))
-		return HAL_STATUS_INVALID;
-
 	android2bdaddr(&cmd->bdaddr, &dst);
 
 	l = g_slist_find_custom(devices, &dst, device_cmp);
@@ -919,45 +896,44 @@ static uint8_t bt_hid_set_report(struct hal_cmd_hid_set_report *cmd,
 	return HAL_STATUS_SUCCESS;
 }
 
-static uint8_t bt_hid_send_data(struct hal_cmd_hid_send_data *cmd,
-								uint16_t len)
+static uint8_t bt_hid_send_data(struct hal_cmd_hid_send_data *cmd)
 {
 	DBG("Not Implemented");
 
 	return HAL_STATUS_FAILED;
 }
 
-void bt_hid_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf, uint16_t len)
+void bt_hid_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf)
 {
 	uint8_t status = HAL_STATUS_FAILED;
 
 	switch (opcode) {
 	case HAL_OP_HID_CONNECT:
-		status = bt_hid_connect(buf, len);
+		status = bt_hid_connect(buf);
 		break;
 	case HAL_OP_HID_DISCONNECT:
-		status = bt_hid_disconnect(buf, len);
+		status = bt_hid_disconnect(buf);
 		break;
 	case HAL_OP_HID_VP:
-		status = bt_hid_virtual_unplug(buf, len);
+		status = bt_hid_virtual_unplug(buf);
 		break;
 	case HAL_OP_HID_SET_INFO:
-		status = bt_hid_info(buf, len);
+		status = bt_hid_info(buf);
 		break;
 	case HAL_OP_HID_GET_PROTOCOL:
-		status = bt_hid_get_protocol(buf, len);
+		status = bt_hid_get_protocol(buf);
 		break;
 	case HAL_OP_HID_SET_PROTOCOL:
-		status = bt_hid_set_protocol(buf, len);
+		status = bt_hid_set_protocol(buf);
 		break;
 	case HAL_OP_HID_GET_REPORT:
-		status = bt_hid_get_report(buf, len);
+		status = bt_hid_get_report(buf);
 		break;
 	case HAL_OP_HID_SET_REPORT:
-		status = bt_hid_set_report(buf, len);
+		status = bt_hid_set_report(buf);
 		break;
 	case HAL_OP_HID_SEND_DATA:
-		status = bt_hid_send_data(buf, len);
+		status = bt_hid_send_data(buf);
 		break;
 	default:
 		DBG("Unhandled command, opcode 0x%x", opcode);
diff --git a/android/hid.h b/android/hid.h
index 674b35a..b92f4f1 100644
--- a/android/hid.h
+++ b/android/hid.h
@@ -21,7 +21,7 @@
  *
  */
 
-void bt_hid_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf, uint16_t len);
+void bt_hid_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf);
 
 bool bt_hid_register(GIOChannel *io, const bdaddr_t *addr);
 void bt_hid_unregister(void);
diff --git a/android/main.c b/android/main.c
index d309068..08bba4e 100644
--- a/android/main.c
+++ b/android/main.c
@@ -252,8 +252,7 @@ static gboolean cmd_watch_cb(GIOChannel *io, GIOCondition cond,
 		bt_adapter_handle_cmd(hal_cmd_io, msg->opcode, msg->payload);
 		break;
 	case HAL_SERVICE_ID_HIDHOST:
-		bt_hid_handle_cmd(hal_cmd_io, msg->opcode, msg->payload,
-								msg->len);
+		bt_hid_handle_cmd(hal_cmd_io, msg->opcode, msg->payload);
 		break;
 	case HAL_SERVICE_ID_SOCK:
 		bt_sock_handle_cmd(hal_cmd_io, msg->opcode, msg->payload,
-- 
1.8.4.2

