Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] android/ipc: trivial: Remove empty line
Date: Wed, 22 Jan 2014 18:03:57 +0200
Message-Id: <1390406638-16783-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-msg.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index cfb5460..d46b428 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -391,7 +391,6 @@ struct hal_cmd_pan_disconnect {
 
 /* Notifications and confirmations */
 
-
 #define HAL_POWER_OFF			0x00
 #define HAL_POWER_ON			0x01
 
-- 
1.8.3.2

