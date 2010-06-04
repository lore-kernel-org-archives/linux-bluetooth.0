Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 20/26] Process md_create_mdl_rsp
Date: Fri,  4 Jun 2010 10:27:13 +0200
Message-Id: <1275640039-7245-21-git-send-email-sancane@gmail.com>
In-Reply-To: <1275640039-7245-20-git-send-email-sancane@gmail.com>
References: <1275640039-7245-1-git-send-email-sancane@gmail.com>
 <1275640039-7245-2-git-send-email-sancane@gmail.com>
 <1275640039-7245-3-git-send-email-sancane@gmail.com>
 <1275640039-7245-4-git-send-email-sancane@gmail.com>
 <1275640039-7245-5-git-send-email-sancane@gmail.com>
 <1275640039-7245-6-git-send-email-sancane@gmail.com>
 <1275640039-7245-7-git-send-email-sancane@gmail.com>
 <1275640039-7245-8-git-send-email-sancane@gmail.com>
 <1275640039-7245-9-git-send-email-sancane@gmail.com>
 <1275640039-7245-10-git-send-email-sancane@gmail.com>
 <1275640039-7245-11-git-send-email-sancane@gmail.com>
 <1275640039-7245-12-git-send-email-sancane@gmail.com>
 <1275640039-7245-13-git-send-email-sancane@gmail.com>
 <1275640039-7245-14-git-send-email-sancane@gmail.com>
 <1275640039-7245-15-git-send-email-sancane@gmail.com>
 <1275640039-7245-16-git-send-email-sancane@gmail.com>
 <1275640039-7245-17-git-send-email-sancane@gmail.com>
 <1275640039-7245-18-git-send-email-sancane@gmail.com>
 <1275640039-7245-19-git-send-email-sancane@gmail.com>
 <1275640039-7245-20-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mcap/mcap.c |   80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 79 insertions(+), 1 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index cd710da..4708fe7 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -1171,10 +1171,88 @@ static void proc_req_active(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
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
+		msg = "MDLID received doesn't match with MDLID sent";
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
 static gboolean process_md_create_mdl_rsp(struct mcap_mcl *mcl,
 						uint8_t *cmd, uint32_t len)
 {
-	return FALSE;
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
+						"Configuration changed");
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
 }
 
 static gboolean process_md_reconnect_mdl_rsp(struct mcap_mcl *mcl,
-- 
1.6.3.3

