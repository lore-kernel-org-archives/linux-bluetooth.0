Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jos=C3=A9=20Antonio=20Santos-Cadenas?=
	<santoscadenas@gmail.com>
Subject: [PATCH 40/60] Fix memory leak when double deletion happens and response code isn't SUCCESS
Date: Thu, 22 Jul 2010 10:56:33 +0200
Message-Id: <1279789001-4587-22-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1279789001-4587-21-git-send-email-santoscadenas@gmail.com>
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
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: José Antonio Santos-Cadenas <santoscadenas@gmail.com>

---
 mcap/mcap.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 51f0d87..64e76b5 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -1132,7 +1132,7 @@ static void process_md_delete_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 	notify = TRUE;
 	if (mdl->state == MDL_DELETING) {
 		/* Remote deviced requests deleting an MDL that upper profile
-		 * tries to delete, MDL will be freed when reply arrives. */
+		 * is trying to delete, MDL will be freed when reply arrives. */
 		mdl->mcl->cb->mdl_deleted(mdl, mdl->mcl->cb->user_data);
 	} else
 		mcap_delete_mdl(mdl, &notify);
@@ -1410,9 +1410,14 @@ static gboolean process_md_delete_mdl_rsp(struct mcap_mcl *mcl, uint8_t *cmd,
 						(rsp->rc == MCAP_INVALID_MDL)) {
 			/* Mdl does not exist in remote side */
 			goto del_mdl;
-		} else {
+		} else if (g_slist_find(mdl->mcl->mdls, mdl)){
 			/* this mdl couldn't be deleted */
 			restore_mdl(mdl, NULL);
+		} else {
+			/* MDL deleted request was sent by remote side while an
+			 * outgoing request for delete it was pending */
+			shutdown_mdl(mdl);
+			g_free(mdl);
 		}
 		goto end;
 	}
-- 
1.6.3.3

