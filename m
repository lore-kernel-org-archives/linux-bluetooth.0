Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 05/18] android/hal-gatt-api: Add Client Search Complete event
Date: Fri, 28 Feb 2014 11:23:50 +0100
Message-Id: <1393583043-23455-5-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1393583043-23455-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1393583043-23455-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-ipc-api.txt | 4 ++++
 android/hal-msg.h       | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 09916b2..9a83ad6 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1824,6 +1824,10 @@ Android HAL name: "gatt" (BT_PROFILE_GATT_ID)
 		                         Address (6 octets)
 
 	Opcode 0x85 - Search Complete notification
+
+		Notification parameters: Connection ID (4 octets)
+		                         Status (4 octets)
+
 	Opcode 0x86 - Search Result notification
 	Opcode 0x87 - Get Characteristic notification
 	Opcode 0x88 - Get Descriptor notification
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 42badb5..abbc0c7 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -1267,3 +1267,9 @@ struct hal_ev_gatt_client_disconnect {
 	int32_t client_if;
 	uint8_t bda[6];
 } __attribute__((packed));
+
+#define HAL_EV_GATT_CLIENT_SEARCH_COMPLETE	0x85
+struct hal_ev_gatt_client_search_complete {
+	int32_t conn_id;
+	int32_t status;
+} __attribute__((packed));
-- 
1.9.0

