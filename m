Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/13] android/hal-gatt-api: Add Server Service Deleted Notification
Date: Fri, 28 Feb 2014 12:20:00 +0100
Message-Id: <1393586404-25190-9-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1393586404-25190-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1393586404-25190-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 5 +++++
 android/hal-msg.h       | 7 +++++++
 2 files changed, 12 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 116dfba..5cf22a8 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -2011,6 +2011,11 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		                         Service Handle (4 octets)
 
 	Opcode 0x9b - Service Deleted notification
+
+		Notification parameters: Status (4 octets)
+		                         Server (4 octets)
+		                         Service Handle (4 octets)
+
 	Opcode 0x9c - Request Read notification
 	Opcode 0x9d - Request Write notification
 	Opcode 0x9e - Request Execute Write notification
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 4219312..ee4ac18 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1461,3 +1461,10 @@ struct hal_ev_gatt_server_service_stopped {
 	int32_t server_if;
 	int32_t srvc_handle;
 } __attribute__((packed));
+
+#define HAL_EV_GATT_SERVER_SERVICE_DELETED	0x9b
+struct hal_ev_gatt_server_service_deleted {
+	int32_t status;
+	int32_t server_if;
+	int32_t srvc_handle;
+} __attribute__((packed));
-- 
1.8.5.2

