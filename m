Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 13/13] android/hal-gatt-api: Add Server Response Confirmation Notification
Date: Fri, 28 Feb 2014 12:20:04 +0100
Message-Id: <1393586404-25190-13-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1393586404-25190-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1393586404-25190-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 3 +++
 android/hal-msg.h       | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index f4d5c91..0518c2f 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -2045,3 +2045,6 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		                         Execute Write (4 octets)
 
 	Opcode 0x9f - Response Confirmation notification
+
+		Notification parameters: Status (4 octets)
+		                         Handle (4 octets)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 12dc8dc..d885eb1 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1499,3 +1499,9 @@ struct hal_ev_gatt_server_request_exec_write {
 	uint8_t bdaddr[6];
 	int32_t exec_write;
 } __attribute__((packed));
+
+#define HAL_EV_GATT_SERVER_RSP_CONFIRMATION	0x9f
+struct hal_ev_gatt_server_rsp_confirmation {
+	int32_t status;
+	int32_t handle;
+} __attribute__((packed));
-- 
1.8.5.2

