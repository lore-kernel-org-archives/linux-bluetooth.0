Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 11/16] Process MCAP process_md_reconnect_mdl request and response commands
Date: Wed, 28 Jul 2010 10:03:51 +0200
Message-Id: <1280304232-2939-5-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1280304232-2939-4-git-send-email-santoscadenas@gmail.com>
References: <1280304015-9230-7-git-send-email-sancane@gmail.com>
 <1280304232-2939-1-git-send-email-santoscadenas@gmail.com>
 <1280304232-2939-2-git-send-email-santoscadenas@gmail.com>
 <1280304232-2939-3-git-send-email-santoscadenas@gmail.com>
 <1280304232-2939-4-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/mcap.c     |  121 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 health/mcap_lib.h |    4 ++
 2 files changed, 122 insertions(+), 3 deletions(-)

diff --git a/health/mcap.c b/health/mcap.c
index 6006c2a..18749e3 100644
--- a/health/mcap.c
+++ b/health/mcap.c
@@ -471,6 +471,43 @@ void mcap_create_mdl(struct mcap_mcl *mcl,
 									mcl);
 }
 
+void mcap_reconnect_mdl(struct mcap_mdl *mdl,
+				mcap_mdl_operation_cb reconnect_cb,
+				gpointer user_data,
+				GError **err)
+{
+	struct mcap_mdl_op_cb *con;
+	struct mcap_mcl *mcl = mdl->mcl;
+	mcap_md_req *cmd;
+
+	if (mdl->state != MDL_CLOSED) {
+		g_set_error(err, MCAP_ERROR, MCAP_ERROR_FAILED,
+					"MDL is not closed");
+		return;
+	}
+	con = g_new0(struct mcap_mdl_op_cb, 1);
+
+	cmd = create_req(MCAP_MD_RECONNECT_MDL_REQ, mdl->mdlid);
+	mcap_send_std_opcode(mcl, cmd, sizeof(mcap_md_req), err);
+	if (*err) {
+		g_free(con);
+		g_free(cmd);
+		return;
+	}
+
+	mdl->state = MDL_WAITING;
+
+	con->mdl = mdl;
+	con->cb.op = reconnect_cb;
+	con->user_data = user_data;
+
+	mcl->state = MCL_ACTIVE;
+	mcl->priv_data = con;
+
+	mcl->tid = g_timeout_add_seconds(RESPONSE_TIMER, wait_response_timer,
+									mcl);
+}
+
 void mcap_mdl_abort(struct mcap_mdl *mdl, mcap_mdl_notify_cb abort_cb,
 					gpointer user_data, GError **err)
 {
@@ -867,7 +904,53 @@ static void process_md_create_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 static void process_md_reconnect_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 								uint32_t len)
 {
-	/* TODO: Implement process_md_reconnect_mdl_req */
+	mcap_md_req *req;
+	struct mcap_mdl *mdl;
+	uint16_t mdl_id;
+	uint8_t rsp;
+
+	if (len != sizeof(mcap_md_req)) {
+		mcap_send_cmd(mcl, MCAP_MD_RECONNECT_MDL_RSP,
+						MCAP_INVALID_PARAM_VALUE,
+						MCAP_MDLID_RESERVED,
+						NULL, 0);
+		return;
+	}
+
+	req = (mcap_md_req *)cmd;
+	mdl_id = ntohs(req->mdl);
+
+	mdl = get_mdl(mcl, mdl_id);
+	if (!mdl) {
+		mcap_send_cmd(mcl, MCAP_MD_RECONNECT_MDL_RSP, MCAP_INVALID_MDL,
+							mdl_id, NULL, 0);
+		return;
+	} else if (mdl->state == MDL_WAITING || mdl->state == MDL_DELETING ) {
+		/* Creation request arrives for a MDL that is being managed
+		* at current moment */
+		mcap_send_cmd(mcl, MCAP_MD_RECONNECT_MDL_RSP, MCAP_MDL_BUSY,
+							mdl_id, NULL, 0);
+		return;
+	}
+
+	/* Callback to upper layer */
+	rsp = mcl->cb->mdl_reconn_req(mdl, mcl->cb->user_data);
+	if (mcl->state == MCL_IDLE)
+		return;
+
+	if (rsp != MCAP_SUCCESS) {
+		mcap_send_cmd(mcl, MCAP_MD_RECONNECT_MDL_RSP, rsp, mdl_id,
+								NULL, 0);
+		return;
+	}
+
+	if (mdl->state == MDL_CONNECTED)
+		shutdown_mdl(mdl);
+
+	mdl->state = MDL_WAITING;
+	mcl->state = MCL_PENDING;
+	mcap_send_cmd(mcl, MCAP_MD_RECONNECT_MDL_RSP, MCAP_SUCCESS, mdl_id,
+								NULL, 0);
 }
 
 static void process_md_abort_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
@@ -1086,8 +1169,40 @@ fail:
 static gboolean process_md_reconnect_mdl_rsp(struct mcap_mcl *mcl,
 						uint8_t *cmd, uint32_t len)
 {
-	/* TODO: Implement process_md_reconnect_mdl_rsp */
-	return TRUE;
+	struct mcap_mdl_op_cb *reconn = mcl->priv_data;
+	mcap_mdl_operation_cb reconn_cb = reconn->cb.op;
+	gpointer user_data = reconn->user_data;
+	struct mcap_mdl *mdl = reconn->mdl;
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
+	reconn_cb(mdl, gerr, user_data);
+	if (!gerr)
+		return close;
+
+	g_error_free(gerr);
+	shutdown_mdl(mdl);
+	update_mcl_state(mcl);
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
diff --git a/health/mcap_lib.h b/health/mcap_lib.h
index 106c1c7..fbf97df 100644
--- a/health/mcap_lib.h
+++ b/health/mcap_lib.h
@@ -104,6 +104,10 @@ void mcap_create_mdl(struct mcap_mcl *mcl,
 				mcap_mdl_operation_conf_cb connect_cb,
 				gpointer user_data,
 				GError **err);
+void mcap_reconnect_mdl(struct mcap_mdl *mdl,
+				mcap_mdl_operation_cb reconnect_cb,
+				gpointer user_data,
+				GError **err);
 void mcap_connect_mdl(struct mcap_mdl *mdl,
 				BtIOType BtType,
 				uint16_t dcpsm,
-- 
1.7.0.4

