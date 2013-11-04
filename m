Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android: Fix not sending scan mode change notification
Date: Mon, 4 Nov 2013 10:59:59 +0100
Message-ID: <1383559199-22843-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Check for current settings instead of changed setting mask when
sending notification. Otherwise scan mode change would be communicated
only if power state changed at the same time.
---
 android/adapter.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index af62b11..efe3e8b 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -174,19 +174,20 @@ static void settings_changed(uint32_t settings)
 
 	DBG("0x%08x", changed_mask);
 
-	if (changed_mask & MGMT_SETTING_POWERED) {
+	if (changed_mask & MGMT_SETTING_POWERED)
 		powered_changed();
 
-		/*
-		 * Only when powered, the connectable and discoverable
-		 * state changes should be communicated.
-		 */
-		scan_mode_mask = MGMT_SETTING_CONNECTABLE |
-						MGMT_SETTING_DISCOVERABLE;
 
+	scan_mode_mask = MGMT_SETTING_CONNECTABLE |
+					MGMT_SETTING_DISCOVERABLE;
+
+	/*
+	 * Only when powered, the connectable and discoverable
+	 * state changes should be communicated.
+	 */
+	if (adapter->current_settings & MGMT_SETTING_POWERED)
 		if (changed_mask & scan_mode_mask)
 			scan_mode_changed();
-	}
 }
 
 static void new_settings_callback(uint16_t index, uint16_t length,
-- 
1.8.4.1

