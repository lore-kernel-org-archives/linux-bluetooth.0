Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot Nemesio <sancane@gmail.com>
Subject: [PATCH 16/25] Support for sending md_reconnect_mdl_req command
Date: Mon, 10 May 2010 12:15:18 +0200
Message-Id: <1273486527-7855-16-git-send-email-sancane@gmail.com>
In-Reply-To: <1273486527-7855-15-git-send-email-sancane@gmail.com>
References: <1273486527-7855-1-git-send-email-sancane@gmail.com>
 <1273486527-7855-2-git-send-email-sancane@gmail.com>
 <1273486527-7855-3-git-send-email-sancane@gmail.com>
 <1273486527-7855-4-git-send-email-sancane@gmail.com>
 <1273486527-7855-5-git-send-email-sancane@gmail.com>
 <1273486527-7855-6-git-send-email-sancane@gmail.com>
 <1273486527-7855-7-git-send-email-sancane@gmail.com>
 <1273486527-7855-8-git-send-email-sancane@gmail.com>
 <1273486527-7855-9-git-send-email-sancane@gmail.com>
 <1273486527-7855-10-git-send-email-sancane@gmail.com>
 <1273486527-7855-11-git-send-email-sancane@gmail.com>
 <1273486527-7855-12-git-send-email-sancane@gmail.com>
 <1273486527-7855-13-git-send-email-sancane@gmail.com>
 <1273486527-7855-14-git-send-email-sancane@gmail.com>
 <1273486527-7855-15-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Santiago Carot Nemesio <sancane@gmail.com>

---
 mcap/mcap.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index beb7385..1d01937 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -213,6 +213,20 @@ static uint16_t generate_mdlid(struct mcap_mcl *mcl)
 	return mdlid;
 }
 
+static uint8_t *create_req(uint8_t op, uint16_t mdl_id)
+{
+	uint8_t *req;
+	mcap_md_req *req_cmd;
+
+	req = g_malloc0(sizeof(mcap_md_req));
+
+	req_cmd = (mcap_md_req *)req;
+	req_cmd->op = op;
+	req_cmd->mdl = htons(mdl_id);
+
+	return req;
+}
+
 static uint8_t *create_mdl_req(uint16_t mdl_id, uint8_t mdep, uint8_t conf)
 {
 	uint8_t *req;
@@ -307,6 +321,42 @@ void mcap_req_mdl_creation(struct mcap_mcl *mcl,
 	mcl->tid = g_timeout_add_seconds(RESPONSE_TIMER, wait_response_timer, mcl);
 }
 
+void mcap_req_mdl_reconnect(struct mcap_mdl *mdl,
+				GError **err,
+				mcap_mdl_operation_cb reconnect_cb,
+				gpointer user_data)
+{
+	struct mcap_mdl_op_cb *con;
+	struct mcap_mcl *mcl = mdl->mcl;
+	uint8_t *cmd;
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
+	mcl->tid = g_timeout_add_seconds(RESPONSE_TIMER, wait_response_timer, mcl);
+}
+
 static void default_mdl_connected_cb(struct mcap_mdl *mdl, gpointer data)
 {
 	debug("MCAP Unmanaged mdl connection");
-- 
1.6.3.3

