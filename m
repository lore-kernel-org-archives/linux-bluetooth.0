Return-Path: <cyrus@holtmann.org>
From: luiz.dentz@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3 v2] Fix uninitialized variable warning
Date: Tue, 29 Mar 2011 16:47:43 +0300
Message-Id: <1301406464-3404-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

health/mcap.c: In function ‘proc_req_pending’:
health/mcap.c:1119:25: error: ‘abrt’ may be used uninitialized in this function
make[1]: *** [health/mcap.o] Error 1
---
 health/mcap.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/health/mcap.c b/health/mcap.c
index 81fd8df..48866d4 100644
--- a/health/mcap.c
+++ b/health/mcap.c
@@ -1126,6 +1126,7 @@ static void process_md_abort_mdl_req(struct mcap_mcl *mcl, void *cmd,
 	req = cmd;
 	mdl_id = ntohs(req->mdl);
 	mcl->state = MCL_CONNECTED;
+	abrt = NULL;
 	for (l = mcl->mdls; l; l = l->next) {
 		mdl = l->data;
 		if (mdl_id == mdl->mdlid && mdl->state == MDL_WAITING) {
-- 
1.7.4.1

