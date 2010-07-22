Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jos=C3=A9=20Antonio=20Santos-Cadenas?=
	<santoscadenas@gmail.com>
Subject: [PATCH 39/60] Fix double memory free on simultaneus deletion of MDLs
Date: Thu, 22 Jul 2010 10:56:32 +0200
Message-Id: <1279789001-4587-21-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1279789001-4587-20-git-send-email-santoscadenas@gmail.com>
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
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: José Antonio Santos-Cadenas <santoscadenas@gmail.com>

---
 mcap/mcap.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index d268bf6..51f0d87 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -1130,7 +1130,12 @@ static void process_md_delete_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 	mcl->mdls = g_slist_remove(mcl->mdls, mdl);
 	update_mcl_state(mcl);
 	notify = TRUE;
-	mcap_delete_mdl(mdl, &notify);
+	if (mdl->state == MDL_DELETING) {
+		/* Remote deviced requests deleting an MDL that upper profile
+		 * tries to delete, MDL will be freed when reply arrives. */
+		mdl->mcl->cb->mdl_deleted(mdl, mdl->mcl->cb->user_data);
+	} else
+		mcap_delete_mdl(mdl, &notify);
 resp:
 	send4B_cmd(mcl, MCAP_MD_DELETE_MDL_RSP, MCAP_SUCCESS, mdlid);
 }
-- 
1.6.3.3

