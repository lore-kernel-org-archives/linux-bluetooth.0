Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 3/4] android: Trivial replacement of tabs where spaces are expected
Date: Sat, 25 Jan 2014 21:44:01 -0400
Message-Id: <1390700642-10482-4-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1390700642-10482-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1390512281-26541-1-git-send-email-anderson.lizardo@openbossa.org>
 <1390700642-10482-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/android-tester.c | 2 +-
 android/hidhost.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index ba9137a..870ad8d 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -3459,7 +3459,7 @@ static void setup_hidhost_connect(const void *test_data)
 	bthost_write_scan_enable(bthost, 0x03);
 }
 
-static void hid_discon_cb(bt_bdaddr_t *bd_addr,	bthh_connection_state_t state)
+static void hid_discon_cb(bt_bdaddr_t *bd_addr, bthh_connection_state_t state)
 {
 	if (state == BTHH_CONN_STATE_DISCONNECTED)
 		tester_test_passed();
diff --git a/android/hidhost.c b/android/hidhost.c
index 37b28a6..6d1088a 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -375,7 +375,7 @@ static void bt_hid_notify_get_report(struct hid_device *dev, uint8_t *buf,
 
 	if (!((buf[0] == (HID_MSG_DATA | HID_DATA_TYPE_INPUT)) ||
 			(buf[0] == (HID_MSG_DATA | HID_DATA_TYPE_OUTPUT)) ||
-			(buf[0]	== (HID_MSG_DATA | HID_DATA_TYPE_FEATURE)))) {
+			(buf[0] == (HID_MSG_DATA | HID_DATA_TYPE_FEATURE)))) {
 		ev = g_malloc0(ev_len);
 		ev->status = buf[0];
 		bdaddr2android(&dev->dst, ev->bdaddr);
-- 
1.8.3.2

