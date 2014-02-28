Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 06/18] android/hal-gatt-api: Add Client Search Result event
Date: Fri, 28 Feb 2014 11:23:51 +0100
Message-Id: <1393583043-23455-6-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1393583043-23455-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1393583043-23455-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 8 ++++++++
 android/hal-msg.h       | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 9a83ad6..fd2adac 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1829,6 +1829,14 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		                         Status (4 octets)
 
 	Opcode 0x86 - Search Result notification
+
+		Notification parameters: Connection ID (4 octets)
+		                         GATT Service ID (18 octets)
+		Valid GATT Service ID: GATT ID (17 octets)
+		                       Is Primary (1 octet)
+		Valid GATT ID: UUID (16 octets)
+		               Instance ID (1 octet)
+
 	Opcode 0x87 - Get Characteristic notification
 	Opcode 0x88 - Get Descriptor notification
 	Opcode 0x89 - Get Included Service notification
diff --git a/android/hal-msg.h b/android/hal-msg.h
index abbc0c7..daea6ed 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1273,3 +1273,9 @@ struct hal_ev_gatt_client_search_complete {
 	int32_t conn_id;
 	int32_t status;
 } __attribute__((packed));
+
+#define HAL_EV_GATT_CLIENT_SEARCH_RESULT	0x86
+struct hal_ev_gatt_client_search_result {
+	int32_t conn_id;
+	struct hal_gatt_srvc_id srvc_id;
+} __attribute__((packed));
-- 
1.9.0

