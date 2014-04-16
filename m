Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 2/8] android/hal-gatt-api: Fix IPC definition for get_included_service
Date: Thu, 17 Apr 2014 01:10:27 +0200
Message-Id: <1397689833-17557-3-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1397689833-17557-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1397689833-17557-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c          |  9 +++++----
 android/hal-gatt.c      | 11 +++++------
 android/hal-ipc-api.txt | 18 ++++++++++++------
 android/hal-msg.h       |  5 +++--
 4 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index f52cb36..a4a1048 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1647,14 +1647,15 @@ static void handle_client_get_included_service(const void *buf, uint16_t len)
 
 	DBG("");
 
-	if (len != sizeof(*cmd) + (cmd->number * sizeof(cmd->srvc_id[0]))) {
+	if (len != sizeof(*cmd) +
+			(cmd->continuation ? sizeof(cmd->incl_srvc_id[0]) : 0)) {
 		error("Invalid get incl services size (%u bytes), terminating",
 									len);
 		raise(SIGTERM);
 		return;
 	}
 
-	hal_srvc_id_to_element_id(&cmd->srvc_id[0], &match_id);
+	hal_srvc_id_to_element_id(&cmd->srvc_id, &match_id);
 	if (!find_service(cmd->conn_id, &match_id, &device, &prim_service)) {
 		status = HAL_STATUS_FAILED;
 		goto reply;
@@ -1670,10 +1671,10 @@ static void handle_client_get_included_service(const void *buf, uint16_t len)
 	}
 
 	/* Try to use cache here */
-	if (cmd->number == 1) {
+	if (!cmd->continuation) {
 		incl_service = queue_peek_head(prim_service->included);
 	} else {
-		uint8_t inst_id = cmd->srvc_id[1].inst_id;
+		uint8_t inst_id = cmd->incl_srvc_id[0].inst_id;
 		incl_service = queue_find(prim_service->included,
 						match_srvc_by_higher_inst_id,
 						INT_TO_PTR(inst_id));
diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index 0229fc8..b1ba977 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -704,14 +704,13 @@ static bt_status_t get_included_service(int conn_id, btgatt_srvc_id_t *srvc_id,
 
 	cmd->conn_id = conn_id;
 
-	srvc_id_to_hal(&cmd->srvc_id[0], srvc_id);
-	len += sizeof(cmd->srvc_id[0]);
-	cmd->number = 1;
+	srvc_id_to_hal(&cmd->srvc_id, srvc_id);
+	cmd->continuation = 0;
 
 	if (start_incl_srvc_id) {
-		srvc_id_to_hal(&cmd->srvc_id[1], start_incl_srvc_id);
-		len += sizeof(cmd->srvc_id[1]);
-		cmd->number++;
+		srvc_id_to_hal(&cmd->incl_srvc_id[0], start_incl_srvc_id);
+		len += sizeof(cmd->incl_srvc_id[0]);
+		cmd->continuation = 1;
 	}
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 67da4ec..906cfc7 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1521,15 +1521,21 @@ Commands and responses:
 	Opcode 0x09 - Get Included Service command/response
 
 		Command parameters: Connection ID (4 octets)
-		                    Number of GATT Service ID Elements (1 octet)
-		                    GATT Service ID # UUID (16 octets)
-		                    GATT Service ID # Instance ID (1 octet)
-		                    GATT Service ID # Is Primary (1 octet)
+		                    GATT Service ID (18 octets)
+		                    Continuation (1 octet)
+		                    GATT Included Service ID (18 octets)
 		                    ...
 		Response parameters: <none>
 
-		Valid Number of GATT Service ID Elements: 0x01
-		                                          0x02
+		Valid GATT Service ID: UUID (16 octets)
+		                       Instance ID (1 octet)
+		                       Is Primary (1 octet)
+
+		Valid GATT Included Service ID: UUID (16 octets)
+		                                Instance ID (1 octet)
+		                                Is Primary (1 octet)
+
+		GATT Included Service ID shall only be present when Continuation is non-zero.
 
 		In case of an error, the error response will be returned.
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index caf6ad9..7a49244 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -616,8 +616,9 @@ struct hal_gatt_srvc_id {
 
 struct hal_cmd_gatt_client_get_included_service {
 	int32_t conn_id;
-	uint8_t number;
-	struct hal_gatt_srvc_id srvc_id[0];
+	struct hal_gatt_srvc_id srvc_id;
+	uint8_t continuation;
+	struct hal_gatt_srvc_id incl_srvc_id[0];
 } __attribute__((packed));
 
 #define HAL_OP_GATT_CLIENT_GET_CHARACTERISTIC	0x0a
-- 
1.9.2

