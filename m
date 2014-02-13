Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 02/12] android/hal-ipc-api: Add Get Play Status notification
Date: Thu, 13 Feb 2014 17:18:38 +0200
Message-Id: <1392304728-5061-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392304728-5061-1-git-send-email-luiz.dentz@gmail.com>
References: <1392304728-5061-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-ipc-api.txt | 3 +++
 android/hal-msg.h       | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 70f947d..ce50b6c 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1311,6 +1311,9 @@ Android HAL name: "avrcp" (BT_PROFILE_AV_RC_ID)
 		                        0x03 = Browse
 
 	Opcode 0x82 - Get Play Status notification
+
+		Notification parameters: <none>
+
 	Opcode 0x83 - List Player Application Attributes notification
 	...
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index f6cdf58..7dfbf2a 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -887,3 +887,5 @@ struct hal_ev_avrcp_remote_features {
 	uint8_t bdaddr[6];
 	uint8_t features;
 } __attribute__((packed));
+
+#define HAL_EV_AVRCP_GET_PLAY_STATUS		0x82
-- 
1.8.5.3

