Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 1/2] Avoid possible memory leak in mcap_connect_mdl function
Date: Mon,  6 Sep 2010 10:11:44 +0200
Message-Id: <1283760704-5390-1-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/mcap.c |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/health/mcap.c b/health/mcap.c
index 6f1e565..30a1e6e 100644
--- a/health/mcap.c
+++ b/health/mcap.c
@@ -65,6 +65,7 @@ struct mcap_mdl_op_cb {
 	struct mcap_mdl		*mdl;		/* MDL for this operation */
 	mcap_cb_type		cb;		/* Operation callback */
 	gpointer		user_data;	/* Callback user data */
+	gboolean		proc;		/* If it was processed*/
 };
 
 /* MCAP finite state machine functions */
@@ -1573,7 +1574,7 @@ static void mcap_connect_mdl_cb(GIOChannel *chan, GError *conn_err,
 	mcap_mdl_operation_cb cb = con->cb.op;
 	gpointer user_data = con->user_data;
 
-	g_free(con);
+	con->proc = TRUE;
 	DBG("mdl connect callback");
 
 	if (conn_err) {
@@ -1592,6 +1593,26 @@ static void mcap_connect_mdl_cb(GIOChannel *chan, GError *conn_err,
 	cb(mdl, conn_err, user_data);
 }
 
+static void mdl_io_destroy(gpointer data)
+{
+	struct mcap_mdl_op_cb *con = data;
+	struct mcap_mdl *mdl = con->mdl;
+	mcap_mdl_operation_cb cb = con->cb.op;
+	gpointer user_data = con->user_data;
+	gboolean proc = con->proc;
+	GError *err = NULL;
+
+	g_free(con);
+
+	if (proc)
+		return;
+	g_set_error(&err, MCAP_ERROR, MCAP_ERROR_FAILED, "Connection error");
+	mdl->state = MDL_CLOSED;
+	g_io_channel_unref(mdl->dc);
+	mdl->dc = NULL;
+	cb(mdl, err, user_data);
+}
+
 gboolean mcap_connect_mdl(struct mcap_mdl *mdl, BtIOType BtType,
 					uint16_t dcpsm,
 					mcap_mdl_operation_cb connect_cb,
@@ -1613,7 +1634,7 @@ gboolean mcap_connect_mdl(struct mcap_mdl *mdl, BtIOType BtType,
 	/* TODO: Check if BtIOType is ERTM or Streaming before continue */
 
 	mdl->dc = bt_io_connect(BtType, mcap_connect_mdl_cb, con,
-				NULL, err,
+				mdl_io_destroy, err,
 				BT_IO_OPT_SOURCE_BDADDR, &mdl->mcl->ms->src,
 				BT_IO_OPT_DEST_BDADDR, &mdl->mcl->addr,
 				BT_IO_OPT_PSM, dcpsm,
-- 
1.7.0.4

