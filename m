Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 02/13] android/hal-gatt-api: Add Server Connection Notification
Date: Fri, 28 Feb 2014 12:19:53 +0100
Message-Id: <1393586404-25190-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1393586404-25190-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1393586404-25190-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 6 ++++++
 android/hal-msg.h       | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index bed8caf..70dfb90 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1956,6 +1956,12 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		                         UUID (16 octets)
 
 	Opcode 0x94 - Connection notification
+
+		Notification parameters: Connection ID (4 octets)
+		                         Server (4 octets)
+		                         Connected (4 octets)
+		                         Address (6 octets)
+
 	Opcode 0x95 - Service Added notification
 	Opcode 0x96 - Included Service Added notification
 	Opcode 0x97 - Characteristic Added notification
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 340f7ee..bfc6fce 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1405,3 +1405,11 @@ struct hal_ev_gatt_server_register {
 	int32_t server_if;
 	uint8_t uuid[16];
 } __attribute__((packed));
+
+#define HAL_EV_GATT_SERVER_CONNECTION		0x94
+struct hal_ev_gatt_server_connection {
+	int32_t conn_id;
+	int32_t server_if;
+	int32_t connected;
+	uint8_t bdaddr[6];
+} __attribute__((packed));
-- 
1.8.5.2

