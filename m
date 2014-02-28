Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 11/13] android/hal-gatt-api: Add Server Request Write Notification
Date: Fri, 28 Feb 2014 12:20:02 +0100
Message-Id: <1393586404-25190-11-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1393586404-25190-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1393586404-25190-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 11 +++++++++++
 android/hal-msg.h       | 13 +++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 08dbed6..9aee3ab 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -2026,5 +2026,16 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		                         Is Long (1 octet)
 
 	Opcode 0x9d - Request Write notification
+
+		Notification parameters: Connection ID (4 octets)
+		                         Trans ID (4 octets)
+		                         Address (6 octets)
+		                         Attribute Handle (4 octets)
+		                         Offset (4 octets)
+		                         Length (4 octets)
+		                         Need Response (4 octets)
+		                         Is Prepare (1 octet)
+		                         Value (variable)
+
 	Opcode 0x9e - Request Execute Write notification
 	Opcode 0x9f - Response Confirmation notification
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 7d54d29..ad57e23 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1478,3 +1478,16 @@ struct hal_ev_gatt_server_request_read {
 	int32_t offset;
 	uint8_t is_long;
 } __attribute__((packed));
+
+#define HAL_EV_GATT_SERVER_REQUEST_WRITE	0x9d
+struct hal_ev_gatt_server_request_write {
+	int32_t conn_id;
+	int32_t trans_id;
+	uint8_t bdaddr[6];
+	int32_t attr_handle;
+	int32_t offset;
+	int32_t length;
+	uint8_t need_rsp;
+	uint8_t is_prep;
+	uint8_t value[0];
+} __attribute__((packed));
-- 
1.8.5.2

