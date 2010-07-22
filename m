Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 59/60] Remove "req" word from MCAP API
Date: Thu, 22 Jul 2010 10:58:16 +0200
Message-Id: <1279789097-2420-11-git-send-email-sancane@gmail.com>
In-Reply-To: <1279789097-2420-10-git-send-email-sancane@gmail.com>
References: <1279789001-4587-30-git-send-email-santoscadenas@gmail.com>
 <1279789097-2420-1-git-send-email-sancane@gmail.com>
 <1279789097-2420-2-git-send-email-sancane@gmail.com>
 <1279789097-2420-3-git-send-email-sancane@gmail.com>
 <1279789097-2420-4-git-send-email-sancane@gmail.com>
 <1279789097-2420-5-git-send-email-sancane@gmail.com>
 <1279789097-2420-6-git-send-email-sancane@gmail.com>
 <1279789097-2420-7-git-send-email-sancane@gmail.com>
 <1279789097-2420-8-git-send-email-sancane@gmail.com>
 <1279789097-2420-9-git-send-email-sancane@gmail.com>
 <1279789097-2420-10-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mcap/mcap.c     |   24 ++++++++++++------------
 mcap/mcap_lib.h |   10 +++++-----
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index b3017fb..5369328 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -307,8 +307,8 @@ int mcap_send_data(int sock, const uint8_t *buf, uint32_t size)
 	return 0;
 }
 
-static int mcap_send_cmd(struct mcap_mcl *mcl, uint8_t oc, uint8_t rc, uint16_t mdl,
-						uint8_t *data, size_t len)
+static int mcap_send_cmd(struct mcap_mcl *mcl, uint8_t oc, uint8_t rc,
+					uint16_t mdl, uint8_t *data, size_t len)
 {
 	mcap_rsp *cmd;
 	uint8_t *rsp;
@@ -427,7 +427,7 @@ static gboolean wait_response_timer(gpointer data)
 	return FALSE;
 }
 
-void mcap_req_mdl_creation(struct mcap_mcl *mcl,
+void mcap_create_mdl(struct mcap_mcl *mcl,
 				uint8_t mdepid,
 				uint8_t conf,
 				mcap_mdl_operation_conf_cb connect_cb,
@@ -474,7 +474,7 @@ void mcap_req_mdl_creation(struct mcap_mcl *mcl,
 									mcl);
 }
 
-void mcap_req_mdl_reconnect(struct mcap_mdl *mdl,
+void mcap_reconnect_mdl(struct mcap_mdl *mdl,
 				mcap_mdl_operation_cb reconnect_cb,
 				gpointer user_data,
 				GError **err)
@@ -529,7 +529,7 @@ static void send_delete_req(GError **err, struct mcap_mcl *mcl,
 									mcl);
 }
 
-void mcap_req_mdl_delete_all(struct mcap_mcl *mcl, mcap_mdl_notify_cb delete_cb,
+void mcap_delete_all_mdls(struct mcap_mcl *mcl, mcap_mdl_notify_cb delete_cb,
 					gpointer user_data, GError **err)
 {
 	GSList *l;
@@ -559,7 +559,7 @@ void mcap_req_mdl_delete_all(struct mcap_mcl *mcl, mcap_mdl_notify_cb delete_cb,
 		g_free(con);
 }
 
-void mcap_req_mdl_deletion(struct mcap_mdl *mdl, mcap_mdl_notify_cb delete_cb,
+void mcap_delete_mdl(struct mcap_mdl *mdl, mcap_mdl_notify_cb delete_cb,
 					gpointer user_data, GError **err)
 {
 	struct mcap_mcl *mcl= mdl->mcl;
@@ -915,7 +915,7 @@ void mcap_mcl_get_addr(struct mcap_mcl *mcl, bdaddr_t *addr)
 	bacpy(addr, &mcl->addr);
 }
 
-static void mcap_delete_mdl(gpointer elem, gpointer user_data)
+static void mcap_del_mdl(gpointer elem, gpointer user_data)
 {
 	struct mcap_mdl *mdl = elem;
 	gboolean notify = *(gboolean *)user_data;
@@ -1127,7 +1127,7 @@ static void process_md_delete_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 	mdlid = ntohs(req->mdl);
 	if (mdlid == MCAP_ALL_MDLIDS) {
 		notify = FALSE;
-		g_slist_foreach(mcl->mdls, mcap_delete_mdl, &notify);
+		g_slist_foreach(mcl->mdls, mcap_del_mdl, &notify);
 		g_slist_free(mcl->mdls);
 		mcl->mdls = NULL;
 		mcl->state = MCL_CONNECTED;
@@ -1158,7 +1158,7 @@ static void process_md_delete_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 	mcl->mdls = g_slist_remove(mcl->mdls, mdl);
 	update_mcl_state(mcl);
 	notify = TRUE;
-	mcap_delete_mdl(mdl, &notify);
+	mcap_del_mdl(mdl, &notify);
 
 resp:
 	mcap_send_cmd(mcl, MCAP_MD_DELETE_MDL_RSP, MCAP_SUCCESS, mdlid,
@@ -1456,7 +1456,7 @@ static gboolean process_md_delete_mdl_rsp(struct mcap_mcl *mcl, uint8_t *cmd,
 	}
 
 	if (mdlid == MCAP_ALL_MDLIDS) {
-		g_slist_foreach(mcl->mdls, mcap_delete_mdl, &notify);
+		g_slist_foreach(mcl->mdls, mcap_del_mdl, &notify);
 		g_slist_free(mcl->mdls);
 		mcl->mdls = NULL;
 		mcl->state = MCL_CONNECTED;
@@ -1465,7 +1465,7 @@ static gboolean process_md_delete_mdl_rsp(struct mcap_mcl *mcl, uint8_t *cmd,
 
 	mcl->mdls = g_slist_remove(mcl->mdls, mdl);
 	update_mcl_state(mcl);
-	mcap_delete_mdl(mdl, &notify);
+	mcap_del_mdl(mdl, &notify);
 end:
 	deleted_cb(gerr, user_data);
 	return close;
@@ -1594,7 +1594,7 @@ static void mcap_connect_mdl_cb(GIOChannel *chan, GError *conn_err,
 	cb(mdl, conn_err, user_data);
 }
 
-void mcap_mdl_connect(struct mcap_mdl *mdl, BtIOType BtType, uint16_t dcpsm,
+void mcap_connect_mdl(struct mcap_mdl *mdl, BtIOType BtType, uint16_t dcpsm,
 	mcap_mdl_operation_cb connect_cb, gpointer user_data, GError **err)
 {
 	struct mcap_mdl_op_cb *con;
diff --git a/mcap/mcap_lib.h b/mcap/mcap_lib.h
index 7b8fcfd..fa62cbe 100644
--- a/mcap/mcap_lib.h
+++ b/mcap/mcap_lib.h
@@ -98,25 +98,25 @@ typedef void (* mcap_mcl_connect_cb) (struct mcap_mcl *mcl, GError *err,
 
 /* Mdl operations*/
 
-void mcap_req_mdl_creation(struct mcap_mcl *mcl,
+void mcap_create_mdl(struct mcap_mcl *mcl,
 				uint8_t mdepid,
 				uint8_t conf,
 				mcap_mdl_operation_conf_cb connect_cb,
 				gpointer user_data,
 				GError **err);
-void mcap_req_mdl_reconnect(struct mcap_mdl *mdl,
+void mcap_reconnect_mdl(struct mcap_mdl *mdl,
 				mcap_mdl_operation_cb reconnect_cb,
 				gpointer user_data,
 				GError **err);
-void mcap_req_mdl_delete_all(struct mcap_mcl *mcl,
+void mcap_delete_all_mdls(struct mcap_mcl *mcl,
 				mcap_mdl_notify_cb delete_cb,
 				gpointer user_data,
 				GError **err);
-void mcap_req_mdl_deletion(struct mcap_mdl *mdl,
+void mcap_delete_mdl(struct mcap_mdl *mdl,
 				mcap_mdl_notify_cb delete_cb,
 				gpointer user_data,
 				GError **err);
-void mcap_mdl_connect(struct mcap_mdl *mdl,
+void mcap_connect_mdl(struct mcap_mdl *mdl,
 				BtIOType BtType,
 				uint16_t dcpsm,
 				mcap_mdl_operation_cb connect_cb,
-- 
1.6.3.3

