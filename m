Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 18/60] Implement function to send md_abort_mdl_req
Date: Thu, 22 Jul 2010 10:52:13 +0200
Message-Id: <1279788733-2324-19-git-send-email-sancane@gmail.com>
In-Reply-To: <1279788733-2324-18-git-send-email-sancane@gmail.com>
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
 <1279788733-2324-17-git-send-email-sancane@gmail.com>
 <1279788733-2324-18-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mcap/mcap.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 5419d54..6f6e08a 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -519,6 +519,38 @@ void mcap_req_mdl_deletion(struct mcap_mdl *mdl, GError **err,
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
@@ -554,6 +586,22 @@ static struct mcap_mcl *find_mcl(GSList *list, const bdaddr_t *addr)
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

