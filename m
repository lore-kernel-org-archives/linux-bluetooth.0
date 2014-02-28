Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 12/13] android/hal-gatt-api: Add Server Request Execute Write Notification
Date: Fri, 28 Feb 2014 12:20:03 +0100
Message-Id: <1393586404-25190-12-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1393586404-25190-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1393586404-25190-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 6 ++++++
 android/hal-msg.h       | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 9aee3ab..f4d5c91 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -2038,4 +2038,10 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		                         Value (variable)
 
 	Opcode 0x9e - Request Execute Write notification
+
+		Notification parameters: Connection ID (4 octets)
+		                         Trans ID (4 octets)
+		                         Address (6 octets)
+		                         Execute Write (4 octets)
+
 	Opcode 0x9f - Response Confirmation notification
diff --git a/android/hal-msg.h b/android/hal-msg.h
index ad57e23..12dc8dc 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1491,3 +1491,11 @@ struct hal_ev_gatt_server_request_write {
 	uint8_t is_prep;
 	uint8_t value[0];
 } __attribute__((packed));
+
+#define HAL_EV_GATT_SERVER_REQUEST_EXEC_WRITE	0x9e
+struct hal_ev_gatt_server_request_exec_write {
+	int32_t conn_id;
+	int32_t trans_id;
+	uint8_t bdaddr[6];
+	int32_t exec_write;
+} __attribute__((packed));
-- 
1.8.5.2

