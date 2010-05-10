Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot Nemesio <sancane@gmail.com>
Subject: [PATCH 05/25] Initial work to process standard op codes
Date: Mon, 10 May 2010 12:15:07 +0200
Message-Id: <1273486527-7855-5-git-send-email-sancane@gmail.com>
In-Reply-To: <1273486527-7855-4-git-send-email-sancane@gmail.com>
References: <1273486527-7855-1-git-send-email-sancane@gmail.com>
 <1273486527-7855-2-git-send-email-sancane@gmail.com>
 <1273486527-7855-3-git-send-email-sancane@gmail.com>
 <1273486527-7855-4-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Santiago Carot Nemesio <sancane@gmail.com>

---
 mcap/mcap.c |  141 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 140 insertions(+), 1 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 5b0257c..b15728c 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -41,6 +41,52 @@
 	__mcl->tid = 0;			\
 } while(0)
 
+/* MCAP finite state machine functions */
+static void proc_req_connected(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len);
+static void proc_req_pending(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len);
+static void proc_req_active(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len);
+
+static void (*proc_req[])(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len) = {
+	proc_req_connected,
+	proc_req_pending,
+	proc_req_active
+};
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
+static int send4B_cmd(struct mcap_mcl *mcl, uint8_t oc, uint8_t rc,
+								uint16_t mdl)
+{
+	uint8_t *rsp;
+	mcap4B_rsp *rsp_err;
+	int sent;
+
+
+	rsp = g_malloc0(sizeof(mcap4B_rsp));
+
+	rsp_err = (mcap4B_rsp *)rsp;
+	rsp_err->op = oc;
+	rsp_err->rc = rc;
+	rsp_err->mdl = htons (mdl);
+
+	sent = mcap_send_data(g_io_channel_unix_get_fd(mcl->cc),
+					rsp,
+					sizeof(mcap4B_rsp));
+	g_free(rsp);
+	return sent;
+}
+
 static void default_mdl_connected_cb(struct mcap_mdl *mdl, gpointer data)
 {
 	debug("MCAP Unmanaged mdl connection");
@@ -229,9 +275,102 @@ void mcap_mcl_unref(struct mcap_mcl *mcl)
 	mcap_mcl_release(mcl);
 }
 
+/* Function used to process commands depending of MCL state */
+
+static void proc_req_connected(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
+{
+	/* TODO: Proccessing commands in CONNECTED state */
+}
+
+static void proc_req_pending(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
+{
+	/* TODO: Proccessing commands in PENDING state */
+}
+
+static void proc_req_active(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
+{
+	/* TODO: Proccessing commands in ACTIVE state */
+}
+
+static void proc_response(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
+{
+	/* TODO: Process response */
+}
+
+static void rsend_req(struct mcap_mcl *mcl)
+{
+	uint8_t *cmd = mcl->lcmd;
+	int len;
+
+	if(!cmd)
+		return;
+
+	switch (cmd[0]) {
+	case MCAP_MD_RECONNECT_MDL_REQ:
+	case MCAP_MD_ABORT_MDL_REQ:
+	case MCAP_MD_DELETE_MDL_REQ:
+		len = 3;
+		break;
+	case MCAP_MD_CREATE_MDL_REQ:
+		len = 5;
+		break;
+	default:
+		return;
+	}
+
+	mcap_send_data(g_io_channel_unix_get_fd(mcl->cc), cmd, len);
+}
+
+static void proc_cmd(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
+{
+	if ((cmd[0] >= MCAP_MD_SYNC_CAP_REQ) && (cmd[0] <= MCAP_MD_SYNC_INFO_IND)) {
+		send4B_cmd(mcl, cmd[0], MCAP_REQUEST_NOT_SUPPORTED, MCAP_MDLID_RESERVED);
+		return;
+	}
+
+	if (!(mcl->ctrl & MCAP_CTRL_STD_OP)) {
+		/* In case the remote device doesn't work corerctly */
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
+			proc_req[mcl->state](mcl, cmd, len);
+			/* Initiator will ignore our last request => re-send */
+			rsend_req(mcl);
+			return;
+		}
+		proc_response(mcl, cmd, len);
+	} else if (cmd[0] & 0x01)
+		proc_req[mcl->state](mcl, cmd, len);
+}
+
 static gboolean mcl_control_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
 {
-	/* Process events received over the control channel*/
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
+	if (mcl->state != MCL_IDLE)
+		mcl->ms->mcl_disconnected_cb(mcl, mcl->ms->user_data);
+	mcap_cache_mcl(mcl);
 	return FALSE;
 }
 
-- 
1.6.3.3

