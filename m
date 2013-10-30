Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 4/6] android/hal: Add device found event handler
Date: Wed, 30 Oct 2013 11:00:30 +0100
Message-Id: <1383127232-25147-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1383127232-25147-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1383127232-25147-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is called when new remote device is found.

---
 android/hal-bluetooth.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 06d85e3..3f9df96 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -132,6 +132,19 @@ static void handle_discovery_state_changed(void *buf)
 		bt_hal_cbacks->discovery_state_changed_cb(ev->state);
 }
 
+static void handle_device_found(void *buf, uint16_t len)
+{
+	struct hal_ev_device_found *ev = buf;
+	bt_property_t props[ev->num_props];
+
+	if (!bt_hal_cbacks->device_found_cb)
+		return;
+
+	repack_properties(props, ev->props, ev->num_props, buf + len);
+
+	bt_hal_cbacks->device_found_cb(ev->num_props, props);
+}
+
 /* will be called from notification thread context */
 void bt_notify_adapter(uint16_t opcode, void *buf, uint16_t len)
 {
@@ -148,6 +161,9 @@ void bt_notify_adapter(uint16_t opcode, void *buf, uint16_t len)
 	case HAL_EV_DISCOVERY_STATE_CHANGED:
 		handle_discovery_state_changed(buf);
 		break;
+	case HAL_EV_DEVICE_FOUND:
+		handle_device_found(buf, len);
+		break;
 	case HAL_EV_BOND_STATE_CHANGED:
 		handle_bond_state_change(buf);
 		break;
-- 
1.8.4.1

