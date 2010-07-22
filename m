Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jos=C3=A9=20Antonio=20Santos-Cadenas?=
	<santoscadenas@gmail.com>
Subject: [PATCH 21/60] Process md_reconnect_mdl_rsp
Date: Thu, 22 Jul 2010 10:56:14 +0200
Message-Id: <1279789001-4587-3-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1279789001-4587-2-git-send-email-santoscadenas@gmail.com>
References: <1279788733-2324-19-git-send-email-sancane@gmail.com>
 <1279789001-4587-1-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-2-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: José Antonio Santos-Cadenas <santoscadenas@gmail.com>

---
 mcap/mcap.c |   39 ++++++++++++++++++++++++++++++++++++++-
 1 files changed, 38 insertions(+), 1 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index aa9f1a3..b1498ca 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -1257,7 +1257,44 @@ fail:
 static gboolean process_md_reconnect_mdl_rsp(struct mcap_mcl *mcl,
 						uint8_t *cmd, uint32_t len)
 {
-	return FALSE;
+	struct mcap_mdl_op_cb *reconn = mcl->priv_data;
+	struct mcap_mdl *mdl = reconn->mdl;
+	mcap_mdl_operation_cb reconn_cb = reconn->cb.op;
+	gpointer user_data = reconn->user_data;
+	mcap4B_rsp *rsp = (mcap4B_rsp *) cmd;
+	mcap_md_req *cmdlast = (mcap_md_req *) mcl->lcmd;
+	uint16_t mdlid = ntohs(cmdlast->mdl);
+	GError *gerr = NULL;
+	gboolean close = FALSE;
+
+	g_free(mcl->priv_data);
+	mcl->priv_data = NULL;
+
+	rsp->mdl = ntohs(rsp->mdl);
+
+	close = check_err_rsp(rsp->mdl, mdlid, rsp->rc, len,
+						sizeof(mcap4B_rsp), &gerr);
+
+	g_free(mcl->lcmd);
+	mcl->lcmd = NULL;
+	mcl->req = MCL_AVAILABLE;
+
+	reconn_cb(mdl, gerr, user_data);
+	if (!gerr)
+		return close;
+
+	g_error_free(gerr);
+	shutdown_mdl(mdl);
+
+	if (rsp->rc != MCAP_INVALID_MDL)
+		return close;
+
+	/* Remove cached mdlid */
+	mcl->mdls = g_slist_remove(mcl->mdls, mdl);
+	mcl->cb->mdl_deleted(mdl, mcl->cb->user_data);
+	g_free(mdl);
+
+	return close;
 }
 
 static gboolean process_md_abort_mdl_rsp(struct mcap_mcl *mcl,
-- 
1.6.3.3

