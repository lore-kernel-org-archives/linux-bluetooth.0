Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot Nemesio <sancane@gmail.com>
Subject: [PATCH 09/25] Add functions to set callbacks in an MCL.
Date: Mon, 10 May 2010 12:15:11 +0200
Message-Id: <1273486527-7855-9-git-send-email-sancane@gmail.com>
In-Reply-To: <1273486527-7855-8-git-send-email-sancane@gmail.com>
References: <1273486527-7855-1-git-send-email-sancane@gmail.com>
 <1273486527-7855-2-git-send-email-sancane@gmail.com>
 <1273486527-7855-3-git-send-email-sancane@gmail.com>
 <1273486527-7855-4-git-send-email-sancane@gmail.com>
 <1273486527-7855-5-git-send-email-sancane@gmail.com>
 <1273486527-7855-6-git-send-email-sancane@gmail.com>
 <1273486527-7855-7-git-send-email-sancane@gmail.com>
 <1273486527-7855-8-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Santiago Carot Nemesio <sancane@gmail.com>

Also, this commit enable to retrieve information from MCAP sessions
and from MCLs
---
 mcap/mcap.c |  118 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 118 insertions(+), 0 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 8f6fb78..3a4b2b9 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -343,6 +343,88 @@ void mcap_mcl_unref(struct mcap_mcl *mcl)
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
+				"Unknown option %d", cb);
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
+void mcap_mcl_set_cb(struct mcap_mcl *mcl, GError **gerr,
+					gpointer user_data, McapMclCb cb1, ...)
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
+bdaddr_t mcap_mcl_get_addr(struct mcap_mcl *mcl)
+{
+	return mcl->addr;
+}
+
 /* Function used to process commands depending of MCL state */
 
 static void proc_req_connected(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
@@ -748,3 +830,39 @@ void mcap_close_session(struct mcap_session *ms)
 
 	g_free(ms);
 }
+
+uint16_t mcap_get_ctrl_psm(struct mcap_session *ms, GError **err)
+{
+	uint16_t lpsm;
+
+	if (!(ms && ms->ccio)) {
+		g_set_error(err, MCAP_ERROR, MCAP_ERROR_INVALID_ARGS,
+			"Invalid MCAP session");
+		return 0;
+	}
+
+	bt_io_get(ms->ccio, BT_IO_L2CAP, err,
+			BT_IO_OPT_PSM, &lpsm,
+			BT_IO_OPT_INVALID);
+	if (*err)
+		return 0;
+	return lpsm;
+}
+
+uint16_t mcap_get_data_psm(struct mcap_session *ms, GError **err)
+{
+	uint16_t lpsm;
+
+	if (!(ms && ms->dcio)) {
+		g_set_error(err, MCAP_ERROR, MCAP_ERROR_INVALID_ARGS,
+			"Invalid MCAP session");
+		return 0;
+	}
+
+	bt_io_get(ms->dcio, BT_IO_L2CAP, err,
+			BT_IO_OPT_PSM, &lpsm,
+			BT_IO_OPT_INVALID);
+	if (*err)
+		return 0;
+	return lpsm;
+}
-- 
1.6.3.3

