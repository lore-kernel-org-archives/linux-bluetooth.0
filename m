Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot Nemesio <sancane@gmail.com>
Subject: [PATCH 11/25] Process md_reconnect_mdl_req in connected state
Date: Mon, 10 May 2010 12:15:13 +0200
Message-Id: <1273486527-7855-11-git-send-email-sancane@gmail.com>
In-Reply-To: <1273486527-7855-10-git-send-email-sancane@gmail.com>
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
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Santiago Carot Nemesio <sancane@gmail.com>

---
 mcap/mcap.c |   43 ++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 42 insertions(+), 1 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 1bc3ed5..4fce82b 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -562,6 +562,47 @@ static void process_md_create_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd, uint32
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
 
 /* Function used to process commands depending of MCL state */
 static void proc_req_connected(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
@@ -571,7 +612,7 @@ static void proc_req_connected(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
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

