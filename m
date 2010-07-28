Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 12/16] Process MCAP process_md_delete_mdl request and response commands
Date: Wed, 28 Jul 2010 10:03:52 +0200
Message-Id: <1280304232-2939-6-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1280304232-2939-5-git-send-email-santoscadenas@gmail.com>
References: <1280304015-9230-7-git-send-email-sancane@gmail.com>
 <1280304232-2939-1-git-send-email-santoscadenas@gmail.com>
 <1280304232-2939-2-git-send-email-santoscadenas@gmail.com>
 <1280304232-2939-3-git-send-email-santoscadenas@gmail.com>
 <1280304232-2939-4-git-send-email-santoscadenas@gmail.com>
 <1280304232-2939-5-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/mcap.c     |  203 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 health/mcap_lib.h |    8 ++
 2 files changed, 208 insertions(+), 3 deletions(-)

diff --git a/health/mcap.c b/health/mcap.c
index 18749e3..050a896 100644
--- a/health/mcap.c
+++ b/health/mcap.c
@@ -508,6 +508,86 @@ void mcap_reconnect_mdl(struct mcap_mdl *mdl,
 									mcl);
 }
 
+static void send_delete_req(GError **err, struct mcap_mcl *mcl,
+				struct mcap_mdl_op_cb *con, uint16_t mdlid)
+{
+	mcap_md_req *cmd;
+
+	cmd = create_req(MCAP_MD_DELETE_MDL_REQ, mdlid);
+	mcap_send_std_opcode(mcl, cmd, sizeof(mcap_md_req), err);
+	if (*err) {
+		g_free(cmd);
+		return;
+	}
+
+	mcl->priv_data = con;
+
+	mcl->tid = g_timeout_add_seconds(RESPONSE_TIMER, wait_response_timer,
+									mcl);
+}
+
+void mcap_delete_all_mdls(struct mcap_mcl *mcl, mcap_mdl_notify_cb delete_cb,
+					gpointer user_data, GError **err)
+{
+	GSList *l;
+	struct mcap_mdl *mdl;
+	struct mcap_mdl_op_cb *con;
+
+	DBG("MCL in state: %d", mcl->state);
+	if (!mcl->mdls) {
+		g_set_error(err, MCAP_ERROR, MCAP_ERROR_FAILED,
+				"There are not MDLs created");
+		return;
+	}
+
+	for (l = mcl->mdls; l; l = l->next) {
+		mdl = l->data;
+		if (mdl->state != MDL_WAITING)
+			mdl->state = MDL_DELETING;
+	}
+
+	con = g_new0(struct mcap_mdl_op_cb, 1);
+	con->mdl = NULL;
+	con->cb.notify = delete_cb;
+	con->user_data = user_data;
+
+	send_delete_req(err, mcl, con, MCAP_ALL_MDLIDS);
+	if (*err)
+		g_free(con);
+}
+
+void mcap_delete_mdl(struct mcap_mdl *mdl, mcap_mdl_notify_cb delete_cb,
+					gpointer user_data, GError **err)
+{
+	struct mcap_mcl *mcl= mdl->mcl;
+	struct mcap_mdl_op_cb *con;
+	GSList *l;
+
+	l = g_slist_find(mcl->mdls, mdl);
+
+	if (!l) {
+		g_set_error(err, MCAP_ERROR, MCAP_ERROR_INVALID_MDL,
+					"%s" , error2str(MCAP_INVALID_MDEP));
+		return;
+	}
+
+	if (mdl->state == MDL_WAITING) {
+		g_set_error(err, MCAP_ERROR, MCAP_ERROR_FAILED,
+							"Mdl is not created");
+		return;
+	}
+	mdl->state = MDL_DELETING;
+
+	con = g_new0(struct mcap_mdl_op_cb, 1);
+	con->mdl = mdl;
+	con->cb.notify = delete_cb;
+	con->user_data = user_data;
+
+	send_delete_req(err, mcl, con, mdl->mdlid);
+	if (*err)
+		g_free(con);
+}
+
 void mcap_mdl_abort(struct mcap_mdl *mdl, mcap_mdl_notify_cb abort_cb,
 					gpointer user_data, GError **err)
 {
@@ -816,6 +896,18 @@ void mcap_mcl_get_addr(struct mcap_mcl *mcl, bdaddr_t *addr)
 	bacpy(addr, &mcl->addr);
 }
 
+static void mcap_del_mdl(gpointer elem, gpointer user_data)
+{
+	struct mcap_mdl *mdl = elem;
+	gboolean notify = *(gboolean *)user_data;
+
+	shutdown_mdl(mdl);
+	if (notify)
+		mdl->mcl->cb->mdl_deleted(mdl, mdl->mcl->cb->user_data);
+
+	g_free(mdl);
+}
+
 static void process_md_create_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 								uint32_t len)
 {
@@ -1000,7 +1092,58 @@ static void process_md_abort_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 static void process_md_delete_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 								uint32_t len)
 {
-	/* TODO: Implement process_md_delete_mdl_req */
+	mcap_md_req *req;
+	struct mcap_mdl *mdl, *aux;
+	uint16_t mdlid;
+	gboolean notify;
+	GSList *l;
+
+	if (len != sizeof(mcap_md_req)) {
+		mcap_send_cmd(mcl, MCAP_MD_ABORT_MDL_RSP,
+			MCAP_INVALID_PARAM_VALUE, MCAP_MDLID_RESERVED, NULL, 0);
+		return;
+	}
+
+	req = (mcap_md_req *)cmd;
+	mdlid = ntohs(req->mdl);
+	if (mdlid == MCAP_ALL_MDLIDS) {
+		notify = FALSE;
+		g_slist_foreach(mcl->mdls, mcap_del_mdl, &notify);
+		g_slist_free(mcl->mdls);
+		mcl->mdls = NULL;
+		mcl->state = MCL_CONNECTED;
+		/* NULL mdl means ALL_MDLS */
+		mcl->cb->mdl_deleted(NULL, mcl->cb->user_data);
+		goto resp;
+	}
+
+	if (mdlid < MCAP_MDLID_INITIAL || mdlid > MCAP_MDLID_FINAL) {
+		mcap_send_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, MCAP_INVALID_MDL,
+								mdlid, NULL, 0);
+		return;
+	}
+
+	for (l = mcl->mdls, mdl = NULL; l; l = l->next) {
+		aux = l->data;
+		if (aux->mdlid == mdlid) {
+			mdl = aux;
+			break;
+		}
+	}
+
+	if (!mdl || mdl->state == MDL_WAITING) {
+		mcap_send_cmd(mcl, MCAP_MD_DELETE_MDL_RSP, MCAP_INVALID_MDL,
+								mdlid, NULL, 0);
+		return;
+	}
+	mcl->mdls = g_slist_remove(mcl->mdls, mdl);
+	update_mcl_state(mcl);
+	notify = TRUE;
+	mcap_del_mdl(mdl, &notify);
+
+resp:
+	mcap_send_cmd(mcl, MCAP_MD_DELETE_MDL_RSP, MCAP_SUCCESS, mdlid,
+								NULL, 0);
 }
 
 static void invalid_req_state(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
@@ -1240,11 +1383,65 @@ static gboolean process_md_abort_mdl_rsp(struct mcap_mcl *mcl,
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
-	/* TODO: Implement process_md_delete_mdl_rsp */
-	return TRUE;
+	struct mcap_mdl_op_cb *del = mcl->priv_data;
+	struct mcap_mdl *mdl = del->mdl;
+	mcap_mdl_notify_cb deleted_cb = del->cb.notify;
+	gpointer user_data = del->user_data;
+	mcap_md_req *cmdlast = (mcap_md_req *) mcl->lcmd;
+	uint16_t mdlid = ntohs(cmdlast->mdl);
+	GError *gerr = NULL;
+	gboolean close = FALSE;
+	gboolean notify = FALSE;
+
+	g_free(mcl->priv_data);
+	mcl->priv_data = NULL;
+
+	close = check_err_rsp(mcl, cmd, len, sizeof(mcap_rsp), &gerr);
+
+	g_free(mcl->lcmd);
+	mcl->lcmd = NULL;
+	mcl->req = MCL_AVAILABLE;
+
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
+		g_slist_foreach(mcl->mdls, mcap_del_mdl, &notify);
+		g_slist_free(mcl->mdls);
+		mcl->mdls = NULL;
+		mcl->state = MCL_CONNECTED;
+		goto end;
+	}
+
+	mcl->mdls = g_slist_remove(mcl->mdls, mdl);
+	update_mcl_state(mcl);
+	mcap_del_mdl(mdl, &notify);
+end:
+	deleted_cb(gerr, user_data);
+	return close;
 }
 
 static void proc_response(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
diff --git a/health/mcap_lib.h b/health/mcap_lib.h
index fbf97df..b9fc9a5 100644
--- a/health/mcap_lib.h
+++ b/health/mcap_lib.h
@@ -108,6 +108,14 @@ void mcap_reconnect_mdl(struct mcap_mdl *mdl,
 				mcap_mdl_operation_cb reconnect_cb,
 				gpointer user_data,
 				GError **err);
+void mcap_delete_all_mdls(struct mcap_mcl *mcl,
+				mcap_mdl_notify_cb delete_cb,
+				gpointer user_data,
+				GError **err);
+void mcap_delete_mdl(struct mcap_mdl *mdl,
+				mcap_mdl_notify_cb delete_cb,
+				gpointer user_data,
+				GError **err);
 void mcap_connect_mdl(struct mcap_mdl *mdl,
 				BtIOType BtType,
 				uint16_t dcpsm,
-- 
1.7.0.4

