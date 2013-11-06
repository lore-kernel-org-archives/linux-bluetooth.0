Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 05/14] android: Add HAL IPC events sanity check
Date: Wed, 6 Nov 2013 15:09:21 +0100
Message-ID: <1383746970-25906-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383746970-25906-1-git-send-email-szymon.janc@tieto.com>
References: <1383746970-25906-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This implements core, bluetooth, sock and hidhost services checks.
---
 android/hal-msg-check.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++
 android/hal-msg.h       |  2 ++
 2 files changed, 65 insertions(+)

diff --git a/android/hal-msg-check.c b/android/hal-msg-check.c
index 0c719ac..8fe1a4f 100644
--- a/android/hal-msg-check.c
+++ b/android/hal-msg-check.c
@@ -262,3 +262,66 @@ bool hal_rsp_check(const struct hal_hdr *msg, const void *payload,
 		return false;
 	}
 }
+
+static bool check_notif_bluetooth(uint8_t opcode, const void *payload,
+								uint16_t len)
+{
+	switch (opcode) {
+	check_fix_p(HAL_EV_ADAPTER_STATE_CHANGED,
+						hal_ev_adapter_state_changed);
+	check_props_p(HAL_EV_ADAPTER_PROPS_CHANGED,
+						hal_ev_adapter_props_changed);
+	check_props_p(HAL_EV_REMOTE_DEVICE_PROPS, hal_ev_remote_device_props);
+	check_props_p(HAL_EV_DEVICE_FOUND, hal_ev_device_found);
+	check_fix_p(HAL_EV_DISCOVERY_STATE_CHANGED,
+					hal_ev_discovery_state_changed);
+	check_fix_p(HAL_EV_PIN_REQUEST, hal_ev_pin_request);
+	check_fix_p(HAL_EV_SSP_REQUEST, hal_ev_ssp_request);
+	check_fix_p(HAL_EV_BOND_STATE_CHANGED, hal_ev_bond_state_changed);
+	check_fix_p(HAL_EV_ACL_STATE_CHANGED, hal_ev_acl_state_changed);
+	check_var_p(HAL_EV_DUT_MODE_RECEIVE, hal_ev_dut_mode_receive, len);
+	check_fix_p(HAL_EV_LE_TEST_MODE, hal_ev_le_test_mode);
+	default:
+		return false;
+	}
+}
+
+static bool check_notif_hidhost(uint8_t opcode, const void *payload,
+								uint16_t len)
+{
+	switch (opcode) {
+	check_fix_p(HAL_EV_HID_CONN_STATE, hal_ev_hid_conn_state);
+	check_fix_p(HAL_EV_HID_INFO, hal_ev_hid_info);
+	default:
+		return false;
+	}
+}
+
+bool hal_notif_check(const struct hal_hdr *msg, const void *payload,
+								ssize_t len)
+{
+	if (len < (ssize_t) sizeof(*msg))
+		return false;
+
+	if (len != (ssize_t) (sizeof(*msg) + msg->len))
+		return false;
+
+	switch (msg->service_id) {
+	case HAL_SERVICE_ID_BLUETOOTH:
+		return check_notif_bluetooth(msg->opcode, payload, msg->len);
+	case HAL_SERVICE_ID_HIDHOST:
+		return check_notif_hidhost(msg->opcode, payload, msg->len);
+	case HAL_SERVICE_ID_PAN:
+	case HAL_SERVICE_ID_HANDSFREE:
+	case HAL_SERVICE_ID_A2DP:
+	case HAL_SERVICE_ID_HEALTH:
+	case HAL_SERVICE_ID_AVRCP:
+	case HAL_SERVICE_ID_GATT:
+		/* TODO implement */
+		return false;
+	case HAL_SERVICE_ID_CORE:
+	case HAL_SERVICE_ID_SOCK:
+	default:
+		return false;
+	}
+}
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 2d67ccf..9f36c61 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -491,3 +491,5 @@ bool hal_cmd_check(const struct hal_hdr *msg, const void *payload,
 								ssize_t len);
 bool hal_rsp_check(const struct hal_hdr *msg, const void *payload,
 								ssize_t len);
+bool hal_notif_check(const struct hal_hdr *msg, const void *payload,
+								ssize_t len);
-- 
1.8.4.2

