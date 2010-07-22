Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jos=C3=A9=20Antonio=20Santos-Cadenas?=
	<santoscadenas@gmail.com>
Subject: [PATCH 38/60] Don't delete aborted MDLS
Date: Thu, 22 Jul 2010 10:56:31 +0200
Message-Id: <1279789001-4587-20-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1279789001-4587-19-git-send-email-santoscadenas@gmail.com>
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
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: José Antonio Santos-Cadenas <santoscadenas@gmail.com>

When a request for abort MDL creation fails we shouldn't delete the
MDL because it may be used for future reconnections.
---
 mcap/mcap.c |   14 ++++++--------
 1 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 87aa233..d268bf6 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -1042,7 +1042,7 @@ static void process_md_abort_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 {
 	mcap_md_req *req;
 	GSList *l;
-	struct mcap_mdl *mdl, *del;
+	struct mcap_mdl *mdl, *abrt;
 	uint16_t mdl_id;
 
 	if (len != sizeof(mcap_md_req)) {
@@ -1057,7 +1057,7 @@ static void process_md_abort_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 	for (l = mcl->mdls; l; l = l->next) {
 		mdl = l->data;
 		if ((mdl_id == mdl->mdlid) && (mdl->state == MDL_WAITING)) {
-			del = mdl;
+			abrt = mdl;
 			if (mcl->state != MCL_CONNECTED)
 				break;
 			continue;
@@ -1065,20 +1065,18 @@ static void process_md_abort_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 		if ((mdl->state == MDL_CONNECTED) && (mcl->state != MCL_ACTIVE))
 			mcl->state = MCL_ACTIVE;
 
-		if ((del) && (mcl->state == MCL_ACTIVE))
+		if ((abrt) && (mcl->state == MCL_ACTIVE))
 			break;
 	}
 
-	if (!del) {
+	if (!abrt) {
 		send4B_cmd(mcl, MCAP_MD_ABORT_MDL_RSP, MCAP_INVALID_MDL,
 									mdl_id);
 		return;
 	}
 
-	mcl->cb->mdl_aborted(del, mcl->cb->user_data);
-
-	mcl->mdls = g_slist_remove(mcl->mdls, del);
-	g_free(del);
+	mcl->cb->mdl_aborted(abrt, mcl->cb->user_data);
+	abrt->state = MDL_CLOSED;
 	send4B_cmd(mcl, MCAP_MD_ABORT_MDL_RSP, MCAP_SUCCESS, mdl_id);
 }
 
-- 
1.6.3.3

