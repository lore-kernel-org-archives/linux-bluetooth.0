Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/13] android/hal-gatt-api: Add Server Characteristic Added Notification
Date: Fri, 28 Feb 2014 12:19:56 +0100
Message-Id: <1393586404-25190-5-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1393586404-25190-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1393586404-25190-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 7 +++++++
 android/hal-msg.h       | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 454694d..88bcc12 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1983,6 +1983,13 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		                         Included Service Handle (4 octets)
 
 	Opcode 0x97 - Characteristic Added notification
+
+		Notification parameters: Status (4 octets)
+		                         Server (4 octets)
+		                         UUID (16 octets)
+		                         Service Handle (4 octets)
+		                         Characteristic Handle (4 octets)
+
 	Opcode 0x98 - Descriptor Added notification
 	Opcode 0x99 - Service Started notification
 	Opcode 0x9a - Service Stopped notification
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 0452856..37d1252 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1429,3 +1429,12 @@ struct hal_ev_gatt_server_inc_srvc_added {
 	int32_t srvc_handle;
 	int32_t incl_srvc_handle;
 } __attribute__((packed));
+
+#define HAL_EV_GATT_SERVER_CHAR_ADDED		0x97
+struct hal_ev_gatt_server_characteristic_added {
+	int32_t status;
+	int32_t server_if;
+	uint8_t uuid[16];
+	int32_t srvc_handle;
+	int32_t char_handle;
+} __attribute__((packed));
-- 
1.8.5.2

