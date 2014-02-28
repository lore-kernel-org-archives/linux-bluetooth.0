Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 09/18] android/hal-gatt-api: Add Client Get Included Service event
Date: Fri, 28 Feb 2014 11:23:54 +0100
Message-Id: <1393583043-23455-9-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1393583043-23455-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1393583043-23455-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 7 +++++++
 android/hal-msg.h       | 8 ++++++++
 2 files changed, 15 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index b004200..362f50f 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1860,6 +1860,13 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		                      Instance ID (1 octet)
 
 	Opcode 0x89 - Get Included Service notification
+
+		Notification parameters: Connection ID (4 octets)
+		                         Status (4 octets)
+		                         GATT Service ID (18 octets)
+		                         GATT Incl. Service ID (18 octets)
+		Valid GATT Service & Incl. Service ID: As described in Search Result
+
 	Opcode 0x8a - Register For Notification notification
 	Opcode 0x8b - Notify notification
 	Opcode 0x8c - Read Characteristic notification
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 033d4c4..642704c 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1297,3 +1297,11 @@ struct hal_ev_gatt_client_get_descriptor {
 	struct hal_gatt_gatt_id char_id;
 	struct hal_gatt_gatt_id descr_id;
 } __attribute__((packed));
+
+#define HAL_EV_GATT_CLIENT_GET_INC_SERVICE	0X89
+struct hal_ev_gatt_client_get_inc_service {
+	int32_t conn_id;
+	int32_t status;
+	struct hal_gatt_srvc_id srvc_id;
+	struct hal_gatt_srvc_id incl_srvc_id;
+} __attribute__((packed));
-- 
1.9.0

