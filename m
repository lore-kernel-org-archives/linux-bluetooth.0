Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot Nemesio <sancane@gmail.com>
Subject: [PATCH 04/25] Processing connections over control channel psm
Date: Mon, 10 May 2010 12:15:06 +0200
Message-Id: <1273486527-7855-4-git-send-email-sancane@gmail.com>
In-Reply-To: <1273486527-7855-3-git-send-email-sancane@gmail.com>
References: <1273486527-7855-1-git-send-email-sancane@gmail.com>
 <1273486527-7855-2-git-send-email-sancane@gmail.com>
 <1273486527-7855-3-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Santiago Carot Nemesio <sancane@gmail.com>

---
 mcap/mcap.c |  179 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 175 insertions(+), 4 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 7d34b95..5b0257c 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -41,6 +41,71 @@
 	__mcl->tid = 0;			\
 } while(0)
 
+static void default_mdl_connected_cb(struct mcap_mdl *mdl, gpointer data)
+{
+	debug("MCAP Unmanaged mdl connection");
+}
+
+static void default_mdl_closed_cb(struct mcap_mdl *mdl, gpointer data)
+{
+	debug("MCAP Unmanaged mdl clsoed");
+}
+
+static void default_mdl_deleted_cb(struct mcap_mdl *mdl, gpointer data)
+{
+	debug("MCAP Unmanaged mdl deleted");
+}
+
+static void default_mdl_aborted_cb(struct mcap_mdl *mdl, gpointer data)
+{
+	debug("MCAP Unmanaged mdl aborted");
+}
+
+static uint8_t default_mdl_conn_req_cb(struct mcap_mcl *mcl,
+						uint8_t mdepid, uint16_t mdlid,
+						uint8_t *conf, gpointer data)
+{
+	debug("MCAP mdl remote connection aborted");
+	/* Due to this callback is not managed this request won't be supported */
+	return MCAP_REQUEST_NOT_SUPPORTED;
+}
+
+static uint8_t default_mdl_reconn_req_cb(struct mcap_mdl *mdl,
+						gpointer data)
+{
+	debug("MCAP mdl remote reconnection aborted");
+	/* Due to this callback is not managed this request won't be supported */
+	return MCAP_REQUEST_NOT_SUPPORTED;
+}
+
+static void set_default_cb(struct mcap_mcl *mcl)
+{
+	if (!mcl->cb)
+		mcl->cb = g_new0(struct mcap_mdl_cb, 1);
+
+	mcl->cb->mdl_connected = default_mdl_connected_cb;
+	mcl->cb->mdl_closed = default_mdl_closed_cb;
+	mcl->cb->mdl_deleted = default_mdl_deleted_cb;
+	mcl->cb->mdl_aborted = default_mdl_aborted_cb;
+	mcl->cb->mdl_conn_req = default_mdl_conn_req_cb;
+	mcl->cb->mdl_reconn_req = default_mdl_reconn_req_cb;
+}
+
+static struct mcap_mcl *find_mcl(GSList *list, const bdaddr_t *addr)
+{
+	GSList *l;
+	struct mcap_mcl *mcl;
+
+	for (l = list; l; l = l->next) {
+		mcl = l->data;
+
+		if (!bacmp(&mcl->addr, addr))
+			return mcl;
+	}
+
+	return NULL;
+}
+
 static void shutdown_mdl(struct mcap_mdl *mdl)
 {
 	mdl->state = MDL_CLOSED;
@@ -125,14 +190,22 @@ static void mcap_mcl_release(struct mcap_mcl *mcl)
 	mcap_mcl_free(mcl, FALSE);
 }
 
-static void confirm_dc_event_cb(GIOChannel *chan, gpointer user_data)
+static void mcap_mcl_check_del(struct mcap_mcl *mcl)
 {
-	/* TODO: Check if we can connect this data channel */
+	if (mcl->ctrl & MCAP_CTRL_CACHED)
+		mcap_mcl_shutdown(mcl);
+	else
+		mcap_mcl_unref(mcl);
 }
 
-static void confirm_mcl_event_cb(GIOChannel *chan, gpointer user_data)
+static void mcap_cache_mcl(struct mcap_mcl *mcl)
 {
-	/* TODO: Check if we can connect this MCL */
+	/* TODO: Store in cache this MCL for future reconnections */
+}
+
+static void mcap_uncache_mcl(struct mcap_mcl *mcl)
+{
+	/* TODO: Remove this MCL from cache */
 }
 
 struct mcap_mcl *mcap_mcl_ref(struct mcap_mcl *mcl)
@@ -156,6 +229,104 @@ void mcap_mcl_unref(struct mcap_mcl *mcl)
 	mcap_mcl_release(mcl);
 }
 
+static gboolean mcl_control_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
+{
+	/* Process events received over the control channel*/
+	return FALSE;
+}
+
+static void confirm_dc_event_cb(GIOChannel *chan, gpointer user_data)
+{
+	/* TODO: Check if we can connect this data channel */
+	g_io_channel_shutdown(chan, TRUE, NULL);
+}
+
+static void connect_mcl_event_cb(GIOChannel *chan, GError *err, gpointer user_data)
+{
+	struct mcap_mcl *mcl = user_data;
+	gboolean reconn;
+
+	if (err) {
+		mcap_mcl_check_del(mcl);
+		return;
+	}
+
+	mcl->state = MCL_CONNECTED;
+	mcl->role = MCL_ACCEPTOR;
+	mcl->req = MCL_AVAILABLE;
+	mcl->cc = g_io_channel_ref(chan);
+	mcl->ctrl |= MCAP_CTRL_STD_OP;
+
+	reconn = (mcl->ctrl & MCAP_CTRL_CACHED);
+	if (reconn)
+		mcap_uncache_mcl(mcl);
+	else
+		mcl->ms->mcls = g_slist_prepend(mcl->ms->mcls, mcl);
+
+	mcl->wid = g_io_add_watch(mcl->cc,
+			G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+			(GIOFunc) mcl_control_cb, mcl);
+
+	/* Callback to report new MCL */
+	if (reconn)
+		mcl->ms->mcl_reconnected_cb(mcl, mcl->ms->user_data);
+	else
+		mcl->ms->mcl_connected_cb(mcl, mcl->ms->user_data);
+
+	if (mcl->ref == 1) {
+		mcl->ms->mcls = g_slist_remove(mcl->ms->mcls, mcl);
+		mcap_mcl_unref(mcl);
+	}
+}
+
+static void confirm_mcl_event_cb(GIOChannel *chan, gpointer user_data)
+{
+	struct mcap_session *ms = user_data;
+	struct mcap_mcl *mcl;
+	bdaddr_t dst;
+	char address[18], srcstr[18];
+	GError *err = NULL;
+
+	bt_io_get(chan, BT_IO_L2CAP, &err,
+			BT_IO_OPT_DEST_BDADDR, &dst,
+			BT_IO_OPT_DEST, address,
+			BT_IO_OPT_INVALID);
+	if (err) {
+		error("%s", err->message);
+		g_error_free(err);
+		goto drop;
+	}
+
+	ba2str(&ms->src, srcstr);
+	mcl = find_mcl(ms->mcls, &dst);
+	if (mcl) {
+		error("Control channel already created with %s on adapter %s",
+				address, srcstr);
+		goto drop;
+	}
+
+	mcl = find_mcl(ms->cached, &dst);
+	if (!mcl) {
+		mcl = g_new0(struct mcap_mcl, 1);
+		mcl->ms = ms;
+		bacpy(&mcl->addr, &dst);
+		set_default_cb(mcl);
+		mcl = mcap_mcl_ref(mcl);
+	}
+
+	if (!bt_io_accept(chan, connect_mcl_event_cb, mcl, NULL, &err)) {
+		error("mcap accept error: %s", err->message);
+		if (!(mcl->ctrl & MCAP_CTRL_CACHED))
+			mcap_mcl_unref(mcl);
+		g_error_free(err);
+		goto drop;
+	}
+
+	return;
+drop:
+	g_io_channel_shutdown(chan, TRUE, NULL);
+}
+
 struct mcap_session *mcap_create_session(struct btd_adapter *btd_adapter,
 					BtIOSecLevel sec,
 					uint16_t ccpsm,
-- 
1.6.3.3

