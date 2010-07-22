Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 53/60] Send error response when an unknown command is received.
Date: Thu, 22 Jul 2010 10:58:10 +0200
Message-Id: <1279789097-2420-5-git-send-email-sancane@gmail.com>
In-Reply-To: <1279789097-2420-4-git-send-email-sancane@gmail.com>
References: <1279789001-4587-30-git-send-email-santoscadenas@gmail.com>
 <1279789097-2420-1-git-send-email-sancane@gmail.com>
 <1279789097-2420-2-git-send-email-sancane@gmail.com>
 <1279789097-2420-3-git-send-email-sancane@gmail.com>
 <1279789097-2420-4-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If an invalid Op Code is received (i.e. neither a Standard Op Code
nor a Clock Synchronization Protocol Op Code), we will send an reply
using an "Invalid Op Code" and the Op Code field to ERROR_RSP
---
 mcap/mcap.c |   49 +++++++++++++++++++++++++------------------------
 1 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 30e0827..788b565 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -934,27 +934,6 @@ bdaddr_t mcap_mcl_get_addr(struct mcap_mcl *mcl)
 	return mcl->addr;
 }
 
-static void error_cmd_rsp(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
-{
-	uint16_t mdlr;
-
-	if (cmd[0] <= MCAP_MD_DELETE_MDL_RSP) {
-		/* Standard Op Code request is invalid in current state */
-		error("Invalid cmd received (op code = %d) in state %d",
-							cmd[0],	mcl->state);
-		/* Get previously mdlid sent to generate an appropriate
-		 * response if it is possible */
-		mdlr = len < sizeof(mcap_md_req) ? MCAP_MDLID_RESERVED :
-					ntohs(((mcap_md_req *)cmd)->mdl);
-		send4B_cmd(mcl, cmd[0]+1, MCAP_INVALID_OPERATION, mdlr);
-	} else {
-		error("Unknown cmd request received (op code = %d) in state %d",
-							cmd[0], mcl->state);
-		send4B_cmd(mcl, MCAP_ERROR_RSP, MCAP_INVALID_OP_CODE,
-							MCAP_MDLID_RESERVED);
-	}
-}
-
 static void mcap_delete_mdl(gpointer elem, gpointer user_data)
 {
 	struct mcap_mdl *mdl = elem;
@@ -1194,6 +1173,19 @@ resp:
 	send4B_cmd(mcl, MCAP_MD_DELETE_MDL_RSP, MCAP_SUCCESS, mdlid);
 }
 
+static void invalid_req_state(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
+{
+	uint16_t mdlr;
+
+	error("Invalid cmd received (op code = %d) in state %d", cmd[0],
+								mcl->state);
+	/* Get previously mdlid sent to generate an appropriate
+	 * response if it is possible */
+	mdlr = len < sizeof(mcap_md_req) ? MCAP_MDLID_RESERVED :
+					ntohs(((mcap_md_req *)cmd)->mdl);
+	send4B_cmd(mcl, cmd[0]+1, MCAP_INVALID_OPERATION, mdlr);
+}
+
 /* Function used to process commands depending of MCL state */
 static void proc_req_connected(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 {
@@ -1208,7 +1200,7 @@ static void proc_req_connected(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 		process_md_delete_mdl_req(mcl, cmd, len);
 		break;
 	default:
-		error_cmd_rsp(mcl, cmd, len);
+		invalid_req_state(mcl, cmd, len);
 	}
 }
 
@@ -1217,7 +1209,7 @@ static void proc_req_pending(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 	if (cmd[0] == MCAP_MD_ABORT_MDL_REQ)
 		process_md_abort_mdl_req(mcl, cmd, len);
 	else
-		error_cmd_rsp(mcl, cmd, len);
+		invalid_req_state(mcl, cmd, len);
 }
 
 static void proc_req_active(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
@@ -1233,7 +1225,7 @@ static void proc_req_active(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 		process_md_delete_mdl_req(mcl, cmd, len);
 		break;
 	default:
-		error_cmd_rsp(mcl, cmd, len);
+		invalid_req_state(mcl, cmd, len);
 	}
 }
 
@@ -1521,6 +1513,15 @@ static void proc_cmd(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 {
 	GError *gerr = NULL;
 
+	if (cmd[0] > MCAP_MD_SYNC_INFO_IND ||
+					(cmd[0] > MCAP_MD_DELETE_MDL_RSP &&
+					cmd[0] < MCAP_MD_SYNC_CAP_REQ)) {
+		error("Unknown cmd received (op code = %d)", cmd[0]);
+		send4B_cmd(mcl, MCAP_ERROR_RSP, MCAP_INVALID_OP_CODE,
+							MCAP_MDLID_RESERVED);
+		return;
+	}
+
 	if ((cmd[0] >= MCAP_MD_SYNC_CAP_REQ) &&
 					(cmd[0] <= MCAP_MD_SYNC_INFO_IND)) {
 		proc_sync_cmd(mcl, cmd, len);
-- 
1.6.3.3

