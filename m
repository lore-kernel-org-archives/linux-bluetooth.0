Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 22/26] Process md_abort_mdl_rsp
Date: Fri,  4 Jun 2010 10:27:15 +0200
Message-Id: <1275640039-7245-23-git-send-email-sancane@gmail.com>
In-Reply-To: <1275640039-7245-22-git-send-email-sancane@gmail.com>
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
 <1275640039-7245-21-git-send-email-sancane@gmail.com>
 <1275640039-7245-22-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mcap/mcap.c |   33 ++++++++++++++++++++++++++++++++-
 1 files changed, 32 insertions(+), 1 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index bd22d54..17f0573 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -1301,7 +1301,38 @@ static gboolean process_md_reconnect_mdl_rsp(struct mcap_mcl *mcl,
 static gboolean process_md_abort_mdl_rsp(struct mcap_mcl *mcl,
 						uint8_t *cmd, uint32_t len)
 {
-	return FALSE;
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
 }
 
 static gboolean process_md_delete_mdl_rsp(struct mcap_mcl *mcl, uint8_t *cmd,
-- 
1.6.3.3

