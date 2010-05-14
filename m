Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 11/25] Process commands in ACTIVE state
Date: Fri, 14 May 2010 12:19:38 +0200
Message-Id: <1273832392-18654-11-git-send-email-sancane@gmail.com>
In-Reply-To: <1273832392-18654-10-git-send-email-sancane@gmail.com>
References: <1273832392-18654-1-git-send-email-sancane@gmail.com>
 <1273832392-18654-2-git-send-email-sancane@gmail.com>
 <1273832392-18654-3-git-send-email-sancane@gmail.com>
 <1273832392-18654-4-git-send-email-sancane@gmail.com>
 <1273832392-18654-5-git-send-email-sancane@gmail.com>
 <1273832392-18654-6-git-send-email-sancane@gmail.com>
 <1273832392-18654-7-git-send-email-sancane@gmail.com>
 <1273832392-18654-8-git-send-email-sancane@gmail.com>
 <1273832392-18654-9-git-send-email-sancane@gmail.com>
 <1273832392-18654-10-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mcap/mcap.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index ac0d938..dfa455f 100644
--- a/mcap/mcap.c
+++ b/mcap/mcap.c
@@ -680,7 +680,19 @@ static void proc_req_pending(struct mcap_mcl *mcl, uint8_t *cmd, uint32_t len)
 
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

