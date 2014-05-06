Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] android/gatt: Fix included service notification send
Date: Tue,  6 May 2014 11:57:03 +0200
Message-Id: <1399370226-19126-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In case of service not found there was read from invalid memory of a
primary service needed by send notification. Also there is no need to
additionaly check if included service is null outside notifiaction
function because it's already done in this function.
---
 android/gatt.c | 50 ++++++++++++++++++--------------------------------
 1 file changed, 18 insertions(+), 32 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index e768856..bbf899f 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1600,7 +1600,7 @@ reply:
 			HAL_OP_GATT_CLIENT_SEARCH_SERVICE, status);
 }
 
-static void send_client_incl_service_notify(const struct service *prim,
+static void send_client_incl_service_notify(const struct element_id *srvc_id,
 						const struct service *incl,
 						int32_t conn_id,
 						int32_t status)
@@ -1612,7 +1612,7 @@ static void send_client_incl_service_notify(const struct service *prim,
 	ev.conn_id = conn_id;
 	ev.status = status;
 
-	element_id_to_hal_srvc_id(&prim->id, 1, &ev.srvc_id);
+	element_id_to_hal_srvc_id(srvc_id, 1, &ev.srvc_id);
 
 	if (incl)
 		element_id_to_hal_srvc_id(&incl->id, 0, &ev.incl_srvc_id);
@@ -1642,7 +1642,7 @@ static void get_included_cb(uint8_t status, GSList *included, void *user_data)
 	struct get_included_data *data = user_data;
 	struct app_connection *conn = data->conn;
 	struct service *service = data->prim;
-	struct service *incl;
+	struct service *incl = NULL;
 	int instance_id;
 
 	DBG("");
@@ -1695,15 +1695,9 @@ static void get_included_cb(uint8_t status, GSList *included, void *user_data)
 	 */
 	incl = queue_peek_head(service->included);
 
-	if (incl) {
-		send_client_incl_service_notify(service, incl, conn->id,
-								GATT_SUCCESS);
-		return;
-	}
-
 failed:
-	send_client_incl_service_notify(service, NULL, conn->id,
-								GATT_FAILURE);
+	send_client_incl_service_notify(&service->id, incl, conn->id,
+					incl ? GATT_SUCCESS : GATT_FAILURE);
 }
 
 static bool search_included_services(struct app_connection *connection,
@@ -1758,12 +1752,15 @@ static void handle_client_get_included_service(const void *buf, uint16_t len)
 	const struct hal_cmd_gatt_client_get_included_service *cmd = buf;
 	struct app_connection *conn;
 	struct service *prim_service;
-	struct service *incl_service;
+	struct service *incl_service = NULL;
 	struct element_id match_id;
+	struct element_id srvc_id;
 	uint8_t status;
 
 	DBG("");
 
+	hal_srvc_id_to_element_id(&cmd->srvc_id, &srvc_id);
+
 	if (len != sizeof(*cmd) +
 			(cmd->continuation ? sizeof(cmd->incl_srvc_id[0]) : 0)) {
 		error("Invalid get incl services size (%u bytes), terminating",
@@ -1784,7 +1781,10 @@ static void handle_client_get_included_service(const void *buf, uint16_t len)
 		else
 			status = HAL_STATUS_FAILED;
 
-		goto reply;
+		ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
+				HAL_OP_GATT_CLIENT_GET_INCLUDED_SERVICE,
+				status);
+		return;
 	}
 
 	/* Try to use cache here */
@@ -1797,31 +1797,17 @@ static void handle_client_get_included_service(const void *buf, uint16_t len)
 						INT_TO_PTR(inst_id));
 	}
 
-	/*
-	 * Note that Android framework expects failure notification
-	 * which is treat as the end of included services
-	 */
-	if (!incl_service)
-		send_client_incl_service_notify(prim_service, NULL,
-						conn->id, GATT_FAILURE);
-	else
-		send_client_incl_service_notify(prim_service, incl_service,
-						conn->id, GATT_SUCCESS);
-
 	status = HAL_STATUS_SUCCESS;
 
 reply:
 	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_GATT,
-					HAL_OP_GATT_CLIENT_GET_INCLUDED_SERVICE,
-					status);
+			HAL_OP_GATT_CLIENT_GET_INCLUDED_SERVICE, status);
 
-	/*
-	 * In case of error in handling request we need to send event with
-	 * Android framework is stupid and do not check status of response
+	/* In case of error in handling request we need to send event with
+	 * service id of cmd and gatt failure status.
 	 */
-	if (status)
-		send_client_incl_service_notify(prim_service, NULL,
-						conn->id, GATT_FAILURE);
+	send_client_incl_service_notify(&srvc_id, incl_service, cmd->conn_id,
+					incl_service ? GATT_SUCCESS : GATT_FAILURE);
 }
 
 static void send_client_char_notify(const struct characteristic *ch,
-- 
1.9.2

