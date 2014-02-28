Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 16/18] android/hal-gatt-api: Add Client Exec Write event
Date: Fri, 28 Feb 2014 11:24:01 +0100
Message-Id: <1393583043-23455-16-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1393583043-23455-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1393583043-23455-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 4 ++++
 android/hal-msg.h       | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 0b1fb7d..0a269b2 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1933,6 +1933,10 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		Valid GATT Write Parameters: As described in Write Characteristic
 
 	Opcode 0x90 - Execute Write notification
+
+		Notification parameters: Connection ID (4 octets)
+		                         Status (4 octets)
+
 	Opcode 0x91 - Read Remote RSSI notification
 	Opcode 0x92 - Listen notification
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index b3d5fd2..8c8e3fa 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1378,3 +1378,9 @@ struct hal_ev_gatt_client_write_descriptor {
 	int32_t status;
 	struct hal_gatt_write_params data;
 } __attribute__((packed));
+
+#define HAL_EV_GATT_CLIENT_EXEC_WRITE		0x90
+struct hal_ev_gatt_client_exec_write {
+	int32_t conn_id;
+	int32_t status;
+} __attribute__((packed));
-- 
1.9.0

