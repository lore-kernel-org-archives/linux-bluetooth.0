Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ] core: Remove leftover from pending_uuids removal
Date: Fri,  4 Jan 2013 22:15:34 -0400
Message-Id: <1357352134-19573-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The struct controller_info "pending_uuids" field was removed on commit
1dd77eda25aae5ed963683dfc125d3ef01187eba.
---
 src/mgmt.c |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/src/mgmt.c b/src/mgmt.c
index c280fe3..b5ce955 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -1633,15 +1633,6 @@ fail:
 
 void mgmt_cleanup(void)
 {
-	int index;
-
-	for (index = 0; index <= max_index; index++) {
-		struct controller_info *info = &controllers[index];
-
-		if (!info->valid)
-			continue;
-	}
-
 	g_free(controllers);
 	controllers = NULL;
 	max_index = -1;
-- 
1.7.9.5

