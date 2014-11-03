Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/3] emulator/bthost: Simplify bthost_create
Date: Mon,  3 Nov 2014 17:20:54 +0100
Message-Id: <1415031656-3360-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use new0 instead of malloc+memset for allocating bthost.
---
 emulator/bthost.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index a2c72a9..a123228 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -219,12 +219,10 @@ struct bthost *bthost_create(void)
 {
 	struct bthost *bthost;
 
-	bthost = malloc(sizeof(*bthost));
+	bthost = new0(struct bthost, 1);
 	if (!bthost)
 		return NULL;
 
-	memset(bthost, 0, sizeof(*bthost));
-
 	/* Set defaults */
 	bthost->io_capability = 0x03;
 
-- 
1.9.1

