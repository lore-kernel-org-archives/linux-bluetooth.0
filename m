Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/7] android/bluetooth: Fix bt_le_discovery_stop
Date: Fri, 18 Apr 2014 15:04:41 +0200
Message-Id: <1397826284-11118-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1397826284-11118-1-git-send-email-szymon.janc@tieto.com>
References: <1397826284-11118-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix invalid use of adapter.exp_discovery_type and not clearing
callback.
---
 android/bluetooth.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index a531db6..68bfb12 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2925,18 +2925,23 @@ bool bt_le_set_advertising(bool advertising, bt_le_set_advertising_done cb,
 
 bool bt_le_discovery_stop(bt_le_discovery_stopped cb)
 {
-	if (!adapter.cur_discovery_type) {
+	if (adapter.cur_discovery_type != SCAN_TYPE_LE) {
 		if (cb)
 			cb();
+
+		gatt_device_found_cb = NULL;
+
 		return true;
 	}
 
-	gatt_discovery_stopped_cb = cb;
-	/* Remove device found callback */
+	if (!stop_discovery(SCAN_TYPE_LE))
+		return false;
+
 	gatt_device_found_cb = NULL;
-	adapter.exp_discovery_type &= ~SCAN_TYPE_LE;
+	gatt_discovery_stopped_cb = cb;
+	adapter.exp_discovery_type = SCAN_TYPE_NONE;
 
-	return stop_discovery(adapter.cur_discovery_type);
+	return true;
 }
 
 bool bt_le_discovery_start(bt_le_device_found cb)
-- 
1.9.1

