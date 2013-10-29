Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/6] android/hal: Add device state changed event handler
Date: Tue, 29 Oct 2013 13:16:55 +0100
Message-Id: <1383049016-23371-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1383049016-23371-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1383049016-23371-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is used to report property change of already reported remote
device.

---
 android/hal-bluetooth.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 261ae85..0fef680 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -114,6 +114,29 @@ static void handle_device_found(void *buf)
 	bt_hal_cbacks->device_found_cb(ev->num_props, send_props);
 }
 
+static void handle_device_state_changed(void *buf)
+{
+	uint8_t i;
+	struct hal_ev_remote_device_props *ev = buf;
+	bt_property_t send_props[ev->num_props];
+	struct hal_property *prop = ev->props;
+
+	if (!bt_hal_cbacks->remote_device_properties_cb)
+		return;
+
+	/* repack props */
+	for (i = 0; i < ev->num_props; ++i) {
+		send_props[i].type = prop->type;
+		send_props[i].len = prop->len;
+		send_props[i].val = prop->val;
+
+		prop = (void *) prop + (sizeof(*prop) + prop->len);
+	}
+	bt_hal_cbacks->remote_device_properties_cb(ev->status,
+						(bt_bdaddr_t *)ev->bdaddr,
+						ev->num_props, send_props);
+}
+
 /* will be called from notification thread context */
 void bt_notify_adapter(uint16_t opcode, void *buf, uint16_t len)
 {
@@ -133,6 +156,9 @@ void bt_notify_adapter(uint16_t opcode, void *buf, uint16_t len)
 	case HAL_EV_DEVICE_FOUND:
 		handle_device_found(buf);
 		break;
+	case HAL_EV_REMOTE_DEVICE_PROPS:
+		handle_device_state_changed(buf);
+		break;
 	default:
 		DBG("Unhandled callback opcode=0x%x", opcode);
 		break;
-- 
1.8.4.1

