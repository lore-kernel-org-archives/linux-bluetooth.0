Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot Nemesio <sancane@gmail.com>
Subject: [PATCH 17/25] Support for sending md_delete_mdl_req command
Date: Wed, 12 May 2010 11:59:24 +0200
Message-Id: <1273658364-17720-1-git-send-email-sancane@gmail.com>
In-Reply-To: <1273486527-7855-17-git-send-email-sancane@gmail.com>
References: <1273486527-7855-17-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Santiago Carot Nemesio <sancane@gmail.com>

---
 mcap/mcap.c |  211 ++++++++++++++++++++++++++++++++++++++++------------------
 1 files changed, 145 insertions(+), 66 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 1d01937..75d3d58 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -76,6 +76,88 @@ static void (*proc_req[])(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len) = {
 static void mcap_cache_mcl(struct mcap_mcl *mcl);
 static void mcap_uncache_mcl(struct mcap_mcl *mcl);
 
+static void default_mdl_connected_cb(struct mcap_mdl *mdl, gpointer data)
+{
+	debug("MCAP Unmanaged mdl connection");
+}
+
+static void default_mdl_closed_cb(struct mcap_mdl *mdl, gpointer data)
+{
+	debug("MCAP Unmanaged mdl clsoed");
+}
+
+static void default_mdl_deleted_cb(struct mcap_mdl *mdl, gpointer data)
+{
+	debug("MCAP Unmanaged mdl deleted");
+}
+
+static void default_mdl_aborted_cb(struct mcap_mdl *mdl, gpointer data)
+{
+	debug("MCAP Unmanaged mdl aborted");
+}
+
+static uint8_t default_mdl_conn_req_cb(struct mcap_mcl *mcl,
+						uint8_t mdepid, uint16_t mdlid,
+						uint8_t *conf, gpointer data)
+{
+	debug("MCAP mdl remote connection aborted");
+	/* Due to this callback is not managed this request won't be supported */
+	return MCAP_REQUEST_NOT_SUPPORTED;
+}
+
+static uint8_t default_mdl_reconn_req_cb(struct mcap_mdl *mdl,
+						gpointer data)
+{
+	debug("MCAP mdl remote reconnection aborted");
+	/* Due to this callback is not managed this request won't be supported */
+	return MCAP_REQUEST_NOT_SUPPORTED;
+}
+
+static void set_default_cb(struct mcap_mcl *mcl)
+{
+	if (!mcl->cb)
+		mcl->cb = g_new0(struct mcap_mdl_cb, 1);
+
+	mcl->cb->mdl_connected = default_mdl_connected_cb;
+	mcl->cb->mdl_closed = default_mdl_closed_cb;
+	mcl->cb->mdl_deleted = default_mdl_deleted_cb;
+	mcl->cb->mdl_aborted = default_mdl_aborted_cb;
+	mcl->cb->mdl_conn_req = default_mdl_conn_req_cb;
+	mcl->cb->mdl_reconn_req = default_mdl_reconn_req_cb;
+}
+
+static char *error2str(uint8_t rc)
+{
+	switch (rc) {
+	case MCAP_SUCCESS:
+		return "Success";
+	case MCAP_INVALID_OP_CODE:
+		return "Invalid Op Code";
+	case MCAP_INVALID_PARAM_VALUE:
+		return "Ivalid Parameter Value";
+	case MCAP_INVALID_MDEP:
+		return "Invalid MDEP";
+	case MCAP_MDEP_BUSY:
+		return "MDEP Busy";
+	case MCAP_INVALID_MDL:
+		return "Invalid MDL";
+	case MCAP_MDL_BUSY:
+		return "MDL Busy";
+	case MCAP_INVALID_OPERATION:
+		return "Invalid Operation";
+	case MCAP_RESOURCE_UNAVAILABLE:
+		return "Resource Unavailable";
+	case MCAP_UNSPECIFIED_ERROR:
+		return "Unspecified Error";
+	case MCAP_REQUEST_NOT_SUPPORTED:
+		return "Request Not Supported";
+	case MCAP_CONFIGURATION_REJECTED:
+		return "Configuration Rejected";
+	default:
+		return "Unknown Response Code";
+	}
+}
+
 static void mcap_send_std_opcode(struct mcap_mcl *mcl, uint8_t *cmd,
 						uint32_t size, GError **err)
 {
@@ -357,86 +439,83 @@ void mcap_req_mdl_reconnect(struct mcap_mdl *mdl,
 	mcl->tid = g_timeout_add_seconds(RESPONSE_TIMER, wait_response_timer, mcl);
 }
 
-static void default_mdl_connected_cb(struct mcap_mdl *mdl, gpointer data)
+static void send_delete_req(GError **err, struct mcap_mcl *mcl,
+				struct mcap_mdl_op_cb *con, uint16_t mdlid)
 {
-	debug("MCAP Unmanaged mdl connection");
-}
+	uint8_t *cmd;
 
-static void default_mdl_closed_cb(struct mcap_mdl *mdl, gpointer data)
-{
-	debug("MCAP Unmanaged mdl clsoed");
-}
+	cmd = create_req(MCAP_MD_DELETE_MDL_REQ, mdlid);
+	mcap_send_std_opcode(mcl, cmd, sizeof(mcap_md_req), err);
+	if (*err) {
+		g_free(cmd);
+		return;
+	}
 
-static void default_mdl_deleted_cb(struct mcap_mdl *mdl, gpointer data)
-{
-	debug("MCAP Unmanaged mdl deleted");
-}
+	mcl->priv_data = con;
 
-static void default_mdl_aborted_cb(struct mcap_mdl *mdl, gpointer data)
-{
-	debug("MCAP Unmanaged mdl aborted");
+	mcl->tid = g_timeout_add_seconds(RESPONSE_TIMER, wait_response_timer, mcl);
 }
 
-static uint8_t default_mdl_conn_req_cb(struct mcap_mcl *mcl,
-						uint8_t mdepid, uint16_t mdlid,
-						uint8_t *conf, gpointer data)
+void mcap_req_mdl_delete_all(struct mcap_mcl *mcl, GError **err,
+			mcap_mdl_del_cb delete_cb, gpointer user_data)
 {
-	debug("MCAP mdl remote connection aborted");
-	/* Due to this callback is not managed this request won't be supported */
-	return MCAP_REQUEST_NOT_SUPPORTED;
-}
+	GSList *l;
+	struct mcap_mdl *mdl;
+	struct mcap_mdl_op_cb *con;
 
-static uint8_t default_mdl_reconn_req_cb(struct mcap_mdl *mdl,
-						gpointer data)
-{
-	debug("MCAP mdl remote reconnection aborted");
-	/* Due to this callback is not managed this request won't be supported */
-	return MCAP_REQUEST_NOT_SUPPORTED;
-}
+	debug("MCL in state: %d", mcl->state);
+	if (!mcl->mdls) {
+		g_set_error(err, MCAP_ERROR, MCAP_ERROR_FAILED,
+				"There are not MDLs created");
+		return;
+	}
 
-static void set_default_cb(struct mcap_mcl *mcl)
-{
-	if (!mcl->cb)
-		mcl->cb = g_new0(struct mcap_mdl_cb, 1);
+	for (l = mcl->mdls; l; l = l->next) {
+		mdl = l->data;
+		if (mdl->state != MDL_WAITING)
+			mdl->state = MDL_DELETING;
+	}
 
-	mcl->cb->mdl_connected = default_mdl_connected_cb;
-	mcl->cb->mdl_closed = default_mdl_closed_cb;
-	mcl->cb->mdl_deleted = default_mdl_deleted_cb;
-	mcl->cb->mdl_aborted = default_mdl_aborted_cb;
-	mcl->cb->mdl_conn_req = default_mdl_conn_req_cb;
-	mcl->cb->mdl_reconn_req = default_mdl_reconn_req_cb;
+	con = g_new0(struct mcap_mdl_op_cb, 1);
+	con->mdl = NULL;
+	con->cb.del = delete_cb;
+	con->user_data = user_data;
+
+	send_delete_req(err, mcl, con, MCAP_ALL_MDLIDS);
+	if (*err)
+		g_free(con);
 }
 
-static char *error2str(uint8_t rc)
+void mcap_req_mdl_deletion(struct mcap_mdl *mdl, GError **err,
+			mcap_mdl_del_cb delete_cb, gpointer user_data)
 {
-	switch (rc) {
-	case MCAP_SUCCESS:
-		return "Success";
-	case MCAP_INVALID_OP_CODE:
-		return "Invalid Op Code";
-	case MCAP_INVALID_PARAM_VALUE:
-		return "Ivalid Parameter Value";
-	case MCAP_INVALID_MDEP:
-		return "Invalid MDEP";
-	case MCAP_MDEP_BUSY:
-		return "MDEP Busy";
-	case MCAP_INVALID_MDL:
-		return "Invalid MDL";
-	case MCAP_MDL_BUSY:
-		return "MDL Busy";
-	case MCAP_INVALID_OPERATION:
-		return "Invalid Operation";
-	case MCAP_RESOURCE_UNAVAILABLE:
-		return "Resource Unavailable";
-	case MCAP_UNSPECIFIED_ERROR:
-		return "Unspecified Error";
-	case MCAP_REQUEST_NOT_SUPPORTED:
-		return "Request Not Supported";
-	case MCAP_CONFIGURATION_REJECTED:
-		return "Configuration Rejected";
-	default:
-		return "Unknown Response Code";
+	struct mcap_mcl *mcl= mdl->mcl;
+	struct mcap_mdl_op_cb *con;
+	GSList *l;
+
+	l = g_slist_find(mcl->mdls, mdl);
+
+	if (!l) {
+		g_set_error(err, MCAP_ERROR, MCAP_ERROR_INVALID_MDL,
+					"%s" , error2str(MCAP_INVALID_MDEP));
+		return;
 	}
+
+	if (mdl->state == MDL_WAITING) {
+		g_set_error(err, MCAP_ERROR, MCAP_ERROR_FAILED,
+							"Mdl is not created");
+		return;
+	}
+	mdl->state = MDL_DELETING;
+
+	con = g_new0(struct mcap_mdl_op_cb, 1);
+	con->mdl = mdl;
+	con->cb.del = delete_cb;
+	con->user_data = user_data;
+
+	send_delete_req(err, mcl, con, mdl->mdlid);
+	if (*err)
+		g_free(con);
 }
 
 static void update_mcl_state(struct mcap_mcl *mcl)
-- 
1.6.3.3

