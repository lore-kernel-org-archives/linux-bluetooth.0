Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jos=C3=A9=20Antonio=20Santos-Cadenas?=
	<santoscadenas@gmail.com>
Subject: [PATCH 19/60] Process response to std. op. codes
Date: Thu, 22 Jul 2010 10:56:12 +0200
Message-Id: <1279789001-4587-1-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1279788733-2324-19-git-send-email-sancane@gmail.com>
References: <1279788733-2324-19-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: José Antonio Santos-Cadenas <santoscadenas@gmail.com>

---
 mcap/mcap.c |  141 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 140 insertions(+), 1 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 6f6e08a..c775501 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -1170,9 +1170,112 @@ static void proc_req_active(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
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
+		DBG("Remote does not support opcodes");
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
+		DBG("Unknown cmd response received (op code = %d)",cmd[0]);
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
@@ -1631,3 +1734,39 @@ void mcap_release_instance(struct mcap_instance *ms)
 
 	g_free(ms);
 }
+
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

