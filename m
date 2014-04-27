Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 6/8] android/bluetooth: Avoid starting/stopping discovery with no type
Date: Sun, 27 Apr 2014 16:54:56 +0200
Message-Id: <1398610498-1112-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1398610498-1112-1-git-send-email-szymon.janc@tieto.com>
References: <1398610498-1112-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index af5c8ad..e60b6ff 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1026,12 +1026,10 @@ static void clear_device_found(gpointer data, gpointer user_data)
 
 static uint8_t get_adapter_discovering_type(void)
 {
-	uint8_t type;
+	uint8_t type = SCAN_TYPE_NONE;
 
 	if (adapter.current_settings & MGMT_SETTING_BREDR)
-		type = SCAN_TYPE_BREDR;
-	else
-		type = 0;
+		type |= SCAN_TYPE_BREDR;
 
 	if (adapter.current_settings & MGMT_SETTING_LE)
 		type |= SCAN_TYPE_LE;
@@ -1047,6 +1045,9 @@ static bool start_discovery(uint8_t type)
 
 	DBG("type=0x%x", cp.type);
 
+	if (cp.type == SCAN_TYPE_NONE)
+		return false;
+
 	if (mgmt_send(mgmt_if, MGMT_OP_START_DISCOVERY, adapter.index,
 				sizeof(cp), &cp, NULL, NULL, NULL) > 0)
 		return true;
@@ -2864,6 +2865,9 @@ static bool stop_discovery(uint8_t type)
 
 	DBG("type=0x%x", cp.type);
 
+	if (cp.type == SCAN_TYPE_NONE)
+		return false;
+
 	/* Lets drop all confirm name request as we don't need it anymore */
 	g_slist_foreach(cached_devices, cancel_pending_confirm_name, NULL);
 
-- 
1.9.1

