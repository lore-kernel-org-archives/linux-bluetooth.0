Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 1/4] android/bluetooth: Fix retriggering the discovery
Date: Mon,  4 Aug 2014 12:53:33 +0200
Message-Id: <1407149616-2224-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1407149616-2224-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1407149616-2224-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously le device found callback was set every time we triggered the scan
from gatt. But it does no longer work like that. This callback is now set
when gatt profile is registered and should not be used for checking if we
should be retriggering the scan. Expected discovery flag should be
used directly instead.
---
 android/bluetooth.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index cd1772a..48866b3 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -3714,9 +3714,16 @@ bool bt_le_discovery_start(void)
 
 	adapter.le_scanning = true;
 
-	/* If core is discovering, don't bother */
-	if (adapter.cur_discovery_type != SCAN_TYPE_NONE)
+	/*
+	 * If core is discovering - just set expected next scan type.
+	 * It will be triggered in case current scan session is almost done
+	 * i.e. we missed LE phase in interleaved scan, or we're trying to
+	 * connect to device that was already discovered.
+	 */
+	if (adapter.cur_discovery_type != SCAN_TYPE_NONE) {
+		adapter.exp_discovery_type = SCAN_TYPE_LE;
 		return true;
+	}
 
 	if (start_discovery(SCAN_TYPE_LE))
 		return true;
@@ -4703,7 +4710,7 @@ static void handle_cancel_discovery_cmd(const void *buf, uint16_t len)
 		if (get_supported_discovery_type() != SCAN_TYPE_LE)
 			break;
 
-		if (gatt_device_found_cb) {
+		if (adapter.exp_discovery_type == SCAN_TYPE_LE) {
 			status = HAL_STATUS_BUSY;
 			goto failed;
 		}
@@ -4721,8 +4728,9 @@ static void handle_cancel_discovery_cmd(const void *buf, uint16_t len)
 			goto failed;
 		}
 
-		adapter.exp_discovery_type = gatt_device_found_cb ?
-						SCAN_TYPE_LE : SCAN_TYPE_NONE;
+		if (adapter.exp_discovery_type != SCAN_TYPE_LE)
+			adapter.exp_discovery_type = SCAN_TYPE_NONE;
+
 		break;
 	}
 
-- 
1.9.1

