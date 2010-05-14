Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 12/25] Managing connection of Data Channels
Date: Fri, 14 May 2010 12:19:39 +0200
Message-Id: <1273832392-18654-12-git-send-email-sancane@gmail.com>
In-Reply-To: <1273832392-18654-11-git-send-email-sancane@gmail.com>
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
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mcap/mcap.c |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 69 insertions(+), 1 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index dfa455f..7f9f508 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -755,6 +755,26 @@ static void proc_cmd(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
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
 static gboolean mcl_control_cb(GIOChannel *chan, GIOCondition cond,
 								gpointer data)
 {
@@ -780,9 +800,57 @@ fail:
 	return FALSE;
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
 static void confirm_dc_event_cb(GIOChannel *chan, gpointer user_data)
 {
-	/* TODO */
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
+	g_io_channel_shutdown(chan, TRUE, NULL);
 }
 
 static void connect_mcl_event_cb(GIOChannel *chan, GError *err,
-- 
1.6.3.3

