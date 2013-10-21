Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 06/11] android: Add HAL_SERVICE_ID_MAX define
Date: Mon, 21 Oct 2013 20:56:46 +0200
Message-Id: <1382381811-28123-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1382381811-28123-1-git-send-email-szymon.janc@tieto.com>
References: <1382381811-28123-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 58fff4d..f19d0d0 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -42,6 +42,8 @@ struct hal_msg_hdr {
 #define HAL_SERVICE_ID_AVRCP		8
 #define HAL_SERVICE_ID_GATT		9
 
+#define HAL_SERVICE_ID_MAX HAL_SERVICE_ID_GATT
+
 /* Core Service */
 
 #define HAL_MSG_OP_ERROR		0x00
-- 
1.8.4

