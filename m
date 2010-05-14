Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 15/25] Implement function to send md_create_mdl_req
Date: Fri, 14 May 2010 12:19:42 +0200
Message-Id: <1273832392-18654-15-git-send-email-sancane@gmail.com>
In-Reply-To: <1273832392-18654-14-git-send-email-sancane@gmail.com>
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
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mcap/mcap.c |  177 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 177 insertions(+), 0 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index dfcce82..c7bbb94 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -34,6 +34,7 @@
 #include "mcap_lib.h"
 #include "mcap_internal.h"
 
+#define RESPONSE_TIMER	2	/* seconds */
 #define MAX_CACHED	10	/* 10 devices */
 
 #define MCAP_ERROR g_quark_from_static_string("mcap-error-quark")
@@ -49,6 +50,17 @@ struct connect_mcl {
 	gpointer		user_data;	/* Callback user data */
 };
 
+typedef union {
+	mcap_mdl_operation_cb 		op;
+	mcap_mdl_operation_conf_cb	op_conf;
+	mcap_mdl_del_cb			del;
+} mcap_cb_type;
+
+struct mcap_mdl_op_cb {
+	struct mcap_mdl		*mdl;		/* MDL for this operation */
+	mcap_cb_type		cb;		/* Operation callback */
+	gpointer		user_data;	/* Callback user data */
+};
 
 /* MCAP finite state machine functions */
 static void proc_req_connected(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t l);
@@ -61,6 +73,8 @@ static void (*proc_req[])(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len) = {
 	proc_req_active
 };
 
+static void mcap_cache_mcl(struct mcap_mcl *mcl);
+
 static void default_mdl_connected_cb(struct mcap_mdl *mdl, gpointer data)
 {
 	debug("MCAP Unmanaged mdl connection");
@@ -111,6 +125,67 @@ static void set_default_cb(struct mcap_mcl *mcl)
 	mcl->cb->mdl_reconn_req = default_mdl_reconn_req_cb;
 }
 
+static void mcap_send_std_opcode(struct mcap_mcl *mcl, uint8_t *cmd,
+						uint32_t size, GError **err)
+{
+	if (mcl->state == MCL_IDLE) {
+		g_set_error(err, MCAP_ERROR, MCAP_ERROR_FAILED,
+			"MCL is not connected");
+		return;
+	}
+
+	if (mcl->req != MCL_AVAILABLE) {
+		g_set_error(err, MCAP_ERROR, MCAP_ERROR_RESOURCE_UNAVAILABLE,
+					"Pending request");
+		return;
+	}
+
+	if (!(mcl->ctrl & MCAP_CTRL_STD_OP)) {
+		g_set_error(err, MCAP_ERROR, MCAP_ERROR_REQUEST_NOT_SUPPORTED,
+				    "Remote does not support standard opcodes");
+		return;
+	}
+
+	if (mcl->state == MCL_PENDING) {
+		g_set_error(err, MCAP_ERROR, MCAP_ERROR_INVALID_OPERATION,
+			"Not Std Op. Codes can be sent in PENDING State");
+		return;
+	}
+
+	if (mcap_send_data(g_io_channel_unix_get_fd(mcl->cc), cmd, size) < 0) {
+		g_set_error(err, MCAP_ERROR, MCAP_ERROR_FAILED,
+				    "Command can't be sent, write error");
+		return;
+	}
+
+	mcl->lcmd = cmd;
+	mcl->req = MCL_WAITING_RSP;
+}
+
+static void mcap_notify_error(struct mcap_mcl *mcl, GError *err)
+{
+	struct mcap_mdl_op_cb *con = mcl->priv_data;
+
+	if (!con || !mcl->lcmd)
+		return;
+
+	switch (mcl->lcmd[0]){
+	case MCAP_MD_CREATE_MDL_REQ:
+		con->cb.op_conf(NULL, 0, err, con->user_data);
+		break;
+	case MCAP_MD_ABORT_MDL_REQ:
+	case MCAP_MD_DELETE_MDL_REQ:
+		con->cb.del(err, con->user_data);
+		break;
+	case MCAP_MD_RECONNECT_MDL_REQ:
+		con->cb.op(NULL, err, con->user_data);
+		break;
+	}
+
+	g_free(mcl->priv_data);
+	mcl->priv_data = NULL;
+}
+
 int mcap_send_data(int sock, const uint8_t *buf, uint32_t size)
 {
 	uint32_t sent = 0;
@@ -167,6 +242,42 @@ static int send5B_cmd(struct mcap_mcl *mcl, uint8_t oc, uint8_t rc,
 	return sent;
 }
 
+static uint16_t generate_mdlid(struct mcap_mcl *mcl)
+{
+	uint16_t mdlid = MCAP_MDLID_INITIAL;
+	struct mcap_mdl *mdl;
+	GSList *l;
+
+	for (l = mcl->mdls; l; l = l->next) {
+		mdl = l->data;
+		if (mdlid < mdl->mdlid)
+			break;
+		else
+			mdlid = mdl->mdlid + 1;
+	}
+
+	if (mdlid > MCAP_MDLID_FINAL)
+		return 0;
+
+	return mdlid;
+}
+
+static uint8_t *create_mdl_req(uint16_t mdl_id, uint8_t mdep, uint8_t conf)
+{
+	uint8_t *req;
+	mcap_md_create_mdl_req *req_mdl;
+
+	req = g_malloc0(sizeof(mcap_md_create_mdl_req));
+
+	req_mdl = (mcap_md_create_mdl_req *)req;
+	req_mdl->op = MCAP_MD_CREATE_MDL_REQ;
+	req_mdl->mdl = htons(mdl_id);
+	req_mdl->mdep = mdep;
+	req_mdl->conf = conf;
+
+	return req;
+}
+
 static gint compare_mdl(gconstpointer a, gconstpointer b)
 {
 	const struct mcap_mdl *mdla = a;
@@ -180,6 +291,72 @@ static gint compare_mdl(gconstpointer a, gconstpointer b)
 		return 1;
 }
 
+static gboolean wait_response_timer(gpointer data)
+{
+	struct mcap_mcl *mcl = data;
+
+	GError *gerr = NULL;
+
+	RELEASE_TIMER(mcl);
+
+	g_set_error(&gerr, MCAP_ERROR, MCAP_ERROR_FAILED,
+					"Timeout waiting response");
+
+	mcap_notify_error(mcl, gerr);
+
+	g_error_free(gerr);
+	mcl->ms->mcl_disconnected_cb(mcl, mcl->ms->user_data);
+	mcap_cache_mcl(mcl);
+	return FALSE;
+}
+
+void mcap_req_mdl_creation(struct mcap_mcl *mcl,
+				uint8_t mdepid,
+				uint8_t conf,
+				GError **err,
+				mcap_mdl_operation_conf_cb connect_cb,
+				gpointer user_data)
+{
+	struct mcap_mdl *mdl;
+	struct mcap_mdl_op_cb *con;
+	uint8_t *cmd = NULL;
+	uint16_t id;
+
+	id = generate_mdlid(mcl);
+	if (!id) {
+		g_set_error(err, MCAP_ERROR, MCAP_ERROR_FAILED,
+					"Not more mdlids available");
+		return;
+	}
+
+	mdl = g_new0(struct mcap_mdl, 1);
+	mdl->mcl = mcl;
+	mdl->mdlid = id;
+	mdl->mdep_id = mdepid;
+	mdl->state = MDL_WAITING;
+
+	con = g_new0(struct mcap_mdl_op_cb, 1);
+	con->mdl = mdl;
+	con->cb.op_conf = connect_cb;
+	con->user_data = user_data;
+
+	cmd = create_mdl_req(id, mdepid, conf);
+	mcap_send_std_opcode(mcl, cmd, sizeof(mcap_md_create_mdl_req), err);
+	if (*err) {
+		g_free(mdl);
+		g_free(con);
+		g_free(cmd);
+		return;
+	}
+
+	mcl->state = MCL_ACTIVE;
+	mcl->priv_data = con;
+
+	mcl->mdls = g_slist_insert_sorted(mcl->mdls, mdl, compare_mdl);
+	mcl->tid = g_timeout_add_seconds(RESPONSE_TIMER, wait_response_timer,
+									mcl);
+}
+
 static void update_mcl_state(struct mcap_mcl *mcl)
 {
 	GSList *l;
-- 
1.6.3.3

