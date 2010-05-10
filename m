Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot Nemesio <sancane@gmail.com>
Subject: [PATCH 12/25] Process md_delete_mdl_req in connected state
Date: Mon, 10 May 2010 12:15:14 +0200
Message-Id: <1273486527-7855-12-git-send-email-sancane@gmail.com>
In-Reply-To: <1273486527-7855-11-git-send-email-sancane@gmail.com>
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
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Santiago Carot Nemesio <sancane@gmail.com>

---
 mcap/mcap.c |   86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 85 insertions(+), 1 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 4fce82b..7aeefb2 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -179,6 +179,26 @@ static void set_default_cb(struct mcap_mcl *mcl)
 	mcl->cb->mdl_reconn_req = default_mdl_reconn_req_cb;
 }
 
+static void update_mcl_state(struct mcap_mcl *mcl)
+{
+	GSList *l;
+	struct mcap_mdl *mdl;
+
+	if (mcl->state == MCL_PENDING)
+		return;
+
+	for (l = mcl->mdls; l; l = l->next) {
+		mdl = l->data;
+
+		if (mdl->state == MDL_CONNECTED) {
+			mcl->state = MCL_ACTIVE;
+			return;
+		}
+	}
+
+	mcl->state = MCL_CONNECTED;
+}
+
 static struct mcap_mcl *find_mcl(GSList *list, const bdaddr_t *addr)
 {
 	GSList *l;
@@ -493,6 +513,17 @@ static struct mcap_mdl *get_mdl(struct mcap_mcl *mcl, uint16_t mdlid)
 	return NULL;
 }
 
+static void mcap_delete_mdl(gpointer elem, gpointer user_data)
+{
+	struct mcap_mdl *mdl = elem;
+	gboolean notify = *(gboolean *)user_data;
+
+	shutdown_mdl(mdl);
+	if (notify)
+		mdl->mcl->cb->mdl_deleted(mdl, mdl->mcl->cb->user_data);
+	g_free(mdl);
+}
+
 static void process_md_create_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 {
 	mcap_md_create_mdl_req *req;
@@ -604,6 +635,59 @@ static void process_md_reconnect_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 	send4B_cmd(mcl, MCAP_MD_RECONNECT_MDL_RSP, MCAP_SUCCESS, mdl_id);
 }
 
+static void process_md_delete_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
+								uint32_t len)
+{
+	mcap_md_req *req;
+	struct mcap_mdl *mdl, *aux;
+	uint16_t mdlid;
+	gboolean notify;
+	GSList *l;
+
+	if (len != sizeof(mcap_md_req)) {
+		send4B_cmd(mcl, MCAP_MD_ABORT_MDL_RSP,
+				MCAP_INVALID_PARAM_VALUE, MCAP_MDLID_RESERVED);
+		return;
+	}
+
+	req = (mcap_md_req *)cmd;
+	mdlid = ntohs(req->mdl);
+	if (mdlid == MCAP_ALL_MDLIDS) {
+		notify = FALSE;
+		g_slist_foreach(mcl->mdls, mcap_delete_mdl, &notify);
+		g_slist_free(mcl->mdls);
+		mcl->mdls = NULL;
+		mcl->state = MCL_CONNECTED;
+		/* NULL mdl means ALL_MDLS */
+		mcl->cb->mdl_deleted(NULL, mcl->cb->user_data);
+		goto resp;
+	}
+
+	if ((mdlid < MCAP_MDLID_INITIAL) || (mdlid > MCAP_MDLID_FINAL)) {
+		send4B_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, MCAP_INVALID_MDL, mdlid);
+		return;
+	}
+
+	for (l=mcl->mdls, mdl = NULL; l; l = l->next) {
+		aux = l->data;
+		if (aux->mdlid == mdlid) {
+			mdl = aux;
+			break;
+		}
+	}
+
+	if (!mdl || (mdl->state == MDL_WAITING)) {
+		send4B_cmd(mcl, MCAP_MD_DELETE_MDL_RSP, MCAP_INVALID_MDL, mdlid);
+		return;
+	}
+	mcl->mdls = g_slist_remove(mcl->mdls, mdl);
+	update_mcl_state(mcl);
+	notify = TRUE;
+	mcap_delete_mdl(mdl, &notify);
+resp:
+	send4B_cmd(mcl, MCAP_MD_DELETE_MDL_RSP, MCAP_SUCCESS, mdlid);
+}
+
 /* Function used to process commands depending of MCL state */
 static void proc_req_connected(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 {
@@ -615,7 +699,7 @@ static void proc_req_connected(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 		process_md_reconnect_mdl_req(mcl, cmd, len);
 		break;
 	case MCAP_MD_DELETE_MDL_REQ:
-		/*process_md_delete_mdl_req(mcl, cmd, len);*/
+		process_md_delete_mdl_req(mcl, cmd, len);
 		break;
 	default:
 		error_cmd_rsp(mcl, cmd, len);
-- 
1.6.3.3

