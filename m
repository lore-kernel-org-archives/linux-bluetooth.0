Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 12/18] android/hal-gatt-api: Add Client Read Characteristic event
Date: Fri, 28 Feb 2014 11:23:57 +0100
Message-Id: <1393583043-23455-12-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1393583043-23455-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1393583043-23455-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 15 +++++++++++++++
 android/hal-msg.h       | 21 +++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 6ee8e9e..0d76967 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1891,6 +1891,21 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		Valid GATT Char. ID: As described in Get Characteristic
 
 	Opcode 0x8c - Read Characteristic notification
+
+		Notification parameters: Connection ID (4 octets)
+		                         Status (4 octets)
+		                         GATT Read Parameters (variable)
+		Valid GATT Read Parameters: GATT Service ID (18 octets)
+		                            GATT Char. ID (17 octets)
+		                            GATT Descr. ID (17 octets)
+		                            Value Type (4 octets)
+		                            Status (1 octet)
+		                            Unformatted Value (variable)
+		Valid GATT Service ID: As described in Get Characteristic
+		Valid GATT Char. & Decr. ID: As described in Get Descriptor
+		Valid Unformatted Value: Length (2 octets)
+		                         Value (variable)
+
 	Opcode 0x8d - Write Characteristic notification
 	Opcode 0x8e - Read Descriptor notification
 	Opcode 0x8f - Write Descriptor notification
diff --git a/android/hal-msg.h b/android/hal-msg.h
index a089378..fe87836 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1329,3 +1329,24 @@ struct hal_ev_gatt_client_notify {
 	int32_t conn_id;
 	struct hal_gatt_notify_params data;
 } __attribute__((packed));
+
+#define HAL_EV_GATT_CLIENT_READ_CHARACTERISTIC	0x8c
+struct hal_gatt_unformated_value {
+	uint16_t len;
+	uint8_t  value[0];
+} __attribute__((packed));
+
+struct hal_gatt_read_params {
+	struct hal_gatt_srvc_id srvc_id;
+	struct hal_gatt_gatt_id char_id;
+	struct hal_gatt_gatt_id descr_id;
+	uint8_t  status;
+	uint16_t value_type;
+	struct hal_gatt_unformated_value value;
+} __attribute__((packed));
+
+struct hal_ev_gatt_client_read_characteristic {
+	int32_t conn_id;
+	int32_t status;
+	struct hal_gatt_read_params data;
+} __attribute__((packed));
-- 
1.9.0

