Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 19/25] Process response to std. op. codes
Date: Fri, 14 May 2010 12:19:46 +0200
Message-Id: <1273832392-18654-19-git-send-email-sancane@gmail.com>
In-Reply-To: <1273832392-18654-18-git-send-email-sancane@gmail.com>
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
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mcap/mcap.c |  140 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 139 insertions(+), 1 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index b0cf651..efc512a 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -1171,9 +1171,112 @@ static void proc_req_active(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 	}
 }
 
+static gboolean process_md_create_mdl_rsp(struct mcap_mcl *mcl,
+						uint8_t *cmd, uint32_t len)
+{
+	return FALSE;
+}
+
+static gboolean process_md_reconnect_mdl_rsp(struct mcap_mcl *mcl,
+						uint8_t *cmd, uint32_t len)
+{
+	return FALSE;
+}
+
+static gboolean process_md_abort_mdl_rsp(struct mcap_mcl *mcl,
+						uint8_t *cmd, uint32_t len)
+{
+	return FALSE;
+}
+
+static gboolean process_md_delete_mdl_rsp(struct mcap_mcl *mcl, uint8_t *cmd,
+								uint32_t len)
+{
+	return FALSE;
+}
+
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
-	/* TODO */
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
+		close = process_md_create_mdl_rsp(mcl, cmd, len);
+		break;
+	case MCAP_MD_RECONNECT_MDL_RSP:
+		close = process_md_reconnect_mdl_rsp(mcl, cmd, len);
+		break;
+	case MCAP_MD_ABORT_MDL_RSP:
+		close = process_md_abort_mdl_rsp(mcl, cmd, len);
+		break;
+	case MCAP_MD_DELETE_MDL_RSP:
+		close = process_md_delete_mdl_rsp(mcl, cmd, len);
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
@@ -1632,3 +1735,38 @@ void mcap_release_instance(struct mcap_instance *ms)
 	g_free(ms);
 }
 
+uint16_t mcap_get_ctrl_psm(struct mcap_instance *ms, GError **err)
+{
+	uint16_t lpsm;
+
+	if (!(ms && ms->ccio)) {
+		g_set_error(err, MCAP_ERROR, MCAP_ERROR_INVALID_ARGS,
+			"Invalid MCAP instance");
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
+uint16_t mcap_get_data_psm(struct mcap_instance *ms, GError **err)
+{
+	uint16_t lpsm;
+
+	if (!(ms && ms->dcio)) {
+		g_set_error(err, MCAP_ERROR, MCAP_ERROR_INVALID_ARGS,
+			"Invalid MCAP instance");
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

