Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 10/18] android/hal-gatt-api: Add Client Register for Notification event
Date: Fri, 28 Feb 2014 11:23:55 +0100
Message-Id: <1393583043-23455-10-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1393583043-23455-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1393583043-23455-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 9 +++++++++
 android/hal-msg.h       | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 362f50f..a5b6cd8 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1868,6 +1868,15 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		Valid GATT Service & Incl. Service ID: As described in Search Result
 
 	Opcode 0x8a - Register For Notification notification
+
+		Notification parameters: Connection ID (4 octets)
+		                         Registered (4 octets)
+		                         Status (4 octets)
+		                         GATT Service ID (18 octets)
+		                         GATT Char. ID (17 octets)
+		Valid GATT Service ID: As described in Get Characteristic
+		Valid GATT Char. ID: As described in Get Characteristic
+
 	Opcode 0x8b - Notify notification
 	Opcode 0x8c - Read Characteristic notification
 	Opcode 0x8d - Write Characteristic notification
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 642704c..356a9a2 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1305,3 +1305,12 @@ struct hal_ev_gatt_client_get_inc_service {
 	struct hal_gatt_srvc_id srvc_id;
 	struct hal_gatt_srvc_id incl_srvc_id;
 } __attribute__((packed));
+
+#define HAL_EV_GATT_CLIENT_REGISTER_FOR_NOTIF	0x8a
+struct hal_ev_gatt_client_reg_for_notif {
+	int32_t conn_id;
+	int32_t registered;
+	int32_t status;
+	struct hal_gatt_srvc_id srvc_id;
+	struct hal_gatt_gatt_id char_id;
+} __attribute__((packed));
-- 
1.9.0

