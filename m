Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/13] android/hal-gatt-api: Add Server Service Added Notification
Date: Fri, 28 Feb 2014 12:19:54 +0100
Message-Id: <1393586404-25190-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1393586404-25190-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1393586404-25190-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 12 ++++++++++++
 android/hal-msg.h       |  8 ++++++++
 2 files changed, 20 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 70dfb90..eb879ce 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1963,6 +1963,18 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		                         Address (6 octets)
 
 	Opcode 0x95 - Service Added notification
+
+		Notification parameters: Status (4 octets)
+		                         Server (4 octets)
+		                         Service ID (18 octets)
+		                         Service Handle (4 octets)
+
+		Valid Service ID: ID (17 octets)
+		                  Is Primary (1 octet)
+
+		Valid ID: UUID (16 octets)
+		          Instance ID (1 octet)
+
 	Opcode 0x96 - Included Service Added notification
 	Opcode 0x97 - Characteristic Added notification
 	Opcode 0x98 - Descriptor Added notification
diff --git a/android/hal-msg.h b/android/hal-msg.h
index bfc6fce..03267f7 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1413,3 +1413,11 @@ struct hal_ev_gatt_server_connection {
 	int32_t connected;
 	uint8_t bdaddr[6];
 } __attribute__((packed));
+
+#define HAL_EV_GATT_SERVER_SERVICE_ADDED	0x95
+struct hal_ev_gatt_server_service_added {
+	int32_t status;
+	int32_t server_if;
+	struct hal_gatt_srvc_id srvc_id;
+	int32_t srvc_handle;
+} __attribute__((packed));
-- 
1.8.5.2

