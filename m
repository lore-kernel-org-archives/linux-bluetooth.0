Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 08/26] Process md_reconnect_mdl_req in CONNECTED state
Date: Fri,  4 Jun 2010 10:27:01 +0200
Message-Id: <1275640039-7245-9-git-send-email-sancane@gmail.com>
In-Reply-To: <1275640039-7245-8-git-send-email-sancane@gmail.com>
References: <1275640039-7245-1-git-send-email-sancane@gmail.com>
 <1275640039-7245-2-git-send-email-sancane@gmail.com>
 <1275640039-7245-3-git-send-email-sancane@gmail.com>
 <1275640039-7245-4-git-send-email-sancane@gmail.com>
 <1275640039-7245-5-git-send-email-sancane@gmail.com>
 <1275640039-7245-6-git-send-email-sancane@gmail.com>
 <1275640039-7245-7-git-send-email-sancane@gmail.com>
 <1275640039-7245-8-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mcap/mcap.c |   44 +++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 43 insertions(+), 1 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index e6c088c..684863b 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -479,6 +479,48 @@ static void process_md_create_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 	send5B_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, MCAP_SUCCESS, mdl_id, conf);
 }
 
+static void process_md_reconnect_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
+								uint32_t len)
+{
+	mcap_md_req *req;
+	struct mcap_mdl *mdl;
+	uint16_t mdl_id;
+	uint8_t rsp;
+
+	if (len != sizeof(mcap_md_req)) {
+		send4B_cmd(mcl, MCAP_MD_RECONNECT_MDL_RSP,
+				MCAP_INVALID_PARAM_VALUE, MCAP_MDLID_RESERVED);
+		return;
+	}
+
+	req = (mcap_md_req *)cmd;
+	mdl_id = ntohs(req->mdl);
+
+	mdl = get_mdl(mcl, mdl_id);
+	if (!mdl) {
+		send4B_cmd(mcl, MCAP_MD_RECONNECT_MDL_RSP,
+						MCAP_INVALID_MDL, mdl_id);
+		return;
+	}
+
+	/* Callback to upper layer */
+	rsp = mcl->cb->mdl_reconn_req(mdl, mcl->cb->user_data);
+	if (mcl->state == MCL_IDLE)
+		return;
+
+	if (rsp != MCAP_SUCCESS) {
+		send4B_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, rsp, mdl_id);
+		return;
+	}
+
+	if (mdl->state == MDL_CONNECTED)
+		shutdown_mdl(mdl);
+
+	mdl->state = MDL_WAITING;
+	mcl->state = MCL_PENDING;
+	send4B_cmd(mcl, MCAP_MD_RECONNECT_MDL_RSP, MCAP_SUCCESS, mdl_id);
+}
+
 /* Function used to process commands depending of MCL state */
 static void proc_req_connected(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 {
@@ -487,7 +529,7 @@ static void proc_req_connected(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 		process_md_create_mdl_req(mcl, cmd, len);
 		break;
 	case MCAP_MD_RECONNECT_MDL_REQ:
-		/*process_md_reconnect_mdl_req(mcl, cmd, len);*/
+		process_md_reconnect_mdl_req(mcl, cmd, len);
 		break;
 	case MCAP_MD_DELETE_MDL_REQ:
 		/*process_md_delete_mdl_req(mcl, cmd, len);*/
-- 
1.6.3.3

