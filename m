Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 09/16] Implement connection of MCAP data links (MDL's)
Date: Wed, 28 Jul 2010 10:03:49 +0200
Message-Id: <1280304232-2939-3-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1280304232-2939-2-git-send-email-santoscadenas@gmail.com>
References: <1280304015-9230-7-git-send-email-sancane@gmail.com>
 <1280304232-2939-1-git-send-email-santoscadenas@gmail.com>
 <1280304232-2939-2-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 health/mcap.c     |  132 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 health/mcap_lib.h |    6 ++
 2 files changed, 137 insertions(+), 1 deletions(-)

diff --git a/health/mcap.c b/health/mcap.c
index 734c6be..ecaa43f 100644
--- a/health/mcap.c
+++ b/health/mcap.c
@@ -1097,6 +1097,87 @@ static void proc_cmd(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 		proc_req[mcl->state](mcl, cmd, len);
 }
 
+static gboolean mdl_event_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
+{
+
+	struct mcap_mdl *mdl = data;
+	gboolean notify;
+
+	DBG("Close MDL %d", mdl->mdlid);
+
+	notify = (mdl->state == MDL_CONNECTED);
+	shutdown_mdl(mdl);
+
+	update_mcl_state(mdl->mcl);
+
+	if (notify) {
+		/*Callback to upper layer */
+		mdl->mcl->cb->mdl_closed(mdl, mdl->mcl->cb->user_data);
+	}
+
+	return FALSE;
+}
+
+static void mcap_connect_mdl_cb(GIOChannel *chan, GError *conn_err,
+							gpointer data)
+{
+	struct mcap_mdl_op_cb *con = data;
+	struct mcap_mdl *mdl = con->mdl;
+	mcap_mdl_operation_cb cb = con->cb.op;
+	gpointer user_data = con->user_data;
+
+	g_free(con);
+	DBG("mdl connect callback");
+
+	if (conn_err) {
+		DBG("ERROR: mdl connect callback");
+		mdl->state = MDL_CLOSED;
+		g_io_channel_unref(mdl->dc);
+		mdl->dc = NULL;
+		cb(mdl, conn_err, user_data);
+		return;
+	}
+
+	mdl->state = MDL_CONNECTED;
+	mdl->wid = g_io_add_watch(mdl->dc, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+				(GIOFunc) mdl_event_cb, mdl);
+
+	cb(mdl, conn_err, user_data);
+}
+
+void mcap_connect_mdl(struct mcap_mdl *mdl, BtIOType BtType, uint16_t dcpsm,
+	mcap_mdl_operation_cb connect_cb, gpointer user_data, GError **err)
+{
+	struct mcap_mdl_op_cb *con;
+
+	if (mdl->state != MDL_WAITING) {
+		g_set_error(err, MCAP_ERROR, MCAP_ERROR_INVALID_MDL,
+					"%s", error2str(MCAP_INVALID_MDL));
+		return;
+	}
+
+	con = g_new0(struct mcap_mdl_op_cb, 1);
+	con->mdl = mdl;
+	con->cb.op = connect_cb;
+	con->user_data = user_data;
+
+	/* TODO: Check if BtIOType is ERTM or Streaming before continue */
+
+	mdl->dc = bt_io_connect(BtType, mcap_connect_mdl_cb, con,
+				NULL, err,
+				BT_IO_OPT_SOURCE_BDADDR, &mdl->mcl->ms->src,
+				BT_IO_OPT_DEST_BDADDR, &mdl->mcl->addr,
+				BT_IO_OPT_PSM, dcpsm,
+				BT_IO_OPT_MTU, MCAP_DC_MTU,
+				BT_IO_OPT_SEC_LEVEL, mdl->mcl->ms->sec,
+				BT_IO_OPT_INVALID);
+	if (*err) {
+		DBG("MDL Connection error");
+		mdl->state = MDL_CLOSED;
+		g_free(con);
+	}
+}
+
 static gboolean mcl_control_cb(GIOChannel *chan, GIOCondition cond,
 								gpointer data)
 {
@@ -1191,6 +1272,21 @@ static void mcap_connect_mcl_cb(GIOChannel *chan, GError *conn_err,
 	}
 }
 
+static void connect_dc_event_cb(GIOChannel *chan, GError *err,
+							gpointer user_data)
+{
+	struct mcap_mdl *mdl = user_data;
+	struct mcap_mcl *mcl = mdl->mcl;
+
+	mdl->state = MDL_CONNECTED;
+	mdl->dc = g_io_channel_ref(chan);
+	mdl->wid = g_io_add_watch(mdl->dc, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+						(GIOFunc) mdl_event_cb, mdl);
+
+	mcl->state = MCL_ACTIVE;
+	mcl->cb->mdl_connected(mdl, mcl->cb->user_data);
+}
+
 void mcap_create_mcl(struct mcap_instance *ms,
 				const bdaddr_t *addr,
 				uint16_t ccpsm,
@@ -1244,7 +1340,41 @@ void mcap_create_mcl(struct mcap_instance *ms,
 
 static void confirm_dc_event_cb(GIOChannel *chan, gpointer user_data)
 {
-	/* TODO: implement confirm_dc_event_cb */
+	struct mcap_instance *ms = user_data;
+	struct mcap_mcl *mcl;
+	struct mcap_mdl *mdl;
+	GError *err = NULL;
+	bdaddr_t dst;
+	GSList *l;
+
+	bt_io_get(chan, BT_IO_L2CAP, &err,
+			BT_IO_OPT_DEST_BDADDR, &dst,
+			BT_IO_OPT_INVALID);
+	if (err) {
+		error("%s", err->message);
+		g_error_free(err);
+		goto drop;
+	}
+
+	mcl = find_mcl(ms->mcls, &dst);
+	if (!mcl || mcl->state != MCL_PENDING)
+		goto drop;
+
+	for (l = mcl->mdls; l; l = l->next) {
+		mdl = l->data;
+		if (mdl->state == MDL_WAITING) {
+			if (!bt_io_accept(chan, connect_dc_event_cb, mdl, NULL,
+									&err)) {
+				error("MDL accept error %s", err->message);
+				mdl->state = MDL_CLOSED;
+				g_error_free(err);
+				goto drop;
+			}
+			return;
+		}
+	}
+drop:
+	g_io_channel_shutdown(chan, TRUE, NULL);
 }
 
 static void connect_mcl_event_cb(GIOChannel *chan, GError *err,
diff --git a/health/mcap_lib.h b/health/mcap_lib.h
index d8fb863..7bdcbc5 100644
--- a/health/mcap_lib.h
+++ b/health/mcap_lib.h
@@ -104,6 +104,12 @@ void mcap_create_mdl(struct mcap_mcl *mcl,
 				mcap_mdl_operation_conf_cb connect_cb,
 				gpointer user_data,
 				GError **err);
+void mcap_connect_mdl(struct mcap_mdl *mdl,
+				BtIOType BtType,
+				uint16_t dcpsm,
+				mcap_mdl_operation_cb connect_cb,
+				gpointer user_data,
+				GError **err);
 
 /* Mcl operations*/
 
-- 
1.7.0.4

