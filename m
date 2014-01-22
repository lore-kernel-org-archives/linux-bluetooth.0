Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/pan: Fix wrong freeing dev
Date: Wed, 22 Jan 2014 12:48:57 +0200
Message-Id: <1390387737-324-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

It does make sense free() dev after it is used. g_free() is not needed
here since it will be already executed in bt_pan_notify_conn_state().
---
 android/pan.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/android/pan.c b/android/pan.c
index bfba128..4e04da0 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -463,7 +463,6 @@ static void nap_confirm_cb(GIOChannel *chan, gpointer data)
 	return;
 
 failed:
-	g_free(dev);
 	bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
 }
 
-- 
1.8.3.2

