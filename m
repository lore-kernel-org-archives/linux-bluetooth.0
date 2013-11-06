Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 6/6] android/hid: Handle virtual unplug notification in hid hal
Date: Wed,  6 Nov 2013 13:48:48 +0200
Message-Id: <1383738528-14550-7-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1383738528-14550-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383738528-14550-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hidhost.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index b24e74e..74a7fe7 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -77,6 +77,15 @@ static void handle_get_report(void *buf)
 						ev->status, ev->data, ev->len);
 }
 
+static void handle_virtual_unplug(void *buf)
+{
+	struct hal_ev_hid_virtual_unplug *ev = buf;
+
+	if (bt_hh_cbacks->virtual_unplug_cb)
+		bt_hh_cbacks->virtual_unplug_cb((bt_bdaddr_t *) ev->bdaddr,
+								ev->status);
+}
+
 /* will be called from notification thread context */
 void bt_notify_hh(uint16_t opcode, void *buf, uint16_t len)
 {
@@ -96,6 +105,9 @@ void bt_notify_hh(uint16_t opcode, void *buf, uint16_t len)
 	case HAL_EV_HID_GET_REPORT:
 		handle_get_report(buf);
 		break;
+	case HAL_EV_HID_VIRTUAL_UNPLUG:
+		handle_virtual_unplug(buf);
+		break;
 	default:
 		DBG("Unhandled callback opcode=0x%x", opcode);
 		break;
-- 
1.8.1.2

