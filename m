Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 01/13] android/hal-gatt-api: Add Server Register Notification
Date: Fri, 28 Feb 2014 12:19:52 +0100
Message-Id: <1393586404-25190-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 5 +++++
 android/hal-msg.h       | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 04c0b7c..bed8caf 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1950,6 +1950,11 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		                         Server Interface (4 octets)
 
 	Opcode 0x93 - Register Server notification
+
+		Notification parameters: Status (4 octets)
+		                         Server (4 octets)
+		                         UUID (16 octets)
+
 	Opcode 0x94 - Connection notification
 	Opcode 0x95 - Service Added notification
 	Opcode 0x96 - Included Service Added notification
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 95ce551..340f7ee 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1398,3 +1398,10 @@ struct hal_ev_gatt_client_listen {
 	int32_t status;
 	int32_t server_if;
 } __attribute__((packed));
+
+#define HAL_EV_GATT_SERVER_REGISTER		0x93
+struct hal_ev_gatt_server_register {
+	int32_t status;
+	int32_t server_if;
+	uint8_t uuid[16];
+} __attribute__((packed));
-- 
1.8.5.2

