Return-Path: <cyrus@holtmann.org>
From: Jaganath Kanakkassery <jaganath.k@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganath.k@samsung.com>
Subject: [PATCH obexd 3/4] irmc: Fix length parameter of strncpy
Date: Thu, 02 Feb 2012 17:04:01 +0530
Message-id: <1328182441-14892-1-git-send-email-jaganath.k@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/irmc.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/plugins/irmc.c b/plugins/irmc.c
index 6f28e51..8344a47 100644
--- a/plugins/irmc.c
+++ b/plugins/irmc.c
@@ -215,9 +215,9 @@ static void *irmc_connect(struct obex_session *os, int *err)
 	 * For now lets used hostname and some 'random' value
 	 */
 	gethostname(irmc->did, DID_LEN);
-	strncpy(irmc->sn, "12345", DID_LEN);
-	strncpy(irmc->manu, "obex", DID_LEN);
-	strncpy(irmc->model, "mymodel", DID_LEN);
+	strncpy(irmc->sn, "12345", sizeof(irmc->sn) - 1);
+	strncpy(irmc->manu, "obex", sizeof(irmc->manu) - 1);
+	strncpy(irmc->model, "mymodel", sizeof(irmc->model) - 1);
 
 	/* We need to know the number of contact/cal/nt entries
 	 * somewhere so why not do it now.
-- 
1.7.1

