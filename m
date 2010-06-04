Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 16/26] Implement function to send md_reconnect_mdl_req
Date: Fri,  4 Jun 2010 10:27:09 +0200
Message-Id: <1275640039-7245-17-git-send-email-sancane@gmail.com>
In-Reply-To: <1275640039-7245-16-git-send-email-sancane@gmail.com>
References: <1275640039-7245-1-git-send-email-sancane@gmail.com>
 <1275640039-7245-2-git-send-email-sancane@gmail.com>
 <1275640039-7245-3-git-send-email-sancane@gmail.com>
 <1275640039-7245-4-git-send-email-sancane@gmail.com>
 <1275640039-7245-5-git-send-email-sancane@gmail.com>
 <1275640039-7245-6-git-send-email-sancane@gmail.com>
 <1275640039-7245-7-git-send-email-sancane@gmail.com>
 <1275640039-7245-8-git-send-email-sancane@gmail.com>
 <1275640039-7245-9-git-send-email-sancane@gmail.com>
 <1275640039-7245-10-git-send-email-sancane@gmail.com>
 <1275640039-7245-11-git-send-email-sancane@gmail.com>
 <1275640039-7245-12-git-send-email-sancane@gmail.com>
 <1275640039-7245-13-git-send-email-sancane@gmail.com>
 <1275640039-7245-14-git-send-email-sancane@gmail.com>
 <1275640039-7245-15-git-send-email-sancane@gmail.com>
 <1275640039-7245-16-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mcap/mcap.c |   51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 7a32e68..2feac10 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -262,6 +262,20 @@ static uint16_t generate_mdlid(struct mcap_mcl *mcl)
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
@@ -357,6 +371,43 @@ void mcap_req_mdl_creation(struct mcap_mcl *mcl,
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

