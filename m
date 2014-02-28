Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 04/18] android/hal-gatt-api: Add Client Disconnect event
Date: Fri, 28 Feb 2014 11:23:49 +0100
Message-Id: <1393583043-23455-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1393583043-23455-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1393583043-23455-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 6 ++++++
 android/hal-msg.h       | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 2570023..09916b2 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1817,6 +1817,12 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		                         Address (6 octets)
 
 	Opcode 0x84 - Disconnect Device notification
+
+		Notification parameters: Connection ID (4 octets)
+		                         Status (4 octets)
+		                         Client Interface (4 octets)
+		                         Address (6 octets)
+
 	Opcode 0x85 - Search Complete notification
 	Opcode 0x86 - Search Result notification
 	Opcode 0x87 - Get Characteristic notification
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 8f781e9..42badb5 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1259,3 +1259,11 @@ struct hal_ev_gatt_client_connect {
 	int32_t client_if;
 	uint8_t bda[6];
 } __attribute__((packed));
+
+#define HAL_EV_GATT_CLIENT_DISCONNECT	0x84
+struct hal_ev_gatt_client_disconnect {
+	int32_t conn_id;
+	int32_t status;
+	int32_t client_if;
+	uint8_t bda[6];
+} __attribute__((packed));
-- 
1.9.0

