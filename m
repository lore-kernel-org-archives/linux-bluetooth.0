Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 6/6] android: Add missing discovery state definitions to IPC header
Date: Wed, 30 Oct 2013 11:00:32 +0100
Message-Id: <1383127232-25147-7-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1383127232-25147-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1383127232-25147-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index 80b47d6..d2a0e2a 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -348,6 +348,9 @@ struct hal_ev_device_found {
 	struct hal_property props[0];
 } __attribute__((packed));
 
+#define HAL_DISCOVERY_STATE_STOPPED	0x00
+#define HAL_DISCOVERY_STATE_STARTED	0x01
+
 #define HAL_EV_DISCOVERY_STATE_CHANGED	0x85
 struct hal_ev_discovery_state_changed {
 	uint8_t state;
-- 
1.8.4.1

