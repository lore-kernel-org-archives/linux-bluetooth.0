Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 06/16] Send MCAP request mcap_md_create_mdl_req
Date: Wed, 28 Jul 2010 10:00:15 +0200
Message-Id: <1280304015-9230-7-git-send-email-sancane@gmail.com>
In-Reply-To: <1280304015-9230-6-git-send-email-sancane@gmail.com>
References: <1280304015-9230-1-git-send-email-sancane@gmail.com>
 <1280304015-9230-2-git-send-email-sancane@gmail.com>
 <1280304015-9230-3-git-send-email-sancane@gmail.com>
 <1280304015-9230-4-git-send-email-sancane@gmail.com>
 <1280304015-9230-5-git-send-email-sancane@gmail.com>
 <1280304015-9230-6-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/mcap.c          |  178 ++++++++++++++++++++++++++++++++++++++++++++++++
 health/mcap.h          |   11 +++
 health/mcap_internal.h |   16 ++++
 health/mcap_lib.h      |    9 +++
 4 files changed, 214 insertions(+), 0 deletions(-)

diff --git a/health/mcap.c b/health/mcap.c
index 73562c3..7366c66 100644
--- a/health/mcap.c
+++ b/health/mcap.c
@@ -35,6 +35,7 @@
 #include "mcap_lib.h"
 #include "mcap_internal.h"
 
+#define RESPONSE_TIMER	2	/* seconds */
 #define MAX_CACHED	10	/* 10 devices */
 
 #define MCAP_ERROR g_quark_from_static_string("mcap-error-quark")
@@ -50,6 +51,18 @@ struct connect_mcl {
 	gpointer		user_data;	/* Callback user data */
 };
 
+typedef union {
+	mcap_mdl_operation_cb 		op;
+	mcap_mdl_operation_conf_cb	op_conf;
+	mcap_mdl_notify_cb		notify;
+} mcap_cb_type;
+
+struct mcap_mdl_op_cb {
+	struct mcap_mdl		*mdl;		/* MDL for this operation */
+	mcap_cb_type		cb;		/* Operation callback */
+	gpointer		user_data;	/* Callback user data */
+};
+
 /* MCAP finite state machine functions */
 static void proc_req_connected(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t l);
 static void proc_req_pending(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t l);
@@ -61,6 +74,8 @@ static void (*proc_req[])(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len) = {
 	proc_req_active
 };
 
+static void mcap_cache_mcl(struct mcap_mcl *mcl);
+
 static void default_mdl_connected_cb(struct mcap_mdl *mdl, gpointer data)
 {
 	DBG("MCAP Unmanaged mdl connection");
@@ -111,6 +126,43 @@ static void set_default_cb(struct mcap_mcl *mcl)
 	mcl->cb->mdl_reconn_req = default_mdl_reconn_req_cb;
 }
 
+static void mcap_send_std_opcode(struct mcap_mcl *mcl, void *cmd,
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
 static void mcap_notify_error(struct mcap_mcl *mcl, GError *err)
 {
 	/* TODO: implement mcap_notify_error */
@@ -155,6 +207,132 @@ static int mcap_send_cmd(struct mcap_mcl *mcl, uint8_t oc, uint8_t rc,
 	return sent;
 }
 
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
+static uint16_t generate_mdlid(struct mcap_mcl *mcl)
+{
+	uint16_t mdlid = mcl->next_mdl;
+	struct mcap_mdl *mdl;
+
+	do {
+		mdl = get_mdl(mcl, mdlid);
+		if (!mdl) {
+			mcl->next_mdl = (mdlid % MCAP_MDLID_FINAL) + 1;
+			return mdlid;
+		} else
+			mdlid = (mdlid % MCAP_MDLID_FINAL) + 1;
+	} while (mdlid != mcl->next_mdl);
+
+	/* No more mdlids availables */
+	return 0;
+}
+
+static mcap_md_create_mdl_req *create_mdl_req(uint16_t mdl_id, uint8_t mdep,
+								uint8_t conf)
+{
+	mcap_md_create_mdl_req *req_mdl;
+
+	req_mdl = g_malloc0(sizeof(mcap_md_create_mdl_req));
+
+	req_mdl->op = MCAP_MD_CREATE_MDL_REQ;
+	req_mdl->mdl = htons(mdl_id);
+	req_mdl->mdep = mdep;
+	req_mdl->conf = conf;
+
+	return req_mdl;
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
+void mcap_create_mdl(struct mcap_mcl *mcl,
+				uint8_t mdepid,
+				uint8_t conf,
+				mcap_mdl_operation_conf_cb connect_cb,
+				gpointer user_data,
+				GError **err)
+{
+	struct mcap_mdl *mdl;
+	struct mcap_mdl_op_cb *con;
+	mcap_md_create_mdl_req *cmd;
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
 static struct mcap_mcl *find_mcl(GSList *list, const bdaddr_t *addr)
 {
 	GSList *l;
diff --git a/health/mcap.h b/health/mcap.h
index 523be90..8c3679f 100644
--- a/health/mcap.h
+++ b/health/mcap.h
@@ -75,6 +75,17 @@ extern "C" {
 #define MCAP_ALL_MDLIDS			0xFFFF
 
 /*
+ * MCAP Request Packet Format
+ */
+
+typedef struct {
+	uint8_t         op;
+        uint16_t	mdl;
+	uint8_t		mdep;
+	uint8_t		conf;
+} __attribute__ ((packed)) mcap_md_create_mdl_req;
+
+/*
  * MCAP Response Packet Format
  */
 
diff --git a/health/mcap_internal.h b/health/mcap_internal.h
index cc81692..d639cdb 100644
--- a/health/mcap_internal.h
+++ b/health/mcap_internal.h
@@ -48,6 +48,13 @@ typedef enum {
 	MCL_WAITING_RSP
 } MCAPCtrl;
 
+typedef enum {
+	MDL_WAITING,
+	MDL_CONNECTED,
+	MDL_DELETING,
+	MDL_CLOSED
+} MDLState;
+
 struct mcap_mdl_cb {
 	mcap_mdl_event_cb 		mdl_connected;	/* Remote device has created a MDL */
 	mcap_mdl_event_cb 		mdl_closed;	/* Remote device has closed a MDL */
@@ -97,6 +104,15 @@ struct mcap_mcl {
 #define	MCAP_CTRL_FREE		0x10	/* MCL is marked as releasable */
 #define	MCAP_CTRL_NOCACHE	0x20	/* MCL is marked as not cacheable */
 
+struct mcap_mdl {
+	struct mcap_mcl		*mcl;		/* MCL where this MDL belongs */
+	GIOChannel		*dc;		/* MCAP Data Channel IO */
+	guint			wid;		/* MDL Watcher id */
+	uint16_t		mdlid;		/* MDL id */
+	uint8_t			mdep_id;	/* MCAP Data End Point */
+	MDLState		state;		/* MDL state */
+};
+
 int mcap_send_data(int sock, const uint8_t *buf, uint32_t size);
 
 void proc_sync_cmd(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len);
diff --git a/health/mcap_lib.h b/health/mcap_lib.h
index b4e9c16..d8fb863 100644
--- a/health/mcap_lib.h
+++ b/health/mcap_lib.h
@@ -96,6 +96,15 @@ typedef void (* mcap_mcl_connect_cb) (struct mcap_mcl *mcl, GError *err,
 
 /************ Operations ************/
 
+/* Mdl operations*/
+
+void mcap_create_mdl(struct mcap_mcl *mcl,
+				uint8_t mdepid,
+				uint8_t conf,
+				mcap_mdl_operation_conf_cb connect_cb,
+				gpointer user_data,
+				GError **err);
+
 /* Mcl operations*/
 
 void mcap_create_mcl(struct mcap_instance *ms,
-- 
1.6.3.3

