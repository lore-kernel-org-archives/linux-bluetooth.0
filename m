Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 03/16] Receive MCAP mcl connections from remote devices
Date: Wed, 28 Jul 2010 10:00:12 +0200
Message-Id: <1280304015-9230-4-git-send-email-sancane@gmail.com>
In-Reply-To: <1280304015-9230-3-git-send-email-sancane@gmail.com>
References: <1280304015-9230-1-git-send-email-sancane@gmail.com>
 <1280304015-9230-2-git-send-email-sancane@gmail.com>
 <1280304015-9230-3-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/mcap.c          |  209 +++++++++++++++++++++++++++++++++++++++++++++++-
 health/mcap.h          |   21 +++++
 health/mcap_internal.h |   52 ++++++++++++
 health/mcap_lib.h      |   15 ++++
 4 files changed, 295 insertions(+), 2 deletions(-)

diff --git a/health/mcap.c b/health/mcap.c
index 54e6355..282580d 100644
--- a/health/mcap.c
+++ b/health/mcap.c
@@ -38,24 +38,229 @@
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
 static void mcap_mcl_shutdown(struct mcap_mcl *mcl)
 {
 	/* TODO: implement mcap_mcl_shutdown */
 }
 
+static void mcap_mcl_release(struct mcap_mcl *mcl)
+{
+	/* TODO: implement mcap_mcl_release */
+}
+
+static void mcap_mcl_check_del(struct mcap_mcl *mcl)
+{
+	if (mcl->ctrl & MCAP_CTRL_CACHED)
+		mcap_mcl_shutdown(mcl);
+	else
+		mcap_mcl_unref(mcl);
+}
+
+static void mcap_uncache_mcl(struct mcap_mcl *mcl)
+{
+	if (!(mcl->ctrl & MCAP_CTRL_CACHED))
+		return;
+
+	DBG("Got MCL from cache");
+
+	mcl->ms->cached = g_slist_remove(mcl->ms->cached, mcl);
+	mcl->ms->mcls = g_slist_prepend(mcl->ms->mcls, mcl);
+	mcl->ctrl &= ~MCAP_CTRL_CACHED;
+	mcl->ctrl &= ~MCAP_CTRL_FREE;
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
 void mcap_mcl_unref(struct mcap_mcl *mcl)
 {
-	/* TODO: implement mcap_mcl_unref */
+	mcl->ref--;
+
+	DBG("mcap_mcl_unref(%p): ref=%d", mcl, mcl->ref);
+
+	if ((mcl->ctrl & MCAP_CTRL_CACHED) && (mcl->ref < 2)) {
+		/* Free space in cache memory due any other profile has a local
+		 * copy of current MCL stored in cache */
+		DBG("Remove from cache (%p): ref=%d", mcl, mcl->ref);
+		mcl->ms->cached = g_slist_remove(mcl->ms->cached, mcl);
+		mcap_mcl_release(mcl);
+		return;
+	}
+
+	if (mcl->ref > 0)
+		return;
+
+	mcap_mcl_release(mcl);
 }
 
+static gboolean mcl_control_cb(GIOChannel *chan, GIOCondition cond,
+								gpointer data)
+{
+	/* TODO: Create mcl_control_cb */
+	return FALSE;
+}
 static void confirm_dc_event_cb(GIOChannel *chan, gpointer user_data)
 {
 	/* TODO: implement confirm_dc_event_cb */
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
-	/* TODO: implement confirm_mcl_event_cb */
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
+		mcl->next_mdl = (rand() % MCAP_MDLID_FINAL) + 1;
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
diff --git a/health/mcap.h b/health/mcap.h
index 139b562..a45cc8a 100644
--- a/health/mcap.h
+++ b/health/mcap.h
@@ -35,6 +35,27 @@ extern "C" {
 #define MCAP_CC_MTU	48
 #define MCAP_DC_MTU	L2CAP_DEFAULT_MTU
 
+/* MCAP Response codes */
+#define MCAP_SUCCESS			0x00
+#define MCAP_INVALID_OP_CODE		0x01
+#define MCAP_INVALID_PARAM_VALUE	0x02
+#define MCAP_INVALID_MDEP		0x03
+#define MCAP_MDEP_BUSY			0x04
+#define MCAP_INVALID_MDL		0x05
+#define MCAP_MDL_BUSY			0x06
+#define MCAP_INVALID_OPERATION		0x07
+#define MCAP_RESOURCE_UNAVAILABLE	0x08
+#define MCAP_UNSPECIFIED_ERROR		0x09
+#define MCAP_REQUEST_NOT_SUPPORTED	0x0A
+#define MCAP_CONFIGURATION_REJECTED	0x0B
+
+/* MDL IDs */
+#define MCAP_MDLID_RESERVED		0x0000
+#define MCAP_MDLID_INITIAL		0x0001
+#define MCAP_MDLID_FINAL		0xFEFF
+#define MCAP_ALL_MDLIDS			0xFFFF
+
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/health/mcap_internal.h b/health/mcap_internal.h
index ed4ed58..aab9e06 100644
--- a/health/mcap_internal.h
+++ b/health/mcap_internal.h
@@ -31,6 +31,33 @@
 extern "C" {
 #endif
 
+typedef enum {
+	MCL_CONNECTED,
+	MCL_PENDING,
+	MCL_ACTIVE,
+	MCL_IDLE
+} MCLState;
+
+typedef enum {
+	MCL_ACCEPTOR,
+	MCL_INITIATOR
+} MCLRole;
+
+typedef enum {
+	MCL_AVAILABLE,
+	MCL_WAITING_RSP
+} MCAPCtrl;
+
+struct mcap_mdl_cb {
+	mcap_mdl_event_cb 		mdl_connected;	/* Remote device has created a MDL */
+	mcap_mdl_event_cb 		mdl_closed;	/* Remote device has closed a MDL */
+	mcap_mdl_event_cb 		mdl_deleted;	/* Remote device requested deleting a MDL */
+	mcap_mdl_event_cb		mdl_aborted;	/* Remote device aborted the mdl creation */
+	mcap_remote_mdl_conn_req_cb	mdl_conn_req;	/* Remote device requested creating a MDL */
+	mcap_remote_mdl_reconn_req_cb 	mdl_reconn_req;	/* Remote device requested reconnecting a MDL */
+	gpointer			user_data;	/* User data */
+};
+
 struct mcap_instance {
 	bdaddr_t		src;			/* Source address */
 	GIOChannel		*ccio;			/* Control Channel IO */
@@ -45,6 +72,31 @@ struct mcap_instance {
 	gpointer		user_data;		/* Data to be provided in callbacks */
 };
 
+struct mcap_mcl {
+	struct mcap_instance	*ms;		/* MCAP instance where this MCL belongs */
+	bdaddr_t		addr;		/* Device address */
+	GIOChannel		*cc;		/* MCAP Control Channel IO */
+	guint			wid;		/* MCL Watcher id */
+	GSList			*mdls;		/* List of Data Channels shorted by mdlid */
+	MCLState		state;		/* Current MCL State */
+	MCLRole			role;		/* Initiator or acceptor of this MCL */
+	MCAPCtrl		req;		/* Request control flag */
+	void			*priv_data;	/* Temporal data to manage in responses */
+	struct mcap_mdl_cb	*cb;		/* MDL callbacks */
+	guint			tid;		/* Timer id for waiting for a response */
+	uint8_t			*lcmd;		/* Last command sent */
+	guint			ref;		/* References counter */
+	uint8_t			ctrl;		/* MCL control flag */
+	uint16_t		next_mdl;	/* id used to create next MDL */
+};
+
+#define	MCAP_CTRL_CACHED	0x01	/* MCL is cached */
+#define	MCAP_CTRL_STD_OP	0x02	/* Support for standard op codes */
+#define	MCAP_CTRL_SYNC_OP	0x04	/* Support for synchronization commands */
+#define	MCAP_CTRL_CONN		0x08	/* MCL is in connecting process */
+#define	MCAP_CTRL_FREE		0x10	/* MCL is marked as releasable */
+#define	MCAP_CTRL_NOCACHE	0x20	/* MCL is marked as not cacheable */
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/health/mcap_lib.h b/health/mcap_lib.h
index 81d8b14..fcf69ee 100644
--- a/health/mcap_lib.h
+++ b/health/mcap_lib.h
@@ -58,15 +58,30 @@ typedef enum {
 
 struct mcap_instance;
 struct mcap_mcl;
+struct mcap_mdl;
 
 /************ Callbacks ************/
 
+/* mdl callbacks */
+
+typedef void (* mcap_mdl_event_cb) (struct mcap_mdl *mdl, gpointer data);
+
+/* Next function should return an MCAP appropriate response code */
+typedef uint8_t (* mcap_remote_mdl_conn_req_cb) (struct mcap_mcl *mcl,
+						uint8_t mdepid, uint16_t mdlid,
+						uint8_t *conf, gpointer data);
+typedef uint8_t (* mcap_remote_mdl_reconn_req_cb) (struct mcap_mdl *mdl,
+						gpointer data);
+
 /* mcl callbacks */
 
 typedef void (* mcap_mcl_event_cb) (struct mcap_mcl *mcl, gpointer data);
 
 /************ Operations ************/
 
+struct mcap_mcl *mcap_mcl_ref(struct mcap_mcl *mcl);
+void mcap_mcl_unref(struct mcap_mcl *mcl);
+
 /* MCAP main operations */
 
 struct mcap_instance *mcap_create_instance(struct btd_adapter *btd_adapter,
-- 
1.6.3.3

