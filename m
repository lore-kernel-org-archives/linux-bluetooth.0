Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v4 2/7] android/pan: Change local_role to NONE only when device list is empty
Date: Wed, 18 Dec 2013 16:53:11 +0200
Message-Id: <1387378396-6259-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1387378396-6259-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1387378396-6259-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pan.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index 2bbba9e..b83f534 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -67,8 +67,6 @@ static int device_cmp(gconstpointer s, gconstpointer user_data)
 
 static void pan_device_free(struct pan_device *dev)
 {
-	local_role = HAL_PAN_ROLE_NONE;
-
 	if (dev->watch > 0) {
 		g_source_remove(dev->watch);
 		dev->watch = 0;
@@ -81,6 +79,9 @@ static void pan_device_free(struct pan_device *dev)
 
 	devices = g_slist_remove(devices, dev);
 	g_free(dev);
+
+	if (g_slist_length(devices) == 0)
+		local_role = HAL_PAN_ROLE_NONE;
 }
 
 static void bt_pan_notify_conn_state(struct pan_device *dev, uint8_t state)
-- 
1.8.3.2

