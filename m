Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot Nemesio <sancane@gmail.com>
Subject: [PATCH 07/25] Initiate creation of MCLs
Date: Mon, 10 May 2010 12:15:09 +0200
Message-Id: <1273486527-7855-7-git-send-email-sancane@gmail.com>
In-Reply-To: <1273486527-7855-6-git-send-email-sancane@gmail.com>
References: <1273486527-7855-1-git-send-email-sancane@gmail.com>
 <1273486527-7855-2-git-send-email-sancane@gmail.com>
 <1273486527-7855-3-git-send-email-sancane@gmail.com>
 <1273486527-7855-4-git-send-email-sancane@gmail.com>
 <1273486527-7855-5-git-send-email-sancane@gmail.com>
 <1273486527-7855-6-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Santiago Carot Nemesio <sancane@gmail.com>

---
 mcap/mcap.c |  115 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 115 insertions(+), 0 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index ebfaf9e..0112154 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -43,6 +43,12 @@
 	__mcl->tid = 0;			\
 } while(0)
 
+struct connect_mcl {
+	struct mcap_mcl		*mcl;		/* MCL for this operation */
+	mcap_mcl_connect_cb	connect_cb;	/* Connect callback */
+	gpointer		user_data;	/* Callback user data */
+};
+
 /* MCAP finite state machine functions */
 static void proc_req_connected(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len);
 static void proc_req_pending(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len);
@@ -419,6 +425,115 @@ fail:
 	return FALSE;
 }
 
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
+	mcl->wid = g_io_add_watch(mcl->cc, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+				(GIOFunc) mcl_control_cb, mcl);
+	connect_cb(mcl, gerr, data);
+
+	if (mcl->ref == 1) {
+		mcl->ms->mcls = g_slist_remove(mcl->ms->mcls, mcl);
+		mcap_mcl_unref(mcl);
+	}
+}
+
+void mcap_create_mcl(struct mcap_session *ms,
+				const bdaddr_t *addr,
+				uint16_t ccpsm,
+				GError **err,
+				mcap_mcl_connect_cb connect_cb,
+				gpointer user_data)
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
 	/* TODO: Check if we can connect this data channel */
-- 
1.6.3.3

