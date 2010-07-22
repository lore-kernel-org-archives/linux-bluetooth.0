Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jos=C3=A9=20Antonio=20Santos-Cadenas?=
	<santoscadenas@gmail.com>
Subject: [PATCH 43/60] Acceptor should not resend commands
Date: Thu, 22 Jul 2010 10:56:36 +0200
Message-Id: <1279789001-4587-25-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1279789001-4587-24-git-send-email-santoscadenas@gmail.com>
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
 <1279789001-4587-13-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-14-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-15-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-16-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-17-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-18-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-19-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-20-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-21-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-22-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-23-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-24-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: José Antonio Santos-Cadenas <santoscadenas@gmail.com>

Acceptor of the MCL should not send the last commands sent when there
is an outstanding request.
---
 mcap/mcap.c |   72 +++++++++--------------------------------------------------
 1 files changed, 11 insertions(+), 61 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index ff6766d..7bea1ad 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -955,16 +955,8 @@ static void process_md_create_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 		return;
 	}
 
-	mdl = get_mdl(mcl, mdl_id);
-	if (mdl && mdl->state == MDL_WAITING) {
-		/* A remote petition is also triying to connect this mdl_id
-		 * so the petition is rejected by the moment */
-		send4B_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, MCAP_MDL_BUSY, mdl_id);
-		return;
-	}
-
-	/* Callback to upper layer */
 	cfga = conf = req->conf;
+	/* Callback to upper layer */
 	rsp = mcl->cb->mdl_conn_req(mcl, mdep_id, mdl_id, &conf,
 							mcl->cb->user_data);
 	if (mcl->state == MCL_IDLE) {
@@ -985,6 +977,7 @@ static void process_md_create_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 		return;
 	}
 
+	mdl = get_mdl(mcl, mdl_id);
 	if (!mdl) {
 		mdl = g_malloc0(sizeof(struct mcap_mdl));
 		mdl->mcl = mcl;
@@ -1137,12 +1130,7 @@ static void process_md_delete_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 	mcl->mdls = g_slist_remove(mcl->mdls, mdl);
 	update_mcl_state(mcl);
 	notify = TRUE;
-	if (mdl->state == MDL_DELETING) {
-		/* Remote deviced requests deleting an MDL that upper profile
-		 * is trying to delete, MDL will be freed when reply arrives. */
-		mdl->mcl->cb->mdl_deleted(mdl, mdl->mcl->cb->user_data);
-	} else
-		mcap_delete_mdl(mdl, &notify);
+	mcap_delete_mdl(mdl, &notify);
 resp:
 	send4B_cmd(mcl, MCAP_MD_DELETE_MDL_RSP, MCAP_SUCCESS, mdlid);
 }
@@ -1395,7 +1383,6 @@ static gboolean process_md_delete_mdl_rsp(struct mcap_mcl *mcl, uint8_t *cmd,
 	gpointer user_data = del->user_data;
 	mcap_md_req *cmdlast = (mcap_md_req *) mcl->lcmd;
 	uint16_t mdlid = ntohs(cmdlast->mdl);
-	mcap4B_rsp *rsp = (mcap4B_rsp *)cmd;
 	GError *gerr = NULL;
 	gboolean close = FALSE;
 	gboolean notify = FALSE;
@@ -1410,23 +1397,13 @@ static gboolean process_md_delete_mdl_rsp(struct mcap_mcl *mcl, uint8_t *cmd,
 	mcl->req = MCL_AVAILABLE;
 
 	if (gerr) {
-		if (!mdl) {
-			/* Deletion of all mdls failed */
-			g_slist_foreach(mcl->mdls, restore_mdl, NULL);
-		} else if ((len >= MIN_RSP_LEN) &&
-						(rsp->rc == MCAP_INVALID_MDL)) {
-			/* Mdl does not exist in remote side */
-			goto del_mdl;
-		} else if (g_slist_find(mdl->mcl->mdls, mdl)){
-			/* this mdl couldn't be deleted */
+		if (mdl)
 			restore_mdl(mdl, NULL);
-		} else {
-			/* MDL deleted request was sent by remote side while an
-			 * outgoing request for delete it was pending */
-			shutdown_mdl(mdl);
-			g_free(mdl);
-		}
-		goto end;
+		else
+			g_slist_foreach(mcl->mdls, restore_mdl, NULL);
+		deleted_cb(gerr, user_data);
+		g_error_free(gerr);
+		return close;
 	}
 
 	if (mdlid == MCAP_ALL_MDLIDS) {
@@ -1436,14 +1413,12 @@ static gboolean process_md_delete_mdl_rsp(struct mcap_mcl *mcl, uint8_t *cmd,
 		mcl->state = MCL_CONNECTED;
 		goto end;
 	}
-del_mdl:
+
 	mcl->mdls = g_slist_remove(mcl->mdls, mdl);
 	update_mcl_state(mcl);
 	mcap_delete_mdl(mdl, &notify);
 end:
 	deleted_cb(gerr, user_data);
-	if (gerr)
-		g_error_free(gerr);
 	return close;
 }
 
@@ -1481,30 +1456,6 @@ static void proc_response(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 	}
 }
 
-static void rsend_req(struct mcap_mcl *mcl)
-{
-	uint8_t *cmd = mcl->lcmd;
-	int len;
-
-	if (!cmd)
-		return;
-
-	switch (cmd[0]) {
-	case MCAP_MD_RECONNECT_MDL_REQ:
-	case MCAP_MD_ABORT_MDL_REQ:
-	case MCAP_MD_DELETE_MDL_REQ:
-		len = 3;
-		break;
-	case MCAP_MD_CREATE_MDL_REQ:
-		len = 5;
-		break;
-	default:
-		return;
-	}
-
-	mcap_send_data(g_io_channel_unix_get_fd(mcl->cc), cmd, len);
-}
-
 static void proc_cmd(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 {
 	if ((cmd[0] >= MCAP_MD_SYNC_CAP_REQ) &&
@@ -1526,8 +1477,7 @@ static void proc_cmd(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 				/* ignore */
 				return;
 			proc_req[mcl->state](mcl, cmd, len);
-			/* Initiator will ignore our last request => re-send */
-			rsend_req(mcl);
+			/* Initiator will ignore our last request */
 			return;
 		}
 		proc_response(mcl, cmd, len);
-- 
1.6.3.3

