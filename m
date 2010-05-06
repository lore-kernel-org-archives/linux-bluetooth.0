Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH] MCAP: Added default abort callback
Date: Thu,  6 May 2010 10:21:43 +0200
Message-Id: <1273134103-9592-1-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1272962595-4108-1-git-send-email-sancane@gmail.com>
References: <1272962595-4108-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Also check if mcl was closed during a callback
---
 mcap/mcap.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 5068054..404d7be 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -183,6 +183,10 @@ static void default_mdl_deleted_cb(struct mcap_mdl *mdl, gpointer data)
 {
 	debug("MCAP Unmanaged mdl deleted");
 }
+static void default_mdl_aborted_cb(struct mcap_mdl *mdl, gpointer data)
+{
+	debug("MCAP Unmanaged mdl aborted");
+}
 static uint8_t default_mdl_conn_req_cb(struct mcap_mcl *mcl,
 						uint8_t mdepid, uint16_t mdlid,
 						uint8_t *conf, gpointer data)
@@ -207,6 +211,7 @@ static void set_default_cb(struct mcap_mcl *mcl)
 	mcl->cb->mdl_connected = default_mdl_connected_cb;
 	mcl->cb->mdl_closed = default_mdl_closed_cb;
 	mcl->cb->mdl_deleted = default_mdl_deleted_cb;
+	mcl->cb->mdl_aborted = default_mdl_aborted_cb;
 	mcl->cb->mdl_conn_req = default_mdl_conn_req_cb;
 	mcl->cb->mdl_reconn_req = default_mdl_reconn_req_cb;
 }
@@ -1045,11 +1050,13 @@ static void process_md_create_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd, uint32
 	/* Callback to upper layer */
 	rsp = mcl->cb->mdl_conn_req(mcl, mdep_id, mdl_id, &conf,
 							mcl->cb->user_data);
+	if (mcl->state == MCL_IDLE)
+		return;
 
 	if ((cfga != 0) && (cfga != conf)) {
 		/* Remote device set default configuration but upper profile */
 		/* has changed it. Protocol Error: force closing the MCL by */
-		/* using remote device using UNESPECIFIED_ERROR response */
+		/* remote device using UNESPECIFIED_ERROR response */
 		send4B_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, MCAP_UNESPECIFIED_ERROR,
 								mdl_id);
 		return;
@@ -1102,6 +1109,9 @@ static void process_md_reconnect_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 
 	/* Callback to upper layer */
 	rsp = mcl->cb->mdl_reconn_req(mdl, mcl->cb->user_data);
+	if (mcl->state == MCL_IDLE)
+		return;
+
 	if (rsp != MCAP_SUCCESS) {
 		send4B_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, rsp, mdl_id);
 		return;
@@ -1734,12 +1744,7 @@ static gboolean mcl_control_cb(GIOChannel *chan, GIOCondition cond, gpointer dat
 	int sk, len;
 	uint8_t buf[MCAP_CC_MTU];
 
-	if (cond & G_IO_NVAL) {
-		error("Revise G_IO_NVAL");
-		goto fail;
-	}
-
-	if (cond & (G_IO_ERR | G_IO_HUP))
+	if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL))
 		goto fail;
 
 	sk = g_io_channel_unix_get_fd(chan);
-- 
1.7.0.4

