Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH] android/health: Fix wrong parameter passing to android2bdaddr
Date: Tue, 17 Jun 2014 15:53:27 +0300
Message-Id: <1403009607-6232-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/health.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/health.c b/android/health.c
index 585d8a4..58323d9 100644
--- a/android/health.c
+++ b/android/health.c
@@ -1102,7 +1102,7 @@ static struct health_device *create_device(uint16_t app_id,
 	if (!dev)
 		return NULL;
 
-	android2bdaddr(&addr, &dev->dst);
+	android2bdaddr(addr, &dev->dst);
 	dev->app_id = app_id;
 
 	return dev;
-- 
1.9.1

