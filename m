Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 11/18] android/hal-gatt-api: Add Client Notify event
Date: Fri, 28 Feb 2014 11:23:56 +0100
Message-Id: <1393583043-23455-11-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1393583043-23455-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1393583043-23455-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 12 ++++++++++++
 android/hal-msg.h       | 15 +++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index a5b6cd8..6ee8e9e 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1878,6 +1878,18 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		Valid GATT Char. ID: As described in Get Characteristic
 
 	Opcode 0x8b - Notify notification
+
+		Notification parameters: Connection ID (4 octets)
+		                         Notify Parameters (variable)
+		Valid Notify Parameters: Address (6 octets)
+		                         GATT Service ID (18 octets)
+		                         GATT Char. ID (17 octets)
+		                         Is Notify (1 octet)
+		                         Length (2 octets)
+		                         Value (variable)
+		Valid Service ID: As described in Get Characteristic
+		Valid GATT Char. ID: As described in Get Characteristic
+
 	Opcode 0x8c - Read Characteristic notification
 	Opcode 0x8d - Write Characteristic notification
 	Opcode 0x8e - Read Descriptor notification
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 356a9a2..a089378 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1314,3 +1314,18 @@ struct hal_ev_gatt_client_reg_for_notif {
 	struct hal_gatt_srvc_id srvc_id;
 	struct hal_gatt_gatt_id char_id;
 } __attribute__((packed));
+
+#define HAL_EV_GATT_CLIENT_NOTIFY		0x8b
+struct hal_gatt_notify_params {
+	uint8_t bda[6];
+	struct hal_gatt_srvc_id srvc_id;
+	struct hal_gatt_gatt_id char_id;
+	uint8_t  is_notify;
+	uint16_t len;
+	uint8_t  value[0];
+} __attribute__((packed));
+
+struct hal_ev_gatt_client_notify {
+	int32_t conn_id;
+	struct hal_gatt_notify_params data;
+} __attribute__((packed));
-- 
1.9.0

