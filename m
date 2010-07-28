Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 10/16] Process MCAP process_md_abort_mdl request and response commands
Date: Wed, 28 Jul 2010 10:03:50 +0200
Message-Id: <1280304232-2939-4-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1280304232-2939-3-git-send-email-santoscadenas@gmail.com>
References: <1280304015-9230-7-git-send-email-sancane@gmail.com>
 <1280304232-2939-1-git-send-email-santoscadenas@gmail.com>
 <1280304232-2939-2-git-send-email-santoscadenas@gmail.com>
 <1280304232-2939-3-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/mcap.c     |  116 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 health/mcap_lib.h |    4 ++
 2 files changed, 117 insertions(+), 3 deletions(-)

diff --git a/health/mcap.c b/health/mcap.c
index ecaa43f..6006c2a 100644
--- a/health/mcap.c
+++ b/health/mcap.c
@@ -365,6 +365,18 @@ static uint16_t generate_mdlid(struct mcap_mcl *mcl)
 	return 0;
 }
 
+static mcap_md_req *create_req(uint8_t op, uint16_t mdl_id)
+{
+	mcap_md_req *req_cmd;
+
+	req_cmd = g_malloc0(sizeof(mcap_md_req));
+
+	req_cmd->op = op;
+	req_cmd->mdl = htons(mdl_id);
+
+	return req_cmd;
+}
+
 static mcap_md_create_mdl_req *create_mdl_req(uint16_t mdl_id, uint8_t mdep,
 								uint8_t conf)
 {
@@ -459,6 +471,38 @@ void mcap_create_mdl(struct mcap_mcl *mcl,
 									mcl);
 }
 
+void mcap_mdl_abort(struct mcap_mdl *mdl, mcap_mdl_notify_cb abort_cb,
+					gpointer user_data, GError **err)
+{
+	struct mcap_mdl_op_cb *con;
+	struct mcap_mcl *mcl = mdl->mcl;
+	mcap_md_req *cmd;
+
+	if (mdl->state != MDL_WAITING) {
+		g_set_error(err, MCAP_ERROR, MCAP_ERROR_FAILED,
+							"Mdl in invalid state");
+		return;
+	}
+
+	con = g_new0(struct mcap_mdl_op_cb, 1);
+	cmd = create_req(MCAP_MD_ABORT_MDL_REQ, mdl->mdlid);
+	mcap_send_std_opcode(mcl, cmd, sizeof(mcap_md_req), err);
+	if (*err) {
+		g_free(con);
+		g_free(cmd);
+		return;
+	}
+
+	con->mdl = mdl;
+	con->cb.notify = abort_cb;
+	con->user_data = user_data;
+
+	mcl->priv_data = con;
+
+	mcl->tid = g_timeout_add_seconds(RESPONSE_TIMER, wait_response_timer,
+									mcl);
+}
+
 static struct mcap_mcl *find_mcl(GSList *list, const bdaddr_t *addr)
 {
 	GSList *l;
@@ -829,7 +873,45 @@ static void process_md_reconnect_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 static void process_md_abort_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 								uint32_t len)
 {
-	/* TODO: Implement process_md_abort_mdl_req */
+	mcap_md_req *req;
+	GSList *l;
+	struct mcap_mdl *mdl, *abrt;
+	uint16_t mdl_id;
+
+	if (len != sizeof(mcap_md_req)) {
+		mcap_send_cmd(mcl, MCAP_MD_ABORT_MDL_RSP,
+			MCAP_INVALID_PARAM_VALUE, MCAP_MDLID_RESERVED, NULL, 0);
+		return;
+	}
+
+	req = (mcap_md_req *)cmd;
+	mdl_id = ntohs(req->mdl);
+	mcl->state = MCL_CONNECTED;
+	for (l = mcl->mdls; l; l = l->next) {
+		mdl = l->data;
+		if (mdl_id == mdl->mdlid && mdl->state == MDL_WAITING) {
+			abrt = mdl;
+			if (mcl->state != MCL_CONNECTED)
+				break;
+			continue;
+		}
+		if (mdl->state == MDL_CONNECTED && mcl->state != MCL_ACTIVE)
+			mcl->state = MCL_ACTIVE;
+
+		if (abrt && mcl->state == MCL_ACTIVE)
+			break;
+	}
+
+	if (!abrt) {
+		mcap_send_cmd(mcl, MCAP_MD_ABORT_MDL_RSP, MCAP_INVALID_MDL,
+							mdl_id, NULL, 0);
+		return;
+	}
+
+	mcl->cb->mdl_aborted(abrt, mcl->cb->user_data);
+	abrt->state = MDL_CLOSED;
+	mcap_send_cmd(mcl, MCAP_MD_ABORT_MDL_RSP, MCAP_SUCCESS, mdl_id,
+								NULL, 0);
 }
 
 static void process_md_delete_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
@@ -1011,8 +1093,36 @@ static gboolean process_md_reconnect_mdl_rsp(struct mcap_mcl *mcl,
 static gboolean process_md_abort_mdl_rsp(struct mcap_mcl *mcl,
 						uint8_t *cmd, uint32_t len)
 {
-	/* TODO: Implement process_md_abort_mdl_rsp */
-	return TRUE;
+	struct mcap_mdl_op_cb *abrt = mcl->priv_data;
+	mcap_mdl_notify_cb abrt_cb = abrt->cb.notify;
+	gpointer user_data = abrt->user_data;
+	struct mcap_mdl *mdl = abrt->mdl;
+	mcap_rsp *rsp = (mcap_rsp *)cmd;
+	GError *gerr = NULL;
+	gboolean close = FALSE;
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
+	abrt_cb(gerr, user_data);
+	shutdown_mdl(mdl);
+
+	if (len >= sizeof(mcap_rsp) && rsp->rc == MCAP_INVALID_MDL) {
+		mcl->mdls = g_slist_remove(mcl->mdls, mdl);
+		g_free(mdl);
+	}
+
+	if (!gerr)
+		g_error_free(gerr);
+
+	update_mcl_state(mcl);
+	return close;
 }
 
 static gboolean process_md_delete_mdl_rsp(struct mcap_mcl *mcl, uint8_t *cmd,
diff --git a/health/mcap_lib.h b/health/mcap_lib.h
index 7bdcbc5..106c1c7 100644
--- a/health/mcap_lib.h
+++ b/health/mcap_lib.h
@@ -110,6 +110,10 @@ void mcap_connect_mdl(struct mcap_mdl *mdl,
 				mcap_mdl_operation_cb connect_cb,
 				gpointer user_data,
 				GError **err);
+void mcap_mdl_abort(struct mcap_mdl *mdl,
+				mcap_mdl_notify_cb abort_cb,
+				gpointer user_data,
+				GError **err);
 
 /* Mcl operations*/
 
-- 
1.7.0.4

