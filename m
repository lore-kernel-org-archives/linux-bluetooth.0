Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/hidhost: Fix logical vs bitwise operation
Date: Fri, 21 Nov 2014 11:48:50 +0200
Message-Id: <1416563330-13822-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

"buf[0] & !1" is always 0, should be bitwise operation.
---
 android/hidhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index 75e895b..b696563 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -465,7 +465,7 @@ static gboolean ctrl_io_watch_cb(GIOChannel *chan, gpointer data)
 		bt_hid_notify_handshake(dev, buf, bread);
 		break;
 	case HID_MSG_CONTROL:
-		if ((buf[0] & !HID_MSG_TYPE_MASK) == HID_VIRTUAL_CABLE_UNPLUG)
+		if ((buf[0] & ~HID_MSG_TYPE_MASK) == HID_VIRTUAL_CABLE_UNPLUG)
 			bt_hid_notify_virtual_unplug(dev, buf, bread);
 		break;
 	default:
-- 
1.9.1

