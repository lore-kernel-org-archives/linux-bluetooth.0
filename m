Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 3/8] android/hal-gatt-api: Fix IPC definition for get_characteristic
Date: Thu, 17 Apr 2014 01:10:28 +0200
Message-Id: <1397689833-17557-4-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1397689833-17557-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1397689833-17557-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c          |  6 +++---
 android/hal-gatt.c      |  8 ++++----
 android/hal-ipc-api.txt | 11 ++++++-----
 android/hal-msg.h       |  4 ++--
 4 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index a4a1048..9d0b2a2 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1799,7 +1799,7 @@ static void handle_client_get_characteristic(const void *buf, uint16_t len)
 
 	DBG("");
 
-	if (len != sizeof(*cmd) + (cmd->number * sizeof(cmd->gatt_id[0]))) {
+	if (len != sizeof(*cmd) + (cmd->continuation ? sizeof(cmd->char_id[0]) : 0)) {
 		error("Invalid get characteristic size (%u bytes), terminating",
 									len);
 		raise(SIGTERM);
@@ -1843,9 +1843,9 @@ static void handle_client_get_characteristic(const void *buf, uint16_t len)
 		goto done;
 	}
 
-	if (cmd->number)
+	if (cmd->continuation)
 		ch = queue_find(srvc->chars, match_char_by_higher_inst_id,
-					INT_TO_PTR(cmd->gatt_id[0].inst_id));
+					INT_TO_PTR(cmd->char_id[0].inst_id));
 	else
 		ch = queue_peek_head(srvc->chars);
 
diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index b1ba977..c5ea9da 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -731,12 +731,12 @@ static bt_status_t get_characteristic(int conn_id, btgatt_srvc_id_t *srvc_id,
 	cmd->conn_id = conn_id;
 
 	srvc_id_to_hal(&cmd->srvc_id, srvc_id);
-	cmd->number = 0;
+	cmd->continuation = 0;
 
 	if (start_char_id) {
-		gatt_id_to_hal(&cmd->gatt_id[0], start_char_id);
-		len += sizeof(cmd->gatt_id[0]);
-		cmd->number = 1;
+		gatt_id_to_hal(&cmd->char_id[0], start_char_id);
+		len += sizeof(cmd->char_id[0]);
+		cmd->continuation = 1;
 	}
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 906cfc7..7a20f56 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1543,9 +1543,8 @@ Commands and responses:
 
 		Command parameters: Connection ID (4 octets)
 		                    GATT Service ID (18 octets)
-		                    Number of GATT ID Elements (1 octet)
-		                    GATT ID # UUID (16 octets)
-		                    GATT ID # Instance ID (1 octet)
+		                    Continuation (1 octet)
+		                    GATT Characteristic ID (17 octets)
 		                    ...
 		Response parameters: <none>
 
@@ -1553,8 +1552,10 @@ Commands and responses:
 		                       Instance ID (1 octet)
 		                       Is Primary (1 octet)
 
-		Valid Number of GATT ID Elements: 0x00
-		                                  0x01
+		Valid GATT Characteristic ID: UUID (16 octets)
+		                              Instance ID (1 octet)
+
+		GATT Characteristic ID shall only be present when Continuation is non-zero.
 
 		In case of an error, the error response will be returned.
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 7a49244..9fec81b 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -630,8 +630,8 @@ struct hal_gatt_gatt_id {
 struct hal_cmd_gatt_client_get_characteristic {
 	int32_t conn_id;
 	struct hal_gatt_srvc_id srvc_id;
-	uint8_t number;
-	struct hal_gatt_gatt_id gatt_id[0];
+	uint8_t continuation;
+	struct hal_gatt_gatt_id char_id[0];
 } __attribute__((packed));
 
 #define HAL_OP_GATT_CLIENT_GET_DESCRIPTOR	0x0b
-- 
1.9.2

