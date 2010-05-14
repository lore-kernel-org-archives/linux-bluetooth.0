Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 17/25] Implement function to send md_delete_mdl_req
Date: Fri, 14 May 2010 12:19:44 +0200
Message-Id: <1273832392-18654-17-git-send-email-sancane@gmail.com>
In-Reply-To: <1273832392-18654-16-git-send-email-sancane@gmail.com>
References: <1273832392-18654-1-git-send-email-sancane@gmail.com>
 <1273832392-18654-2-git-send-email-sancane@gmail.com>
 <1273832392-18654-3-git-send-email-sancane@gmail.com>
 <1273832392-18654-4-git-send-email-sancane@gmail.com>
 <1273832392-18654-5-git-send-email-sancane@gmail.com>
 <1273832392-18654-6-git-send-email-sancane@gmail.com>
 <1273832392-18654-7-git-send-email-sancane@gmail.com>
 <1273832392-18654-8-git-send-email-sancane@gmail.com>
 <1273832392-18654-9-git-send-email-sancane@gmail.com>
 <1273832392-18654-10-git-send-email-sancane@gmail.com>
 <1273832392-18654-11-git-send-email-sancane@gmail.com>
 <1273832392-18654-12-git-send-email-sancane@gmail.com>
 <1273832392-18654-13-git-send-email-sancane@gmail.com>
 <1273832392-18654-14-git-send-email-sancane@gmail.com>
 <1273832392-18654-15-git-send-email-sancane@gmail.com>
 <1273832392-18654-16-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mcap/mcap.c |  112 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 112 insertions(+), 0 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index b4b8b09..1fd8e43 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -125,6 +125,38 @@ static void set_default_cb(struct mcap_mcl *mcl)
 	mcl->cb->mdl_reconn_req = default_mdl_reconn_req_cb;
 }
 
+static char *error2str(uint8_t rc)
+{
+	switch (rc) {
+	case MCAP_SUCCESS:
+		return "Success";
+	case MCAP_INVALID_OP_CODE:
+		return "Invalid Op Code";
+	case MCAP_INVALID_PARAM_VALUE:
+		return "Invalid Parameter Value";
+	case MCAP_INVALID_MDEP:
+		return "Invalid MDEP";
+	case MCAP_MDEP_BUSY:
+		return "MDEP Busy";
+	case MCAP_INVALID_MDL:
+		return "Invalid MDL";
+	case MCAP_MDL_BUSY:
+		return "MDL Busy";
+	case MCAP_INVALID_OPERATION:
+		return "Invalid Operation";
+	case MCAP_RESOURCE_UNAVAILABLE:
+		return "Resource Unavailable";
+	case MCAP_UNSPECIFIED_ERROR:
+		return "Unspecified Error";
+	case MCAP_REQUEST_NOT_SUPPORTED:
+		return "Request Not Supported";
+	case MCAP_CONFIGURATION_REJECTED:
+		return "Configuration Rejected";
+	default:
+		return "Unknown Response Code";
+	}
+}
+
 static void mcap_send_std_opcode(struct mcap_mcl *mcl, uint8_t *cmd,
 						uint32_t size, GError **err)
 {
@@ -408,6 +440,86 @@ void mcap_req_mdl_reconnect(struct mcap_mdl *mdl,
 									mcl);
 }
 
+static void send_delete_req(GError **err, struct mcap_mcl *mcl,
+				struct mcap_mdl_op_cb *con, uint16_t mdlid)
+{
+	uint8_t *cmd;
+
+	cmd = create_req(MCAP_MD_DELETE_MDL_REQ, mdlid);
+	mcap_send_std_opcode(mcl, cmd, sizeof(mcap_md_req), err);
+	if (*err) {
+		g_free(cmd);
+		return;
+	}
+
+	mcl->priv_data = con;
+
+	mcl->tid = g_timeout_add_seconds(RESPONSE_TIMER, wait_response_timer,
+									mcl);
+}
+
+void mcap_req_mdl_delete_all(struct mcap_mcl *mcl, GError **err,
+			mcap_mdl_del_cb delete_cb, gpointer user_data)
+{
+	GSList *l;
+	struct mcap_mdl *mdl;
+	struct mcap_mdl_op_cb *con;
+
+	debug("MCL in state: %d", mcl->state);
+	if (!mcl->mdls) {
+		g_set_error(err, MCAP_ERROR, MCAP_ERROR_FAILED,
+				"There are not MDLs created");
+		return;
+	}
+
+	for (l = mcl->mdls; l; l = l->next) {
+		mdl = l->data;
+		if (mdl->state != MDL_WAITING)
+			mdl->state = MDL_DELETING;
+	}
+
+	con = g_new0(struct mcap_mdl_op_cb, 1);
+	con->mdl = NULL;
+	con->cb.del = delete_cb;
+	con->user_data = user_data;
+
+	send_delete_req(err, mcl, con, MCAP_ALL_MDLIDS);
+	if (*err)
+		g_free(con);
+}
+
+void mcap_req_mdl_deletion(struct mcap_mdl *mdl, GError **err,
+			mcap_mdl_del_cb delete_cb, gpointer user_data)
+{
+	struct mcap_mcl *mcl= mdl->mcl;
+	struct mcap_mdl_op_cb *con;
+	GSList *l;
+
+	l = g_slist_find(mcl->mdls, mdl);
+
+	if (!l) {
+		g_set_error(err, MCAP_ERROR, MCAP_ERROR_INVALID_MDL,
+					"%s" , error2str(MCAP_INVALID_MDEP));
+		return;
+	}
+
+	if (mdl->state == MDL_WAITING) {
+		g_set_error(err, MCAP_ERROR, MCAP_ERROR_FAILED,
+							"Mdl is not created");
+		return;
+	}
+	mdl->state = MDL_DELETING;
+
+	con = g_new0(struct mcap_mdl_op_cb, 1);
+	con->mdl = mdl;
+	con->cb.del = delete_cb;
+	con->user_data = user_data;
+
+	send_delete_req(err, mcl, con, mdl->mdlid);
+	if (*err)
+		g_free(con);
+}
+
 static void update_mcl_state(struct mcap_mcl *mcl)
 {
 	GSList *l;
-- 
1.6.3.3

