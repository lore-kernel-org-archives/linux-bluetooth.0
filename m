Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] android/hid: Log not implemented HAL functions
Date: Fri,  1 Nov 2013 15:52:44 +0200
Message-Id: <1383313965-30182-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1383313965-30182-1-git-send-email-luiz.dentz@gmail.com>
References: <1383313965-30182-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes it easier to spot which functions the HAL is calling.
---
 android/hid.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/android/hid.c b/android/hid.c
index 6e6f606..e660552 100644
--- a/android/hid.c
+++ b/android/hid.c
@@ -564,6 +564,60 @@ static uint8_t bt_hid_disconnect(struct hal_cmd_hid_disconnect *cmd,
 	return HAL_STATUS_SUCCESS;
 }
 
+static uint8_t bt_hid_virtual_unplug(struct hal_cmd_hid_vp *cmd, uint16_t len)
+{
+	DBG("Not Implemented");
+
+	return HAL_STATUS_FAILED;
+}
+
+static uint8_t bt_hid_info(struct hal_cmd_hid_set_info *cmd, uint16_t len)
+{
+	DBG("Not Implemented");
+
+	return HAL_STATUS_FAILED;
+}
+
+static uint8_t bt_hid_get_protocol(struct hal_cmd_hid_get_protocol *cmd,
+								uint16_t len)
+{
+	DBG("Not Implemented");
+
+	return HAL_STATUS_FAILED;
+}
+
+static uint8_t bt_hid_set_protocol(struct hal_cmd_hid_set_protocol *cmd,
+								uint16_t len)
+{
+	DBG("Not Implemented");
+
+	return HAL_STATUS_FAILED;
+}
+
+static uint8_t bt_hid_get_report(struct hal_cmd_hid_get_report *cmd,
+								uint16_t len)
+{
+	DBG("Not Implemented");
+
+	return HAL_STATUS_FAILED;
+}
+
+static uint8_t bt_hid_set_report(struct hal_cmd_hid_set_report *cmd,
+								uint16_t len)
+{
+	DBG("Not Implemented");
+
+	return HAL_STATUS_FAILED;
+}
+
+static uint8_t bt_hid_send_data(struct hal_cmd_hid_send_data *cmd,
+								uint16_t len)
+{
+	DBG("Not Implemented");
+
+	return HAL_STATUS_FAILED;
+}
+
 void bt_hid_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf, uint16_t len)
 {
 	uint8_t status = HAL_STATUS_FAILED;
@@ -575,6 +629,27 @@ void bt_hid_handle_cmd(GIOChannel *io, uint8_t opcode, void *buf, uint16_t len)
 	case HAL_OP_HID_DISCONNECT:
 		status = bt_hid_disconnect(buf, len);
 		break;
+	case HAL_OP_HID_VP:
+		status = bt_hid_virtual_unplug(buf, len);
+		break;
+	case HAL_OP_HID_SET_INFO:
+		status = bt_hid_info(buf, len);
+		break;
+	case HAL_OP_HID_GET_PROTOCOL:
+		status = bt_hid_get_protocol(buf, len);
+		break;
+	case HAL_OP_HID_SET_PROTOCOL:
+		status = bt_hid_set_protocol(buf, len);
+		break;
+	case HAL_OP_HID_GET_REPORT:
+		status = bt_hid_get_report(buf, len);
+		break;
+	case HAL_OP_HID_SET_REPORT:
+		status = bt_hid_set_report(buf, len);
+		break;
+	case HAL_OP_HID_SEND_DATA:
+		status = bt_hid_send_data(buf, len);
+		break;
 	default:
 		DBG("Unhandled command, opcode 0x%x", opcode);
 		break;
-- 
1.8.3.1

