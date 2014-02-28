Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 17/18] android/hal-gatt-api: Add Client Read Remote RSSI event
Date: Fri, 28 Feb 2014 11:24:02 +0100
Message-Id: <1393583043-23455-17-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1393583043-23455-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1393583043-23455-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 6 ++++++
 android/hal-msg.h       | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 0a269b2..5f2561a 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1938,6 +1938,12 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		                         Status (4 octets)
 
 	Opcode 0x91 - Read Remote RSSI notification
+
+		Notification parameters: Client (4 octets)
+		                         Address (6 octets)
+		                         RSSI (4 octets)
+		                         Status (4 octets)
+
 	Opcode 0x92 - Listen notification
 
 	Opcode 0x93 - Register Server notification
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 8c8e3fa..b7c351d 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1384,3 +1384,11 @@ struct hal_ev_gatt_client_exec_write {
 	int32_t conn_id;
 	int32_t status;
 } __attribute__((packed));
+
+#define HAL_EV_GATT_CLIENT_READ_REMOTE_RSSI	0x91
+struct hal_ev_gatt_client_read_remote_rssi {
+	int32_t client_if;
+	uint8_t address[6];
+	int32_t rssi;
+	int32_t status;
+} __attribute__((packed));
-- 
1.9.0

