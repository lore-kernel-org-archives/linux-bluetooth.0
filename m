Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCHv2 22/23] android/hal-gatt-api: Add Client Set Advertising Data
Date: Wed, 26 Feb 2014 09:41:20 +0100
Message-Id: <1393404081-1401-23-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1393404081-1401-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1393404081-1401-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 14 ++++++++++++++
 android/hal-msg.h       | 13 +++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 259aa69..a7867f2 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1631,6 +1631,20 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		In case of an error, the error response will be returned.
 
 	Opcode 0x15 - Set Advertising data command/response
+
+		Command parameters: Server Interface (4 octets)
+		                    Set Scan Resp. (1 octet)
+		                    Include Name (1 octet)
+		                    Include TX Power (1 octet)
+		                    Min. Interval (4 octets)
+		                    Max. Interval (4 octets)
+		                    Appearance (4 octets)
+		                    Manufacturer Len. (2 octets)
+		                    Manufacturer Data (variable)
+		Response parameters: <none>
+
+		In case of an error, the error response will be returned.
+
 	Opcode 0x16 - Test Command command/response
 
 	Opcode 0x17 - Register Server command/response
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 316ca62..0820e3f 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -673,6 +673,19 @@ struct hal_cmd_gatt_client_get_device_type {
 	uint8_t bdaddr[6];
 } __attribute__((packed));
 
+#define HAL_OP_GATT_CLIENT_SET_ADV_DATA		0x015
+struct hal_cmd_gatt_client_set_adv_data {
+	int32_t  server_if;
+	uint8_t  set_scan_rsp;
+	uint8_t  include_name;
+	uint8_t  include_txpower;
+	int32_t  min_interval;
+	int32_t  max_interval;
+	int32_t  appearance;
+	uint16_t manufacturer_len;
+	uint8_t  manufacturer_data[0];
+} __attribute__((packed));
+
 /* Notifications and confirmations */
 
 #define HAL_POWER_OFF			0x00
-- 
1.9.0

