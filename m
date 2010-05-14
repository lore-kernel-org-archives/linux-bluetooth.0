Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 10/25] Process md_abort_mdl_req in PENDING state
Date: Fri, 14 May 2010 12:19:37 +0200
Message-Id: <1273832392-18654-10-git-send-email-sancane@gmail.com>
In-Reply-To: <1273832392-18654-9-git-send-email-sancane@gmail.com>
References: <1273832392-18654-1-git-send-email-sancane@gmail.com>
 <1273832392-18654-2-git-send-email-sancane@gmail.com>
 <1273832392-18654-3-git-send-email-sancane@gmail.com>
 <1273832392-18654-4-git-send-email-sancane@gmail.com>
 <1273832392-18654-5-git-send-email-sancane@gmail.com>
 <1273832392-18654-6-git-send-email-sancane@gmail.com>
 <1273832392-18654-7-git-send-email-sancane@gmail.com>
 <1273832392-18654-8-git-send-email-sancane@gmail.com>
 <1273832392-18654-9-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mcap/mcap.c |   50 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 49 insertions(+), 1 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index e4d9a1a..ac0d938 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -552,6 +552,51 @@ static void process_md_reconnect_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 	send4B_cmd(mcl, MCAP_MD_RECONNECT_MDL_RSP, MCAP_SUCCESS, mdl_id);
 }
 
+static void process_md_abort_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
+								uint32_t len)
+{
+	mcap_md_req *req;
+	GSList *l;
+	struct mcap_mdl *mdl, *del;
+	uint16_t mdl_id;
+
+	if (len != sizeof(mcap_md_req)) {
+		send4B_cmd(mcl, MCAP_MD_ABORT_MDL_RSP,
+				MCAP_INVALID_PARAM_VALUE, MCAP_MDLID_RESERVED);
+		return;
+	}
+
+	req = (mcap_md_req *)cmd;
+	mdl_id = ntohs(req->mdl);
+	mcl->state = MCL_CONNECTED;
+	for (l = mcl->mdls; l; l = l->next) {
+		mdl = l->data;
+		if ((mdl_id == mdl->mdlid) && (mdl->state == MDL_WAITING)) {
+			del = mdl;
+			if (mcl->state != MCL_CONNECTED)
+				break;
+			continue;
+		}
+		if ((mdl->state == MDL_CONNECTED) && (mcl->state != MCL_ACTIVE))
+			mcl->state = MCL_ACTIVE;
+
+		if ((del) && (mcl->state == MCL_ACTIVE))
+			break;
+	}
+
+	if (!del) {
+		send4B_cmd(mcl, MCAP_MD_ABORT_MDL_RSP, MCAP_INVALID_MDL,
+									mdl_id);
+		return;
+	}
+
+	mcl->cb->mdl_aborted(del, mcl->cb->user_data);
+
+	mcl->mdls = g_slist_remove(mcl->mdls, del);
+	g_free(del);
+	send4B_cmd(mcl, MCAP_MD_ABORT_MDL_RSP, MCAP_SUCCESS, mdl_id);
+}
+
 static void process_md_delete_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 								uint32_t len)
 {
@@ -627,7 +672,10 @@ static void proc_req_connected(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 
 static void proc_req_pending(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 {
-	/* TODO */
+	if (cmd[0] == MCAP_MD_ABORT_MDL_REQ)
+		process_md_abort_mdl_req(mcl, cmd, len);
+	else
+		error_cmd_rsp(mcl, cmd, len);
 }
 
 static void proc_req_active(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
-- 
1.6.3.3

