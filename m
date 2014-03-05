Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 2/5] android/hal-gatt-api: Simplify GATT Notify ev struct
Date: Wed,  5 Mar 2014 09:59:47 +0100
Message-Id: <1394009990-5795-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1394009990-5795-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1394009990-5795-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Make nested struct open coded for simplicity.
---
 android/hal-ipc-api.txt | 3 +--
 android/hal-msg.h       | 8 ++------
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 6fa0d3b..e88a85d 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1885,8 +1885,7 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 	Opcode 0x8b - Notify notification
 
 		Notification parameters: Connection ID (4 octets)
-		                         Notify Parameters (variable)
-		Valid Notify Parameters: Address (6 octets)
+		                         Address (6 octets)
 		                         GATT Service ID (18 octets)
 		                         GATT Char. ID (17 octets)
 		                         Is Notify (1 octet)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index c3b1bc3..5511297 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1305,7 +1305,8 @@ struct hal_ev_gatt_client_reg_for_notif {
 } __attribute__((packed));
 
 #define HAL_EV_GATT_CLIENT_NOTIFY		0x8b
-struct hal_gatt_notify_params {
+struct hal_ev_gatt_client_notify {
+	int32_t conn_id;
 	uint8_t bda[6];
 	struct hal_gatt_srvc_id srvc_id;
 	struct hal_gatt_gatt_id char_id;
@@ -1314,11 +1315,6 @@ struct hal_gatt_notify_params {
 	uint8_t  value[0];
 } __attribute__((packed));
 
-struct hal_ev_gatt_client_notify {
-	int32_t conn_id;
-	struct hal_gatt_notify_params data;
-} __attribute__((packed));
-
 #define HAL_EV_GATT_CLIENT_READ_CHARACTERISTIC	0x8c
 struct hal_gatt_unformated_value {
 	uint16_t len;
-- 
1.9.0

