Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 07/18] android/hal-gatt-api: Add Client Get Characteristic event
Date: Fri, 28 Feb 2014 11:23:52 +0100
Message-Id: <1393583043-23455-7-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1393583043-23455-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1393583043-23455-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 10 ++++++++++
 android/hal-msg.h       |  9 +++++++++
 2 files changed, 19 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index fd2adac..c98c2ba 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1838,6 +1838,16 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		               Instance ID (1 octet)
 
 	Opcode 0x87 - Get Characteristic notification
+
+		Notification parameters: Connection ID (4 octets)
+		                         Status (4 octets)
+		                         GATT Service ID (18 octets)
+		                         GATT Char. ID (17 octets)
+		                         Char Prop. (4 octets)
+		Valid GATT Service: As described in Search Result
+		Valid GATT Char. ID: UUID (16 octets)
+		                     Instance ID (1 octet)
+
 	Opcode 0x88 - Get Descriptor notification
 	Opcode 0x89 - Get Included Service notification
 	Opcode 0x8a - Register For Notification notification
diff --git a/android/hal-msg.h b/android/hal-msg.h
index daea6ed..148bd44 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1279,3 +1279,12 @@ struct hal_ev_gatt_client_search_result {
 	int32_t conn_id;
 	struct hal_gatt_srvc_id srvc_id;
 } __attribute__((packed));
+
+#define HAL_EV_GATT_CLIENT_GET_CHARACTERISTIC	0x87
+struct hal_ev_gatt_client_get_characteristic {
+	int32_t conn_id;
+	int32_t status;
+	struct hal_gatt_srvc_id srvc_id;
+	struct hal_gatt_gatt_id char_id;
+	int32_t char_prop;
+} __attribute__((packed));
-- 
1.9.0

