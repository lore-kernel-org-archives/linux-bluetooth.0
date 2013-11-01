Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 4/8] android/hal: Handle acl_state_changed event
Date: Fri,  1 Nov 2013 15:41:41 +0200
Message-Id: <1383313305-9442-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1383313305-9442-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1383313305-9442-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-bluetooth.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index a0ee844..91c5f97 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -254,6 +254,18 @@ static void handle_device_state_changed(void *buf, uint16_t len)
 	device_hal_props_cleanup(props, ev->num_props);
 }
 
+static void handle_acl_state_changed(void *buf)
+{
+	struct hal_ev_acl_state_changed *ev = buf;
+	bt_bdaddr_t *addr = (bt_bdaddr_t *) ev->bdaddr;
+
+	DBG("state %u", ev->state);
+
+	if (bt_hal_cbacks->acl_state_changed_cb)
+		bt_hal_cbacks->acl_state_changed_cb(ev->status, addr,
+								ev->state);
+}
+
 /* will be called from notification thread context */
 void bt_notify_adapter(uint16_t opcode, void *buf, uint16_t len)
 {
@@ -287,6 +299,9 @@ void bt_notify_adapter(uint16_t opcode, void *buf, uint16_t len)
 	case HAL_EV_SSP_REQUEST:
 		handle_ssp_request(buf);
 		break;
+	case HAL_EV_ACL_STATE_CHANGED:
+		handle_acl_state_changed(buf);
+		break;
 	default:
 		DBG("Unhandled callback opcode=0x%x", opcode);
 		break;
-- 
1.7.10.4

