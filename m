Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/6] android/hal: Add support for handling discovery state change event
Date: Tue, 29 Oct 2013 13:16:53 +0100
Message-Id: <1383049016-23371-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1383049016-23371-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1383049016-23371-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-bluetooth.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index aa104ba..b13f4d7 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -85,6 +85,14 @@ static bool interface_ready(void)
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
@@ -98,6 +106,9 @@ void bt_notify_adapter(uint16_t opcode, void *buf, uint16_t len)
 	case HAL_EV_ADAPTER_PROPS_CHANGED:
 		handle_adapter_props_changed(buf, len);
 		break;
+	case HAL_EV_DISCOVERY_STATE_CHANGED:
+		handle_discovery_state_changed(buf);
+		break;
 	default:
 		DBG("Unhandled callback opcode=0x%x", opcode);
 		break;
-- 
1.8.4.1

