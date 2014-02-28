Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 18/18] android/hal-gatt-api: Add Client Listen event
Date: Fri, 28 Feb 2014 11:24:03 +0100
Message-Id: <1393583043-23455-18-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1393583043-23455-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1393583043-23455-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 3 +++
 android/hal-msg.h       | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 5f2561a..04c0b7c 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1946,6 +1946,9 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 
 	Opcode 0x92 - Listen notification
 
+		Notification parameters: Status (4 octets)
+		                         Server Interface (4 octets)
+
 	Opcode 0x93 - Register Server notification
 	Opcode 0x94 - Connection notification
 	Opcode 0x95 - Service Added notification
diff --git a/android/hal-msg.h b/android/hal-msg.h
index b7c351d..95ce551 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1392,3 +1392,9 @@ struct hal_ev_gatt_client_read_remote_rssi {
 	int32_t rssi;
 	int32_t status;
 } __attribute__((packed));
+
+#define HAL_EV_GATT_CLIENT_LISTEN		0x92
+struct hal_ev_gatt_client_listen {
+	int32_t status;
+	int32_t server_if;
+} __attribute__((packed));
-- 
1.9.0

