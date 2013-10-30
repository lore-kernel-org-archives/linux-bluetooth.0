Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/6] android/hal: Add support for handling discovery state change event
Date: Wed, 30 Oct 2013 11:00:28 +0100
Message-Id: <1383127232-25147-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1383127232-25147-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1383127232-25147-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-bluetooth.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 9d1c3f7..18a5e1c 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -119,6 +119,14 @@ static bool interface_ready(void)
 	return bt_hal_cbacks != NULL;
 }
 
+static void handle_discovery_state_changed(void *buf)
+{
+	struct hal_ev_discovery_state_changed *ev = buf;
+
+	if (bt_hal_cbacks->discovery_state_changed_cb)
+		bt_hal_cbacks->discovery_state_changed_cb(ev->state);
+}
+
 /* will be called from notification thread context */
 void bt_notify_adapter(uint16_t opcode, void *buf, uint16_t len)
 {
@@ -132,6 +140,9 @@ void bt_notify_adapter(uint16_t opcode, void *buf, uint16_t len)
 	case HAL_EV_ADAPTER_PROPS_CHANGED:
 		handle_adapter_props_changed(buf, len);
 		break;
+	case HAL_EV_DISCOVERY_STATE_CHANGED:
+		handle_discovery_state_changed(buf);
+		break;
 	case HAL_EV_BOND_STATE_CHANGED:
 		handle_bond_state_change(buf);
 		break;
-- 
1.8.4.1

