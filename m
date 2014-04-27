Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 3/8] android/bluetooth: Fix bt_le_discovery_start
Date: Sun, 27 Apr 2014 16:54:53 +0200
Message-Id: <1398610498-1112-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1398610498-1112-1-git-send-email-szymon.janc@tieto.com>
References: <1398610498-1112-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix wrong use of adapter.exp_discovery_type and setting callback
even if failed to start discovery.
---
 android/bluetooth.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 51243a0..20f8993 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2944,15 +2944,18 @@ bool bt_le_discovery_start(bt_le_device_found cb)
 	if (!(adapter.current_settings & MGMT_SETTING_POWERED))
 		return false;
 
-	gatt_device_found_cb = cb;
-
-	adapter.exp_discovery_type |= SCAN_TYPE_LE;
-
 	/* If core is discovering, don't bother */
-	if (adapter.cur_discovery_type)
+	if (adapter.cur_discovery_type != SCAN_TYPE_NONE) {
+		gatt_device_found_cb = cb;
 		return true;
+	}
 
-	return start_discovery(adapter.exp_discovery_type);
+	if (start_discovery(SCAN_TYPE_LE)) {
+		gatt_device_found_cb = cb;
+		return true;
+	}
+
+	return false;
 }
 
 static uint8_t set_adapter_scan_mode(const void *buf, uint16_t len)
-- 
1.9.1

