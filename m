Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 13/18] android/hal-gatt-api: Add Client Write Characteristic event
Date: Fri, 28 Feb 2014 11:23:58 +0100
Message-Id: <1393583043-23455-13-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1393583043-23455-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1393583043-23455-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 11 +++++++++++
 android/hal-msg.h       | 14 ++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 0d76967..1ce350d 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1907,6 +1907,17 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		                         Value (variable)
 
 	Opcode 0x8d - Write Characteristic notification
+
+		Notification parameters: Connection ID (4 octets)
+		                         Status (4 octets)
+		                         GATT Write Parameters (53 octets)
+		Valid GATT Write Parameters: GATT Service ID (18 octets)
+		                             GATT Characteristic ID (17 octets)
+		                             GATT Description ID (17 octets)
+		                             Status (1 octet)
+		Valid GATT Service ID: As described in Get Descriptor
+		Valid GATT Char. & Decr. ID: As described in Get Descriptor
+
 	Opcode 0x8e - Read Descriptor notification
 	Opcode 0x8f - Write Descriptor notification
 	Opcode 0x90 - Execute Write notification
diff --git a/android/hal-msg.h b/android/hal-msg.h
index fe87836..c6d9ab4 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1350,3 +1350,17 @@ struct hal_ev_gatt_client_read_characteristic {
 	int32_t status;
 	struct hal_gatt_read_params data;
 } __attribute__((packed));
+
+#define HAL_EV_GATT_CLIENT_WRITE_CHARACTERISTIC	0x8d
+struct hal_gatt_write_params {
+	struct hal_gatt_srvc_id srvc_id;
+	struct hal_gatt_gatt_id char_id;
+	struct hal_gatt_gatt_id descr_id;
+	uint8_t status;
+} __attribute__((packed));
+
+struct hal_ev_gatt_client_write_characteristic {
+	int32_t conn_id;
+	int32_t status;
+	struct hal_gatt_write_params data;
+} __attribute__((packed));
-- 
1.9.0

