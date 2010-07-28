Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 04/16] Added function for MCAP control channel (MCL) management
Date: Wed, 28 Jul 2010 10:00:13 +0200
Message-Id: <1280304015-9230-5-git-send-email-sancane@gmail.com>
In-Reply-To: <1280304015-9230-4-git-send-email-sancane@gmail.com>
References: <1280304015-9230-1-git-send-email-sancane@gmail.com>
 <1280304015-9230-2-git-send-email-sancane@gmail.com>
 <1280304015-9230-3-git-send-email-sancane@gmail.com>
 <1280304015-9230-4-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/mcap.c     |  270 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 health/mcap_lib.h |   30 ++++++
 2 files changed, 298 insertions(+), 2 deletions(-)

diff --git a/health/mcap.c b/health/mcap.c
index 282580d..ba2b2ad 100644
--- a/health/mcap.c
+++ b/health/mcap.c
@@ -37,6 +37,16 @@
 
 #define MCAP_ERROR g_quark_from_static_string("mcap-error-quark")
 
+#define RELEASE_TIMER(__mcl) do {	\
+	g_source_remove(__mcl->tid);	\
+	__mcl->tid = 0;			\
+} while(0)
+
+struct connect_mcl {
+	struct mcap_mcl		*mcl;		/* MCL for this operation */
+	mcap_mcl_connect_cb	connect_cb;	/* Connect callback */
+	gpointer		user_data;	/* Callback user data */
+};
 
 static void default_mdl_connected_cb(struct mcap_mdl *mdl, gpointer data)
 {
@@ -103,14 +113,59 @@ static struct mcap_mcl *find_mcl(GSList *list, const bdaddr_t *addr)
 	return NULL;
 }
 
+static void mcap_free_mdls(struct mcap_mcl *mcl, gboolean save)
+{
+	/* TODO: implement mcap_free_mdls */
+}
+
+static void close_mcl(struct mcap_mcl *mcl, gboolean save)
+{
+	gboolean store = ((!(mcl->ctrl & MCAP_CTRL_FREE)) && save);
+
+	if (mcl->tid) {
+		RELEASE_TIMER(mcl);
+	}
+
+	if (mcl->cc) {
+		g_io_channel_shutdown(mcl->cc, TRUE, NULL);
+		g_io_channel_unref(mcl->cc);
+		mcl->cc = NULL;
+	}
+
+	g_source_remove(mcl->wid);
+	if (mcl->lcmd) {
+		g_free(mcl->lcmd);
+		mcl->lcmd = NULL;
+	}
+
+	if (mcl->priv_data) {
+		g_free(mcl->priv_data);
+		mcl->priv_data = NULL;
+	}
+
+	mcap_free_mdls(mcl, store);
+
+	if (mcl->cb && !store) {
+		g_free(mcl->cb);
+		mcl->cb = NULL;
+	}
+
+	mcl->state = MCL_IDLE;
+
+	if (store)
+		return;
+
+	g_free(mcl);
+}
+
 static void mcap_mcl_shutdown(struct mcap_mcl *mcl)
 {
-	/* TODO: implement mcap_mcl_shutdown */
+	close_mcl(mcl, TRUE);
 }
 
 static void mcap_mcl_release(struct mcap_mcl *mcl)
 {
-	/* TODO: implement mcap_mcl_release */
+	close_mcl(mcl, FALSE);
 }
 
 static void mcap_mcl_check_del(struct mcap_mcl *mcl)
@@ -134,6 +189,23 @@ static void mcap_uncache_mcl(struct mcap_mcl *mcl)
 	mcl->ctrl &= ~MCAP_CTRL_FREE;
 }
 
+void mcap_close_mcl(struct mcap_mcl *mcl, gboolean cache)
+{
+	if (!mcl)
+		return;
+
+	if (mcl->cc) {
+		g_io_channel_shutdown(mcl->cc, TRUE, NULL);
+		g_io_channel_unref(mcl->cc);
+		mcl->cc = NULL;
+	}
+
+	mcl->state = MCL_IDLE;
+
+	if (!cache)
+		mcl->ctrl |= MCAP_CTRL_NOCACHE;
+}
+
 struct mcap_mcl *mcap_mcl_ref(struct mcap_mcl *mcl)
 {
 	mcl->ref++;
@@ -164,12 +236,206 @@ void mcap_mcl_unref(struct mcap_mcl *mcl)
 	mcap_mcl_release(mcl);
 }
 
+static gboolean parse_set_opts(struct mcap_mdl_cb *mdl_cb, GError **err,
+						McapMclCb cb1, va_list args)
+{
+	McapMclCb cb = cb1;
+	struct mcap_mdl_cb *c;
+
+	c = g_new0(struct mcap_mdl_cb, 1);
+
+	while (cb != MCAP_MDL_CB_INVALID) {
+		switch (cb) {
+		case MCAP_MDL_CB_CONNECTED:
+			c->mdl_connected = va_arg(args,
+				mcap_mdl_event_cb);
+			break;
+		case MCAP_MDL_CB_CLOSED:
+			c->mdl_closed = va_arg(args,
+				mcap_mdl_event_cb);
+			break;
+		case MCAP_MDL_CB_DELETED:
+			c->mdl_deleted = va_arg(args,
+				mcap_mdl_event_cb);
+			break;
+		case MCAP_MDL_CB_ABORTED:
+			c->mdl_aborted = va_arg(args,
+				mcap_mdl_event_cb);
+			break;
+		case MCAP_MDL_CB_REMOTE_CONN_REQ:
+			c->mdl_conn_req = va_arg(args,
+				mcap_remote_mdl_conn_req_cb);
+			break;
+		case MCAP_MDL_CB_REMOTE_RECONN_REQ:
+			c->mdl_reconn_req = va_arg(args,
+				mcap_remote_mdl_reconn_req_cb);
+			break;
+		default:
+			g_set_error(err, MCAP_ERROR, MCAP_ERROR_INVALID_ARGS,
+						"Unknown option %d", cb);
+			return FALSE;
+		}
+		cb = va_arg(args, int);
+	}
+
+	/* Set new callbacks */
+	if (c->mdl_connected)
+		mdl_cb->mdl_connected = c->mdl_connected;
+	if (c->mdl_closed)
+		mdl_cb->mdl_closed = c->mdl_closed;
+	if (c->mdl_deleted)
+		mdl_cb->mdl_deleted = c->mdl_deleted;
+	if (c->mdl_aborted)
+		mdl_cb->mdl_aborted = c->mdl_aborted;
+	if (c->mdl_conn_req)
+		mdl_cb->mdl_conn_req = c->mdl_conn_req;
+	if (c->mdl_reconn_req)
+		mdl_cb->mdl_reconn_req = c->mdl_reconn_req;
+
+	g_free(c);
+	return TRUE;
+}
+
+void mcap_mcl_set_cb(struct mcap_mcl *mcl, gpointer user_data, GError **gerr,
+							McapMclCb cb1, ...)
+{
+	va_list args;
+	gboolean ret;
+
+	va_start(args, cb1);
+	ret = parse_set_opts(mcl->cb, gerr, cb1, args);
+	va_end(args);
+
+	if (!ret)
+		return;
+
+	mcl->cb->user_data = user_data;
+	return;
+}
+
+void mcap_mcl_get_addr(struct mcap_mcl *mcl, bdaddr_t *addr)
+{
+	bacpy(addr, &mcl->addr);
+}
+
 static gboolean mcl_control_cb(GIOChannel *chan, GIOCondition cond,
 								gpointer data)
 {
 	/* TODO: Create mcl_control_cb */
 	return FALSE;
 }
+
+static void mcap_connect_mcl_cb(GIOChannel *chan, GError *conn_err,
+							gpointer user_data)
+{
+	char dstaddr[18];
+	struct connect_mcl *con = user_data;
+	struct mcap_mcl *aux, *mcl = con->mcl;
+	mcap_mcl_connect_cb connect_cb = con->connect_cb;
+	gpointer data = con->user_data;
+	GError *gerr = NULL;
+
+	g_free(con);
+
+	mcl->ctrl &= ~MCAP_CTRL_CONN;
+
+	if (conn_err) {
+		if (mcl->ctrl & MCAP_CTRL_FREE)
+			mcl->ms->mcl_uncached_cb(mcl, mcl->ms->user_data);
+		mcap_mcl_check_del(mcl);
+		connect_cb(NULL, conn_err, data);
+		return;
+	}
+
+	ba2str(&mcl->addr, dstaddr);
+
+	aux = find_mcl(mcl->ms->mcls, &mcl->addr);
+	if (aux) {
+		/* Double MCL connection case */
+		if (aux != mcl) {
+			/* This MCL was not in cache */
+			mcap_mcl_unref(mcl);
+		}
+		error("MCL error: Device %s is already connected", dstaddr);
+		g_set_error(&gerr, MCAP_ERROR, MCAP_ERROR_ALREADY_EXISTS,
+				"MCL %s is already connected", dstaddr);
+		connect_cb(NULL, gerr, data);
+		g_error_free(gerr);
+		return;
+	}
+
+	mcl->state = MCL_CONNECTED;
+	mcl->role = MCL_INITIATOR;
+	mcl->req = MCL_AVAILABLE;
+	mcl->ctrl |= MCAP_CTRL_STD_OP;
+
+	if (mcl->ctrl & MCAP_CTRL_CACHED)
+		mcap_uncache_mcl(mcl);
+	else
+		mcl->ms->mcls = g_slist_prepend(mcl->ms->mcls, mcl);
+
+	mcl->wid = g_io_add_watch(mcl->cc,
+				G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+				(GIOFunc) mcl_control_cb, mcl);
+	connect_cb(mcl, gerr, data);
+
+	if (mcl->ref == 1) {
+		mcl->ms->mcls = g_slist_remove(mcl->ms->mcls, mcl);
+		mcap_mcl_unref(mcl);
+	}
+}
+
+void mcap_create_mcl(struct mcap_instance *ms,
+				const bdaddr_t *addr,
+				uint16_t ccpsm,
+				mcap_mcl_connect_cb connect_cb,
+				gpointer user_data,
+				GError **err)
+{
+	struct mcap_mcl *mcl;
+	struct connect_mcl *con;
+
+	mcl = find_mcl(ms->mcls, addr);
+	if (mcl) {
+		g_set_error(err, MCAP_ERROR, MCAP_ERROR_ALREADY_EXISTS,
+					"MCL is already connected.");
+		return;
+	}
+
+	mcl = find_mcl(ms->cached, addr);
+	if (!mcl) {
+		mcl = g_new0(struct mcap_mcl, 1);
+		mcl->ms = ms;
+		mcl->state = MCL_IDLE;
+		bacpy(&mcl->addr, addr);
+		set_default_cb(mcl);
+		mcl->next_mdl = (rand() % MCAP_MDLID_FINAL) + 1;
+		mcl = mcap_mcl_ref(mcl);
+	} else
+		mcl->ctrl |= MCAP_CTRL_CONN;
+
+	con = g_new0(struct connect_mcl, 1);
+	con->mcl = mcl;
+	con->connect_cb = connect_cb;
+	con->user_data = user_data;
+
+	mcl->cc = bt_io_connect(BT_IO_L2CAP, mcap_connect_mcl_cb, con,
+				NULL, err,
+				BT_IO_OPT_SOURCE_BDADDR, &ms->src,
+				BT_IO_OPT_DEST_BDADDR, addr,
+				BT_IO_OPT_PSM, ccpsm,
+				BT_IO_OPT_MTU, MCAP_CC_MTU,
+				BT_IO_OPT_SEC_LEVEL, ms->sec,
+				BT_IO_OPT_INVALID);
+	if (*err) {
+		g_free(con);
+		mcl->ctrl &= ~MCAP_CTRL_CONN;
+		if (mcl->ctrl & MCAP_CTRL_FREE)
+			mcl->ms->mcl_uncached_cb(mcl, mcl->ms->user_data);
+		mcap_mcl_check_del(mcl);
+	}
+}
+
 static void confirm_dc_event_cb(GIOChannel *chan, gpointer user_data)
 {
 	/* TODO: implement confirm_dc_event_cb */
diff --git a/health/mcap_lib.h b/health/mcap_lib.h
index fcf69ee..b4e9c16 100644
--- a/health/mcap_lib.h
+++ b/health/mcap_lib.h
@@ -56,6 +56,16 @@ typedef enum {
 	MCAP_ERROR_FAILED
 } McapError;
 
+typedef enum {
+	MCAP_MDL_CB_INVALID,
+	MCAP_MDL_CB_CONNECTED,		/* mcap_mdl_event_cb */
+	MCAP_MDL_CB_CLOSED,		/* mcap_mdl_event_cb */
+	MCAP_MDL_CB_DELETED,		/* mcap_mdl_event_cb */
+	MCAP_MDL_CB_ABORTED,		/* mcap_mdl_event_cb */
+	MCAP_MDL_CB_REMOTE_CONN_REQ,	/* mcap_remote_mdl_conn_req_cb */
+	MCAP_MDL_CB_REMOTE_RECONN_REQ	/* mcap_remote_mdl_reconn_req_cb */
+} McapMclCb;
+
 struct mcap_instance;
 struct mcap_mcl;
 struct mcap_mdl;
@@ -65,6 +75,11 @@ struct mcap_mdl;
 /* mdl callbacks */
 
 typedef void (* mcap_mdl_event_cb) (struct mcap_mdl *mdl, gpointer data);
+typedef void (* mcap_mdl_operation_conf_cb) (struct mcap_mdl *mdl, uint8_t conf,
+						GError *err, gpointer data);
+typedef void (* mcap_mdl_operation_cb) (struct mcap_mdl *mdl, GError *err,
+						gpointer data);
+typedef void (* mcap_mdl_notify_cb) (GError *err, gpointer data);
 
 /* Next function should return an MCAP appropriate response code */
 typedef uint8_t (* mcap_remote_mdl_conn_req_cb) (struct mcap_mcl *mcl,
@@ -76,9 +91,24 @@ typedef uint8_t (* mcap_remote_mdl_reconn_req_cb) (struct mcap_mdl *mdl,
 /* mcl callbacks */
 
 typedef void (* mcap_mcl_event_cb) (struct mcap_mcl *mcl, gpointer data);
+typedef void (* mcap_mcl_connect_cb) (struct mcap_mcl *mcl, GError *err,
+								gpointer data);
 
 /************ Operations ************/
 
+/* Mcl operations*/
+
+void mcap_create_mcl(struct mcap_instance *ms,
+				const bdaddr_t *addr,
+				uint16_t ccpsm,
+				mcap_mcl_connect_cb connect_cb,
+				gpointer user_data,
+				GError **err);
+void mcap_close_mcl(struct mcap_mcl *mcl, gboolean cache);
+void mcap_mcl_set_cb(struct mcap_mcl *mcl, gpointer user_data, GError **gerr,
+							McapMclCb cb1, ...);
+void mcap_mcl_get_addr(struct mcap_mcl *mcl, bdaddr_t *addr);
+
 struct mcap_mcl *mcap_mcl_ref(struct mcap_mcl *mcl);
 void mcap_mcl_unref(struct mcap_mcl *mcl);
 
-- 
1.6.3.3

