Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 03/26] Initial work to process incomming connection of MCLs
Date: Fri,  4 Jun 2010 10:26:56 +0200
Message-Id: <1275640039-7245-4-git-send-email-sancane@gmail.com>
In-Reply-To: <1275640039-7245-3-git-send-email-sancane@gmail.com>
References: <1275640039-7245-1-git-send-email-sancane@gmail.com>
 <1275640039-7245-2-git-send-email-sancane@gmail.com>
 <1275640039-7245-3-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mcap/mcap.c |  193 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 192 insertions(+), 1 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index f2c95fb..ea92118 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -36,14 +36,205 @@
 
 #define MCAP_ERROR g_quark_from_static_string("mcap-error-quark")
 
+static void default_mdl_connected_cb(struct mcap_mdl *mdl, gpointer data)
+{
+	DBG("MCAP Unmanaged mdl connection");
+}
+
+static void default_mdl_closed_cb(struct mcap_mdl *mdl, gpointer data)
+{
+	DBG("MCAP Unmanaged mdl closed");
+}
+
+static void default_mdl_deleted_cb(struct mcap_mdl *mdl, gpointer data)
+{
+	DBG("MCAP Unmanaged mdl deleted");
+}
+
+static void default_mdl_aborted_cb(struct mcap_mdl *mdl, gpointer data)
+{
+	DBG("MCAP Unmanaged mdl aborted");
+}
+
+static uint8_t default_mdl_conn_req_cb(struct mcap_mcl *mcl,
+						uint8_t mdepid, uint16_t mdlid,
+						uint8_t *conf, gpointer data)
+{
+	DBG("MCAP mdl remote connection aborted");
+	/* Due to this callback isn't managed this request won't be supported */
+	return MCAP_REQUEST_NOT_SUPPORTED;
+}
+
+static uint8_t default_mdl_reconn_req_cb(struct mcap_mdl *mdl,
+						gpointer data)
+{
+	DBG("MCAP mdl remote reconnection aborted");
+	/* Due to this callback isn't managed this request won't be supported */
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
+static void mcap_mcl_release(struct mcap_mcl *mcl)
+{
+	/* TODO */
+}
+
+static void mcap_mcl_check_del(struct mcap_mcl *mcl)
+{
+	/* TODO */
+}
+
+static void mcap_uncache_mcl(struct mcap_mcl *mcl)
+{
+	/* TODO */
+}
+
+struct mcap_mcl *mcap_mcl_ref(struct mcap_mcl *mcl)
+{
+	mcl->ref++;
+
+	DBG("mcap_mcl_ref(%p): ref=%d", mcl, mcl->ref);
+
+	return mcl;
+}
+
+void mcap_mcl_unref(struct mcap_mcl *mcl)
+{
+	mcl->ref--;
+
+	DBG("mcap_mcl_unref(%p): ref=%d", mcl, mcl->ref);
+
+	if (mcl->ref > 0)
+		return;
+
+	mcap_mcl_release(mcl);
+}
+
+static gboolean mcl_control_cb(GIOChannel *chan, GIOCondition cond,
+								gpointer data)
+{
+
+	/* TODO */
+	return FALSE;
+}
+
 static void confirm_dc_event_cb(GIOChannel *chan, gpointer user_data)
 {
 	/* TODO */
 }
 
+static void connect_mcl_event_cb(GIOChannel *chan, GError *err,
+							gpointer user_data)
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
 static void confirm_mcl_event_cb(GIOChannel *chan, gpointer user_data)
 {
-	/* TODO */
+	struct mcap_instance *ms = user_data;
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
 }
 
 struct mcap_instance *mcap_create_instance(struct btd_adapter *btd_adapter,
-- 
1.6.3.3

