Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] Remove unused variable in mgmtops plugin
Date: Tue, 29 Mar 2011 11:42:02 -0300
Message-Id: <1301409722-16198-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/mgmtops.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 65b32e6..3f96017 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -1410,7 +1410,6 @@ static void mgmt_cleanup(void)
 {
 	g_free(controllers);
 	controllers = NULL;
-	max_index = -1;
 
 	if (mgmt_sock >= 0) {
 		close(mgmt_sock);
-- 
1.7.4.1

