Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jos=C3=A9=20Antonio=20Santos-Cadenas?=
	<santoscadenas@gmail.com>
Subject: [PATCH 48/60] Notify MCL closed when there is a pending callback
Date: Thu, 22 Jul 2010 10:56:41 +0200
Message-Id: <1279789001-4587-30-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1279789001-4587-29-git-send-email-santoscadenas@gmail.com>
References: <1279788733-2324-19-git-send-email-sancane@gmail.com>
 <1279789001-4587-1-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-2-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-3-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-4-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-5-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-6-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-7-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-8-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-9-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-10-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-11-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-12-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-13-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-14-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-15-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-16-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-17-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-18-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-19-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-20-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-21-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-22-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-23-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-24-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-25-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-26-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-27-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-28-git-send-email-santoscadenas@gmail.com>
 <1279789001-4587-29-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: José Antonio Santos-Cadenas <santoscadenas@gmail.com>

---
 mcap/mcap.c     |   11 ++++++++++-
 mcap/mcap_lib.h |    1 +
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index f164e76..434d50f 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -1643,6 +1643,7 @@ void mcap_mdl_connect(struct mcap_mdl *mdl, BtIOType BtType, uint16_t dcpsm,
 static gboolean mcl_control_cb(GIOChannel *chan, GIOCondition cond,
 								gpointer data)
 {
+	GError *gerr = NULL;
 
 	struct mcap_mcl *mcl = data;
 	int sk, len;
@@ -1659,8 +1660,16 @@ static gboolean mcl_control_cb(GIOChannel *chan, GIOCondition cond,
 	proc_cmd(mcl, buf, (uint32_t)len);
 	return TRUE;
 fail:
-	if (mcl->state != MCL_IDLE)
+	if (mcl->state != MCL_IDLE) {
+		if (mcl->req == MCL_WAITING_RSP) {
+			/* notify error in pending callback */
+			g_set_error(&gerr, MCAP_ERROR, MCAP_ERROR_MCL_CLOSED,
+								"MCL closed");
+			mcap_notify_error(mcl, gerr, TRUE);
+			g_error_free(gerr);
+		}
 		mcl->ms->mcl_disconnected_cb(mcl, mcl->ms->user_data);
+	}
 	mcap_cache_mcl(mcl);
 	return FALSE;
 }
diff --git a/mcap/mcap_lib.h b/mcap/mcap_lib.h
index 67c2f29..afac8aa 100644
--- a/mcap/mcap_lib.h
+++ b/mcap/mcap_lib.h
@@ -52,6 +52,7 @@ typedef enum {
 	MCAP_ERROR_INVALID_ARGS,
 	MCAP_ERROR_ALREADY_EXISTS,
 	MCAP_ERROR_REQ_IGNORED,
+	MCAP_ERROR_MCL_CLOSED,
 	MCAP_ERROR_FAILED
 } McapError;
 
-- 
1.6.3.3

