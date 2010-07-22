Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jos=C3=A9=20Antonio=20Santos-Cadenas?=
	<santoscadenas@gmail.com>
Subject: [PATCH 20/60] Process md_create_mdl_rsp
Date: Thu, 22 Jul 2010 10:56:13 +0200
Message-Id: <1279789001-4587-2-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1279789001-4587-1-git-send-email-santoscadenas@gmail.com>
References: <1279788733-2324-19-git-send-email-sancane@gmail.com>
 <1279789001-4587-1-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: José Antonio Santos-Cadenas <santoscadenas@gmail.com>

---
 mcap/mcap.c |   80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 79 insertions(+), 1 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index c775501..aa9f1a3 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -1170,10 +1170,88 @@ static void proc_req_active(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
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

