Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 10/10] android/bluetooth: Fix not setting expected discovery type
Date: Thu, 12 Jun 2014 15:33:29 +0300
Message-Id: <1402576409-9352-10-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1402576409-9352-1-git-send-email-luiz.dentz@gmail.com>
References: <1402576409-9352-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The code was not setting the expected discovery type for the next round
when discovering is active.
---
 android/bluetooth.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 9d17faa..bc10b38 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1292,8 +1292,11 @@ static void mgmt_discovering_event(uint16_t index, uint16_t length,
 
 	adapter.cur_discovery_type = type;
 
-	if (ev->discovering)
+	if (ev->discovering) {
+		adapter.exp_discovery_type = adapter.le_scanning ?
+						SCAN_TYPE_LE : SCAN_TYPE_NONE;
 		return;
+	}
 
 	/* One shot notification about discovery stopped */
 	if (gatt_discovery_stopped_cb) {
-- 
1.9.3

