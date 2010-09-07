Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH] Avoid possible memory leak in mcap_create_mcl function
Date: Tue,  7 Sep 2010 12:36:42 +0200
Message-Id: <1283855802-8548-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/mcap.c |   39 ++++++++++++++++++++++++++++++++++-----
 1 files changed, 34 insertions(+), 5 deletions(-)

diff --git a/health/mcap.c b/health/mcap.c
index 6f1e565..a9a1190 100644
--- a/health/mcap.c
+++ b/health/mcap.c
@@ -783,6 +783,17 @@ static void mcap_uncache_mcl(struct mcap_mcl *mcl)
 	mcl->ctrl &= ~MCAP_CTRL_FREE;
 }
 
+static void close_connecting_mcl(struct mcap_mcl *mcl)
+{
+	mcl->ctrl &= ~MCAP_CTRL_CONN;
+
+	if (mcl->ctrl & MCAP_CTRL_FREE) {
+		/* We have closed an MCL marked as releseable */
+		/* while it was in connecting process */
+		mcl->ms->mcl_uncached_cb(mcl, mcl->ms->user_data);
+	}
+}
+
 void mcap_close_mcl(struct mcap_mcl *mcl, gboolean cache)
 {
 	if (!mcl)
@@ -792,6 +803,9 @@ void mcap_close_mcl(struct mcap_mcl *mcl, gboolean cache)
 		g_io_channel_shutdown(mcl->cc, TRUE, NULL);
 		g_io_channel_unref(mcl->cc);
 		mcl->cc = NULL;
+
+		if (mcl->ctrl & MCAP_CTRL_CONN)
+			close_connecting_mcl(mcl);
 	}
 
 	mcl->state = MCL_IDLE;
@@ -1674,8 +1688,6 @@ static void mcap_connect_mcl_cb(GIOChannel *chan, GError *conn_err,
 	gpointer data = con->user_data;
 	GError *gerr = NULL;
 
-	g_free(con);
-
 	mcl->ctrl &= ~MCAP_CTRL_CONN;
 
 	if (conn_err) {
@@ -1739,6 +1751,21 @@ static void connect_dc_event_cb(GIOChannel *chan, GError *err,
 	mcl->cb->mdl_connected(mdl, mcl->cb->user_data);
 }
 
+static void mcl_io_destroy(gpointer data)
+{
+	struct connect_mcl *con = data;
+	struct mcap_mcl *mcl = con->mcl;
+
+	g_free(con);
+
+	if ((mcl->state != MCL_IDLE) || (mcl->ctrl & MCAP_CTRL_CACHED))
+		return;
+
+	/* This is a new MCL or another MCL removed */
+	/* from MCAP cache so we have to release it */
+	mcap_mcl_unref(mcl);
+}
+
 gboolean mcap_create_mcl(struct mcap_instance *ms,
 				const bdaddr_t *addr,
 				uint16_t ccpsm,
@@ -1765,8 +1792,9 @@ gboolean mcap_create_mcl(struct mcap_instance *ms,
 		set_default_cb(mcl);
 		mcl->next_mdl = (rand() % MCAP_MDLID_FINAL) + 1;
 		mcl = mcap_mcl_ref(mcl);
-	} else
-		mcl->ctrl |= MCAP_CTRL_CONN;
+	}
+
+	mcl->ctrl |= MCAP_CTRL_CONN;
 
 	con = g_new0(struct connect_mcl, 1);
 	con->mcl = mcl;
@@ -1774,13 +1802,14 @@ gboolean mcap_create_mcl(struct mcap_instance *ms,
 	con->user_data = user_data;
 
 	mcl->cc = bt_io_connect(BT_IO_L2CAP, mcap_connect_mcl_cb, con,
-				NULL, err,
+				mcl_io_destroy, err,
 				BT_IO_OPT_SOURCE_BDADDR, &ms->src,
 				BT_IO_OPT_DEST_BDADDR, addr,
 				BT_IO_OPT_PSM, ccpsm,
 				BT_IO_OPT_MTU, MCAP_CC_MTU,
 				BT_IO_OPT_SEC_LEVEL, ms->sec,
 				BT_IO_OPT_INVALID);
+
 	if (!mcl->cc) {
 		g_free(con);
 		mcl->ctrl &= ~MCAP_CTRL_CONN;
-- 
1.7.0.4

