Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 3/5] android/hal-gatt-api: Simplify GATT Read Char. event
Date: Wed,  5 Mar 2014 09:59:48 +0100
Message-Id: <1394009990-5795-3-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1394009990-5795-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1394009990-5795-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Make nested struct open coded for simplicity.
---
 android/hal-ipc-api.txt | 5 ++---
 android/hal-msg.h       | 8 ++------
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index e88a85d..8d512dd 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1904,11 +1904,10 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		                            GATT Descr. ID (17 octets)
 		                            Value Type (4 octets)
 		                            Status (1 octet)
-		                            Unformatted Value (variable)
+		                            Length (2 octets)
+		                            Value (variable)
 		Valid GATT Service ID: As described in Get Characteristic
 		Valid GATT Char. & Decr. ID: As described in Get Descriptor
-		Valid Unformatted Value: Length (2 octets)
-		                         Value (variable)
 
 	Opcode 0x8d - Write Characteristic notification
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 5511297..546172b 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1316,18 +1316,14 @@ struct hal_ev_gatt_client_notify {
 } __attribute__((packed));
 
 #define HAL_EV_GATT_CLIENT_READ_CHARACTERISTIC	0x8c
-struct hal_gatt_unformated_value {
-	uint16_t len;
-	uint8_t  value[0];
-} __attribute__((packed));
-
 struct hal_gatt_read_params {
 	struct hal_gatt_srvc_id srvc_id;
 	struct hal_gatt_gatt_id char_id;
 	struct hal_gatt_gatt_id descr_id;
 	uint8_t  status;
 	uint16_t value_type;
-	struct hal_gatt_unformated_value value;
+	uint16_t len;
+	uint8_t  value[0];
 } __attribute__((packed));
 
 struct hal_ev_gatt_client_read_characteristic {
-- 
1.9.0

