Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 1/8] android/hal-gatt-api: Fix IPC definition for service_search
Date: Thu, 17 Apr 2014 01:10:26 +0200
Message-Id: <1397689833-17557-2-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1397689833-17557-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1397689833-17557-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-gatt.c      | 2 +-
 android/hal-ipc-api.txt | 8 +++-----
 android/hal-msg.h       | 2 +-
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index 6fde143..0229fc8 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -684,7 +684,7 @@ static bt_status_t search_service(int conn_id, bt_uuid_t *filter_uuid)
 	if (filter_uuid) {
 		memcpy(cmd->filter_uuid, filter_uuid, sizeof(*filter_uuid));
 		len += sizeof(*filter_uuid);
-		cmd->number = 1;
+		cmd->filtered = 1;
 	}
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index a56474c..67da4ec 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1510,13 +1510,11 @@ Commands and responses:
 	Opcode 0x08 - Search Service command/response
 
 		Command parameters: Connection ID (4 octets)
-		                    Number of UUID Filters (1 octet)
-		                    UUID Filter # (16 octets)
-		                    ...
+		                    Filtered (1 octet)
+		                    Filter UUID (16 octets)
 		Response parameters: <none>
 
-		Valid Number of UUID Filters: 0x00
-		                              0x01
+		Filter UUID shall only be present when Filtered is non-zero.
 
 		In case of an error, the error response will be returned.
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index ca36b59..caf6ad9 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -603,7 +603,7 @@ struct hal_cmd_gatt_client_refresh {
 #define HAL_OP_GATT_CLIENT_SEARCH_SERVICE	0x08
 struct hal_cmd_gatt_client_search_service {
 	int32_t conn_id;
-	uint8_t number;
+	uint8_t filtered;
 	uint8_t filter_uuid[0];
 } __attribute__((packed));
 
-- 
1.9.2

