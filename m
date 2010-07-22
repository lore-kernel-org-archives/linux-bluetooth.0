Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 51/60] Change name for callback used to report status of delete and abort operations
Date: Thu, 22 Jul 2010 10:58:08 +0200
Message-Id: <1279789097-2420-3-git-send-email-sancane@gmail.com>
In-Reply-To: <1279789097-2420-2-git-send-email-sancane@gmail.com>
References: <1279789001-4587-30-git-send-email-santoscadenas@gmail.com>
 <1279789097-2420-1-git-send-email-sancane@gmail.com>
 <1279789097-2420-2-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mcap/mcap.c     |   22 +++++++++++-----------
 mcap/mcap_lib.h |    8 ++++----
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index e89b720..1e55bc7 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -54,7 +54,7 @@ struct connect_mcl {
 typedef union {
 	mcap_mdl_operation_cb 		op;
 	mcap_mdl_operation_conf_cb	op_conf;
-	mcap_mdl_del_cb			del;
+	mcap_mdl_notify_cb		notify;
 } mcap_cb_type;
 
 struct mcap_mdl_op_cb {
@@ -266,7 +266,7 @@ static void mcap_notify_error(struct mcap_mcl *mcl, GError *err)
 		l = g_slist_find_custom(mcl->mdls, &st, cmp_mdl_state);
 		shutdown_mdl(l->data);
 		update_mcl_state(mcl);
-		con->cb.del(err, con->user_data);
+		con->cb.notify(err, con->user_data);
 		break;
 	case MCAP_MD_DELETE_MDL_REQ:
 		for (l = mcl->mdls; l; l = l->next) {
@@ -276,7 +276,7 @@ static void mcap_notify_error(struct mcap_mcl *mcl, GError *err)
 								MDL_CLOSED;
 		}
 		update_mcl_state(mcl);
-		con->cb.del(err, con->user_data);
+		con->cb.notify(err, con->user_data);
 		break;
 	case MCAP_MD_RECONNECT_MDL_REQ:
 		st = MDL_WAITING;
@@ -549,7 +549,7 @@ static void send_delete_req(GError **err, struct mcap_mcl *mcl,
 }
 
 void mcap_req_mdl_delete_all(struct mcap_mcl *mcl, GError **err,
-			mcap_mdl_del_cb delete_cb, gpointer user_data)
+			mcap_mdl_notify_cb delete_cb, gpointer user_data)
 {
 	GSList *l;
 	struct mcap_mdl *mdl;
@@ -570,7 +570,7 @@ void mcap_req_mdl_delete_all(struct mcap_mcl *mcl, GError **err,
 
 	con = g_new0(struct mcap_mdl_op_cb, 1);
 	con->mdl = NULL;
-	con->cb.del = delete_cb;
+	con->cb.notify = delete_cb;
 	con->user_data = user_data;
 
 	send_delete_req(err, mcl, con, MCAP_ALL_MDLIDS);
@@ -579,7 +579,7 @@ void mcap_req_mdl_delete_all(struct mcap_mcl *mcl, GError **err,
 }
 
 void mcap_req_mdl_deletion(struct mcap_mdl *mdl, GError **err,
-			mcap_mdl_del_cb delete_cb, gpointer user_data)
+			mcap_mdl_notify_cb delete_cb, gpointer user_data)
 {
 	struct mcap_mcl *mcl= mdl->mcl;
 	struct mcap_mdl_op_cb *con;
@@ -602,7 +602,7 @@ void mcap_req_mdl_deletion(struct mcap_mdl *mdl, GError **err,
 
 	con = g_new0(struct mcap_mdl_op_cb, 1);
 	con->mdl = mdl;
-	con->cb.del = delete_cb;
+	con->cb.notify = delete_cb;
 	con->user_data = user_data;
 
 	send_delete_req(err, mcl, con, mdl->mdlid);
@@ -611,7 +611,7 @@ void mcap_req_mdl_deletion(struct mcap_mdl *mdl, GError **err,
 }
 
 void mcap_mdl_abort(struct mcap_mdl *mdl, GError **err,
-			mcap_mdl_del_cb abort_cb, gpointer user_data)
+				mcap_mdl_notify_cb abort_cb, gpointer user_data)
 {
 	struct mcap_mdl_op_cb *con;
 	struct mcap_mcl *mcl = mdl->mcl;
@@ -633,7 +633,7 @@ void mcap_mdl_abort(struct mcap_mdl *mdl, GError **err,
 	}
 
 	con->mdl = mdl;
-	con->cb.del = abort_cb;
+	con->cb.notify = abort_cb;
 	con->user_data = user_data;
 
 	mcl->priv_data = con;
@@ -1395,7 +1395,7 @@ static gboolean process_md_abort_mdl_rsp(struct mcap_mcl *mcl,
 						uint8_t *cmd, uint32_t len)
 {
 	struct mcap_mdl_op_cb *abrt = mcl->priv_data;
-	mcap_mdl_del_cb abrt_cb = abrt->cb.del;
+	mcap_mdl_notify_cb abrt_cb = abrt->cb.notify;
 	gpointer user_data = abrt->user_data;
 	struct mcap_mdl *mdl = abrt->mdl;
 	mcap4B_rsp *rsp = (mcap4B_rsp *)cmd;
@@ -1444,7 +1444,7 @@ static gboolean process_md_delete_mdl_rsp(struct mcap_mcl *mcl, uint8_t *cmd,
 {
 	struct mcap_mdl_op_cb *del = mcl->priv_data;
 	struct mcap_mdl *mdl = del->mdl;
-	mcap_mdl_del_cb deleted_cb = del->cb.del;
+	mcap_mdl_notify_cb deleted_cb = del->cb.notify;
 	gpointer user_data = del->user_data;
 	mcap_md_req *cmdlast = (mcap_md_req *) mcl->lcmd;
 	uint16_t mdlid = ntohs(cmdlast->mdl);
diff --git a/mcap/mcap_lib.h b/mcap/mcap_lib.h
index afac8aa..3d6e0b6 100644
--- a/mcap/mcap_lib.h
+++ b/mcap/mcap_lib.h
@@ -79,7 +79,7 @@ typedef void (* mcap_mdl_operation_conf_cb) (struct mcap_mdl *mdl, uint8_t conf,
 						GError *err, gpointer data);
 typedef void (* mcap_mdl_operation_cb) (struct mcap_mdl *mdl, GError *err,
 						gpointer data);
-typedef void (* mcap_mdl_del_cb) (GError *err, gpointer data);
+typedef void (* mcap_mdl_notify_cb) (GError *err, gpointer data);
 
 /* Next function should return an MCAP appropriate response code */
 typedef uint8_t (* mcap_remote_mdl_conn_req_cb) (struct mcap_mcl *mcl,
@@ -108,9 +108,9 @@ void mcap_req_mdl_reconnect(struct mcap_mdl *mdl, GError **err,
 				mcap_mdl_operation_cb reconnect_cb,
 				gpointer user_data);
 void mcap_req_mdl_delete_all(struct mcap_mcl *mcl, GError **err,
-			mcap_mdl_del_cb delete_cb, gpointer user_data);
+			mcap_mdl_notify_cb delete_cb, gpointer user_data);
 void mcap_req_mdl_deletion(struct mcap_mdl *mdl, GError **err,
-			mcap_mdl_del_cb delete_cb, gpointer user_data);
+			mcap_mdl_notify_cb delete_cb, gpointer user_data);
 void mcap_mdl_connect(struct mcap_mdl *mdl,
 			BtIOType BtType,
 			uint16_t dcpsm,
@@ -118,7 +118,7 @@ void mcap_mdl_connect(struct mcap_mdl *mdl,
 			mcap_mdl_operation_cb connect_cb,
 			gpointer user_data);
 void mcap_mdl_abort(struct mcap_mdl *mdl, GError **err,
-			mcap_mdl_del_cb abort_cb, gpointer user_data);
+			mcap_mdl_notify_cb abort_cb, gpointer user_data);
 
 int mcap_mdl_get_fd(struct mcap_mdl *mdl);
 uint16_t mcap_mdl_get_mdlid(struct mcap_mdl *mdl);
-- 
1.6.3.3

