Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 1/5] android/hal-gatt-api: Simplify GATT Test cmd struct
Date: Wed,  5 Mar 2014 09:59:46 +0100
Message-Id: <1394009990-5795-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Make nested struct open coded for simplicity.
---
 android/hal-ipc-api.txt | 15 +++++++--------
 android/hal-msg.h       |  8 ++------
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 6bf9af3..6fa0d3b 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1657,14 +1657,13 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 	Opcode 0x16 - Test Command command/response
 
 		Command parameters: Command (4 octets)
-		                    Test Parameters (32 octets)
-		Valid Test Parameter: Address (6 octets)
-		                      UUID (16 octets)
-		                      U1 (2 octets)
-		                      U2 (2 octets)
-		                      U3 (2 octets)
-		                      U4 (2 octets)
-		                      U5 (2 octets)
+		                    Address (6 octets)
+		                    UUID (16 octets)
+		                    U1 (2 octets)
+		                    U2 (2 octets)
+		                    U3 (2 octets)
+		                    U4 (2 octets)
+		                    U5 (2 octets)
 		Response parameters: <none>
 
 		In case of an error, the error response will be returned.
diff --git a/android/hal-msg.h b/android/hal-msg.h
index dd25f6e..c3b1bc3 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -680,7 +680,8 @@ struct hal_cmd_gatt_client_set_adv_data {
 } __attribute__((packed));
 
 #define HAL_OP_GATT_CLIENT_TEST_COMMAND		0x16
-struct hal_gatt_test_params {
+struct hal_cmd_gatt_client_test_command {
+	int32_t command;
 	uint8_t  bda1[6];
 	uint8_t  uuid1[16];
 	uint16_t u1;
@@ -690,11 +691,6 @@ struct hal_gatt_test_params {
 	uint16_t u5;
 } __attribute__((packed));
 
-struct hal_cmd_gatt_client_test_command {
-	int32_t command;
-	struct hal_gatt_test_params params;
-} __attribute__((packed));
-
 #define HAL_OP_GATT_SERVER_REGISTER		0x17
 struct hal_cmd_gatt_server_register {
 	uint8_t uuid[16];
-- 
1.9.0

