Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 09/11] android/hid: Handle virtual unplug notification in hid hal
Date: Fri,  8 Nov 2013 00:10:18 +0200
Message-Id: <1383862220-29968-10-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1383862220-29968-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1383862220-29968-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-hidhost.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/android/hal-hidhost.c b/android/hal-hidhost.c
index dbdf176..db95e3e 100644
--- a/android/hal-hidhost.c
+++ b/android/hal-hidhost.c
@@ -78,6 +78,15 @@ static void handle_get_report(void *buf)
 							ev->data, ev->len);
 }
 
+static void handle_virtual_unplug(void *buf)
+{
+	struct hal_ev_hidhost_virtual_unplug *ev = buf;
+
+	if (cbacks->virtual_unplug_cb)
+		cbacks->virtual_unplug_cb((bt_bdaddr_t *) ev->bdaddr,
+								ev->status);
+}
+
 /* will be called from notification thread context */
 void bt_notify_hidhost(uint16_t opcode, void *buf, uint16_t len)
 {
@@ -97,6 +106,9 @@ void bt_notify_hidhost(uint16_t opcode, void *buf, uint16_t len)
 	case HAL_EV_HIDHOST_GET_REPORT:
 		handle_get_report(buf);
 		break;
+	case HAL_EV_HIDHOST_VIRTUAL_UNPLUG:
+		handle_virtual_unplug(buf);
+		break;
 	default:
 		DBG("Unhandled callback opcode=0x%x", opcode);
 		break;
-- 
1.8.3.2

