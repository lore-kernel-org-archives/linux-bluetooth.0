Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 04/13] android/hal-gatt-api: Add Server Included Service Added Notification
Date: Fri, 28 Feb 2014 12:19:55 +0100
Message-Id: <1393586404-25190-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1393586404-25190-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1393586404-25190-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 6 ++++++
 android/hal-msg.h       | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index eb879ce..454694d 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1976,6 +1976,12 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		          Instance ID (1 octet)
 
 	Opcode 0x96 - Included Service Added notification
+
+		Notification patemeters: Status (4 octets)
+		                         Server (4 octets)
+		                         Service Handle (4 octets)
+		                         Included Service Handle (4 octets)
+
 	Opcode 0x97 - Characteristic Added notification
 	Opcode 0x98 - Descriptor Added notification
 	Opcode 0x99 - Service Started notification
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 03267f7..0452856 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1421,3 +1421,11 @@ struct hal_ev_gatt_server_service_added {
 	struct hal_gatt_srvc_id srvc_id;
 	int32_t srvc_handle;
 } __attribute__((packed));
+
+#define HAL_EV_GATT_SERVER_INC_SRVC_ADDED	0x96
+struct hal_ev_gatt_server_inc_srvc_added {
+	int32_t status;
+	int32_t server_if;
+	int32_t srvc_handle;
+	int32_t incl_srvc_handle;
+} __attribute__((packed));
-- 
1.8.5.2

