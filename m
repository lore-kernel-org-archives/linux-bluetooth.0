Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jos=C3=A9=20Antonio=20Santos-Cadenas?=
	<santoscadenas@gmail.com>
Subject: [PATCH 44/60] Restore state after INITIATOR ignore a request
Date: Thu, 22 Jul 2010 10:56:37 +0200
Message-Id: <1279789001-4587-26-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1279789001-4587-25-git-send-email-santoscadenas@gmail.com>
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
 <1279789001-4587-25-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: José Antonio Santos-Cadenas <santoscadenas@gmail.com>

When ACEPTOR receives a request when an outstanding request is
pending it should reply to the INITIATOR and restore previous state
if it is needed.
---
 mcap/mcap.c     |  140 ++++++++++++++++++++++++++++++++++++++++--------------
 mcap/mcap_lib.h |    1 +
 2 files changed, 104 insertions(+), 37 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 7bea1ad..a2cfa8c 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -194,28 +194,112 @@ static void mcap_send_std_opcode(struct mcap_mcl *mcl, uint8_t *cmd,
 	mcl->req = MCL_WAITING_RSP;
 }
 
-static void mcap_notify_error(struct mcap_mcl *mcl, GError *err)
+static void update_mcl_state(struct mcap_mcl *mcl)
+{
+	GSList *l;
+	struct mcap_mdl *mdl;
+
+	if (mcl->state == MCL_PENDING)
+		return;
+
+	for (l = mcl->mdls; l; l = l->next) {
+		mdl = l->data;
+
+		if (mdl->state == MDL_CONNECTED) {
+			mcl->state = MCL_ACTIVE;
+			return;
+		}
+	}
+
+	mcl->state = MCL_CONNECTED;
+}
+
+static void shutdown_mdl(struct mcap_mdl *mdl)
+{
+	mdl->state = MDL_CLOSED;
+
+	g_source_remove(mdl->wid);
+
+	if (mdl->dc) {
+		g_io_channel_shutdown(mdl->dc, TRUE, NULL);
+		g_io_channel_unref(mdl->dc);
+		mdl->dc = NULL;
+	}
+}
+
+static gint cmp_mdl_state(gconstpointer a, gconstpointer b)
+{
+	const struct mcap_mdl *mdl = a;
+	const MDLState *st = b;
+
+	if (mdl->state == *st)
+		return 0;
+	else if (mdl->state < *st)
+		return -1;
+	else
+		return 1;
+}
+
+static void mcap_notify_error(struct mcap_mcl *mcl, GError *err,
+							gboolean restore)
 {
 	struct mcap_mdl_op_cb *con = mcl->priv_data;
+	struct mcap_mdl *mdl;
+	MDLState st;
+	GSList *l;
 
 	if (!con || !mcl->lcmd)
 		return;
 
 	switch (mcl->lcmd[0]){
 	case MCAP_MD_CREATE_MDL_REQ:
+		if (restore) {
+			st = MDL_WAITING;
+			l = g_slist_find_custom(mcl->mdls, &st, cmp_mdl_state);
+			mdl = l->data;
+			mcl->mdls = g_slist_remove(mcl->mdls, mdl);
+			g_free(mdl);
+			update_mcl_state(mcl);
+		}
 		con->cb.op_conf(NULL, 0, err, con->user_data);
 		break;
 	case MCAP_MD_ABORT_MDL_REQ:
+		if (restore) {
+			st = MDL_WAITING;
+			l = g_slist_find_custom(mcl->mdls, &st, cmp_mdl_state);
+			shutdown_mdl(l->data);
+			update_mcl_state(mcl);
+		}
+		con->cb.del(err, con->user_data);
+		break;
 	case MCAP_MD_DELETE_MDL_REQ:
+		if (restore) {
+			for (l = mcl->mdls; l; l = l->next) {
+				mdl = l->data;
+				if (mdl->state == MDL_DELETING)
+					mdl->state = (mdl->dc) ? MDL_CONNECTED :
+								MDL_CLOSED;
+			}
+			update_mcl_state(mcl);
+		}
 		con->cb.del(err, con->user_data);
 		break;
 	case MCAP_MD_RECONNECT_MDL_REQ:
+		if (restore) {
+			st = MDL_WAITING;
+			l = g_slist_find_custom(mcl->mdls, &st, cmp_mdl_state);
+			shutdown_mdl(l->data);
+			update_mcl_state(mcl);
+		}
 		con->cb.op(NULL, err, con->user_data);
 		break;
 	}
 
 	g_free(mcl->priv_data);
 	mcl->priv_data = NULL;
+
+	g_free(mcl->lcmd);
+	mcl->lcmd = NULL;
 }
 
 int mcap_send_data(int sock, const uint8_t *buf, uint32_t size)
@@ -348,7 +432,7 @@ static gboolean wait_response_timer(gpointer data)
 	g_set_error(&gerr, MCAP_ERROR, MCAP_ERROR_FAILED,
 					"Timeout waiting response");
 
-	mcap_notify_error(mcl, gerr);
+	mcap_notify_error(mcl, gerr, FALSE);
 
 	g_error_free(gerr);
 	mcl->ms->mcl_disconnected_cb(mcl, mcl->ms->user_data);
@@ -552,26 +636,6 @@ void mcap_mdl_abort(struct mcap_mdl *mdl, GError **err,
 									mcl);
 }
 
-static void update_mcl_state(struct mcap_mcl *mcl)
-{
-	GSList *l;
-	struct mcap_mdl *mdl;
-
-	if (mcl->state == MCL_PENDING)
-		return;
-
-	for (l = mcl->mdls; l; l = l->next) {
-		mdl = l->data;
-
-		if (mdl->state == MDL_CONNECTED) {
-			mcl->state = MCL_ACTIVE;
-			return;
-		}
-	}
-
-	mcl->state = MCL_CONNECTED;
-}
-
 static struct mcap_mcl *find_mcl(GSList *list, const bdaddr_t *addr)
 {
 	GSList *l;
@@ -603,19 +667,6 @@ uint16_t mcap_mdl_get_mdlid(struct mcap_mdl *mdl)
 	return mdl->mdlid;
 }
 
-static void shutdown_mdl(struct mcap_mdl *mdl)
-{
-	mdl->state = MDL_CLOSED;
-
-	g_source_remove(mdl->wid);
-
-	if (mdl->dc) {
-		g_io_channel_shutdown(mdl->dc, TRUE, NULL);
-		g_io_channel_unref(mdl->dc);
-		mdl->dc = NULL;
-	}
-}
-
 static void mcap_free_mdls(struct mcap_mcl *mcl, gboolean save)
 {
 	GSList *l;
@@ -955,6 +1006,14 @@ static void process_md_create_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 		return;
 	}
 
+	mdl = get_mdl(mcl, mdl_id);
+	if (mdl && (mdl->state == MDL_WAITING || mdl->state == MDL_DELETING )) {
+		/* Creation request arrives for a MDL that is being managed
+		* at current moment */
+		send4B_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, MCAP_MDL_BUSY, mdl_id);
+		return;
+	}
+
 	cfga = conf = req->conf;
 	/* Callback to upper layer */
 	rsp = mcl->cb->mdl_conn_req(mcl, mdep_id, mdl_id, &conf,
@@ -977,7 +1036,6 @@ static void process_md_create_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 		return;
 	}
 
-	mdl = get_mdl(mcl, mdl_id);
 	if (!mdl) {
 		mdl = g_malloc0(sizeof(struct mcap_mdl));
 		mdl->mcl = mcl;
@@ -987,6 +1045,7 @@ static void process_md_create_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 		 * it is open when we receive a MD_CREATE_MDL_REQ */
 		shutdown_mdl(mdl);
 	}
+
 	mdl->mdep_id = mdep_id;
 	mdl->state = MDL_WAITING;
 	mcl->mdls = g_slist_insert_sorted(mcl->mdls, mdl, compare_mdl);
@@ -1458,6 +1517,8 @@ static void proc_response(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 
 static void proc_cmd(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 {
+	GError *gerr = NULL;
+
 	if ((cmd[0] >= MCAP_MD_SYNC_CAP_REQ) &&
 					(cmd[0] <= MCAP_MD_SYNC_INFO_IND)) {
 		proc_sync_cmd(mcl, cmd, len);
@@ -1476,8 +1537,13 @@ static void proc_cmd(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 			if (mcl->role == MCL_INITIATOR)
 				/* ignore */
 				return;
-			proc_req[mcl->state](mcl, cmd, len);
 			/* Initiator will ignore our last request */
+			proc_req[mcl->state](mcl, cmd, len);
+			RELEASE_TIMER(mcl);
+			mcl->req = MCL_AVAILABLE;
+			g_set_error(&gerr, MCAP_ERROR, MCAP_ERROR_REQ_IGNORED,
+				"Initiator sent a request with more priority");
+			mcap_notify_error(mcl, gerr, TRUE);
 			return;
 		}
 		proc_response(mcl, cmd, len);
diff --git a/mcap/mcap_lib.h b/mcap/mcap_lib.h
index 2283dac..67c2f29 100644
--- a/mcap/mcap_lib.h
+++ b/mcap/mcap_lib.h
@@ -51,6 +51,7 @@ typedef enum {
 /* MCAP Internal Errors */
 	MCAP_ERROR_INVALID_ARGS,
 	MCAP_ERROR_ALREADY_EXISTS,
+	MCAP_ERROR_REQ_IGNORED,
 	MCAP_ERROR_FAILED
 } McapError;
 
-- 
1.6.3.3

