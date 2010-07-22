Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 49/60] Restore state in MCL whenever an error takes place.
Date: Thu, 22 Jul 2010 10:58:06 +0200
Message-Id: <1279789097-2420-1-git-send-email-sancane@gmail.com>
In-Reply-To: <1279789001-4587-30-git-send-email-santoscadenas@gmail.com>
References: <1279789001-4587-30-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mcap/mcap.c |   55 +++++++++++++++++++++++--------------------------------
 1 files changed, 23 insertions(+), 32 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 434d50f..e8a93a1 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -241,8 +241,7 @@ static gint cmp_mdl_state(gconstpointer a, gconstpointer b)
 		return 1;
 }
 
-static void mcap_notify_error(struct mcap_mcl *mcl, GError *err,
-							gboolean restore)
+static void mcap_notify_error(struct mcap_mcl *mcl, GError *err)
 {
 	struct mcap_mdl_op_cb *con = mcl->priv_data;
 	struct mcap_mdl *mdl;
@@ -254,44 +253,36 @@ static void mcap_notify_error(struct mcap_mcl *mcl, GError *err,
 
 	switch (mcl->lcmd[0]){
 	case MCAP_MD_CREATE_MDL_REQ:
-		if (restore) {
-			st = MDL_WAITING;
-			l = g_slist_find_custom(mcl->mdls, &st, cmp_mdl_state);
-			mdl = l->data;
-			mcl->mdls = g_slist_remove(mcl->mdls, mdl);
-			g_free(mdl);
-			update_mcl_state(mcl);
-		}
+		st = MDL_WAITING;
+		l = g_slist_find_custom(mcl->mdls, &st, cmp_mdl_state);
+		mdl = l->data;
+		mcl->mdls = g_slist_remove(mcl->mdls, mdl);
+		g_free(mdl);
+		update_mcl_state(mcl);
 		con->cb.op_conf(NULL, 0, err, con->user_data);
 		break;
 	case MCAP_MD_ABORT_MDL_REQ:
-		if (restore) {
-			st = MDL_WAITING;
-			l = g_slist_find_custom(mcl->mdls, &st, cmp_mdl_state);
-			shutdown_mdl(l->data);
-			update_mcl_state(mcl);
-		}
+		st = MDL_WAITING;
+		l = g_slist_find_custom(mcl->mdls, &st, cmp_mdl_state);
+		shutdown_mdl(l->data);
+		update_mcl_state(mcl);
 		con->cb.del(err, con->user_data);
 		break;
 	case MCAP_MD_DELETE_MDL_REQ:
-		if (restore) {
-			for (l = mcl->mdls; l; l = l->next) {
-				mdl = l->data;
-				if (mdl->state == MDL_DELETING)
-					mdl->state = (mdl->dc) ? MDL_CONNECTED :
+		for (l = mcl->mdls; l; l = l->next) {
+			mdl = l->data;
+			if (mdl->state == MDL_DELETING)
+				mdl->state = (mdl->dc) ? MDL_CONNECTED :
 								MDL_CLOSED;
-			}
-			update_mcl_state(mcl);
 		}
+		update_mcl_state(mcl);
 		con->cb.del(err, con->user_data);
 		break;
 	case MCAP_MD_RECONNECT_MDL_REQ:
-		if (restore) {
-			st = MDL_WAITING;
-			l = g_slist_find_custom(mcl->mdls, &st, cmp_mdl_state);
-			shutdown_mdl(l->data);
-			update_mcl_state(mcl);
-		}
+		st = MDL_WAITING;
+		l = g_slist_find_custom(mcl->mdls, &st, cmp_mdl_state);
+		shutdown_mdl(l->data);
+		update_mcl_state(mcl);
 		con->cb.op(NULL, err, con->user_data);
 		break;
 	}
@@ -446,7 +437,7 @@ static gboolean wait_response_timer(gpointer data)
 	g_set_error(&gerr, MCAP_ERROR, MCAP_ERROR_FAILED,
 					"Timeout waiting response");
 
-	mcap_notify_error(mcl, gerr, FALSE);
+	mcap_notify_error(mcl, gerr);
 
 	g_error_free(gerr);
 	mcl->ms->mcl_disconnected_cb(mcl, mcl->ms->user_data);
@@ -1551,7 +1542,7 @@ static void proc_cmd(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 			mcl->req = MCL_AVAILABLE;
 			g_set_error(&gerr, MCAP_ERROR, MCAP_ERROR_REQ_IGNORED,
 				"Initiator sent a request with more priority");
-			mcap_notify_error(mcl, gerr, TRUE);
+			mcap_notify_error(mcl, gerr);
 			return;
 		}
 		proc_response(mcl, cmd, len);
@@ -1665,7 +1656,7 @@ fail:
 			/* notify error in pending callback */
 			g_set_error(&gerr, MCAP_ERROR, MCAP_ERROR_MCL_CLOSED,
 								"MCL closed");
-			mcap_notify_error(mcl, gerr, TRUE);
+			mcap_notify_error(mcl, gerr);
 			g_error_free(gerr);
 		}
 		mcl->ms->mcl_disconnected_cb(mcl, mcl->ms->user_data);
-- 
1.6.3.3

