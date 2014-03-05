Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 4/5] android/hal-gatt-api: Simplify GATT Service ID struct
Date: Wed,  5 Mar 2014 09:59:49 +0100
Message-Id: <1394009990-5795-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1394009990-5795-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1394009990-5795-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Make nested struct open coded for simplicity.
---
 android/hal-ipc-api.txt | 19 +++++++++----------
 android/hal-msg.h       | 11 ++++++-----
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 8d512dd..43b79ec 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1500,7 +1500,8 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		                    Service ID Elements (variable)
 		Valid Number of Service ID Elements: 0x01
 		                                     0x02
-		Valid Service ID Element: GATT ID (17 octets)
+		Valid Service ID Element: UUID (16 octets)
+		                          Instance ID (1 octet)
 		                          Is Primary (1 octet)
 		Valid GATT ID: UUID (16 octets)
 		               Instance ID (1 octet)
@@ -1706,7 +1707,8 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		                    GATT Service ID (18 octets)
 		                    Number of Handles (4 octet)
 
-		Valid GATT Service ID: GATT ID (17 octets)
+		Valid GATT Service ID: UUID (16 octets)
+		                       Instance ID (1 octets)
 		                       Is Primary (1 octet)
 
 		Valid GATT ID: UUID (16 octets)
@@ -1837,10 +1839,9 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 
 		Notification parameters: Connection ID (4 octets)
 		                         GATT Service ID (18 octets)
-		Valid GATT Service ID: GATT ID (17 octets)
+		Valid GATT Service ID: UUID (16 octets)
+		                       Instance ID (1 octets)
 		                       Is Primary (1 octet)
-		Valid GATT ID: UUID (16 octets)
-		               Instance ID (1 octet)
 
 	Opcode 0x87 - Get Characteristic notification
 
@@ -1969,15 +1970,13 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 
 		Notification parameters: Status (4 octets)
 		                         Server (4 octets)
-		                         Service ID (18 octets)
+		                         GATT Service ID (18 octets)
 		                         Service Handle (4 octets)
 
-		Valid Service ID: ID (17 octets)
+		Valid Service ID: UUID (16 octets)
+		                  Instance ID (1 octet)
 		                  Is Primary (1 octet)
 
-		Valid ID: UUID (16 octets)
-		          Instance ID (1 octet)
-
 	Opcode 0x96 - Included Service Added notification
 
 		Notification patemeters: Status (4 octets)
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 546172b..677f450 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -561,13 +561,9 @@ struct hal_cmd_gatt_client_search_service {
 } __attribute__((packed));
 
 #define HAL_OP_GATT_CLIENT_GET_INCLUDED_SERVICE	0x09
-struct hal_gatt_gatt_id {
+struct hal_gatt_srvc_id {
 	uint8_t uuid[16];
 	uint8_t inst_id;
-} __attribute__((packed));
-
-struct hal_gatt_srvc_id {
-	struct hal_gatt_gatt_id gatt_id;
 	uint8_t is_primary;
 } __attribute__((packed));
 
@@ -578,6 +574,11 @@ struct hal_cmd_gatt_client_get_included_service {
 } __attribute__((packed));
 
 #define HAL_OP_GATT_CLIENT_GET_CHARACTERISTIC	0x0a
+struct hal_gatt_gatt_id {
+	uint8_t uuid[16];
+	uint8_t inst_id;
+} __attribute__((packed));
+
 struct hal_cmd_gatt_client_get_characteristic {
 	int32_t conn_id;
 	struct hal_gatt_srvc_id srvc_id;
-- 
1.9.0

