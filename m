Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 1/2] android/hidhost: Fix miscalculation of get report event notification length
Date: Tue, 21 Jan 2014 14:24:18 +0200
Message-Id: <1390307059-7772-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Event length is size of struct + data len (if any). It is miscalulated.
---
 android/hidhost.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index 3da77c8..108493a 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -371,7 +371,7 @@ static void bt_hid_notify_get_report(struct hid_device *dev, uint8_t *buf,
 	ba2str(&dev->dst, address);
 	DBG("device %s", address);
 
-	ev_len = sizeof(*ev) + sizeof(struct hal_ev_hidhost_get_report) + 1;
+	ev_len = sizeof(*ev);
 
 	if (!((buf[0] == (HID_MSG_DATA | HID_DATA_TYPE_INPUT)) ||
 			(buf[0] == (HID_MSG_DATA | HID_DATA_TYPE_OUTPUT)) ||
-- 
1.8.3.2

