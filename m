Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 04/13] android/hid: Handle protocol mode notification in hal
Date: Tue,  5 Nov 2013 13:38:06 +0200
Message-Id: <1383651495-12434-5-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1383651495-12434-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383651495-12434-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hidhost.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index c20c785..13928e6 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -59,6 +59,15 @@ static void handle_info(void *buf)
 		bt_hh_cbacks->hid_info_cb((bt_bdaddr_t *) ev->bdaddr, info);
 }
 
+static void handle_proto_mode(void *buf)
+{
+	struct hal_ev_hid_proto_mode *ev = buf;
+
+	if (bt_hh_cbacks->protocol_mode_cb)
+		bt_hh_cbacks->protocol_mode_cb((bt_bdaddr_t *) ev->bdaddr,
+							ev->status, ev->mode);
+}
+
 /* will be called from notification thread context */
 void bt_notify_hh(uint16_t opcode, void *buf, uint16_t len)
 {
@@ -72,6 +81,9 @@ void bt_notify_hh(uint16_t opcode, void *buf, uint16_t len)
 	case HAL_EV_HID_INFO:
 		handle_info(buf);
 		break;
+	case HAL_EV_HID_PROTO_MODE:
+		handle_proto_mode(buf);
+		break;
 	default:
 		DBG("Unhandled callback opcode=0x%x", opcode);
 		break;
-- 
1.8.1.2

