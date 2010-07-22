Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jos=C3=A9=20Antonio=20Santos-Cadenas?=
	<santoscadenas@gmail.com>
Subject: [PATCH 32/60] Fix MCL transitions when responses are not success
Date: Thu, 22 Jul 2010 10:56:25 +0200
Message-Id: <1279789001-4587-14-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1279789001-4587-13-git-send-email-santoscadenas@gmail.com>
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
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: José Antonio Santos-Cadenas <santoscadenas@gmail.com>

---
 mcap/mcap.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index d20b3d5..73abb90 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -1315,6 +1315,7 @@ static gboolean process_md_reconnect_mdl_rsp(struct mcap_mcl *mcl,
 
 	g_error_free(gerr);
 	shutdown_mdl(mdl);
+	update_mcl_state(mcl);
 
 	if (rsp->rc != MCAP_INVALID_MDL)
 		return close;
@@ -1323,7 +1324,6 @@ static gboolean process_md_reconnect_mdl_rsp(struct mcap_mcl *mcl,
 	mcl->mdls = g_slist_remove(mcl->mdls, mdl);
 	mcl->cb->mdl_deleted(mdl, mcl->cb->user_data);
 	g_free(mdl);
-	update_mcl_state(mcl);
 
 	return close;
 }
@@ -1335,6 +1335,7 @@ static gboolean process_md_abort_mdl_rsp(struct mcap_mcl *mcl,
 	mcap_mdl_del_cb abrt_cb = abrt->cb.del;
 	gpointer user_data = abrt->user_data;
 	struct mcap_mdl *mdl = abrt->mdl;
+	mcap4B_rsp *rsp = (mcap4B_rsp *)cmd;
 	GError *gerr = NULL;
 	gboolean close = FALSE;
 
@@ -1347,16 +1348,17 @@ static gboolean process_md_abort_mdl_rsp(struct mcap_mcl *mcl,
 	mcl->lcmd = NULL;
 	mcl->req = MCL_AVAILABLE;
 
-	if (gerr) {
-		abrt_cb(gerr, user_data);
-		g_error_free(gerr);
-		return close;
+	abrt_cb(gerr, user_data);
+
+	if ((len >= 4) && (rsp->rc == MCAP_INVALID_MDL)) {
+		mcl->mdls = g_slist_remove(mcl->mdls, mdl);
+		g_free(mdl);
 	}
 
-	mcl->mdls = g_slist_remove(mcl->mdls, mdl);
-	g_free(mdl);
+	if (!gerr)
+		g_error_free(gerr);
+
 	update_mcl_state(mcl);
-	abrt_cb(gerr, user_data);
 	return close;
 }
 
-- 
1.6.3.3

