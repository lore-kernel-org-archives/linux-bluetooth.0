Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 4/8] android/hal-gatt-api: Fix IPC definition for get_descriptor
Date: Thu, 17 Apr 2014 01:10:29 +0200
Message-Id: <1397689833-17557-5-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1397689833-17557-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1397689833-17557-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/gatt.c          | 10 +++++-----
 android/hal-gatt.c      | 12 +++++-------
 android/hal-ipc-api.txt | 15 ++++++++++-----
 android/hal-msg.h       |  5 +++--
 4 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index 9d0b2a2..f9ba870 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -2017,8 +2017,8 @@ static void handle_client_get_descriptor(const void *buf, uint16_t len)
 
 	DBG("");
 
-	if ((len != sizeof(*cmd) + cmd->number * sizeof(cmd->gatt_id[0])) ||
-				(cmd->number != 1 && cmd->number != 2)) {
+	if (len != sizeof(*cmd) +
+			(cmd->continuation ? sizeof(cmd->descr_id[0]) : 0)) {
 		error("gatt: Invalid get descr command (%u bytes), terminating",
 									len);
 
@@ -2030,7 +2030,7 @@ static void handle_client_get_descriptor(const void *buf, uint16_t len)
 	primary = cmd->srvc_id.is_primary;
 
 	hal_srvc_id_to_element_id(&cmd->srvc_id, &srvc_id);
-	hal_gatt_id_to_element_id(&cmd->gatt_id[0], &char_id);
+	hal_gatt_id_to_element_id(&cmd->char_id, &char_id);
 
 	if (!find_service(conn_id, &srvc_id, &dev, &srvc)) {
 		error("gatt: Get descr. could not find service");
@@ -2059,10 +2059,10 @@ static void handle_client_get_descriptor(const void *buf, uint16_t len)
 	status = HAL_STATUS_SUCCESS;
 
 	/* Send from cache */
-	if (cmd->number > 1)
+	if (cmd->continuation)
 		descr = queue_find(ch->descriptors,
 					match_descr_by_higher_inst_id,
-					INT_TO_PTR(cmd->gatt_id[1].inst_id));
+					INT_TO_PTR(cmd->descr_id[0].inst_id));
 	else
 		descr = queue_peek_head(ch->descriptors);
 
diff --git a/android/hal-gatt.c b/android/hal-gatt.c
index c5ea9da..bcbeb54 100644
--- a/android/hal-gatt.c
+++ b/android/hal-gatt.c
@@ -758,15 +758,13 @@ static bt_status_t get_descriptor(int conn_id, btgatt_srvc_id_t *srvc_id,
 	cmd->conn_id = conn_id;
 
 	srvc_id_to_hal(&cmd->srvc_id, srvc_id);
-
-	gatt_id_to_hal(&cmd->gatt_id[0], char_id);
-	len += sizeof(cmd->gatt_id[0]);
-	cmd->number = 1;
+	gatt_id_to_hal(&cmd->char_id, char_id);
+	cmd->continuation = 0;
 
 	if (start_descr_id) {
-		gatt_id_to_hal(&cmd->gatt_id[1], start_descr_id);
-		len += sizeof(cmd->gatt_id[1]);
-		cmd->number++;
+		gatt_id_to_hal(&cmd->descr_id[0], start_descr_id);
+		len += sizeof(cmd->descr_id[0]);
+		cmd->continuation = 1;
 	}
 
 	return hal_ipc_cmd(HAL_SERVICE_ID_GATT,
diff --git a/android/hal-ipc-api.txt b/android/hal-ipc-api.txt
index 7a20f56..fa6552e 100644
--- a/android/hal-ipc-api.txt
+++ b/android/hal-ipc-api.txt
@@ -1563,9 +1563,9 @@ Commands and responses:
 
 		Command parameters: Connection ID (4 octets)
 		                    GATT Service ID (18 octets)
-		                    Number of GATT ID Elements (1 octet)
-		                    GATT ID # UUID (16 octets)
-		                    GATT ID # Instance ID (1 octet)
+		                    GATT Characteristic ID (17 octets)
+		                    Continuation (1 octet)
+		                    GATT Descriptor ID (17 octets)
 		                    ...
 		Response parameters: <none>
 
@@ -1573,8 +1573,13 @@ Commands and responses:
 		                       Instance ID (1 octet)
 		                       Is Primary (1 octet)
 
-		Valid Number of GATT ID Elements: 0x01
-		                                  0x02
+		Valid GATT Characteristic ID: UUID (16 octets)
+		                              Instance ID (1 octet)
+
+		Valid GATT Descriptor ID: UUID (16 octets)
+		                          Instance ID (1 octet)
+
+		GATT Descriptor ID shall only be present when Continuation is non-zero.
 
 		In case of an error, the error response will be returned.
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 9fec81b..6b4b2f5 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -638,8 +638,9 @@ struct hal_cmd_gatt_client_get_characteristic {
 struct hal_cmd_gatt_client_get_descriptor {
 	int32_t conn_id;
 	struct hal_gatt_srvc_id srvc_id;
-	uint8_t number;
-	struct hal_gatt_gatt_id gatt_id[0];
+	struct hal_gatt_gatt_id char_id;
+	uint8_t continuation;
+	struct hal_gatt_gatt_id descr_id[0];
 } __attribute__((packed));
 
 #define HAL_OP_GATT_CLIENT_READ_CHARACTERISTIC	0x0c
-- 
1.9.2

