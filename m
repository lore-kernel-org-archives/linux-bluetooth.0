Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 16/60] Implement function to send md_reconnect_mdl_req
Date: Thu, 22 Jul 2010 10:52:11 +0200
Message-Id: <1279788733-2324-17-git-send-email-sancane@gmail.com>
In-Reply-To: <1279788733-2324-16-git-send-email-sancane@gmail.com>
References: <1279788733-2324-1-git-send-email-sancane@gmail.com>
 <1279788733-2324-2-git-send-email-sancane@gmail.com>
 <1279788733-2324-3-git-send-email-sancane@gmail.com>
 <1279788733-2324-4-git-send-email-sancane@gmail.com>
 <1279788733-2324-5-git-send-email-sancane@gmail.com>
 <1279788733-2324-6-git-send-email-sancane@gmail.com>
 <1279788733-2324-7-git-send-email-sancane@gmail.com>
 <1279788733-2324-8-git-send-email-sancane@gmail.com>
 <1279788733-2324-9-git-send-email-sancane@gmail.com>
 <1279788733-2324-10-git-send-email-sancane@gmail.com>
 <1279788733-2324-11-git-send-email-sancane@gmail.com>
 <1279788733-2324-12-git-send-email-sancane@gmail.com>
 <1279788733-2324-13-git-send-email-sancane@gmail.com>
 <1279788733-2324-14-git-send-email-sancane@gmail.com>
 <1279788733-2324-15-git-send-email-sancane@gmail.com>
 <1279788733-2324-16-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mcap/mcap.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index dc55cda..a0f00af 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -261,6 +261,20 @@ static uint16_t generate_mdlid(struct mcap_mcl *mcl)
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
@@ -356,6 +370,43 @@ void mcap_req_mdl_creation(struct mcap_mcl *mcl,
 									mcl);
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
+	mcl->tid = g_timeout_add_seconds(RESPONSE_TIMER, wait_response_timer,
+									mcl);
+}
+
 static void update_mcl_state(struct mcap_mcl *mcl)
 {
 	GSList *l;
-- 
1.6.3.3

