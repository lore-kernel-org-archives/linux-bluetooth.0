Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 07/13] android/hal-gatt-api: Add Server Service Started Notification
Date: Fri, 28 Feb 2014 12:19:58 +0100
Message-Id: <1393586404-25190-7-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1393586404-25190-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1393586404-25190-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 5 +++++
 android/hal-msg.h       | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index f7c9f7d..8bf8af6 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1999,6 +1999,11 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		                         Descriptor Handle (4 octets)
 
 	Opcode 0x99 - Service Started notification
+
+		Notification parameters: Status (4 octets)
+		                         Server (4 octets)
+		                         Service Handle (4 octets)
+
 	Opcode 0x9a - Service Stopped notification
 	Opcode 0x9b - Service Deleted notification
 	Opcode 0x9c - Request Read notification
diff --git a/android/hal-msg.h b/android/hal-msg.h
index e411728..7bba250 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1447,3 +1447,10 @@ struct hal_ev_gatt_server_descriptor_added {
 	int32_t srvc_handle;
 	int32_t descr_handle;
 } __attribute__((packed));
+
+#define HAL_EV_GATT_SERVER_SERVICE_STARTED	0x99
+struct hal_ev_gatt_server_service_started {
+	int32_t status;
+	int32_t server_if;
+	int32_t srvc_handle;
+} __attribute__((packed));
-- 
1.8.5.2

