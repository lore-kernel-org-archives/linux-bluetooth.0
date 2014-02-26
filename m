Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 23/23] android/hal-gatt-api: Add Client Test Command
Date: Wed, 26 Feb 2014 09:41:21 +0100
Message-Id: <1393404081-1401-24-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1393404081-1401-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1393404081-1401-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 13 +++++++++++++
 android/hal-msg.h       | 16 ++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index a7867f2..9b2c8ae 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1647,6 +1647,19 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 
 	Opcode 0x16 - Test Command command/response
 
+		Command parameters: Command (4 octets)
+		                    Test Parameters (32 octets)
+		Valid Test Parameter: Address (6 octets)
+		                      UUID (16 octets)
+		                      U1 (2 octets)
+		                      U2 (2 octets)
+		                      U3 (2 octets)
+		                      U4 (2 octets)
+		                      U5 (2 octets)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
 	Opcode 0x17 - Register Server command/response
 	Opcode 0x18 - Unregister Server command/response
 	Opcode 0x19 - Connect Peripheral command/response
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 0820e3f..2d8e6b0 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -686,6 +686,22 @@ struct hal_cmd_gatt_client_set_adv_data {
 	uint8_t  manufacturer_data[0];
 } __attribute__((packed));
 
+#define HAL_OP_GATT_CLIENT_TEST_COMMAND		0x16
+struct hal_gatt_test_params {
+	uint8_t  bda1[6];
+	uint8_t  uuid1[16];
+	uint16_t u1;
+	uint16_t u2;
+	uint16_t u3;
+	uint16_t u4;
+	uint16_t u5;
+} __attribute__((packed));
+
+struct hal_cmd_gatt_client_test_command {
+	int32_t command;
+	struct hal_gatt_test_params params;
+} __attribute__((packed));
+
 /* Notifications and confirmations */
 
 #define HAL_POWER_OFF			0x00
-- 
1.9.0

