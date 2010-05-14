Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 09/25] Process md_delete_mdl_req in CONNECTED state
Date: Fri, 14 May 2010 12:19:36 +0200
Message-Id: <1273832392-18654-9-git-send-email-sancane@gmail.com>
In-Reply-To: <1273832392-18654-8-git-send-email-sancane@gmail.com>
References: <1273832392-18654-1-git-send-email-sancane@gmail.com>
 <1273832392-18654-2-git-send-email-sancane@gmail.com>
 <1273832392-18654-3-git-send-email-sancane@gmail.com>
 <1273832392-18654-4-git-send-email-sancane@gmail.com>
 <1273832392-18654-5-git-send-email-sancane@gmail.com>
 <1273832392-18654-6-git-send-email-sancane@gmail.com>
 <1273832392-18654-7-git-send-email-sancane@gmail.com>
 <1273832392-18654-8-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mcap/mcap.c |   88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 87 insertions(+), 1 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index a8bdc9e..e4d9a1a 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -174,6 +174,26 @@ static gint compare_mdl(gconstpointer a, gconstpointer b)
 		return 1;
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
@@ -407,6 +427,17 @@ static struct mcap_mdl *get_mdl(struct mcap_mcl *mcl, uint16_t mdlid)
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
 static void process_md_create_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 								uint32_t len)
 {
@@ -521,6 +552,61 @@ static void process_md_reconnect_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
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
+		send4B_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, MCAP_INVALID_MDL,
+									mdlid);
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
+		send4B_cmd(mcl, MCAP_MD_DELETE_MDL_RSP, MCAP_INVALID_MDL,
+									mdlid);
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
@@ -532,7 +618,7 @@ static void proc_req_connected(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
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

