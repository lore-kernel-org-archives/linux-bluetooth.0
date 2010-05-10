Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot Nemesio <sancane@gmail.com>
Subject: [PATCH 21/25] Process reply to md_create_mdl_req command
Date: Mon, 10 May 2010 12:15:23 +0200
Message-Id: <1273486527-7855-21-git-send-email-sancane@gmail.com>
In-Reply-To: <1273486527-7855-20-git-send-email-sancane@gmail.com>
References: <1273486527-7855-1-git-send-email-sancane@gmail.com>
 <1273486527-7855-2-git-send-email-sancane@gmail.com>
 <1273486527-7855-3-git-send-email-sancane@gmail.com>
 <1273486527-7855-4-git-send-email-sancane@gmail.com>
 <1273486527-7855-5-git-send-email-sancane@gmail.com>
 <1273486527-7855-6-git-send-email-sancane@gmail.com>
 <1273486527-7855-7-git-send-email-sancane@gmail.com>
 <1273486527-7855-8-git-send-email-sancane@gmail.com>
 <1273486527-7855-9-git-send-email-sancane@gmail.com>
 <1273486527-7855-10-git-send-email-sancane@gmail.com>
 <1273486527-7855-11-git-send-email-sancane@gmail.com>
 <1273486527-7855-12-git-send-email-sancane@gmail.com>
 <1273486527-7855-13-git-send-email-sancane@gmail.com>
 <1273486527-7855-14-git-send-email-sancane@gmail.com>
 <1273486527-7855-15-git-send-email-sancane@gmail.com>
 <1273486527-7855-16-git-send-email-sancane@gmail.com>
 <1273486527-7855-17-git-send-email-sancane@gmail.com>
 <1273486527-7855-18-git-send-email-sancane@gmail.com>
 <1273486527-7855-19-git-send-email-sancane@gmail.com>
 <1273486527-7855-20-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Santiago Carot Nemesio <sancane@gmail.com>

---
 mcap/mcap.c |   86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 85 insertions(+), 1 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 5b53ee8..1ed069d 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -1161,6 +1161,90 @@ static void proc_req_active(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 	}
 }
 
+/* Function used to process replies */
+static gboolean check_err_rsp(uint16_t rmdl, uint16_t smdl, uint8_t rc,
+				uint32_t rlen, uint32_t len, GError **gerr)
+{
+	gboolean close = FALSE;
+	char *msg;
+	gint err = MCAP_ERROR_FAILED;
+
+	if (rmdl != smdl) {
+		msg = "MDLID received doesn't match with MDLID sended";
+		close = TRUE;
+		goto fail;
+	}
+
+	if ((rc != MCAP_SUCCESS) && (rc <= MCAP_CONFIGURATION_REJECTED)) {
+		msg = error2str(rc);
+		err = rc;
+		goto fail;
+	}
+
+	if (rlen < len) {
+		msg = "Protocol error";
+		close = TRUE;
+		goto fail;
+	}
+	return FALSE;
+fail:
+	g_set_error(gerr, MCAP_ERROR, err, "%s", msg);
+	return close;
+}
+
+static gboolean process_md_create_mdl_rsp(struct mcap_mcl *mcl,
+						uint8_t *cmd, uint32_t len)
+{
+	struct mcap_mdl_op_cb *conn = mcl->priv_data;
+	struct mcap_mdl *mdl = conn->mdl;
+	mcap_mdl_operation_conf_cb connect_cb = conn->cb.op_conf;
+	gpointer user_data = conn->user_data;
+	uint16_t mdlid;
+	mcap5B_rsp *rsp = (mcap5B_rsp *) cmd;
+	mcap_md_create_mdl_req *cmdlast;
+	GError *gerr = NULL;
+	gboolean close = FALSE;
+
+	g_free(mcl->priv_data);
+	mcl->priv_data = NULL;
+
+	cmdlast = (mcap_md_create_mdl_req *) mcl->lcmd;
+	mdlid = ntohs(cmdlast->mdl);
+	rsp->mdl = ntohs(rsp->mdl);
+
+	g_free(mcl->lcmd);
+	mcl->lcmd = NULL;
+	mcl->req = MCL_AVAILABLE;
+	close = check_err_rsp(rsp->mdl, mdlid, rsp->rc, 0, 0, &gerr);
+
+	if (gerr)
+		goto fail;
+
+	if (len < 5) {
+		g_set_error(&gerr, MCAP_ERROR, MCAP_ERROR_FAILED,
+							"Protocol error");
+		close = TRUE;
+		goto fail;
+	}
+
+	/* Check if preferences changed */
+	if ((cmdlast->conf != 0x00) && (rsp->param != cmdlast->conf)) {
+		g_set_error(&gerr, MCAP_ERROR, MCAP_ERROR_FAILED,
+							"Configutation changed");
+		close = TRUE;
+		goto fail;
+	}
+
+	connect_cb(mdl, rsp->param, gerr, user_data);
+	return close;
+fail:
+	connect_cb(NULL, 0, gerr, user_data);
+	mcl->mdls = g_slist_remove(mcl->mdls, mdl);
+	g_free(mdl);
+	g_error_free(gerr);
+	return close;
+}
+
 static gboolean check_rsp(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 {
 	mcap4B_rsp *rsp;
@@ -1222,7 +1306,7 @@ static void proc_response(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 		close = TRUE;
 		break;
 	case MCAP_MD_CREATE_MDL_RSP:
-		/* close = process_md_create_mdl_rsp(mcl, cmd, len); */
+		close = process_md_create_mdl_rsp(mcl, cmd, len);
 		break;
 	case MCAP_MD_RECONNECT_MDL_RSP:
 		/* close = process_md_reconnect_mdl_rsp(mcl, cmd, len); */
-- 
1.6.3.3

