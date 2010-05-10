Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot Nemesio <sancane@gmail.com>
Subject: [PATCH 23/25] Process reply to md_abort_mdl_req command
Date: Mon, 10 May 2010 12:15:25 +0200
Message-Id: <1273486527-7855-23-git-send-email-sancane@gmail.com>
In-Reply-To: <1273486527-7855-22-git-send-email-sancane@gmail.com>
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
 <1273486527-7855-21-git-send-email-sancane@gmail.com>
 <1273486527-7855-22-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Santiago Carot Nemesio <sancane@gmail.com>

---
 mcap/mcap.c |   39 ++++++++++++++++++++++++++++++++++++++-
 1 files changed, 38 insertions(+), 1 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index d469dfc..147f322 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -1288,6 +1288,43 @@ static gboolean process_md_reconnect_mdl_rsp(struct mcap_mcl *mcl,
 	return close;
 }
 
+static gboolean process_md_abort_mdl_rsp(struct mcap_mcl *mcl,
+						uint8_t *cmd, uint32_t len)
+{
+	struct mcap_mdl_op_cb *abrt = mcl->priv_data;
+	struct mcap_mdl *mdl = abrt->mdl;
+	mcap_mdl_del_cb abrt_cb = abrt->cb.del;
+	gpointer user_data = abrt->user_data;
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
+	g_free(mcl->lcmd);
+	mcl->lcmd = NULL;
+	mcl->req = MCL_AVAILABLE;
+
+	if (gerr) {
+		abrt_cb(gerr, user_data);
+		g_error_free(gerr);
+		return close;
+	}
+
+	mcl->mdls = g_slist_remove(mcl->mdls, mdl);
+	g_free(mdl);
+	update_mcl_state(mcl);
+	abrt_cb(gerr, user_data);
+	return close;
+}
+
 static gboolean check_rsp(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 {
 	mcap4B_rsp *rsp;
@@ -1355,7 +1392,7 @@ static void proc_response(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 		close = process_md_reconnect_mdl_rsp(mcl, cmd, len);
 		break;
 	case MCAP_MD_ABORT_MDL_RSP:
-		/* close = process_md_abort_mdl_rsp(mcl, cmd, len); */
+		close = process_md_abort_mdl_rsp(mcl, cmd, len);
 		break;
 	case MCAP_MD_DELETE_MDL_RSP:
 		/* close = process_md_delete_mdl_rsp(mcl, cmd, len); */
-- 
1.6.3.3

