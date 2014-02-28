Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 08/18] android/hal-gatt-api: Add Client Get Descriptor event
Date: Fri, 28 Feb 2014 11:23:53 +0100
Message-Id: <1393583043-23455-8-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1393583043-23455-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1393583043-23455-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 10 ++++++++++
 android/hal-msg.h       |  9 +++++++++
 2 files changed, 19 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index c98c2ba..b004200 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1849,6 +1849,16 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		                     Instance ID (1 octet)
 
 	Opcode 0x88 - Get Descriptor notification
+
+		Notification parameters: Connection ID (4 octets)
+		                         Status (4 octets)
+		                         GATT Service ID (18 octets)
+		                         GATT Char. ID (17 octets)
+		                         GATT Descr. ID (17 octets)
+		Valid GATT Service & Char. ID: As described in Get Characteristic
+		Valid GATT Descr. ID: UUID (16 octets)
+		                      Instance ID (1 octet)
+
 	Opcode 0x89 - Get Included Service notification
 	Opcode 0x8a - Register For Notification notification
 	Opcode 0x8b - Notify notification
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 148bd44..033d4c4 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1288,3 +1288,12 @@ struct hal_ev_gatt_client_get_characteristic {
 	struct hal_gatt_gatt_id char_id;
 	int32_t char_prop;
 } __attribute__((packed));
+
+#define HAL_EV_GATT_CLIENT_GET_DESCRIPTOR	0x88
+struct hal_ev_gatt_client_get_descriptor {
+	int32_t conn_id;
+	int32_t status;
+	struct hal_gatt_srvc_id srvc_id;
+	struct hal_gatt_gatt_id char_id;
+	struct hal_gatt_gatt_id descr_id;
+} __attribute__((packed));
-- 
1.9.0

