Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 1/2] Avoid possible memory leak in mcap_connect_mdl function
Date: Fri,  3 Sep 2010 10:31:04 +0200
Message-Id: <1283502664-5894-1-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/mcap.c |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/health/mcap.c b/health/mcap.c
index 6f1e565..ec9ea08 100644
--- a/health/mcap.c
+++ b/health/mcap.c
@@ -1592,6 +1592,22 @@ static void mcap_connect_mdl_cb(GIOChannel *chan, GError *conn_err,
 	cb(mdl, conn_err, user_data);
 }
 
+static void mdl_io_destroy(gpointer data)
+{
+	struct mcap_mdl_op_cb *con = data;
+	struct mcap_mdl *mdl = con->mdl;
+	mcap_mdl_operation_cb cb = con->cb.op;
+	gpointer user_data = con->user_data;
+	GError *err = NULL;
+
+	g_free(con);
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
@@ -1613,7 +1629,7 @@ gboolean mcap_connect_mdl(struct mcap_mdl *mdl, BtIOType BtType,
 	/* TODO: Check if BtIOType is ERTM or Streaming before continue */
 
 	mdl->dc = bt_io_connect(BtType, mcap_connect_mdl_cb, con,
-				NULL, err,
+				mdl_io_destroy, err,
 				BT_IO_OPT_SOURCE_BDADDR, &mdl->mcl->ms->src,
 				BT_IO_OPT_DEST_BDADDR, &mdl->mcl->addr,
 				BT_IO_OPT_PSM, dcpsm,
-- 
1.7.0.4

