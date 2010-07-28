Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 07/16] Process MCAP request mcap_md_create_mdl_req
Date: Wed, 28 Jul 2010 10:03:47 +0200
Message-Id: <1280304232-2939-1-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1280304015-9230-7-git-send-email-sancane@gmail.com>
References: <1280304015-9230-7-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/mcap.c |  255 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 health/mcap.h |    5 +
 2 files changed, 255 insertions(+), 5 deletions(-)

diff --git a/health/mcap.c b/health/mcap.c
index 7366c66..9bb81cf 100644
--- a/health/mcap.c
+++ b/health/mcap.c
@@ -163,9 +163,103 @@ static void mcap_send_std_opcode(struct mcap_mcl *mcl, void *cmd,
 	mcl->req = MCL_WAITING_RSP;
 }
 
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
 static void mcap_notify_error(struct mcap_mcl *mcl, GError *err)
 {
-	/* TODO: implement mcap_notify_error */
+	struct mcap_mdl_op_cb *con = mcl->priv_data;
+	struct mcap_mdl *mdl;
+	MDLState st;
+	GSList *l;
+
+	if (!con || !mcl->lcmd)
+		return;
+
+	switch (mcl->lcmd[0]){
+	case MCAP_MD_CREATE_MDL_REQ:
+		st = MDL_WAITING;
+		l = g_slist_find_custom(mcl->mdls, &st, cmp_mdl_state);
+		mdl = l->data;
+		mcl->mdls = g_slist_remove(mcl->mdls, mdl);
+		g_free(mdl);
+		update_mcl_state(mcl);
+		con->cb.op_conf(NULL, 0, err, con->user_data);
+		break;
+	case MCAP_MD_ABORT_MDL_REQ:
+		st = MDL_WAITING;
+		l = g_slist_find_custom(mcl->mdls, &st, cmp_mdl_state);
+		shutdown_mdl(l->data);
+		update_mcl_state(mcl);
+		con->cb.notify(err, con->user_data);
+		break;
+	case MCAP_MD_DELETE_MDL_REQ:
+		for (l = mcl->mdls; l; l = l->next) {
+			mdl = l->data;
+			if (mdl->state == MDL_DELETING)
+				mdl->state = (mdl->dc) ? MDL_CONNECTED :
+								MDL_CLOSED;
+		}
+		update_mcl_state(mcl);
+		con->cb.notify(err, con->user_data);
+		break;
+	case MCAP_MD_RECONNECT_MDL_REQ:
+		st = MDL_WAITING;
+		l = g_slist_find_custom(mcl->mdls, &st, cmp_mdl_state);
+		shutdown_mdl(l->data);
+		update_mcl_state(mcl);
+		con->cb.op(NULL, err, con->user_data);
+		break;
+	}
+
+	g_free(mcl->priv_data);
+	mcl->priv_data = NULL;
+
+	g_free(mcl->lcmd);
+	mcl->lcmd = NULL;
 }
 
 int mcap_send_data(int sock, const uint8_t *buf, uint32_t size)
@@ -350,7 +444,23 @@ static struct mcap_mcl *find_mcl(GSList *list, const bdaddr_t *addr)
 
 static void mcap_free_mdls(struct mcap_mcl *mcl, gboolean save)
 {
-	/* TODO: implement mcap_free_mdls */
+	GSList *l;
+	struct mcap_mdl *mdl;
+
+	if (!mcl->mdls)
+		return;
+
+	for (l = mcl->mdls; l; l = l->next) {
+		mdl = l->data;
+		shutdown_mdl(mdl);
+		if (!save)
+			g_free(mdl);
+	}
+
+	if (!save) {
+		g_slist_free(mcl->mdls);
+		mcl->mdls = NULL;
+	}
 }
 
 static void close_mcl(struct mcap_mcl *mcl, gboolean save)
@@ -593,20 +703,155 @@ void mcap_mcl_get_addr(struct mcap_mcl *mcl, bdaddr_t *addr)
 	bacpy(addr, &mcl->addr);
 }
 
+static void process_md_create_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
+								uint32_t len)
+{
+	mcap_md_create_mdl_req *req;
+	struct mcap_mdl *mdl;
+	uint16_t mdl_id;
+	uint8_t mdep_id;
+	uint8_t cfga, conf;
+	uint8_t rsp;
+
+	if (len != sizeof(mcap_md_create_mdl_req)) {
+		mcap_send_cmd(mcl, MCAP_MD_CREATE_MDL_RSP,
+						MCAP_INVALID_PARAM_VALUE,
+						MCAP_MDLID_RESERVED,
+						NULL, 0);
+		return;
+	}
+
+	req = (mcap_md_create_mdl_req *)cmd;
+
+	mdl_id = ntohs(req->mdl);
+	if (mdl_id < MCAP_MDLID_INITIAL || mdl_id > MCAP_MDLID_FINAL) {
+		mcap_send_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, MCAP_INVALID_MDL,
+							mdl_id, NULL, 0);
+		return;
+	}
+
+	mdep_id = req->mdep;
+	if (mdep_id > MCAP_MDEPID_FINAL) {
+		mcap_send_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, MCAP_INVALID_MDEP,
+							mdl_id, NULL, 0);
+		return;
+	}
+
+	mdl = get_mdl(mcl, mdl_id);
+	if (mdl && (mdl->state == MDL_WAITING || mdl->state == MDL_DELETING )) {
+		/* Creation request arrives for a MDL that is being managed
+		* at current moment */
+		mcap_send_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, MCAP_MDL_BUSY,
+							mdl_id, NULL, 0);
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
+	if (cfga != 0 && cfga != conf) {
+		/* Remote device set default configuration but upper profile */
+		/* has changed it. Protocol Error: force closing the MCL by */
+		/* remote device using UNSPECIFIED_ERROR response */
+		mcap_send_cmd(mcl, MCAP_MD_CREATE_MDL_RSP,
+				MCAP_UNSPECIFIED_ERROR, mdl_id, NULL, 0);
+		return;
+	}
+	if (rsp != MCAP_SUCCESS) {
+		mcap_send_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, rsp, mdl_id,
+								NULL, 0);
+		return;
+	}
+
+	if (!mdl) {
+		mdl = g_malloc0(sizeof(struct mcap_mdl));
+		mdl->mcl = mcl;
+		mdl->mdlid = mdl_id;
+		mcl->mdls = g_slist_insert_sorted(mcl->mdls, mdl, compare_mdl);
+	} else if (mdl->state == MDL_CONNECTED) {
+		/* MCAP specification says that we should close the MCL if
+		 * it is open when we receive a MD_CREATE_MDL_REQ */
+		shutdown_mdl(mdl);
+	}
+
+	mdl->mdep_id = mdep_id;
+	mdl->state = MDL_WAITING;
+
+	mcl->state = MCL_PENDING;
+	mcap_send_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, MCAP_SUCCESS, mdl_id,
+								&conf, 1);
+}
+
+static void process_md_reconnect_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
+								uint32_t len)
+{
+	/* TODO: Implement process_md_reconnect_mdl_req */
+}
+
+static void process_md_abort_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
+								uint32_t len)
+{
+	/* TODO: Implement process_md_abort_mdl_req */
+}
+
+static void process_md_delete_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
+								uint32_t len)
+{
+	/* TODO: Implement process_md_delete_mdl_req */
+}
+
+static void invalid_req_state(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
+{
+	/* TODO: Implements invalid_req_state */
+}
+
 /* Function used to process commands depending of MCL state */
 static void proc_req_connected(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 {
-	/* TODO: Implement proc_req_connected */
+	switch (cmd[0]) {
+	case MCAP_MD_CREATE_MDL_REQ:
+		process_md_create_mdl_req(mcl, cmd, len);
+		break;
+	case MCAP_MD_RECONNECT_MDL_REQ:
+		process_md_reconnect_mdl_req(mcl, cmd, len);
+		break;
+	case MCAP_MD_DELETE_MDL_REQ:
+		process_md_delete_mdl_req(mcl, cmd, len);
+		break;
+	default:
+		invalid_req_state(mcl, cmd, len);
+	}
 }
 
 static void proc_req_pending(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 {
-	/* TODO: Implement proc_req_pending */
+	if (cmd[0] == MCAP_MD_ABORT_MDL_REQ)
+		process_md_abort_mdl_req(mcl, cmd, len);
+	else
+		invalid_req_state(mcl, cmd, len);
 }
 
 static void proc_req_active(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 {
-	/* TODO: Implement proc_req_active */
+	switch (cmd[0]) {
+	case MCAP_MD_CREATE_MDL_REQ:
+		process_md_create_mdl_req(mcl, cmd, len);
+		break;
+	case MCAP_MD_RECONNECT_MDL_REQ:
+		process_md_reconnect_mdl_req(mcl, cmd, len);
+		break;
+	case MCAP_MD_DELETE_MDL_REQ:
+		process_md_delete_mdl_req(mcl, cmd, len);
+		break;
+	default:
+		invalid_req_state(mcl, cmd, len);
+	}
 }
 
 static void proc_response(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
diff --git a/health/mcap.h b/health/mcap.h
index 8c3679f..d0d552a 100644
--- a/health/mcap.h
+++ b/health/mcap.h
@@ -74,6 +74,11 @@ extern "C" {
 #define MCAP_MDLID_FINAL		0xFEFF
 #define MCAP_ALL_MDLIDS			0xFFFF
 
+/* MDEP IDs */
+#define MCAP_MDEPID_INITIAL		0x00
+#define MCAP_MDEPID_FINAL		0x7F
+
+
 /*
  * MCAP Request Packet Format
  */
-- 
1.7.0.4

