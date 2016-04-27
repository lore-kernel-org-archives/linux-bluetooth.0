Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Francois Beaufort <beaufort.francois@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] Set RSSI_THRESHOLD to 2
Date: Wed, 27 Apr 2016 10:01:48 +0200
Message-Id: <1461744108-21366-2-git-send-email-beaufort.francois@gmail.com>
In-Reply-To: <1461744108-21366-1-git-send-email-beaufort.francois@gmail.com>
References: <1461744108-21366-1-git-send-email-beaufort.francois@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 5269ee8..1caeee7 100644
--- a/src/device.c
+++ b/src/device.c
@@ -85,7 +85,7 @@
 #define MIN(a, b) ((a) < (b) ? (a) : (b))
 #endif
 
-#define RSSI_THRESHOLD		8
+#define RSSI_THRESHOLD		2
 
 #define GATT_PRIM_SVC_UUID_STR "2800"
 #define GATT_SND_SVC_UUID_STR  "2801"
-- 
2.7.0

