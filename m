Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/hal-ipc-api: Fix Add Set Volume command struct packing
Date: Tue, 25 Feb 2014 16:50:53 +0100
Message-Id: <1393343453-4105-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds missed packed struct attribute to hal-ipc command.
---
 android/hal-msg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 7c6110a..ee08c37 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -987,7 +987,7 @@ struct hal_cmd_avrcp_register_notification {
 #define HAL_OP_AVRCP_SET_VOLUME			0x0a
 struct hal_cmd_avrcp_set_volume {
 	uint8_t value;
-};
+} __attribute__((packed));
 
 #define HAL_EV_AVRCP_REMOTE_FEATURES		0x81
 struct hal_ev_avrcp_remote_features {
-- 
1.8.5.2

