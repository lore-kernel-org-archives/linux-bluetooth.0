Return-Path: <cyrus@holtmann.org>
From: luiz.dentz@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Fix uninitialized variable warning
Date: Tue, 29 Mar 2011 14:36:54 +0300
Message-Id: <1301398615-16283-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1301398615-16283-1-git-send-email-luiz.dentz@gmail.com>
References: <1301398615-16283-1-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

health/mcap.c: In function ‘proc_req_pending’:
health/mcap.c:1119:25: error: ‘abrt’ may be used uninitialized in this function
make[1]: *** [health/mcap.o] Error 1
---
 health/mcap.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/health/mcap.c b/health/mcap.c
index 81fd8df..a36f2c0 100644
--- a/health/mcap.c
+++ b/health/mcap.c
@@ -1116,7 +1116,7 @@ static void process_md_abort_mdl_req(struct mcap_mcl *mcl, void *cmd,
 {
 	mcap_md_req *req;
 	GSList *l;
-	struct mcap_mdl *mdl, *abrt;
+	struct mcap_mdl *mdl, *abrt = NULL;
 	uint16_t mdl_id;
 
 	if (!check_cmd_req_length(mcl, cmd, len, sizeof(mcap_md_req),
-- 
1.7.4.1

