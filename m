Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/13] android/hal-gatt-api: Add Server Descriptor Added Notification
Date: Fri, 28 Feb 2014 12:19:57 +0100
Message-Id: <1393586404-25190-6-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1393586404-25190-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1393586404-25190-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 7 +++++++
 android/hal-msg.h       | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 88bcc12..f7c9f7d 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1991,6 +1991,13 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		                         Characteristic Handle (4 octets)
 
 	Opcode 0x98 - Descriptor Added notification
+
+		Notification parameters: Status (4 octets)
+		                         Server (4 octets)
+		                         UUID (6 octets)
+		                         Service Handle (4 octets)
+		                         Descriptor Handle (4 octets)
+
 	Opcode 0x99 - Service Started notification
 	Opcode 0x9a - Service Stopped notification
 	Opcode 0x9b - Service Deleted notification
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 37d1252..e411728 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1438,3 +1438,12 @@ struct hal_ev_gatt_server_characteristic_added {
 	int32_t srvc_handle;
 	int32_t char_handle;
 } __attribute__((packed));
+
+#define HAL_EV_GATT_SERVER_DESCRIPTOR_ADDED	0x98
+struct hal_ev_gatt_server_descriptor_added {
+	int32_t status;
+	int32_t server_if;
+	uint8_t uuid[16];
+	int32_t srvc_handle;
+	int32_t descr_handle;
+} __attribute__((packed));
-- 
1.8.5.2

