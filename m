Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 50/60] Check control channel before calling to g_io_channel_unix_get_fd
Date: Thu, 22 Jul 2010 10:58:07 +0200
Message-Id: <1279789097-2420-2-git-send-email-sancane@gmail.com>
In-Reply-To: <1279789097-2420-1-git-send-email-sancane@gmail.com>
References: <1279789001-4587-30-git-send-email-santoscadenas@gmail.com>
 <1279789097-2420-1-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Glib does not return file descriptor -1 when a NULL pointer is passed
as parameter in g_io_channel_unix_get_fd function. Pointer parameter
is deferrence in glib without checking NULL
---
 mcap/mcap.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index e8a93a1..e89b720 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -312,7 +312,7 @@ static int send4B_cmd(struct mcap_mcl *mcl, uint8_t oc, uint8_t rc,
 {
 	uint8_t *rsp;
 	mcap4B_rsp *rsp_err;
-	int sent;
+	int sent = -1;
 
 
 	rsp = g_malloc0(sizeof(mcap4B_rsp));
@@ -322,9 +322,9 @@ static int send4B_cmd(struct mcap_mcl *mcl, uint8_t oc, uint8_t rc,
 	rsp_err->rc = rc;
 	rsp_err->mdl = htons (mdl);
 
-	sent = mcap_send_data(g_io_channel_unix_get_fd(mcl->cc),
-					rsp,
-					sizeof(mcap4B_rsp));
+	if (mcl->cc)
+		sent = mcap_send_data(g_io_channel_unix_get_fd(mcl->cc), rsp,
+							sizeof(mcap4B_rsp));
 	g_free(rsp);
 	return sent;
 }
@@ -334,7 +334,7 @@ static int send5B_cmd(struct mcap_mcl *mcl, uint8_t oc, uint8_t rc,
 {
 	uint8_t *rsp;
 	mcap5B_rsp *suc;
-	int sent;
+	int sent = -1;
 
 	rsp = g_malloc0(sizeof(mcap5B_rsp));
 
@@ -344,7 +344,8 @@ static int send5B_cmd(struct mcap_mcl *mcl, uint8_t oc, uint8_t rc,
 	suc->mdl = htons(mdl);
 	suc->param = param;
 
-	sent = mcap_send_data(g_io_channel_unix_get_fd(mcl->cc), rsp,
+	if (mcl->cc)
+		sent = mcap_send_data(g_io_channel_unix_get_fd(mcl->cc), rsp,
 							sizeof(mcap5B_rsp));
 	g_free(rsp);
 	return sent;
@@ -962,6 +963,7 @@ static void mcap_delete_mdl(gpointer elem, gpointer user_data)
 	shutdown_mdl(mdl);
 	if (notify)
 		mdl->mcl->cb->mdl_deleted(mdl, mdl->mcl->cb->user_data);
+
 	g_free(mdl);
 }
 
@@ -1187,6 +1189,7 @@ static void process_md_delete_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 	update_mcl_state(mcl);
 	notify = TRUE;
 	mcap_delete_mdl(mdl, &notify);
+
 resp:
 	send4B_cmd(mcl, MCAP_MD_DELETE_MDL_RSP, MCAP_SUCCESS, mdlid);
 }
-- 
1.6.3.3

