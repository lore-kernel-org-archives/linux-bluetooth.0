Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 03/14] android: Add HAL IPC message response sanity checks
Date: Wed, 6 Nov 2013 15:09:19 +0100
Message-ID: <1383746970-25906-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383746970-25906-1-git-send-email-szymon.janc@tieto.com>
References: <1383746970-25906-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This implements core, bluetooth, sock and hidhost services checks.
---
 android/hal-msg-check.c | 101 ++++++++++++++++++++++++++++++++++++++++++++++++
 android/hal-msg.h       |   2 +
 2 files changed, 103 insertions(+)

diff --git a/android/hal-msg-check.c b/android/hal-msg-check.c
index 208d8a5..0c719ac 100644
--- a/android/hal-msg-check.c
+++ b/android/hal-msg-check.c
@@ -161,3 +161,104 @@ bool hal_cmd_check(const struct hal_hdr *msg, const void *payload, ssize_t len)
 		return false;
 	}
 }
+
+static bool check_rsp_core(uint8_t opcode, const void *payload, uint16_t len)
+{
+	switch (opcode) {
+	check_fix_p(HAL_OP_STATUS, hal_status);
+	check_no_p(HAL_OP_REGISTER_MODULE);
+	check_no_p(HAL_OP_UNREGISTER_MODULE);
+	default:
+		return false;
+	}
+}
+
+static bool check_rsp_bluetooth(uint8_t opcode, const void *payload,
+								uint16_t len)
+{
+	switch (opcode) {
+	check_fix_p(HAL_OP_STATUS, hal_status);
+	check_no_p(HAL_OP_ENABLE);
+	check_no_p(HAL_OP_DISABLE);
+	check_no_p(HAL_OP_GET_ADAPTER_PROPS);
+	check_no_p(HAL_OP_GET_ADAPTER_PROP);
+	check_no_p(HAL_OP_SET_ADAPTER_PROP);
+	check_no_p(HAL_OP_GET_REMOTE_DEVICE_PROPS);
+	check_no_p(HAL_OP_GET_REMOTE_DEVICE_PROP);
+	check_no_p(HAL_OP_SET_REMOTE_DEVICE_PROP);
+	check_no_p(HAL_OP_GET_REMOTE_SERVICE_REC);
+	check_no_p(HAL_OP_GET_REMOTE_SERVICES);
+	check_no_p(HAL_OP_START_DISCOVERY);
+	check_no_p(HAL_OP_CANCEL_DISCOVERY);
+	check_no_p(HAL_OP_CREATE_BOND);
+	check_no_p(HAL_OP_REMOVE_BOND);
+	check_no_p(HAL_OP_CANCEL_BOND)
+	check_no_p(HAL_OP_PIN_REPLY);
+	check_no_p(HAL_OP_SSP_REPLY)
+	check_no_p(HAL_OP_DUT_MODE_CONF);
+	check_no_p(HAL_OP_DUT_MODE_SEND);
+	check_no_p(HAL_OP_LE_TEST_MODE);
+	default:
+		return false;
+	}
+}
+
+static bool check_rsp_sock(uint8_t opcode, const void *payload, uint16_t len)
+{
+	switch (opcode) {
+	check_fix_p(HAL_OP_STATUS, hal_status);
+	check_no_p(HAL_OP_SOCK_LISTEN);
+	check_no_p(HAL_OP_SOCK_CONNECT);
+	default:
+		return false;
+	}
+}
+
+static bool check_rsp_hidhost(uint8_t opcode, const void *payload,
+								uint16_t len)
+{
+	switch (opcode) {
+	check_fix_p(HAL_OP_STATUS, hal_status);
+	check_no_p(HAL_OP_HID_CONNECT);
+	check_no_p(HAL_OP_HID_DISCONNECT);
+	check_no_p(HAL_OP_HID_VP);
+	check_no_p(HAL_OP_HID_SET_INFO);
+	check_no_p(HAL_OP_HID_GET_PROTOCOL);
+	check_no_p(HAL_OP_HID_SET_PROTOCOL);
+	check_no_p(HAL_OP_HID_GET_REPORT);
+	check_no_p(HAL_OP_HID_SET_REPORT);
+	check_no_p(HAL_OP_HID_SEND_DATA);
+	default:
+		return false;
+	}
+}
+
+bool hal_rsp_check(const struct hal_hdr *msg, const void *payload,
+								ssize_t len)
+{
+	if (len < (ssize_t) sizeof(*msg))
+		return false;
+
+	if (len != (ssize_t) (sizeof(*msg) + msg->len))
+		return false;
+
+	switch (msg->service_id) {
+	case HAL_SERVICE_ID_CORE:
+		return check_rsp_core(msg->opcode, payload, msg->len);
+	case HAL_SERVICE_ID_BLUETOOTH:
+		return check_rsp_bluetooth(msg->opcode, payload, msg->len);
+	case HAL_SERVICE_ID_SOCK:
+		return check_rsp_sock(msg->opcode, payload, msg->len);
+	case HAL_SERVICE_ID_HIDHOST:
+		return check_rsp_hidhost(msg->opcode, payload, msg->len);
+	case HAL_SERVICE_ID_PAN:
+	case HAL_SERVICE_ID_HANDSFREE:
+	case HAL_SERVICE_ID_A2DP:
+	case HAL_SERVICE_ID_HEALTH:
+	case HAL_SERVICE_ID_AVRCP:
+	case HAL_SERVICE_ID_GATT:
+		return true;
+	default:
+		return false;
+	}
+}
diff --git a/android/hal-msg.h b/android/hal-msg.h
index e7587bf..2d67ccf 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -489,3 +489,5 @@ struct hal_ev_av_audio_state {
 
 bool hal_cmd_check(const struct hal_hdr *msg, const void *payload,
 								ssize_t len);
+bool hal_rsp_check(const struct hal_hdr *msg, const void *payload,
+								ssize_t len);
-- 
1.8.4.2

