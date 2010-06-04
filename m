Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 11/26] Process commands in ACTIVE state
Date: Fri,  4 Jun 2010 10:27:04 +0200
Message-Id: <1275640039-7245-12-git-send-email-sancane@gmail.com>
In-Reply-To: <1275640039-7245-11-git-send-email-sancane@gmail.com>
References: <1275640039-7245-1-git-send-email-sancane@gmail.com>
 <1275640039-7245-2-git-send-email-sancane@gmail.com>
 <1275640039-7245-3-git-send-email-sancane@gmail.com>
 <1275640039-7245-4-git-send-email-sancane@gmail.com>
 <1275640039-7245-5-git-send-email-sancane@gmail.com>
 <1275640039-7245-6-git-send-email-sancane@gmail.com>
 <1275640039-7245-7-git-send-email-sancane@gmail.com>
 <1275640039-7245-8-git-send-email-sancane@gmail.com>
 <1275640039-7245-9-git-send-email-sancane@gmail.com>
 <1275640039-7245-10-git-send-email-sancane@gmail.com>
 <1275640039-7245-11-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 mcap/mcap.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/mcap/mcap.c b/mcap/mcap.c
index ddd888e..0ad7847 100644
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

