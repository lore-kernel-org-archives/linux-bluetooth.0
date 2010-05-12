Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot Nemesio <sancane@gmail.com>
Subject: [PATCH 10/25] Process md_create_mdl_req command in state connected
Date: Wed, 12 May 2010 11:56:52 +0200
Message-Id: <1273658212-17628-1-git-send-email-sancane@gmail.com>
In-Reply-To: <1273486527-7855-10-git-send-email-sancane@gmail.com>
References: <1273486527-7855-10-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Santiago Carot Nemesio <sancane@gmail.com>

---
 mcap/mcap.c |  153 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 151 insertions(+), 2 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 3a4b2b9..1bc3ed5 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -95,6 +95,40 @@ static int send4B_cmd(struct mcap_mcl *mcl, uint8_t oc, uint8_t rc,
 	return sent;
 }
 
+static int send5B_cmd(struct mcap_mcl *mcl, uint8_t oc, uint8_t rc,
+						uint16_t mdl, uint8_t param)
+{
+	uint8_t *rsp;
+	mcap5B_rsp *suc;
+	int sent;
+
+	rsp = g_malloc0(sizeof(mcap5B_rsp));
+
+	suc = (mcap5B_rsp *)rsp;
+	suc->op = oc;
+	suc->rc = rc;
+	suc->mdl = htons(mdl);
+	suc->param = param;
+
+	sent = mcap_send_data(g_io_channel_unix_get_fd(mcl->cc), rsp,
+							sizeof(mcap5B_rsp));
+	g_free(rsp);
+	return sent;
+}
+
+static gint compare_mdl(gconstpointer a, gconstpointer b)
+{
+	const struct mcap_mdl *mdla = a;
+	const struct mcap_mdl *mdlb = b;
+
+	if (mdla->mdlid == mdlb->mdlid)
+		return 0;
+	else if (mdla->mdlid < mdlb->mdlid)
+		return -1;
+	else
+		return 1;
+}
+
 static void default_mdl_connected_cb(struct mcap_mdl *mdl, gpointer data)
 {
 	debug("MCAP Unmanaged mdl connection");
@@ -425,11 +459,126 @@ bdaddr_t mcap_mcl_get_addr(struct mcap_mcl *mcl)
 	return mcl->addr;
 }
 
-/* Function used to process commands depending of MCL state */
+static void error_cmd_rsp(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
+{
+	uint16_t mdlr;
+
+	if (cmd[0] <= MCAP_MD_DELETE_MDL_RSP) {
+		/* Standard Op Code request is invalid in current state */
+		error("Invalid cmd received (op code = %d) in state %d",
+							cmd[0],	mcl->state);
+		/* Get mdlid sended to generate appropriate response if it is possible */
+		mdlr = len < sizeof(mcap_md_req) ? MCAP_MDLID_RESERVED :
+						ntohs(((mcap_md_req *)cmd)->mdl);
+		send4B_cmd(mcl, cmd[0]+1, MCAP_INVALID_OPERATION, mdlr);
+	} else {
+		error("Unknown cmd request received (op code = %d) in state %d",
+							cmd[0], mcl->state);
+		send4B_cmd(mcl, MCAP_ERROR_RSP, MCAP_INVALID_OP_CODE,
+							MCAP_MDLID_RESERVED);
+	}
+}
+
+static struct mcap_mdl *get_mdl(struct mcap_mcl *mcl, uint16_t mdlid)
+{
+	GSList *l;
+	struct mcap_mdl *mdl;
+
+	for (l = mcl->mdls; l; l = l->next) {
+		mdl = l->data;
+		if (mdlid == mdl->mdlid)
+			return mdl;
+	}
+
+	return NULL;
+}
+
+static void process_md_create_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
+{
+	mcap_md_create_mdl_req *req;
+	struct mcap_mdl *mdl;
+	uint16_t mdl_id;
+	uint8_t mdep_id;
+	uint8_t cfga, conf;
+	uint8_t rsp;
+
+	if (len != sizeof(mcap_md_create_mdl_req)) {
+		send4B_cmd(mcl, MCAP_MD_CREATE_MDL_RSP,
+				MCAP_INVALID_PARAM_VALUE, MCAP_MDLID_RESERVED);
+		return;
+	}
+
+	req = (mcap_md_create_mdl_req *)cmd;
+
+	mdl_id = ntohs(req->mdl);
+	if ((mdl_id < MCAP_MDLID_INITIAL) || (mdl_id > MCAP_MDLID_FINAL)) {
+		send4B_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, MCAP_INVALID_MDL, mdl_id);
+		return;
+	}
+
+	mdep_id = req->mdep;
+	if (mdep_id > MCAP_MDEPID_FINAL) {
+		send4B_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, MCAP_INVALID_MDEP, mdl_id);
+		return;
+	}
+
+	cfga = conf = req->conf;
+	/* Callback to upper layer */
+	rsp = mcl->cb->mdl_conn_req(mcl, mdep_id, mdl_id, &conf,
+							mcl->cb->user_data);
+	if (mcl->state == MCL_IDLE) {
+		/* MCL has been closed int the callback */
+		return;
+	}
+
+	if ((cfga != 0) && (cfga != conf)) {
+		/* Remote device set default configuration but upper profile */
+		/* has changed it. Protocol Error: force closing the MCL by */
+		/* remote device using UNSPECIFIED_ERROR response */
+		send4B_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, MCAP_UNSPECIFIED_ERROR,
+								mdl_id);
+		return;
+	}
+	if (rsp != MCAP_SUCCESS) {
+		send4B_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, rsp, mdl_id);
+		return;
+	}
 
+	mdl = get_mdl(mcl, mdl_id);
+	if (!mdl) {
+		mdl = g_malloc0(sizeof(struct mcap_mdl));
+		mdl->mcl = mcl;
+		mdl->mdlid = mdl_id;
+	} else if (mdl->state == MDL_CONNECTED) {
+		/* MCAP specification says that we should close the MCL if
+		 * it is open when we receive a MD_CREATE_MDL_REQ */
+		shutdown_mdl(mdl);
+	}
+	mdl->mdep_id = mdep_id;
+	mdl->state = MDL_WAITING;
+	mcl->mdls = g_slist_insert_sorted(mcl->mdls, mdl, compare_mdl);
+
+	mcl->state = MCL_PENDING;
+	send5B_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, MCAP_SUCCESS, mdl_id, conf);
+}
+
+
+/* Function used to process commands depending of MCL state */
 static void proc_req_connected(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 {
-	/* TODO: Proccessing commands in CONNECTED state */
+	switch (cmd[0]) {
+	case MCAP_MD_CREATE_MDL_REQ:
+		process_md_create_mdl_req(mcl, cmd, len);
+		break;
+	case MCAP_MD_RECONNECT_MDL_REQ:
+		/*process_md_reconnect_mdl_req(mcl, cmd, len);*/
+		break;
+	case MCAP_MD_DELETE_MDL_REQ:
+		/*process_md_delete_mdl_req(mcl, cmd, len);*/
+		break;
+	default:
+		error_cmd_rsp(mcl, cmd, len);
+	}
 }
 
 static void proc_req_pending(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
-- 
1.6.3.3

