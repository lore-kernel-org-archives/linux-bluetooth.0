Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 2/2] Avoid possible memory leak in mcap_create_mcl function
Date: Mon,  6 Sep 2010 10:15:52 +0200
Message-Id: <1283760952-7238-1-git-send-email-sancane@gmail.com>
In-Reply-To: <1283760704-5390-1-git-send-email-santoscadenas@gmail.com>
References: <1283760704-5390-1-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/mcap.c |   28 +++++++++++++++++++++++++---
 1 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/health/mcap.c b/health/mcap.c
index 30a1e6e..17e16d8 100644
--- a/health/mcap.c
+++ b/health/mcap.c
@@ -53,6 +53,7 @@ struct connect_mcl {
 	struct mcap_mcl		*mcl;		/* MCL for this operation */
 	mcap_mcl_connect_cb	connect_cb;	/* Connect callback */
 	gpointer		user_data;	/* Callback user data */
+	gboolean		proc;		/* If it is was proccessed */
 };
 
 typedef union {
@@ -1695,8 +1696,7 @@ static void mcap_connect_mcl_cb(GIOChannel *chan, GError *conn_err,
 	gpointer data = con->user_data;
 	GError *gerr = NULL;
 
-	g_free(con);
-
+	con->proc = TRUE;
 	mcl->ctrl &= ~MCAP_CTRL_CONN;
 
 	if (conn_err) {
@@ -1760,6 +1760,28 @@ static void connect_dc_event_cb(GIOChannel *chan, GError *err,
 	mcl->cb->mdl_connected(mdl, mcl->cb->user_data);
 }
 
+static void mcl_io_destroy(gpointer data)
+{
+	struct connect_mcl *con = data;
+	struct mcap_mcl *mcl = con->mcl;
+	mcap_mcl_connect_cb connect_cb = con->connect_cb;
+	gpointer user_data = con->user_data;
+	GError *err = NULL;
+
+	g_free(con);
+
+	if (con->proc)
+		return;
+
+	mcl->ctrl &= ~MCAP_CTRL_CONN;
+
+	if (mcl->ctrl & MCAP_CTRL_FREE)
+		mcl->ms->mcl_uncached_cb(mcl, mcl->ms->user_data);
+	mcap_mcl_check_del(mcl);
+	g_set_error(&err, MCAP_ERROR, MCAP_ERROR_FAILED, "Connection error");
+	connect_cb(NULL, err, user_data);
+}
+
 gboolean mcap_create_mcl(struct mcap_instance *ms,
 				const bdaddr_t *addr,
 				uint16_t ccpsm,
@@ -1795,7 +1817,7 @@ gboolean mcap_create_mcl(struct mcap_instance *ms,
 	con->user_data = user_data;
 
 	mcl->cc = bt_io_connect(BT_IO_L2CAP, mcap_connect_mcl_cb, con,
-				NULL, err,
+				mcl_io_destroy, err,
 				BT_IO_OPT_SOURCE_BDADDR, &ms->src,
 				BT_IO_OPT_DEST_BDADDR, addr,
 				BT_IO_OPT_PSM, ccpsm,
-- 
1.7.0.4

