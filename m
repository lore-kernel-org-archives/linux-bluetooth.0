Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 08/16] Process MCAP response mcap_md_create_mdl_rsp
Date: Wed, 28 Jul 2010 10:03:48 +0200
Message-Id: <1280304232-2939-2-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1280304232-2939-1-git-send-email-santoscadenas@gmail.com>
References: <1280304015-9230-7-git-send-email-sancane@gmail.com>
 <1280304232-2939-1-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/mcap.c |  195 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 health/mcap.h |    6 ++
 2 files changed, 200 insertions(+), 1 deletions(-)

diff --git a/health/mcap.c b/health/mcap.c
index 9bb81cf..734c6be 100644
--- a/health/mcap.c
+++ b/health/mcap.c
@@ -126,6 +126,38 @@ static void set_default_cb(struct mcap_mcl *mcl)
 	mcl->cb->mdl_reconn_req = default_mdl_reconn_req_cb;
 }
 
+static char *error2str(uint8_t rc)
+{
+	switch (rc) {
+	case MCAP_SUCCESS:
+		return "Success";
+	case MCAP_INVALID_OP_CODE:
+		return "Invalid Op Code";
+	case MCAP_INVALID_PARAM_VALUE:
+		return "Invalid Parameter Value";
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
 static void mcap_send_std_opcode(struct mcap_mcl *mcl, void *cmd,
 						uint32_t size, GError **err)
 {
@@ -854,9 +886,170 @@ static void proc_req_active(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 	}
 }
 
+/* Function used to process replies */
+static gboolean check_err_rsp(struct mcap_mcl *mcl, uint8_t *cmd,
+				uint32_t rlen, uint32_t len, GError **gerr)
+{
+	mcap_md_req *cmdlast = (mcap_md_req *) mcl->lcmd;
+	gint err = MCAP_ERROR_FAILED;
+	gboolean close = FALSE;
+	uint16_t rmdl, smdl;
+	mcap_rsp *rsp;
+	char *msg;
+
+	if (cmd[0] == MCAP_ERROR_RSP) {
+		msg = "MCAP_ERROR_RSP received";
+		close = TRUE;
+		goto fail;
+	}
+
+	/* Check if the response matches with the last request */
+	if (rlen < sizeof(mcap_rsp) || (mcl->lcmd[0] + 1) != cmd[0]) {
+		msg = "Protocol error";
+		close = TRUE;
+		goto fail;
+	}
+
+	if (rlen < len) {
+		msg = "Protocol error";
+		close = TRUE;
+		goto fail;
+	}
+
+	rsp = (mcap_rsp *)cmd;
+	smdl = ntohs(cmdlast->mdl);
+	rmdl = ntohs(rsp->mdl);
+	if (rmdl != smdl) {
+		msg = "MDLID received doesn't match with MDLID sent";
+		close = TRUE;
+		goto fail;
+	}
+
+	if (rsp->rc == MCAP_REQUEST_NOT_SUPPORTED) {
+		msg = "Remote does not support opcodes";
+		mcl->ctrl &= ~MCAP_CTRL_STD_OP;
+		goto fail;
+	}
+
+	if (rsp->rc == MCAP_UNSPECIFIED_ERROR) {
+		msg = "Unspecified error";
+		close = TRUE;
+		goto fail;
+	}
+
+	if (rsp->rc != MCAP_SUCCESS) {
+		msg = error2str(rsp->rc);
+		err = rsp->rc;
+		goto fail;
+	}
+
+	return FALSE;
+
+fail:
+	g_set_error(gerr, MCAP_ERROR, err, "%s", msg);
+	return close;
+}
+
+static gboolean process_md_create_mdl_rsp(struct mcap_mcl *mcl,
+						uint8_t *cmd, uint32_t len)
+{
+	mcap_md_create_mdl_req *cmdlast = (mcap_md_create_mdl_req *)mcl->lcmd;
+	struct mcap_mdl_op_cb *conn = mcl->priv_data;
+	mcap_mdl_operation_conf_cb connect_cb = conn->cb.op_conf;
+	gpointer user_data = conn->user_data;
+	struct mcap_mdl *mdl = conn->mdl;
+	uint8_t conf = cmdlast->conf;
+	gboolean close = FALSE;
+	GError *gerr = NULL;
+	uint8_t *param;
+
+	g_free(mcl->priv_data);
+	mcl->priv_data = NULL;
+
+	close = check_err_rsp(mcl, cmd, len, sizeof(mcap_rsp) + 1, &gerr);
+	g_free(mcl->lcmd);
+	mcl->lcmd = NULL;
+	mcl->req = MCL_AVAILABLE;
+
+	if (gerr)
+		goto fail;
+
+	if (len < sizeof(mcap_rsp)) {
+		g_set_error(&gerr, MCAP_ERROR, MCAP_ERROR_FAILED,
+							"Protocol error");
+		close = TRUE;
+		goto fail;
+	}
+
+	param = cmd + sizeof(mcap_rsp);
+	/* Check if preferences changed */
+	if (conf != 0x00 && *param != conf) {
+		g_set_error(&gerr, MCAP_ERROR, MCAP_ERROR_FAILED,
+						"Configuration changed");
+		close = TRUE;
+		goto fail;
+	}
+
+	connect_cb(mdl, *param, gerr, user_data);
+	return close;
+fail:
+	connect_cb(NULL, 0, gerr, user_data);
+	mcl->mdls = g_slist_remove(mcl->mdls, mdl);
+	g_free(mdl);
+	g_error_free(gerr);
+	update_mcl_state(mcl);
+	return close;
+}
+
+static gboolean process_md_reconnect_mdl_rsp(struct mcap_mcl *mcl,
+						uint8_t *cmd, uint32_t len)
+{
+	/* TODO: Implement process_md_reconnect_mdl_rsp */
+	return TRUE;
+}
+
+static gboolean process_md_abort_mdl_rsp(struct mcap_mcl *mcl,
+						uint8_t *cmd, uint32_t len)
+{
+	/* TODO: Implement process_md_abort_mdl_rsp */
+	return TRUE;
+}
+
+static gboolean process_md_delete_mdl_rsp(struct mcap_mcl *mcl, uint8_t *cmd,
+								uint32_t len)
+{
+	/* TODO: Implement process_md_delete_mdl_rsp */
+	return TRUE;
+}
+
 static void proc_response(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 {
-	/* TODO: Implement proc_response */
+	gboolean close;
+	RELEASE_TIMER(mcl);
+
+	switch (mcl->lcmd[0] + 1) {
+	case MCAP_MD_CREATE_MDL_RSP:
+		close = process_md_create_mdl_rsp(mcl, cmd, len);
+		break;
+	case MCAP_MD_RECONNECT_MDL_RSP:
+		close = process_md_reconnect_mdl_rsp(mcl, cmd, len);
+		break;
+	case MCAP_MD_ABORT_MDL_RSP:
+		close = process_md_abort_mdl_rsp(mcl, cmd, len);
+		break;
+	case MCAP_MD_DELETE_MDL_RSP:
+		close = process_md_delete_mdl_rsp(mcl, cmd, len);
+		break;
+	default:
+		DBG("Unknown cmd response received (op code = %d)",cmd[0]);
+		close = TRUE;
+		break;
+	}
+
+	if (close) {
+		mcl->ms->mcl_disconnected_cb(mcl, mcl->ms->user_data);
+		mcap_cache_mcl(mcl);
+	}
 }
 
 static void proc_cmd(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
diff --git a/health/mcap.h b/health/mcap.h
index d0d552a..1c72080 100644
--- a/health/mcap.h
+++ b/health/mcap.h
@@ -90,6 +90,12 @@ typedef struct {
 	uint8_t		conf;
 } __attribute__ ((packed)) mcap_md_create_mdl_req;
 
+typedef struct {
+        uint8_t         op;
+        uint16_t        mdl;
+} __attribute__ ((packed)) mcap_md_req;
+
+
 /*
  * MCAP Response Packet Format
  */
-- 
1.7.0.4

