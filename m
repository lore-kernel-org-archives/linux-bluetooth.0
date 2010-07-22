Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 11/60] Process commands in ACTIVE state
Date: Thu, 22 Jul 2010 10:52:06 +0200
Message-Id: <1279788733-2324-12-git-send-email-sancane@gmail.com>
In-Reply-To: <1279788733-2324-11-git-send-email-sancane@gmail.com>
References: <1279788733-2324-1-git-send-email-sancane@gmail.com>
 <1279788733-2324-2-git-send-email-sancane@gmail.com>
 <1279788733-2324-3-git-send-email-sancane@gmail.com>
 <1279788733-2324-4-git-send-email-sancane@gmail.com>
 <1279788733-2324-5-git-send-email-sancane@gmail.com>
 <1279788733-2324-6-git-send-email-sancane@gmail.com>
 <1279788733-2324-7-git-send-email-sancane@gmail.com>
 <1279788733-2324-8-git-send-email-sancane@gmail.com>
 <1279788733-2324-9-git-send-email-sancane@gmail.com>
 <1279788733-2324-10-git-send-email-sancane@gmail.com>
 <1279788733-2324-11-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mcap/mcap.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index 9f41c6b..cf44472 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -679,7 +679,19 @@ static void proc_req_pending(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 
 static void proc_req_active(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 {
-	/* TODO */
+	switch (cmd[0]) {
+	case MCAP_MD_CREATE_MDL_REQ:
+		process_md_create_mdl_req(mcl, cmd, len);
+		break;
+	case MCAP_MD_RECONNECT_MDL_REQ:
+		process_md_reconnect_mdl_req(mcl, cmd, len);
+		break;
+	case MCAP_MD_DELETE_MDL_REQ:
+		process_md_delete_mdl_req(mcl, cmd, len);
+		break;
+	default:
+		error_cmd_rsp(mcl, cmd, len);
+	}
 }
 
 static void proc_response(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
-- 
1.6.3.3

