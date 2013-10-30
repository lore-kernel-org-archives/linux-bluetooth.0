Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 5/6] android/hal: Add device state changed event handler
Date: Wed, 30 Oct 2013 11:00:31 +0100
Message-Id: <1383127232-25147-6-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1383127232-25147-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1383127232-25147-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is used to report property change of already reported remote
device.

---
 android/hal-bluetooth.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 3f9df96..2237063 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -145,6 +145,21 @@ static void handle_device_found(void *buf, uint16_t len)
 	bt_hal_cbacks->device_found_cb(ev->num_props, props);
 }
 
+static void handle_device_state_changed(void *buf, uint16_t len)
+{
+	struct hal_ev_remote_device_props *ev = buf;
+	bt_property_t props[ev->num_props];
+
+	if (!bt_hal_cbacks->remote_device_properties_cb)
+		return;
+
+	repack_properties(props, ev->props, ev->num_props, buf + len);
+
+	bt_hal_cbacks->remote_device_properties_cb(ev->status,
+						(bt_bdaddr_t *)ev->bdaddr,
+						ev->num_props, props);
+}
+
 /* will be called from notification thread context */
 void bt_notify_adapter(uint16_t opcode, void *buf, uint16_t len)
 {
@@ -164,6 +179,9 @@ void bt_notify_adapter(uint16_t opcode, void *buf, uint16_t len)
 	case HAL_EV_DEVICE_FOUND:
 		handle_device_found(buf, len);
 		break;
+	case HAL_EV_REMOTE_DEVICE_PROPS:
+		handle_device_state_changed(buf, len);
+		break;
 	case HAL_EV_BOND_STATE_CHANGED:
 		handle_bond_state_change(buf);
 		break;
-- 
1.8.4.1

