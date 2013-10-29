Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/6] android: Add missing discovery state definitions to IPC header
Date: Tue, 29 Oct 2013 13:16:56 +0100
Message-Id: <1383049016-23371-6-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1383049016-23371-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1383049016-23371-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-msg.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/hal-msg.h b/android/hal-msg.h
index a4eb2a8..ec4b62a 100644
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

