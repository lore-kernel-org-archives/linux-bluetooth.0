Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 24/25] Enable connection of Data Channel with remote MCAP instances
Date: Fri, 14 May 2010 12:19:51 +0200
Message-Id: <1273832392-18654-24-git-send-email-sancane@gmail.com>
In-Reply-To: <1273832392-18654-23-git-send-email-sancane@gmail.com>
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
 <1273832392-18654-14-git-send-email-sancane@gmail.com>
 <1273832392-18654-15-git-send-email-sancane@gmail.com>
 <1273832392-18654-16-git-send-email-sancane@gmail.com>
 <1273832392-18654-17-git-send-email-sancane@gmail.com>
 <1273832392-18654-18-git-send-email-sancane@gmail.com>
 <1273832392-18654-19-git-send-email-sancane@gmail.com>
 <1273832392-18654-20-git-send-email-sancane@gmail.com>
 <1273832392-18654-21-git-send-email-sancane@gmail.com>
 <1273832392-18654-22-git-send-email-sancane@gmail.com>
 <1273832392-18654-23-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mcap/mcap.c |   60 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index a08e631..6c98124 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -1558,6 +1558,66 @@ static gboolean mdl_event_cb(GIOChannel *chan, GIOCondition cond, gpointer data)
 	return FALSE;
 }
 
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
 static gboolean mcl_control_cb(GIOChannel *chan, GIOCondition cond,
 								gpointer data)
 {
-- 
1.6.3.3

