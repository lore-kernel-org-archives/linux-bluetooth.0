Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/6] android/pan: Remove unneeded NULL assignment
Date: Tue,  3 Dec 2013 17:53:09 +0200
Message-Id: <1386085993-22055-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1386085993-22055-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1386085993-22055-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/pan.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/android/pan.c b/android/pan.c
index fe6ee26..87fa4e8 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -81,7 +81,6 @@ static void pan_device_free(struct pan_device *dev)
 
 	devices = g_slist_remove(devices, dev);
 	g_free(dev);
-	dev = NULL;
 }
 
 static void bt_pan_notify_conn_state(struct pan_device *dev, uint8_t state)
-- 
1.8.3.2

