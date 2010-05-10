Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot Nemesio <sancane@gmail.com>
Subject: [PATCH 18/25] Support for sending md_abort_mdl_req command
Date: Mon, 10 May 2010 12:15:20 +0200
Message-Id: <1273486527-7855-18-git-send-email-sancane@gmail.com>
In-Reply-To: <1273486527-7855-17-git-send-email-sancane@gmail.com>
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
 <1273486527-7855-16-git-send-email-sancane@gmail.com>
 <1273486527-7855-17-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Santiago Carot Nemesio <sancane@gmail.com>

---
 mcap/mcap.c |   31 +++++++++++++++++++++++++++++++
 1 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 75d3d58..34243df 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -518,6 +518,37 @@ void mcap_req_mdl_deletion(struct mcap_mdl *mdl, GError **err,
 		g_free(con);
 }
 
+void mcap_mdl_abort(struct mcap_mdl *mdl, GError **err,
+			mcap_mdl_del_cb abort_cb, gpointer user_data)
+{
+	struct mcap_mdl_op_cb *con;
+	struct mcap_mcl *mcl = mdl->mcl;
+	uint8_t *cmd;
+
+	if (mdl->state != MDL_WAITING) {
+		g_set_error(err, MCAP_ERROR, MCAP_ERROR_FAILED,
+							"Mdl in invalid state");
+		return;
+	}
+
+	con = g_new0(struct mcap_mdl_op_cb, 1);
+	cmd = create_req(MCAP_MD_ABORT_MDL_REQ, mdl->mdlid);
+	mcap_send_std_opcode(mcl, cmd, sizeof(mcap_md_req), err);
+	if (*err) {
+		g_free(con);
+		g_free(cmd);
+		return;
+	}
+
+	con->mdl = mdl;
+	con->cb.del = abort_cb;
+	con->user_data = user_data;
+
+	mcl->priv_data = con;
+
+	mcl->tid = g_timeout_add_seconds(RESPONSE_TIMER, wait_response_timer, mcl);
+}
+
 static void update_mcl_state(struct mcap_mcl *mcl)
 {
 	GSList *l;
-- 
1.6.3.3

