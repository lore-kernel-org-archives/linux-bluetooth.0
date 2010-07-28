Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 05/16] Prepare FSM functions for processing comands
Date: Wed, 28 Jul 2010 10:00:14 +0200
Message-Id: <1280304015-9230-6-git-send-email-sancane@gmail.com>
In-Reply-To: <1280304015-9230-5-git-send-email-sancane@gmail.com>
References: <1280304015-9230-1-git-send-email-sancane@gmail.com>
 <1280304015-9230-2-git-send-email-sancane@gmail.com>
 <1280304015-9230-3-git-send-email-sancane@gmail.com>
 <1280304015-9230-4-git-send-email-sancane@gmail.com>
 <1280304015-9230-5-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/mcap.c          |  192 +++++++++++++++++++++++++++++++++++++++++++++++-
 health/mcap.h          |   29 +++++++
 health/mcap_internal.h |    4 +
 3 files changed, 224 insertions(+), 1 deletions(-)

diff --git a/health/mcap.c b/health/mcap.c
index ba2b2ad..73562c3 100644
--- a/health/mcap.c
+++ b/health/mcap.c
@@ -35,6 +35,8 @@
 #include "mcap_lib.h"
 #include "mcap_internal.h"
 
+#define MAX_CACHED	10	/* 10 devices */
+
 #define MCAP_ERROR g_quark_from_static_string("mcap-error-quark")
 
 #define RELEASE_TIMER(__mcl) do {	\
@@ -48,6 +50,17 @@ struct connect_mcl {
 	gpointer		user_data;	/* Callback user data */
 };
 
+/* MCAP finite state machine functions */
+static void proc_req_connected(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t l);
+static void proc_req_pending(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t l);
+static void proc_req_active(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t l);
+
+static void (*proc_req[])(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len) = {
+	proc_req_connected,
+	proc_req_pending,
+	proc_req_active
+};
+
 static void default_mdl_connected_cb(struct mcap_mdl *mdl, gpointer data)
 {
 	DBG("MCAP Unmanaged mdl connection");
@@ -98,6 +111,50 @@ static void set_default_cb(struct mcap_mcl *mcl)
 	mcl->cb->mdl_reconn_req = default_mdl_reconn_req_cb;
 }
 
+static void mcap_notify_error(struct mcap_mcl *mcl, GError *err)
+{
+	/* TODO: implement mcap_notify_error */
+}
+
+int mcap_send_data(int sock, const uint8_t *buf, uint32_t size)
+{
+	uint32_t sent = 0;
+
+	while (sent < size) {
+		int n = send(sock, buf + sent, size - sent, 0);
+		if (n < 0)
+			return -1;
+		sent += n;
+	}
+	return 0;
+}
+
+static int mcap_send_cmd(struct mcap_mcl *mcl, uint8_t oc, uint8_t rc,
+					uint16_t mdl, uint8_t *data, size_t len)
+{
+	mcap_rsp *cmd;
+	uint8_t *rsp;
+	int sock, sent;
+
+	if (mcl->cc == NULL)
+		return -1;
+
+	sock = g_io_channel_unix_get_fd(mcl->cc);
+
+	rsp = g_malloc(sizeof(mcap_rsp) + len);
+	cmd = (mcap_rsp *)rsp;
+	cmd->op = oc;
+	cmd->rc = rc;
+	cmd->mdl = htons(mdl);
+
+	if (data && len > 0)
+		memcpy(rsp + sizeof(mcap_rsp), data, len);
+
+	sent = mcap_send_data(sock, rsp, sizeof(mcap_rsp) + len);
+	g_free(rsp);
+	return sent;
+}
+
 static struct mcap_mcl *find_mcl(GSList *list, const bdaddr_t *addr)
 {
 	GSList *l;
@@ -176,6 +233,46 @@ static void mcap_mcl_check_del(struct mcap_mcl *mcl)
 		mcap_mcl_unref(mcl);
 }
 
+static void mcap_cache_mcl(struct mcap_mcl *mcl)
+{
+	GSList *l;
+	struct mcap_mcl *last;
+	int len;
+
+	if (mcl->ctrl & MCAP_CTRL_CACHED)
+		return;
+
+	mcl->ms->mcls = g_slist_remove(mcl->ms->mcls, mcl);
+
+	if ((mcl->ctrl & MCAP_CTRL_NOCACHE) || (mcl->ref < 2)) {
+		mcap_mcl_unref(mcl);
+		return;
+	}
+
+	DBG("Caching MCL");
+
+	len = g_slist_length(mcl->ms->cached);
+	if (len == MAX_CACHED) {
+		/* Remove the latest cached mcl */
+		l = g_slist_last(mcl->ms->cached);
+		last = l->data;
+		mcl->ms->cached = g_slist_remove(mcl->ms->cached, last);
+		last->ctrl &= ~MCAP_CTRL_CACHED;
+		if (last->ctrl & MCAP_CTRL_CONN) {
+			/* If connection process is not success this MCL will be
+			 * freed next time that close_mcl is invoked */
+			last->ctrl |= MCAP_CTRL_FREE;
+		} else {
+			last->ms->mcl_uncached_cb(last, last->ms->user_data);
+			mcap_mcl_unref(last);
+		}
+	}
+
+	mcl->ms->cached = g_slist_prepend(mcl->ms->cached, mcl);
+	mcl->ctrl |= MCAP_CTRL_CACHED;
+	mcap_mcl_shutdown(mcl);
+}
+
 static void mcap_uncache_mcl(struct mcap_mcl *mcl)
 {
 	if (!(mcl->ctrl & MCAP_CTRL_CACHED))
@@ -318,10 +415,103 @@ void mcap_mcl_get_addr(struct mcap_mcl *mcl, bdaddr_t *addr)
 	bacpy(addr, &mcl->addr);
 }
 
+/* Function used to process commands depending of MCL state */
+static void proc_req_connected(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
+{
+	/* TODO: Implement proc_req_connected */
+}
+
+static void proc_req_pending(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
+{
+	/* TODO: Implement proc_req_pending */
+}
+
+static void proc_req_active(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
+{
+	/* TODO: Implement proc_req_active */
+}
+
+static void proc_response(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
+{
+	/* TODO: Implement proc_response */
+}
+
+static void proc_cmd(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
+{
+	GError *gerr = NULL;
+
+	if (cmd[0] > MCAP_MD_SYNC_INFO_IND ||
+					(cmd[0] > MCAP_MD_DELETE_MDL_RSP &&
+					cmd[0] < MCAP_MD_SYNC_CAP_REQ)) {
+		error("Unknown cmd received (op code = %d)", cmd[0]);
+		mcap_send_cmd(mcl, MCAP_ERROR_RSP, MCAP_INVALID_OP_CODE,
+						MCAP_MDLID_RESERVED, NULL, 0);
+		return;
+	}
+
+	if (cmd[0] >= MCAP_MD_SYNC_CAP_REQ &&
+					cmd[0] <= MCAP_MD_SYNC_INFO_IND) {
+		/* TODO: proc_sync_cmd(mcl, cmd, len);*/
+		return;
+	}
+
+	if (!(mcl->ctrl & MCAP_CTRL_STD_OP)) {
+		/* In case the remote device doesn't work correctly */
+		error("Remote device does not support opcodes, cmd ignored");
+		return;
+	}
+
+	if (mcl->req == MCL_WAITING_RSP) {
+		if (cmd[0] & 0x01) {
+			/* Request arrived when a response is expected */
+			if (mcl->role == MCL_INITIATOR)
+				/* ignore */
+				return;
+			/* Initiator will ignore our last request */
+			proc_req[mcl->state](mcl, cmd, len);
+			RELEASE_TIMER(mcl);
+			mcl->req = MCL_AVAILABLE;
+			g_set_error(&gerr, MCAP_ERROR, MCAP_ERROR_REQ_IGNORED,
+				"Initiator sent a request with more priority");
+			mcap_notify_error(mcl, gerr);
+			return;
+		}
+		proc_response(mcl, cmd, len);
+	} else if (cmd[0] & 0x01)
+		proc_req[mcl->state](mcl, cmd, len);
+}
+
 static gboolean mcl_control_cb(GIOChannel *chan, GIOCondition cond,
 								gpointer data)
 {
-	/* TODO: Create mcl_control_cb */
+	GError *gerr = NULL;
+
+	struct mcap_mcl *mcl = data;
+	int sk, len;
+	uint8_t buf[MCAP_CC_MTU];
+
+	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
+		goto fail;
+
+	sk = g_io_channel_unix_get_fd(chan);
+	len = recv(sk, buf, sizeof(buf), 0);
+	if (len < 0)
+		goto fail;
+
+	proc_cmd(mcl, buf, (uint32_t)len);
+	return TRUE;
+fail:
+	if (mcl->state != MCL_IDLE) {
+		if (mcl->req == MCL_WAITING_RSP) {
+			/* notify error in pending callback */
+			g_set_error(&gerr, MCAP_ERROR, MCAP_ERROR_MCL_CLOSED,
+								"MCL closed");
+			mcap_notify_error(mcl, gerr);
+			g_error_free(gerr);
+		}
+		mcl->ms->mcl_disconnected_cb(mcl, mcl->ms->user_data);
+	}
+	mcap_cache_mcl(mcl);
 	return FALSE;
 }
 
diff --git a/health/mcap.h b/health/mcap.h
index a45cc8a..523be90 100644
--- a/health/mcap.h
+++ b/health/mcap.h
@@ -35,6 +35,25 @@ extern "C" {
 #define MCAP_CC_MTU	48
 #define MCAP_DC_MTU	L2CAP_DEFAULT_MTU
 
+
+/* MCAP Standard Op Codes */
+#define MCAP_ERROR_RSP			0x00
+#define MCAP_MD_CREATE_MDL_REQ		0x01
+#define MCAP_MD_CREATE_MDL_RSP		0x02
+#define MCAP_MD_RECONNECT_MDL_REQ	0x03
+#define MCAP_MD_RECONNECT_MDL_RSP	0x04
+#define MCAP_MD_ABORT_MDL_REQ		0x05
+#define MCAP_MD_ABORT_MDL_RSP		0x06
+#define MCAP_MD_DELETE_MDL_REQ		0x07
+#define MCAP_MD_DELETE_MDL_RSP		0x08
+
+/* MCAP Clock Sync Op Codes */
+#define MCAP_MD_SYNC_CAP_REQ		0x11
+#define MCAP_MD_SYNC_CAP_RSP		0x12
+#define MCAP_MD_SYNC_SET_REQ		0x13
+#define MCAP_MD_SYNC_SET_RSP            0x14
+#define MCAP_MD_SYNC_INFO_IND		0x15
+
 /* MCAP Response codes */
 #define MCAP_SUCCESS			0x00
 #define MCAP_INVALID_OP_CODE		0x01
@@ -55,6 +74,16 @@ extern "C" {
 #define MCAP_MDLID_FINAL		0xFEFF
 #define MCAP_ALL_MDLIDS			0xFFFF
 
+/*
+ * MCAP Response Packet Format
+ */
+
+typedef struct {
+	uint8_t         op;
+	uint8_t         rc;
+	uint16_t        mdl;
+} __attribute__ ((packed)) mcap_rsp;
+
 
 #ifdef __cplusplus
 }
diff --git a/health/mcap_internal.h b/health/mcap_internal.h
index aab9e06..cc81692 100644
--- a/health/mcap_internal.h
+++ b/health/mcap_internal.h
@@ -97,6 +97,10 @@ struct mcap_mcl {
 #define	MCAP_CTRL_FREE		0x10	/* MCL is marked as releasable */
 #define	MCAP_CTRL_NOCACHE	0x20	/* MCL is marked as not cacheable */
 
+int mcap_send_data(int sock, const uint8_t *buf, uint32_t size);
+
+void proc_sync_cmd(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len);
+
 #ifdef __cplusplus
 }
 #endif
-- 
1.6.3.3

