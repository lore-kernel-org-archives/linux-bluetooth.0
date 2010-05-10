Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot Nemesio <sancane@gmail.com>
Subject: [PATCH 14/25] Support for managing creation of data channels
Date: Mon, 10 May 2010 12:15:16 +0200
Message-Id: <1273486527-7855-14-git-send-email-sancane@gmail.com>
In-Reply-To: <1273486527-7855-13-git-send-email-sancane@gmail.com>
References: <1273486527-7855-1-git-send-email-sancane@gmail.com>
 <1273486527-7855-2-git-send-email-sancane@gmail.com>
 <1273486527-7855-3-git-send-email-sancane@gmail.com>
 <1273486527-7855-4-git-send-email-sancane@gmail.com>
 <1273486527-7855-5-git-send-email-sancane@gmail.com>
 <1273486527-7855-6-git-send-email-sancane@gmail.com>
 <1273486527-7855-7-git-send-email-sancane@gmail.com>
 <1273486527-7855-8-git-send-email-sancane@gmail.com>
 <1273486527-7855-9-git-send-email-sancane@gmail.com>
 <1273486527-7855-10-git-send-email-sancane@gmail.com>
 <1273486527-7855-11-git-send-email-sancane@gmail.com>
 <1273486527-7855-12-git-send-email-sancane@gmail.com>
 <1273486527-7855-13-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Santiago Carot Nemesio <sancane@gmail.com>

---
 mcap/mcap.c |  172 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 171 insertions(+), 1 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 6d548b9..3d442d1 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -49,6 +49,18 @@ struct connect_mcl {
 	gpointer		user_data;	/* Callback user data */
 };
 
+typedef union {
+	mcap_mdl_operation_cb 		op;
+	mcap_mdl_operation_conf_cb	op_conf;
+	mcap_mdl_del_cb			del;
+} mcap_cb_type;
+
+struct mcap_mdl_op_cb {
+	struct mcap_mdl		*mdl;		/* MDL for this operation */
+	mcap_cb_type		cb;		/* Operation callback */
+	gpointer		user_data;	/* Callback user data */
+};
+
 /* MCAP finite state machine functions */
 static void proc_req_connected(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len);
 static void proc_req_pending(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len);
@@ -179,6 +191,38 @@ static void set_default_cb(struct mcap_mcl *mcl)
 	mcl->cb->mdl_reconn_req = default_mdl_reconn_req_cb;
 }
 
+static char *error2str(uint8_t rc)
+{
+	switch (rc) {
+	case MCAP_SUCCESS:
+		return "Success";
+	case MCAP_INVALID_OP_CODE:
+		return "Invalid Op Code";
+	case MCAP_INVALID_PARAM_VALUE:
+		return "Ivalid Parameter Value";
+	case MCAP_INVALID_MDEP:
+		return "Invalid MDEP";
+	case MCAP_MDEP_BUSY:
+		return "MDEP Busy";
+	case MCAP_INVALID_MDL:
+		return "Invalid MDL";
+	case MCAP_MDL_BUSY:
+		return "MDL Busy";
+	case MCAP_INVALID_OPERATION:
+		return "Invalid Operation";
+	case MCAP_RESOURCE_UNAVAILABLE:
+		return "Resource Unavailable";
+	case MCAP_UNESPECIFIED_ERROR:
+		return "Unspecified Error";
+	case MCAP_REQUEST_NOT_SUPPORTED:
+		return "Request Not Supported";
+	case MCAP_CONFIGURATION_REJECTED:
+		return "Configuration Rejected";
+	default:
+		return "Unknown Response Code";
+	}
+}
+
 static void update_mcl_state(struct mcap_mcl *mcl)
 {
 	GSList *l;
@@ -833,6 +877,86 @@ static void proc_cmd(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 		proc_req[mcl->state](mcl, cmd, len);
 }
 
+static gboolean mdl_event_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
+{
+
+	struct mcap_mdl *mdl = data;
+	gboolean notify;
+
+	debug("Close MDL %d", mdl->mdlid);
+
+	notify = (mdl->state == MDL_CONNECTED);
+	shutdown_mdl(mdl);
+
+	update_mcl_state(mdl->mcl);
+
+	if (notify)
+		/*Callback to upper layer */
+		mdl->mcl->cb->mdl_closed(mdl, mdl->mcl->cb->user_data);
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
+	debug("mdl connect callback");
+
+	if (conn_err) {
+		debug("ERROR: mdl connect callback");
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
+void mcap_mdl_connect(struct mcap_mdl *mdl, BtIOType BtType, uint16_t dcpsm,
+	GError **err, mcap_mdl_operation_cb connect_cb, gpointer user_data)
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
+		debug("MDL Connection error");
+		mdl->state = MDL_CLOSED;
+		g_free(con);
+	}
+}
+
 static gboolean mcl_control_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
 {
 
@@ -916,6 +1040,20 @@ static void mcap_connect_mcl_cb(GIOChannel *chan, GError *conn_err,
 	}
 }
 
+static void connect_dc_event_cb(GIOChannel *chan, GError *err, gpointer user_data)
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
 void mcap_create_mcl(struct mcap_session *ms,
 				const bdaddr_t *addr,
 				uint16_t ccpsm,
@@ -968,7 +1106,39 @@ void mcap_create_mcl(struct mcap_session *ms,
 
 static void confirm_dc_event_cb(GIOChannel *chan, gpointer user_data)
 {
-	/* TODO: Check if we can connect this data channel */
+	struct mcap_session *ms = user_data;
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
+	if (!mcl || (mcl->state != MCL_PENDING))
+		goto drop;
+
+	for (l = mcl->mdls; l; l = l->next) {
+		mdl = l->data;
+		if (mdl->state == MDL_WAITING) {
+			if (!bt_io_accept(chan, connect_dc_event_cb, mdl, NULL,
+									&err)) {
+				error("MDL accept error %s", err->message);
+				g_error_free(err);
+				goto drop;
+			}
+			return;
+		}
+	}
+drop:
 	g_io_channel_shutdown(chan, TRUE, NULL);
 }
 
-- 
1.6.3.3

