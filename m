Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 10/13] android/hal-gatt-api: Add Server Request Read Notification
Date: Fri, 28 Feb 2014 12:20:01 +0100
Message-Id: <1393586404-25190-10-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1393586404-25190-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1393586404-25190-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt |  8 ++++++++
 android/hal-msg.h       | 10 ++++++++++
 2 files changed, 18 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 5cf22a8..08dbed6 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -2017,6 +2017,14 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		                         Service Handle (4 octets)
 
 	Opcode 0x9c - Request Read notification
+
+		Notification parameters: Connection ID (4 octets)
+		                         Trans ID (4 octets)
+		                         Address (6 octets)
+		                         Attribute Handle (4 octets)
+		                         Offset (4 octets)
+		                         Is Long (1 octet)
+
 	Opcode 0x9d - Request Write notification
 	Opcode 0x9e - Request Execute Write notification
 	Opcode 0x9f - Response Confirmation notification
diff --git a/android/hal-msg.h b/android/hal-msg.h
index ee4ac18..7d54d29 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1468,3 +1468,13 @@ struct hal_ev_gatt_server_service_deleted {
 	int32_t server_if;
 	int32_t srvc_handle;
 } __attribute__((packed));
+
+#define HAL_EV_GATT_SERVER_REQUEST_READ		0x9c
+struct hal_ev_gatt_server_request_read {
+	int32_t conn_id;
+	int32_t trans_id;
+	uint8_t bdaddr[6];
+	int32_t attr_handle;
+	int32_t offset;
+	uint8_t is_long;
+} __attribute__((packed));
-- 
1.8.5.2

