Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 23/25] Process md_delete_mdl_rsp
Date: Fri, 14 May 2010 12:19:50 +0200
Message-Id: <1273832392-18654-23-git-send-email-sancane@gmail.com>
In-Reply-To: <1273832392-18654-22-git-send-email-sancane@gmail.com>
References: <1273832392-18654-1-git-send-email-sancane@gmail.com>
 <1273832392-18654-2-git-send-email-sancane@gmail.com>
 <1273832392-18654-3-git-send-email-sancane@gmail.com>
 <1273832392-18654-4-git-send-email-sancane@gmail.com>
 <1273832392-18654-5-git-send-email-sancane@gmail.com>
 <1273832392-18654-6-git-send-email-sancane@gmail.com>
 <1273832392-18654-7-git-send-email-sancane@gmail.com>
 <1273832392-18654-8-git-send-email-sancane@gmail.com>
 <1273832392-18654-9-git-send-email-sancane@gmail.com>
 <1273832392-18654-10-git-send-email-sancane@gmail.com>
 <1273832392-18654-11-git-send-email-sancane@gmail.com>
 <1273832392-18654-12-git-send-email-sancane@gmail.com>
 <1273832392-18654-13-git-send-email-sancane@gmail.com>
 <1273832392-18654-14-git-send-email-sancane@gmail.com>
 <1273832392-18654-15-git-send-email-sancane@gmail.com>
 <1273832392-18654-16-git-send-email-sancane@gmail.com>
 <1273832392-18654-17-git-send-email-sancane@gmail.com>
 <1273832392-18654-18-git-send-email-sancane@gmail.com>
 <1273832392-18654-19-git-send-email-sancane@gmail.com>
 <1273832392-18654-20-git-send-email-sancane@gmail.com>
 <1273832392-18654-21-git-send-email-sancane@gmail.com>
 <1273832392-18654-22-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mcap/mcap.c |   60 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 59 insertions(+), 1 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index eda8dd1..a08e631 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -1335,10 +1335,68 @@ static gboolean process_md_abort_mdl_rsp(struct mcap_mcl *mcl,
 	return close;
 }
 
+static void restore_mdl(gpointer elem, gpointer data)
+{
+	struct mcap_mdl *mdl = elem;
+
+	if (mdl->state == MDL_DELETING) {
+		if (mdl->dc)
+			mdl->state = MDL_CONNECTED;
+		else
+			mdl->state = MDL_CLOSED;
+	} else if (mdl->state == MDL_CLOSED)
+		mdl->mcl->cb->mdl_closed(mdl, mdl->mcl->cb->user_data);
+}
+
 static gboolean process_md_delete_mdl_rsp(struct mcap_mcl *mcl, uint8_t *cmd,
 								uint32_t len)
 {
-	return FALSE;
+	struct mcap_mdl_op_cb *del = mcl->priv_data;
+	struct mcap_mdl *mdl = del->mdl;
+	mcap_mdl_del_cb deleted_cb = del->cb.del;
+	gpointer user_data = del->user_data;
+	mcap4B_rsp *rsp = (mcap4B_rsp *) cmd;
+	mcap_md_req *cmdlast = (mcap_md_req *) mcl->lcmd;
+	uint16_t mdlid = ntohs(cmdlast->mdl);
+	GError *gerr = NULL;
+	gboolean close = FALSE;
+	gboolean notify = FALSE;
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
+	if (gerr) {
+		if (mdl)
+			restore_mdl(mdl, NULL);
+		else
+			g_slist_foreach(mcl->mdls, restore_mdl, NULL);
+		deleted_cb(gerr, user_data);
+		g_error_free(gerr);
+		return close;
+	}
+
+	if (mdlid == MCAP_ALL_MDLIDS) {
+		g_slist_foreach(mcl->mdls, mcap_delete_mdl, &notify);
+		g_slist_free(mcl->mdls);
+		mcl->mdls = NULL;
+		mcl->state = MCL_CONNECTED;
+		goto end;
+	}
+
+	mcl->mdls = g_slist_remove(mcl->mdls, mdl);
+	update_mcl_state(mcl);
+	mcap_delete_mdl(mdl, &notify);
+end:
+	deleted_cb(gerr, user_data);
+	return close;
 }
 
 static gboolean check_rsp(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
-- 
1.6.3.3

