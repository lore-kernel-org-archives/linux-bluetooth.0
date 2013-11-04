Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 08/11] android/hid: Handle get report notification in hal
Date: Tue,  5 Nov 2013 00:20:12 +0200
Message-Id: <1383603615-9953-9-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1383603615-9953-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383603615-9953-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hidhost.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index 040d517..45767b8 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -68,6 +68,15 @@ static void handle_protocol_mode(void *buf)
 							ev->status, ev->mode);
 }
 
+static void handle_get_report(void *buf)
+{
+	struct hal_ev_hid_get_report *ev = buf;
+
+	if (bt_hh_cbacks->get_report_cb)
+		bt_hh_cbacks->get_report_cb((bt_bdaddr_t *) ev->bdaddr,
+						ev->status, ev->data, ev->len);
+}
+
 /* will be called from notification thread context */
 void bt_notify_hh(uint16_t opcode, void *buf, uint16_t len)
 {
@@ -84,6 +93,9 @@ void bt_notify_hh(uint16_t opcode, void *buf, uint16_t len)
 	case HAL_EV_HID_PROTO_MODE:
 		handle_protocol_mode(buf);
 		break;
+	case HAL_EV_HID_GET_REPORT:
+		handle_get_report(buf);
+		break;
 	default:
 		DBG("Unhandled callback opcode=0x%x", opcode);
 		break;
-- 
1.8.1.2

