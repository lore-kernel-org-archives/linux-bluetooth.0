Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/5] android: Add name property length define
Date: Thu, 31 Oct 2013 15:25:32 +0100
Message-Id: <1383229534-17157-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1383229534-17157-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1383229534-17157-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add define for adapter and remote device name property.

---
 android/hal-msg.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index b792411..8a344d8 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -89,6 +89,8 @@ struct hal_cmd_get_adapter_prop {
 	uint8_t type;
 } __attribute__((packed));
 
+#define HAL_MAX_NAME_LENGTH		249
+
 #define HAL_PROP_ADAPTER_NAME			0x01
 #define HAL_PROP_ADAPTER_ADDR			0x02
 #define HAL_PROP_ADAPTER_UUIDS			0x03
-- 
1.8.4.1

