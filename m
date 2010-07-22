Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jos=C3=A9=20Antonio=20Santos-Cadenas?=
	<santoscadenas@gmail.com>
Subject: [PATCH 37/60] Remove MDL when delete operation fails with INVALID_MDL response code
Date: Thu, 22 Jul 2010 10:56:30 +0200
Message-Id: <1279789001-4587-19-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1279789001-4587-18-git-send-email-santoscadenas@gmail.com>
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
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: José Antonio Santos-Cadenas <santoscadenas@gmail.com>

---
 mcap/mcap.c |   23 ++++++++++++++++-------
 1 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 63058d1..87aa233 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -1385,6 +1385,7 @@ static gboolean process_md_delete_mdl_rsp(struct mcap_mcl *mcl, uint8_t *cmd,
 	gpointer user_data = del->user_data;
 	mcap_md_req *cmdlast = (mcap_md_req *) mcl->lcmd;
 	uint16_t mdlid = ntohs(cmdlast->mdl);
+	mcap4B_rsp *rsp = (mcap4B_rsp *)cmd;
 	GError *gerr = NULL;
 	gboolean close = FALSE;
 	gboolean notify = FALSE;
@@ -1397,14 +1398,20 @@ static gboolean process_md_delete_mdl_rsp(struct mcap_mcl *mcl, uint8_t *cmd,
 	g_free(mcl->lcmd);
 	mcl->lcmd = NULL;
 	mcl->req = MCL_AVAILABLE;
+
 	if (gerr) {
-		if (mdl)
-			restore_mdl(mdl, NULL);
-		else
+		if (!mdl) {
+			/* Deletion of all mdls failed */
 			g_slist_foreach(mcl->mdls, restore_mdl, NULL);
-		deleted_cb(gerr, user_data);
-		g_error_free(gerr);
-		return close;
+		} else if ((len >= MIN_RSP_LEN) &&
+						(rsp->rc == MCAP_INVALID_MDL)) {
+			/* Mdl does not exist in remote side */
+			goto del_mdl;
+		} else {
+			/* this mdl couldn't be deleted */
+			restore_mdl(mdl, NULL);
+		}
+		goto end;
 	}
 
 	if (mdlid == MCAP_ALL_MDLIDS) {
@@ -1414,12 +1421,14 @@ static gboolean process_md_delete_mdl_rsp(struct mcap_mcl *mcl, uint8_t *cmd,
 		mcl->state = MCL_CONNECTED;
 		goto end;
 	}
-
+del_mdl:
 	mcl->mdls = g_slist_remove(mcl->mdls, mdl);
 	update_mcl_state(mcl);
 	mcap_delete_mdl(mdl, &notify);
 end:
 	deleted_cb(gerr, user_data);
+	if (gerr)
+		g_error_free(gerr);
 	return close;
 }
 
-- 
1.6.3.3

