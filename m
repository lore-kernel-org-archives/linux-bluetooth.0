Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 02/18] android/hal-gatt-api: Add Client Scan Result event
Date: Fri, 28 Feb 2014 11:23:47 +0100
Message-Id: <1393583043-23455-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1393583043-23455-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1393583043-23455-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 6 ++++++
 android/hal-msg.h       | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 58c05a9..ab9cbc5 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1803,6 +1803,12 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		                         UUID (16 octets)
 
 	Opcode 0x82 - Scan Result notification
+
+		Notification parameters: Address (6 octets)
+		                         RSSI (4 octets)
+		                         Length (2 octets)
+		                         Data (variable)
+
 	Opcode 0x83 - Connect Device notification
 	Opcode 0x84 - Disconnect Device notification
 	Opcode 0x85 - Search Complete notification
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 9f7f9e9..1dad9e1 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1243,3 +1243,11 @@ struct hal_ev_gatt_client_register_client {
 	int32_t client_if;
 	uint8_t app_uuid[16];
 } __attribute__((packed));
+
+#define HAL_EV_GATT_CLIENT_SCAN_RESULT	0x82
+struct hal_ev_gatt_client_scan_result {
+	uint8_t  bda[6];
+	int32_t  rssi;
+	uint16_t len;
+	uint8_t  adv_data[0];
+} __attribute__((packed));
-- 
1.9.0

