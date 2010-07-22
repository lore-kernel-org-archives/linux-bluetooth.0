Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 57/60] Set Gerror at the end of the output paremeters list
Date: Thu, 22 Jul 2010 10:58:14 +0200
Message-Id: <1279789097-2420-9-git-send-email-sancane@gmail.com>
In-Reply-To: <1279789097-2420-8-git-send-email-sancane@gmail.com>
References: <1279789001-4587-30-git-send-email-santoscadenas@gmail.com>
 <1279789097-2420-1-git-send-email-sancane@gmail.com>
 <1279789097-2420-2-git-send-email-sancane@gmail.com>
 <1279789097-2420-3-git-send-email-sancane@gmail.com>
 <1279789097-2420-4-git-send-email-sancane@gmail.com>
 <1279789097-2420-5-git-send-email-sancane@gmail.com>
 <1279789097-2420-6-git-send-email-sancane@gmail.com>
 <1279789097-2420-7-git-send-email-sancane@gmail.com>
 <1279789097-2420-8-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mcap/mcap.c     |   34 +++++++++++++++++-----------------
 mcap/mcap_lib.h |   49 ++++++++++++++++++++++++++++---------------------
 2 files changed, 45 insertions(+), 38 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 869b6e7..30a8d56 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -429,9 +429,9 @@ static gboolean wait_response_timer(gpointer data)
 void mcap_req_mdl_creation(struct mcap_mcl *mcl,
 				uint8_t mdepid,
 				uint8_t conf,
-				GError **err,
 				mcap_mdl_operation_conf_cb connect_cb,
-				gpointer user_data)
+				gpointer user_data,
+				GError **err)
 {
 	struct mcap_mdl *mdl;
 	struct mcap_mdl_op_cb *con;
@@ -474,9 +474,9 @@ void mcap_req_mdl_creation(struct mcap_mcl *mcl,
 }
 
 void mcap_req_mdl_reconnect(struct mcap_mdl *mdl,
-				GError **err,
 				mcap_mdl_operation_cb reconnect_cb,
-				gpointer user_data)
+				gpointer user_data,
+				GError **err)
 {
 	struct mcap_mdl_op_cb *con;
 	struct mcap_mcl *mcl = mdl->mcl;
@@ -528,8 +528,8 @@ static void send_delete_req(GError **err, struct mcap_mcl *mcl,
 									mcl);
 }
 
-void mcap_req_mdl_delete_all(struct mcap_mcl *mcl, GError **err,
-			mcap_mdl_notify_cb delete_cb, gpointer user_data)
+void mcap_req_mdl_delete_all(struct mcap_mcl *mcl, mcap_mdl_notify_cb delete_cb,
+					gpointer user_data, GError **err)
 {
 	GSList *l;
 	struct mcap_mdl *mdl;
@@ -558,8 +558,8 @@ void mcap_req_mdl_delete_all(struct mcap_mcl *mcl, GError **err,
 		g_free(con);
 }
 
-void mcap_req_mdl_deletion(struct mcap_mdl *mdl, GError **err,
-			mcap_mdl_notify_cb delete_cb, gpointer user_data)
+void mcap_req_mdl_deletion(struct mcap_mdl *mdl, mcap_mdl_notify_cb delete_cb,
+					gpointer user_data, GError **err)
 {
 	struct mcap_mcl *mcl= mdl->mcl;
 	struct mcap_mdl_op_cb *con;
@@ -590,8 +590,8 @@ void mcap_req_mdl_deletion(struct mcap_mdl *mdl, GError **err,
 		g_free(con);
 }
 
-void mcap_mdl_abort(struct mcap_mdl *mdl, GError **err,
-				mcap_mdl_notify_cb abort_cb, gpointer user_data)
+void mcap_mdl_abort(struct mcap_mdl *mdl, mcap_mdl_notify_cb abort_cb,
+					gpointer user_data, GError **err)
 {
 	struct mcap_mdl_op_cb *con;
 	struct mcap_mcl *mcl = mdl->mcl;
@@ -892,8 +892,8 @@ static gboolean parse_set_opts(struct mcap_mdl_cb *mdl_cb, GError **err,
 	return TRUE;
 }
 
-void mcap_mcl_set_cb(struct mcap_mcl *mcl, GError **gerr,
-					gpointer user_data, McapMclCb cb1, ...)
+void mcap_mcl_set_cb(struct mcap_mcl *mcl, gpointer user_data, GError **gerr,
+							McapMclCb cb1, ...)
 {
 	va_list args;
 	gboolean ret;
@@ -1594,7 +1594,7 @@ static void mcap_connect_mdl_cb(GIOChannel *chan, GError *conn_err,
 }
 
 void mcap_mdl_connect(struct mcap_mdl *mdl, BtIOType BtType, uint16_t dcpsm,
-	GError **err, mcap_mdl_operation_cb connect_cb, gpointer user_data)
+	mcap_mdl_operation_cb connect_cb, gpointer user_data, GError **err)
 {
 	struct mcap_mdl_op_cb *con;
 
@@ -1738,9 +1738,9 @@ static void connect_dc_event_cb(GIOChannel *chan, GError *err,
 void mcap_create_mcl(struct mcap_instance *ms,
 				const bdaddr_t *addr,
 				uint16_t ccpsm,
-				GError **err,
 				mcap_mcl_connect_cb connect_cb,
-				gpointer user_data)
+				gpointer user_data,
+				GError **err)
 {
 	struct mcap_mcl *mcl;
 	struct connect_mcl *con;
@@ -1917,12 +1917,12 @@ struct mcap_instance *mcap_create_instance(struct btd_adapter *btd_adapter,
 					BtIOSecLevel sec,
 					uint16_t ccpsm,
 					uint16_t dcpsm,
-					GError **gerr,
 					mcap_mcl_event_cb mcl_connected,
 					mcap_mcl_event_cb mcl_reconnected,
 					mcap_mcl_event_cb mcl_disconnected,
 					mcap_mcl_event_cb mcl_uncached,
-					gpointer user_data)
+					gpointer user_data,
+					GError **gerr)
 {
 	struct mcap_instance *ms;
 
diff --git a/mcap/mcap_lib.h b/mcap/mcap_lib.h
index 54b40ad..7b8fcfd 100644
--- a/mcap/mcap_lib.h
+++ b/mcap/mcap_lib.h
@@ -101,24 +101,31 @@ typedef void (* mcap_mcl_connect_cb) (struct mcap_mcl *mcl, GError *err,
 void mcap_req_mdl_creation(struct mcap_mcl *mcl,
 				uint8_t mdepid,
 				uint8_t conf,
-				GError **err,
 				mcap_mdl_operation_conf_cb connect_cb,
-				gpointer user_data);
-void mcap_req_mdl_reconnect(struct mcap_mdl *mdl, GError **err,
+				gpointer user_data,
+				GError **err);
+void mcap_req_mdl_reconnect(struct mcap_mdl *mdl,
 				mcap_mdl_operation_cb reconnect_cb,
-				gpointer user_data);
-void mcap_req_mdl_delete_all(struct mcap_mcl *mcl, GError **err,
-			mcap_mdl_notify_cb delete_cb, gpointer user_data);
-void mcap_req_mdl_deletion(struct mcap_mdl *mdl, GError **err,
-			mcap_mdl_notify_cb delete_cb, gpointer user_data);
+				gpointer user_data,
+				GError **err);
+void mcap_req_mdl_delete_all(struct mcap_mcl *mcl,
+				mcap_mdl_notify_cb delete_cb,
+				gpointer user_data,
+				GError **err);
+void mcap_req_mdl_deletion(struct mcap_mdl *mdl,
+				mcap_mdl_notify_cb delete_cb,
+				gpointer user_data,
+				GError **err);
 void mcap_mdl_connect(struct mcap_mdl *mdl,
-			BtIOType BtType,
-			uint16_t dcpsm,
-			GError **err,
-			mcap_mdl_operation_cb connect_cb,
-			gpointer user_data);
-void mcap_mdl_abort(struct mcap_mdl *mdl, GError **err,
-			mcap_mdl_notify_cb abort_cb, gpointer user_data);
+				BtIOType BtType,
+				uint16_t dcpsm,
+				mcap_mdl_operation_cb connect_cb,
+				gpointer user_data,
+				GError **err);
+void mcap_mdl_abort(struct mcap_mdl *mdl,
+				mcap_mdl_notify_cb abort_cb,
+				gpointer user_data,
+				GError **err);
 
 int mcap_mdl_get_fd(struct mcap_mdl *mdl);
 uint16_t mcap_mdl_get_mdlid(struct mcap_mdl *mdl);
@@ -128,12 +135,12 @@ uint16_t mcap_mdl_get_mdlid(struct mcap_mdl *mdl);
 void mcap_create_mcl(struct mcap_instance *ms,
 				const bdaddr_t *addr,
 				uint16_t ccpsm,
-				GError **err,
 				mcap_mcl_connect_cb connect_cb,
-				gpointer user_data);
+				gpointer user_data,
+				GError **err);
 void mcap_close_mcl(struct mcap_mcl *mcl, gboolean cache);
-void mcap_mcl_set_cb(struct mcap_mcl *mcl, GError **gerr,
-					gpointer user_data, McapMclCb cb1, ...);
+void mcap_mcl_set_cb(struct mcap_mcl *mcl, gpointer user_data, GError **gerr,
+							McapMclCb cb1, ...);
 void mcap_mcl_get_addr(struct mcap_mcl *mcl, bdaddr_t *addr);
 
 struct mcap_mcl *mcap_mcl_ref(struct mcap_mcl *mcl);
@@ -144,12 +151,12 @@ void mcap_mcl_unref(struct mcap_mcl *mcl);
 struct mcap_instance *mcap_create_instance(struct btd_adapter *btd_adapter,
 					BtIOSecLevel sec, uint16_t ccpsm,
 					uint16_t dcpsm,
-					GError **gerr,
 					mcap_mcl_event_cb mcl_connected,
 					mcap_mcl_event_cb mcl_reconnected,
 					mcap_mcl_event_cb mcl_disconnected,
 					mcap_mcl_event_cb mcl_uncached,
-					gpointer user_data);
+					gpointer user_data,
+					GError **gerr);
 
 void mcap_release_instance(struct mcap_instance *ms);
 
-- 
1.6.3.3

