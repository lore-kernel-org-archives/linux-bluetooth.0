Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 14/25] Implement set callbacks operation over MCLs
Date: Fri, 14 May 2010 12:19:41 +0200
Message-Id: <1273832392-18654-14-git-send-email-sancane@gmail.com>
In-Reply-To: <1273832392-18654-13-git-send-email-sancane@gmail.com>
References: <1273832392-18654-1-git-send-email-sancane@gmail.com>
 <1273832392-18654-2-git-send-email-sancane@gmail.com>
 <1273832392-18654-3-git-send-email-sancane@gmail.com>
 <1273832392-18654-4-git-send-email-sancane@gmail.com>
 <1273832392-18654-5-git-send-email-sancane@gmail.com>
 <1273832392-18654-6-git-send-email-sancane@gmail.com>
 <1273832392-18654-7-git-send-email-sancane@gmail.com>
 <1273832392-18654-8-git-send-email-sancane@gmail.com>
 <1273832392-18654-9-git-send-email-sancane@gmail.com>
 <1273832392-18654-10-git-send-email-sancane@gmail.com>
 <1273832392-18654-11-git-send-email-sancane@gmail.com>
 <1273832392-18654-12-git-send-email-sancane@gmail.com>
 <1273832392-18654-13-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mcap/mcap.c |   82 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 82 insertions(+), 0 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index bbbcf2b..dfcce82 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -398,6 +398,88 @@ void mcap_mcl_unref(struct mcap_mcl *mcl)
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
 static void error_cmd_rsp(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 {
 	uint16_t mdlr;
-- 
1.6.3.3

