Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 14/18] android/hal-gatt-api: Add Client Read Descriptor event
Date: Fri, 28 Feb 2014 11:23:59 +0100
Message-Id: <1393583043-23455-14-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1393583043-23455-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1393583043-23455-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 6 ++++++
 android/hal-msg.h       | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 1ce350d..a1852a6 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1919,6 +1919,12 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		Valid GATT Char. & Decr. ID: As described in Get Descriptor
 
 	Opcode 0x8e - Read Descriptor notification
+
+		Notification parameters: Connection ID (4 octets)
+		                         Status (4 octets)
+		                         GATT Read Parameters (variable)
+		Valid GATT Read Parameters: As described in Read Characteristic
+
 	Opcode 0x8f - Write Descriptor notification
 	Opcode 0x90 - Execute Write notification
 	Opcode 0x91 - Read Remote RSSI notification
diff --git a/android/hal-msg.h b/android/hal-msg.h
index c6d9ab4..3bf9c68 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1364,3 +1364,10 @@ struct hal_ev_gatt_client_write_characteristic {
 	int32_t status;
 	struct hal_gatt_write_params data;
 } __attribute__((packed));
+
+#define HAL_EV_GATT_CLIENT_READ_DESCRIPTOR	0x8e
+struct hal_ev_gatt_client_read_descriptor {
+	int32_t conn_id;
+	int32_t status;
+	struct hal_gatt_read_params data;
+} __attribute__((packed));
-- 
1.9.0

