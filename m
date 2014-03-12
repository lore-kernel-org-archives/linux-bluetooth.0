Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 3/4] android/bluetooth: Expose LE scan in bluetooth API
Date: Wed, 12 Mar 2014 15:43:54 +0100
Message-Id: <1394635435-26646-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1394635435-26646-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1394635435-26646-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Allow GATT to use Core scan functionality instead doubling this
functionality in GATT.
---
 android/bluetooth.c | 18 ++++++++++++++++++
 android/bluetooth.h |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 5430c8a..7ab5184 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2506,6 +2506,24 @@ void bt_set_le_discovering_cb(bt_le_discovering_state_cb_t cb)
 	le_discovering_cb = cb;
 }
 
+bool bt_write_le_scan(bool do_scan)
+{
+	if (!(adapter.current_settings & MGMT_SETTING_POWERED))
+		return false;
+
+	if (adapter.le_discovering == do_scan)
+		return true;
+
+	/* if core is discovering its interleaved scan, don't bother */
+	if (adapter.discovering)
+		return true;
+
+	if (do_scan)
+		return start_discovery(SCAN_TYPE_LE);
+
+	return stop_discovery(SCAN_TYPE_LE);
+}
+
 static uint8_t set_adapter_scan_mode(const void *buf, uint16_t len)
 {
 	const uint8_t *mode = buf;
diff --git a/android/bluetooth.h b/android/bluetooth.h
index 127b9db..9855544 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -42,3 +42,5 @@ void bt_set_le_device_found_cb(bt_le_device_found_cb_t cb);
 
 typedef void (*bt_le_discovering_state_cb_t)(uint8_t state);
 void bt_set_le_discovering_cb(bt_le_discovering_state_cb_t cb);
+
+bool bt_write_le_scan(bool do_scan);
-- 
1.9.0

