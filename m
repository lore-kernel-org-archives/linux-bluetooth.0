Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 52/60] Avoid double insertion of the same MDL in an MCL
Date: Thu, 22 Jul 2010 10:58:09 +0200
Message-Id: <1279789097-2420-4-git-send-email-sancane@gmail.com>
In-Reply-To: <1279789097-2420-3-git-send-email-sancane@gmail.com>
References: <1279789001-4587-30-git-send-email-santoscadenas@gmail.com>
 <1279789097-2420-1-git-send-email-sancane@gmail.com>
 <1279789097-2420-2-git-send-email-sancane@gmail.com>
 <1279789097-2420-3-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We don't have to insert an MDL in the list when we receive a
request to create a new data channel using a mdlid that it is
already created.
---
 mcap/mcap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 1e55bc7..30e0827 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -1033,6 +1033,7 @@ static void process_md_create_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 		mdl = g_malloc0(sizeof(struct mcap_mdl));
 		mdl->mcl = mcl;
 		mdl->mdlid = mdl_id;
+		mcl->mdls = g_slist_insert_sorted(mcl->mdls, mdl, compare_mdl);
 	} else if (mdl->state == MDL_CONNECTED) {
 		/* MCAP specification says that we should close the MCL if
 		 * it is open when we receive a MD_CREATE_MDL_REQ */
@@ -1041,7 +1042,6 @@ static void process_md_create_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 
 	mdl->mdep_id = mdep_id;
 	mdl->state = MDL_WAITING;
-	mcl->mdls = g_slist_insert_sorted(mcl->mdls, mdl, compare_mdl);
 
 	mcl->state = MCL_PENDING;
 	send5B_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, MCAP_SUCCESS, mdl_id, conf);
-- 
1.6.3.3

