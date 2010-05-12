Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot Nemesio <sancane@gmail.com>
Subject: [PATCH 20/25] Prepare MCAP library to process responses to standard op. codes
Date: Wed, 12 May 2010 12:00:29 +0200
Message-Id: <1273658429-17770-1-git-send-email-sancane@gmail.com>
In-Reply-To: <1273486527-7855-20-git-send-email-sancane@gmail.com>
References: <1273486527-7855-20-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Santiago Carot Nemesio <sancane@gmail.com>

---
 mcap/mcap.c |   81 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 80 insertions(+), 1 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 2554cd9..5b53ee8 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -1161,9 +1161,88 @@ static void proc_req_active(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 	}
 }
 
+static gboolean check_rsp(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
+{
+	mcap4B_rsp *rsp;
+	GError *gerr = NULL;
+
+	/* Check if the response matches with the last request */
+	if ((cmd[0] != MCAP_ERROR_RSP) && ((mcl->lcmd[0] + 1) != cmd[0]))
+		goto close_mcl;
+
+	if (len < 4)
+		goto close_mcl;
+
+	rsp = (mcap4B_rsp *)cmd;
+
+	if (rsp->rc == MCAP_REQUEST_NOT_SUPPORTED) {
+		debug("Remote does not support opcodes");
+		g_set_error(&gerr, MCAP_ERROR, MCAP_ERROR_REQUEST_NOT_SUPPORTED,
+						"%s", error2str(rsp->rc));
+		mcap_notify_error(mcl, gerr);
+		g_error_free(gerr);
+
+		g_free(mcl->lcmd);
+		mcl->lcmd = NULL;
+		mcl->ctrl &= ~MCAP_CTRL_STD_OP;
+		mcl->req = MCL_AVAILABLE;
+		update_mcl_state(mcl);
+		return FALSE;
+	}
+
+	if (rsp->rc == MCAP_UNSPECIFIED_ERROR)
+		goto close_mcl;
+
+	return TRUE;
+close_mcl:
+	if (rsp->rc == MCAP_UNSPECIFIED_ERROR)
+		g_set_error(&gerr, MCAP_ERROR, MCAP_ERROR_UNSPECIFIED_ERROR,
+						"%s", error2str(rsp->rc));
+	else
+		g_set_error(&gerr, MCAP_ERROR, MCAP_ERROR_FAILED,
+						"Protocol error");
+	mcap_notify_error(mcl, gerr);
+	g_error_free(gerr);
+	mcl->ms->mcl_disconnected_cb(mcl, mcl->ms->user_data);
+	mcap_cache_mcl(mcl);
+	return FALSE;
+}
+
 static void proc_response(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 {
-	/* TODO: Process response */
+	gboolean close;
+	RELEASE_TIMER(mcl);
+
+	if (!check_rsp(mcl, cmd, len))
+		return;
+
+	switch (cmd[0]) {
+	case MCAP_ERROR_RSP:
+		error("MCAP_ERROR_RSP received");
+		close = TRUE;
+		break;
+	case MCAP_MD_CREATE_MDL_RSP:
+		/* close = process_md_create_mdl_rsp(mcl, cmd, len); */
+		break;
+	case MCAP_MD_RECONNECT_MDL_RSP:
+		/* close = process_md_reconnect_mdl_rsp(mcl, cmd, len); */
+		break;
+	case MCAP_MD_ABORT_MDL_RSP:
+		/* close = process_md_abort_mdl_rsp(mcl, cmd, len); */
+		break;
+	case MCAP_MD_DELETE_MDL_RSP:
+		/* close = process_md_delete_mdl_rsp(mcl, cmd, len); */
+		break;
+	default:
+		debug("Unknown cmd response received (op code = %d)",cmd[0]);
+		close = TRUE;
+		break;
+	}
+
+	if (close) {
+		mcl->ms->mcl_disconnected_cb(mcl, mcl->ms->user_data);
+		mcap_cache_mcl(mcl);
+	}
 }
 
 static void rsend_req(struct mcap_mcl *mcl)
-- 
1.6.3.3

