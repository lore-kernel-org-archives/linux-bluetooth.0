Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 8/8] android/bluetooth: Rename get_adapter_discovering_type function
Date: Sun, 27 Apr 2014 16:54:58 +0200
Message-Id: <1398610498-1112-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1398610498-1112-1-git-send-email-szymon.janc@tieto.com>
References: <1398610498-1112-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Rename it to get_supported_discovery_type which better describes
function purpose.
---
 android/bluetooth.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index d6bc013..9516911 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1024,7 +1024,7 @@ static void clear_device_found(gpointer data, gpointer user_data)
 	dev->found = false;
 }
 
-static uint8_t get_adapter_discovering_type(void)
+static uint8_t get_supported_discovery_type(void)
 {
 	uint8_t type = SCAN_TYPE_NONE;
 
@@ -1041,7 +1041,7 @@ static bool start_discovery(uint8_t type)
 {
 	struct mgmt_cp_start_discovery cp;
 
-	cp.type = get_adapter_discovering_type() & type;
+	cp.type = get_supported_discovery_type() & type;
 
 	DBG("type=0x%x", cp.type);
 
@@ -1066,14 +1066,14 @@ static void check_discovery_state(uint8_t new_type, uint8_t old_type)
 
 	DBG("%u %u", new_type, old_type);
 
-	if (new_type == get_adapter_discovering_type()) {
+	if (new_type == get_supported_discovery_type()) {
 		g_slist_foreach(bonded_devices, clear_device_found, NULL);
 		g_slist_foreach(cached_devices, clear_device_found, NULL);
 		ev.state = HAL_DISCOVERY_STATE_STARTED;
 		goto done;
 	}
 
-	if (old_type != get_adapter_discovering_type())
+	if (old_type != get_supported_discovery_type())
 		return;
 
 	ev.state = HAL_DISCOVERY_STATE_STOPPED;
@@ -2878,7 +2878,7 @@ static bool stop_discovery(uint8_t type)
 {
 	struct mgmt_cp_stop_discovery cp;
 
-	cp.type = get_adapter_discovering_type() & type;
+	cp.type = get_supported_discovery_type() & type;
 
 	DBG("type=0x%x", cp.type);
 
@@ -3743,7 +3743,7 @@ static void handle_start_discovery_cmd(const void *buf, uint16_t len)
 
 		break;
 	case SCAN_TYPE_LE:
-		if (get_adapter_discovering_type() == SCAN_TYPE_LE)
+		if (get_supported_discovery_type() == SCAN_TYPE_LE)
 			break;
 
 		if (!stop_discovery(SCAN_TYPE_LE)) {
@@ -3775,7 +3775,7 @@ static void handle_cancel_discovery_cmd(const void *buf, uint16_t len)
 	case SCAN_TYPE_NONE:
 		break;
 	case SCAN_TYPE_LE:
-		if (get_adapter_discovering_type() != SCAN_TYPE_LE)
+		if (get_supported_discovery_type() != SCAN_TYPE_LE)
 			break;
 
 		if (gatt_device_found_cb) {
-- 
1.9.1

