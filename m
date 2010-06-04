Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 18/26] Implement function to send md_abort_mdl_req
Date: Fri,  4 Jun 2010 10:27:11 +0200
Message-Id: <1275640039-7245-19-git-send-email-sancane@gmail.com>
In-Reply-To: <1275640039-7245-18-git-send-email-sancane@gmail.com>
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
 <1275640039-7245-17-git-send-email-sancane@gmail.com>
 <1275640039-7245-18-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mcap/mcap.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 2c03e83..78b6af8 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -520,6 +520,38 @@ void mcap_req_mdl_deletion(struct mcap_mdl *mdl, GError **err,
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
+	mcl->tid = g_timeout_add_seconds(RESPONSE_TIMER, wait_response_timer,
+									mcl);
+}
+
 static void update_mcl_state(struct mcap_mcl *mcl)
 {
 	GSList *l;
@@ -555,6 +587,22 @@ static struct mcap_mcl *find_mcl(GSList *list, const bdaddr_t *addr)
 	return NULL;
 }
 
+int mcap_mdl_get_fd(struct mcap_mdl *mdl)
+{
+	if ((!mdl) || (mdl->state != MDL_CONNECTED))
+		return -1;
+
+	return g_io_channel_unix_get_fd(mdl->dc);
+}
+
+uint16_t mcap_mdl_get_mdlid(struct mcap_mdl *mdl)
+{
+	if (!mdl)
+		return MCAP_MDLID_RESERVED;
+
+	return mdl->mdlid;
+}
+
 static void shutdown_mdl(struct mcap_mdl *mdl)
 {
 	mdl->state = MDL_CLOSED;
-- 
1.6.3.3

