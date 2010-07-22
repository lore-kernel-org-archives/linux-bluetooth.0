Return-Path: <cyrus@holtmann.org>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Subject: [PATCH 42/60] Move assignment of data channel configuration
Date: Thu, 22 Jul 2010 10:56:35 +0200
Message-Id: <1279789001-4587-24-git-send-email-santoscadenas@gmail.com>
In-Reply-To: <1279789001-4587-23-git-send-email-santoscadenas@gmail.com>
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
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mcap/mcap.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 1d33452..ff6766d 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -955,8 +955,6 @@ static void process_md_create_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 		return;
 	}
 
-	cfga = conf = req->conf;
-
 	mdl = get_mdl(mcl, mdl_id);
 	if (mdl && mdl->state == MDL_WAITING) {
 		/* A remote petition is also triying to connect this mdl_id
@@ -964,7 +962,9 @@ static void process_md_create_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 		send4B_cmd(mcl, MCAP_MD_CREATE_MDL_RSP, MCAP_MDL_BUSY, mdl_id);
 		return;
 	}
+
 	/* Callback to upper layer */
+	cfga = conf = req->conf;
 	rsp = mcl->cb->mdl_conn_req(mcl, mdep_id, mdl_id, &conf,
 							mcl->cb->user_data);
 	if (mcl->state == MCL_IDLE) {
@@ -985,7 +985,6 @@ static void process_md_create_mdl_req(struct mcap_mcl *mcl, uint8_t *cmd,
 		return;
 	}
 
-
 	if (!mdl) {
 		mdl = g_malloc0(sizeof(struct mcap_mdl));
 		mdl->mcl = mcl;
-- 
1.6.3.3

