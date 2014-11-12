Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/hal: Fix last service id number
Date: Wed, 12 Nov 2014 10:22:06 +0200
Message-Id: <1415780526-20367-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-msg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index eedd37b..773af5b 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -39,7 +39,7 @@ static const char BLUEZ_HAL_SK_PATH[] = "\0bluez_hal_socket";
 #define HAL_SERVICE_ID_MAP_CLIENT	11
 #define HAL_SERVICE_ID_AVRCP_CTRL	12
 
-#define HAL_SERVICE_ID_MAX HAL_SERVICE_ID_MAP_CLIENT
+#define HAL_SERVICE_ID_MAX HAL_SERVICE_ID_AVRCP_CTRL
 
 /* Core Service */
 
-- 
1.9.1

