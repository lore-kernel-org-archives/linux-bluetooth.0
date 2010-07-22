Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 56/60] Use a generic function to send commands with variable parameters
Date: Thu, 22 Jul 2010 10:58:13 +0200
Message-Id: <1279789097-2420-8-git-send-email-sancane@gmail.com>
In-Reply-To: <1279789097-2420-7-git-send-email-sancane@gmail.com>
References: <1279789001-4587-30-git-send-email-santoscadenas@gmail.com>
 <1279789097-2420-1-git-send-email-sancane@gmail.com>
 <1279789097-2420-2-git-send-email-sancane@gmail.com>
 <1279789097-2420-3-git-send-email-sancane@gmail.com>
 <1279789097-2420-4-git-send-email-sancane@gmail.com>
 <1279789097-2420-5-git-send-email-sancane@gmail.com>
 <1279789097-2420-6-git-send-email-sancane@gmail.com>
 <1279789097-2420-7-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Future commands added to MCAP specification may use a variable
parameters greater than one Byte. This patch sets the fixed
part of a mcap response and append at the end of the command
the variable parameter depending of length provided.
---
 mcap/mcap.c          |  159 +++++++++++++++++++++++--------------------------
 mcap/mcap.h          |   14 +----
 mcap/mcap_internal.h |    1 +
 mcap/mcap_sync.c     |   23 -------
 4 files changed, 79 insertions(+), 118 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index a91f4b1..869b6e7 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -36,7 +36,6 @@
 
 #define RESPONSE_TIMER	2	/* seconds */
 #define MAX_CACHED	10	/* 10 devices */
-#define MIN_RSP_LEN	4	/* 4 Bytes */
 
 #define MCAP_ERROR g_quark_from_static_string("mcap-error-quark")
 
@@ -307,46 +306,28 @@ int mcap_send_data(int sock, const uint8_t *buf, uint32_t size)
 	return 0;
 }
 
-static int send4B_cmd(struct mcap_mcl *mcl, uint8_t oc, uint8_t rc,
-								uint16_t mdl)
+static int mcap_send_cmd(struct mcap_mcl *mcl, uint8_t oc, uint8_t rc, uint16_t mdl,
+						uint8_t *data, size_t len)
 {
+	mcap_rsp *cmd;
 	uint8_t *rsp;
-	mcap4B_rsp *rsp_err;
-	int sent = -1;
+	int sock, sent;
 
+	if (mcl->cc == NULL)
+		return -1;
 
-	rsp = g_malloc0(sizeof(mcap4B_rsp));
-
-	rsp_err = (mcap4B_rsp *)rsp;
-	rsp_err->op = oc;
-	rsp_err->rc = rc;
-	rsp_err->mdl = htons (mdl);
-
-	if (mcl->cc)
-		sent = mcap_send_data(g_io_channel_unix_get_fd(mcl->cc), rsp,
-							sizeof(mcap4B_rsp));
-	g_free(rsp);
-	return sent;
-}
-
-static int send5B_cmd(struct mcap_mcl *mcl, uint8_t oc, uint8_t rc,
-						uint16_t mdl, uint8_t param)
-{
-	uint8_t *rsp;
-	mcap5B_rsp *suc;
-	int sent = -1;
+	sock = g_io_channel_unix_get_fd(mcl->cc);
 
-	rsp = g_malloc0(sizeof(mcap5B_rsp));
+	rsp = g_malloc(sizeof(mcap_rsp) + len);
+	cmd = (mcap_rsp *)rsp;
+	cmd->op = oc;
+	cmd->rc = rc;
+	cmd->mdl = htons(mdl);
 
-	suc = (mcap5B_rsp *)rsp;
-	suc->op = oc;
-	suc->rc = rc;
-	suc->mdl = htons(mdl);
-	suc->param = param;
+	if (data && (len > 0))
+		memcpy(rsp + sizeof(mcap_rsp), data, len);
 
-	if (mcl->cc)
-		sent = mcap_send_data(g_io_channel_unix_get_fd(mcl->cc), rsp,
-							sizeof(mcap5B_rsp));
+	sent = mcap_send_data(sock, rsp, sizeof(mcap_rsp) + len);
 	g_free(rsp);
 	return sent;
 }
@@ -371,7 +352,6 @@ static uint16_t generate_mdlid(struct mcap_mcl *mcl)
 	struct mcap_mdl *mdl;
 
 	do {
-		DBG("Testing %d", mdlid);
 		mdl = get_mdl(mcl, mdlid);
 		if (!mdl) {
 			mcl->next_mdl = (mdlid % MCAP_MDLID_FINAL) + 1;
@@ -957,8 +937,10 @@ static void process_md_create_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 	uint8_t rsp;
 
 	if (len != sizeof(mcap_md_create_mdl_req)) {
-		send4B_cmd(mcl, MCAP_MD_CREATE_MDL_RSP,
-				MCAP_INVALID_PARAM_VALUE, MCAP_MDLID_RESERVED);
+		mcap_send_cmd(mcl, MCAP_MD_CREATE_MDL_RSP,
+						MCAP_INVALID_PARAM_VALUE,
+						MCAP_MDLID_RESERVED,
+						NULL, 0);
 		return;
 	}
 
@@ -966,15 +948,15 @@ static void process_md_create_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 
 	mdl_id = ntohs(req->mdl);
 	if ((mdl_id < MCAP_MDLID_INITIAL) || (mdl_id > MCAP_MDLID_FINAL)) {
-		send4B_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, MCAP_INVALID_MDL,
-									mdl_id);
+		mcap_send_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, MCAP_INVALID_MDL,
+							mdl_id, NULL, 0);
 		return;
 	}
 
 	mdep_id = req->mdep;
 	if (mdep_id > MCAP_MDEPID_FINAL) {
-		send4B_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, MCAP_INVALID_MDEP,
-									mdl_id);
+		mcap_send_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, MCAP_INVALID_MDEP,
+							mdl_id, NULL, 0);
 		return;
 	}
 
@@ -982,7 +964,8 @@ static void process_md_create_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 	if (mdl && (mdl->state == MDL_WAITING || mdl->state == MDL_DELETING )) {
 		/* Creation request arrives for a MDL that is being managed
 		* at current moment */
-		send4B_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, MCAP_MDL_BUSY, mdl_id);
+		mcap_send_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, MCAP_MDL_BUSY,
+							mdl_id, NULL, 0);
 		return;
 	}
 
@@ -999,12 +982,13 @@ static void process_md_create_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 		/* Remote device set default configuration but upper profile */
 		/* has changed it. Protocol Error: force closing the MCL by */
 		/* remote device using UNSPECIFIED_ERROR response */
-		send4B_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, MCAP_UNSPECIFIED_ERROR,
-									mdl_id);
+		mcap_send_cmd(mcl, MCAP_MD_CREATE_MDL_RSP,
+				MCAP_UNSPECIFIED_ERROR, mdl_id, NULL, 0);
 		return;
 	}
 	if (rsp != MCAP_SUCCESS) {
-		send4B_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, rsp, mdl_id);
+		mcap_send_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, rsp, mdl_id,
+								NULL, 0);
 		return;
 	}
 
@@ -1023,7 +1007,8 @@ static void process_md_create_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 	mdl->state = MDL_WAITING;
 
 	mcl->state = MCL_PENDING;
-	send5B_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, MCAP_SUCCESS, mdl_id, conf);
+	mcap_send_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, MCAP_SUCCESS, mdl_id,
+								&conf, 1);
 }
 
 static void process_md_reconnect_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
@@ -1035,8 +1020,10 @@ static void process_md_reconnect_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 	uint8_t rsp;
 
 	if (len != sizeof(mcap_md_req)) {
-		send4B_cmd(mcl, MCAP_MD_RECONNECT_MDL_RSP,
-				MCAP_INVALID_PARAM_VALUE, MCAP_MDLID_RESERVED);
+		mcap_send_cmd(mcl, MCAP_MD_RECONNECT_MDL_RSP,
+						MCAP_INVALID_PARAM_VALUE,
+						MCAP_MDLID_RESERVED,
+						NULL, 0);
 		return;
 	}
 
@@ -1045,14 +1032,14 @@ static void process_md_reconnect_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 
 	mdl = get_mdl(mcl, mdl_id);
 	if (!mdl) {
-		send4B_cmd(mcl, MCAP_MD_RECONNECT_MDL_RSP,
-						MCAP_INVALID_MDL, mdl_id);
+		mcap_send_cmd(mcl, MCAP_MD_RECONNECT_MDL_RSP, MCAP_INVALID_MDL,
+							mdl_id, NULL, 0);
 		return;
 	} else if (mdl->state == MDL_WAITING || mdl->state == MDL_DELETING ) {
 		/* Creation request arrives for a MDL that is being managed
 		* at current moment */
-		send4B_cmd(mcl, MCAP_MD_RECONNECT_MDL_RSP, MCAP_MDL_BUSY,
-									mdl_id);
+		mcap_send_cmd(mcl, MCAP_MD_RECONNECT_MDL_RSP, MCAP_MDL_BUSY,
+							mdl_id, NULL, 0);
 		return;
 	}
 
@@ -1062,7 +1049,8 @@ static void process_md_reconnect_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 		return;
 
 	if (rsp != MCAP_SUCCESS) {
-		send4B_cmd(mcl, MCAP_MD_RECONNECT_MDL_RSP, rsp, mdl_id);
+		mcap_send_cmd(mcl, MCAP_MD_RECONNECT_MDL_RSP, rsp, mdl_id,
+								NULL, 0);
 		return;
 	}
 
@@ -1071,7 +1059,8 @@ static void process_md_reconnect_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 
 	mdl->state = MDL_WAITING;
 	mcl->state = MCL_PENDING;
-	send4B_cmd(mcl, MCAP_MD_RECONNECT_MDL_RSP, MCAP_SUCCESS, mdl_id);
+	mcap_send_cmd(mcl, MCAP_MD_RECONNECT_MDL_RSP, MCAP_SUCCESS, mdl_id,
+								NULL, 0);
 }
 
 static void process_md_abort_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
@@ -1083,8 +1072,8 @@ static void process_md_abort_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 	uint16_t mdl_id;
 
 	if (len != sizeof(mcap_md_req)) {
-		send4B_cmd(mcl, MCAP_MD_ABORT_MDL_RSP,
-				MCAP_INVALID_PARAM_VALUE, MCAP_MDLID_RESERVED);
+		mcap_send_cmd(mcl, MCAP_MD_ABORT_MDL_RSP,
+			MCAP_INVALID_PARAM_VALUE, MCAP_MDLID_RESERVED, NULL, 0);
 		return;
 	}
 
@@ -1107,14 +1096,15 @@ static void process_md_abort_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 	}
 
 	if (!abrt) {
-		send4B_cmd(mcl, MCAP_MD_ABORT_MDL_RSP, MCAP_INVALID_MDL,
-									mdl_id);
+		mcap_send_cmd(mcl, MCAP_MD_ABORT_MDL_RSP, MCAP_INVALID_MDL,
+							mdl_id, NULL, 0);
 		return;
 	}
 
 	mcl->cb->mdl_aborted(abrt, mcl->cb->user_data);
 	abrt->state = MDL_CLOSED;
-	send4B_cmd(mcl, MCAP_MD_ABORT_MDL_RSP, MCAP_SUCCESS, mdl_id);
+	mcap_send_cmd(mcl, MCAP_MD_ABORT_MDL_RSP, MCAP_SUCCESS, mdl_id,
+								NULL, 0);
 }
 
 static void process_md_delete_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
@@ -1127,8 +1117,8 @@ static void process_md_delete_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 	GSList *l;
 
 	if (len != sizeof(mcap_md_req)) {
-		send4B_cmd(mcl, MCAP_MD_ABORT_MDL_RSP,
-				MCAP_INVALID_PARAM_VALUE, MCAP_MDLID_RESERVED);
+		mcap_send_cmd(mcl, MCAP_MD_ABORT_MDL_RSP,
+			MCAP_INVALID_PARAM_VALUE, MCAP_MDLID_RESERVED, NULL, 0);
 		return;
 	}
 
@@ -1146,8 +1136,8 @@ static void process_md_delete_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 	}
 
 	if ((mdlid < MCAP_MDLID_INITIAL) || (mdlid > MCAP_MDLID_FINAL)) {
-		send4B_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, MCAP_INVALID_MDL,
-									mdlid);
+		mcap_send_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, MCAP_INVALID_MDL,
+								mdlid, NULL, 0);
 		return;
 	}
 
@@ -1160,8 +1150,8 @@ static void process_md_delete_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 	}
 
 	if (!mdl || (mdl->state == MDL_WAITING)) {
-		send4B_cmd(mcl, MCAP_MD_DELETE_MDL_RSP, MCAP_INVALID_MDL,
-									mdlid);
+		mcap_send_cmd(mcl, MCAP_MD_DELETE_MDL_RSP, MCAP_INVALID_MDL,
+								mdlid, NULL, 0);
 		return;
 	}
 	mcl->mdls = g_slist_remove(mcl->mdls, mdl);
@@ -1170,7 +1160,8 @@ static void process_md_delete_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 	mcap_delete_mdl(mdl, &notify);
 
 resp:
-	send4B_cmd(mcl, MCAP_MD_DELETE_MDL_RSP, MCAP_SUCCESS, mdlid);
+	mcap_send_cmd(mcl, MCAP_MD_DELETE_MDL_RSP, MCAP_SUCCESS, mdlid,
+								NULL, 0);
 }
 
 static void invalid_req_state(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
@@ -1183,7 +1174,7 @@ static void invalid_req_state(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 	 * response if it is possible */
 	mdlr = len < sizeof(mcap_md_req) ? MCAP_MDLID_RESERVED :
 					ntohs(((mcap_md_req *)cmd)->mdl);
-	send4B_cmd(mcl, cmd[0]+1, MCAP_INVALID_OPERATION, mdlr);
+	mcap_send_cmd(mcl, cmd[0]+1, MCAP_INVALID_OPERATION, mdlr, NULL, 0);
 }
 
 /* Function used to process commands depending of MCL state */
@@ -1237,7 +1228,7 @@ static gboolean check_err_rsp(struct mcap_mcl *mcl, uint8_t *cmd,
 	gint err = MCAP_ERROR_FAILED;
 	gboolean close = FALSE;
 	uint16_t rmdl, smdl;
-	mcap4B_rsp *rsp;
+	mcap_rsp *rsp;
 	char *msg;
 
 	if (cmd[0] == MCAP_ERROR_RSP) {
@@ -1247,7 +1238,7 @@ static gboolean check_err_rsp(struct mcap_mcl *mcl, uint8_t *cmd,
 	}
 
 	/* Check if the response matches with the last request */
-	if ((rlen < MIN_RSP_LEN) || ((mcl->lcmd[0] + 1) != cmd[0])) {
+	if ((rlen < sizeof(mcap_rsp)) || ((mcl->lcmd[0] + 1) != cmd[0])) {
 		msg = "Protocol error";
 		close = TRUE;
 		goto fail;
@@ -1259,7 +1250,7 @@ static gboolean check_err_rsp(struct mcap_mcl *mcl, uint8_t *cmd,
 		goto fail;
 	}
 
-	rsp = (mcap4B_rsp *)cmd;
+	rsp = (mcap_rsp *)cmd;
 	smdl = ntohs(cmdlast->mdl);
 	rmdl = ntohs(rsp->mdl);
 	if (rmdl != smdl) {
@@ -1304,12 +1295,12 @@ static gboolean process_md_create_mdl_rsp(struct mcap_mcl *mcl,
 	uint8_t conf = cmdlast->conf;
 	gboolean close = FALSE;
 	GError *gerr = NULL;
-	mcap5B_rsp *rsp;
+	uint8_t *param;
 
 	g_free(mcl->priv_data);
 	mcl->priv_data = NULL;
 
-	close = check_err_rsp(mcl, cmd, len, sizeof(mcap4B_rsp), &gerr);
+	close = check_err_rsp(mcl, cmd, len, sizeof(mcap_rsp) + 1, &gerr);
 	g_free(mcl->lcmd);
 	mcl->lcmd = NULL;
 	mcl->req = MCL_AVAILABLE;
@@ -1317,23 +1308,23 @@ static gboolean process_md_create_mdl_rsp(struct mcap_mcl *mcl,
 	if (gerr)
 		goto fail;
 
-	if (len < sizeof(mcap5B_rsp)) {
+	if (len < sizeof(mcap_rsp)) {
 		g_set_error(&gerr, MCAP_ERROR, MCAP_ERROR_FAILED,
 							"Protocol error");
 		close = TRUE;
 		goto fail;
 	}
 
-	rsp = (mcap5B_rsp *)cmd;
+	param = cmd + sizeof(mcap_rsp);
 	/* Check if preferences changed */
-	if ((conf != 0x00) && (rsp->param != conf)) {
+	if ((conf != 0x00) && (*param != conf)) {
 		g_set_error(&gerr, MCAP_ERROR, MCAP_ERROR_FAILED,
 						"Configuration changed");
 		close = TRUE;
 		goto fail;
 	}
 
-	connect_cb(mdl, rsp->param, gerr, user_data);
+	connect_cb(mdl, *param, gerr, user_data);
 	return close;
 fail:
 	connect_cb(NULL, 0, gerr, user_data);
@@ -1351,14 +1342,14 @@ static gboolean process_md_reconnect_mdl_rsp(struct mcap_mcl *mcl,
 	mcap_mdl_operation_cb reconn_cb = reconn->cb.op;
 	gpointer user_data = reconn->user_data;
 	struct mcap_mdl *mdl = reconn->mdl;
-	mcap4B_rsp *rsp = (mcap4B_rsp *)cmd;
+	mcap_rsp *rsp = (mcap_rsp *)cmd;
 	GError *gerr = NULL;
 	gboolean close = FALSE;
 
 	g_free(mcl->priv_data);
 	mcl->priv_data = NULL;
 
-	close = check_err_rsp(mcl, cmd, len, sizeof(mcap4B_rsp), &gerr);
+	close = check_err_rsp(mcl, cmd, len, sizeof(mcap_rsp), &gerr);
 
 	g_free(mcl->lcmd);
 	mcl->lcmd = NULL;
@@ -1390,14 +1381,14 @@ static gboolean process_md_abort_mdl_rsp(struct mcap_mcl *mcl,
 	mcap_mdl_notify_cb abrt_cb = abrt->cb.notify;
 	gpointer user_data = abrt->user_data;
 	struct mcap_mdl *mdl = abrt->mdl;
-	mcap4B_rsp *rsp = (mcap4B_rsp *)cmd;
+	mcap_rsp *rsp = (mcap_rsp *)cmd;
 	GError *gerr = NULL;
 	gboolean close = FALSE;
 
 	g_free(mcl->priv_data);
 	mcl->priv_data = NULL;
 
-	close = check_err_rsp(mcl, cmd, len, sizeof(mcap4B_rsp), &gerr);
+	close = check_err_rsp(mcl, cmd, len, sizeof(mcap_rsp), &gerr);
 
 	g_free(mcl->lcmd);
 	mcl->lcmd = NULL;
@@ -1406,7 +1397,7 @@ static gboolean process_md_abort_mdl_rsp(struct mcap_mcl *mcl,
 	abrt_cb(gerr, user_data);
 	shutdown_mdl(mdl);
 
-	if ((len >= MIN_RSP_LEN) && (rsp->rc == MCAP_INVALID_MDL)) {
+	if ((len >= sizeof(mcap_rsp)) && (rsp->rc == MCAP_INVALID_MDL)) {
 		mcl->mdls = g_slist_remove(mcl->mdls, mdl);
 		g_free(mdl);
 	}
@@ -1447,7 +1438,7 @@ static gboolean process_md_delete_mdl_rsp(struct mcap_mcl *mcl, uint8_t *cmd,
 	g_free(mcl->priv_data);
 	mcl->priv_data = NULL;
 
-	close = check_err_rsp(mcl, cmd, len, sizeof(mcap4B_rsp), &gerr);
+	close = check_err_rsp(mcl, cmd, len, sizeof(mcap_rsp), &gerr);
 
 	g_free(mcl->lcmd);
 	mcl->lcmd = NULL;
@@ -1517,8 +1508,8 @@ static void proc_cmd(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 					(cmd[0] > MCAP_MD_DELETE_MDL_RSP &&
 					cmd[0] < MCAP_MD_SYNC_CAP_REQ)) {
 		error("Unknown cmd received (op code = %d)", cmd[0]);
-		send4B_cmd(mcl, MCAP_ERROR_RSP, MCAP_INVALID_OP_CODE,
-							MCAP_MDLID_RESERVED);
+		mcap_send_cmd(mcl, MCAP_ERROR_RSP, MCAP_INVALID_OP_CODE,
+						MCAP_MDLID_RESERVED, NULL, 0);
 		return;
 	}
 
diff --git a/mcap/mcap.h b/mcap/mcap.h
index 0299f42..9b95473 100644
--- a/mcap/mcap.h
+++ b/mcap/mcap.h
@@ -106,18 +106,10 @@ typedef struct {
  */
 
 typedef struct {
-        uint8_t         op;
-        uint8_t         rc;
+	uint8_t         op;
+	uint8_t         rc;
 	uint16_t        mdl;
-} __attribute__ ((packed)) mcap4B_rsp;
-
-typedef struct {
-        uint8_t         op;
-        uint8_t         rc;
-        uint16_t        mdl;
-        uint8_t         param;
-} __attribute__ ((packed)) mcap5B_rsp;
-
+} __attribute__ ((packed)) mcap_rsp;
 
 /*
  * MCAP Clock Synchronization Protocol
diff --git a/mcap/mcap_internal.h b/mcap/mcap_internal.h
index 9dacc12..7f16ab7 100644
--- a/mcap/mcap_internal.h
+++ b/mcap/mcap_internal.h
@@ -114,6 +114,7 @@ struct mcap_mdl {
 };
 
 int mcap_send_data(int sock, const uint8_t *buf, uint32_t size);
+
 void proc_sync_cmd(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len);
 
 #endif /* __MCAP_INTERNAL_H */
diff --git a/mcap/mcap_sync.c b/mcap/mcap_sync.c
index 76f1377..569a40a 100644
--- a/mcap/mcap_sync.c
+++ b/mcap/mcap_sync.c
@@ -33,27 +33,6 @@
 #include "mcap_lib.h"
 #include "mcap_internal.h"
 
-static int send_unsupported_req(struct mcap_mcl *mcl, uint8_t oc)
-{
-	uint8_t *rsp;
-	mcap4B_rsp *rsp_err;
-	int sent;
-
-
-	rsp = g_malloc0(sizeof(mcap4B_rsp));
-
-	rsp_err = (mcap4B_rsp *)rsp;
-	rsp_err->op = oc;
-	rsp_err->rc = MCAP_REQUEST_NOT_SUPPORTED;
-	rsp_err->mdl = htons (MCAP_MDLID_RESERVED);
-
-	sent = mcap_send_data(g_io_channel_unix_get_fd(mcl->cc),
-					rsp,
-					sizeof(mcap4B_rsp));
-	g_free(rsp);
-	return sent;
-}
-
 void proc_sync_cmd(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 {
 	switch (cmd[0]) {
@@ -61,7 +40,6 @@ void proc_sync_cmd(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 		DBG("TODO: received MCAP_MD_SYNC_CAP_REQ: %d",
 							MCAP_MD_SYNC_CAP_REQ);
 		/* Not implemented yet. Reply with unsupported request */
-		send_unsupported_req(mcl, cmd[0]);
 		break;
 	case MCAP_MD_SYNC_CAP_RSP:
 		DBG("TODO: received MCAP_MD_SYNC_CAP_RSP: %d",
@@ -71,7 +49,6 @@ void proc_sync_cmd(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 		DBG("TODO: received MCAP_MD_SYNC_SET_REQ: %d",
 							MCAP_MD_SYNC_SET_REQ);
 		/* Not implemented yet. Reply with unsupported request */
-		send_unsupported_req(mcl, cmd[0]);
 		break;
 	case MCAP_MD_SYNC_SET_RSP:
 		DBG("TODO: received MCAP_MD_SYNC_SET_RSP: %d",
-- 
1.6.3.3

