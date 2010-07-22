Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jos=C3=A9=20Antonio=20Santos-Cadenas?=
	<santoscadenas@gmail.com>
Subject: [PATCH 31/60] Fix MCAP bug processing responses
Date: Thu, 22 Jul 2010 10:56:24 +0200
Message-Id: <1279789001-4587-13-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1279789001-4587-12-git-send-email-santoscadenas@gmail.com>
References: <1279788733-2324-19-git-send-email-sancane@gmail.com>
 <1279789001-4587-1-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-2-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-3-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-4-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-5-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-6-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-7-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-8-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-9-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-10-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-11-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-12-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: José Antonio Santos-Cadenas <santoscadenas@gmail.com>

---
 mcap/mcap.c |  138 +++++++++++++++++++++-------------------------------------
 1 files changed, 50 insertions(+), 88 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 34fd43b..d20b3d5 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -1180,31 +1180,59 @@ static void proc_req_active(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 }
 
 /* Function used to process replies */
-static gboolean check_err_rsp(uint16_t rmdl, uint16_t smdl, uint8_t rc,
+static gboolean check_err_rsp(struct mcap_mcl *mcl, uint8_t *cmd,
 				uint32_t rlen, uint32_t len, GError **gerr)
 {
+	mcap_md_req *cmdlast = (mcap_md_req *) mcl->lcmd;
+	gint err = MCAP_ERROR_FAILED;
 	gboolean close = FALSE;
+	uint16_t rmdl, smdl;
+	mcap4B_rsp *rsp;
 	char *msg;
-	gint err = MCAP_ERROR_FAILED;
 
+	/* Check if the response matches with the last request */
+	if ((rlen < 4) || ((mcl->lcmd[0] + 1) != cmd[0])) {
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
+	rsp = (mcap4B_rsp *)cmd;
+	smdl = ntohs(cmdlast->mdl);
+	rmdl = ntohs(rsp->mdl);
 	if (rmdl != smdl) {
-		msg = "MDLID received doesn't match with MDLID sent";
+		msg = "MDLID %d received doesn't match with MDLID %d sent",
+								rmdl, smdl;
 		close = TRUE;
 		goto fail;
 	}
 
-	if ((rc != MCAP_SUCCESS) && (rc <= MCAP_CONFIGURATION_REJECTED)) {
-		msg = error2str(rc);
-		err = rc;
+	if (rsp->rc == MCAP_REQUEST_NOT_SUPPORTED) {
+		msg = "Remote does not support opcodes";
+		mcl->ctrl &= ~MCAP_CTRL_STD_OP;
 		goto fail;
 	}
 
-	if (rlen < len) {
-		msg = "Protocol error";
+	if (rsp->rc == MCAP_UNSPECIFIED_ERROR) {
+		msg = "Unspecified error";
 		close = TRUE;
 		goto fail;
 	}
+
+	if (rsp->rc != MCAP_SUCCESS) {
+		msg = error2str(rsp->rc);
+		err = rsp->rc;
+		goto fail;
+	}
+
 	return FALSE;
+
 fail:
 	g_set_error(gerr, MCAP_ERROR, err, "%s", msg);
 	return close;
@@ -1213,27 +1241,23 @@ fail:
 static gboolean process_md_create_mdl_rsp(struct mcap_mcl *mcl,
 						uint8_t *cmd, uint32_t len)
 {
+	mcap_md_create_mdl_req *cmdlast = (mcap_md_create_mdl_req *)mcl->lcmd;
 	struct mcap_mdl_op_cb *conn = mcl->priv_data;
-	struct mcap_mdl *mdl = conn->mdl;
 	mcap_mdl_operation_conf_cb connect_cb = conn->cb.op_conf;
 	gpointer user_data = conn->user_data;
-	uint16_t mdlid;
-	mcap5B_rsp *rsp = (mcap5B_rsp *) cmd;
-	mcap_md_create_mdl_req *cmdlast;
-	GError *gerr = NULL;
+	struct mcap_mdl *mdl = conn->mdl;
+	uint8_t conf = cmdlast->conf;
 	gboolean close = FALSE;
+	GError *gerr = NULL;
+	mcap5B_rsp *rsp;
 
 	g_free(mcl->priv_data);
 	mcl->priv_data = NULL;
 
-	cmdlast = (mcap_md_create_mdl_req *) mcl->lcmd;
-	mdlid = ntohs(cmdlast->mdl);
-	rsp->mdl = ntohs(rsp->mdl);
-
+	close = check_err_rsp(mcl, cmd, len, sizeof(mcap4B_rsp), &gerr);
 	g_free(mcl->lcmd);
 	mcl->lcmd = NULL;
 	mcl->req = MCL_AVAILABLE;
-	close = check_err_rsp(rsp->mdl, mdlid, rsp->rc, 0, 0, &gerr);
 
 	if (gerr)
 		goto fail;
@@ -1245,8 +1269,9 @@ static gboolean process_md_create_mdl_rsp(struct mcap_mcl *mcl,
 		goto fail;
 	}
 
+	rsp = (mcap5B_rsp *)cmd;
 	/* Check if preferences changed */
-	if ((cmdlast->conf != 0x00) && (rsp->param != cmdlast->conf)) {
+	if ((conf != 0x00) && (rsp->param != conf)) {
 		g_set_error(&gerr, MCAP_ERROR, MCAP_ERROR_FAILED,
 						"Configuration changed");
 		close = TRUE;
@@ -1268,22 +1293,17 @@ static gboolean process_md_reconnect_mdl_rsp(struct mcap_mcl *mcl,
 						uint8_t *cmd, uint32_t len)
 {
 	struct mcap_mdl_op_cb *reconn = mcl->priv_data;
-	struct mcap_mdl *mdl = reconn->mdl;
 	mcap_mdl_operation_cb reconn_cb = reconn->cb.op;
 	gpointer user_data = reconn->user_data;
-	mcap4B_rsp *rsp = (mcap4B_rsp *) cmd;
-	mcap_md_req *cmdlast = (mcap_md_req *) mcl->lcmd;
-	uint16_t mdlid = ntohs(cmdlast->mdl);
+	struct mcap_mdl *mdl = reconn->mdl;
+	mcap4B_rsp *rsp = (mcap4B_rsp *)cmd;
 	GError *gerr = NULL;
 	gboolean close = FALSE;
 
 	g_free(mcl->priv_data);
 	mcl->priv_data = NULL;
 
-	rsp->mdl = ntohs(rsp->mdl);
-
-	close = check_err_rsp(rsp->mdl, mdlid, rsp->rc, len,
-						sizeof(mcap4B_rsp), &gerr);
+	close = check_err_rsp(mcl, cmd, len, sizeof(mcap4B_rsp), &gerr);
 
 	g_free(mcl->lcmd);
 	mcl->lcmd = NULL;
@@ -1312,22 +1332,17 @@ static gboolean process_md_abort_mdl_rsp(struct mcap_mcl *mcl,
 						uint8_t *cmd, uint32_t len)
 {
 	struct mcap_mdl_op_cb *abrt = mcl->priv_data;
-	struct mcap_mdl *mdl = abrt->mdl;
 	mcap_mdl_del_cb abrt_cb = abrt->cb.del;
 	gpointer user_data = abrt->user_data;
-	mcap4B_rsp *rsp = (mcap4B_rsp *) cmd;
-	mcap_md_req *cmdlast = (mcap_md_req *) mcl->lcmd;
-	uint16_t mdlid = ntohs(cmdlast->mdl);
+	struct mcap_mdl *mdl = abrt->mdl;
 	GError *gerr = NULL;
 	gboolean close = FALSE;
 
 	g_free(mcl->priv_data);
 	mcl->priv_data = NULL;
 
-	rsp->mdl = ntohs(rsp->mdl);
+	close = check_err_rsp(mcl, cmd, len, sizeof(mcap4B_rsp), &gerr);
 
-	close = check_err_rsp(rsp->mdl, mdlid, rsp->rc, len,
-						sizeof(mcap4B_rsp), &gerr);
 	g_free(mcl->lcmd);
 	mcl->lcmd = NULL;
 	mcl->req = MCL_AVAILABLE;
@@ -1365,7 +1380,6 @@ static gboolean process_md_delete_mdl_rsp(struct mcap_mcl *mcl, uint8_t *cmd,
 	struct mcap_mdl *mdl = del->mdl;
 	mcap_mdl_del_cb deleted_cb = del->cb.del;
 	gpointer user_data = del->user_data;
-	mcap4B_rsp *rsp = (mcap4B_rsp *) cmd;
 	mcap_md_req *cmdlast = (mcap_md_req *) mcl->lcmd;
 	uint16_t mdlid = ntohs(cmdlast->mdl);
 	GError *gerr = NULL;
@@ -1375,10 +1389,7 @@ static gboolean process_md_delete_mdl_rsp(struct mcap_mcl *mcl, uint8_t *cmd,
 	g_free(mcl->priv_data);
 	mcl->priv_data = NULL;
 
-	rsp->mdl = ntohs(rsp->mdl);
-
-	close = check_err_rsp(rsp->mdl, mdlid, rsp->rc, len,
-						sizeof(mcap4B_rsp), &gerr);
+	close = check_err_rsp(mcl, cmd, len, sizeof(mcap4B_rsp), &gerr);
 
 	g_free(mcl->lcmd);
 	mcl->lcmd = NULL;
@@ -1409,60 +1420,11 @@ end:
 	return close;
 }
 
-static gboolean check_rsp(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
-{
-	mcap4B_rsp *rsp;
-	GError *gerr = NULL;
-
-	rsp = (mcap4B_rsp *)cmd;
-	/* Check if the response matches with the last request */
-	if ((cmd[0] != MCAP_ERROR_RSP) && ((mcl->lcmd[0] + 1) != cmd[0]))
-		goto close_mcl;
-
-	if (len < 4)
-		goto close_mcl;
-
-	if (rsp->rc == MCAP_REQUEST_NOT_SUPPORTED) {
-		DBG("Remote does not support opcodes");
-		g_set_error(&gerr, MCAP_ERROR, MCAP_ERROR_REQUEST_NOT_SUPPORTED,
-						"%s", error2str(rsp->rc));
-		mcap_notify_error(mcl, gerr);
-		g_error_free(gerr);
-
-		g_free(mcl->lcmd);
-		mcl->lcmd = NULL;
-		mcl->ctrl &= ~MCAP_CTRL_STD_OP;
-		mcl->req = MCL_AVAILABLE;
-		update_mcl_state(mcl);
-		return FALSE;
-	}
-
-	if (rsp->rc == MCAP_UNSPECIFIED_ERROR)
-		goto close_mcl;
-
-	return TRUE;
-close_mcl:
-	if (rsp->rc == MCAP_UNSPECIFIED_ERROR)
-		g_set_error(&gerr, MCAP_ERROR, MCAP_ERROR_UNSPECIFIED_ERROR,
-						"%s", error2str(rsp->rc));
-	else
-		g_set_error(&gerr, MCAP_ERROR, MCAP_ERROR_FAILED,
-						"Protocol error");
-	mcap_notify_error(mcl, gerr);
-	g_error_free(gerr);
-	mcl->ms->mcl_disconnected_cb(mcl, mcl->ms->user_data);
-	mcap_cache_mcl(mcl);
-	return FALSE;
-}
-
 static void proc_response(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 {
 	gboolean close;
 	RELEASE_TIMER(mcl);
 
-	if (!check_rsp(mcl, cmd, len))
-		return;
-
 	switch (cmd[0]) {
 	case MCAP_ERROR_RSP:
 		error("MCAP_ERROR_RSP received");
-- 
1.6.3.3

