Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 12/12] android/hal-ipc-api: Add Passthrough Command notification
Date: Thu, 13 Feb 2014 17:18:48 +0200
Message-Id: <1392304728-5061-12-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1392304728-5061-1-git-send-email-luiz.dentz@gmail.com>
References: <1392304728-5061-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/hal-ipc-api.txt | 5 +++++
 android/hal-msg.h       | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 99ecede..ee3bd76 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1380,6 +1380,11 @@ Android HAL name: "avrcp" (BT_PROFILE_AV_RC_ID)
 
 		Valid type values: Same as in Register Notification
 
+	Opcode 0x8c - Passthrough Command notification
+
+		Notification parameters: ID (1 octet)
+		                         State (1 octet)
+
 Bluetooth GATT HAL (ID 9)
 =========================
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 0561894..6504408 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -938,3 +938,9 @@ struct hal_ev_avrcp_volume_changed {
 	uint8_t volume;
 	uint8_t type;
 } __attribute__((packed));
+
+#define HAL_EV_AVRCP_PASSTHROUGH_CMD		0x8c
+struct hal_ev_avrcp_passthrough_cmd {
+	uint8_t id;
+	uint8_t state;
+} __attribute__((packed));
-- 
1.8.5.3

