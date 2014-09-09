Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 05/39] android/hf-client: Add hf-client ID
Date: Tue,  9 Sep 2014 21:56:50 +0200
Message-Id: <1410292644-23497-6-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1410292644-23497-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 5575d93..986f26b 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -35,8 +35,9 @@ static const char BLUEZ_HAL_SK_PATH[] = "\0bluez_hal_socket";
 #define HAL_SERVICE_ID_HEALTH		7
 #define HAL_SERVICE_ID_AVRCP		8
 #define HAL_SERVICE_ID_GATT		9
+#define HAL_SERVICE_ID_HF_CLIENT	10
 
-#define HAL_SERVICE_ID_MAX HAL_SERVICE_ID_GATT
+#define HAL_SERVICE_ID_MAX HAL_SERVICE_ID_HF_CLIENT
 
 /* Core Service */
 
-- 
1.8.4

