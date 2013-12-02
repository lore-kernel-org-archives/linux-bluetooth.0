Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] android/pan: Remove unneeded NULL assignment
Date: Mon,  2 Dec 2013 17:46:27 +0200
Message-Id: <1385999188-1546-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385999188-1546-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385999188-1546-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/pan.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/android/pan.c b/android/pan.c
index 3270aa4..8e719b2 100644
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

